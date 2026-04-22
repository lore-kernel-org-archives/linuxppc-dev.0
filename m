Return-Path: <linuxppc-dev+bounces-19940-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73856F94CDE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:15:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0sTn5pJtz2yrT;
	Wed, 22 Apr 2026 18:15:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776845709;
	cv=none; b=EPzc9OzNB6Lwx5nSDlEILHGHfqIMfEJxKUVINpK0Qr1k9yRQGqD9tpsXWZHDuN7RZXafp7yGWui6/CLcr4M+CwHxBY2xCWcJIxtG9wESpEwPIuddfbyjeHa2MRDsxv5vd500CHfEVPzPxa6rY3ByRtsIEsRqNGq3vzcVrqv244VluyudRcgYHrsRPiMOVUtdAxISG73kZpRQ67O77tus84eDzorPm1ocoLNCWdd62xkas8s/f0zi9/XfDW17BLqlfvHkDpJ51LVlhedvYZ/1zFFfsd37RO9No2cZVB4XNPRVvVqsnsnGjbBm/mGh2QLPizsmyPLffajuYlc3W9rm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776845709; c=relaxed/relaxed;
	bh=bFvE9gY2jdfvM/7z3bv6AJAQ88eqA1v0Ow6s9f2y7sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EI/BhpBD/y41MRaRaoZ06rn1mrBxDLwKaCJFfwYFCC+yE72YdPSRfTeyI480nPr9/CD72VlsfTxkOs7M+pkjC81QpSLxVAbXQ9xvBMWmXU7uKPQL5wGw5I9nxI2PGzkR4E0/InyHpsAB4b//8WW2W5iSc7HT+DSY3i6slu7W5OL/FeAmiEYbguPCBxf/KDYhVa9ju4y4BNY2HmBG7yVvlgScd6yIC9/8Rd0bnxFG/ipyD62ITQgDbesFzpv56Nepn3Yh5IaGm8n6gdQI6S2CbMtk1n4yGaiExRquJclE8DoBHommaDdq1D3XMW4TjoInWRTHvua2PpRhQ2FHSwpJ6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AubyEuX1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AubyEuX1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0sTn1F8kz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 18:15:09 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so1906878b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 01:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776845707; x=1777450507; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFvE9gY2jdfvM/7z3bv6AJAQ88eqA1v0Ow6s9f2y7sk=;
        b=AubyEuX1JRIiPpw3xds5R/+n5nEPTjrTszZue7YLZ74pjWmaPgkMLc4WBQ8fBebq5T
         ENIoUG/JwY4yT6MrxJURbZ0WOFHOkVZ/b9OkSxjWpeKeJfreBTLihyEFJbvXRPK3j41V
         mvMjVkSUZ/yfVHuXBTUHWO63a/TuWlhWayTMVaXPGHcOEhfIcg3YdD0QxgyCuQ1YXCEl
         BDXuFpTfyIaFnNuLUjw7sJyEBTuwIjGd+JURSLXl76Zb5qfEgfXdutKq3DrzUIOyAYir
         pDusoKhh8INiU/QvT58ZLfbXEOz+IdxTDqk3xRlBAGYgz+FA0yjlHTWHgTm1VTe4KcRU
         8cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776845707; x=1777450507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bFvE9gY2jdfvM/7z3bv6AJAQ88eqA1v0Ow6s9f2y7sk=;
        b=IxpEiPG692kIz6+iKgDNGS6nzZmnD1UksM3wakni1gJN816BlXy91B7egD/NQerrds
         +V+1cnWuGtdHFjhbPGg3Li/PM4wrGDCF52cTXoB1mQeLF1IYzcrwLCvs/xTTs4DghGG7
         0e2u7hQO/DkSl0PG/M0cKR3Uug+2Ada9fcdng63OHcBnAVOcEIWodJLJr2XL4DALkClC
         B5PcGqOoCRyJ3HSTJNHArXQZTYXc0y6EtRVISLVECxsiPO6BwtbXa2uPA5oDWgQHPcRj
         bG1rizj9Q8E24tXIW96Oc+DwkI4l/t2x+j9QfC9COTK5dOvrczuqz0mq6Ltlpl9XPwqF
         TyUA==
