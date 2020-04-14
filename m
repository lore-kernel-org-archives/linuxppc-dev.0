Return-Path: <SRS0=VNWk=56=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB08C2BA19
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 14:21:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7C42075E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 14:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NwaxTAki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7C42075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491njH6ZWRzDqkK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 00:21:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+4a22011dcb1da0b09bf4+6078+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=NwaxTAki; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491mDp5T0HzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2020 23:15:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=pDm9hbAz3BSYZA1fYrWbFg2iKrNnxVLGyRxjWpx/QY0=; b=NwaxTAkiaRWgQZ3FtcecEmP9Zv
 1VRkY8iSEzfJpcKYSqez0gj+k+rbst93U7tt9DUQHtMv9Kwts2FJlsfQUskP8XCi4DxEUli5Fy7LK
 j2L33iunvKs7lwGCZiC6RhJYBD0wm33A/q1lJYGKXLryYLKYPlH7VQff28Ny7urT1OFtES7nI1b1b
 K+8brMe/8atKR8RThqRwrt+dv/lP2lu8SLnbnCPxoNmIKo63jsv6Q+GYub/kjaASVYyJbkGzY/nkO
 FOgazw2TErYQRPa8/9ftvG+8hOrYad0qzsQfApg+B/tj9Z027X+H/S2hC6t2n9ZPvFmfNOc3P80+2
 R2FVpt8g==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOLOo-00070c-Iy; Tue, 14 Apr 2020 13:14:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 x86@kernel.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Subject: [PATCH 16/29] mm: remove map_vm_range
Date: Tue, 14 Apr 2020 15:13:35 +0200
Message-Id: <20200414131348.444715-17-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, bpf@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Switch all callers to map_kernel_range, which symmetric to the unmap
side (as well as the _noflush versions).

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/core-api/cachetlb.rst |  2 +-
 include/linux/vmalloc.h             | 10 ++++------
 mm/vmalloc.c                        | 21 +++++++--------------
 mm/zsmalloc.c                       |  4 +++-
 net/ceph/ceph_common.c              |  3 +--
 5 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index 93cb65d52720..a1582cc79f0f 100644
--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -213,7 +213,7 @@ Here are the routines, one by one:
 	there will be no entries in the cache for the kernel address
 	space for virtual addresses in the range 'start' to 'end-1'.
 
-	The first of these two routines is invoked after map_vm_area()
+	The first of these two routines is invoked after map_kernel_range()
 	has installed the page table entries.  The second is invoked
 	before unmap_kernel_range() deletes the page table entries.
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 3070b4dbc2d9..15ffbd8e8e65 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -168,11 +168,11 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 extern struct vm_struct *remove_vm_area(const void *addr);
 extern struct vm_struct *find_vm_area(const void *addr);
 
-extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
-			struct page **pages);
 #ifdef CONFIG_MMU
 extern int map_kernel_range_noflush(unsigned long start, unsigned long size,
 				    pgprot_t prot, struct page **pages);
+int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,
+		struct page **pages);
 extern void unmap_kernel_range_noflush(unsigned long addr, unsigned long size);
 extern void unmap_kernel_range(unsigned long addr, unsigned long size);
 static inline void set_vm_flush_reset_perms(void *addr)
@@ -189,14 +189,12 @@ map_kernel_range_noflush(unsigned long start, unsigned long size,
 {
 	return size >> PAGE_SHIFT;
 }
+#define map_kernel_range map_kernel_range_noflush
 static inline void
 unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
 {
 }
-static inline void
-unmap_kernel_range(unsigned long addr, unsigned long size)
-{
-}
+#define unmap_kernel_range unmap_kernel_range_noflush
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ca8dc5d42580..b0c7cdc8701a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -272,8 +272,8 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 	return 0;
 }
 
-static int map_kernel_range(unsigned long start, unsigned long size,
-			   pgprot_t prot, struct page **pages)
+int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,
+		struct page **pages)
 {
 	int ret;
 
@@ -2027,16 +2027,6 @@ void unmap_kernel_range(unsigned long addr, unsigned long size)
 	flush_tlb_kernel_range(addr, end);
 }
 
-int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
-{
-	unsigned long addr = (unsigned long)area->addr;
-	int err;
-
-	err = map_kernel_range(addr, get_vm_area_size(area), prot, pages);
-
-	return err > 0 ? 0 : err;
-}
-
 static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
 {
@@ -2408,7 +2398,8 @@ void *vmap(struct page **pages, unsigned int count,
 	if (!area)
 		return NULL;
 
-	if (map_vm_area(area, prot, pages)) {
+	if (map_kernel_range((unsigned long)area->addr, size, prot,
+			pages) < 0) {
 		vunmap(area->addr);
 		return NULL;
 	}
@@ -2471,8 +2462,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
-	if (map_vm_area(area, prot, pages))
+	if (map_kernel_range((unsigned long)area->addr, get_vm_area_size(area),
+			prot, pages) < 0)
 		goto fail;
+
 	return area->addr;
 
 fail:
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index ac0524330b9b..f6dc0673e62c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1138,7 +1138,9 @@ static inline void __zs_cpu_down(struct mapping_area *area)
 static inline void *__zs_map_object(struct mapping_area *area,
 				struct page *pages[2], int off, int size)
 {
-	BUG_ON(map_vm_area(area->vm, PAGE_KERNEL, pages));
+	unsigned long addr = (unsigned long)area->vm->addr;
+
+	BUG_ON(map_kernel_range(addr, PAGE_SIZE * 2, PAGE_KERNEL, pages) < 0);
 	area->vm_addr = area->vm->addr;
 	return area->vm_addr + off;
 }
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index a0e97f6c1072..66f22e8aa529 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -190,8 +190,7 @@ EXPORT_SYMBOL(ceph_compare_options);
  * kvmalloc() doesn't fall back to the vmalloc allocator unless flags are
  * compatible with (a superset of) GFP_KERNEL.  This is because while the
  * actual pages are allocated with the specified flags, the page table pages
- * are always allocated with GFP_KERNEL.  map_vm_area() doesn't even take
- * flags because GFP_KERNEL is hard-coded in {p4d,pud,pmd,pte}_alloc().
+ * are always allocated with GFP_KERNEL.
  *
  * ceph_kvmalloc() may be called with GFP_KERNEL, GFP_NOFS or GFP_NOIO.
  */
-- 
2.25.1

