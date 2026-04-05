Return-Path: <linuxppc-dev+bounces-19353-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861DCF3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:56:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXWb6KgVz2ymg;
	Sun, 05 Apr 2026 22:55:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393755;
	cv=none; b=E8cHWwmqleu0hTRC2oKJTQiQD9zdkAleiBig/lju2AXWxga9e+4Gwkq7Etv7btaLxw7RN6Op2H9MVrTqiPA/j4P+pInfLlGN39P2X0jUmDlQDgsyMga3d2X8/dbFUQdOZ76ViaMB1+kmLEn/03FKRqqIe+s2QF6GLYaTNwggASwYW3qCSrFMHn3Rv+OPkvQYIMGGQ7Ip+2kO9wfeyH9OFSOeOqVaM7BS0m2G86XCtQ/m707s7r98RdEOjp2vMzMnyOHzdLg1K/+KJkEVbB0PTft0oY0rf5pot1iQDVeTRw9HSxcm1qc4CYCNd4ecXS8tteOhTiQmnpHWbuaHC0SCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393755; c=relaxed/relaxed;
	bh=bqgbPUicXY/csWEcQb9KuYcgGnVxfQn/0ErN/EA6ZY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5sWCFgPZwhZQilMJPLxmN6ZVCRY2HMzQ2X3cCruheURWHlpeKlOdsjc4SzWSiP9SJ9qdo7u8AHHg/ovK5BTRvL64kw3FcmEXfTLvlg0WR3MP8T26ecS1qKWy6rzaIkaXdpy2MHKAVMYreJ/MyXZEaAabad66z1+EIiBsbDZH06Z4JAVBK7J+0UTQzNOUXvyCQIRGQndsfU2lRhF98gBD61+Gk7VJaHHAVoMDxFjcCIQrfAnA7VuPPf8nD7/kBe2RSk5bcdo51hk0buZ4ntgmCIWhah9XOhmRBB8cLC/qS12YE6PNubU4wTipgmsy0uf7CVBnj5Cz7t7tA0oexOVFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=E0L7jHIx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=E0L7jHIx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXWb0RrPz2yks
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:55:55 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso2818950a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393753; x=1775998553; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqgbPUicXY/csWEcQb9KuYcgGnVxfQn/0ErN/EA6ZY8=;
        b=E0L7jHIxukQmwzJ21oek/9NAqCsng4DxJ1n4EYgZEf2HJP5HzCvLIYi75b3J0F2hJk
         AoJeYDvVVH67gGA65iSbMY+fC5IAlLGYNUm+rD1VEEAHtCY/46cBo/OjGOmx5Pch7UEc
         y20VQOxREudkjKqjvwL6sgpysfK0YmTMvT9P536rHRTG1DRGOKdpjOubyw3YrjeizJJQ
         q5eFHlDz7Q46CpSHhvMFwK3wcefDveQA7gIVl6pxqtsd4/Q1L1/tyLW7tWPPNv4o91nK
         O0HvkJ7poX6sun0o2Wu1Tipsc3ZHtK8bnfe87J0W7kl0Ut25WUMbghXg6vtzx2YHyUzM
         4i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393753; x=1775998553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bqgbPUicXY/csWEcQb9KuYcgGnVxfQn/0ErN/EA6ZY8=;
        b=bw743Vy9H2cf+JMjufn7tga0HkwAPrPXK/veBHq1HMFatGElHm1k198qF2g2HkUd1+
         h2X+SgqGCknCo766kAUxJ9cnAZOULMmb/Atc9bw8Ih7HJY+9CQAny3LLDOkA+s314H7D
         f5vPw+y3nRsRMKqci4UGXEJHd+ZmaiauHItooLnqKjoBEW8bkTT1hf3J52NntxM4D5b6
         R0x9oap5Po7rBw3jKymrbaqEctCbV5rHtX0L3oi4YUpeI5HcTXcPVRLd2sgcfXAVvkgh
         Id13EXkf3MRuVWOu1AdxrKaiQjYP0qAYPoE+8+V84iJXjcI03Xcgkp0WUk6k3MXujtAE
         Sd1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMoPOHQR4Ch7FxZlm67vMbe/khxGTgzmYPYxIhG4EdRDNBDCr8+KBa9nKJoOG1TKgurvsXATFkhhVauDc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzoye3dRvwvqfW4mRilpqH2qGwmmLDBo8IT7ZxtPSK7XRA6Si5P
	AjO+Bo+Ht7zUvyZI+iYtmKTAeRLVdcArA8s3J3OFZxQWVOC8YeAyF2MQ+cAEasEgqXM=
