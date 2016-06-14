Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTXr94xLpzDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 01:00:09 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5EEsW6l127925
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:00:07 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jj0ddpjc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:00:07 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 12:00:04 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 5373D1DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 10:59:54 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5EF00s114680448
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 12:00:00 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5EExxZl018832
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 12:00:00 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Torsten Duwe <duwe@suse.de>
Subject: [PATCH v2 4/9] powerpc: Factor out relocation code from module_64.c
 to elf_util_64.c.
Date: Tue, 14 Jun 2016 11:59:04 -0300
In-Reply-To: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1465916349-3398-5-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kexec_file_load system call needs to relocate the purgatory, so
factor out the module relocation code so that it can be shared.

This patch's purpose is to move the ELF relocation logic from
apply_relocate_add to elf_util_64.c with as few changes as
possible. The following changes were needed:

To avoid having module-specific code in a general purpose utility
function, struct elf_info was created to contain the information
needed for ELF binaries manipulation.

my_r2, stub_for_addr and create_stub were changed to use it instead of
having to receive a struct module, since they are called from
elf64_apply_relocate_add.

local_entry_offset and squash_toc_save_inst were only used by
apply_rellocate_add, so they were moved to elf_util_64.c as well.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Torsten Duwe <duwe@suse.de>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/include/asm/elf_util.h |  70 ++++++++
 arch/powerpc/include/asm/module.h   |  14 +-
 arch/powerpc/kernel/Makefile        |   4 +
 arch/powerpc/kernel/elf_util_64.c   | 269 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/module_64.c     | 312 ++++--------------------------------
 5 files changed, 386 insertions(+), 283 deletions(-)

diff --git a/arch/powerpc/include/asm/elf_util.h b/arch/powerpc/include/asm/elf_util.h
new file mode 100644
index 000000000000..13d3ca113299
--- /dev/null
+++ b/arch/powerpc/include/asm/elf_util.h
@@ -0,0 +1,70 @@
+/*
+ * Utility functions to work with ELF files.
+ *
+ * Copyright (C) 2016, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _ASM_POWERPC_ELF_UTIL_H
+#define _ASM_POWERPC_ELF_UTIL_H
+
+#include <linux/elf.h>
+
+struct elf_info {
+	struct elf_shdr *sechdrs;
+
+	/* Index of stubs section. */
+	unsigned int stubs_section;
+	/* Index of TOC section. */
+	unsigned int toc_section;
+};
+
+#ifdef __powerpc64__
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+
+/* An address is simply the address of the function. */
+typedef unsigned long func_desc_t;
+#else
+
+/* An address is address of the OPD entry, which contains address of fn. */
+typedef struct ppc64_opd_entry func_desc_t;
+#endif
+
+/* Like PPC32, we need little trampolines to do > 24-bit jumps (into
+   the kernel itself).  But on PPC64, these need to be used for every
+   jump, actually, to reset r2 (TOC+0x8000). */
+struct ppc64_stub_entry
+{
+	/* 28 byte jump instruction sequence (7 instructions). We only
+	 * need 6 instructions on ABIv2 but we always allocate 7 so
+	 * so we don't have to modify the trampoline load instruction. */
+	u32 jump[7];
+	/* Used by ftrace to identify stubs */
+	u32 magic;
+	/* Data for the above code */
+	func_desc_t funcdata;
+};
+#endif
+
+/* r2 is the TOC pointer: it actually points 0x8000 into the TOC (this
+   gives the value maximum span in an instruction which uses a signed
+   offset) */
+static inline unsigned long my_r2(const struct elf_info *elf_info)
+{
+	return elf_info->sechdrs[elf_info->toc_section].sh_addr + 0x8000;
+}
+
+int elf64_apply_relocate_add(const struct elf_info *elf_info,
+			     const char *strtab, unsigned int symindex,
+			     unsigned int relsec, const char *obj_name);
+
+#endif /* _ASM_POWERPC_ELF_UTIL_H */
diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index cd4ffd86765f..f2073115d518 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -12,7 +12,14 @@
 #include <linux/list.h>
 #include <asm/bug.h>
 #include <asm-generic/module.h>
+#include <asm/elf_util.h>
 
