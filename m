Return-Path: <linuxppc-dev+bounces-19356-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ABAF3D5E1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:56:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXWz1cr8z2yv1;
	Sun, 05 Apr 2026 22:56:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393775;
	cv=none; b=CcG1LiHlngPUEHcjLHK7fCqlO05kWWx7fPnJPaf1PPY1aDsRlpw0WVECc7GcHD726QhyOe+9xV/BCcsr1ZcSyVjueVA/9O3j3NHcOq4Hw2PViUdZGYk+LRIwMWqLy8CxQgdqEwIDJ6R2LFnq1kLYJZ0zhZHwPWr67XjDLy6vnMyobhLEzNcXdQY8JgFi1UnGxESGZ0hdXwUl7+qUOFWaqSzottvof1sGuXvtQBwnvmay2FNDylmeGqm9JllejslJY1x3vxzWqcBMd1SN+uHjxK/BP5LxqEEuXaT1pokeX3AWtkKJi44SSIfuCbCbmINlfKINjsRwyJBkGbX9HpLYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393775; c=relaxed/relaxed;
	bh=CEDM6s7dxdsKjdGxQjN87sllzWekchktC1ag1ZZ29CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6VJsVBurumibcfvxBGvnmVXQqdjqVOk/5sEDis7zhmEGeVdoyLK81h0eiF+B0yaUQBx78/U4ZlgtLiTE5+uaWDwGlP332X2NjHK6vzlX8aqDuqlnDC5d5X4WbF9bDygkf9UK8S9M8nckM3/94qeEspf9ZegL/zFFQub9EA/j8u3v62Ip8gnvXj1lXX8+IRayuFFZ4fmKhR7rqHYgY8uSOw9VBJGba0XBAEl+JWcXmGvweyaO8m8ZPmRKmSqZr/u3yeFpegXI0KNQh769OV+lyel0/AIUF10SowwVsHZy+kwliPxJs2yVU+BkqrnbTBdPy051ujBRh8TE0XxLql3xA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ehEcaRVZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ehEcaRVZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXWy2gSwz2yks
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:56:14 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so2933452a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393772; x=1775998572; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEDM6s7dxdsKjdGxQjN87sllzWekchktC1ag1ZZ29CI=;
        b=ehEcaRVZSq5bvqh2xqj6qlq3msxrP079T0frI1A12u+gppIly2FTb5qyKqgGOX2CZH
         lugKWVNiVAj+D8mFHSPtz+Kqh9/HpEzpbvEP30o8lsgP3V91Tg1Tw4jfhqtB0cXaFkvu
         lM3rjFdnCbqdBCjwNsqsXjwgcMtbmdBWfjMKIaTXL0YUCKGD9EidokBLD4kpEpPtcP5I
         YqPNma2GvDZS5gdm4EWekI9SfANtS5iVci8leDv5suqmNcCNrTgkURr7LzK65HNQLf6g
         IzcmOgNBUAIjEdBRilgQ815xTpED7sCoK7jRH3DUsB5afsJEzhfxFueZm6o552E6qDlS
         FMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393772; x=1775998572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CEDM6s7dxdsKjdGxQjN87sllzWekchktC1ag1ZZ29CI=;
        b=aOgaIFX2+4pgdHb9GAn9xonN/jWAucqM0BiPFDS1prjetpGTOUyYVrUKsqcsPfJmLd
         kii9Y2HPBcIu3yd1zvdqnAkxcx0VN81ciilWlOIpfhIBrtxaW9q5Atm079LrCNS+eXCl
         XgE8SK8ll16V6dpVXfHddiraup81qQLVU1tZ2nPdiJergQ2N2QkJjY4AbTCaA9Cl46dn
         wyPc1FpSlzecPF6XqWpgukDgK1Nq6kzvhE/UBb4KHCe1btzQwOBk1t61bkNaejr0xEJG
         l0JPjkL7jCG2591oCP0F7FudIinj8H24fBkPnCiJJ/H5u2++VJfL8Ne12nCxYFcrcHlU
         uyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF8D1TQicrhThtpqdryzR+8dQUhwBgdpxSGR0jUf0XQmpVUcALlC4d9XqyacY4aojnmHPoZ4L8we1nUMs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8VX4NuOBPvqfONWbKA3ZAxPj7AGZ4SXQ6WnawQhCZHIpYYZ2f
	vnRKBm5nKANxEY1qWn0JDxBqalIahhSq89EDGb6Y9HI6qGG+4sfIs3YzyxDyrcgcK0k=
