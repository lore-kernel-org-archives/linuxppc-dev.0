Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0VM14NXlzDvZm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 13:42:05 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L2d3JM014603
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:42:03 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2675yfgy4x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:42:02 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 00:42:00 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 1ED73352005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:41:32 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L2fwjS24838554
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:41:58 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L2fu6r006328
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:41:58 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Josh Sklar <sklar@linux.vnet.ibm.com>
Subject: [PATCH v9 06/10] powerpc: Implement kexec_file_load.
Date: Fri, 21 Oct 2016 00:40:13 -0200
In-Reply-To: <1477017617-8540-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1477017617-8540-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1477017617-8540-7-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add arch-specific functions needed by generic kexec_file code.

Also, module_64.c's apply_relocate_add and kexec_file's
arch_kexec_apply_relocations_add have slightly different needs, so
elf64_apply_relocate_add_item needs to be adapted to accommodate both:

When apply_relocate_add is called, the module is already loaded at its
final location in memory so the place where the relocation needs to be
applied and its address in the module's memory are the same.

This is not the case for kexec's purgatory, because it is stored in a
buffer and will only be copied to its final location in memory right
before being executed. Therefore, it needs to be relocated while still
in its buffer. In this case, the place where the relocation needs to
be applied is different from its address in the purgatory's memory.

So we add an address argument to elf64_apply_relocate_add_item
to specify the final address of the relocation in memory. We also add
more relocation types that are used by the purgatory.

Signed-off-by: Josh Sklar <sklar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                        |  13 ++
 arch/powerpc/include/asm/elf_util.h         |  43 +++++
 arch/powerpc/include/asm/systbl.h           |   1 +
 arch/powerpc/include/asm/unistd.h           |   2 +-
 arch/powerpc/include/uapi/asm/unistd.h      |   1 +
 arch/powerpc/kernel/Makefile                |   1 +
 arch/powerpc/kernel/elf_util.c              |  46 ++++++
 arch/powerpc/kernel/machine_kexec_file_64.c | 245 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/module_64.c             |  71 ++++++--
 9 files changed, 406 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6cb59c6e5ba4..897d0f14447d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -455,6 +455,19 @@ config KEXEC
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
 config RELOCATABLE
 	bool "Build a relocatable kernel"
 	depends on (PPC64 && !COMPILE_TEST) || (FLATMEM && (44x || FSL_BOOKE))
