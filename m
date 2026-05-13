Return-Path: <linuxppc-dev+bounces-20911-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C1BCD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:22:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvJq3xF1z2yVd;
	Wed, 13 May 2026 23:22:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678555;
	cv=none; b=BlPL8MTojKoqAhuY9yZJvITGUGsOQDU7L9rLfLn2AlGlrcY2QZNHR2eug+Pek9ZZHCVKnL5x51cTS4uc4Y2TxoiDqJhXLbAiROk6YjX4MZNpeHeEU2I6j8BpO/iGdfYCQEffWZZO8icxinEtlMRPuYw5M67x4ADKFp8dtcvDLvqKTh3z7+xhpCRj8YPIl/eyqhcHbJEG0N0a1SHwgrUxfYX5UDONOXBoI9vmgbRIXB/GOuCtjnLCyhsQgF4SIOwl+66FzOoZf7YWFKLypwSOQcX77AvCmjqLKwo00eNsDCzt9rbkN6r6eGogD1FsLf01415QmzHFwtarSe5Ua7xYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678555; c=relaxed/relaxed;
	bh=x2kKgj5K23Ztq0NiYkfPLR6EY3A9OUYR9zP+JIm9wZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBJar5HJekIX7gZ0SpxYN8HQ2bcGpBGY6TsA5uN4Q2zUwSQ7tbr5JXncmygNerkeIuSxqQWvIqUclN1eKV5MubxO7Q8mhvLzfVX+VgSeXowEkkC/GGfmaN0Cei6DuATYvxwdW3KddHM+x5gDN5H+Swq0zF8PC4P4BJZCkxYh8P30n2NHXwaVGgqWMe+eM+oK1GeHAkLedvFHzcwqy/PiDvQuonp97EGOaEdo8NXMKw0efS89gcFVG6pJNcaaktWBzRXqKsDwmNtumB9xa1eNahpF20UzToOOjyEvbv9SoQVZ6s51xTjISfwwF00p52NZQ/IAC66KY3ohBwrm0sizbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VHrax/ao; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VHrax/ao;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvJp5gGYz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:22:34 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-366070f71adso6068680a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678553; x=1779283353; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2kKgj5K23Ztq0NiYkfPLR6EY3A9OUYR9zP+JIm9wZc=;
        b=VHrax/aoCwZJuHAEMqQVkljszPmv90OscpTobabuwAE2ZI8CMjVOuvNd1nABawTbiV
         YRkd7v/U/MpfnoIRZy5YcnX9DHGgQ/fqJxc8YV40acJKj9c0kw2YC2U9NCtHOLmUC2jy
         HpfF6Td+ai7e/pMLV6X92aIaCGT1GPHzXo2UKFQUZ8oyyCCO8WvWJNY+JUQNJEGfdiEJ
         nbFCtZrMKAMyLYpMtP0YWszuyZLKN2nihEbz7+sZjyuRi7ZSuNZTcUJMGV5ZpfDh8zD0
         AdoWLLBqh65ktq/2lULPAs4Ndy1Hna0qYiuqPwLRTtk9tZOWTgQXG8eA/tk0AKWLuKj6
         PyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678553; x=1779283353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x2kKgj5K23Ztq0NiYkfPLR6EY3A9OUYR9zP+JIm9wZc=;
        b=CnKkKdUj+4CIe6+TJVufbh+2Qt2bOZgh90jR4oTkepPJNAAG7/EcgzJhoH2o0CVqMZ
         UatEQBpNgrH/J55kUJALSQmOmIqeIS4ay18HmeBkW8FNRQ3zlKvSR3w7g77sx82drx5t
         TxxkDqQ5ka26itLy2gUBl8hva5qRTEj8wWkRDdFQsaNg1cT5SrlhrBnxuUWrt7spKW5A
         ymZPwhVECfzwnXkSBExL7SZrYWL9TDLfXjdt0cUlPdYqhxwmcmU/HhK9bQDNov/Pt7YZ
         2O+VXOJdFq0tb2/CzFPGRYs/q61EdugD00Z3wEUE7AT2+V07SnmUufFJNjiu6YEREPmt
         Wdmw==
X-Forwarded-Encrypted: i=1; AFNElJ/a2LnkWQRLa3OjwpJijGNhPXkgKhBof/anmDLhxUbjG9OL07m6E1+Rx6RwJlCzIMhPP18IPr3duwhh0ZQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzWooik9rD/ITrIItqyWbF6X5Mf5LvTumppjNXM5W9GamjSWLwS
	GHUwiX0KNrGuPC/0z+lmjd85UeX8D0pdDjALa7GiMdTZEQMwMuao1PhK5bMYmIPXXAA=