X-Gm-Gg: AeBDieu46a91SAxyXhomI5KVWAbRYrR0Nx1/SoE80Aihd1KlpG4w4ht1r0R/XAzc3Us
	Xnrhz7L+YTm5Gz6A0LNDAyCFB/mPhCUTLGqusG9vSrX3KpFxXep8RvSRZUhM56oT3L2kS9zPoDe
	UZi1/SpmtYbxVYzDI/8Ez+eyM017Jf7dXuWfRW9pCy/20NbyDwI3HaYlKHfQ0GGrlRG0cQQtWJG
	QSmNX5tsk3cQV1oZJJBAGzre52q7XhzjlWIntdwJ2u+FOK9eHF8MYodyxPpDVXmunEwgWJEu36F
	equPQ6EjwjPjnUnHHSlXqBb34PVq9QqG8KWYSo4FAwcNYpMMzrLyuPx2xLTwHZMQujkUVIjwvr9
	fwz4rNYUYHH8FYgMDqKrosPwCa2rUmQHiMFslab3CfVLHCt+9WeEWUza5Rk6Pv/tmm0g1GeOxS8
	1sijABkns1BRqF3KdpnQn3LdLlHlxpyHWZfXSINOQdxys=
X-Received: by 2002:a17:90b:224e:b0:35b:e56e:a17e with SMTP id 98e67ed59e1d1-35de68cf52fmr9251356a91.17.1775393772471;
        Sun, 05 Apr 2026 05:56:12 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:56:12 -0700 (PDT)
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
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 26/49] mm/hugetlb: use generic vmemmap optimization macros
Date: Sun,  5 Apr 2026 20:52:17 +0800
Message-Id: <20260405125240.2558577-27-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

Use the generic macros OPTIMIZED_FOLIO_VMEMMAP_SIZE,
OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS and OPTIMIZED_FOLIO_VMEMMAP_PAGES
instead of the hugetlb-specific HUGETLB_VMEMMAP_RESERVE_SIZE and
HUGETLB_VMEMMAP_RESERVE_PAGES to describe the vmemmap-optimized folio.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         |  4 ++--
 mm/hugetlb_vmemmap.c | 14 +++++++-------
 mm/hugetlb_vmemmap.h |  9 +--------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a00c9f3672b7..a7e0599802cb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3241,7 +3241,7 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 			 * be no contention.
 			 */
 			hugetlb_folio_init_tail_vmemmap(folio, h,
-					HUGETLB_VMEMMAP_RESERVE_PAGES,
+					OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS,
 					pages_per_huge_page(h));
 		}
 		hugetlb_bootmem_init_migratetype(folio, h);
@@ -3280,7 +3280,7 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		WARN_ON(folio_ref_count(folio) != 1);
 
 		hugetlb_folio_init_vmemmap(folio, h,
-					   HUGETLB_VMEMMAP_RESERVE_PAGES);
+					   OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS);
 		init_new_hugetlb_folio(folio);
 
 		if (hugetlb_bootmem_page_prehvo(m))
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index d6dd47c232e0..0af528c0e229 100644
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
 			epfn = spfn + pages_per_huge_page(h);
 			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
-					HUGETLB_VMEMMAP_RESERVE_SIZE);
+					OPTIMIZED_FOLIO_VMEMMAP_SIZE);
 			register_page_bootmem_memmap(pfn_to_section_nr(spfn),
 					&folio->page,
-					HUGETLB_VMEMMAP_RESERVE_SIZE);
+					OPTIMIZED_FOLIO_VMEMMAP_SIZE);
 			continue;
 		}
 
@@ -791,8 +791,8 @@ void __init hugetlb_vmemmap_init_early(int nid)
 		zone = pfn_to_zone(nid, pfn);
 
 		BUG_ON(vmemmap_populate_hvo(start, end, huge_page_order(m->hstate),
-					    zone, HUGETLB_VMEMMAP_RESERVE_SIZE));
-		memmap_boot_pages_add(HUGETLB_VMEMMAP_RESERVE_SIZE / PAGE_SIZE);
+					    zone, OPTIMIZED_FOLIO_VMEMMAP_SIZE));
+		memmap_boot_pages_add(OPTIMIZED_FOLIO_VMEMMAP_PAGES);
 
 		pnum = pfn_to_section_nr(pfn);
 		ns = psize / section_size;
@@ -824,8 +824,8 @@ static int __init hugetlb_vmemmap_init(void)
 	const struct hstate *h;
 	struct zone *zone;
 
-	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
-	BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
+	/* OPTIMIZED_FOLIO_VMEMMAP_SIZE should cover all used struct pages */
+	BUILD_BUG_ON(__NR_USED_SUBPAGE > OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS);
 
 	for_each_zone(zone) {
 		for (int i = 0; i < NR_OPTIMIZABLE_FOLIO_SIZES; i++) {
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
2.20.1


