Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTXrD0dsDzDqfr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 01:00:11 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5EEsVtB087946
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:00:10 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jgpd8p7w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:00:09 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 12:00:06 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id E7D111DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 10:59:57 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5EF04H061538418
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 12:00:04 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5EF04aF019606
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 12:00:04 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v2 8/9] powerpc: Add support for loading ELF kernels with
 kexec_file_load.
Date: Tue, 14 Jun 2016 11:59:08 -0300
In-Reply-To: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1465916349-3398-9-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This uses all the infrastructure built up by the previous patches
in the series to load an ELF vmlinux file and an initrd. It uses the
flattened device tree at initial_boot_params as a base and adjusts memory
reservations and its /chosen node for the next kernel.

elf64_apply_relocate_add was extended to support relative symbols. This
is necessary because before relocation, the module loading mechanism
adjusts Elf64_Sym.st_value to point to the absolute memory address
while the kexec purgatory relocation code does that during relocation.

The patch also adds relocation types used by the purgatory.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/include/asm/elf_util.h     |   1 +
 arch/powerpc/include/asm/kexec_elf_64.h |  10 +
 arch/powerpc/kernel/Makefile            |   5 +-
 arch/powerpc/kernel/elf_util_64.c       |  82 ++++-
 arch/powerpc/kernel/kexec_elf_64.c      | 564 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c  | 102 +++++-
 arch/powerpc/kernel/module_64.c         |   5 +-
 7 files changed, 765 insertions(+), 4 deletions(-)

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
diff --git a/arch/powerpc/include/asm/kexec_elf_64.h b/arch/powerpc/include/asm/kexec_elf_64.h
new file mode 100644
index 000000000000..30da6bc0ccf8
--- /dev/null
+++ b/arch/powerpc/include/asm/kexec_elf_64.h
@@ -0,0 +1,10 @@
+#ifndef __POWERPC_KEXEC_ELF_64_H__
+#define __POWERPC_KEXEC_ELF_64_H__
+
+#ifdef CONFIG_KEXEC_FILE
+
+extern struct kexec_file_ops kexec_elf64_ops;
+
+#endif /* CONFIG_KEXEC_FILE */
+
+#endif /* __POWERPC_KEXEC_ELF_64_H__ */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 8a53fccaa053..b89a2ae1b2a0 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
 obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o \
 				   machine_kexec_$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
@@ -124,9 +125,11 @@ ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
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
index cde0420add9e..4ad85086b31b 100644
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
@@ -84,11 +86,13 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
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
@@ -121,8 +125,34 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
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
@@ -135,6 +165,10 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			*(unsigned long *)location = value;
 			break;
 
+		case R_PPC64_REL32:
+			*(uint32_t *)location = value - (uint32_t)(uint64_t)location;
+			break;
+
 		case R_PPC64_TOC:
 			*(unsigned long *)location = my_r2(elf_info);
 			break;
