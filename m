Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rS1CB0CkzzDqbW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 13:11:17 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5C38h5x084564
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 23:11:16 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gcybfwu5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 23:11:16 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Sun, 12 Jun 2016 00:11:13 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 3F3313520068
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 23:10:54 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5C3BAtv9699824
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 00:11:10 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5C3B9Wn029774
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 00:11:09 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 6/8] powerpc: Implement kexec_file_load.
Date: Sun, 12 Jun 2016 00:10:20 -0300
In-Reply-To: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1465701022-11601-7-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds the machinery needed by kexec_file_load, except actually loading
a kernel and initrd.

elf64_apply_relocate_add was extended to support relative symbols. This
is necessary because before relocation, the module loading mechanism
adjusts Elf64_Sym.st_value to point to the absolute memory address,
while the kexec purgatory relocation code does that during relocation.

We also add relocation types used by the purgatory.

Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/Kconfig                   |  13 +++
 arch/powerpc/include/asm/elf_util.h    |   1 +
 arch/powerpc/include/asm/systbl.h      |   1 +
 arch/powerpc/include/asm/unistd.h      |   2 +-
 arch/powerpc/include/uapi/asm/unistd.h |   1 +
 arch/powerpc/kernel/Makefile           |   4 +-
 arch/powerpc/kernel/elf_util_64.c      |  83 +++++++++++++++++++-
 arch/powerpc/kernel/machine_kexec_64.c | 139 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/module_64.c        |   5 +-
 9 files changed, 245 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 01f7464d9fea..3ed5770b89e4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -457,6 +457,19 @@ config KEXEC
 	  interface is strongly in flux, so no good recommendation can be
 	  made.
 
+config KEXEC_FILE
+	bool "kexec file based system call"
+	select KEXEC_CORE
+	select BUILD_BIN2C
+	depends on PPC64
+	depends on CRYPTO=y
+	depends on CRYPTO_SHA256=y
+	help
+	  This is a new version of the kexec system call. This call is
+	  file based and takes in file descriptors as system call arguments
+	  for kernel and initramfs as opposed to a list of segments as is the
+	  case for the older kexec call.
+
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
 	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
diff --git a/arch/powerpc/include/asm/elf_util.h b/arch/powerpc/include/asm/elf_util.h
index 9cd24bc528b1..41a172077f9e 100644
--- a/arch/powerpc/include/asm/elf_util.h
+++ b/arch/powerpc/include/asm/elf_util.h
@@ -86,6 +86,7 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			     const char *strtab, const Elf64_Rela *rela,
 			     unsigned int num_rela, void *syms_base,
 			     void *loc_base, Elf64_Addr addr_base,
+			     bool relative_symbols, bool check_symbols,
 			     const char *obj_name);
 
 #endif /* _ASM_POWERPC_ELF_UTIL_H */
diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 2fc5d4db503c..4b369d83fe9c 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -386,3 +386,4 @@ SYSCALL(mlock2)
 SYSCALL(copy_file_range)
 COMPAT_SYS_SPU(preadv2)
 COMPAT_SYS_SPU(pwritev2)
+SYSCALL(kexec_file_load)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index cf12c580f6b2..a01e97d3f305 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		382
+#define NR_syscalls		383
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index e9f5f41aa55a..2f26335a3c42 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -392,5 +392,6 @@
 #define __NR_copy_file_range	379
 #define __NR_preadv2		380
 #define __NR_pwritev2		381
+#define __NR_kexec_file_load	382
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 8a53fccaa053..c937b8074464 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -124,9 +124,11 @@ ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
 obj-y				+= iomap.o
 endif
 
-ifeq ($(CONFIG_MODULES)$(CONFIG_WORD_SIZE),y64)
+ifneq ($(CONFIG_MODULES)$(CONFIG_KEXEC_FILE),)
+ifeq ($(CONFIG_WORD_SIZE),64)
 obj-y				+= elf_util.o elf_util_64.o
 endif
+endif
 
 obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)	+= tm.o
 
diff --git a/arch/powerpc/kernel/elf_util_64.c b/arch/powerpc/kernel/elf_util_64.c
index cde0420add9e..287d381a1a86 100644
--- a/arch/powerpc/kernel/elf_util_64.c
+++ b/arch/powerpc/kernel/elf_util_64.c
@@ -74,6 +74,8 @@ static void squash_toc_save_inst(const char *name, unsigned long addr) { }
  * @syms_base:		Contents of the associated symbol table.
  * @loc_base:		Contents of the section to which relocations apply.
  * @addr_base:		The address where the section will be loaded in memory.
+ * @relative_symbols:	Are the symbols' st_value members relative?
+ * @check_symbols:	Fail if an unexpected symbol is found?
  * @obj_name:		The name of the ELF binary, for information messages.
  *
  * Applies RELA relocations to an ELF file already at its final location
@@ -84,16 +86,19 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			     const char *strtab, const Elf64_Rela *rela,
 			     unsigned int num_rela, void *syms_base,
 			     void *loc_base, Elf64_Addr addr_base,