+/* Both low and high 16 bits are added as SIGNED additions, so if low
+   16 bits has high bit set, high 16 bits must be adjusted.  These
+   macros do that (stolen from binutils). */
+#define PPC_LO(v) ((v) & 0xffff)
+#define PPC_HI(v) (((v) >> 16) & 0xffff)
+#define PPC_HA(v) PPC_HI ((v) + 0x8000)
 
 #ifndef __powerpc64__
 /*
@@ -33,8 +40,7 @@ struct ppc_plt_entry {
 
 struct mod_arch_specific {
 #ifdef __powerpc64__
-	unsigned int stubs_section;	/* Index of stubs section in module */
-	unsigned int toc_section;	/* What section is the TOC? */
+	struct elf_info elf_info;
 	bool toc_fixed;			/* Have we fixed up .TOC.? */
 #ifdef CONFIG_DYNAMIC_FTRACE
 	unsigned long toc;
@@ -90,6 +96,10 @@ static inline int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sec
 }
 #endif
 
+unsigned long stub_for_addr(const struct elf_info *elf_info, unsigned long addr,
+			    const char *obj_name);
+int restore_r2(u32 *instruction, const char *obj_name);
+
 struct exception_table_entry;
 void sort_ex_table(struct exception_table_entry *start,
 		   struct exception_table_entry *finish);
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2da380fcc34c..e99f626acc85 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -124,6 +124,10 @@ ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
 obj-y				+= iomap.o
 endif
 
