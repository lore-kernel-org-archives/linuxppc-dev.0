Return-Path: <linuxppc-dev+bounces-20885-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37777CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:12:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv3K5WSQz2ydq;
	Wed, 13 May 2026 23:10:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677853;
	cv=none; b=a5eSxiTjx8XjuTYUWE6xfBcUgH9B3hfTBCaGH0QwdbZDvlb7wtTu32FASq2u+xvQyXleQSYqIr0x+WQYyCQ6ZUNZTFUmhCFQ/GdJZhULF4FVTRM6r34+PiSQ7G60xrl16/IFAYdmPhTMnt1f89jYL1zeNBaibA0C9ikPImMk0UiSAirbqCHA08riigv1DzIZg49VUkvOuwjln8fgOnLzOL0BKzcs2M9BZsd3NOuSzLeBtjkFxqEiC6eKOuoTQSbvDogIah9XW8HFg0Wyl84410PbOnv2cbXaWKqtPmUUhYRxdTKYzrS0RztlLLwynUehXQ92ZSTjF8A+Hn19l7QtHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677853; c=relaxed/relaxed;
	bh=8LL1KUkSPgRngQo7FrouyGUEJqkrJiFH1mc8jZNgwIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P59g9JWJ5EZr+vXgfyaY8aAFiZfMRXhzmaa8QV+V01rTvn2/s6vnneYeBRmraYmqIe3hWS+KlFOmv4o3ZH47ZgdO+qBc5zJBapA5r/durShcrYiH3QP2TcfB7PoFZbUpstIhz//NYvp6SYUoJStRVOEm5e5Ese+7HBODqepEJ1ri/turISAnDLzCBIZP/wBlwo39ipPjfBykAT9wmNjPOCnX3rFrEw6KruuX5Z/ZnZyOiKU7bxcE3USvAS4LisM3UzAFVEl/1Ki0euuRB5eu6HtuHIP8W/+xjnY7SBSt7eAMpKd3pkZy8boWg1W6SIYwVRndt7CvCjtKCAsg/7astw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Lde5Fexu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Lde5Fexu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv3K0WYSz2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:53 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2bc763e2ba8so21665215ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677851; x=1779282651; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LL1KUkSPgRngQo7FrouyGUEJqkrJiFH1mc8jZNgwIM=;
        b=Lde5Fexua/xyw3U6cyYT/RhhBq9LKleFphXQXG0PRP3YN+R0/HZnpXPGSqtJ2chBd7
         AHzaFjln7EkG8cAE7MWWv6QHCXDNRQfDMUseBPjBUwoeK3krCG8w3Hh3Y4ImOtwfV6B6
         2WQripsO/UYIWl/kxeRgYAVGHUA+f4RHtpEAhUKlh5ViuFz1dKunCHWKU/WMl+tO9utk
         UQNIOfrX4qxso4Tf29lGG1PUDmLPYufbhcDB9rf4iZ95e5ABNTtYv19o5VvunVy9qDcM
         6uI3ZxE9CzwAvDtl+rccln0Oy49MR8x5DVJfJSHj4Jhq/t+tWhFjnqzbWkNmgrbUWiAV
         aE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677851; x=1779282651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LL1KUkSPgRngQo7FrouyGUEJqkrJiFH1mc8jZNgwIM=;
        b=KKGAkDxFEOmuVLYrk8/46+Moec/03vapGttGEo/b6pjcp9fGyMX/KOlOwBrQ82Errh
         heewksFjRciRbX6OiVvDYcKfYOrq5K0NafWFiMotobYyYqSYMp4wVZQk1tVGymp7EPEx
         qq7biEuvFc+AKXR+1VjFAtjvtlrU3D39wmEu7JSwPX7zyQz4x8C1MerUNntH6MrJ8jpK
         HHMAooXsEL8vZbxU8NZmzAxy9R4LMdiSnEz9214lCp29GFUkOBAJQtPqJ4YED2Kcod9k
         61x0+QC/AYmROKsRtHkqkdl4jcubzY1/LUjg6MmnulH5HqSmmI2lIRpbk1vsIVAxknco
         nXBg==
