Return-Path: <linuxppc-dev+bounces-29688-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486FCCCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 09:09:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7V910nKdz2xjN;
	Mon, 19 Oct 2026 20:09:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792400949;
	cv=none; b=eenryi1NGcQJ7wGyBOrz/7ASvWMJHT6Rl8FXdg6OkoIfuMzilDijCrxhuclBIAuyLvhyV6/OQ4cz2FTivozuKkGKwSs0lU46P6aAzHBGVF6s9b4fZsnDYpegiCXl1zclhckVOruD/1OkvI5ju7h/uAu19hayxSnRE3Kqyyvmmx1ce49KSrphXjd9Z86WJdTXyLrVse8CX/nIW/TQmDop4akTDpgDJXszQKtA4V+UDfjJ5fY1yXBpALoRVN1K7DS8cjvaQm+deZlahDve98WUhxDiSuool+Si9IACPlanOp88p9h1ySPlezwgYnGxn6cG3CKcbsQiCX6Kpm7axCs1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792400949; c=relaxed/relaxed;
	bh=MY99aGpYyrbJvUgE+53njDtXSNtzDrVyeLA7CiNpfcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neYfqGtFSTl4clZLPK2AKshKg5/e7oHSAk8Hsv/D5GFk0NWyRb6e+dohMILMF5rIN0eSlHFyelssS/CS6HzLa9Wk6vWEoIajJK2slJ842EKgt7dWm/0yWNrX+C0539ELXpzdGtSfPzANDF3YxWTKV94srd8SHs56csOxIHuaRNuHasfMVt1PwzD1SdjyKX5Q5hbip9NyitEnVDIA9HJzjzpLjC5N5Y6Bw3k344sCHf5urUwoz9ZAQHChquoyL+4HnjQYN7rtAtVinddYC+6K9255koQoGrWL8oqSv5SJYR7vlu7AC4D5JVYgORc717kxpmLzwwOkFCvahU6QTFReEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XQognmGZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XQognmGZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7V8z3H6gz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 20:09:07 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso8675365ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792400945; x=1793005745; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MY99aGpYyrbJvUgE+53njDtXSNtzDrVyeLA7CiNpfcY=;
        b=XQognmGZc7jD5B9wppZAnpJ3JnkJ/SvDtysDYb+7r1MYx1zIChxMMO317ePc6aKS2r
         QOLvzJ/b5ng1WUP9ff/nAOUNsNlu9JU7kFrTR6QU8d6qpg1KEAPOrOtGFFY5kh5VppRf
         TmJteeRyA2JCzfeDJowwBtogeaIqvkmRqy9q16xE+J9gQ0dfLhieeDHymFpAhoX5oFRk
         N46S5TxTFMi7rnVXWp3ng59RY1OcooLpMZnSTGgO/dxPFVVx82wQg0oqJ61nLngVcVyY
         5mUwbYn/en4D77XMoBhT9LZXzEFy9LOGP/0Q6OkbZSvGXTLvLWab92xPMlAz7Kiec4As
         A/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400945; x=1793005745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MY99aGpYyrbJvUgE+53njDtXSNtzDrVyeLA7CiNpfcY=;
        b=qXo2yyUJJ0L97Tb8RgB+tevuEkbYbQXe30zCdUCXMnAMkSBhXmoABZw6hPqTzw7h01
         gU0otDqP9y/uTGkUxK0qxUO+ZqyNyidO0f6UGOd8MyeU3EAO8TfodUmQ6nB+7CAaB79u
         gn8phchrmkED3f8hmFtel9C6i4A7XTeUlKO+4EZPvvM+x2Ce9ICyxKDHe3slCNUWeoSK
         AukaL5+2wey684m3BIYJoF1jIcBMCYfPtQXvvnBw0AFtnCkICj8YXA3t49eFwFdYyVmm
         VrYIKCdp1MMRnKu+Mof8AsVZkHRWy+3ct4eKBSDR750W7T5dpqtN61tA+aiB52fNBCWb
         8DmA==
X-Forwarded-Encrypted: i=1; AKwUvBz330Lnf7o5s/J6SQP66rVQaimSqBxlHgkqg0QRLx55+zL3B9CHH1uywqNqCeSvAy3AE8mjR9KdXSBw8Xo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL7Nxku6qRW5TSZWQKcrmIFQv24gpvcjoWFb/xh3hYpY4FJGv2i
	MpWWKQQm0VaTs0S25/YE412nvYC9k9RQyPHRu6/RxVMoflRCF0GeLJ8jNVTd810o9GE=
