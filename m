Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85B606A331
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VuyMD/d2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSfJ05J4Sz2yDm;
	Mon, 16 Nov 2026 18:14:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::a1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794813280;
	cv=none; b=P1VTZeOHOu1xYPnmdYdGHZt+S+idU+cAD3Wi4KgWbtCc0jkRdsz3vH7HgZ+vANdVGQYHspfwZqdrSt3ItwHkhiDDK0gZXqyZ1Lj3lKHyJx/y6NieGjENCUCTxuv7ek1SkhoVCHiynjCmDZMU2ctzk5XFDCLGxfbPccp8GYbXKVh8OBJO065pFhFwIs9/Itp3zrE/frgIWulNI/9lf8J1GYwBKOhLkRQIUB6tJeP85knZkhBJAH0MlzA5IX7DKOPJRVkDeYbyU1h8c9ErKoq6AZqaGPYN5V/b25ySJSDDKU823RY4df63Eeb/OM3BegVxrd0thGbv0IGL/cT2JYlMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794813280; c=relaxed/relaxed;
	bh=r8vTH4ZwG/2DWs42qtrHbGL6SaYihVYpzXL05YW5oBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QdBlo7CNk9iRlKehL1aSD0oJMCvOX7ZiRsIoFjkwOskFYNJyPrukXBmSohD71KiHtlzP1vTxFat3FwR4xwes6twSTdJZxszm9LfoLxcbe9bmhVrL73PLvjdvGf9rnbN/Mw0Q/CRXbgbWcbGBXe3WBUAi/tMriA/u6ItTvEX54szYKQKKZPyKWoQqsaQua2YKfOeBX5HT/5begA+rSbzk6frd98wa73VAG/c4GY7punEU1nZspy53tcXyymQS+gmpFzZwJm2YKvUsN72ovXjan5AKl2xdm8O1Yzs7u6Ze0ICEuxPi+cwLpH9mNMioiXXCmuARmMBe6iAV41mBx1ImcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VuyMD/d2; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::a1; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VuyMD/d2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::a1; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-161.mta0.migadu.com [IPv6:2001:41d0:1004:224b::a1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSfHz5RGmz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:14:39 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=ZK0HyZRkuJf6PUVCzsSx26r+AdupLQhc4IQDUdlGHx8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794813261; v=1; x=1795418061;
 b=VuyMD/d2FNS1xfFGffpEoXLYVZOHRJHoksYj3ncxI4GngvkPOXcE3xO4g0EwHAAAXruYRGqb
 vMkJtMsMiUUbty62kzy5AwvUpwK8KcXgyJd4Jko7YhXUYq5zFyeSKfzGwFOO9wNoOzcC3vKLosv
 2rQp85uxhVs9eQU+LwfP9ABs=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 6aca88df114c26b4;
	Mon, 16 Nov 2026 07:14:21 +0000
X-Mizu-Trace-ID: 6aca88df114c26b4
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v5 07/11] mm/vmalloc: undo what __vmap_pages_range_noflush() mapped on failure
Date: Mon, 16 Nov 2026 15:13:21 +0800
Message-Id: <20261116071325.263682-8-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116071325.263682-1-hao.ge@linux.dev>
References: <20261116071325.263682-1-hao.ge@linux.dev>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__vmap_pages_range_noflush() maps a struct page array and may fail
half way. The ptes installed so far stay behind, so a retry of the
same range, the __GFP_NOFAIL loop in __vmalloc_area_node() or the
module tags populate, trips the WARN_ON(!pte_none()) in
vmap_pages_pte_range() and fails with -EBUSY.

vmap_pages_range_noflush_walk() now reports how many pages it
installed through its running index into the pages array, and
__vmap_pages_range_noflush() undoes [addr, addr + mapped_pages *
PAGE_SIZE) on failure. vmap_pages_pte_range() fails with -EBUSY
instead of installing over a pte that is already set, so the ptes
below that point are all ours, while a pte above it can only have
been put there by somebody else, for example when the caller's range
overlaps an existing mapping. Going further would clear ptes that
are not ours.

