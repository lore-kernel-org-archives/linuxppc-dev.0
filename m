Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNwsK0HPRzDrhR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 03:45:24 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7UHhgpI074263
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 13:45:22 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25536ksva4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 13:45:22 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 30 Aug 2016 14:45:20 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 44573352006C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 13:44:55 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7UHjHp74976754
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 14:45:17 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7UHjGRw015724
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 14:45:16 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v4 3/5] kexec_file: Allow skipping checksum calculation for
 some segments.
Date: Tue, 30 Aug 2016 14:45:03 -0300
In-Reply-To: <1472579105-26296-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1472579105-26296-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1472579105-26296-4-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add skip_checksum member to struct kexec_buf to specify whether the
corresponding segment should be part of the checksum calculation.

The next patch will add a way to update segments after a kimage is loaded.
Segments that will be updated in this way should not be checksummed,
otherwise they will cause the purgatory checksum verification to fail
when the machine is rebooted.

As a bonus, we don't need to special-case the purgatory segment anymore
to avoid checksumming it.

Places using struct kexec_buf get false as the default value for
skip_checksum since they all use designated initializers.  Therefore,
there is no behavior change with this patch and all segments except the
purgatory are checksummed.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 include/linux/kexec.h | 23 ++++++++++++++---------
 kernel/kexec_file.c   | 15 +++++++--------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 16561e96a6d7..edadff6c86ff 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -100,6 +100,9 @@ struct kexec_segment {
 	size_t bufsz;
 	unsigned long mem;
 	size_t memsz;
+
+	/* Whether this segment is ignored in the checksum calculation. */
+	bool skip_checksum;
 };
 
 #ifdef CONFIG_COMPAT
@@ -151,15 +154,16 @@ struct kexec_file_ops {
 
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
- * @image:	kexec image in which memory to search.
- * @buffer:	Contents which will be copied to the allocated memory.
- * @bufsz:	Size of @buffer.
- * @mem:	On return will have address of the buffer in memory.
- * @memsz:	Size for the buffer in memory.
- * @buf_align:	Minimum alignment needed.
- * @buf_min:	The buffer can't be placed below this address.
- * @buf_max:	The buffer can't be placed above this address.
- * @top_down:	Allocate from top of memory.
+ * @image:		kexec image in which memory to search.
+ * @buffer:		Contents which will be copied to the allocated memory.
+ * @bufsz:		Size of @buffer.
+ * @mem:		On return will have address of the buffer in memory.
+ * @memsz:		Size for the buffer in memory.
+ * @buf_align:		Minimum alignment needed.
+ * @buf_min:		The buffer can't be placed below this address.
+ * @buf_max:		The buffer can't be placed above this address.
+ * @top_down:		Allocate from top of memory.
+ * @skip_checksum:	Don't verify checksum for this buffer in purgatory.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -171,6 +175,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	bool skip_checksum;
 };
 
 int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f5684adfad07..0e90d1446cb0 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -584,6 +584,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	ksegment->bufsz = kbuf->bufsz;
 	ksegment->mem = kbuf->mem;
 	ksegment->memsz = kbuf->memsz;
+	ksegment->skip_checksum = kbuf->skip_checksum;
 	kbuf->image->nr_segments++;
 	return 0;
 }
@@ -598,7 +599,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	char *digest;
 	void *zero_buf;
 	struct kexec_sha_region *sha_regions;
-	struct purgatory_info *pi = &image->purgatory_info;
 
 	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
 	zero_buf_sz = PAGE_SIZE;
@@ -638,11 +638,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		struct kexec_segment *ksegment;
 
 		ksegment = &image->segment[i];
-		/*
-		 * Skip purgatory as it will be modified once we put digest
-		 * info in purgatory.
-		 */
-		if (ksegment->kbuf == pi->purgatory_buf)
+		if (ksegment->skip_checksum)
 			continue;
 
 		ret = crypto_shash_update(desc, ksegment->kbuf,
@@ -714,7 +710,7 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	Elf_Shdr *sechdrs = NULL;
 	struct kexec_buf kbuf = { .image = image, .bufsz = 0, .buf_align = 1,
 				  .buf_min = min, .buf_max = max,
-				  .top_down = top_down };
+				  .top_down = top_down, .skip_checksum = true };
 
 	/*
 	 * sechdrs_c points to section headers in purgatory and are read
@@ -819,7 +815,10 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	if (kbuf.buf_align < bss_align)
 		kbuf.buf_align = bss_align;
 
-	/* Add buffer to segment list */
+	/*
+	 * Add buffer to segment list. Don't checksum the segment as
+	 * it will be modified once we put digest info in purgatory.
+	 */
 	ret = kexec_add_buffer(&kbuf);
 	if (ret)
 		goto out;
-- 
1.9.1
