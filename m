Return-Path: <linuxppc-dev+bounces-20227-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB111FF885D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 08:19:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4YJC0Ckjz2yrZ;
	Tue, 28 Apr 2026 18:19:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777364378;
	cv=none; b=mlgKu6ZpBaW3F0W3olDq5OGjLRSqtDivBgp1zVUEmDwfi8EWDD78F4DURPe+QCexyQWFp24xpwCRXE9/NmwTo1/4TpE0ZEsafc+84RDsIopwcfoTjRHdMU4KYtbZTJuqbE05k6P3Ik+rIDSR3gb6ewmkb+NRyQNEb0HN7VQ5hGaDZ5kFQoQntD/Z/E4poT6NVYFY/+toxHHmag3oq7BPk81sX4A3CBTKJlS8A8NeDBjfc7UECd2Qe8ikL9gBP4I5PR7tF3YrXx29si4C7Le0fwlAxIQUB6OcIkG9PoJq/NnDPQyqFIJPcIJEIXsW4UBL0uD6yWti4Mb8J8V2Lsuk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777364378; c=relaxed/relaxed;
	bh=sKHGjwyqOWL6rVsBt0Sw/YSvydX7Gt+2C2Tpk5skGPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmUvPzfb5TjqVumajEF81IhwnADlb4Q6lAscmMs5KYCD8R0fHdON75HJalWvWUlDxPPmiCD8KzvWPpyxk0UeAYGCcVyWsAklS1i2aavo4AE25sHcimYKh9/xi5KYXhjrHFhE3Pa8q6L1hxGb8M39egdbsI7ImZgwKAkrpjztHDtywyDjrfgEmNutaOuySEB9mHtcRtaAq/mjSb1puIZQeOiI+5jNSTL+1r3oYNKB1wH9wnPX85eFzFZK8HrZm2uJrGNFdo3SfVpkTuiO9a6iMQ4XZrwBt2ji06N4ydgpWF2lQ8koAkCREXeT+mNPYcq8TU6qF8qFeUqoGqHCFs11+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=bIDLNhyG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=bIDLNhyG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4YJB1nrhz2yrM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 18:19:38 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso8527131a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 01:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777364376; x=1777969176; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKHGjwyqOWL6rVsBt0Sw/YSvydX7Gt+2C2Tpk5skGPU=;
        b=bIDLNhyG1u+gKVHoHvTMvcJWyOQPNa0JaDold+tdvR6MxGsgkjAaN92EuVVvswzj/8
         NrqXVKO3qsPf00faeUtHz+vreFsiRUvE9FPGDTBOvKqK8H3dnBBBLTs9XkFmV/0alj6N
         AQfStFAAzhmAmugVuPDODlB2EdwRB5G9or49fUwY5pv5xuVgG96RI6SDiOZO+VDyjIDn
         pwvVHWtoMd7tPxxOPJLMMq7zgEuvuV7L8fTuIKRHcXUFCM2dpyhFhjutoQgQj4rIYW/o
         Y3dHjpc08Hh0NhbGGQPJvLkToM7/MCDkHc/8GrGYIunX1elN6sffxdtRFDGQUoT/qRBA
         SNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364376; x=1777969176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKHGjwyqOWL6rVsBt0Sw/YSvydX7Gt+2C2Tpk5skGPU=;
        b=C9T+FbCuOVL46EHQR6F+zPJb0gvIyXAD3JTG53h6r0G1tP0lPUjKiigh9JyDme50Fe
         RIV0zf7723qEQ2CT/fGLZRhFfVgTkayggs9JIe2lk8GxJGxOf+EuxV5+S0NYKRcTX0yM
         6XL0iz+pEOoTBWZFsaSkhAtVGD4iFU8oYkyaLy6L+OHk/RvSzCHIWvkP4hHGIZIcGRy8
         rsXQXw008R9bRFErvffpRyr1q4EQXzQ7g8ET12rmK7keynCIvxzR6uFfvNs9TtD0m2dR
         MIax8JuqzegZ1HlRr+lzgNWDIMMcAgy/wft07PiOLhlgZF+dor0APt4tAvx4sjcYPw7y
         ttOw==
