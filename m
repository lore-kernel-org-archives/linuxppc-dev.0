Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYVsX11yRzDqlK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 11:45:03 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L1hfhP130043
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:45:02 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23pe02wx2x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:45:02 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:44:59 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 83AD11DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:44:49 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L1iuGA9568578
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:44:56 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L1iug4030000
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:44:56 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 3/6] kexec_file: Allow skipping checksum calculation for some
 segments.
Date: Mon, 20 Jun 2016 22:44:33 -0300
In-Reply-To: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1466473476-10104-4-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds checksum argument to kexec_add_buffer specifying whether the given
segment should be part of the checksum calculation.

The next patch will add a way to update segments after a kimage is loaded.
Segments that will be updated in this way should not be checksummed,
otherwise they will cause the purgatory checksum verification to fail
when the machine is rebooted.

As a bonus, we don't need to special-case the purgatory segment anymore
to avoid checksumming it.

Adjust call sites for the new argument.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kexec_elf_64.c |  6 +++---
 arch/x86/kernel/crash.c            |  4 ++--
 arch/x86/kernel/kexec-bzimage64.c  |  6 +++---
 include/linux/kexec.h              |  7 +++++--
 kernel/kexec_file.c                | 22 +++++++++++-----------
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
index 5d2b7036fee7..abbad484d7b2 100644
--- a/arch/powerpc/kernel/kexec_elf_64.c
+++ b/arch/powerpc/kernel/kexec_elf_64.c
@@ -311,7 +311,7 @@ static int elf_exec_load(struct kimage *image, struct elfhdr *ehdr,
 				       (char *) elf_info->buffer + phdr->p_offset,
 				       size, phdr->p_memsz, phdr->p_align,
 				       phdr->p_paddr + base, ppc64_rma_size,
-				       false, &load_addr);
+				       false, true, &load_addr);
 		if (ret)
 			goto out;
 