+ifeq ($(CONFIG_MODULES)$(CONFIG_WORD_SIZE),y64)
+obj-y				+= elf_util_64.o
+endif
+
 obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)	+= tm.o
 
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
diff --git a/arch/powerpc/kernel/elf_util_64.c b/arch/powerpc/kernel/elf_util_64.c
new file mode 100644
index 000000000000..b53b3959a605
--- /dev/null
+++ b/arch/powerpc/kernel/elf_util_64.c
@@ -0,0 +1,269 @@
+/*
+ * Utility functions to work with ELF files.
+ *
+ * Copyright (C) 2016, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <asm/ppc-opcode.h>
+#include <asm/elf_util.h>
+
+/*
+ * We just need to use the functions defined in <asm/module.h>, so just declare
+ * struct module here and avoid having to import <linux/module.h>.
+ */
+struct module;
+#include <asm/module.h>
+
+#if defined(_CALL_ELF) && _CALL_ELF == 2
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
+#else
+static unsigned int local_entry_offset(const Elf64_Sym *sym)
+{
+	return 0;
+}
+#endif
+
+#ifdef CC_USING_MPROFILE_KERNEL
+/*
+ * In case of _mcount calls, do not save the current callee's TOC (in r2) into
+ * the original caller's stack frame. If we did we would clobber the saved TOC
+ * value of the original caller.
+ */
+static void squash_toc_save_inst(const char *name, unsigned long addr)
+{
+	struct ppc64_stub_entry *stub = (struct ppc64_stub_entry *)addr;
+
+	/* Only for calls to _mcount */
+	if (strcmp("_mcount", name) != 0)
+		return;
+
+	stub->jump[2] = PPC_INST_NOP;
+}
+#else
+static void squash_toc_save_inst(const char *name, unsigned long addr) { }
+#endif
+
+/**
+ * elf64_apply_relocate_add - apply 64 bit RELA relocations
+ * @elf_info:		Support information for the ELF binary being relocated.
+ * @strtab:		String table for the associated symbol table.
+ * @symindex:		Section header index for the associated symbol table.
+ * @relsec:		Section header index for the relocations to apply.
+ * @obj_name:		The name of the ELF binary, for information messages.
+ */
+int elf64_apply_relocate_add(const struct elf_info *elf_info,
+			     const char *strtab, unsigned int symindex,
+			     unsigned int relsec, const char *obj_name)
+{
+	unsigned int i;
+	Elf64_Shdr *sechdrs = elf_info->sechdrs;
+	Elf64_Rela *rela = (void *)sechdrs[relsec].sh_addr;
+	Elf64_Sym *sym;
+	unsigned long *location;
+	unsigned long value;
+
+
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rela); i++) {
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
+			+ rela[i].r_offset;
+		/* This is the symbol it is referring to */
+		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
+			+ ELF64_R_SYM(rela[i].r_info);
+
+		pr_debug("RELOC at %p: %li-type as %s (0x%lx) + %li\n",
+		       location, (long)ELF64_R_TYPE(rela[i].r_info),
+		       strtab + sym->st_name, (unsigned long)sym->st_value,
+		       (long)rela[i].r_addend);
+
+		/* `Everything is relative'. */
+		value = sym->st_value + rela[i].r_addend;
+
+		switch (ELF64_R_TYPE(rela[i].r_info)) {
+		case R_PPC64_ADDR32:
+			/* Simply set it */
+			*(u32 *)location = value;
+			break;
+
+		case R_PPC64_ADDR64:
+			/* Simply set it */
+			*(unsigned long *)location = value;
+			break;
+
+		case R_PPC64_TOC:
+			*(unsigned long *)location = my_r2(elf_info);
+			break;
+
+		case R_PPC64_TOC16:
+			/* Subtract TOC pointer */
+			value -= my_r2(elf_info);
+			if (value + 0x8000 > 0xffff) {
+				pr_err("%s: bad TOC16 relocation (0x%lx)\n",
+				       obj_name, value);
+				return -ENOEXEC;
+			}
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+			break;
+
+		case R_PPC64_TOC16_LO:
+			/* Subtract TOC pointer */
+			value -= my_r2(elf_info);
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+			break;
+
+		case R_PPC64_TOC16_DS:
+			/* Subtract TOC pointer */
+			value -= my_r2(elf_info);
+			if ((value & 3) != 0 || value + 0x8000 > 0xffff) {
+				pr_err("%s: bad TOC16_DS relocation (0x%lx)\n",
+				       obj_name, value);
+				return -ENOEXEC;
+			}
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xfffc)
+				| (value & 0xfffc);
+			break;
+
+		case R_PPC64_TOC16_LO_DS:
+			/* Subtract TOC pointer */
+			value -= my_r2(elf_info);
+			if ((value & 3) != 0) {
+				pr_err("%s: bad TOC16_LO_DS relocation (0x%lx)\n",
+				       obj_name, value);
+				return -ENOEXEC;
+			}
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xfffc)
+				| (value & 0xfffc);
+			break;
+
+		case R_PPC64_TOC16_HA:
+			/* Subtract TOC pointer */
+			value -= my_r2(elf_info);
+			value = ((value + 0x8000) >> 16);
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+			break;
+
+		case R_PPC_REL24:
+			/* FIXME: Handle weak symbols here --RR */
+			if (sym->st_shndx == SHN_UNDEF) {
+				/* External: go via stub */
+				value = stub_for_addr(elf_info, value, obj_name);
+				if (!value)
+					return -ENOENT;
+				if (!restore_r2((u32 *)location + 1, obj_name))
+					return -ENOEXEC;
+
+				squash_toc_save_inst(strtab + sym->st_name, value);
+			} else
+				value += local_entry_offset(sym);
+
+			/* Convert value to relative */
+			value -= (unsigned long)location;
+			if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0){
+				pr_err("%s: REL24 %li out of range!\n",
+				       obj_name, (long int)value);
+				return -ENOEXEC;
+			}
+
+			/* Only replace bits 2 through 26 */
+			*(uint32_t *)location
+				= (*(uint32_t *)location & ~0x03fffffc)
+				| (value & 0x03fffffc);
+			break;
+
+		case R_PPC64_REL64:
+			/* 64 bits relative (used by features fixups) */
+			*location = value - (unsigned long)location;
+			break;
+
+		case R_PPC64_TOCSAVE:
+			/*
+			 * Marker reloc indicates we don't have to save r2.
+			 * That would only save us one instruction, so ignore
+			 * it.
+			 */
+			break;
+
+		case R_PPC64_ENTRY:
+			/*
+			 * Optimize ELFv2 large code model entry point if
+			 * the TOC is within 2GB range of current location.
+			 */
+			value = my_r2(elf_info) - (unsigned long)location;
+			if (value + 0x80008000 > 0xffffffff)
+				break;
+			/*
+			 * Check for the large code model prolog sequence:
+			 *	ld r2, ...(r12)
+			 *	add r2, r2, r12
+			 */
+			if ((((uint32_t *)location)[0] & ~0xfffc)
+			    != 0xe84c0000)
+				break;
+			if (((uint32_t *)location)[1] != 0x7c426214)
+				break;
+			/*
+			 * If found, replace it with:
+			 *	addis r2, r12, (.TOC.-func)@ha
+			 *	addi r2, r12, (.TOC.-func)@l
+			 */
+			((uint32_t *)location)[0] = 0x3c4c0000 + PPC_HA(value);
+			((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
+			break;
+
+		case R_PPC64_REL16_HA:
+			/* Subtract location pointer */
+			value -= (unsigned long)location;
+			value = ((value + 0x8000) >> 16);
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+			break;
+
+		case R_PPC64_REL16_LO:
+			/* Subtract location pointer */
+			value -= (unsigned long)location;
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+			break;
+
+		default:
+			pr_err("%s: Unknown ADD relocation: %lu\n",
+			       obj_name,
+			       (unsigned long)ELF64_R_TYPE(rela[i].r_info));
+			return -ENOEXEC;
+		}
+	}
+
+	return 0;
+}
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 9ce9a25f58b5..5f2eeab93651 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -19,7 +19,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
-#include <linux/elf.h>
+#include <asm/elf_util.h>
 #include <linux/moduleloader.h>
 #include <linux/err.h>
 #include <linux/vmalloc.h>