@@ -186,6 +220,14 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
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
@@ -195,6 +237,21 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
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
@@ -263,6 +320,29 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
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
diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
new file mode 100644
index 000000000000..4e71595300ed
--- /dev/null
+++ b/arch/powerpc/kernel/kexec_elf_64.c
@@ -0,0 +1,564 @@
+/*
+ * Load ELF vmlinux file for the kexec_file_load syscall.
+ *
+ * Copyright (C) 2004  Adam Litke (agl@us.ibm.com)
+ * Copyright (C) 2004  IBM Corp.
+ * Copyright (C) 2005  R Sharada (sharada@in.ibm.com)
+ * Copyright (C) 2006  Mohan Kumar M (mohan@in.ibm.com)
+ * Copyright (C) 2016  IBM Corporation
+ *
+ * Based on kexec-tools' kexec-elf-exec.c and kexec-elf-ppc64.c.
+ * Heavily modified for the kernel by
+ * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#define pr_fmt(fmt)	"kexec_elf: " fmt
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/kexec.h>
+#include <linux/elf.h>
+#include <linux/kexec.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
+#include <linux/memblock.h>
+#include <asm/elf_util.h>
+
+extern size_t kexec_purgatory_size;
+
+#define PURGATORY_STACK_SIZE	(16 * 1024)
+#define SLAVE_CODE_SIZE		256
+
+/**
+ * build_elf_exec_info - read ELF executable and check that we can use it
+ */
+static int build_elf_exec_info(const char *buf, size_t len, struct elfhdr *ehdr,
+			       struct elf_info *elf_info)
+{
+	int i;
+	int ret;
+
+	ret = elf_read_from_buffer(buf, len, ehdr, elf_info);
+	if (ret)
+		return ret;
+
+	if (ehdr->e_type != ET_EXEC) {
+		pr_err("Not an ELF executable.\n");
+		goto error;
+	} else if (!elf_info->proghdrs) {
+		pr_err("No ELF program header.\n");
+		goto error;
+	}
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		/*
+		 * Kexec does not support loading interpreters.
+		 * In addition this check keeps us from attempting
+		 * to kexec ordinay executables.
+		 */
+		if (elf_info->proghdrs[i].p_type == PT_INTERP) {
+			pr_err("Requires an ELF interpreter.\n");
+			goto error;
+		}
+	}
+
+	return 0;
+error:
+	elf_free_info(elf_info);
+	return -ENOEXEC;
+}
+
+static int elf64_probe(const char *buf, unsigned long len)
+{
+	struct elfhdr ehdr;
+	struct elf_info elf_info;
+	int ret;
+
+	ret = build_elf_exec_info(buf, len, &ehdr, &elf_info);
+	if (ret)
+		return ret;
+
+	elf_free_info(&elf_info);
+
+	return elf_check_arch(&ehdr)? 0 : -ENOEXEC;
+}
+
+static bool find_debug_console(void *fdt, int chosen_node)
+{
+	int len;
+	int console_node;
+	const void *prop, *colon;
+
+	prop = fdt_getprop(fdt, chosen_node, "stdout-path", &len);
+	if (prop == NULL) {
+		if (len == -FDT_ERR_NOTFOUND) {
+			prop = fdt_getprop(fdt, chosen_node, "linux,stdout-path",
+					   &len);
+			if (prop == NULL) {
+				pr_debug("Unable to find [linux,]stdout-path.\n");
+				return false;
+			}
+		} else {
+			pr_debug("Error finding console: %s\n",
+				 fdt_strerror(len));
+			return false;
+		}
+	}
+
+	/*
+	 * stdout-path can have a ':' separating the path from device-specific
+	 * information, so we should only consider what's before it.
+	 */
+	colon = strchr(prop, ':');
+	if (colon != NULL)
+		len = colon - prop;
+	else
+		len -= 1;	/* Ignore the terminating NUL. */
+
+	console_node = fdt_path_offset_namelen(fdt, prop, len);
+	if (console_node < 0) {
+		pr_debug("Error finding console: %s\n",
+			 fdt_strerror(console_node));
+		return false;
+	}
+
+	if (fdt_node_check_compatible(fdt, console_node, "hvterm1") == 0)
+		return true;
+	else if (fdt_node_check_compatible(fdt, console_node,
+					   "hvterm-protocol") == 0)
+		return true;
+
+	return false;
+}
+
+static int setup_purgatory(struct kimage *image, struct elf_info *kernel_info,
+			   void *fdt, unsigned long kernel_load_addr,
+			   unsigned long fdt_load_addr, unsigned long stack_top,
+			   int debug)
+{
+	int ret, tree_node;
+	const void *prop;
+	unsigned long opal_base, opal_entry;
+	uint64_t toc;
+	unsigned int *slave_code, master_entry;
+	struct elf_info purg_info;
+
+	/* Get the slave code from the new kernel and put it in purgatory. */
+	slave_code = kmalloc(SLAVE_CODE_SIZE, GFP_KERNEL);
+	if (!slave_code)
+		return -ENOMEM;
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_start",
+					     slave_code, SLAVE_CODE_SIZE, true);
+	if (ret) {
+		kfree(slave_code);
+		return ret;
+	}
+	master_entry = slave_code[0];
+	memcpy(slave_code,
+	       kernel_info->buffer + kernel_info->proghdrs[0].p_offset,
+	       SLAVE_CODE_SIZE);
+	slave_code[0] = master_entry;
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_start",
+					     slave_code, SLAVE_CODE_SIZE,
+					     false);
+	kfree(slave_code);
+
+	ret = kexec_purgatory_get_set_symbol(image, "kernel", &kernel_load_addr,
+					     sizeof(kernel_load_addr), false);
+	if (ret)
+		return ret;
+	ret = kexec_purgatory_get_set_symbol(image, "dt_offset", &fdt_load_addr,
+					     sizeof(fdt_load_addr), false);
+	if (ret)
+		return ret;
+
+	tree_node = fdt_path_offset(fdt, "/ibm,opal");
+	if (tree_node >= 0) {
+		prop = fdt_getprop(fdt, tree_node, "opal-base-address", NULL);
+		if (!prop) {
+			pr_err("OPAL address not found in the device tree.\n");
+			return -EINVAL;
+		}
+		opal_base = fdt64_to_cpu((const fdt64_t *) prop);
+
+		prop = fdt_getprop(fdt, tree_node, "opal-entry-address", NULL);
+		if (!prop) {
+			pr_err("OPAL address not found in the device tree.\n");
+			return -EINVAL;
+		}
+		opal_entry = fdt64_to_cpu((const fdt64_t *) prop);
+
+		ret = kexec_purgatory_get_set_symbol(image, "opal_base",
+						     &opal_base,
+						     sizeof(opal_base), false);
+		if (ret)
+			return ret;
+		ret = kexec_purgatory_get_set_symbol(image, "opal_entry",
+						     &opal_entry,
+						     sizeof(opal_entry), false);
+		if (ret)
+			return ret;
+	}
+
+	ret = kexec_purgatory_get_set_symbol(image, "stack", &stack_top,
+					     sizeof(stack_top), false);
+	if (ret)
+		return ret;
+
+	elf_init_elf_info(image->purgatory_info.ehdr,
+			  image->purgatory_info.sechdrs, &purg_info);
+	toc = my_r2(&purg_info);
+	ret = kexec_purgatory_get_set_symbol(image, "my_toc", &toc, sizeof(toc),
+					     false);
+	if (ret)
+		return ret;
+	pr_debug("Purgatory TOC is at 0x%llx\n", toc);
+
+	ret = kexec_purgatory_get_set_symbol(image, "debug", &debug,
+					     sizeof(debug), false);
+	if (ret)
+		return ret;
+	if (!debug)
+		pr_debug("Disabling purgatory output.\n");
+
+	return 0;
+}
+
+/**
+ * elf_exec_load - load ELF executable image
+ * @lowest_load_addr:	On return, will be the address where the first PT_LOAD
+ *			section will be loaded in memory.
+ *
+ * Return:
+ * 0 on success, negative value on failure.
+ */
+static int elf_exec_load(struct kimage *image, struct elfhdr *ehdr,
+			 struct elf_info *elf_info,
+			 unsigned long *lowest_load_addr)
+{
+	unsigned long base = 0, lowest_addr = UINT_MAX;
+	int ret;
+	size_t i;
+
+	/* Read in the PT_LOAD segments. */
+	for(i = 0; i < ehdr->e_phnum; i++) {
+		unsigned long load_addr;
+		size_t size;
+		const struct elf_phdr *phdr;
+
+		phdr = &elf_info->proghdrs[i];
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		size = phdr->p_filesz;
+		if (size > phdr->p_memsz)
+			size = phdr->p_memsz;
+
+		ret = kexec_add_buffer(image,
+				       (char *) elf_info->buffer + phdr->p_offset,
+				       size, phdr->p_memsz, phdr->p_align,
+				       phdr->p_paddr + base, ppc64_rma_size,
+				       false, &load_addr);
+		if (ret)
+			goto out;
+
+		if (load_addr < lowest_addr)
+			lowest_addr = load_addr;
+	}
+
+	/* Update entry point to reflect new load address. */
+	ehdr->e_entry += base;
+
+	*lowest_load_addr = lowest_addr;
+	ret = 0;
+ out:
+	return ret;
+}
+
+void *elf64_load(struct kimage *image, char *kernel_buf,
+		 unsigned long kernel_len, char *initrd,
+		 unsigned long initrd_len, char *cmdline,
+		 unsigned long cmdline_len)
+{
+	int i;
+	int ret = 0, chosen_node;
+	unsigned int fdt_size;
+	unsigned long kernel_load_addr, purgatory_load_addr;
+	unsigned long initrd_load_addr, fdt_load_addr, stack_top;
+	uint64_t oldfdt_addr;
+	void *fdt;
+	const void *prop;
+	struct elfhdr ehdr;
+	struct elf_info elf_info;
+	struct fdt_reserve_entry *rsvmap;
+
+	ret = build_elf_exec_info(kernel_buf, kernel_len, &ehdr, &elf_info);
+	if (ret)
+		goto out;
+
+	ret = elf_exec_load(image, &ehdr, &elf_info, &kernel_load_addr);
+	if (ret)
+		goto out;
+
+	pr_debug("Loaded the kernel at 0x%lx\n", kernel_load_addr);
+
+	ret = kexec_load_purgatory(image, 0, ppc64_rma_size, true,
+				   &purgatory_load_addr);
+	if (ret) {
+		pr_err("Loading purgatory failed.\n");
+		goto out;
+	}
+
+	pr_debug("Loaded purgatory at 0x%lx\n", purgatory_load_addr);
+
+	fdt_size = fdt_totalsize(initial_boot_params) * 2;
+	fdt = kmalloc(fdt_size, GFP_KERNEL);
+	if (!fdt) {
+		pr_err("Not enough memory for the device tree.\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = fdt_open_into(initial_boot_params, fdt, fdt_size);
+	if (ret < 0) {
+		pr_err("Error setting up the new device tree.\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Remove memory reservation for the current device tree. */
+	oldfdt_addr = __pa(initial_boot_params);
+	for (i = 0; i < fdt_num_mem_rsv(fdt); i++) {
+		uint64_t rsv_start, rsv_size;
+
+		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
+		if (ret) {
+			pr_err("Malformed device tree.\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (rsv_start == oldfdt_addr &&
+		    rsv_size == fdt_totalsize(initial_boot_params)) {
+			ret = fdt_del_mem_rsv(fdt, i);
+			if (ret) {
+				pr_err("Error deleting fdt reservation.\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			pr_debug("Removed old device tree reservation.\n");
+
+			break;
+		}
+	}
+
+	chosen_node = fdt_path_offset(fdt, "/chosen");
+	if (chosen_node < 0) {
+		pr_err("Malformed device tree: /chosen not found.\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Did we boot using an initrd? */
+	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
+	if (prop) {
+		uint64_t tmp_start, tmp_end, tmp_size, tmp_sizepg;
+
+		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
+		if (!prop) {
+			pr_err("Malformed device tree.\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		/*
+		 * kexec reserves exact initrd size, while firmware may
+		 * reserve a multiple of PAGE_SIZE, so check for both.
+		 */
+		tmp_size = tmp_end - tmp_start;
+		tmp_sizepg = round_up(tmp_size, PAGE_SIZE);
+
+		/* Remove memory reservation for the current initrd. */
+		for (i = 0; i < fdt_num_mem_rsv(fdt); i++) {
+			uint64_t rsv_start, rsv_size;
+
+			ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
+			if (ret) {
+				pr_err("Malformed device tree.\n");
+				ret = -EINVAL;
+				goto out;
+			}
+
+			if (rsv_start == tmp_start &&
+			    (rsv_size == tmp_size || rsv_size == tmp_sizepg)) {
+				ret = fdt_del_mem_rsv(fdt, i);
+				if (ret) {
+					pr_err("Error deleting fdt reservation.\n");
+					ret = -EINVAL;
+					goto out;
+				}
+				pr_debug("Removed old initrd reservation.\n");
+
+				/* fdt was modified, offsets may have changed. */
+				chosen_node = fdt_path_offset(fdt, "/chosen");
+				if (chosen_node < 0) {
+					pr_err("Malformed device tree.\n");
+					ret = -EINVAL;
+					goto out;
+				}
+
+				break;
+			}
+		}
+
+		/* If there's no new initrd, delete the old initrd's info. */
+		if (initrd == NULL) {
+			ret = fdt_delprop(fdt, chosen_node, "linux,initrd-start");
+			if (ret) {
+				pr_err("Error deleting linux,initrd-start.\n");
+				ret = -EINVAL;
+				goto out;
+			}
+
+			ret = fdt_delprop(fdt, chosen_node, "linux,initrd-end");
+			if (ret) {
+				pr_err("Error deleting linux,initrd-end.\n");
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
+	if (initrd != NULL) {
+		ret = kexec_add_buffer(image, initrd, initrd_len, initrd_len,
+				       PAGE_SIZE, 0, ppc64_rma_size, false,
+				       &initrd_load_addr);
+		if (ret)
+			goto out;
+
+		pr_debug("Loaded initrd at 0x%lx\n", initrd_load_addr);
+
+		ret = fdt_setprop_u64(fdt, chosen_node, "linux,initrd-start",
+				      initrd_load_addr);
+		if (ret < 0) {
+			pr_err("Error setting up the new device tree.\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		/* initrd-end is the first address after the initrd image. */
+		ret = fdt_setprop_u64(fdt, chosen_node, "linux,initrd-end",
+				      initrd_load_addr + initrd_len);
+		if (ret < 0) {
+			pr_err("Error setting up the new device tree.\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = fdt_add_mem_rsv(fdt, initrd_load_addr, initrd_len);
+		if (ret) {
+			pr_err("Error reserving initrd memory: %s\n",
+			       fdt_strerror(ret));
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (cmdline_len) {
+		ret = fdt_setprop_string(fdt, chosen_node, "bootargs", cmdline);
+		if (ret < 0) {
+			pr_err("Error setting up the new device tree.\n");
+			ret = -EINVAL;
+			goto out;
+		}
+	} else {
+		ret = fdt_delprop(fdt, chosen_node, "bootargs");
+		if (ret && ret != -FDT_ERR_NOTFOUND) {
+			pr_err("Error deleting bootargs.\n");
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
+	if (ret) {
+		pr_err("Error setting up the new device tree.\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Documentation/devicetree/booting-without-of.txt says we need to
+	 * add a reservation entry for the device tree block, but
+	 * early_init_fdt_reserve_self reserves the memory even if there's no
+	 * such entry. We'll add a reservation entry anyway, to be safe and
+	 * compliant.
+	 *
+	 * Use dummy values, we will correct them in a moment.
+	 */
+	ret = fdt_add_mem_rsv(fdt, 1, 1);
+	if (ret) {
+		pr_err("Error reserving device tree memory: %s\n",
+		       fdt_strerror(ret));
+		ret = -EINVAL;
+		goto out;
+	}
+	fdt_pack(fdt);
+
+	ret = kexec_add_buffer(image, fdt, fdt_size, fdt_size, PAGE_SIZE, 0,
+			       ppc64_rma_size, true, &fdt_load_addr);
+	if (ret)
+		goto out;
+
+	/*
+	 * Fix fdt reservation, now that we now where it will be loaded
+	 * and how big it is.
+	 */
+	rsvmap = fdt + fdt_off_mem_rsvmap(fdt);
+	i = fdt_num_mem_rsv(fdt) - 1;
+	rsvmap[i].address = cpu_to_fdt64(fdt_load_addr);
+	rsvmap[i].size = cpu_to_fdt64(fdt_totalsize(fdt));
+
+	pr_debug("Loaded device tree at 0x%lx\n", fdt_load_addr);
+
+	ret = kexec_locate_mem_hole(image, PURGATORY_STACK_SIZE, PAGE_SIZE, 0,
+				    ppc64_rma_size, true, &stack_top);
+	if (ret) {
+		pr_err("Couldn't find free memory for the purgatory stack.\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+	stack_top = stack_top + PURGATORY_STACK_SIZE - 1;
+	pr_debug("Purgatory stack is at 0x%lx\n", stack_top);
+
+	ret = setup_purgatory(image, &elf_info, fdt, kernel_load_addr,
+			      fdt_load_addr, stack_top,
+			      find_debug_console(fdt, chosen_node));
+	if (ret)
+		pr_err("Error setting up the purgatory.\n");
+
+out:
+	elf_free_info(&elf_info);
+
+	/* Make kimage_file_post_load_cleanup free the fdt buffer for us. */
+	return ret? ERR_PTR(ret) : fdt;
+}
+
+struct kexec_file_ops kexec_elf64_ops = {
+	.probe = elf64_probe,
+	.load = elf64_load,
+};
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 4042d66939b8..43e8185ab6f7 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/cpu.h>
 #include <linux/hardirq.h>
+#include <linux/memblock.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -29,9 +30,12 @@
 #include <asm/prom.h>
 #include <asm/smp.h>
 #include <asm/hw_breakpoint.h>
+#include <asm/kexec_elf_64.h>
 
 #ifdef CONFIG_KEXEC_FILE
-static struct kexec_file_ops *kexec_file_loaders[] = { };
+static struct kexec_file_ops *kexec_file_loaders[] = {
+	&kexec_elf64_ops,
+};
 #endif
 
 #ifdef CONFIG_PPC_BOOK3E
@@ -476,4 +480,100 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 
 	return image->fops->cleanup(image->image_loader_data);
 }
+
+/**
+ * arch_kexec_walk_mem - call func(data) for each unreserved memory block
+ * @image_type:	kimage.type
+ * @start:	Minimum address.
+ * @end:	Maximum address.
+ * @top_down:	Start from the highest address?
+ * @data:	Argument to pass to @func.
+ * @func:	Function to call for each memory block.
+ *
+ * This function is used by kexec_add_buffer and kexec_locate_mem_hole
+ * to find unreserved memory to load kexec segments into.
+ *
+ * Return: The memory walk will stop when func returns a non-zero value
+ * and that value will be returned. If all free regions are visited without
+ * func returning non-zero, then zero will be returned.
+ */
+int arch_kexec_walk_mem(unsigned int image_type, unsigned long start,
+			unsigned long end, bool top_down, void *data,
+			int (*func)(u64, u64, void *))
+{
+	int ret = 0;
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
 #endif /* CONFIG_KEXEC_FILE */
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
