Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sGL5Z2YlbzDr68
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Aug 2016 10:18:10 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7K0DrtB113596
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 20:18:07 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wqk677se-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 20:18:07 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 21:18:05 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 4E82B352005F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 20:17:42 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7K0I3Ge34144730
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 21:18:03 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7K0I20S005347
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 21:18:03 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Josh Sklar <sklar@linux.vnet.ibm.com>
Subject: [PATCH v6 08/12] powerpc: Implement kexec_file_load.
Date: Fri, 19 Aug 2016 21:17:18 -0300
In-Reply-To: <1471652242-14436-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1471652242-14436-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1471652242-14436-9-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch_kexec_walk_mem and arch_kexec_apply_relocations_add are used by
generic kexec code, while setup_purgatory is powerpc-specific and sets
runtime variables needed by the powerpc purgatory implementation.

Signed-off-by: Josh Sklar <sklar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                   |  13 ++
 arch/powerpc/include/asm/kexec.h       |   7 +
 arch/powerpc/include/asm/systbl.h      |   1 +
 arch/powerpc/include/asm/unistd.h      |   2 +-
 arch/powerpc/include/uapi/asm/unistd.h |   1 +
 arch/powerpc/kernel/Makefile           |   4 +-
 arch/powerpc/kernel/machine_kexec_64.c | 252 +++++++++++++++++++++++++++++++++
 7 files changed, 278 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ec4047e170a0..ff362ca60d1b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -459,6 +459,19 @@ config KEXEC
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
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index a46f5f45570c..83b81b7bdca1 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -91,6 +91,13 @@ static inline bool kdump_in_progress(void)
 	return crashing_cpu >= 0;
 }
 
+#ifdef CONFIG_KEXEC_FILE
+int setup_purgatory(struct kimage *image, const void *slave_code,
+		    const void *fdt, unsigned long kernel_load_addr,
+		    unsigned long fdt_load_addr, unsigned long stack_top,
+		    int debug);
+#endif /* CONFIG_KEXEC_FILE */
+
 #else /* !CONFIG_KEXEC */
 static inline void crash_kexec_secondary(struct pt_regs *regs) { }
 
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
index 6159ec6ac032..ce18a985bcfc 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -123,9 +123,11 @@ ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
 obj-y				+= iomap.o
 endif
 
-ifeq ($(CONFIG_MODULES)$(CONFIG_WORD_SIZE),y64)
+ifneq ($(CONFIG_MODULES)$(CONFIG_KEXEC_FILE),)
+ifeq ($(CONFIG_WORD_SIZE),64)
 obj-y				+= elf_util.o elf_util_64.o
 endif
+endif
 
 obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)	+= tm.o
 
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 4c780a342282..1e678dc5096a 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -18,6 +18,8 @@
 #include <linux/kernel.h>
 #include <linux/cpu.h>
 #include <linux/hardirq.h>
+#include <linux/memblock.h>
+#include <linux/libfdt.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -31,6 +33,12 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/asm-prototypes.h>
 
+#define SLAVE_CODE_SIZE		256
+
+#ifdef CONFIG_KEXEC_FILE
+static struct kexec_file_ops *kexec_file_loaders[] = { };
+#endif
+
 #ifdef CONFIG_PPC_BOOK3E
 int default_machine_kexec_prepare(struct kimage *image)
 {
@@ -432,3 +440,247 @@ static int __init export_htab_values(void)
 }
 late_initcall(export_htab_values);
 #endif /* CONFIG_PPC_STD_MMU_64 */
+
+#ifdef CONFIG_KEXEC_FILE
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
+ * arch_kexec_walk_mem() - call func(data) for each unreserved memory block
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
+ * arch_kexec_apply_relocations_add() - apply purgatory relocations
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
+
+/**
+ * setup_purgatory() - setup the purgatory runtime variables
+ * @image:		kexec image.
+ * @slave_code:		Slave code for the purgatory.
+ * @fdt:		Flattened device tree for the next kernel.
+ * @kernel_load_addr:	Address where the kernel is loaded.
+ * @fdt_load_addr:	Address where the flattened device tree is loaded.
+ * @stack_top:		Address where the purgatory can place its stack.
+ * @debug:		Can the purgatory print messages to the console?
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int setup_purgatory(struct kimage *image, const void *slave_code,
+		    const void *fdt, unsigned long kernel_load_addr,
+		    unsigned long fdt_load_addr, unsigned long stack_top,
+		    int debug)
+{
+	int ret, tree_node;
+	const void *prop;
+	unsigned long opal_base, opal_entry;
+	uint64_t toc;
+	unsigned int *slave_code_buf, master_entry;
+	struct elf_info purg_info;
+
+	slave_code_buf = kmalloc(SLAVE_CODE_SIZE, GFP_KERNEL);
+	if (!slave_code_buf)
+		return -ENOMEM;
+
+	/* Get the slave code from the new kernel and put it in purgatory. */
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_start",
+					     slave_code_buf, SLAVE_CODE_SIZE,
+					     true);
+	if (ret) {
+		kfree(slave_code_buf);
+		return ret;
+	}
+
+	master_entry = slave_code_buf[0];
+	memcpy(slave_code_buf, slave_code, SLAVE_CODE_SIZE);
+	slave_code_buf[0] = master_entry;
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_start",
+					     slave_code_buf, SLAVE_CODE_SIZE,
+					     false);
+	kfree(slave_code_buf);
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
+
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
+#endif /* CONFIG_KEXEC_FILE */
-- 
1.9.1