@@ -43,9 +43,6 @@
 
 #if defined(_CALL_ELF) && _CALL_ELF == 2
 
-/* An address is simply the address of the function. */
-typedef unsigned long func_desc_t;
-
 static func_desc_t func_desc(unsigned long addr)
 {
 	return addr;
@@ -58,25 +55,8 @@ static unsigned long stub_func_addr(func_desc_t func)
 {
 	return func;
 }
-
-/* PowerPC64 specific values for the Elf64_Sym st_other field.  */
-#define STO_PPC64_LOCAL_BIT	5
-#define STO_PPC64_LOCAL_MASK	(7 << STO_PPC64_LOCAL_BIT)
-#define PPC64_LOCAL_ENTRY_OFFSET(other)					\
- (((1 << (((other) & STO_PPC64_LOCAL_MASK) >> STO_PPC64_LOCAL_BIT)) >> 2) << 2)
-
-static unsigned int local_entry_offset(const Elf64_Sym *sym)
-{
-	/* sym->st_other indicates offset to local entry point
-	 * (otherwise it will assume r12 is the address of the start
-	 * of function and try to derive r2 from it). */
-	return PPC64_LOCAL_ENTRY_OFFSET(sym->st_other);
-}
 #else
 
-/* An address is address of the OPD entry, which contains address of fn. */
-typedef struct ppc64_opd_entry func_desc_t;
-
 static func_desc_t func_desc(unsigned long addr)
 {
 	return *(struct ppc64_opd_entry *)addr;
@@ -89,29 +69,10 @@ static unsigned long stub_func_addr(func_desc_t func)
 {
 	return func.funcaddr;
 }
-static unsigned int local_entry_offset(const Elf64_Sym *sym)
-{
-	return 0;
-}
 #endif
 
 #define STUB_MAGIC 0x73747562 /* stub */
 
-/* Like PPC32, we need little trampolines to do > 24-bit jumps (into
-   the kernel itself).  But on PPC64, these need to be used for every
-   jump, actually, to reset r2 (TOC+0x8000). */
-struct ppc64_stub_entry
-{
-	/* 28 byte jump instruction sequence (7 instructions). We only
-	 * need 6 instructions on ABIv2 but we always allocate 7 so
-	 * so we don't have to modify the trampoline load instruction. */
-	u32 jump[7];
-	/* Used by ftrace to identify stubs */
-	u32 magic;
-	/* Data for the above code */
-	func_desc_t funcdata;
-};
-
 /*
  * PPC64 uses 24 bit jumps, but we need to jump into other modules or
  * the kernel which may be further.  So we jump to a stub.
@@ -346,9 +307,9 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 	for (i = 1; i < hdr->e_shnum; i++) {
 		char *p;
 		if (strcmp(secstrings + sechdrs[i].sh_name, ".stubs") == 0)
-			me->arch.stubs_section = i;
+			me->arch.elf_info.stubs_section = i;
 		else if (strcmp(secstrings + sechdrs[i].sh_name, ".toc") == 0)
-			me->arch.toc_section = i;
+			me->arch.elf_info.toc_section = i;
 		else if (strcmp(secstrings+sechdrs[i].sh_name,"__versions")==0)
 			dedotify_versions((void *)hdr + sechdrs[i].sh_offset,
 					  sechdrs[i].sh_size);
@@ -364,7 +325,7 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 				 + sechdrs[sechdrs[i].sh_link].sh_offset);
 	}
 
-	if (!me->arch.stubs_section) {
+	if (!me->arch.elf_info.stubs_section) {
 		pr_err("%s: doesn't contain .stubs.\n", me->name);
 		return -ENOEXEC;
 	}
@@ -373,44 +334,32 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 	   to some reasonable value in case the module calls out to
 	   other functions via a stub, or if a function pointer escapes
 	   the module by some means.  */
-	if (!me->arch.toc_section)
-		me->arch.toc_section = me->arch.stubs_section;
+	if (!me->arch.elf_info.toc_section)
+		me->arch.elf_info.toc_section = me->arch.elf_info.stubs_section;
 
 	/* Override the stubs size */
-	sechdrs[me->arch.stubs_section].sh_size = get_stubs_size(hdr, sechdrs);
-	return 0;
-}
+	sechdrs[me->arch.elf_info.stubs_section].sh_size = get_stubs_size(hdr, sechdrs);
 
-/* r2 is the TOC pointer: it actually points 0x8000 into the TOC (this
-   gives the value maximum span in an instruction which uses a signed
-   offset) */
-static inline unsigned long my_r2(const Elf64_Shdr *sechdrs, struct module *me)
-{
-	return sechdrs[me->arch.toc_section].sh_addr + 0x8000;
-}
+	/* For the elf_util functions. */
+	me->arch.elf_info.sechdrs = sechdrs;
 
-/* Both low and high 16 bits are added as SIGNED additions, so if low
-   16 bits has high bit set, high 16 bits must be adjusted.  These
-   macros do that (stolen from binutils). */
-#define PPC_LO(v) ((v) & 0xffff)
-#define PPC_HI(v) (((v) >> 16) & 0xffff)
-#define PPC_HA(v) PPC_HI ((v) + 0x8000)
+	return 0;
+}
 
 /* Patch stub to reference function and correct r2 value. */
