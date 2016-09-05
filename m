Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSkjX2YN2zDrp2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 08:21:52 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85MHkjC025670
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 18:21:50 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259cmb13hj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 18:21:50 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 5 Sep 2016 19:21:47 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A66391DC001D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 18:21:44 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85MLi1s25624886
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:21:44 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85MLhhZ015422
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:21:44 -0300
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
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v8 02/13] kexec_file: Change kexec_add_buffer to take
 kexec_buf as argument.
Date: Mon,  5 Sep 2016 19:20:03 -0300
In-Reply-To: <1473114014-20769-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1473114014-20769-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1473114014-20769-3-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is done to simplify the kexec_add_buffer argument list.
Adapt all callers to set up a kexec_buf to pass to kexec_add_buffer.

In addition, change the type of kexec_buf.buffer from char * to void *.
There is no particular reason for it to be a char *, and the change
allows us to get rid of 3 existing casts to char * in the code.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Acked-by: Dave Young <dyoung@redhat.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/x86/kernel/crash.c           | 37 ++++++++--------
 arch/x86/kernel/kexec-bzimage64.c | 48 +++++++++++----------
 include/linux/kexec.h             |  8 +---
 kernel/kexec_file.c               | 88 ++++++++++++++++++---------------------
 4 files changed, 87 insertions(+), 94 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9616cf76940c..38a1cdf6aa05 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -615,9 +615,9 @@ static int determine_backup_region(u64 start, u64 end, void *arg)
 
 int crash_load_segments(struct kimage *image)
 {
-	unsigned long src_start, src_sz, elf_sz;
-	void *elf_addr;
 	int ret;
+	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
+				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/*
 	 * Determine and load a segment for backup area. First 640K RAM
@@ -631,43 +631,44 @@ int crash_load_segments(struct kimage *image)
 	if (ret < 0)
 		return ret;
 
-	src_start = image->arch.backup_src_start;
-	src_sz = image->arch.backup_src_sz;
-
 	/* Add backup segment. */
-	if (src_sz) {
+	if (image->arch.backup_src_sz) {
+		kbuf.buffer = &crash_zero_bytes;
+		kbuf.bufsz = sizeof(crash_zero_bytes);
+		kbuf.memsz = image->arch.backup_src_sz;
+		kbuf.buf_align = PAGE_SIZE;
 		/*
 		 * Ideally there is no source for backup segment. This is
 		 * copied in purgatory after crash. Just add a zero filled
 		 * segment for now to make sure checksum logic works fine.
 		 */
-		ret = kexec_add_buffer(image, (char *)&crash_zero_bytes,
-				       sizeof(crash_zero_bytes), src_sz,
-				       PAGE_SIZE, 0, -1, 0,
-				       &image->arch.backup_load_addr);
+		ret = kexec_add_buffer(&kbuf);
 		if (ret)
 			return ret;
+		image->arch.backup_load_addr = kbuf.mem;
 		pr_debug("Loaded backup region at 0x%lx backup_start=0x%lx memsz=0x%lx\n",
-			 image->arch.backup_load_addr, src_start, src_sz);
+			 image->arch.backup_load_addr,
+			 image->arch.backup_src_start, kbuf.memsz);
 	}
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &elf_addr, &elf_sz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
 	if (ret)
 		return ret;
 
-	image->arch.elf_headers = elf_addr;
-	image->arch.elf_headers_sz = elf_sz;
+	image->arch.elf_headers = kbuf.buffer;
+	image->arch.elf_headers_sz = kbuf.bufsz;
 
-	ret = kexec_add_buffer(image, (char *)elf_addr, elf_sz, elf_sz,
-			ELF_CORE_HEADER_ALIGN, 0, -1, 0,
-			&image->arch.elf_load_addr);
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		vfree((void *)image->arch.elf_headers);
 		return ret;
 	}
+	image->arch.elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 image->arch.elf_load_addr, elf_sz, elf_sz);
+		 image->arch.elf_load_addr, kbuf.bufsz, kbuf.bufsz);
 
 	return ret;
 }
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index f2356bda2b05..4b3a75329fb6 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -331,17 +331,17 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 
 	struct setup_header *header;
 	int setup_sects, kern16_size, ret = 0;
