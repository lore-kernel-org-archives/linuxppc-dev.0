Return-Path: <linuxppc-dev+bounces-19939-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9262F94CDF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:15:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0sTh45Jpz2yr6;
	Wed, 22 Apr 2026 18:15:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776845704;
	cv=none; b=CGbaoqAgEBi5EnPBdsSk7kcjZrjN37x4cbaoEoQ7WWtNIoLvjG4d391V2Le5morQsV6/M4kvmUh5p7j0WT/eDOb92SefuvP4H7lN40Q/R2io4OpBuqQ9XNAvv6FazPh4Nw/D8YyzQX6bM9GwUA3wiD4R5ngyvw+QyK/q1W/M69VGqv4rdBeROBvDesu5psJZPd3p6lZMHzfu3Njn6j24iD5OQQTK2YLv4S/Mk4S4DFNqeOgxTvSfVA8n2v3gjm5l53vIBL2SGaU8vN7/6LQfkZ4QRejP3cMfk9MMiFqMKScjQcF1lvyRzO+qziOX60V0WZoFWETwnIeHofnRlRKh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776845704; c=relaxed/relaxed;
	bh=guNzfHlKCo9CNY+Bza9mDTIoReNzZ+M+FnR7lRKuPVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N0WrpawGWP4jCjHYAVfD05GSSu0ktdbK5XwCWg3w58X+U+59J6nusnA3En0e5nDRcFxE4mbYCPi74vsHgfYQnHFu0ilXIeSdkIzDadDDT+vftMR1ZtPA7uXPcskuWLf8F9hSqH8U82SNJKizMRKNUcSCFaYggCLcMJsGwDa8hX2MfPaor6TPUzD3TKF3Jsw2F6JlKRCCO1wTThl0uBQwxLPWqkgxHsTpCAoBx/6ob5EwWj6NSnCp4O3va81sh5esZiWHWxGN4V4HLU/WmNThDQsDGJg/KlHS3GhGGnbuNZBkuKH2uLfGQ89+GD8Ug22wRCQ37Ajgt9ehPL0MVL7T8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hgJVpI9c; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hgJVpI9c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0sTg0YjRz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 18:15:02 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c795eacbeb0so2123660a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 01:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776845701; x=1777450501; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guNzfHlKCo9CNY+Bza9mDTIoReNzZ+M+FnR7lRKuPVg=;
        b=hgJVpI9cq7ROjEO6UEtLbtfk9RdPtdzQjfP5l7U8NMicV0EduE/NZfYlcNviDpjOF4
         A70ojNO/VUzLqHTQrzgQ/U+y86x3L6WGj8qDxLiAZeRwsj7/oEPSWbL0Khw7H8DTTR1e
         3FAzZr4/xSmd42rRu6cX1sLvzBPsuYwdZVf9oM2pMKYiyqu+KSmeM5LOSotQRqrXd9Ds
         i+UJToCnpo+3DgUC5RENhSPAVsmyMFV5ptgvcaTJQxuhQ+H3ehf57B7YtFXPQZRKFjQY
         jpFiyqHADzeSSQKRNQPCa1TbLUy+2AQgsiSiveYJ7CMeBebd3IYQcp7LhW3uYZiEvCLr
         akRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776845701; x=1777450501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=guNzfHlKCo9CNY+Bza9mDTIoReNzZ+M+FnR7lRKuPVg=;
        b=TQZgzlIJ3pdAo5hl6ooVw7ehx67n9LZvLbAy4d2UrDwJf4NNHH9/38znIyd/RpUqyi
         VjcCxfVff6PKHGZYbjhKbdbDsnnAicq/CRsSZx/lfkusp52M+QlXOHt6IN+MQTLw193X
         8EGHDP+G8xyh9sgbm/QKRL+I01xOWpcvZTI/6BpO4paec+5eQgJoM339frGpJHpEPSav
         aBc1WDNIag/P/9AKvqdY4wSqQJHRQae7mALC7Rlumnbp3lpl/kzDao1NxiDlJvHKcLs5
         yKEYBO3ReMhei80JikuZ33WsHftjAnEpvoCc26sgWRneb34m8OPJZd3BYfQOElkJ1F8W
         nkAA==
