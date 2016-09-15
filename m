Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZKhL1hLTzDsXC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 10:55:14 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8F0qdLv132542
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 20:55:11 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25f1nqysub-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 20:55:11 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 14 Sep 2016 21:55:08 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id ABF433520068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 20:54:43 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8F0t6c74939940
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 21:55:06 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8F0t5GL005488
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 21:55:06 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v5 4/5] kexec_file: Add mechanism to update kexec segments.
Date: Wed, 14 Sep 2016 21:54:49 -0300
In-Reply-To: <1473900890-1476-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1473900890-1476-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1473900890-1476-5-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kexec_update_segment allows a given segment in kexec_image to have
its contents updated. This is useful if the current kernel wants to
send information to the next kernel that is up-to-date at the time of
reboot.

Before modifying the segment the image checksum is verified, and after
the segment is updated the checksum is recalculated and updated in the
kexec image.

Suggested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 include/linux/kexec.h   |   2 +
 kernel/kexec_core.c     |   5 -
 kernel/kexec_file.c     | 331 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_internal.h |   6 +
 4 files changed, 339 insertions(+), 5 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 768245aa76bf..81aca6acc3b0 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -183,6 +183,8 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 			       int (*func)(u64, u64, void *));
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
+int kexec_update_segment(const char *buffer, size_t bufsz,
+			 unsigned long load_addr, size_t memsz);
 #endif /* CONFIG_KEXEC_FILE */
 
 struct kimage {
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 561675589511..a86596984454 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -551,11 +551,6 @@ void kimage_terminate(struct kimage *image)
 	*image->entry = IND_DONE;
 }
 
-#define for_each_kimage_entry(image, ptr, entry) \
-	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
-		ptr = (entry & IND_INDIRECTION) ? \
-			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
-
 static void kimage_free_entry(kimage_entry_t entry)
 {
 	struct page *page;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 35b04296484b..fbcec07bb3f5 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -18,6 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/highmem.h>
 #include <linux/fs.h>
 #include <crypto/hash.h>
 #include <crypto/sha.h>
@@ -591,6 +592,336 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	return 0;
 }
 