This path can run with a non-blocking gfp mask, the undo passes
gfpflags_allow_blocking() as can_resched.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/kmsan/hooks.c  |  4 ++--
 mm/kmsan/shadow.c |  4 ++--
 mm/vmalloc.c      | 36 +++++++++++++++++++++++++++++-------
 mm/vmalloc.h      |  3 ++-
 4 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 69008b085658..d830a4e649f1 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -208,7 +208,7 @@ int kmsan_ioremap_page_range(unsigned long start, unsigned long end,
 		mapped = __vmap_pages_range_noflush(
 			vmalloc_shadow(start + off),
 			vmalloc_shadow(start + off + PAGE_SIZE), prot, &shadow,
-			PAGE_SHIFT);
+			PAGE_SHIFT, gfp_mask);
 		if (mapped) {
 			err = mapped;
 			goto ret;
@@ -218,7 +218,7 @@ int kmsan_ioremap_page_range(unsigned long start, unsigned long end,
 		mapped = __vmap_pages_range_noflush(
 			vmalloc_origin(start + off),
 			vmalloc_origin(start + off + PAGE_SIZE), prot, &origin,
-			PAGE_SHIFT);
+			PAGE_SHIFT, gfp_mask);
 		if (mapped) {
 			err = mapped;
 			goto ret;
diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 212449db34a1..452760a333e4 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -247,7 +247,7 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 	origin_end = vmalloc_meta((void *)end, KMSAN_META_ORIGIN);
 	kmsan_enter_runtime();
 	mapped = __vmap_pages_range_noflush(shadow_start, shadow_end, prot,
-					    s_pages, page_shift);
+					    s_pages, page_shift, gfp_mask);
 	kmsan_leave_runtime();
 	if (mapped) {
 		err = mapped;
@@ -255,7 +255,7 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 	}
 	kmsan_enter_runtime();
 	mapped = __vmap_pages_range_noflush(origin_start, origin_end, prot,
-					    o_pages, page_shift);
+					    o_pages, page_shift, gfp_mask);
 	kmsan_leave_runtime();
 	if (mapped) {
 		/* Undo the shadow mapping set up above. */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5c1eacc2a0ac..4f3c320a4849 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -725,7 +725,8 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
  * may have contiguous chunks, as hinted by @shift.
  */
 static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
-		pgprot_t prot, struct page **pages, unsigned int shift)
+		pgprot_t prot, struct page **pages, unsigned int shift,
+		unsigned int *mapped_pages)
 {
 	unsigned long start = addr;
 	pgd_t *pgd;
@@ -748,6 +749,7 @@ static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
+	*mapped_pages = nr;
 	return err;
 }
 
@@ -758,18 +760,36 @@ static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
  * The caller is responsible for calling flush_cache_vmap() after this
  * function returns successfully and before the addresses are accessed.
  *
+ * On failure the PTEs installed by this call are torn down before
+ * returning, so a retry sees a clean range; PTEs that were already
+ * there when the walk failed are left alone. When @gfp_mask cannot
+ * block, the teardown skips cond_resched(), it may run in atomic
+ * context.
+ *
  * This is an internal function only. Do not use outside mm/.
  */
 int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-		pgprot_t prot, struct page **pages, unsigned int page_shift)
+		pgprot_t prot, struct page **pages, unsigned int page_shift,
+		gfp_t gfp_mask)
 {
+	int err;
+	unsigned int mapped_pages = 0;
+
 	if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
 		return -EINVAL;
 
 	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC))
 		page_shift = PAGE_SHIFT;
 
-	return vmap_pages_range_noflush_walk(addr, end, prot, pages, page_shift);
+	err = vmap_pages_range_noflush_walk(addr, end, prot, pages, page_shift,
+					    &mapped_pages);
+
+	/* Undo the PTEs installed before the failure. */
+	if (err && mapped_pages)
+		__vunmap_range_noflush(addr, addr + (mapped_pages * PAGE_SIZE),
+				       gfpflags_allow_blocking(gfp_mask));
+
+	return err;
 }
 
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
@@ -781,7 +801,8 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 
 	if (ret)
 		return ret;
-	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
+	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift,
+					  gfp_mask);
 }
 
 static int __vmap_pages_range(unsigned long addr, unsigned long end,
@@ -3715,7 +3736,7 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages)
 {
 	const unsigned int nr_pages = (end - addr) >> PAGE_SHIFT;
-	unsigned int prev_shift = 0, batch_idx = 0;
+	unsigned int prev_shift = 0, batch_idx = 0, nr_mapped;
 	unsigned long batch_start = addr, batch_end = addr;
 	int err;
 
@@ -3734,7 +3755,8 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
 
 		if (shift != prev_shift) {
 			err = vmap_pages_range_noflush_walk(batch_start, batch_end,
-					prot, pages + batch_idx, prev_shift);
+					prot, pages + batch_idx, prev_shift,
+					&nr_mapped);
 			if (err)
 				goto out;
 			prev_shift = shift;
@@ -3756,7 +3778,7 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
 	/* Remaining */
 	if (batch_start < end)
 		err = vmap_pages_range_noflush_walk(batch_start, end, prot,
-				pages + batch_idx, prev_shift);
+				pages + batch_idx, prev_shift, &nr_mapped);
 
 out:
 	if (!err)
diff --git a/mm/vmalloc.h b/mm/vmalloc.h
index 4ec114a75f04..9ea28845f713 100644
--- a/mm/vmalloc.h
+++ b/mm/vmalloc.h
@@ -40,7 +40,8 @@ void clear_vm_uninitialized_flag(struct vm_struct *vm);
 
 int __must_check __vmap_pages_range_noflush(unsigned long addr,
 		unsigned long end, pgprot_t prot,
-		struct page **pages, unsigned int page_shift);
+		struct page **pages, unsigned int page_shift,
+		gfp_t gfp_mask);
 
 void vunmap_range_noflush(unsigned long start, unsigned long end);
 
-- 
2.25.1


