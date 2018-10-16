Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9190C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:32:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D9D20869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRnnDkdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D9D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZGST066xzF3Wk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:32:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QRnnDkdr";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QRnnDkdr"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZG3y5ZhTzF3W9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 00:14:22 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id j23-v6so11445238pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Wozx3I6t1Z6fZ+0xttJ6rllGkcnzPt2KAsF0ALUBnnI=;
 b=QRnnDkdrX4fTuAStV0TssQmvg1tQGZDM8vwrwyePkqEPHeenfDLv/cItj0JX95n69G
 z/jVDqEaBiBrP+MCux6xsHe8ceWLckKJyYmwS2L38fAkinSn2GD/WWuGpyEw95WtG0ub
 V/Uhabhj24big4D6uo/4ZkeWohj7BQHqqv7c09ZBuAuEm34YxZgn5plnw1psItwCJGoL
 zzuBpbBoeYk0qesuFnzoPrdViEUg4i9rMh1GV/bP3wUAan7fBuk9DdbLzpFF2Vy1cosG
 0uMbbR8trBZmW0mfb/w+Wc24TkIyRYwl39mgvpMJYP4uPJnprMkcGzs4cPlwH4A4lbMW
 Hs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Wozx3I6t1Z6fZ+0xttJ6rllGkcnzPt2KAsF0ALUBnnI=;
 b=rKf/+mXu59+10vBtz6QYmtl0XQS1IIqDYatXlp4qlItBBj6Z7XgDVFNh/pDBncYXV5
 ICT9ncZNKrUJY8IuHYpqo7gt7Kpsc7LqTuVT/NmTd4P95Sjzqgx35g0G1LMNgbX7EwTT
 lEckI5h51LKBhkkIaNt/0KFs5PbCrp2fahMsj/Kh2b/IIeO7D/mltlapNklbWMvpPSjp
 W1paLKu97iYt69vNrkfMJ76KIyrAMJ864pbrMTAEASimzRUw37E9xmoX5zp2dsvj8dn9
 NTwkMu0sJfIsiDdE+bvgX66jaZRAPTW9SKTQMTFQm8XPAU06lQPcWSNQdC1Uh9NvONgD
 MdEw==
X-Gm-Message-State: ABuFfojjFvIk8kcKFux2RVzW/CXpTtR0NKzDVFKg9MfoR0th1mt7lrNq
 c71rDUbhprK9BaSEQC8qMIs=
X-Google-Smtp-Source: ACcGV62PowkKGuB1+DTkoNK49/BnGHkMHGcEPghSygGdFtY1eXOZ5nEe+W/s+bLONLOvO07moh8WRA==
X-Received: by 2002:a63:db55:: with SMTP id
 x21-v6mr19632152pgi.365.1539695661103; 
 Tue, 16 Oct 2018 06:14:21 -0700 (PDT)
Received: from roar.local0.net ([60.240.252.156])
 by smtp.gmail.com with ESMTPSA id j62-v6sm16043423pgd.40.2018.10.16.06.14.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Oct 2018 06:14:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 5/5] mm: optimise pte dirty/accessed bit setting by demand
 based pte insertion
Date: Tue, 16 Oct 2018 23:13:43 +1000
Message-Id: <20181016131343.20556-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181016131343.20556-1-npiggin@gmail.com>
References: <20181016131343.20556-1-npiggin@gmail.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linux-mm <linux-mm@kvack.org>,
 Ley Foon Tan <ley.foon.tan@intel.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Similarly to the previous patch, this tries to optimise dirty/accessed
bits in ptes to avoid access costs of hardware setting them.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/huge_memory.c | 12 ++++++++----
 mm/memory.c      |  9 ++++++---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1f43265204d4..38c2cd3b4879 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1197,6 +1197,7 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
 		pte_t entry;
 		entry = mk_pte(pages[i], vma->vm_page_prot);
+		entry = pte_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		memcg = (void *)page_private(pages[i]);
 		set_page_private(pages[i], 0);
@@ -2067,7 +2068,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	struct page *page;
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
-	bool young, write, soft_dirty, pmd_migration = false;
+	bool young, write, dirty, soft_dirty, pmd_migration = false;
 	unsigned long addr;
 	int i;
 
@@ -2145,7 +2146,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		page = pmd_page(old_pmd);
 	VM_BUG_ON_PAGE(!page_count(page), page);
 	page_ref_add(page, HPAGE_PMD_NR - 1);
-	if (pmd_dirty(old_pmd))
+	dirty = pmd_dirty(old_pmd);
+	if (dirty)
 		SetPageDirty(page);
 	write = pmd_write(old_pmd);
 	young = pmd_young(old_pmd);
@@ -2176,8 +2178,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			entry = maybe_mkwrite(entry, vma);
 			if (!write)
 				entry = pte_wrprotect(entry);
-			if (!young)
-				entry = pte_mkold(entry);
+			if (young)
+				entry = pte_mkyoung(entry);
+			if (dirty)
+				entry = pte_mkdirty(entry);
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
 		}
diff --git a/mm/memory.c b/mm/memory.c
index 9e314339a0bd..f907ea7a6303 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1804,10 +1804,9 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 		entry = pte_mkspecial(pfn_t_pte(pfn, prot));
 
 out_mkwrite:
-	if (mkwrite) {
-		entry = pte_mkyoung(entry);
+	entry = pte_mkyoung(entry);
+	if (mkwrite)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-	}
 
 	set_pte_at(mm, addr, pte, entry);
 	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
@@ -2534,6 +2533,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
+		entry = pte_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		/*
 		 * Clear the pte entry and flush it first, before updating the
@@ -3043,6 +3043,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
 	pte = mk_pte(page, vma->vm_page_prot);
+	pte = pte_mkyoung(pte);
 	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 		vmf->flags &= ~FAULT_FLAG_WRITE;
@@ -3185,6 +3186,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	__SetPageUptodate(page);
 
 	entry = mk_pte(page, vma->vm_page_prot);
+	entry = pte_mkyoung(entry);
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
 
@@ -3453,6 +3455,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
+	entry = pte_mkyoung(entry);
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	/* copy-on-write page */
-- 
2.18.0