+/**
+ * @kexec_image_visit_segments() - call function on each segment page
+ * @image:	kexec image to inspect.
+ * @func:	Function to call on each page.
+ * @data:	Data pointer to pass to @func.
+ *
+ * Iterate through the @image entries, calling @func with the given @data
+ * on each segment page. dest is the start address of the page in the next
+ * kernel's address space, and addr is the address of the page in this kernel's
+ * address space.
+ *
+ * Stop iterating if @func returns non-zero, and return that value.
+ *
+ * Return: zero if all pages were visited, @func return value if non-zero.
+ */
+static int kexec_image_visit_segments(struct kimage *image,
+				      int (*func)(void *data,
+						  unsigned long dest,
+						  void *addr),
+				      void *data)
+{
+	int ret;
+	unsigned long entry, dest = 0;
+	unsigned long *ptr = NULL;
+
+	for_each_kimage_entry(image, ptr, entry) {
+		void *addr = (void *) (entry & PAGE_MASK);
+
+		switch (entry & IND_FLAGS) {
+		case IND_DESTINATION:
+			dest = (unsigned long) addr;
+			break;
+		case IND_SOURCE:
+			/* Shouldn't happen, but verify just to be safe. */
+			if (WARN_ON(!dest)) {
+				pr_err("Invalid kexec entries list.");
+				return -EINVAL;
+			}
+
+			ret = func(data, dest, addr);
+			if (ret)
+				break;
+
+			dest += PAGE_SIZE;
+		}
+
+		/* Shouldn't happen, but verify just to be safe. */
+		if (WARN_ON(ptr == NULL)) {
+			pr_err("Invalid kexec entries list.");
+			return -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+struct image_digest_data {
+	unsigned long digest_load_addr;
+	struct shash_desc *desc;
+};
+
+static int calculate_image_digest(void *data, unsigned long dest, void *addr)
+{
+	struct image_digest_data *d = (struct image_digest_data *) data;
+	void *page_addr;
+	unsigned long offset;
+	int ret;
+
+	/* Assumption: the digest segment is PAGE_SIZE long. */
+	if (dest == d->digest_load_addr)
+		return 0;
+
+	page_addr = kmap_atomic(kmap_to_page(addr));
+
+	offset = dest & ~PAGE_MASK;
+	ret = crypto_shash_update(d->desc, page_addr + offset,
+				  PAGE_SIZE - offset);
+
+	kunmap_atomic(page_addr);
+
+	return ret;
+}
+
+/**
+ * kexec_calculate_image_digest() - calculate the digest of the kexec image
+ * @image:	kexec image with segments already loaded into it.
+ * @digest:	Buffer of at least SHA256_DIGEST_SIZE bytes.
+ *
+ * This function goes through the @image->head list, calculates the checksum
+ * of the segment contents and puts the result in @digest, which is assumed
+ * to be big enough to hold an SHA256 digest.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int kexec_calculate_image_digest(struct kimage *image, void *digest)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	int ret;
+	size_t desc_size;
+	struct purgatory_info *pi = &image->purgatory_info;
+	struct image_digest_data d;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out;
+	}
+
+	desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
+	desc = kzalloc(desc_size, GFP_KERNEL);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto out_free_tfm;
+	}
+
+	desc->tfm   = tfm;
+	desc->flags = 0;
+
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto out_free_desc;
+
+	d.desc = desc;
+	d.digest_load_addr = pi->digest_load_addr;
+	ret = kexec_image_visit_segments(image, calculate_image_digest, &d);
+
+	if (!ret)
+		ret = crypto_shash_final(desc, digest);
+
+out_free_desc:
+	kfree(desc);
+out_free_tfm:
+	kfree(tfm);
+out:
+	return ret;
+}
+
+struct get_digest_data {
+	void *digest;
+	unsigned long digest_load_addr;
+	size_t bufsz;
+	size_t memsz;
+};
+
+static int get_digest(void *data, unsigned long dest, void *addr)
+{
+	struct get_digest_data *d = (struct get_digest_data *) data;
+	void *page_addr;
+	unsigned long offset;
+	size_t uchunk, mchunk;
+
+	if (dest != d->digest_load_addr)
+		return 0;
+
+	page_addr = kmap_atomic(kmap_to_page(addr));
+
+	offset = dest & ~PAGE_MASK;
+	mchunk = min_t(size_t, d->memsz, PAGE_SIZE - offset);
+	uchunk = min(d->bufsz, mchunk);
+	memcpy(d->digest, page_addr + offset, uchunk);
+
+	kunmap_atomic(page_addr);
+
+	d->digest += mchunk;
+	d->bufsz -= uchunk;
+	d->digest_load_addr += mchunk;
+	d->memsz -= mchunk;
+
+	return d->memsz > 0 ? 0 : 1;
+}
+
+static int kexec_image_get_digest(struct kimage *image, void *digest)
+{
+	int ret;
+	struct get_digest_data d;
+
+	d.digest = digest;
+	d.digest_load_addr = image->purgatory_info.digest_load_addr;
+	d.bufsz = SHA256_DIGEST_SIZE;
+	d.memsz = SHA256_DIGEST_SIZE;
+	ret = kexec_image_visit_segments(image, get_digest, &d);
+
+	return d.bufsz == 0 ? 0 : -ENOENT;
+}
+
+struct update_segment_data {
+	const char *buffer;
+	size_t bufsz;
+	size_t memsz;
+	unsigned long load_addr;
+};
+
+static int update_segment(void *data, unsigned long dest, void *addr)
+{
+	struct update_segment_data *d = (struct update_segment_data *) data;
+	void *page_addr;
+	unsigned long offset;
+	size_t uchunk, mchunk;
+
+	if (dest != d->load_addr)
+		return 0;
+
+	page_addr = kmap_atomic(kmap_to_page(addr));
+
+	offset = d->load_addr & ~PAGE_MASK;
+	mchunk = min_t(size_t, d->memsz, PAGE_SIZE - offset);
+	uchunk = min(d->bufsz, mchunk);
+	memcpy(page_addr + offset, d->buffer, uchunk);
+
+	kunmap_atomic(page_addr);
+
+	d->bufsz -= uchunk;
+	d->load_addr += mchunk;
+	d->buffer += mchunk;
+	d->memsz -= mchunk;
+
+	return d->memsz > 0 ? 0 : 1;
+}
+
+static int do_kexec_update_segment(const char *buffer, size_t bufsz,
+				   unsigned long load_addr, size_t memsz)
+{
+	int i;
+	struct update_segment_data d;
+
+	if (kexec_image == NULL) {
+		pr_err("Can't update segment: no kexec image loaded.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * kexec_add_buffer rounds up segment sizes to PAGE_SIZE, so
+	 * we have to do it here as well.
+	 */
+	memsz = ALIGN(memsz, PAGE_SIZE);
+
+	for (i = 0; i < kexec_image->nr_segments; i++)
+		/* We only support updating whole segments. */
+		if (load_addr == kexec_image->segment[i].mem &&
+		    memsz == kexec_image->segment[i].memsz)
+			break;
+
+	if (WARN_ON(i == kexec_image->nr_segments)) {
+		pr_debug("Couldn't find segment to update: 0x%lx, size 0x%zx\n",
+			 load_addr, memsz);
+		return -EINVAL;
+	}
+
+	d.buffer = buffer;
+	d.bufsz = bufsz;
+	d.load_addr = load_addr;
+	d.memsz = memsz;
+	kexec_image_visit_segments(kexec_image, update_segment, &d);
+
+	return 0;
+}
+
+
+/**
+ * kexec_update_segment() - update the contents of a kimage segment
+ * @buffer:	New contents of the segment.
+ * @bufsz:	@buffer size.
+ * @load_addr:	Segment's physical address in the next kernel.
+ * @memsz:	Segment size.
+ *
+ * This function assumes kexec_mutex is held.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_update_segment(const char *buffer, size_t bufsz,
+			 unsigned long load_addr, size_t memsz)
+{
+	int ret;
+	void *digest, *orig_digest;
+	struct purgatory_info *pi = &kexec_image->purgatory_info;
+
+	digest = kzalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
+	if (!digest)
+		return -ENOMEM;
+
+	orig_digest = kzalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
+	if (!orig_digest) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* First, verify the kexec image integrity. */
+	ret = kexec_image_get_digest(kexec_image, orig_digest);
+	if (ret) {
+		pr_debug("Can't get kexec image checksum.\n");
+		goto out;
+	}
+
+	ret = kexec_calculate_image_digest(kexec_image, digest);
+	if (ret) {
+		pr_debug("Can't calculate kexec image checksum.\n");
+		goto out;
+	}
+
+	ret = memcmp(digest, orig_digest, SHA256_DIGEST_SIZE);
+	if (ret) {
+		pr_debug("The kexec image was corrupted in memory.\n");
+		ret = -ENOEXEC;
+		goto out;
+	}
+
+	/* Now, update the segment we were asked to update. */
+	ret = do_kexec_update_segment(buffer, bufsz, load_addr, memsz);
+	if (ret)
+		goto out;
+
+	/* Calculate the new kexec image checksum. */
+	ret = kexec_calculate_image_digest(kexec_image, digest);
+	if (ret) {
+		pr_debug("Can't calculate kexec image checksum.\n");
+		goto out;
+	}
+
+	/* Update the segment containing the kexec image checksum. */
+	ret = do_kexec_update_segment(digest, SHA256_DIGEST_SIZE,
+				      pi->digest_load_addr, SHA256_DIGEST_SIZE);
+
+out:
+	kfree(digest);
+	kfree(orig_digest);
+
+	return ret;
+}
+
 /* Calculate and store the digest of segments */
 static int kexec_calculate_store_digests(struct kimage *image)
 {
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 4cef7e4706b0..9bb05a08e31a 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -14,6 +14,12 @@ int kimage_is_destination_range(struct kimage *image,
 
 extern struct mutex kexec_mutex;
 
+#define for_each_kimage_entry(image, ptr, entry) \
+	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
+		ptr = (entry & IND_INDIRECTION) ? \
+			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
+
+
 #ifdef CONFIG_KEXEC_FILE
 struct kexec_sha_region {
 	unsigned long start;
-- 
1.9.1
