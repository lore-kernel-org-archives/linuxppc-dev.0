Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7yBD3k73zDt1q
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 17:00:20 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA25wPvr076856
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 02:00:18 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26f8qfmxu8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 02:00:18 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 04:00:15 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 0FC1E1DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 02:00:12 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA260B2s31326388
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 04:00:11 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA260BVv026665
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 04:00:11 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, Baoquan He <bhe@redhat.com>,
 Dave Young <dyoung@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Vivek Goyal <vgoyal@redhat.com>
Subject: [RFC]  kexec_file: Add support for purgatory built as PIE
Date: Wed, 02 Nov 2016 04:00:09 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <3476672.cGrsQmUQKg@morokweng>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

The kexec_file code currently builds the purgatory as a partially linked object 
(using ld -r). Is there a particular reason to use that instead of a position 
independent executable (PIE)?

I found a discussion from 2013 in the archives but from what I understood it 
was about the purgatory as a separate object vs having it linked into the 
kernel, which is different from what I'm asking:

http://lists.infradead.org/pipermail/kexec/2013-December/010535.html

Here is my motivation for this question:

 On ppc64 purgatory.ro has 12 relocation types when built as a partially 
linked object. This makes arch_kexec_apply_relocations_add duplicate a lot of 
code with module_64.c:apply_relocate_add to implement these relocations. The 
alternative is to do some refactoring so that both functions can share the 
implementation of the relocations. This is done in patches 5 and 6 of the 
kexec_file_load implementation for powerpc:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-October/149984.html

Michael Ellerman would prefer if module_64.c didn't need to be changed, and 
suggested that the purgatory could be a position independent executable. 
Indeed, in that case there are only 4 relocation types in purgatory.ro (which 
aren't even implemented in module_64.c:apply_relocate_add), so the relocation 
code for the purgatory can leave that file alone and have its own relocation 
implementation.

Also, the purgatory is an executable and not an intermediary output from the 
compiler, so in my mind it makes sense conceptually that it is easier to build 
it as a PIE than as a partially linked object.

The patch below adds the support needed in kexec_file.c to allow powerpc-
specific code to load and relocate a purgatory binary built as PIE. This is WIP 
and can probably be refined a bit. Would you accept a change along these lines?

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/Kconfig            |   3 +
 kernel/kexec_file.c     | 159 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/kexec_internal.h |  26 ++++++++
 3 files changed, 183 insertions(+), 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 659bdd079277..7fd6879be222 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -5,6 +5,9 @@
 config KEXEC_CORE
 	bool
 
+config HAVE_KEXEC_FILE_PIE_PURGATORY
+	bool
+
 config OPROFILE
 	tristate "OProfile system profiling"
 	depends on PROFILING
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0c2df7f73792..dfc3e015160d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -633,7 +633,149 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	return ret;
 }
 