+			     bool relative_symbols, bool check_symbols,
 			     const char *obj_name)
 {
 	unsigned int i;
 	unsigned long *location;
 	unsigned long address;
+	unsigned long sec_base;
 	unsigned long value;
 	const char *name;
 	Elf64_Sym *sym;
 
 	for (i = 0; i < num_rela; i++) {
+
 		/*
 		 * rels[i].r_offset contains the byte offset from the beginning
 		 * of section to the storage unit affected.
@@ -121,8 +126,34 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 		       name, (unsigned long)sym->st_value,
 		       (long)rela[i].r_addend);
 
+		if (check_symbols) {
+			/* TOC symbols appear as undefined but should be
+			 * resolved as well, so allow them to be processed. */
+			if (sym->st_shndx == SHN_UNDEF &&
+					strcmp(name, ".TOC.") != 0) {
+				pr_err("Undefined symbol: %s\n", name);
+				return -ENOEXEC;
+			} else if (sym->st_shndx == SHN_COMMON) {
+				pr_err("Symbol '%s' in common section.\n", name);
+				return -ENOEXEC;
+			}
+		}
+
+		if (relative_symbols && sym->st_shndx != SHN_ABS) {
+			if (sym->st_shndx >= elf_info->ehdr->e_shnum) {
+				pr_err("Invalid section %d for symbol %s\n",
+				       sym->st_shndx, name);
+				return -ENOEXEC;
+			} else {
+				struct elf_shdr *sechdrs = elf_info->sechdrs;
+
+				sec_base = sechdrs[sym->st_shndx].sh_addr;
+			}
+		} else
+			sec_base = 0;
+
 		/* `Everything is relative'. */
-		value = sym->st_value + rela[i].r_addend;
+		value = sym->st_value + sec_base + rela[i].r_addend;
 
 		switch (ELF64_R_TYPE(rela[i].r_info)) {
 		case R_PPC64_ADDR32:
@@ -135,6 +166,10 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			*(unsigned long *)location = value;
 			break;
 
+		case R_PPC64_REL32:
+			*(uint32_t *)location = value - (uint32_t)(uint64_t)location;
+			break;
+
 		case R_PPC64_TOC:
 			*(unsigned long *)location = my_r2(elf_info);
 			break;
@@ -186,6 +221,14 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 				| (value & 0xfffc);
 			break;
 
+		case R_PPC64_TOC16_HI:
+			/* Subtract TOC pointer */
+			value -= my_r2(elf_info);
+			value = value >> 16;
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+
 		case R_PPC64_TOC16_HA:
 			/* Subtract TOC pointer */
 			value -= my_r2(elf_info);
@@ -195,6 +238,21 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 				| (value & 0xffff);
 			break;
 
+		case R_PPC64_REL14:
+			/* Convert value to relative */
+			value -= address;
+			if (value + 0x8000 > 0xffff || (value & 3) != 0) {
+				pr_err("%s: REL14 %li out of range!\n", obj_name,
+				       (long int)value);
+				return -ENOEXEC;
+			}
+
+			/* Only replace bits 2 through 16 */
+			*(uint32_t *)location
+				= (*(uint32_t *)location & ~0xfffc)
+				| (value & 0xfffc);
+			break;
+
 		case R_PPC_REL24:
 			/* FIXME: Handle weak symbols here --RR */
 			if (sym->st_shndx == SHN_UNDEF) {
@@ -263,6 +321,29 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
 			break;
 
+		case R_PPC64_ADDR16_LO:
+			*(uint16_t *)location = value & 0xffff;
+			break;
+
+		case R_PPC64_ADDR16_HI:
+			*(uint16_t *)location = (value >> 16) & 0xffff;
+			break;
+
+		case R_PPC64_ADDR16_HA:
+			*(uint16_t *)location = (((value + 0x8000) >> 16) &
+							0xffff);
+			break;
+
+		case R_PPC64_ADDR16_HIGHER:
+			*(uint16_t *)location = (((uint64_t)value >> 32) &
+							0xffff);
+			break;
+
+		case R_PPC64_ADDR16_HIGHEST:
+			*(uint16_t *)location = (((uint64_t)value >> 48) &
+							0xffff);
+			break;
+
 		case R_PPC64_REL16_HA:
 			/* Subtract location pointer */
 			value -= address;
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index b8c202d63ecb..a3bd8cd53776 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -9,6 +9,7 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#define pr_fmt(fmt) "kexec: " fmt
 
 #include <linux/kexec.h>
 #include <linux/smp.h>
@@ -18,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/cpu.h>
 #include <linux/hardirq.h>
+#include <linux/memblock.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -30,6 +32,10 @@
 #include <asm/smp.h>
 #include <asm/hw_breakpoint.h>
 
+#ifdef CONFIG_KEXEC_FILE
+static struct kexec_file_ops *kexec_file_loaders[] = { };
+#endif
+
 #ifdef CONFIG_PPC_BOOK3E
 int default_machine_kexec_prepare(struct kimage *image)
 {
@@ -426,3 +432,136 @@ static int __init export_htab_values(void)
 }
 late_initcall(export_htab_values);
 #endif /* CONFIG_PPC_STD_MMU_64 */
+
+/* arch-dependent functionality required for implementing kexec_file_load() syscall */
+#ifdef CONFIG_KEXEC_FILE
+int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
+				  unsigned long buf_len)
+{
+	int i, ret = -ENOEXEC;
+	struct kexec_file_ops *fops;
+
+	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
+		fops = kexec_file_loaders[i];
+		if (!fops || !fops->probe)
+			continue;
+
+		ret = fops->probe(buf, buf_len);
+		if (!ret) {
+			image->fops = fops;
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+void *arch_kexec_kernel_image_load(struct kimage *image)
+{
+	if (!image->fops || !image->fops->load)
+		return ERR_PTR(-ENOEXEC);
+
+	return image->fops->load(image, image->kernel_buf,
+				 image->kernel_buf_len, image->initrd_buf,
+				 image->initrd_buf_len, image->cmdline_buf,
+				 image->cmdline_buf_len);
+}
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	if (!image->fops || !image->fops->cleanup)
+		return 0;
+
+	return image->fops->cleanup(image->image_loader_data);
+}
+
+/**
+ * arch_walk_system_ram - call func(data) for each unreserved memory block
+ * @start:	Minimum address.
+ * @end:	Maximum address.
+ * @top_down:	Starts from the highest address?
+ * @data:	Argument to pass to @func.
+ * @func:	Function to call for each memory block.
+ *
+ * This function is used by kexec_add_buffer and kexec_locate_mem_hole
+ * to find unreserved memory to load kexec segments into.
+ */
+int arch_walk_system_ram(unsigned long start, unsigned long end, bool top_down,
+			 void *data, int (*func)(u64, u64, void *))
+{
+	int ret = -1;
+	u64 i;
+	phys_addr_t mstart, mend;
+
+	if (top_down) {
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+						&mstart, &mend, NULL) {
+			if (end < mstart)
+				continue;
+			else if (start > mend)
+				break;
+
+			ret = func(mstart, mend, data);
+			if (ret)
+				break;
+		}
+	} else {
+		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
+					NULL) {
+			if (end < mstart)
+				break;
+			else if (start > mend)
+				continue;
+
+			ret = func(mstart, mend, data);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * arch_kexec_apply_relocations_add - apply purgatory relocations
+ * @ehdr:	Pointer to ELF headers.
+ * @sechdrs:	Pointer to section headers.
+ * @relsec:	Section index of SHT_RELA section.
+ *
+ * Elf64_Shdr.sh_offset has been modified to keep the pointer to the section
+ * contents, while Elf64_Shdr.sh_addr points to the final adress of the
+ * section in memory.
+ */
+int arch_kexec_apply_relocations_add(const Elf64_Ehdr *ehdr,
+				     Elf64_Shdr *sechdrs, unsigned int relsec)
+{
+	/* Section containing the relocation entries. */
+	Elf64_Shdr *rel_section = &sechdrs[relsec];
+	const Elf64_Rela *rela = (const Elf64_Rela *) rel_section->sh_offset;
+	unsigned int num_rela = rel_section->sh_size / sizeof(Elf64_Rela);
+	/* Section to which relocations apply. */
+	Elf64_Shdr *target_section = &sechdrs[rel_section->sh_info];
+	/* Associated symbol table. */
+	Elf64_Shdr *symtabsec = &sechdrs[rel_section->sh_link];
+	void *syms_base = (void *) symtabsec->sh_offset;
+	void *loc_base = (void *) target_section->sh_offset;
+	Elf64_Addr addr_base = target_section->sh_addr;
+	struct elf_info elf_info;
+	const char *strtab;
+
+	if (symtabsec->sh_link >= ehdr->e_shnum) {
+		/* Invalid strtab section number */
+		pr_err("Invalid string table section index %d\n",
+		       symtabsec->sh_link);
+		return -ENOEXEC;
+	}
+	/* String table for the associated symbol table. */
+	strtab = (const char *) sechdrs[symtabsec->sh_link].sh_offset;
+
+	elf_init_elf_info(ehdr, sechdrs, &elf_info);
+
+	return elf64_apply_relocate_add(&elf_info, strtab, rela, num_rela,
+					syms_base, loc_base, addr_base,
+					true, true, "kexec purgatory");
+}
+#endif /* CONFIG_KEXEC_FILE */
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index a3cb0f6e83bb..15b822867f8d 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -442,6 +442,9 @@ int restore_r2(u32 *instruction, const char *obj_name)
  * When this function is called, the module is already at its final location in
  * memory, so Elf64_Shdr.sh_addr can be used for accessing the section
  * contents as well as the base address for relocations.
+ *
+ * Also, simplify_symbols already changed all symbols' st_value members
+ * to absolute addresses.
  */
 int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       const char *strtab,
@@ -471,7 +474,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 
 	return elf64_apply_relocate_add(&me->arch.elf_info, strtab, rela,
 					num_rela, syms_base, (void *) addr_base,
-					addr_base, me->name);
+					addr_base, false, false, me->name);
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-- 
1.9.1
