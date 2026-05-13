Return-Path: <linuxppc-dev+bounces-20877-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC65ECD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:11:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv2V4bN3z2yY0;
	Wed, 13 May 2026 23:10:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677810;
	cv=none; b=nzmi7hivEUEEIqXotqCQTuXclFBwPwTuuWLu1zPHPGJf/ixD/1tzJYolGGqRKwtuk0iXwr+u5ZZ8aM7Li0f7u7PGrtvsP1L2+iRSSxn6S2nLE+63Vj3cdbSBMCKEMxY3wKoH+Jj5n40reAFGmigHsHj01KwfgdWn/wZo0IIj3MNdzOEGtgC1w0wjxfqV5N1jrTCx9rOImS9kfSjQBkebvbGvIw1k3UexrFzvXgFG3zdvGC+4KwK/X+Si4+LZp5aRrr+CYlAtsHt7jeySD12Kz5fds58YTxQdF+Jo0C5/qCaMoG5ma/GDGELCgXu2dMGL1zz0xr9mlHwl4YQzt2z7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677810; c=relaxed/relaxed;
	bh=wj09+T2FktkdLwU79u80MiVhyJiQtKDMnM2x4Hjwdtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UG4bvzXCyDZjUywohk7ZihBvzSxgxhGslOjtHR5e6aLFRUgtIczfV3oAUn8g70eh6wDU+2IOK2hxxqijB9JNw1tdlIoE2+SB3oTTqigP/+k71nU1C75hFvR5kaoj/NcRUf19MMPkhfVVwQ1L7Q7ajaaBnE/UF49NvYY+d71aCfCquWXYdOG2hCyKUAw6mffHXMmKC84z1y4i3wI3Mt0PXPWib0tn5ijjHFPEKKzw9uj55wwVBqYwRSJaQeplFeYUyja3gyU3I2YuKleoZuK0dewHAC7WK9ATqM9W1NXh8ASGC8/6ekTjVn9PknKzKK5gDr2rAodFZYO+rOuBTKwGRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hBnMnqmS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hBnMnqmS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv2V083Sz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:09 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2bc7b311e77so17532175ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677808; x=1779282608; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj09+T2FktkdLwU79u80MiVhyJiQtKDMnM2x4Hjwdtg=;
        b=hBnMnqmSFB9V0QzHF4n48AWSWzmav5vdXOGcBvcAeGNyuL4kgI7J/SuHhrnGo7DAQG
         qZErG9wPWKhUKXyg5oSbUdEbeewQAu3wI7qW662oLUONbTXdab48K+K2n3Nj94wOU2Cl
         IhiV3Rl0oX1Q+aU/6WvQRBCBntSOmPy3NHmNhNiLQMRpjCyEphAYVD8pnMd5gDCPEI8P
         TA8ny28fi990np5EfbWqIc9vnNWYujRQLFVe4M0MU6H/Sond27aPF+TFP8vFOQtlzYN1
         N+mhZ8Ctd8xovUm/TTCOF0+jyayaU0o83skFBNAvHGGfO6Ke0/IJ8nbLRd0pSLui7qWJ
         Yw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677808; x=1779282608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wj09+T2FktkdLwU79u80MiVhyJiQtKDMnM2x4Hjwdtg=;
        b=eQGJ9igPbcADpR9jCZ626ozc1cXja4FlXXsTKm+uxidbidGK1s4k03tqOoqdLt4CZA
         +0ZOHoGxF7fdNKiViIpGO7ZVb7jEThpS6u5k9LV8QTizvcSfh56mkGnTo8FW8M7HQv+y
         llEZg+aH4UN8x/L5qqOUEUHVkG9q6iijx3u1d9AuqnCiqbS9vCyEjZ2rM6PJiBojXOWZ
         lIS+M72azO4P8HFqWhXX7JqB+4Y6MZc/P5aRL/aoqQW6pT7G9IXTxvqVqqRcpbe1K9+4
         i1Du1L+8yvBKpDUodW+KKGYf4A2qU2Gqi77gjTL29h9QxD5ywFzNRNRIv7nmcDoIpiy4
         8Z2w==
X-Forwarded-Encrypted: i=1; AFNElJ/q+eHITBQC8j2ngrlHe16jw8HfOHkzGO1v13v055cDjtD564SkrU1xkrgyo41HUBDDOPShzNeg5X4MdOw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz/FwDiJ8c17KB/hUfnEFD7jZ0B7bJQceoXflfWq8xnIczRLgUH
	Suth2cV7yBA4SOT+meF5nESSOZHwXd06YeaoqH8Oz7juDufGwfD2Zeo+EArMwd90+5E=
X-Gm-Gg: Acq92OF7tpBsiArCIt0Ojrb7e3Tc1cWFNz9F7hWvrACSjCDzNpvOc18GPaM27SI5Fvu
	5BuD+F0AXzoY+YldDjzB1KCHXf7WI/dDRt8bmOen8ua7+WRIgatTUBf/bIrg5/HvX/Iddp7anT6
	zoJvvT2+jIV2fMI8hFnoLSbFSOr///WRfg4XuoVx4tqrvRzaVwqksRQ8TA6qxRWZxTxq0MiYSkv
	2JdShj1Y1TuZnWVnkHLcxlLyKPuL8HCE+XPp92mHUi9i5DERBWLtLyEHoEDNr7I1dYTQ2eGGCVa
	UsH+sYFLKla74lD3lMc6xJ2qB52HpFfGGG0rx95NFx3c0h1dLzzudfpZt3GM9aCnDXTNdoWaaOj
	IWgx6ZDULIBWCUREW1SEGue8YnyXgyIkExgRbr1TM/qRLW/+uLaoNfLvinpvMe5pustcGGyJYJr
	d0HeuDhEO1zi65Oye1k53NJ0/ioOPX93mTEUxBlK6q2qnMyq97jjJXKGPvJMEIk25hOxAoaQ==
