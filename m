Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDpRk4gnRzDvh1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 14:28:50 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAA3SVM7029243
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2016 22:28:48 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26m8m3uh3e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 22:28:48 -0500
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 10 Nov 2016 01:28:46 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id AC4023520078
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 22:28:14 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAA3Sgv333948158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 01:28:42 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAA3SfxZ020205
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 01:28:42 -0200
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
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v10 04/10] kexec_file: Add support for purgatory built as PIE.
Date: Thu, 10 Nov 2016 01:27:23 -0200
In-Reply-To: <1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1478748449-3894-5-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc's purgatory.ro has 12 relocation types when built as
a relocatable object. To implement support for them requires
arch_kexec_apply_relocations_add to duplicate a lot of code with
module_64.c:apply_relocate_add.

When built as a Position Independent Executable there are only 4
relocation types in purgatory.ro, so it becomes practical for the powerpc
implementation of kexec_file to have its own relocation implementation.

Also, the purgatory is an executable and not an intermediary output from
the compiler so it makes sense conceptually that it is easier to build
it as a PIE than as a partially linked object.

Apart from the greatly reduced number of relocations, there are two
differences between a relocatable object and a PIE:

1. __kexec_load_purgatory needs to use the program headers rather than the
   section headers to figure out how to load the binary.
2. Symbol values are absolute addresses instead of relative to the
   start of the section.

This patch adds the support needed in generic code for the differences
above and allows powerpc to load and relocate a position independent
purgatory.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/Kconfig          |  11 ++
 include/linux/kexec.h |   4 +
 kernel/kexec_file.c   | 314 ++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 253 insertions(+), 76 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 659bdd079277..f4498530a618 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -5,6 +5,17 @@
 config KEXEC_CORE
 	bool
 