X-Forwarded-Encrypted: i=1; AFNElJ9IHMnpankTVV3tyPL9DJlE6NNfNvgLeOM22RjVCatYiDnat7+EmAtZMWtyvj9b6yrcfQUEl4eafcaaTrA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwPmLfj9sZ3iZxtM8ZJ+3ESnhSy1+cBVUjN415mzQJNb/qqmSoh
	P1jZ2k1aStT73yP1SYJkpvS8aXd/K2Aw3Go7Jz+teT4VVf9sPl47gvKGVPvLI2cmUPY=
X-Gm-Gg: AeBDietsOEsVjY1SEUgBgyuaSW+D8WEV8uFii+3SC7QC3MI0cUP3P/asuuXalOh4c1F
	bffAb03vppeNdTZ1WF3K2KcK1ssPEC+FhDCZ9yQ8hsyyx8pnQzr/Fz6LlyhgNQGGirC6n/fLCGq
	NEr7eaMf024qSQY+dKf6dapOq+NhkAVXx74eHSW8/9qDVKgnO1iGwf/mRoMPwR3QiQJyzA0lDy3
	VaI8ofonzAB8wyLviNvrPiaVpR06/gh8nrpBMmBkdMH5H4Nr15kQvzMsuPGhVBr5qgOjA7J5b/T
	tvaRUFQq1+w/iQ33Jkc8BhLHwvk7i1AtEA2UbCXCf4VRE/JSCOmydTnkgpImhXBoQM4Z85y+Tw7
	mB31HDHuKDEZmm1wDa6VIs7opZ4jhvQboWUqKit4P5Cl/YpOYSxdmwp0tTC/X7erzOEN74QF0LC
	wzJj2+MqW98C72QSI6rojx7wmvqvrN
X-Received: by 2002:a05:6a00:3e16:b0:82f:5571:1a8d with SMTP id d2e1a72fcca58-82f8c8308e0mr22842732b3a.2.1776845706907;
        Wed, 22 Apr 2026 01:15:06 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec0307esm16522874b3a.53.2026.04.22.01.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:15:06 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
Date: Wed, 22 Apr 2026 16:14:19 +0800
Message-Id: <20260422081420.4009847-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260422081420.4009847-1-songmuchun@bytedance.com>
References: <20260422081420.4009847-1-songmuchun@bytedance.com>
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

The memmap_init_zone_device() function only initializes the migratetype
of the first pageblock of a compound page. If the compound page size
exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
subsequent pageblocks in the compound page remain uninitialized.

Move the migratetype initialization out of __init_zone_device_page()
and into a separate pageblock_migratetype_init_range() function. This
iterates over the entire PFN range of the memory, ensuring that all
pageblocks are correctly initialized.

Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/mm_init.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..9d0fe79a94de 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -674,6 +674,21 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_ZONE_DEVICE
+static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
+						       unsigned long nr_pages,
+						       int migratetype)
+{
+	unsigned long end = pfn + nr_pages;
+
+	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
+		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+	}
+}
+#endif
+
 /*
  * Initialize a reserved page unconditionally, finding its zone first.
  */
@@ -1011,21 +1026,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
-	/*
-	 * Mark the block movable so that blocks are reserved for
-	 * movable at startup. This will force kernel allocations
-	 * to reserve their blocks rather than leaking throughout
-	 * the address space during boot when many long-lived
-	 * kernel allocations are made.
-	 *
-	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
-	 * because this is done early in section_activate()
-	 */
-	if (pageblock_aligned(pfn)) {
-		init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
-		cond_resched();
-	}
-
 	/*
 	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
 	 * directly to the driver page allocator which will set the page count
@@ -1122,6 +1122,9 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+
 		if (pfns_per_compound == 1)
 			continue;
 
@@ -1129,6 +1132,18 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				     compound_nr_pages(altmap, pgmap));
 	}
 
+	/*
+	 * Mark the block movable so that blocks are reserved for
+	 * movable at startup. This will force kernel allocations
+	 * to reserve their blocks rather than leaking throughout
+	 * the address space during boot when many long-lived
+	 * kernel allocations are made.
+	 *
+	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
+	 * because this is done early in section_activate()
+	 */
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
+
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
 }
-- 
2.20.1