X-Gm-Gg: Acq92OEIMl84n3Yyn6Od4nI1TjoQQAdsrspX1+/GLpyvduyyPQ7Q9V7i1OOdZduoPqN
	LQnHjRNwZSymXNbzn/bqOTumkaPoY8YwUIonPcgziIuwFfLeW5pKZzpwy9ssfRlZcd/z7s7IFP4
	xgmXgGPO6QcHcHxdySTFDn7OxsC6A+N00OZeGKbocrI9xxrB8qKdMARytkE4CrWvzkWo0jvYrlk
	MG/5UH0/yjWOTVW0hOv0SFaggw9wTrFoH59hHkMY6sMCN8HHKqYJHSfVBprswIYlgUiC7QA5kvH
	qG7Md3G0XVMwx42hTZh+VxwKSpZCJTbeOIPeB8TxFaSmjhtCZktmnlJfNKt+JNuXZiD4CA587az
	bYMeTy13iw/lYTb5bzxYoLZPHB4sb64M0BQZS9KAfewfsLIDtHc745IA18yQSWDWoQTJdZSySub
	inoUxY/B3isHYvHLJH21CEC5mwPlT8ZfptKr8sp4caDSYjIDq7vG7i2uhJM193
X-Received: by 2002:a17:90b:3d44:b0:365:7e4d:bcb8 with SMTP id 98e67ed59e1d1-368f77f1013mr2804387a91.1.1778678552706;
        Wed, 13 May 2026 06:22:32 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.22.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:22:32 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 62/69] mm/hugetlb: Simplify hugetlb_folio_init_vmemmap()
Date: Wed, 13 May 2026 21:20:27 +0800
Message-ID: <20260513132044.41690-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

hugetlb_folio_init_vmemmap() currently splits the open-coded
compound-page setup across two helpers even though the tail-page
initialization is only used here.

Fold the tail-page initialization into the main helper and pass
the precomputed page metadata in from the caller. This makes
the initialization flow easier to follow.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 50 +++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3cb8fffb9e3e..950b0fa3bc27 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3126,33 +3126,8 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 	return true;
 }
 
-/* Initialize [start_page:end_page_number] tail struct pages of a hugepage */
-static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
-					struct hstate *h,
-					unsigned long start_page_number,
-					unsigned long end_page_number)
-{
-	enum zone_type zone = folio_zonenum(folio);
-	int nid = folio_nid(folio);
-	struct page *page = folio_page(folio, start_page_number);
-	unsigned long head_pfn = folio_pfn(folio);
-	unsigned long pfn, end_pfn = head_pfn + end_page_number;
-	unsigned int order = huge_page_order(h);
-
-	/*
-	 * As we marked all tail pages with memblock_reserved_mark_noinit(),
-	 * we must initialize them ourselves here.
-	 */
-	for (pfn = head_pfn + start_page_number; pfn < end_pfn; page++, pfn++) {
-		__init_single_page(page, pfn, zone, nid);
-		prep_compound_tail(page, &folio->page, order);
-		set_page_count(page, 0);
-	}
-}
-
-static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
-					      struct hstate *h,
-					      unsigned long nr_pages)
+static void __init hugetlb_folio_init_vmemmap(struct page *head, unsigned long pfn,
+		enum zone_type zone, int nid, unsigned int order, unsigned int nr_pages)
 {
 	int ret;
 
@@ -3161,12 +3136,19 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 	 * walking pages twice by initializing/preparing+freezing them in the
 	 * same go.
 	 */
-	__folio_clear_reserved(folio);
-	__folio_set_head(folio);
-	ret = folio_ref_freeze(folio, 1);
+	__ClearPageReserved(head);
+	ret = page_ref_freeze(head, 1);
 	VM_BUG_ON(!ret);
-	hugetlb_folio_init_tail_vmemmap(folio, h, 1, nr_pages);
-	prep_compound_head(&folio->page, huge_page_order(h));
+
+	__SetPageHead(head);
+	for (int i = 1; i < nr_pages; i++) {
+		struct page *page = head + i;
+
+		__init_single_page(page, pfn + i, zone, nid);
+		prep_compound_tail(page, head, order);
+		set_page_count(page, 0);
+	}
+	prep_compound_head(head, order);
 }
 
 /*
@@ -3226,6 +3208,7 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		struct folio *folio = (void *)page;
 		unsigned long pfn = PHYS_PFN(__pa(m));
 		unsigned long nr_pages = pages_per_huge_page(m->hstate);
+		enum zone_type zone = folio_zonenum(folio);
 
 		h = m->hstate;
 		/*
@@ -3239,7 +3222,8 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
 
-		hugetlb_folio_init_vmemmap(folio, h, vmemmap_nr_struct_pages(pfn, nr_pages));
+		hugetlb_folio_init_vmemmap(page, pfn, zone, nid, huge_page_order(h),
+					   vmemmap_nr_struct_pages(pfn, nr_pages));
 		init_new_hugetlb_folio(folio);
 
 		if (order_vmemmap_optimizable(pfn_to_section_order(pfn))) {
-- 
2.54.0