X-Forwarded-Encrypted: i=1; AFNElJ+dMZ0J3Lyxfh54F1pHYFh7tahvA4H3QEUAbYC+oKlr8oFCnEz8ynuCX8rPD2HxXQ5+DsNDx9rvVpThpBc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywv2RjB2aYZ/2j6hBv3f4nBXQ1JTKOGUK6W2GTIDOMOZ2x4ayG4
	e3drv/wzWbjOtkq6ly+ORm2+u0kPnPFM4tYJOE+XMEWl2HRzIuq8956C2xIs442Tfhg=
X-Gm-Gg: Acq92OGKe6ESBVSIyYVTn7/U6ZagQ3cx40Q6piPuHb+b+VDetfwBZIjfCE+VVw7uDhI
	AYDjllydZyqW6h03AFDojeM6Gc8p4s4h1RTUZmOFY9Nkg56tL4T1ZhAS8WdRvMkncFvMFaNRr56
	5IwXa6xNh5FQw4NNtbPikqvHTixKaIsuFopL4kevkCztBKttLfpclwZOq0g071BmsVMcgwbYH/Z
	+vx74yYwSHDVWsxE1UFM9fufJOzu2ycXZ5nt4kAWvNcTugQwSOQRSUSX93PrZvgmwuhZC5dc1FO
	d0q7vxbKF+ZEvDNY6RC9Tvi88sv7eS340OyexAPuQNZG01ZbBC/+roIGNI6r80NFxtAqWLlUmyt
	L4FAGcE2KSLLrn/G4/pr0PMw1yWvwu8bokL3Fsd1iD9VjiUu0wuWC31hRY/s/1RiEwjML/KORSO
	LBS3r7529rTKRCpxVUZB7R8KtBJXovtptvWfEkNdgcXQmIQ4Cm4JtKsjAy4bs=
X-Received: by 2002:a17:902:b401:b0:2bc:fe65:4e9e with SMTP id d9443c01a7336-2bd275d95bdmr26715515ad.27.1778677851113;
        Wed, 13 May 2026 06:10:51 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.10.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:10:50 -0700 (PDT)
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
Subject: [PATCH v2 36/69] mm/hugetlb: Remove HUGE_BOOTMEM_CMA
Date: Wed, 13 May 2026 21:05:04 +0800
Message-ID: <20260513130542.35604-37-songmuchun@bytedance.com>
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

Track early CMA hugetlb pages from the hstate instead of storing a
redundant bootmem flag. This removes the unused helper and keeps the
bootmem metadata minimal.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h | 1 -
 mm/hugetlb.c            | 9 ++-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 18af8f304b95..82dbb9ebead8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -696,7 +696,6 @@ struct huge_bootmem_page {
 };
 
 #define HUGE_BOOTMEM_ZONES_VALID	BIT(0)
-#define HUGE_BOOTMEM_CMA		BIT(1)
 
 int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index abd79bb85b1c..74770c1648fc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3093,7 +3093,7 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 	 */
 	INIT_LIST_HEAD(&m->list);
 	m->hstate = h;
-	m->flags = hugetlb_early_cma(h) ? HUGE_BOOTMEM_CMA : 0;
+	m->flags = 0;
 
 	/* CMA pages: zone-crossing is validated in hugetlb_cma_reserve(). */
 	if (!hugetlb_early_cma(h) &&
@@ -3169,11 +3169,6 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 	prep_compound_head(&folio->page, huge_page_order(h));
 }
 
-static bool __init hugetlb_bootmem_page_earlycma(struct huge_bootmem_page *m)
-{
-	return m->flags & HUGE_BOOTMEM_CMA;
-}
-
 /*
  * memblock-allocated pageblocks might not have the migrate type set
  * if marked with the 'noinit' flag. Set it to the default (MIGRATE_MOVABLE)
@@ -3265,7 +3260,7 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 			section_set_order_range(folio_pfn(folio), folio_nr_pages(folio), 0);
 		}
 
-		if (hugetlb_bootmem_page_earlycma(m))
+		if (hugetlb_early_cma(h))
 			folio_set_hugetlb_cma(folio);
 
 		list_add(&folio->lru, &folio_list);
-- 
2.54.0