X-Gm-Gg: AeBDieugJzYKnukOx9ceJtSeySGm4XN/ichyjb9CZ5rc8zXWBGBAzDWznVHqP9yLY+q
	y3SCFAdlxISIKiRAjDOp9uA0YSh07CHmOD0412npn47eGXHBP6YAVOKpDkNwwPlHX17zGCdJjUD
	ZHzb08wkqNSagIhpS3PlQFNUV/8MDrrag2iZ7hAeeFcfT22fQTEyFvFNVyFSkNWax+SyihkpoE8
	c83s9xrud0p7Q3SokuF3jx/XgfQjCD1ofESJG4vLuwpgIfI7tORp4OylWz4YNqjRcyh1XXZTn1X
	X7wsD2a8/TCXT89emb87jx5SbPd7eP7TqvECGrR0Mn/f5gljYkPgH/HT/MuJ/NF26aOyBE5sK1i
	532BMkIAvyfnfxq7BNiUcEQBe7qj/SYOfpaTsJ2zh1dEKnkB0UeKrFTY6d1T7M9+t2E+gsW6WE7
	NYOVeYKgxakxCEGxvCVQ+84vRSo424fj9lMwI9VpXS28o=
X-Received: by 2002:a17:90b:3a8a:b0:35c:30a8:319 with SMTP id 98e67ed59e1d1-35de660e4d6mr9096576a91.0.1775393753200;
        Sun, 05 Apr 2026 05:55:53 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:55:52 -0700 (PDT)
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
Subject: [PATCH 23/49] mm/mm_init: skip initializing shared tail pages for compound pages
Date: Sun,  5 Apr 2026 20:52:14 +0800
Message-Id: <20260405125240.2558577-24-songmuchun@bytedance.com>
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

Currently, memmap_init_range() unconditionally initializes all struct pages
within a section. However, when HugeTLB Vmemmap Optimization (HVO) is enabled,
shared vmemmap tail pages are allocated during the vmemmap population phase
(e.g., via vmemmap_get_tail()). These shared tail pages are left intentionally
uninitialized at that time because the subsequent memmap_init() would simply
overwrite them.

If memmap_init_range() continues to initialize these shared tail pages, it
will overwrite the carefully constructed HVO mappings and metadata. This forces
subsystems like HugeTLB to implement workarounds (like re-initializing or
compensating for the overwritten data in their own init routines, as seen
in hugetlb_vmemmap_init()).

Therefore, the primary motivation of this patch is to prevent memmap_init_range()
from incorrectly overwriting the shared vmemmap tail pages. By detecting if a
page is an optimizable compound vmemmap page (using the newly introduced section
order), we can safely skip its redundant initialization.

As a significant side-effect, skipping the initialization of these shared tail
pages also saves substantial CPU cycles during the early boot stage.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h | 11 +++++++++++
 mm/mm_init.c  | 19 +++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a8acabcd1d93..1060d7c07f5b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1011,6 +1011,17 @@ static inline void sparse_init_subsection_map(void)
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
+static inline bool vmemmap_page_optimizable(const struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	unsigned int order = section_order(__pfn_to_section(pfn));
+
+	if (!is_power_of_2(sizeof(struct page)))
+		return false;
+
+	return (pfn & ((1L << order) - 1)) >= OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS;
+}
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 977a837b7ef6..7f5b326e9298 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -676,12 +676,13 @@ static inline void fixup_hashdist(void) {}
 
 static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
 						       unsigned long nr_pages,
-						       int migratetype)
+						       int migratetype,
+						       bool isolate)
 {
 	unsigned long end = pfn + nr_pages;
 
 	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
-		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
+		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, isolate);
 		cond_resched();
 	}
 }
@@ -912,6 +913,16 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		}
 
 		page = pfn_to_page(pfn);
+		if (vmemmap_page_optimizable(page)) {
+			struct mem_section *ms = __pfn_to_section(pfn);
+			unsigned long start = pfn;
+
+			pfn = min(ALIGN(start, 1L << section_order(ms)), end_pfn);
+			pageblock_migratetype_init_range(start, pfn - start, migratetype,
+							 isolate_pageblock);
+			continue;
+		}
+
 		__init_single_page(page, pfn, zone, nid);
 		if (context == MEMINIT_HOTPLUG) {
 #ifdef CONFIG_ZONE_DEVICE
@@ -1138,7 +1149,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
 	 * because this is done early in section_activate()
 	 */
-	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE, false);
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
@@ -1963,7 +1974,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 	if (!nr_pages)
 		return;
 
-	pageblock_migratetype_init_range(pfn, nr_pages, MIGRATE_MOVABLE);
+	pageblock_migratetype_init_range(pfn, nr_pages, MIGRATE_MOVABLE, false);
 
 	page = pfn_to_page(pfn);
 
-- 
2.20.1