-static inline int create_stub(const Elf64_Shdr *sechdrs,
+static inline int create_stub(const struct elf_info *elf_info,
 			      struct ppc64_stub_entry *entry,
-			      unsigned long addr,
-			      struct module *me)
+			      unsigned long addr, const char *obj_name)
 {
 	long reladdr;
 
 	memcpy(entry->jump, ppc64_stub_insns, sizeof(ppc64_stub_insns));
 
 	/* Stub uses address relative to r2. */
-	reladdr = (unsigned long)entry - my_r2(sechdrs, me);
+	reladdr = (unsigned long)entry - my_r2(elf_info);
 	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
 		pr_err("%s: Address %p of stub out of range of %p.\n",
-		       me->name, (void *)reladdr, (void *)my_r2);
+		       obj_name, (void *)reladdr, (void *)my_r2);
 		return 0;
 	}
 	pr_debug("Stub %p get data from reladdr %li\n", entry, reladdr);
@@ -425,17 +374,17 @@ static inline int create_stub(const Elf64_Shdr *sechdrs,
 
 /* Create stub to jump to function described in this OPD/ptr: we need the
    stub to set up the TOC ptr (r2) for the function. */
-static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
-				   unsigned long addr,
-				   struct module *me)
+unsigned long stub_for_addr(const struct elf_info *elf_info, unsigned long addr,
+			    const char *obj_name)
 {
+	struct elf_shdr *stubs_sec = &elf_info->sechdrs[elf_info->stubs_section];
 	struct ppc64_stub_entry *stubs;
 	unsigned int i, num_stubs;
 
-	num_stubs = sechdrs[me->arch.stubs_section].sh_size / sizeof(*stubs);
+	num_stubs = stubs_sec->sh_size / sizeof(*stubs);
 
 	/* Find this stub, or if that fails, the next avail. entry */
-	stubs = (void *)sechdrs[me->arch.stubs_section].sh_addr;
+	stubs = (void *) stubs_sec->sh_addr;
 	for (i = 0; stub_func_addr(stubs[i].funcdata); i++) {
 		BUG_ON(i >= num_stubs);
 
@@ -443,7 +392,7 @@ static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
 			return (unsigned long)&stubs[i];
 	}
 
-	if (!create_stub(sechdrs, &stubs[i], addr, me))
+	if (!create_stub(elf_info, &stubs[i], addr, obj_name))
 		return 0;
 
 	return (unsigned long)&stubs[i];
@@ -465,24 +414,7 @@ static bool is_early_mcount_callsite(u32 *instruction)
 	return false;
 }
 