X-Forwarded-Encrypted: i=1; AFNElJ/zZ3AVBD6si1UTyc5IXXrT2ewSP1Uy2XR9VFz8HfeqqTKBENgpn0MFVtR6qNla9srYZpAfV+sz+ZulziU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxu4NBYWQESrH7N53+O4YubAh5M+j4UVGh66r4R+HcdHmFgugR+
	7oT3jQx4o+5CbNj2eJWpSFMWheb3ZQ7s+dDU2aCTc0RX9VzTFkCALzG82VJprPL60S0=
X-Gm-Gg: AeBDieujq0TypOmMldtPIlNSpMv5ShoHeDXbkw9nmUtnNMnQrZVwtwliHBohS55xRsU
	F6/fjj681z0Gv4UYPS+4lYL+0hLPxI21xLwgkogD1hDtMQJfHibdIh+/SbvpX3LNy1hZdjatPRp
	livvk4maWBTF3PE95W4w2n4oVb2wnCunsJeel1asEKuG5sYZiPJA/AC3o0Wu7o9bacGw8tSkxG8
	aYG+4pUBK6lpUfGtV4yWpzLtHn5M7Ejr56fKRg2uemZBaJsdw7sfDN4lLSyFWRWKpi6LrfCgbyn
	GsBnGcMTzzYgLHDUG1OocQcYpBd5Td/OqKpNcjV+B38SB1qwMweuOwtu+CMAEU2xDvpzl/x4asD
	3nsklKUXi/VgUHUF5JivFO1wuO6jsbf1u3ernBT6O0Cmk0TeioG/qlFWNc0vW21YNPG0T9tKGb9
	z4RSZMYc7HVIEECS3Og+3mYFy4JkOGG5J6qeqiwLUsKmQARYitREBRsYE=
X-Received: by 2002:a17:90b:5808:b0:35b:e5ce:73bb with SMTP id 98e67ed59e1d1-36491fbf11dmr2272598a91.1.1777364376405;
        Tue, 28 Apr 2026 01:19:36 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm2181356a91.8.2026.04.28.01.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:19:36 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 6/6] mm/mm_init: Fix uninitialized struct pages for ZONE_DEVICE
Date: Tue, 28 Apr 2026 16:18:55 +0800
Message-Id: <20260428081855.1249045-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260428081855.1249045-1-songmuchun@bytedance.com>
References: <20260428081855.1249045-1-songmuchun@bytedance.com>
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

If DAX memory is hotplugged into an unoccupied subsection of an early
section, section_activate() reuses the unoptimized boot memmap.
However, compound_nr_pages() still assumes that vmemmap optimization is
in effect and initializes only the reduced number of struct pages. As a
result, the remaining tail struct pages are left uninitialized, which
can later lead to unexpected behavior or crashes.

Fix this by treating early sections as unoptimized when calculating how
many struct pages to initialize.

Fixes: 6fd3620b3428 ("mm/page_alloc: reuse tail struct pages for compound devmaps")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index cfc76953e249..bd466a3c10c8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1055,10 +1055,17 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
  * of how the sparse_vmemmap internals handle compound pages in the lack
  * of an altmap. See vmemmap_populate_compound_pages().
  */
-static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
+static inline unsigned long compound_nr_pages(unsigned long pfn,
+					      struct vmem_altmap *altmap,
 					      struct dev_pagemap *pgmap)
 {
-	if (!vmemmap_can_optimize(altmap, pgmap))
+	/*
+	 * If DAX memory is hot-plugged into an unoccupied subsection
+	 * of an early section, the unoptimized boot memmap is reused.
+	 * See section_activate().
+	 */
+	if (early_section(__pfn_to_section(pfn)) ||
+	    !vmemmap_can_optimize(altmap, pgmap))
 		return pgmap_vmemmap_nr(pgmap);
 
 	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
@@ -1128,7 +1135,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
-- 
2.20.1


