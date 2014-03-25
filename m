Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 32/33] powerpc: modules: implement stubs for ELFv2 ABI.
Date: Tue, 25 Mar 2014 22:44:38 +1100
Message-Id: <1395747879-5948-33-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rusty Russell <rusty@rustcorp.com.au>

ELFv2 doesn't use function descriptors, because it doesn't need to
load a new r2 when calling into a function.  On the other hand, you're
supposed to use a local entry point for R_PPC_REL24 branches.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/kernel/module_64.c | 73 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index d722249..0423601 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -43,8 +43,58 @@
 
 #if defined(_CALL_ELF) && _CALL_ELF == 2
 #define R2_STACK_OFFSET 24
+
+/* An address is simply the address of the function. */
+typedef unsigned long func_desc_t;
+
+static func_desc_t func_desc(unsigned long addr)
+{
+	return addr;
+}
+static unsigned long func_addr(unsigned long addr)
+{
+	return addr;
+}
+static unsigned long stub_func_addr(func_desc_t func)
+{
+	return func;
+}
+
+/* PowerPC64 specific values for the Elf64_Sym st_other field.  */
+#define STO_PPC64_LOCAL_BIT	5
+#define STO_PPC64_LOCAL_MASK	(7 << STO_PPC64_LOCAL_BIT)
+#define PPC64_LOCAL_ENTRY_OFFSET(other)					\
+ (((1 << (((other) & STO_PPC64_LOCAL_MASK) >> STO_PPC64_LOCAL_BIT)) >> 2) << 2)
+
+static unsigned int local_entry_offset(const Elf64_Sym *sym)
+{
+	/* sym->st_other indicates offset to local entry point
+	 * (otherwise it will assume r12 is the address of the start
+	 * of function and try to derive r2 from it). */
+	return PPC64_LOCAL_ENTRY_OFFSET(sym->st_other);
+}
 #else
 #define R2_STACK_OFFSET 40
+
+/* An address is address of the OPD entry, which contains address of fn. */
+typedef struct ppc64_opd_entry func_desc_t;
+
+static func_desc_t func_desc(unsigned long addr)
+{
+	return *(struct ppc64_opd_entry *)addr;
+}
+static unsigned long func_addr(unsigned long addr)
+{
+	return func_desc(addr).funcaddr;
+}
+static unsigned long stub_func_addr(func_desc_t func)
+{
+	return func.funcaddr;
+}
+static unsigned int local_entry_offset(const Elf64_Sym *sym)
+{
+	return 0;
+}
 #endif
 
 /* Like PPC32, we need little trampolines to do > 24-bit jumps (into
@@ -56,7 +106,7 @@ struct ppc64_stub_entry
 	u32 jump[7];
 	u32 unused;
 	/* Data for the above code */
-	struct ppc64_opd_entry opd;
+	func_desc_t funcdata;
 };
 
 /*
@@ -225,7 +275,7 @@ static Elf64_Sym *find_dot_toc(Elf64_Shdr *sechdrs,
 
 	for (i = 1; i < numsyms; i++) {
 		if (syms[i].st_shndx == SHN_UNDEF
-		    && strcmp(strtab + syms[i].st_name, ".TOC.") == 0)
+		    && strcmp(strtab + syms[i].st_name, "TOC.") == 0)
 			return &syms[i];
 	}
 	return NULL;
@@ -295,7 +345,7 @@ static inline unsigned long my_r2(Elf64_Shdr *sechdrs, struct module *me)
 /* Patch stub to reference function and correct r2 value. */
 static inline int create_stub(Elf64_Shdr *sechdrs,
 			      struct ppc64_stub_entry *entry,
-			      struct ppc64_opd_entry *opd,
+			      unsigned long addr,
 			      struct module *me)
 {
 	long reladdr;
@@ -313,33 +363,31 @@ static inline int create_stub(Elf64_Shdr *sechdrs,
 
 	entry->jump[0] |= PPC_HA(reladdr);
 	entry->jump[1] |= PPC_LO(reladdr);
-	entry->opd.funcaddr = opd->funcaddr;
-	entry->opd.r2 = opd->r2;
+	entry->funcdata = func_desc(addr);
 	return 1;
 }
 
-/* Create stub to jump to function described in this OPD: we need the
+/* Create stub to jump to function described in this OPD/ptr: we need the
    stub to set up the TOC ptr (r2) for the function. */
 static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
-				   unsigned long opdaddr,
+				   unsigned long addr,
 				   struct module *me)
 {
 	struct ppc64_stub_entry *stubs;
-	struct ppc64_opd_entry *opd = (void *)opdaddr;
 	unsigned int i, num_stubs;
 
 	num_stubs = sechdrs[me->arch.stubs_section].sh_size / sizeof(*stubs);
 
 	/* Find this stub, or if that fails, the next avail. entry */
 	stubs = (void *)sechdrs[me->arch.stubs_section].sh_addr;
-	for (i = 0; stubs[i].opd.funcaddr; i++) {
+	for (i = 0; stub_func_addr(stubs[i].funcdata); i++) {
 		BUG_ON(i >= num_stubs);
 
-		if (stubs[i].opd.funcaddr == opd->funcaddr)
+		if (stub_func_addr(stubs[i].funcdata) == func_addr(addr))
 			return (unsigned long)&stubs[i];
 	}
 
-	if (!create_stub(sechdrs, &stubs[i], opd, me))
+	if (!create_stub(sechdrs, &stubs[i], addr, me))
 		return 0;
 
 	return (unsigned long)&stubs[i];
@@ -480,7 +528,8 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 					return -ENOENT;
 				if (!restore_r2((u32 *)location + 1, me))
 					return -ENOEXEC;
-			}
+			} else
+				value += local_entry_offset(sym);
 
 			/* Convert value to relative */
 			value -= (unsigned long)location;
-- 
1.8.3.2
