Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 585041A0851
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 04:00:21 +1100 (AEDT)
Date: Tue, 23 Feb 2016 18:00:17 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace
 location during build
Message-ID: <20160223170017.GB21932@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174517.8347D692C8@newverein.lst.de>
 <1455293609.16012.9.camel@gmail.com> <20160212164517.GO12548@pathway.suse.cz>
 <20160216054701.GA20570@linux.vnet.ibm.com> <20160216082302.GA20522@lst.de>
 <20160216103028.GA10730@linux.vnet.ibm.com> <20160216103907.GB25103@lst.de>
 <20160216135742.GT12548@pathway.suse.cz>
 <1455678521.2956.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455678521.2956.4.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2016 at 02:08:41PM +1100, Michael Ellerman wrote:
> 
> That stub uses r2 to find the location of itself, but it only works if r2 holds
> the TOC for scsi_mod.ko. In this case r2 still contains ibmvscsi.ko's TOC.

Here's my solution, a bit rough still. This replaces the module_64.c change
from patch 2/8:

I shuffle the trampoline instructions so the R2-save-to-stack comes first.
This allows me to construct a profiling trampoline code that
looks very similar. The first instruction, harmful to -mprofile-kernel
can now be replaced with a load of the *kernel* TOC value via paca.
Arithmetic is done in r11, to keep it bitwise identical where possible.
Likewise the result is "moved" to r12 via an addi.

What do you think?

	Torsten


--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -27,6 +27,7 @@
 #include <linux/bug.h>
 #include <linux/uaccess.h>
 #include <asm/module.h>
+#include <asm/asm-offsets.h>
 #include <asm/firmware.h>
 #include <asm/code-patching.h>
 #include <linux/sort.h>
@@ -123,10 +124,10 @@ struct ppc64_stub_entry
  */
 
 static u32 ppc64_stub_insns[] = {
-	0x3d620000,			/* addis   r11,r2, <high> */
-	0x396b0000,			/* addi    r11,r11, <low> */
 	/* Save current r2 value in magic place on the stack. */
 	0xf8410000|R2_STACK_OFFSET,	/* std     r2,R2_STACK_OFFSET(r1) */
+	0x3d620000,			/* addis   r11,r2, <high> */
+	0x396b0000,			/* addi    r11,r11, <low> */
 	0xe98b0020,			/* ld      r12,32(r11) */
 #if !defined(_CALL_ELF) || _CALL_ELF != 2
 	/* Set up new r2 from function descriptor */
@@ -136,13 +137,30 @@ static u32 ppc64_stub_insns[] = {
 	0x4e800420			/* bctr */
 };
 
+/* In case of _mcount calls or dynamic ftracing with -mprofile-kernel,
+ * the stack frame already holds the TOC value of the original
+ * caller. And even worse, for a leaf function without global data
+ * references, R2 holds the TOC of the caller's caller, e.g. is
+ * completely undefined. So: do not dare to write r2 anywhere, and use
+ * the kernel's TOC to find _mcount / ftrace_caller.  Mcount and
+ * ftrace_caller will then take care of the r2 value themselves.
+ */
+static u32 ppc64_profile_stub_insns[] = {
+	0xe98d0000|PACATOC,		/* ld	   r12,PACATOC(r13) */
+	0x3d6c0000,			/* addis   r11,r12, <high> */
+	0x396b0000,			/* addi    r11,r11, <low> */
+	0x398b0000,			/* addi    r12,r11,0 */
+	0x7d8903a6,			/* mtctr   r12 */
+	0x4e800420			/* bctr */
+};
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 static u32 ppc64_stub_mask[] = {
+	0xee330000,
+	0xfff10000,
 	0xffff0000,
-	0xffff0000,
-	0xffffffff,
-	0xffffffff,
+	0x2fffffdf,
 #if !defined(_CALL_ELF) || _CALL_ELF != 2
 	0xffffffff,
 #endif
@@ -168,10 +186,15 @@ bool is_module_trampoline(u32 *p)
 		if ((insna & mask) != (insnb & mask))
 			return false;
 	}
+	if (insns[0] != ppc64_stub_insns[0] &&
+	    insns[0] != ppc64_profile_stub_insns[0])
+		return false;
 
 	return true;
 }
 
