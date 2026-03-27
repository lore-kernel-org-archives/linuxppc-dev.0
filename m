Return-Path: <linuxppc-dev+bounces-18857-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C11B10AB83C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:16:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhklL6YWHz2ypm;
	Fri, 27 Mar 2026 13:15:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577758;
	cv=none; b=iKmzxq6aGCfYhcJC1jNSrB1SA3OFUFO0f3yQdLGG/VzvGJNVfytA7bi4VDxh7ZX5hQ9jp+aD7ku0kCssH2tT+OcBCOHcFEcqk+oOWR0R35QQ3mNtSWTvM0gIsibr4x2/rRo2kFBwryUKW9r2crjsHZ2YQ5AdJr2jOA+jrQ+Fs2JIxJa0jD9eGtutquGkwnvGfhRYnY7FoFXES7+j0IzZvUrnN9OGCM8/0Yf5WTSDD4bVkOLEu3ihfaU/MonFUBMQzzsqs9AsY2WL0ig7sGwsTX8IbQXaGKGFJ282x/11FSbwJ2Xo324Z7ZTQu95nh8BwQjZy7xBJttGfXGeoxmEEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577758; c=relaxed/relaxed;
	bh=DA9DXWIy9I9hYoDDZ6d9idv8WvO7k2GsFa78UasupfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTOi1j63eAJxKUo55QTWB0XKLQhO5AABw/7mnEoE3j6E912p/0EeyO6jIGOTWCn8cV2mZYyv1us0fclxkggexyQ8ai7/Vvb+iVJ+IIbCqFAUdKPRafSocjHHsW9kzyZSKZL/EFCVxZk8xoRhzvtmvKRe/pWm9vW+LImST+6CL/2dYnVbLUM8uOUE5+MpwVg0dOtSGV0YcX2YC/HHmNvfSp3TNeMISMe730dN1NQ9q3ySoGO0glpu2yRvSgja105MoJgsZgnBoO76V91AqO6Swr/fFeVsGDlXO1K0/l+XTvOQGC+Vxt3OSamX5tF4uUdqSXfahRttnRbGoPXFzkkMsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w7b0PFKI; dkim-atps=neutral; spf=pass (client-ip=95.215.58.178; helo=out-178.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w7b0PFKI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.178; helo=out-178.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhklL1Y4cz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:15:58 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DA9DXWIy9I9hYoDDZ6d9idv8WvO7k2GsFa78UasupfU=;
	b=w7b0PFKIYHL5VzgfVOmJaU8mndUe+9d3TAczYvwOPmlWZPC+YdbN4753/gZVXBv6rf/e2p
	hhxdxl4rOelbJ74Wb6vwZdxneuTlP5Mo2CuIkJfQOwBMurDfXHMHtfo4IP9DtIrgPBP2Dl
	uZc/JaknYWmWWlMxr4qMjjDLSrv/rhw=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: [v3 14/24] powerpc/mm: handle split_huge_pmd failure in subpage_prot
Date: Thu, 26 Mar 2026 19:08:56 -0700
Message-ID: <20260327021403.214713-15-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
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

subpage_walk_pmd_entry() splits huge PMDs when the subpage_prot
syscall controls the access permissions on individual 4 kB.

In practice this cannot fail today: sys_subpage_prot() returns -ENOENT
early when radix is enabled, and on hash powerpc
arch_needs_pgtable_deposit() is true so split uses the pre-deposited
page table and always succeeds. The change is for __must_check
compliance introduced in a later patch and correctness if the call
chain ever becomes reachable on architectures with lazy PTE allocation.

Propagate the error through the full call chain up to the syscall.
The syscall already returns -ENOMEM in other places when it runs out
of memory.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 arch/powerpc/mm/book3s64/subpage_prot.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index 37d47282c3686..b3635a11ff433 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -139,8 +139,8 @@ static int subpage_walk_pmd_entry(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, struct mm_walk *walk)
 {
 	struct vm_area_struct *vma = walk->vma;
-	split_huge_pmd(vma, pmd, addr);
-	return 0;
+
+	return split_huge_pmd(vma, pmd, addr);
 }
 
 static const struct mm_walk_ops subpage_walk_ops = {
@@ -148,11 +148,12 @@ static const struct mm_walk_ops subpage_walk_ops = {
 	.walk_lock	= PGWALK_WRLOCK_VERIFY,
 };
 
-static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
-				    unsigned long len)
+static int subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
+				   unsigned long len)
 {
 	struct vm_area_struct *vma;
 	VMA_ITERATOR(vmi, mm, addr);
+	int err;
 
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
@@ -160,14 +161,17 @@ static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
 	 */
 	for_each_vma_range(vmi, vma, addr + len) {
 		vm_flags_set(vma, VM_NOHUGEPAGE);
-		walk_page_vma(vma, &subpage_walk_ops, NULL);
+		err = walk_page_vma(vma, &subpage_walk_ops, NULL);
+		if (err)
+			return err;
 	}
+	return 0;
 }
 #else
-static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
-				    unsigned long len)
+static int subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
+				   unsigned long len)
 {
-	return;
+	return 0;
 }
 #endif
 
@@ -229,7 +233,9 @@ SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
 		mm->context.hash_context->spt = spt;
 	}
 
-	subpage_mark_vma_nohuge(mm, addr, len);
+	err = subpage_mark_vma_nohuge(mm, addr, len);
+	if (err)
+		goto out;
 	for (limit = addr + len; addr < limit; addr = next) {
 		next = pmd_addr_end(addr, limit);
 		err = -ENOMEM;
-- 
2.52.0