X-Gm-Gg: AYBFou2oQENrOWs7zQ9S5mRRdkO+m062K0UHzn7vFXrX9Kx22bQBHYKDcN4PhGJcPuN
	Awio3LHNp5fPxl/QnmFWYEDCy5PBziu9eI5bwRrsCvPyKAw5jERprJb0weXLllhwoXh8FcGkeqW
	mfLIawfIBkO6M5Df0uQCZKSvWU9Jwi0am2uX9dKgOWNOmDHFlm/xnj1LQCebrQ/mlaT/HGjDj5O
	q/5Qf1TO2gDbnOEeTAgg784wZF6UR3kP8ZePW72/l79g+ysDfmiDLLviomSRPSrETVbNVccJeo2
	c3OeiE8xDe03EUFd0dUcM2h8cx2n4znuDVGeIYXTxzS0hbg7gVdopW5HD2sbAI+gjYSvBk+HE40
	xVr2rQoQ+IdGuQ8pU3Q6U/I3K8kZdona9l8xDKL1GRbVOG7o6/hXwgu5MnacTah8qJocSBbFhIs
	LykLO6oPve2KvGCFJ18u+VEl4MCwAr2pokQl0bR/e+kvyCvm5Dr4nwJkaTauDOn47BudJuxVTkg
	Q8mPjwzzfMkfomGrh8=
X-Received: by 2002:a17:902:ccd2:b0:2e8:1d5c:f6f9 with SMTP id d9443c01a7336-2e9a6f51258mr61061775ad.46.1792400945396;
        Mon, 19 Oct 2026 02:09:05 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e305f1dsm36707595ad.0.2026.10.19.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:09:04 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Muchun Song <muchun.song@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/4] mm/hugetlb_vmemmap: remove hugetlb_vmemmap_optimize_bootmem_folios()
Date: Mon, 19 Oct 2026 17:08:30 +0800
Message-ID: <20261019090830.1917657-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019090830.1917657-1-songmuchun@bytedance.com>
References: <20261019090830.1917657-1-songmuchun@bytedance.com>
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

With vmemmap_wrprotect_hvo() removed, the bootmem wrapper no longer
performs any bootmem-specific work.

Call hugetlb_vmemmap_optimize_folios() directly for bootmem folios and
remove the redundant wrapper.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         |  2 +-
 mm/hugetlb_vmemmap.c | 29 ++++-------------------------
 mm/hugetlb_vmemmap.h |  6 ------
 3 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b37d7d0db7fc..64a21b7e820f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3297,7 +3297,7 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 	struct folio *folio, *tmp_f;
 
 	/* Send list for bulk vmemmap optimization processing */
-	hugetlb_vmemmap_optimize_bootmem_folios(h, folio_list);
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
 
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
 		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 3d72346c2ca2..236e1db9517b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -588,19 +588,16 @@ static int hugetlb_vmemmap_split_folio(const struct hstate *h, struct folio *fol
 	return vmemmap_remap_split(vmemmap_start, vmemmap_end);
 }
 
-static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
-					      struct list_head *folio_list,
-					      bool boot)
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
-	int nr_to_optimize;
+	unsigned long nr_to_optimize = 0;
 	LIST_HEAD(vmemmap_pages);
 	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH;
 
 	if (list_empty(folio_list))
 		return;
 
-	nr_to_optimize = 0;
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
 
@@ -608,7 +605,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		 * Bootmem gigantic folios may already be marked optimized when
 		 * their vmemmap layout was prepared earlier, so skip them here.
 		 */
-		if (boot && folio_test_hugetlb_vmemmap_optimized(folio))
+		if (folio_test_hugetlb_vmemmap_optimized(folio))
 			continue;
 
 		nr_to_optimize++;
@@ -626,14 +623,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 	}
 
 	if (!nr_to_optimize)
-		/*
-		 * All pre-HVO folios, nothing left to do. It's ok if
-		 * there is a mix of pre-HVO and not yet HVO-ed folios
-		 * here, as __hugetlb_vmemmap_optimize_folio() will
-		 * skip any folios that already have the optimized flag
-		 * set, see vmemmap_should_optimize_folio().
-		 */
-		goto out;
+		return;
 
 	flush_tlb_all();
 
@@ -658,21 +648,10 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		}
 	}
 
-out:
 	flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
-{
-	__hugetlb_vmemmap_optimize_folios(h, folio_list, false);
-}
-
-void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list)
-{
-	__hugetlb_vmemmap_optimize_folios(h, folio_list, true);
-}
-
 void __init hugetlb_vmemmap_optimize_bootmem_page(unsigned long pfn, unsigned int order)
 {
 	if (!READ_ONCE(vmemmap_optimize_enabled))
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 464192e32dec..d717d0d10960 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -24,7 +24,6 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *non_hvo_folios);
 void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
-void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list);
 void hugetlb_vmemmap_optimize_bootmem_page(unsigned long pfn, unsigned int order);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
@@ -66,11 +65,6 @@ static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list
 {
 }
 
-static inline void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h,
-						struct list_head *folio_list)
-{
-}
-
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
-- 
2.54.0