-/* Actually load purgatory. Lot of code taken from kexec-tools */
+#ifdef CONFIG_HAVE_KEXEC_FILE_PIE_PURGATORY
+/* Load PIE purgatory using the program header information. */
+static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
+				  unsigned long max, int top_down)
+{
+	struct purgatory_info *pi = &image->purgatory_info;
+	unsigned long first_offset;
+	unsigned long orig_load_addr = 0;
+	const void *src;
+	int i, ret;
+	const Elf_Phdr *phdrs = (const void *) pi->ehdr + pi->ehdr->e_phoff;
+	const Elf_Phdr *phdr;
+	const Elf_Shdr *sechdrs_c;
+	Elf_Shdr *sechdr;
+	Elf_Shdr *sechdrs = NULL;
+	struct kexec_buf kbuf = { .image = image, .bufsz = 0, .buf_align = 1,
+				  .buf_min = min, .buf_max = max,
+				  .top_down = top_down };
+
+	/*
+	 * sechdrs_c points to section headers in purgatory and are read
+	 * only. No modifications allowed.
+	 */
+	sechdrs_c = (void *) pi->ehdr + pi->ehdr->e_shoff;
+
+	/*
+	 * We can not modify sechdrs_c[] and its fields. It is read only.
+	 * Copy it over to a local copy where one can store some temporary
+	 * data and free it at the end. We need to modify ->sh_addr and
+	 * ->sh_offset fields to keep track of permanent and temporary
+	 * locations of sections.
+	 */
+	sechdrs = vzalloc(pi->ehdr->e_shnum * sizeof(Elf_Shdr));
+	if (!sechdrs)
+		return -ENOMEM;
+
+	memcpy(sechdrs, sechdrs_c, pi->ehdr->e_shnum * sizeof(Elf_Shdr));
+
+	/*
+	 * We seem to have multiple copies of sections. First copy is which
+	 * is embedded in kernel in read only section. Some of these sections
+	 * will be copied to a temporary buffer and relocated. And these
+	 * sections will finally be copied to their final destination at
+	 * segment load time.
+	 *
+	 * Use ->sh_offset to reflect section address in memory. It will
+	 * point to original read only copy if section is not allocatable.
+	 * Otherwise it will point to temporary copy which will be relocated.
+	 *
+	 * Use ->sh_addr to contain final address of the section where it
+	 * will go during execution time.
+	 */
+	for (sechdr = sechdrs; sechdr < sechdrs + pi->ehdr->e_shnum; sechdr++) {
+		if (sechdr->sh_type == SHT_NOBITS)
+			continue;
+
+		sechdr->sh_offset = (unsigned long) pi->ehdr + sechdr->sh_offset;
+	}
+
+	/* Determine how much memory is needed to load the executable. */
+	for (phdr = phdrs; phdr < phdrs + pi->ehdr->e_phnum; phdr++) {
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		if (!orig_load_addr) {
+			orig_load_addr = phdr->p_vaddr - phdr->p_offset;
+			kbuf.bufsz = first_offset = phdr->p_offset;
+		}
+
+		if (kbuf.buf_align < phdr->p_align) {
+			pr_debug("buf_align was %lx, now is %llx\n",
+				 kbuf.buf_align, phdr->p_align);
+			kbuf.buf_align = phdr->p_align;
+		}
+
+		kbuf.bufsz += phdr->p_memsz;
+	}
+
+	/* Allocate buffer for purgatory. */
+	kbuf.buffer = vzalloc(kbuf.bufsz);
+	if (!kbuf.buffer) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Add buffer to segment list. */
+	kbuf.memsz = kbuf.bufsz;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		goto out;
+
+	pi->purgatory_load_addr = kbuf.mem;
+
+	/* Load executable. */
+	for (phdr = phdrs; phdr < phdrs + pi->ehdr->e_phnum; phdr++) {
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		src = (const void *) pi->ehdr + phdr->p_offset;
+		memcpy(kbuf.buffer + phdr->p_offset, src, phdr->p_filesz);
+
+		pr_debug("loaded segment of size %llx at %llx (base = %lx, offset = %llx)\n",
+			 phdr->p_memsz, pi->purgatory_load_addr + phdr->p_offset, pi->purgatory_load_addr, phdr->p_offset);
+
+		/*
+		 * Find sections within this segment and update their
+		 * ->sh_offset to point to within the buffer.
+		 */
+		for (i = 0; i < pi->ehdr->e_shnum; i++) {
+			if (sechdrs[i].sh_addr >= phdr->p_vaddr &&
+			    sechdrs[i].sh_addr + sechdrs[i].sh_size <= phdr->p_vaddr + phdr->p_memsz) {
+				sechdrs[i].sh_addr = sechdrs[i].sh_addr - orig_load_addr + pi->purgatory_load_addr;
+				sechdrs[i].sh_offset = (unsigned long long) kbuf.buffer + sechdrs_c[i].sh_offset;
+			}
+		}
+	}
+
+	/* Make kernel jump to purgatory after shutdown */
+	image->start = pi->ehdr->e_entry - orig_load_addr + pi->purgatory_load_addr;
+
+	/* Used later to get/set symbol values */
+	pi->sechdrs = sechdrs;
+
+	/*
+	 * Used later to identify which section is purgatory and skip it
+	 * from checksumming.
+	 */
+	pi->purgatory_buf = kbuf.buffer;
+
+	pr_debug("purgatory entry point at %lx\n", image->start);
+
+	return 0;
+out:
+	vfree(sechdrs);
+	vfree(kbuf.buffer);
+
+	return ret;
+}
+#else /* CONFIG_HAVE_KEXEC_FILE_PIE_PURGATORY */
+/*
+ * Load relocatable object purgatory using the section header information.
+ * A lot of code taken from kexec-tools.
+ */
 static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 				  unsigned long max, int top_down)
 {
@@ -813,6 +955,7 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	vfree(kbuf.buffer);
 	return ret;
 }