X-Forwarded-Encrypted: i=1; AFNElJ9X9uI9RCJ8D5mpguhMAQzR+z1HTpw5bBCwQ3lkqy2MUN1IXbPXR/HkUC8Vsdc2D1m6oxifOyp+nD9CAVU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz2p0DCZcL5vFwxifDWjFXIYf+Zlt4W+P1CjiNreH3jh+Wo/eUk
	PK5RIH75KQs3VFs5+838Asp4qhK4IphKE3lPhUODVpgC9tSLffOvxOcwd5pjVdIeDWI=
X-Gm-Gg: AeBDiesh4nakVoHXzWj/8rEC773x5WfxqGojF/EVQoGSR72/Zj/IZ1hklpp8Hya78D3
	L7+ghZrx81G+2Xf7x9f3HpyxDt2/nGs/doHDht94nWxcRuUS5oR+ubV+Bm1aYQZy3xgkLueMorh
	MN74ddCMJKAkOZGa5OqbwqZtZbtgTOZNOpt836JuIj+F3ClifOkctKM5/29ZRLKX0S2UrIGDr1H
	F0Yw1417Y/gv+k44hVfpZSmnoKBF2BDi9lKtW2Go5gn44Gw50TI1LVOO5slBS1gnaIOch5UvA2w
	IGb5PqJ4FMSvay09494HtCJ1CYYp9MojeGNXf5AIBPxAzSgt9LO62kDZxslqu2HVF8+UTnJtMQb
	B48Yy75hmm6VMioixva6qTzXBoIRkgUR4gwDjni8F9z7+R2bjBcrVvrZn7ELyLd4Jiq7uIctPeG
	V9q23iNiwlRiBLqoqwb4gRSH3W5CFf
X-Received: by 2002:a05:6a00:3397:b0:82f:24e:6a50 with SMTP id d2e1a72fcca58-82f8c830359mr23157259b3a.10.1776845700663;
        Wed, 22 Apr 2026 01:15:00 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec0307esm16522874b3a.53.2026.04.22.01.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:15:00 -0700 (PDT)
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
Subject: [PATCH v4 3/5] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Wed, 22 Apr 2026 16:14:18 +0800
Message-Id: <20260422081420.4009847-4-songmuchun@bytedance.com>
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

When vmemmap optimization is enabled for DAX, the nr_memmap_pages
counter in /proc/vmstat is incorrect. The current code always accounts
for the full, non-optimized vmemmap size, but vmemmap optimization
reduces the actual number of vmemmap pages by reusing tail pages. This
causes the system to overcount vmemmap usage, leading to inaccurate
page statistics in /proc/vmstat.

Fix this by introducing section_vmemmap_pages(), which returns the exact
vmemmap page count for a given pfn range based on whether optimization
is in effect.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 mm/sparse-vmemmap.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c208187a4b00..fcc5e0eda9e7 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -652,6 +652,29 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }
 
+static int __meminit section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+					   struct vmem_altmap *altmap,
+					   struct dev_pagemap *pgmap)
+{
+	unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
+	unsigned long pages_per_compound = 1L << order;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, min(pages_per_compound,
+							PAGES_PER_SECTION)));
+	VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) != pfn_to_section_nr(pfn + nr_pages - 1));
+
+	if (!vmemmap_can_optimize(altmap, pgmap))
+		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+
+	if (order < PFN_SECTION_SHIFT)
+		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
+
+	if (IS_ALIGNED(pfn, pages_per_compound))
+		return VMEMMAP_RESERVE_NR;
+
+	return 0;
+}
+
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
@@ -659,7 +682,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+	memmap_pages_add(section_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 
 	return page;
 }
@@ -670,7 +693,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	memmap_pages_add(-section_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -678,9 +701,10 @@ static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
+	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
-						  PAGE_SIZE)));
+	memmap_boot_pages_add(-section_vmemmap_pages(pfn, PAGES_PER_SECTION,
+						     NULL, NULL));
 	vmemmap_free(start, end, NULL);
 }
 
-- 
2.20.1


