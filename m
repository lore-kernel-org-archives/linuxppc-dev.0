Return-Path: <linuxppc-dev+bounces-19769-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B90F41986
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 11:15:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwdpX544Zz2yvG;
	Wed, 15 Apr 2026 21:15:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776251700;
	cv=none; b=C4P9jNDG13Wbu/ZyaoW3f1ALfY/bvq7gNVo3rFBqikvAuRerIqQTnXGTSJwGzwS+DmstTuGKU2otEborrUu+5WO4GhSXLyyfxBD1dNfvHvIzF5W8m7rpGMfBy0bfK7j8B0QToA7Ngf2fuxNMR3qaMvZ5h+/btFD3S2TpzLrpkr00InnxZ4Oc4iX6wYufsPa/13INIEjHtSrIOrdRqSOXaVLbZRLyFr/O3ACmeqa19egLXhLL7TdER2LvwSDAgXIeRhjDJB0zOxpuoVQGJEl1bIrYfgQtVhKYerLzaanHtvq2dUeNLVFCOalTR+B03ZgeA/25V79R0v4ZCskQvJ7hoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776251700; c=relaxed/relaxed;
	bh=M2tbh3r8pv+EpSWaqLjjsd7slEO4DRhf7DkjZnRXEmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LG0JmXorB9xhm/5QrBf83kNgwwhbQMkqhcTV2cRAttZW34IH1LLKImdT2HtFFO84S4NEHSsMoeIeuQCDZFIhQpgelSFEM1BgyvestmL4DnnWgCW6A+iy6E/LhpwqjpLSPxeyMCyu1icUbO5zQ7wV0b0ElhffxM9pRwrHY77jAF6LU6Kh6SBcBEkMEzRVAjqOyMsyP35fKEiJE2u/0dBS6qvgj3mqHehLLlRFSFOuX6EwfVF24YnJ9i8YfwIbYRPkNA8x9mxNl4N/TuP0Xe54Rb2ClgsFXdIF9DbOxyZa2FB9WDHmbmJ1co6cLilmfhXEQ9U8ahmuoVhWRKwPJkyngA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jDglYO+g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jDglYO+g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwdpX0HcPz2yxf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 21:14:59 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2b24fdac394so60010325ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776251698; x=1776856498; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2tbh3r8pv+EpSWaqLjjsd7slEO4DRhf7DkjZnRXEmM=;
        b=jDglYO+g3Kzd49bALq4htgBWzE0VktPX5PHVaWL1VSOTQKBZe5uESv65e0gxP+s3Wd
         ZzQzM1EtcXoeOpvuFoHHcUs7zke3dV5xyhL4T1WymSWmDhy6ug5139pU13++pG6XI23t
         DpmpapHOaLKfzr4CoqZQCpr6GIMAgsZdJPofhx2VDoW11bfNRmVylK6jNiSBAb+ehhtl
         M9FroG94/QhrWJYTfRRO3Vl+Ke55N2wQ9Vl3cptnRR7/S6CtMmLzvDkSDIhJzEOozWa0
         64j4eYl1nJZ+iOF8Lx44o3SEhmzdzDwufCrRqbSGi0Fau8dKeU4IK8+eXVZxQScFJ5S9
         6DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251698; x=1776856498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M2tbh3r8pv+EpSWaqLjjsd7slEO4DRhf7DkjZnRXEmM=;
        b=qKK8pu2MeeJzh9ZiinRs+65veHk5xuApkVl+MUl/1g+K+hkqx7e7RJ0nvjQ97ruT2j
         vFCbHWto77l2Rl94WriJOgF1WxcGzCukvcR59C/q8YIfPLpHjOvCT5ceZO6tbpC30kt2
         k7Y238pZZpHchSWzbtbykjI6+ccfFd3z5NNaykBue+FVBZuJZqqfR0xM6+b+iR7qo37T
         WzvEHNpRIsJqp6/V9jxmT3YD2UODVwxX4aORDPQ4W0fOLty29GdyQ4D26C2Em7Y210u/
         Es0sKI8fPHk15bHIfkbg6OkeaU3IYcEeFTlx7/vhpO/gOwKTXRoRTT03GdITxuXTLFvV
         AUTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KKPfvDDiKFt8qL8kyR6F7zPCWA0a+zQKWIOWzLGXRepNy0rpPy18l7JvKzW7vZyWgaUQH9zZUBy2ncTc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyoAIH6oay3s8GP9Y3EGIfpqb7BVS+K0dlXiJyE3QMwsgQGZlUz
	rVjgn6cLns+W/Yn+D35xTd0b5apPsmkD3pUMTbpEf+ZXjdD18TrLAm4w6Fhb9HIeNwY=
X-Gm-Gg: AeBDieuB7GxH8QhWlDiCtN5Rsv7/o8XUJo8RrAGJD/o2+nThzAZeFfd4U8d4/7RgCoz
	NysAM6cHdjw1ft0cOrOhw3iO7ZKG/07Z/d/k74VGVxg4KU5dTPylXEk9JCRibE6k4WRZbDgYruu
	PUPiH7U31DtYL5G75FP6nPnLke7eiJXr4J4Ph37t9uU48kkaecmxC6q0sfWaNndujUW2+ZsH92E
	3zJItHUVQ8bRcAGsj4owxeO/EvZXV133jmLl7euC2VbVobAEJaaQpiD0kkApbLRQqyFYBlCmRje
	ZjAHcsxG9BkZiIORNJNc24y96fzOqKiBNs/8zClzUeDhztga+efIOTrPzYWH3w89JipvC29NfoN
	nShMFUTyBpVe2ygBByT3PQYVq6mttybJ5O+94Zb8ZnlfGOKVRIJ3cEK/hop/iHaeXt57qKeF6ju
	vUSIKTqwjwL5JmT8tc8WTVeqhtIYFrN6foqq7z4JQLfVI=
X-Received: by 2002:a17:903:1a24:b0:2b4:63c8:ce18 with SMTP id d9443c01a7336-2b463c8db7emr113441015ad.12.1776251697718;
        Wed, 15 Apr 2026 04:14:57 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b477fd3724sm19509485ad.0.2026.04.15.04.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:14:57 -0700 (PDT)
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
Subject: [PATCH v2 6/6] mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
Date: Wed, 15 Apr 2026 19:14:12 +0800
Message-Id: <20260415111412.1003526-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260415111412.1003526-1-songmuchun@bytedance.com>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
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
---
 mm/mm_init.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..30528c4206c1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -674,6 +674,19 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
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
+
 /*
  * Initialize a reserved page unconditionally, finding its zone first.
  */
@@ -1011,21 +1024,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
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
@@ -1122,6 +1120,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 
+		cond_resched();
+
 		if (pfns_per_compound == 1)
 			continue;
 
@@ -1129,6 +1129,18 @@ void __ref memmap_init_zone_device(struct zone *zone,
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