@@ -487,7 +487,7 @@ void *elf64_load(struct kimage *image, char *kernel_buf,
 	if (initrd != NULL) {
 		ret = kexec_add_buffer(image, initrd, initrd_len, initrd_len,
 				       PAGE_SIZE, 0, ppc64_rma_size, false,
-				       &initrd_load_addr);
+				       true, &initrd_load_addr);
 		if (ret)
 			goto out;
 
@@ -564,7 +564,7 @@ void *elf64_load(struct kimage *image, char *kernel_buf,
 	fdt_pack(fdt);
 
 	ret = kexec_add_buffer(image, fdt, fdt_size, fdt_size, PAGE_SIZE, 0,
-			       ppc64_rma_size, true, &fdt_load_addr);
+			       ppc64_rma_size, true, true, &fdt_load_addr);
 	if (ret)
 		goto out;
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9ef978d69c22..c8b16f2ca321 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -643,7 +643,7 @@ int crash_load_segments(struct kimage *image)
 		 */
 		ret = kexec_add_buffer(image, (char *)&crash_zero_bytes,
 				       sizeof(crash_zero_bytes), src_sz,
-				       PAGE_SIZE, 0, -1, 0,
+				       PAGE_SIZE, 0, -1, false, true,
 				       &image->arch.backup_load_addr);
 		if (ret)
 			return ret;
@@ -660,7 +660,7 @@ int crash_load_segments(struct kimage *image)
 	image->arch.elf_headers_sz = elf_sz;
 
 	ret = kexec_add_buffer(image, (char *)elf_addr, elf_sz, elf_sz,
-			ELF_CORE_HEADER_ALIGN, 0, -1, 0,
+			ELF_CORE_HEADER_ALIGN, 0, -1, false, true,
 			&image->arch.elf_load_addr);
 	if (ret) {
 		vfree((void *)image->arch.elf_headers);
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index f2356bda2b05..f9016be44da6 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -420,7 +420,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 
 	ret = kexec_add_buffer(image, (char *)params, params_misc_sz,
 			       params_misc_sz, 16, MIN_BOOTPARAM_ADDR,
-			       ULONG_MAX, 1, &bootparam_load_addr);
+			       ULONG_MAX, true, true, &bootparam_load_addr);
 	if (ret)
 		goto out_free_params;
 	pr_debug("Loaded boot_param, command line and misc at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
@@ -434,7 +434,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 
 	ret = kexec_add_buffer(image, kernel_buf,
 			       kernel_bufsz, kernel_memsz, kernel_align,
-			       MIN_KERNEL_LOAD_ADDR, ULONG_MAX, 1,
+			       MIN_KERNEL_LOAD_ADDR, ULONG_MAX, true, true,
 			       &kernel_load_addr);
 	if (ret)
 		goto out_free_params;
@@ -446,7 +446,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	if (initrd) {
 		ret = kexec_add_buffer(image, initrd, initrd_len, initrd_len,
 				       PAGE_SIZE, MIN_INITRD_LOAD_ADDR,
-				       ULONG_MAX, 1, &initrd_load_addr);
+				       ULONG_MAX, true, true, &initrd_load_addr);
 		if (ret)
 			goto out_free_params;
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 72db95c623b3..131b1fc7820e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -98,6 +98,9 @@ struct kexec_segment {
 	size_t bufsz;
 	unsigned long mem;
 	size_t memsz;
+
+	/* Whether this segment is part of the checksum calculation. */
+	bool do_checksum;
 };
 
 #ifdef CONFIG_COMPAT
@@ -217,7 +220,7 @@ int kexec_locate_mem_hole(struct kimage *image, unsigned long size,
 extern int kexec_add_buffer(struct kimage *image, char *buffer,
 			    unsigned long bufsz, unsigned long memsz,
 			    unsigned long buf_align, unsigned long buf_min,
-			    unsigned long buf_max, bool top_down,
+			    unsigned long buf_max, bool top_down, bool checksum,
 			    unsigned long *load_addr);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
@@ -334,7 +337,7 @@ int kexec_add_handover_buffer(struct kimage *image, void *buffer,
 			      unsigned long bufsz, unsigned long memsz,
 			      unsigned long buf_align, unsigned long buf_min,
 			      unsigned long buf_max, bool top_down,
-			      unsigned long *load_addr);
+			      bool checksum, unsigned long *load_addr);
 int __weak kexec_get_handover_buffer(void **addr, unsigned long *size);
 int __weak kexec_free_handover_buffer(void);
 #else
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index d6ba702654f5..3aa829a78f50 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -146,6 +146,7 @@ int __weak arch_kexec_add_handover_buffer(struct kimage *image,
  * @buf_min:	Minimum address where buffer can be placed.
  * @buf_max:	Maximum address where buffer can be placed.
  * @top_down:	Find the highest available memory position for the buffer?
+ * @checksum:	Should this buffer checksum be verified by the purgatory?
  * @load_addr:	On successful return, set to the physical memory address of the
  * 		buffer in the next kernel.
  *
@@ -157,7 +158,7 @@ int kexec_add_handover_buffer(struct kimage *image, void *buffer,
 			      unsigned long bufsz, unsigned long memsz,
 			      unsigned long buf_align, unsigned long buf_min,
 			      unsigned long buf_max, bool top_down,
-			      unsigned long *load_addr)
+			      bool checksum, unsigned long *load_addr)
 {
 	int ret;
 
@@ -165,7 +166,7 @@ int kexec_add_handover_buffer(struct kimage *image, void *buffer,
 		return -ENOTSUPP;
 
 	ret = kexec_add_buffer(image, buffer, bufsz, memsz, buf_align, buf_min,
-			       buf_max, top_down, load_addr);
+			       buf_max, top_down, checksum, load_addr);
 	if (ret)
 		return ret;
 
@@ -590,7 +591,7 @@ int kexec_locate_mem_hole(struct kimage *image, unsigned long size,
 int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 		     unsigned long memsz, unsigned long buf_align,
 		     unsigned long buf_min, unsigned long buf_max,
-		     bool top_down, unsigned long *load_addr)
+		     bool top_down, bool checksum, unsigned long *load_addr)
 {
 
 	struct kexec_segment *ksegment;
@@ -630,6 +631,7 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 	ksegment->bufsz = bufsz;
 	ksegment->mem = addr;
 	ksegment->memsz = size;
+	ksegment->do_checksum = checksum;
 	image->nr_segments++;
 	*load_addr = ksegment->mem;
 	return 0;
@@ -645,7 +647,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	char *digest;
 	void *zero_buf;
 	struct kexec_sha_region *sha_regions;
-	struct purgatory_info *pi = &image->purgatory_info;
 
 	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
 	zero_buf_sz = PAGE_SIZE;
@@ -685,11 +686,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		struct kexec_segment *ksegment;
 
 		ksegment = &image->segment[i];
-		/*
-		 * Skip purgatory as it will be modified once we put digest
-		 * info in purgatory.
-		 */
-		if (ksegment->kbuf == pi->purgatory_buf)
+		if (!ksegment->do_checksum)
 			continue;
 
 		ret = crypto_shash_update(desc, ksegment->kbuf,
@@ -866,9 +863,12 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	if (buf_align < bss_align)
 		buf_align = bss_align;
 
-	/* Add buffer to segment list */
+	/*
+	 * Add buffer to segment list. Don't checksum the segment as
+	 * it will be modified once we put digest info in purgatory.
+	 */
 	ret = kexec_add_buffer(image, purgatory_buf, buf_sz, memsz,
-				buf_align, min, max, top_down,
+				buf_align, min, max, top_down, false,
 				&pi->purgatory_load_addr);
 	if (ret)
 		goto out;
-- 
1.9.1
