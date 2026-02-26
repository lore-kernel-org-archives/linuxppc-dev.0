Return-Path: <linuxppc-dev+bounces-17245-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC076FC5935
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:33:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM8V91xYtz3bf3;
	Thu, 26 Feb 2026 22:33:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.186
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772105617;
	cv=none; b=JW2tsDY/OrwqBrVxbR3+4AzACx90EiFS/YA5PZwC0SFCeN9vL3WL3EKvOyWFlQRMRzdxdxhbffDt7cPshE9H25lp5aFe0BN/2a3aEScQ5DWw1hwjbGpBZF/wqqTgKiMYN0kWb/ZXi7ohZgqB1cptFLEwGDQLKz/5PYbKbhDkpr68Qnk8CXHe/7V4QqHAQT3v1x5jiz/q1E39c5WLkuMxSOuEQXCJne1rs2hW6VgzyBIasR8EzxVO/cXKZT+1IVm7YbCMPLEndmBbtb9oUUauDHcnodYUOEyrlxcgYYdiE/rofJJBO6M0KcYXjdEDRhU2ZyxIO/2pH/9M7UPPgK+/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772105617; c=relaxed/relaxed;
	bh=2wV75ycWB4G3qq8SlJolQA0LHwO/bo1HFS74uWGxBRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyZruZhT+X4hrZWTjvrua+QitZlFBZTPVCOnZePjCv0ATjtRwrjFnx5UfH8Xp/cq4y1XSBtqU8S06uy9JkePBIuJcLvF5Ni3R8YmS7r+Zfoz/WIW/CaOOfZLPxGQV/gf8atmuDrlCj9ds33iZXOuxQqjr4284w7iO0L6voQxQPiUEB5ebzfntoNH6Bz9PfyW05Kxg7n2vSLQCFjLygsq3Xb0FACHpjgNvblHBrS1uJEbb+Zi2omqSAI4j+QUhqQa46fgKEo6Imw4G6Ha/6CVqY2c5ADDCFb924QffM4+sDjOO8buvk69qyRgufcGjZ1g2Tcuq0bfCxmcHR3ZSQQVDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ntm7c4wG; dkim-atps=neutral; spf=pass (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ntm7c4wG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM8V82VYrz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 22:33:36 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wV75ycWB4G3qq8SlJolQA0LHwO/bo1HFS74uWGxBRw=;
	b=Ntm7c4wGMxkHypNZVQKbHs8TTIz27iUQ6yNvJF8E1SZ+Fq3QLZZ+cJB62Cw0Bd3ziCm6pj
	SmukNQafpR/c4gmMWxFcvO732rYRlWl8/zW+U+JjZixPks++JafCzkFlL73zeKLtzOPfAf
	PD/PlDtkk+CZZAVIdlqmB0cfhdOs3OA=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [RFC v2 02/21] mm: thp: propagate split failure from vma_adjust_trans_huge()
Date: Thu, 26 Feb 2026 03:23:31 -0800
Message-ID: <20260226113233.3987674-3-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-1-usama.arif@linux.dev>
References: <20260226113233.3987674-1-usama.arif@linux.dev>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

With lazy PTE page table allocation, split_huge_pmd_if_needed() and
thus vma_adjust_trans_huge() can now fail if order-0 allocation
for pagetable fails when trying to split. It is important to check
if this failure occurred to prevent a huge PMD straddling at VMA
boundary.

The vma_adjust_trans_huge() call is moved before vma_prepare() in all
three callers (__split_vma, vma_shrink, commit_merge). Previously it sat
between vma_prepare() and vma_complete(), where there is no mechanism to
abort - once vma_prepare() has been called, we must reach vma_complete().
By moving the call earlier, a split failure can return -ENOMEM cleanly
without needing to undo VMA preparation.

This move is safe because vma_adjust_trans_huge() acquires its own
pmd_lock() internally and does not depend on any locks or state changes
from vma_prepare(). The VMA boundaries are also unchanged at the new
call site, satisfying __split_huge_pmd_locked()'s requirement that the
VMA covers the full PMD range.

All 3 callers (__split_vma, vma_shrink, commit_merge) already return
-ENOMEM if there are allocation failures for other reasons (failure in
vma_iter_prealloc for example), this follows the same pattern.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/huge_mm.h           | 13 ++++++-----
 mm/huge_memory.c                  | 21 +++++++++++++-----
 mm/vma.c                          | 37 +++++++++++++++++++++----------
 tools/testing/vma/include/stubs.h |  9 ++++----
 4 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e4cbf5afdbe7e..207bf7cd95c78 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -484,8 +484,8 @@ int hugepage_madvise(struct vm_area_struct *vma, vm_flags_t *vm_flags,
 		     int advice);
 int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end, bool *lock_dropped);
-void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
-			   unsigned long end, struct vm_area_struct *next);
+int vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
+			  unsigned long end, struct vm_area_struct *next);
 spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
 spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma);
 
@@ -687,11 +687,12 @@ static inline int madvise_collapse(struct vm_area_struct *vma,
 	return -EINVAL;
 }
 