-	unsigned long setup_header_size, params_cmdline_sz, params_misc_sz;
+	unsigned long setup_header_size, params_cmdline_sz;
 	struct boot_params *params;
 	unsigned long bootparam_load_addr, kernel_load_addr, initrd_load_addr;
 	unsigned long purgatory_load_addr;
-	unsigned long kernel_bufsz, kernel_memsz, kernel_align;
-	char *kernel_buf;
 	struct bzimage64_data *ldata;
 	struct kexec_entry64_regs regs64;
 	void *stack;
 	unsigned int setup_hdr_offset = offsetof(struct boot_params, hdr);
 	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
+	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
+				  .top_down = true };
 
 	header = (struct setup_header *)(kernel + setup_hdr_offset);
 	setup_sects = header->setup_sects;
@@ -402,11 +402,11 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
 				MAX_ELFCOREHDR_STR_LEN;
 	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
-	params_misc_sz = params_cmdline_sz + efi_map_sz +
+	kbuf.bufsz = params_cmdline_sz + efi_map_sz +
 				sizeof(struct setup_data) +
 				sizeof(struct efi_setup_data);
 
-	params = kzalloc(params_misc_sz, GFP_KERNEL);
+	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
 	efi_map_offset = params_cmdline_sz;
@@ -418,37 +418,41 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	/* Is there a limit on setup header size? */
 	memcpy(&params->hdr, (kernel + setup_hdr_offset), setup_header_size);
 
-	ret = kexec_add_buffer(image, (char *)params, params_misc_sz,
-			       params_misc_sz, 16, MIN_BOOTPARAM_ADDR,
-			       ULONG_MAX, 1, &bootparam_load_addr);
+	kbuf.buffer = params;
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = 16;
+	kbuf.buf_min = MIN_BOOTPARAM_ADDR;
+	ret = kexec_add_buffer(&kbuf);
 	if (ret)
 		goto out_free_params;
+	bootparam_load_addr = kbuf.mem;
 	pr_debug("Loaded boot_param, command line and misc at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 bootparam_load_addr, params_misc_sz, params_misc_sz);
+		 bootparam_load_addr, kbuf.bufsz, kbuf.bufsz);
 
 	/* Load kernel */
-	kernel_buf = kernel + kern16_size;
-	kernel_bufsz =  kernel_len - kern16_size;
-	kernel_memsz = PAGE_ALIGN(header->init_size);
-	kernel_align = header->kernel_alignment;
-
-	ret = kexec_add_buffer(image, kernel_buf,
-			       kernel_bufsz, kernel_memsz, kernel_align,
-			       MIN_KERNEL_LOAD_ADDR, ULONG_MAX, 1,
-			       &kernel_load_addr);
+	kbuf.buffer = kernel + kern16_size;
+	kbuf.bufsz =  kernel_len - kern16_size;
+	kbuf.memsz = PAGE_ALIGN(header->init_size);
+	kbuf.buf_align = header->kernel_alignment;
+	kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
+	ret = kexec_add_buffer(&kbuf);
 	if (ret)
 		goto out_free_params;
