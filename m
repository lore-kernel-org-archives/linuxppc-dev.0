Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDpSD5b7GzDvgs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 14:29:16 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAA3SVus095383
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2016 22:29:15 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26mfh95h82-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 22:29:15 -0500
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 10 Nov 2016 01:29:12 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 293D53520068
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 22:28:41 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAA3T9qk39256090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 01:29:09 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAA3T80c020532
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 01:29:09 -0200
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
Subject: [PATCH v10 06/10] powerpc: Implement kexec_file_load.
Date: Thu, 10 Nov 2016 01:27:25 -0200
In-Reply-To: <1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1478748449-3894-7-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add arch-specific functions needed by the generic kexec_file code.

Signed-off-by: Josh Sklar <sklar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                        |  14 ++
 arch/powerpc/include/asm/systbl.h           |   1 +
 arch/powerpc/include/asm/unistd.h           |   2 +-
 arch/powerpc/include/uapi/asm/unistd.h      |   1 +
 arch/powerpc/kernel/Makefile                |   1 +
 arch/powerpc/kernel/machine_kexec_file_64.c | 301 ++++++++++++++++++++++++++++
 6 files changed, 319 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6cb59c6e5ba4..a5a7bcf30c05 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -455,6 +455,20 @@ config KEXEC
 	  interface is strongly in flux, so no good recommendation can be
 	  made.
 
+config KEXEC_FILE
+	bool "kexec file based system call"
+	select KEXEC_CORE
+	select HAVE_KEXEC_FILE_PIE_PURGATORY
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
index 22534a56c914..6de731d90bff 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_PCI)		+= pci_$(BITS).o $(pci64-y) \
 obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o crash.o \
 				   machine_kexec_$(BITS).o
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file_$(BITS).o
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
new file mode 100644
index 000000000000..172f6f736987
--- /dev/null
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -0,0 +1,301 @@
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
+	unsigned long reloc_type;
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
+	Elf64_Addr orig_addr_base;
+	const Elf_Phdr *phdrs = (const void *) ehdr + ehdr->e_phoff;
+	const Elf_Phdr *phdr;
+	unsigned long sec_base;
+	unsigned long purgatory_load_addr;
+	unsigned long orig_load_addr;
+	const char *strtab;
+	const char *shstrtab;
+	const Elf_Shdr *sechdrs_c;
+
+	if (symtabsec->sh_link >= ehdr->e_shnum) {
+		/* Invalid strtab section number */
+		pr_err("Invalid string table section index %d\n",
+		       symtabsec->sh_link);
+		return -ENOEXEC;
+	}
+
+	/*
+	 * The original section header was modified by __kexec_load_purgatory
+	 * so that the ->sh_addr and ->sh_offset fields point to the permanent
+	 * and temporary locations of sections.
+	 */
+	sechdrs_c = (const void *) ehdr + ehdr->e_shoff;
+	orig_addr_base = sechdrs_c[rel_section->sh_info].sh_addr;
+
+	/* Find the address where the purgatory was built to be loaded in. */
+	for (phdr = phdrs; phdr < phdrs + ehdr->e_phnum; phdr++) {
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		orig_load_addr = phdr->p_paddr - phdr->p_offset;
+		break;
+	}
+
+	/*
+	 * Find the address where we will load the purgatory.
+	 * This is simply the reverse of the calculation done when modifying
+	 * ->sh_addr in __kexec_really_load_purgatory.
+	 */
+	purgatory_load_addr = addr_base - orig_addr_base + orig_load_addr;
+
+	/* String table for the associated symbol table. */
+	strtab = (const char *) sechdrs[symtabsec->sh_link].sh_offset;
+
+	/* Section header string table. */
+	shstrtab = (const char *) sechdrs[ehdr->e_shstrndx].sh_offset;
+
+	for (i = 0; i < rel_section->sh_size / sizeof(Elf64_Rela); i++) {
+		Elf64_Addr r_offset = rela[i].r_offset - orig_addr_base;
+		long addend = rela[i].r_addend;
+		Elf64_Addr orig_sec_base;
+
+		/*
+		 * rels[i].r_offset contains the byte offset from the beginning
+		 * of section to the storage unit affected.
+		 *
+		 * This is the location to update in the temporary buffer where
+		 * the section is currently loaded. The section will finally
+		 * be loaded to a different address later, pointed to by
+		 * addr_base.
+		 */
+		location = loc_base + r_offset;
+
+		/* Final address of the location. */
+		address = addr_base + r_offset;
+
+		/* This is the symbol the relocation is referring to. */
+		sym = (Elf64_Sym *) syms_base + ELF64_R_SYM(rela[i].r_info);
+		orig_sec_base = sechdrs_c[sym->st_shndx].sh_addr;
+
+		if (sym->st_name)
+			name = strtab + sym->st_name;
+		else if (sym->st_value == orig_sec_base)
+			name = &shstrtab[sechdrs[sym->st_shndx].sh_name];
+		else
+			name = "<unnamed symbol>";
+
+		reloc_type = ELF64_R_TYPE(rela[i].r_info);
+
+		pr_debug("RELOC at %p: %lu-type as %s (0x%lx) + %li\n",
+		       location, reloc_type, name, (unsigned long)sym->st_value,
+		       (long)rela[i].r_addend);
+
+		if ((void *) location >= loc_base + target_section->sh_size) {
+			pr_err("Location %p is %llx bytes beyond the end of the section.\n",
+			       location, (void *) location - loc_base +
+						target_section->sh_size - 1);
+			return -ENOEXEC;
+		}
+
+		/*
+		 * Function descriptor symbols appear as undefined but
+		 * should be resolved as well, so allow them to be processed.
+		 */
+		if (sym->st_shndx == SHN_UNDEF &&
+				reloc_type != R_PPC64_RELATIVE) {
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
+			sec_base = orig_sec_base = 0;
+
+		/* `Everything is relative'. */
+		value = sym->st_value - orig_sec_base + sec_base + addend;
+
+		switch (reloc_type) {
+		case R_PPC64_ADDR16_LO:
+			*(uint16_t *) location = value & 0xffff;
+			break;
+
+		case R_PPC64_ADDR16_HI:
+			*(uint16_t *) location = (value >> 16) & 0xffff;
+			break;
+
+		case R_PPC64_ADDR16_HIGHER:
+			*(uint16_t *) location = (((uint64_t) value >> 32) &
+						  0xffff);
+			break;
+
+		case R_PPC64_ADDR16_HIGHEST:
+			*(uint16_t *) location = (((uint64_t) value >> 48) &
+						  0xffff);
+			break;
+		case R_PPC64_RELATIVE:
+			*location = purgatory_load_addr + addend - orig_load_addr;
+			break;
+		default:
+			pr_err("kexec purgatory: Unknown ADD relocation: %lu\n",
+			       reloc_type);
+			return -ENOEXEC;
+		}
+	}
+
+	return 0;
+}
-- 
2.7.4