diff --git a/arch/powerpc/include/asm/elf_util.h b/arch/powerpc/include/asm/elf_util.h
new file mode 100644
index 000000000000..1df232f65ec8
--- /dev/null
+++ b/arch/powerpc/include/asm/elf_util.h
@@ -0,0 +1,43 @@
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
+/*
+ * r2 is the TOC pointer: it actually points 0x8000 into the TOC (this
+ * gives the value maximum span in an instruction which uses a signed
+ * offset)
+ */
+static inline unsigned long elf_my_r2(const struct elf_shdr *sechdrs,
+				      unsigned int toc_section)
+{
+	return sechdrs[toc_section].sh_addr + 0x8000;
+}
+
+unsigned int elf_toc_section(const struct elfhdr *ehdr,
+			     const struct elf_shdr *sechdrs);
+
+int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs, const char *strtab,
+				  const Elf64_Rela *rela, const Elf64_Sym *sym,
+				  unsigned long *location,
+				  unsigned long address, unsigned long value,
+				  unsigned long my_r2, const char *obj_name,
+				  struct module *me);
+
+#endif /* _ASM_POWERPC_ELF_UTIL_H */
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
index 22534a56c914..de14b7eb11bb 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_PCI)		+= pci_$(BITS).o $(pci64-y) \
 obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o crash.o \
 				   machine_kexec_$(BITS).o
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file_$(BITS).o elf_util.o
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
diff --git a/arch/powerpc/kernel/elf_util.c b/arch/powerpc/kernel/elf_util.c
new file mode 100644
index 000000000000..ffa68cd6fb99
--- /dev/null
+++ b/arch/powerpc/kernel/elf_util.c
@@ -0,0 +1,46 @@
+/*
+ * Utility functions to work with ELF files.
+ *
+ * Copyright (C) 2016, IBM Corporation
+ *
+ * Based on kexec-tools' kexec-elf.c. Heavily modified for the
+ * kernel by Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <asm/elf_util.h>
+
+/**
+ * elf_toc_section - find the toc section in the file with the given ELF headers
+ * @ehdr:	Pointer to already loaded ELF header.
+ * @sechdrs:	Pointer to already loaded section headers contents.
+ *
+ * Return: TOC section index or 0 if one wasn't found.
+ */
+unsigned int elf_toc_section(const struct elfhdr *ehdr,
+			     const struct elf_shdr *sechdrs)
+{
+	int i;
+	const char *shstrtab;
+
+	/* Section header string table. */
+	shstrtab = (const char *) sechdrs[ehdr->e_shstrndx].sh_offset;
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (sechdrs[i].sh_size == 0)
+			continue;
+
+		if (!strcmp(&shstrtab[sechdrs[i].sh_name], ".toc"))
+			return i;
+	}
+
+	return 0;
+}
diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
new file mode 100644
index 000000000000..c6b8f75c1624
--- /dev/null
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -0,0 +1,245 @@
+/*
+ * ppc64 code to implement the kexec_file_load syscall
+ *
+ * Copyright (C) 2004  Adam Litke (agl@us.ibm.com)
+ * Copyright (C) 2004  IBM Corp.
+ * Copyright (C) 2005  R Sharada (sharada@in.ibm.com)
+ * Copyright (C) 2006  Mohan Kumar M (mohan@in.ibm.com)
+ * Copyright (C) 2016  IBM Corporation
+ *
+ * Based on kexec-tools' kexec-elf-ppc64.c.
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
+ */
+
+#include <linux/slab.h>
+#include <linux/kexec.h>
+#include <linux/memblock.h>
+#include <linux/libfdt.h>
+#include <asm/elf_util.h>
+
+#define SLAVE_CODE_SIZE		256
+
+static struct kexec_file_ops *kexec_file_loaders[] = { };
+
+int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
+				  unsigned long buf_len)
+{
+	int i, ret = -ENOEXEC;
+	struct kexec_file_ops *fops;
+
+	/* We don't support crash kernels yet. */
+	if (image->type == KEXEC_TYPE_CRASH)
+		return -ENOTSUPP;
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
+ * arch_kexec_walk_mem - call func(data) for each unreserved memory block
+ * @kbuf:	Context info for the search. Also passed to @func.
+ * @func:	Function to call for each memory block.
+ *
+ * This function is used by kexec_add_buffer and kexec_locate_mem_hole
+ * to find unreserved memory to load kexec segments into.
+ *
+ * Return: The memory walk will stop when func returns a non-zero value
+ * and that value will be returned. If all free regions are visited without
+ * func returning non-zero, then zero will be returned.
+ */
+int arch_kexec_walk_mem(struct kexec_buf *kbuf, int (*func)(u64, u64, void *))
+{
+	int ret = 0;
+	u64 i;
+	phys_addr_t mstart, mend;
+
+	if (kbuf->top_down) {
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+						&mstart, &mend, NULL) {
+			/*
+			 * In memblock, end points to the first byte after the
+			 * range while in kexec, end points to the last byte
+			 * in the range.
+			 */
+			ret = func(mstart, mend - 1, kbuf);
+			if (ret)
+				break;
+		}
+	} else {
+		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
+					NULL) {
+			/*
+			 * In memblock, end points to the first byte after the
+			 * range while in kexec, end points to the last byte
+			 * in the range.
+			 */
+			ret = func(mstart, mend - 1, kbuf);
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
+ * contents, while Elf64_Shdr.sh_addr points to the final address of the
+ * section in memory.
+ */
+int arch_kexec_apply_relocations_add(const Elf64_Ehdr *ehdr,
+				     Elf64_Shdr *sechdrs, unsigned int relsec)
+{
+	unsigned int i;
+	int ret;
+	int reloc_type;
+	unsigned long *location;
+	unsigned long address;
+	unsigned long value;
+	const char *name;
+	Elf64_Sym *sym;
+	/* Section containing the relocation entries. */
+	Elf64_Shdr *rel_section = &sechdrs[relsec];
+	const Elf64_Rela *rela = (const Elf64_Rela *) rel_section->sh_offset;
+	/* Section to which relocations apply. */
+	Elf64_Shdr *target_section = &sechdrs[rel_section->sh_info];
+	/* Associated symbol table. */
+	Elf64_Shdr *symtabsec = &sechdrs[rel_section->sh_link];
+	void *syms_base = (void *) symtabsec->sh_offset;
+	void *loc_base = (void *) target_section->sh_offset;
+	Elf64_Addr addr_base = target_section->sh_addr;
+	unsigned long sec_base;
+	unsigned long r2;
+	unsigned int toc;
+	const char *strtab;
+
+	if (symtabsec->sh_link >= ehdr->e_shnum) {
+		/* Invalid strtab section number */
+		pr_err("Invalid string table section index %d\n",
+		       symtabsec->sh_link);
+		return -ENOEXEC;
+	}
+
+	toc = elf_toc_section(ehdr, sechdrs);
+	if (!toc) {
+		pr_err("Purgatory TOC section not found.");
+		return -ENOEXEC;
+	}
+
+	r2 = elf_my_r2(sechdrs, toc);
+
+	/* String table for the associated symbol table. */
+	strtab = (const char *) sechdrs[symtabsec->sh_link].sh_offset;
+
+	for (i = 0; i < rel_section->sh_size / sizeof(Elf64_Rela); i++) {
+		/*
+		 * rels[i].r_offset contains the byte offset from the beginning
+		 * of section to the storage unit affected.
+		 *
+		 * This is the location to update in the temporary buffer where
+		 * the section is currently loaded. The section will finally
+		 * be loaded to a different address later, pointed to by
+		 * addr_base.
+		 */
+		location = loc_base + rela[i].r_offset;
+
+		/* Final address of the location. */
+		address = addr_base + rela[i].r_offset;
+
+		/* This is the symbol the relocation is referring to. */
+		sym = (Elf64_Sym *) syms_base + ELF64_R_SYM(rela[i].r_info);
+
+		if (sym->st_name)
+			name = strtab + sym->st_name;
+		else
+			name = "<unnamed symbol>";
+
+		reloc_type = ELF64_R_TYPE(rela[i].r_info);
+
+		pr_debug("RELOC at %p: %i-type as %s (0x%lx) + %li\n",
+		       location, reloc_type, name, (unsigned long)sym->st_value,
+		       (long)rela[i].r_addend);
+
+		/*
+		 * TOC symbols appear as undefined but should be
+		 * resolved as well, so allow them to be processed.
+		 */
+		if (sym->st_shndx == SHN_UNDEF && strcmp(name, ".TOC.") != 0 &&
+				reloc_type != R_PPC64_TOC) {
+			pr_err("Undefined symbol: %s\n", name);
+			return -ENOEXEC;
+		} else if (sym->st_shndx == SHN_COMMON) {
+			pr_err("Symbol '%s' in common section.\n",
+			       name);
+			return -ENOEXEC;
+		}
+
+		if (sym->st_shndx != SHN_ABS) {
+			if (sym->st_shndx >= ehdr->e_shnum) {
+				pr_err("Invalid section %d for symbol %s\n",
+				       sym->st_shndx, name);
+				return -ENOEXEC;
+			}
+
+			sec_base = sechdrs[sym->st_shndx].sh_addr;
+		} else
+			sec_base = 0;
+
+		/* `Everything is relative'. */
+		value = sym->st_value + sec_base + rela[i].r_addend;
+
+		ret = elf64_apply_relocate_add_item(sechdrs, strtab, &rela[i],
+						    sym, location, address,
+						    value, r2,
+						    "kexec purgatory", NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 61baad036639..8307cf2f07bf 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -507,15 +507,12 @@ static int restore_r2(u32 *instruction, struct module *me)
 	return 1;
 }
 
-static int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs,
-					 const char *strtab,
-					 const Elf64_Rela *rela,
-					 const Elf64_Sym *sym,
-					 unsigned long *location,
-					 unsigned long value,
-					 unsigned long my_r2,
-					 const char *obj_name,
-					 struct module *me)
+int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs, const char *strtab,
+				  const Elf64_Rela *rela, const Elf64_Sym *sym,
+				  unsigned long *location,
+				  unsigned long address, unsigned long value,
+				  unsigned long my_r2, const char *obj_name,
+				  struct module *me)
 {
 	switch (ELF64_R_TYPE(rela->r_info)) {
 	case R_PPC64_ADDR32:
@@ -588,9 +585,32 @@ static int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs,
 			| (value & 0xffff);
 		break;
 
+	case R_PPC64_REL14:
+		/* Convert value to relative */
+		value -= address;
+		if (value + 0x8000 > 0xffff || (value & 3) != 0) {
+			pr_err("%s: REL14 %li out of range!\n",
+			       obj_name, (long int) value);
+			return -ENOEXEC;
+		}
+
+		/* Only replace bits 2 through 16 */
+		*(uint32_t *)location
+			= (*(uint32_t *)location & ~0xfffc)
+			| (value & 0xfffc);
+		break;
+
 	case R_PPC_REL24:
 		/* FIXME: Handle weak symbols here --RR */
 		if (sym->st_shndx == SHN_UNDEF) {
+			/*
+			 * The purgatory relocation code passes NULL for me,
+			 * but the purgatory doesn't have any REL24 relocations
+			 * for undefined symbols, so if this happens it's a bug.
+			 */
+			if (WARN_ON(!me))
+				return -ENOEXEC;
+
 			/* External: go via stub */
 			value = stub_for_addr(sechdrs, value, me);
 			if (!value)
@@ -603,7 +623,7 @@ static int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs,
 			value += local_entry_offset(sym);
 
 		/* Convert value to relative */
-		value -= (unsigned long)location;
+		value -= address;
 		if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0) {
 			pr_err("%s: REL24 %li out of range!\n",
 			       obj_name, (long int)value);
@@ -618,7 +638,7 @@ static int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs,
 
 	case R_PPC64_REL64:
 		/* 64 bits relative (used by features fixups) */
-		*location = value - (unsigned long)location;
+		*location = value - address;
 		break;
 
 	case R_PPC64_TOCSAVE:
@@ -634,7 +654,7 @@ static int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs,
 		 * Optimize ELFv2 large code model entry point if
 		 * the TOC is within 2GB range of current location.
 		 */
-		value = my_r2 - (unsigned long)location;
+		value = my_r2 - address;
 		if (value + 0x80008000 > 0xffffffff)
 			break;
 		/*
@@ -656,9 +676,27 @@ static int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs,
 		((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
 		break;
 
+	case R_PPC64_ADDR16_LO:
+		*(uint16_t *)location = value & 0xffff;
+		break;
+
+	case R_PPC64_ADDR16_HI:
+		*(uint16_t *)location = (value >> 16) & 0xffff;
+		break;
+
+	case R_PPC64_ADDR16_HIGHER:
+		*(uint16_t *)location = (((uint64_t)value >> 32) &
+						0xffff);
+		break;
+
+	case R_PPC64_ADDR16_HIGHEST:
+		*(uint16_t *)location = (((uint64_t)value >> 48) &
+						0xffff);
+		break;
+
 	case R_PPC64_REL16_HA:
 		/* Subtract location pointer */
-		value -= (unsigned long)location;
+		value -= address;
 		value = ((value + 0x8000) >> 16);
 		*((uint16_t *) location)
 			= (*((uint16_t *) location) & ~0xffff)
@@ -667,7 +705,7 @@ static int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs,
 
 	case R_PPC64_REL16_LO:
 		/* Subtract location pointer */
-		value -= (unsigned long)location;
+		value -= address;
 		*((uint16_t *) location)
 			= (*((uint16_t *) location) & ~0xffff)
 			| (value & 0xffff);
@@ -725,8 +763,9 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		value = sym->st_value + rela[i].r_addend;
 
 		ret = elf64_apply_relocate_add_item(sechdrs, strtab, &rela[i],
-						    sym, location, value,
-						    my_r2(sechdrs, me),
+						    sym, location,
+						    (unsigned long) location,
+						    value, my_r2(sechdrs, me),
 						    me->name, me);
 		if (ret)
 			return ret;
-- 
2.7.4