+config HAVE_KEXEC_FILE_PIE_PURGATORY
+	bool
+	help
+	  By default, the purgatory binary is built as a relocatable
+	  object, but on some architectures it might be an advantage
+	  to build it as a Position Independent Executable to reduce
+	  the types of relocation that have to be dealt with.
+
+	  If an architecture builds a PIE purgatory it should select
+	  this symbol.
+
 config OPROFILE
 	tristate "OProfile system profiling"
 	depends on PROFILING
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index a33f63351f86..5c356e387240 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -112,6 +112,10 @@ struct compat_kexec_segment {
 #endif
 
 #ifdef CONFIG_KEXEC_FILE
+#ifndef PURGATORY_ELF_TYPE
+#define PURGATORY_ELF_TYPE ET_REL
+#endif
+
 struct purgatory_info {
 	/* Pointer to elf header of read only purgatory */
 	Elf_Ehdr *ehdr;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0c2df7f73792..cf8c17111b12 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -633,68 +633,139 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	return ret;
 }
 
-/* Actually load purgatory. Lot of code taken from kexec-tools */
-static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
-				  unsigned long max, int top_down)
+#ifdef CONFIG_HAVE_KEXEC_FILE_PIE_PURGATORY
+/*
+ * Load position independent executable purgatory using program header
+ * information.
+ */
+static int __kexec_really_load_purgatory(const Elf_Ehdr *ehdr,
+					 Elf_Shdr *sechdrs,
+					 struct kexec_buf *kbuf,
+					 unsigned long *entry_addr)
 {
-	struct purgatory_info *pi = &image->purgatory_info;
-	unsigned long align, bss_align, bss_sz, bss_pad;
-	unsigned long entry, load_addr, curr_load_addr, bss_addr, offset;
-	unsigned char *buf_addr, *src;
-	int i, ret = 0, entry_sidx = -1;
-	const Elf_Shdr *sechdrs_c;
-	Elf_Shdr *sechdrs = NULL;
-	struct kexec_buf kbuf = { .image = image, .bufsz = 0, .buf_align = 1,
-				  .buf_min = min, .buf_max = max,
-				  .top_down = top_down };
+	int ret;
+	unsigned long entry, dst_mem;
+	void *dst;
+	const Elf_Phdr *phdr, *first_load_seg = NULL, *last_load_seg = NULL;
+	const Elf_Phdr *prev_load_seg;
+	const Elf_Phdr *phdrs = (const void *) ehdr + ehdr->e_phoff;
+
+	/* Determine how much memory is needed to load the executable. */
+	for (phdr = phdrs; phdr < phdrs + ehdr->e_phnum; phdr++) {
+		if (phdr->p_type != PT_LOAD)
+			continue;
 
-	/*
-	 * sechdrs_c points to section headers in purgatory and are read
-	 * only. No modifications allowed.
-	 */
-	sechdrs_c = (void *)pi->ehdr + pi->ehdr->e_shoff;
+		if (!first_load_seg)
+			first_load_seg = phdr;
 
-	/*
-	 * We can not modify sechdrs_c[] and its fields. It is read only.
-	 * Copy it over to a local copy where one can store some temporary
-	 * data and free it at the end. We need to modify ->sh_addr and
-	 * ->sh_offset fields to keep track of permanent and temporary
-	 * locations of sections.
-	 */
-	sechdrs = vzalloc(pi->ehdr->e_shnum * sizeof(Elf_Shdr));
-	if (!sechdrs)
-		return -ENOMEM;
+		if (kbuf->buf_align < phdr->p_align)
+			kbuf->buf_align = phdr->p_align;
 
-	memcpy(sechdrs, sechdrs_c, pi->ehdr->e_shnum * sizeof(Elf_Shdr));
+		last_load_seg = phdr;
+	}
 
-	/*
-	 * We seem to have multiple copies of sections. First copy is which
-	 * is embedded in kernel in read only section. Some of these sections
-	 * will be copied to a temporary buffer and relocated. And these
-	 * sections will finally be copied to their final destination at
-	 * segment load time.
-	 *
-	 * Use ->sh_offset to reflect section address in memory. It will
-	 * point to original read only copy if section is not allocatable.
-	 * Otherwise it will point to temporary copy which will be relocated.
-	 *
-	 * Use ->sh_addr to contain final address of the section where it
-	 * will go during execution time.
-	 */
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		if (sechdrs[i].sh_type == SHT_NOBITS)
+	kbuf->memsz = kbuf->bufsz = last_load_seg->p_paddr +
+					    last_load_seg->p_memsz -
+					    first_load_seg->p_paddr +
+					    first_load_seg->p_offset;
+
+	/* Allocate buffer for purgatory. */
+	kbuf->buffer = vzalloc(kbuf->bufsz);
+	if (!kbuf->buffer) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Add buffer to segment list. */
+	ret = kexec_add_buffer(kbuf);
+	if (ret)
+		goto out;
+
+	/* Load executable. */
+	prev_load_seg = NULL;
+	entry = ehdr->e_entry;
+	dst = kbuf->buffer;
+	dst_mem = kbuf->mem;
+	for (phdr = phdrs; phdr < phdrs + ehdr->e_phnum; phdr++) {
+		const void *src;
+		int i;
+		unsigned long p_offset;
+
+		if (phdr->p_type != PT_LOAD)
 			continue;
 
-		sechdrs[i].sh_offset = (unsigned long)pi->ehdr +
-						sechdrs[i].sh_offset;
+		if (!prev_load_seg)
+			p_offset = phdr->p_offset;
+		else
+			p_offset = phdr->p_paddr - prev_load_seg->p_paddr;
+
+		src = (const void *) ehdr + phdr->p_offset;
+		dst += p_offset;
+		dst_mem += p_offset;
+		memcpy(dst, src, phdr->p_filesz);
+
+		/*
+		 * If the entry point is in this segment, find its final
+		 * location in memory.
+		 */
+		if (entry >= phdr->p_paddr &&
+		    entry < phdr->p_paddr + phdr->p_memsz)
+			entry = dst_mem + entry - phdr->p_paddr;
+
+		/*
+		 * Find sections within this segment and update their
+		 * ->sh_offset to point to within the buffer.
+		 */
+		for (i = 0; i < ehdr->e_shnum; i++) {
+			Elf_Shdr *sechdr = &sechdrs[i];
+			Elf_Addr start = sechdr->sh_addr;
+			Elf_Addr size = sechdr->sh_size;
+
+			if (!(sechdr->sh_flags & SHF_ALLOC))
+				continue;
+
+			if (start >= phdr->p_paddr &&
+			    start + size <= phdr->p_paddr + phdr->p_memsz) {
+				unsigned long s_offset = start - phdr->p_paddr;
+				void *p = dst + s_offset;
+
+				sechdr->sh_addr = dst_mem + s_offset;
+				sechdr->sh_offset = (unsigned long long) p;
+			}
+		}
+
+		prev_load_seg = phdr;
 	}
 
+	*entry_addr = entry;
+
+	return 0;
+out:
+	vfree(kbuf->buffer);
+
+	return ret;
+}
+#else /* CONFIG_HAVE_KEXEC_FILE_PIE_PURGATORY */
+/*
+ * Load relocatable object purgatory using the section header information.
+ * A lot of code taken from kexec-tools.
+ */
+static int __kexec_really_load_purgatory(const Elf_Ehdr *ehdr,
+					 Elf_Shdr *sechdrs,
+					 struct kexec_buf *kbuf,
+					 unsigned long *entry_addr)
+{
+	unsigned long align, bss_align, bss_sz, bss_pad;
+	unsigned long entry, load_addr, curr_load_addr, bss_addr, offset;
+	unsigned char *buf_addr, *src;
+	int i, ret, entry_sidx = -1;
+
 	/*
 	 * Identify entry point section and make entry relative to section
 	 * start.
 	 */
-	entry = pi->ehdr->e_entry;
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
+	entry = ehdr->e_entry;
+	for (i = 0; i < ehdr->e_shnum; i++) {
 		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
 
@@ -702,9 +773,9 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 			continue;
 
 		/* Make entry section relative */
-		if (sechdrs[i].sh_addr <= pi->ehdr->e_entry &&
+		if (sechdrs[i].sh_addr <= ehdr->e_entry &&
 		    ((sechdrs[i].sh_addr + sechdrs[i].sh_size) >
-		     pi->ehdr->e_entry)) {
+		     ehdr->e_entry)) {
 			entry_sidx = i;
 			entry -= sechdrs[i].sh_addr;
 			break;
@@ -715,16 +786,16 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	bss_align = 1;
 	bss_sz = 0;
 
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
+	for (i = 0; i < ehdr->e_shnum; i++) {
 		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
 
 		align = sechdrs[i].sh_addralign;
 		if (sechdrs[i].sh_type != SHT_NOBITS) {
-			if (kbuf.buf_align < align)
-				kbuf.buf_align = align;
-			kbuf.bufsz = ALIGN(kbuf.bufsz, align);
-			kbuf.bufsz += sechdrs[i].sh_size;
+			if (kbuf->buf_align < align)
+				kbuf->buf_align = align;
+			kbuf->bufsz = ALIGN(kbuf->bufsz, align);
+			kbuf->bufsz += sechdrs[i].sh_size;
 		} else {
 			/* bss section */
 			if (bss_align < align)
@@ -736,33 +807,32 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 
 	/* Determine the bss padding required to align bss properly */
 	bss_pad = 0;
-	if (kbuf.bufsz & (bss_align - 1))
-		bss_pad = bss_align - (kbuf.bufsz & (bss_align - 1));
+	if (kbuf->bufsz & (bss_align - 1))
+		bss_pad = bss_align - (kbuf->bufsz & (bss_align - 1));
 
-	kbuf.memsz = kbuf.bufsz + bss_pad + bss_sz;
+	kbuf->memsz = kbuf->bufsz + bss_pad + bss_sz;
 
 	/* Allocate buffer for purgatory */
-	kbuf.buffer = vzalloc(kbuf.bufsz);
-	if (!kbuf.buffer) {
+	kbuf->buffer = vzalloc(kbuf->bufsz);
+	if (!kbuf->buffer) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	if (kbuf.buf_align < bss_align)
-		kbuf.buf_align = bss_align;
+	if (kbuf->buf_align < bss_align)
+		kbuf->buf_align = bss_align;
 
 	/* Add buffer to segment list */
-	ret = kexec_add_buffer(&kbuf);
+	ret = kexec_add_buffer(kbuf);
 	if (ret)
 		goto out;
-	pi->purgatory_load_addr = kbuf.mem;
 
 	/* Load SHF_ALLOC sections */
-	buf_addr = kbuf.buffer;
-	load_addr = curr_load_addr = pi->purgatory_load_addr;
-	bss_addr = load_addr + kbuf.bufsz + bss_pad;
+	buf_addr = kbuf->buffer;
+	load_addr = curr_load_addr = kbuf->mem;
+	bss_addr = load_addr + kbuf->bufsz + bss_pad;
 
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
+	for (i = 0; i < ehdr->e_shnum; i++) {
 		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
 
@@ -796,8 +866,76 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	if (entry_sidx >= 0)
 		entry += sechdrs[entry_sidx].sh_addr;
 
-	/* Make kernel jump to purgatory after shutdown */
-	image->start = entry;
+	*entry_addr = entry;
+
+	return 0;
+out:
+	vfree(kbuf->buffer);
+
+	return ret;
+}
+#endif /* CONFIG_HAVE_KEXEC_FILE_PIE_PURGATORY */
+
+/*
+ * Adjust the section headers to point to the temporary copy of their contents
+ * and load the purgatory binary.
+ */
+static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
+				  unsigned long max, int top_down)
+{
+	struct purgatory_info *pi = &image->purgatory_info;
+	const Elf_Shdr *sechdrs_c;
+	Elf_Shdr *sechdrs;
+	int i, ret;
+	struct kexec_buf kbuf = { .image = image, .buf_align = 1,
+				  .buf_min = min, .buf_max = max,
+				  .top_down = top_down };
+
+	/*
+	 * sechdrs_c points to section headers in purgatory and are read
+	 * only. No modifications allowed.
+	 */
+	sechdrs_c = (void *)pi->ehdr + pi->ehdr->e_shoff;
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
+	for (i = 0; i < pi->ehdr->e_shnum; i++) {
+		if (sechdrs[i].sh_type == SHT_NOBITS)
+			continue;
+
+		sechdrs[i].sh_offset = (unsigned long)pi->ehdr +
+						sechdrs[i].sh_offset;
+	}
+
+	ret = __kexec_really_load_purgatory(pi->ehdr, sechdrs, &kbuf,
+					    &image->start);
+	if (ret)
+		goto out;
 
 	/* Used later to get/set symbol values */
 	pi->sechdrs = sechdrs;
@@ -807,10 +945,12 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	 * from checksumming.
 	 */
 	pi->purgatory_buf = kbuf.buffer;
-	return ret;
+	pi->purgatory_load_addr = kbuf.mem;
+
+	return 0;
 out:
 	vfree(sechdrs);
-	vfree(kbuf.buffer);
+
 	return ret;
 }
 
@@ -886,7 +1026,7 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	pi->ehdr = (Elf_Ehdr *)kexec_purgatory;
 
 	if (memcmp(pi->ehdr->e_ident, ELFMAG, SELFMAG) != 0
-	    || pi->ehdr->e_type != ET_REL
+	    || pi->ehdr->e_type != PURGATORY_ELF_TYPE
 	    || !elf_check_arch(pi->ehdr)
 	    || pi->ehdr->e_shentsize != sizeof(Elf_Shdr))
 		return -ENOEXEC;
@@ -915,6 +1055,28 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	return ret;
 }
 
+/**
+ * sym_value_offset - return symbol value as a section-relative offset
+ *
+ * In position-independent executables the symbol value is an absolute address,
+ * so convert it to a section-relative offset. In relocatable objects the symbol
+ * value already is a section-relative offset.
+ */
+static Elf_Addr sym_value_offset(struct purgatory_info *pi, Elf_Sym *sym)
+{
+	Elf_Addr base_addr;
+
+	if (IS_ENABLED(CONFIG_HAVE_KEXEC_FILE_PIE_PURGATORY)) {
+		const Elf_Shdr *sechdrs_c;
+
+		sechdrs_c = (const void *) pi->ehdr + pi->ehdr->e_shoff;
+		base_addr = sechdrs_c[sym->st_shndx].sh_addr;
+	} else
+		base_addr = 0;
+
+	return sym->st_value - base_addr;
+}
+
 static Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 					    const char *name)
 {
@@ -979,7 +1141,7 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
 	 * Returns the address where symbol will finally be loaded after
 	 * kexec_load_segment()
 	 */
-	return (void *)(sechdr->sh_addr + sym->st_value);
+	return (void *)(sechdr->sh_addr + sym_value_offset(pi, sym));
 }
 
 /*
@@ -1013,7 +1175,7 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	}
 
 	sym_buf = (unsigned char *)sechdrs[sym->st_shndx].sh_offset +
-					sym->st_value;
+					sym_value_offset(pi, sym);
 
 	if (get_value)
 		memcpy((void *)buf, sym_buf, size);
-- 
2.7.4