+	kernel_load_addr = kbuf.mem;
 
 	pr_debug("Loaded 64bit kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 kernel_load_addr, kernel_memsz, kernel_memsz);
+		 kernel_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	/* Load initrd high */
 	if (initrd) {
-		ret = kexec_add_buffer(image, initrd, initrd_len, initrd_len,
-				       PAGE_SIZE, MIN_INITRD_LOAD_ADDR,
-				       ULONG_MAX, 1, &initrd_load_addr);
+		kbuf.buffer = initrd;
+		kbuf.bufsz = kbuf.memsz = initrd_len;
+		kbuf.buf_align = PAGE_SIZE;
+		kbuf.buf_min = MIN_INITRD_LOAD_ADDR;
+		ret = kexec_add_buffer(&kbuf);
 		if (ret)
 			goto out_free_params;
+		initrd_load_addr = kbuf.mem;
 
 		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 				initrd_load_addr, initrd_len, initrd_len);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 2d6a1ab3b630..be39903edae1 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -163,7 +163,7 @@ struct kexec_file_ops {
  */
 struct kexec_buf {
 	struct kimage *image;
-	char *buffer;
+	void *buffer;
 	unsigned long bufsz;
 	unsigned long mem;
 	unsigned long memsz;
@@ -175,6 +175,7 @@ struct kexec_buf {
 
 int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 			       int (*func)(u64, u64, void *));
+extern int kexec_add_buffer(struct kexec_buf *kbuf);
 #endif /* CONFIG_KEXEC_FILE */
 
 struct kimage {
@@ -239,11 +240,6 @@ extern asmlinkage long sys_kexec_load(unsigned long entry,
 					struct kexec_segment __user *segments,
 					unsigned long flags);
 extern int kernel_kexec(void);
-extern int kexec_add_buffer(struct kimage *image, char *buffer,
-			    unsigned long bufsz, unsigned long memsz,
-			    unsigned long buf_align, unsigned long buf_min,
-			    unsigned long buf_max, bool top_down,
-			    unsigned long *load_addr);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
 extern int kexec_load_purgatory(struct kimage *image, unsigned long min,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f865674bff51..efd2c094af7e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -449,25 +449,27 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
 }
 
-/*
- * Helper function for placing a buffer in a kexec segment. This assumes
- * that kexec_mutex is held.
+/**
+ * kexec_add_buffer - place a buffer in a kexec segment
+ * @kbuf:	Buffer contents and memory parameters.
+ *
+ * This function assumes that kexec_mutex is held.
+ * On successful return, @kbuf->mem will have the physical address of
+ * the buffer in memory.
+ *
+ * Return: 0 on success, negative errno on error.
  */
-int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
-		     unsigned long memsz, unsigned long buf_align,
-		     unsigned long buf_min, unsigned long buf_max,
-		     bool top_down, unsigned long *load_addr)
+int kexec_add_buffer(struct kexec_buf *kbuf)
 {
 
 	struct kexec_segment *ksegment;
-	struct kexec_buf buf, *kbuf;
 	int ret;
 
 	/* Currently adding segment this way is allowed only in file mode */
-	if (!image->file_mode)
+	if (!kbuf->image->file_mode)
 		return -EINVAL;
 
-	if (image->nr_segments >= KEXEC_SEGMENT_MAX)
+	if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
 	/*
@@ -477,22 +479,14 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 	 * logic goes through list of segments to make sure there are
 	 * no destination overlaps.
 	 */
-	if (!list_empty(&image->control_pages)) {
+	if (!list_empty(&kbuf->image->control_pages)) {
 		WARN_ON(1);
 		return -EINVAL;
 	}
 
-	memset(&buf, 0, sizeof(struct kexec_buf));
-	kbuf = &buf;
-	kbuf->image = image;
-	kbuf->buffer = buffer;
-	kbuf->bufsz = bufsz;
-
-	kbuf->memsz = ALIGN(memsz, PAGE_SIZE);
-	kbuf->buf_align = max(buf_align, PAGE_SIZE);
-	kbuf->buf_min = buf_min;
-	kbuf->buf_max = buf_max;
-	kbuf->top_down = top_down;
+	/* Ensure minimum alignment needed for segments. */
+	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
+	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
 	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
@@ -502,13 +496,12 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 	}
 
 	/* Found a suitable memory range */
-	ksegment = &image->segment[image->nr_segments];
+	ksegment = &kbuf->image->segment[kbuf->image->nr_segments];
 	ksegment->kbuf = kbuf->buffer;
 	ksegment->bufsz = kbuf->bufsz;
 	ksegment->mem = kbuf->mem;
 	ksegment->memsz = kbuf->memsz;
-	image->nr_segments++;
-	*load_addr = ksegment->mem;
+	kbuf->image->nr_segments++;
 	return 0;
 }
 
@@ -630,13 +623,15 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 				  unsigned long max, int top_down)
 {
 	struct purgatory_info *pi = &image->purgatory_info;
-	unsigned long align, buf_align, bss_align, buf_sz, bss_sz, bss_pad;
-	unsigned long memsz, entry, load_addr, curr_load_addr, bss_addr, offset;
+	unsigned long align, bss_align, bss_sz, bss_pad;
+	unsigned long entry, load_addr, curr_load_addr, bss_addr, offset;
 	unsigned char *buf_addr, *src;
 	int i, ret = 0, entry_sidx = -1;
 	const Elf_Shdr *sechdrs_c;
 	Elf_Shdr *sechdrs = NULL;
-	void *purgatory_buf = NULL;
+	struct kexec_buf kbuf = { .image = image, .bufsz = 0, .buf_align = 1,
+				  .buf_min = min, .buf_max = max,
+				  .top_down = top_down };
 
 	/*
 	 * sechdrs_c points to section headers in purgatory and are read
@@ -702,9 +697,7 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	}
 
 	/* Determine how much memory is needed to load relocatable object. */
-	buf_align = 1;
 	bss_align = 1;
-	buf_sz = 0;
 	bss_sz = 0;
 
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
@@ -713,10 +706,10 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 
 		align = sechdrs[i].sh_addralign;
 		if (sechdrs[i].sh_type != SHT_NOBITS) {
-			if (buf_align < align)
-				buf_align = align;
-			buf_sz = ALIGN(buf_sz, align);
-			buf_sz += sechdrs[i].sh_size;
+			if (kbuf.buf_align < align)
+				kbuf.buf_align = align;
+			kbuf.bufsz = ALIGN(kbuf.bufsz, align);
+			kbuf.bufsz += sechdrs[i].sh_size;
 		} else {
 			/* bss section */
 			if (bss_align < align)
@@ -728,32 +721,31 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 
 	/* Determine the bss padding required to align bss properly */
 	bss_pad = 0;
-	if (buf_sz & (bss_align - 1))
-		bss_pad = bss_align - (buf_sz & (bss_align - 1));
+	if (kbuf.bufsz & (bss_align - 1))
+		bss_pad = bss_align - (kbuf.bufsz & (bss_align - 1));
 
-	memsz = buf_sz + bss_pad + bss_sz;
+	kbuf.memsz = kbuf.bufsz + bss_pad + bss_sz;
 
 	/* Allocate buffer for purgatory */
-	purgatory_buf = vzalloc(buf_sz);
-	if (!purgatory_buf) {
+	kbuf.buffer = vzalloc(kbuf.bufsz);
+	if (!kbuf.buffer) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	if (buf_align < bss_align)
-		buf_align = bss_align;
+	if (kbuf.buf_align < bss_align)
+		kbuf.buf_align = bss_align;
 
 	/* Add buffer to segment list */
-	ret = kexec_add_buffer(image, purgatory_buf, buf_sz, memsz,
-				buf_align, min, max, top_down,
-				&pi->purgatory_load_addr);
+	ret = kexec_add_buffer(&kbuf);
 	if (ret)
 		goto out;
+	pi->purgatory_load_addr = kbuf.mem;
 
 	/* Load SHF_ALLOC sections */
-	buf_addr = purgatory_buf;
+	buf_addr = kbuf.buffer;
 	load_addr = curr_load_addr = pi->purgatory_load_addr;
-	bss_addr = load_addr + buf_sz + bss_pad;
+	bss_addr = load_addr + kbuf.bufsz + bss_pad;
 
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
 		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
@@ -799,11 +791,11 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	 * Used later to identify which section is purgatory and skip it
 	 * from checksumming.
 	 */
-	pi->purgatory_buf = purgatory_buf;
+	pi->purgatory_buf = kbuf.buffer;
 	return ret;
 out:
 	vfree(sechdrs);
-	vfree(purgatory_buf);
+	vfree(kbuf.buffer);
 	return ret;
 }
 
-- 
1.9.1