-static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
-					 unsigned long start,
-					 unsigned long end,
-					 struct vm_area_struct *next)
+static inline int vma_adjust_trans_huge(struct vm_area_struct *vma,
+					unsigned long start,
+					unsigned long end,
+					struct vm_area_struct *next)
 {
+	return 0;
 }
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 125ff36f475de..a979aa5bd2995 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3316,20 +3316,31 @@ static inline int split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned
 	return 0;
 }
 
-void vma_adjust_trans_huge(struct vm_area_struct *vma,
+int vma_adjust_trans_huge(struct vm_area_struct *vma,
 			   unsigned long start,
 			   unsigned long end,
 			   struct vm_area_struct *next)
 {
+	int err;
+
 	/* Check if we need to split start first. */
-	split_huge_pmd_if_needed(vma, start);
+	err = split_huge_pmd_if_needed(vma, start);
+	if (err)
+		return err;
 
 	/* Check if we need to split end next. */
-	split_huge_pmd_if_needed(vma, end);
+	err = split_huge_pmd_if_needed(vma, end);
+	if (err)
+		return err;
 
 	/* If we're incrementing next->vm_start, we might need to split it. */
-	if (next)
-		split_huge_pmd_if_needed(next, end);
+	if (next) {
+		err = split_huge_pmd_if_needed(next, end);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static void unmap_folio(struct folio *folio)
diff --git a/mm/vma.c b/mm/vma.c
index be64f781a3aa7..f50b1f291ab7c 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -510,6 +510,15 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			return err;
 	}
 
+	/*
+	 * Split any THP straddling the split boundary before splitting
+	 * the VMA itself. Do this before vma_prepare() so we can
+	 * cleanly fail without undoing VMA preparation.
+	 */
+	err = vma_adjust_trans_huge(vma, vma->vm_start, addr, NULL);
+	if (err)
+		return err;
+
 	new = vm_area_dup(vma);
 	if (!new)
 		return -ENOMEM;
@@ -547,11 +556,6 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vp.insert = new;
 	vma_prepare(&vp);
 
-	/*
-	 * Get rid of huge pages and shared page tables straddling the split
-	 * boundary.
-	 */
-	vma_adjust_trans_huge(vma, vma->vm_start, addr, NULL);
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_split(vma, addr);
 
@@ -729,6 +733,7 @@ static int commit_merge(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *vma;
 	struct vma_prepare vp;
+	int err;
 
 	if (vmg->__adjust_next_start) {
 		/* We manipulate middle and adjust next, which is the target. */
@@ -740,6 +745,16 @@ static int commit_merge(struct vma_merge_struct *vmg)
 		vma_iter_config(vmg->vmi, vmg->start, vmg->end);
 	}
 
+	/*
+	 * THP pages may need to do additional splits if we increase
+	 * middle->vm_start. Do this before vma_prepare() so we can
+	 * cleanly fail without undoing VMA preparation.
+	 */
+	err = vma_adjust_trans_huge(vma, vmg->start, vmg->end,
+				  vmg->__adjust_middle_start ? vmg->middle : NULL);
+	if (err)
+		return err;
+
 	init_multi_vma_prep(&vp, vma, vmg);
 
 	/*
@@ -752,12 +767,6 @@ static int commit_merge(struct vma_merge_struct *vmg)
 		return -ENOMEM;
 
 	vma_prepare(&vp);
-	/*
-	 * THP pages may need to do additional splits if we increase
-	 * middle->vm_start.
-	 */
-	vma_adjust_trans_huge(vma, vmg->start, vmg->end,
-			      vmg->__adjust_middle_start ? vmg->middle : NULL);
 	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
 	vmg_adjust_set_range(vmg);
 	vma_iter_store_overwrite(vmg->vmi, vmg->target);
@@ -1229,9 +1238,14 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff)
 {
 	struct vma_prepare vp;
+	int err;
 
 	WARN_ON((vma->vm_start != start) && (vma->vm_end != end));
 
+	err = vma_adjust_trans_huge(vma, start, end, NULL);
+	if (err)
+		return err;
+
 	if (vma->vm_start < start)
 		vma_iter_config(vmi, vma->vm_start, start);
 	else
@@ -1244,7 +1258,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	init_vma_prep(&vp, vma);
 	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, start, end, NULL);
 
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
index 947a3a0c25665..171986f9c9fcd 100644
--- a/tools/testing/vma/include/stubs.h
+++ b/tools/testing/vma/include/stubs.h
@@ -418,11 +418,12 @@ static inline int vma_dup_policy(struct vm_area_struct *src, struct vm_area_stru
 	return 0;
 }
 
-static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
-					 unsigned long start,
-					 unsigned long end,
-					 struct vm_area_struct *next)
+static inline int vma_adjust_trans_huge(struct vm_area_struct *vma,
+					unsigned long start,
+					unsigned long end,
+					struct vm_area_struct *next)
 {
+	return 0;
 }
 
 static inline void hugetlb_split(struct vm_area_struct *, unsigned long) {}
-- 
2.47.3