+#endif /* CONFIG_HAVE_KEXEC_FILE_PIE_PURGATORY */
 
 static int kexec_apply_relocations(struct kimage *image)
 {
@@ -886,7 +1029,7 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	pi->ehdr = (Elf_Ehdr *)kexec_purgatory;
 
 	if (memcmp(pi->ehdr->e_ident, ELFMAG, SELFMAG) != 0
-	    || pi->ehdr->e_type != ET_REL
+	    || pi->ehdr->e_type != PURGATORY_ELF_TYPE
 	    || !elf_check_arch(pi->ehdr)
 	    || pi->ehdr->e_shentsize != sizeof(Elf_Shdr))
 		return -ENOEXEC;
@@ -942,7 +1085,13 @@ static Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 
 		/* Go through symbols for a match */
 		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
-			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
+			/*
+			 * FIXME: See if we can or should export the .TOC.
+			 * symbol as global instead of searching local symbols
+			 * here.
+			 */
+			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL &&
+			    ELF_ST_BIND(syms[k].st_info) != STB_LOCAL)
 				continue;
 
 			if (strcmp(strtab + syms[k].st_name, name) != 0)
@@ -979,7 +1128,7 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
 	 * Returns the address where symbol will finally be loaded after
 	 * kexec_load_segment()
 	 */
-	return (void *)(sechdr->sh_addr + sym->st_value);
+	return (void *)(sechdr->sh_addr + sym_value_offset(pi, sym));
 }
 
 /*
@@ -1013,7 +1162,7 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	}
 
 	sym_buf = (unsigned char *)sechdrs[sym->st_shndx].sh_offset +
-					sym->st_value;
+					sym_value_offset(pi, sym);
 
 	if (get_value)
 		memcpy((void *)buf, sym_buf, size);
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 4cef7e4706b0..c253b00f88d0 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -20,6 +20,32 @@ struct kexec_sha_region {
 	unsigned long len;
 };
 
+#ifdef CONFIG_HAVE_KEXEC_FILE_PIE_PURGATORY
+#define PURGATORY_ELF_TYPE ET_EXEC
+
+/*
+ * In position-independent executables, the symbol value is an absolute address,
+ * so convert it to a section-relative offset.
+ */
+static inline Elf_Addr sym_value_offset(struct purgatory_info *pi, Elf_Sym *sym)
+{
+	const Elf_Shdr *sechdrs_c = (const void *) pi->ehdr + pi->ehdr->e_shoff;
+
+	return sym->st_value - sechdrs_c[sym->st_shndx].sh_addr;
+}
+#else
+#define PURGATORY_ELF_TYPE ET_REL
+
+/*
+ * In a relocatable object, the symbol value already is a section-relative
+ * offset.
+ */
+static inline Elf_Addr sym_value_offset(struct purgatory_info *pi, Elf_Sym *sym)
+{
+	return sym->st_value;
+}
+#endif
+
 void kimage_file_post_load_cleanup(struct kimage *image);
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
-- 
2.7.4