+extern unsigned long __toc_start;
+
 int module_trampoline_target(struct module *mod, u32 *trampoline,
 			     unsigned long *target)
 {
@@ -180,7 +203,7 @@ int module_trampoline_target(struct modu
 	long offset;
 	void *toc_entry;
 
-	if (probe_kernel_read(buf, trampoline, sizeof(buf)))
+	if (probe_kernel_read(buf, trampoline+1, sizeof(buf)))
 		return -EFAULT;
 
 	upper = buf[0] & 0xffff;
@@ -189,6 +212,13 @@ int module_trampoline_target(struct modu
 	/* perform the addis/addi, both signed */
 	offset = ((short)upper << 16) + (short)lower;
 
+	/* profiling trampolines work differently */
+	if ((buf[0] & 0xFFFF0000) == 0x3D6C0000)
+	  {
+	    *target = offset + (unsigned long)(&__toc_start) + 0x8000UL;
+	    return 0;
+	  }
+
 	/*
 	 * Now get the address this trampoline jumps to. This
 	 * is always 32 bytes into our trampoline stub.
@@ -427,14 +457,24 @@ static inline unsigned long my_r2(Elf64_
 static inline int create_stub(Elf64_Shdr *sechdrs,
 			      struct ppc64_stub_entry *entry,
 			      unsigned long addr,
-			      struct module *me)
+			      struct module *me,
+			      bool prof)
 {
 	long reladdr;
 
-	memcpy(entry->jump, ppc64_stub_insns, sizeof(ppc64_stub_insns));
+	if (prof)
+	{
+		memcpy(entry->jump, ppc64_profile_stub_insns,
+		       sizeof(ppc64_stub_insns));
 
-	/* Stub uses address relative to r2. */
-	reladdr = (unsigned long)entry - my_r2(sechdrs, me);
+		/* Stub uses address relative to kernel TOC. */
+		reladdr = addr - ((unsigned long)(&__toc_start) + 0x8000UL);
+	} else {
+		memcpy(entry->jump, ppc64_stub_insns, sizeof(ppc64_stub_insns));
+
+		/* Stub uses address relative to r2. */
+		reladdr = (unsigned long)entry - my_r2(sechdrs, me);
+	}
 	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
 		pr_err("%s: Address %p of stub out of range of %p.\n",
 		       me->name, (void *)reladdr, (void *)my_r2);
@@ -442,8 +482,8 @@ static inline int create_stub(Elf64_Shdr
 	}
 	pr_debug("Stub %p get data from reladdr %li\n", entry, reladdr);
 
-	entry->jump[0] |= PPC_HA(reladdr);
-	entry->jump[1] |= PPC_LO(reladdr);
+	entry->jump[1] |= PPC_HA(reladdr);
+	entry->jump[2] |= PPC_LO(reladdr);
 	entry->funcdata = func_desc(addr);
 	return 1;
 }
@@ -452,7 +492,8 @@ static inline int create_stub(Elf64_Shdr
    stub to set up the TOC ptr (r2) for the function. */
 static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
 				   unsigned long addr,
-				   struct module *me)
+				   struct module *me,
+				   bool prof)
 {
 	struct ppc64_stub_entry *stubs;
 	unsigned int i, num_stubs;
@@ -468,44 +509,17 @@ static unsigned long stub_for_addr(Elf64
 			return (unsigned long)&stubs[i];
 	}
 
-	if (!create_stub(sechdrs, &stubs[i], addr, me))
+	if (!create_stub(sechdrs, &stubs[i], addr, me, prof))
 		return 0;
 
 	return (unsigned long)&stubs[i];
 }
 
-#ifdef CC_USING_MPROFILE_KERNEL
-static int is_early_mcount_callsite(u32 *instruction)
-{
-	/* -mprofile-kernel sequence starting with
-	 * mflr r0 and maybe std r0, LRSAVE(r1).
-	 */
-	if ((instruction[-3] == PPC_INST_MFLR &&
-	     instruction[-2] == PPC_INST_STD_LR) ||
-	    instruction[-2] == PPC_INST_MFLR) {
-		/* Nothing to be done here, it's an _mcount
-		 * call location and r2 will have to be
-		 * restored in the _mcount function.
-		 */
-		return 1;
-	}
-	return 0;
-}
-#else
-/* without -mprofile-kernel, mcount calls are never early */
-static int is_early_mcount_callsite(u32 *instruction)
-{
-	return 0;
-}
-#endif
-
 /* We expect a noop next: if it is, replace it with instruction to
    restore r2. */
 static int restore_r2(u32 *instruction, struct module *me)
 {
 	if (*instruction != PPC_INST_NOP) {
-		if (is_early_mcount_callsite(instruction))
-			return 1;
 		pr_err("%s: Expect noop after relocate, got %08x\n",
 		       me->name, *instruction);
 		return 0;
@@ -515,6 +529,12 @@ static int restore_r2(u32 *instruction,
 	return 1;
 }
 
+#ifdef CC_USING_MPROFILE_KERNEL
+#define IS_KERNEL_PROFILING_CALL (!strcmp("_mcount", strtab+sym->st_name))
+#else
+#define IS_KERNEL_PROFILING_CALL 0
+#endif
+
 int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       const char *strtab,
 		       unsigned int symindex,
@@ -630,11 +650,15 @@ int apply_relocate_add(Elf64_Shdr *sechd
 		case R_PPC_REL24:
 			/* FIXME: Handle weak symbols here --RR */
 			if (sym->st_shndx == SHN_UNDEF) {
+				bool prof = false;
+				if (IS_KERNEL_PROFILING_CALL)
+					prof = true;
 				/* External: go via stub */
-				value = stub_for_addr(sechdrs, value, me);
+				value = stub_for_addr(sechdrs, value, me, prof);
 				if (!value)
 					return -ENOENT;
-				if (!restore_r2((u32 *)location + 1, me))
+				if (!prof &&
+				    !restore_r2((u32 *)location + 1, me))
 					return -ENOEXEC;
 			} else
 				value += local_entry_offset(sym);
@@ -722,7 +746,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 	me->arch.toc = my_r2(sechdrs, me);
 	me->arch.tramp = stub_for_addr(sechdrs,
 				       (unsigned long)ftrace_caller,
-				       me);
+				       me, true);
 #endif
 
 	return 0;