X-Received: by 2002:a17:902:b713:b0:2b0:6068:4c5f with SMTP id d9443c01a7336-2bcfcc3ce55mr52172605ad.8.1778677807808;
        Wed, 13 May 2026 06:10:07 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.10.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:10:07 -0700 (PDT)
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
Subject: [PATCH v2 28/69] mm/hugetlb: Use generic vmemmap optimization macros
Date: Wed, 13 May 2026 21:04:56 +0800
Message-ID: <20260513130542.35604-29-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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

Vmemmap optimization is no longer hugetlb-specific, so the remaining
hugetlb-local reserve macros are redundant.

Replace them with the generic definitions to remove duplication and keep
the hugetlb vmemmap code aligned with the common optimization macros.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         |  4 ++--
 mm/hugetlb_vmemmap.c | 14 +++++++-------
 mm/hugetlb_vmemmap.h |  9 +--------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 53448b05ca11..8debe5c5abce 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3222,7 +3222,7 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 			 * be no contention.
 			 */
 			hugetlb_folio_init_tail_vmemmap(folio, h,
-					HUGETLB_VMEMMAP_RESERVE_PAGES,
+					OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES,
 					pages_per_huge_page(h));
 		}
 		hugetlb_bootmem_init_migratetype(folio, h);
@@ -3261,7 +3261,7 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		WARN_ON(folio_ref_count(folio) != 1);
 
 		hugetlb_folio_init_vmemmap(folio, h,
-					   HUGETLB_VMEMMAP_RESERVE_PAGES);
+					   OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES);
 		init_new_hugetlb_folio(folio);
 
 		if (hugetlb_bootmem_page_prehvo(m))
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index e9906d32a64c..4367118f8f57 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -407,7 +407,7 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
 	vmemmap_start	= (unsigned long)&folio->page;
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 
-	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
+	vmemmap_start	+= OPTIMIZED_FOLIO_VMEMMAP_SIZE;
 
 	/*
 	 * The pages which the vmemmap virtual address range [@vmemmap_start,
@@ -637,10 +637,10 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 			spfn = (unsigned long)&folio->page;
 			epfn = spfn + hugetlb_vmemmap_size(h);
 			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
-					HUGETLB_VMEMMAP_RESERVE_SIZE);
+					OPTIMIZED_FOLIO_VMEMMAP_SIZE);
 			register_page_bootmem_memmap(pfn_to_section_nr(folio_pfn(folio)),
 					&folio->page,
-					HUGETLB_VMEMMAP_RESERVE_PAGES);
+					OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES);
 			continue;
 		}
 
@@ -779,9 +779,9 @@ void __init hugetlb_vmemmap_init_early(int nid)
 		zone = pfn_to_zone(nid, pfn);
 
 		if (vmemmap_populate_hvo(start, end, huge_page_order(m->hstate),
-					 zone, HUGETLB_VMEMMAP_RESERVE_SIZE))
+					 zone, OPTIMIZED_FOLIO_VMEMMAP_SIZE))
 			panic("Failed to allocate memmap for HugeTLB page\n");
-		memmap_boot_pages_add(DIV_ROUND_UP(HUGETLB_VMEMMAP_RESERVE_SIZE, PAGE_SIZE));
+		memmap_boot_pages_add(OPTIMIZED_FOLIO_VMEMMAP_PAGES);
 
 		pnum = pfn_to_section_nr(pfn);
 		ns = psize / section_size;
@@ -826,8 +826,8 @@ static int __init hugetlb_vmemmap_init(void)
 {
 	const struct hstate *h;
 
-	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
-	BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
+	/* OPTIMIZED_FOLIO_VMEMMAP_SIZE should cover all used struct pages */
+	BUILD_BUG_ON(__NR_USED_SUBPAGE > OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES);
 
 	for_each_hstate(h) {
 		if (hugetlb_vmemmap_optimizable(h)) {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 7ac49c52457d..66e11893d076 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -12,13 +12,6 @@
 #include <linux/io.h>
 #include <linux/memblock.h>
 
-/*
- * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
- * Documentation/mm/vmemmap_dedup.rst.
- */
-#define HUGETLB_VMEMMAP_RESERVE_SIZE	PAGE_SIZE
-#define HUGETLB_VMEMMAP_RESERVE_PAGES	(HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page))
-
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio);
 long hugetlb_vmemmap_restore_folios(const struct hstate *h,
@@ -43,7 +36,7 @@ static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
  */
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
-	int size = hugetlb_vmemmap_size(h) - HUGETLB_VMEMMAP_RESERVE_SIZE;
+	int size = hugetlb_vmemmap_size(h) - OPTIMIZED_FOLIO_VMEMMAP_SIZE;
 
 	if (!is_power_of_2(sizeof(struct page)))
 		return 0;
-- 
2.54.0