-/*
- * In case of _mcount calls, do not save the current callee's TOC (in r2) into
- * the original caller's stack frame. If we did we would clobber the saved TOC
- * value of the original caller.
- */
-static void squash_toc_save_inst(const char *name, unsigned long addr)
-{
-	struct ppc64_stub_entry *stub = (struct ppc64_stub_entry *)addr;
-
-	/* Only for calls to _mcount */
-	if (strcmp("_mcount", name) != 0)
-		return;
-
-	stub->jump[2] = PPC_INST_NOP;
-}
 #else
-static void squash_toc_save_inst(const char *name, unsigned long addr) { }
-
 /* without -mprofile-kernel, mcount calls are never early */
 static bool is_early_mcount_callsite(u32 *instruction)
 {
@@ -492,13 +424,13 @@ static bool is_early_mcount_callsite(u32 *instruction)
 
 /* We expect a noop next: if it is, replace it with instruction to
    restore r2. */
-static int restore_r2(u32 *instruction, struct module *me)
+int restore_r2(u32 *instruction, const char *obj_name)
 {
 	if (*instruction != PPC_INST_NOP) {
 		if (is_early_mcount_callsite(instruction - 1))
 			return 1;
 		pr_err("%s: Expect noop after relocate, got %08x\n",
-		       me->name, *instruction);
+		       obj_name, *instruction);
 		return 0;
 	}
 	/* ld r2,R2_STACK_OFFSET(r1) */
@@ -512,11 +444,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       unsigned int relsec,
 		       struct module *me)
 {
-	unsigned int i;
-	Elf64_Rela *rela = (void *)sechdrs[relsec].sh_addr;
 	Elf64_Sym *sym;
-	unsigned long *location;
-	unsigned long value;
 
 	pr_debug("Applying ADD relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
@@ -527,191 +455,12 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		/* It's theoretically possible that a module doesn't want a
 		 * .TOC. so don't fail it just for that. */
 		if (sym)
-			sym->st_value = my_r2(sechdrs, me);
+			sym->st_value = my_r2(&me->arch.elf_info);
 		me->arch.toc_fixed = true;
 	}
 
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rela); i++) {
-		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
-			+ rela[i].r_offset;
-		/* This is the symbol it is referring to */
-		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
-			+ ELF64_R_SYM(rela[i].r_info);
-
-		pr_debug("RELOC at %p: %li-type as %s (0x%lx) + %li\n",
-		       location, (long)ELF64_R_TYPE(rela[i].r_info),
-		       strtab + sym->st_name, (unsigned long)sym->st_value,
-		       (long)rela[i].r_addend);
-
-		/* `Everything is relative'. */
-		value = sym->st_value + rela[i].r_addend;
-
-		switch (ELF64_R_TYPE(rela[i].r_info)) {
-		case R_PPC64_ADDR32:
-			/* Simply set it */
-			*(u32 *)location = value;
-			break;
-
-		case R_PPC64_ADDR64:
-			/* Simply set it */
-			*(unsigned long *)location = value;
-			break;
-
-		case R_PPC64_TOC:
-			*(unsigned long *)location = my_r2(sechdrs, me);
-			break;
-
-		case R_PPC64_TOC16:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			if (value + 0x8000 > 0xffff) {
-				pr_err("%s: bad TOC16 relocation (0x%lx)\n",
-				       me->name, value);
-				return -ENOEXEC;
-			}
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC64_TOC16_LO:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC64_TOC16_DS:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			if ((value & 3) != 0 || value + 0x8000 > 0xffff) {
-				pr_err("%s: bad TOC16_DS relocation (0x%lx)\n",
-				       me->name, value);
-				return -ENOEXEC;
-			}
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xfffc)
-				| (value & 0xfffc);
-			break;
-
-		case R_PPC64_TOC16_LO_DS:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			if ((value & 3) != 0) {
-				pr_err("%s: bad TOC16_LO_DS relocation (0x%lx)\n",
-				       me->name, value);
-				return -ENOEXEC;
-			}
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xfffc)
-				| (value & 0xfffc);
-			break;
-
-		case R_PPC64_TOC16_HA:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			value = ((value + 0x8000) >> 16);
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC_REL24:
-			/* FIXME: Handle weak symbols here --RR */
-			if (sym->st_shndx == SHN_UNDEF) {
-				/* External: go via stub */
-				value = stub_for_addr(sechdrs, value, me);
-				if (!value)
-					return -ENOENT;
-				if (!restore_r2((u32 *)location + 1, me))
-					return -ENOEXEC;
-
-				squash_toc_save_inst(strtab + sym->st_name, value);
-			} else
-				value += local_entry_offset(sym);
-
-			/* Convert value to relative */
-			value -= (unsigned long)location;
-			if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0){
-				pr_err("%s: REL24 %li out of range!\n",
-				       me->name, (long int)value);
-				return -ENOEXEC;
-			}
-
-			/* Only replace bits 2 through 26 */
-			*(uint32_t *)location
-				= (*(uint32_t *)location & ~0x03fffffc)
-				| (value & 0x03fffffc);
-			break;
-
-		case R_PPC64_REL64:
-			/* 64 bits relative (used by features fixups) */
-			*location = value - (unsigned long)location;
-			break;
-
-		case R_PPC64_TOCSAVE:
-			/*
-			 * Marker reloc indicates we don't have to save r2.
-			 * That would only save us one instruction, so ignore
-			 * it.
-			 */
-			break;
-
-		case R_PPC64_ENTRY:
-			/*
-			 * Optimize ELFv2 large code model entry point if
-			 * the TOC is within 2GB range of current location.
-			 */
-			value = my_r2(sechdrs, me) - (unsigned long)location;
-			if (value + 0x80008000 > 0xffffffff)
-				break;
-			/*
-			 * Check for the large code model prolog sequence:
-		         *	ld r2, ...(r12)
-			 *	add r2, r2, r12
-			 */
-			if ((((uint32_t *)location)[0] & ~0xfffc)
-			    != 0xe84c0000)
-				break;
-			if (((uint32_t *)location)[1] != 0x7c426214)
-				break;
-			/*
-			 * If found, replace it with:
-			 *	addis r2, r12, (.TOC.-func)@ha
-			 *	addi r2, r12, (.TOC.-func)@l
-			 */
-			((uint32_t *)location)[0] = 0x3c4c0000 + PPC_HA(value);
-			((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
-			break;
-
-		case R_PPC64_REL16_HA:
-			/* Subtract location pointer */
-			value -= (unsigned long)location;
-			value = ((value + 0x8000) >> 16);
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC64_REL16_LO:
-			/* Subtract location pointer */
-			value -= (unsigned long)location;
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		default:
-			pr_err("%s: Unknown ADD relocation: %lu\n",
-			       me->name,
-			       (unsigned long)ELF64_R_TYPE(rela[i].r_info));
-			return -ENOEXEC;
-		}
-	}
-
-	return 0;
+	return elf64_apply_relocate_add(&me->arch.elf_info, strtab, symindex,
+					relsec, me->name);
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -745,10 +494,10 @@ static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module
 	};
 	long reladdr;
 
-	num_stubs = sechdrs[me->arch.stubs_section].sh_size / sizeof(*entry);
+	num_stubs = sechdrs[me->arch.elf_info.stubs_section].sh_size / sizeof(*entry);
 
 	/* Find the next available stub entry */
-	entry = (void *)sechdrs[me->arch.stubs_section].sh_addr;
+	entry = (void *)sechdrs[me->arch.elf_info.stubs_section].sh_addr;
 	for (i = 0; i < num_stubs && stub_func_addr(entry->funcdata); i++, entry++);
 
 	if (i >= num_stubs) {
@@ -777,13 +526,14 @@ static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module
 #else
 static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module *me)
 {
-	return stub_for_addr(sechdrs, (unsigned long)ftrace_caller, me);
+	return stub_for_addr(&me->arch.elf_info, (unsigned long)ftrace_caller,
+			     me->name);
 }
 #endif
 
 int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
 {
-	mod->arch.toc = my_r2(sechdrs, mod);
+	mod->arch.toc = my_r2(&mod->arch.elf_info);
 	mod->arch.tramp = create_ftrace_stub(sechdrs, mod);
 
 	if (!mod->arch.tramp)
-- 
1.9.1
