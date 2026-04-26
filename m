Return-Path: <linuxppc-dev+bounces-20118-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C133CFF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 09:27:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3LvX6SSmz2ynZ;
	Sun, 26 Apr 2026 19:27:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777195656;
	cv=none; b=cLJMPx0+AKSGJhHerIo7LtrK0B6SVYl6EZzdeVqqxlWcxhiU4CPBwHG3vZUQCBp18qFCtGrJaQHFCaFCp4Bf89QiPV08pd6QI4JlOxr5KbEpq4tI+B7EZZEUKOGAA0sBHicID464GE2g6Jq7VS4E5vVwptHbAXoY1sPe82W18JT9rORHKMCEiaAeCjkvodD/6H+SUArkhkWiIckJVoTJp+sIl5OdAt0Mz/gaV1NLKrH8jsjtm7QbXTfSxe/uOL4koUPR7eIppsiU2XOPnlD3rT1TJ9Ht2QQtTkQEKwiQQVWkMZo7qFHDkYccGJIYvtzL54cXRzrEr2wpsUJBUeaIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777195656; c=relaxed/relaxed;
	bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P5nkyouwLM6cXU7rlf8GM1P36vELmX5Kbku8aQq4/TnHLrFbE3G7GKdlllaZ5bzwKb9FtYBFB/Zp6gmXoJC6aCfmKaHNJ2hQmJ4cuxfjtQCGRf1xhcGdaVPvE/qY4aqXwilJuBLc4jJFBWKdG+nGu/SAAEvjZc+xwqIbz1eVIFzWEf7Tsw63s/f5t6mIRmTWNK39l90xO+J2IlcLEonyxjlILa7IXCo7Y0uWl5S59rR+eQELvAAjD9rhxRP6Ko3t//zO4veqngMvBr8+wh18ohi8y76mCdQ3hSFuQUZotu36ChO1u4wtPoJiAHxONhFgGmKHPBIwSOr3bM9mu0Sn2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Png3lhOR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Png3lhOR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3LvX14zBz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 19:27:36 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b788a98557so41725935ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777195654; x=1777800454; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=Png3lhORLygyMYiYihNiCBVSmYuvpiHyRsB8GYP7Ohnro2+q7DYSbzjMsvla9UNCNH
         RMDPrwxMK3+Z0CaynQR3A3Kn/rrK27lYzvteCT29HW1HeENJ1D72OhENuJBZgbc4jf/n
         akB3LCCzGbX1gTV2+EeJpRr4wdt8E7IB4cjBjNb7VAZKxriwGeMFDe2ZQIa2ZhJm9FNJ
         LNXxohkG2kNdb522rh9VeFL2iLq3WK57LNtG1j+UFmaYK/ejTNLX0SGvsuBxuR3I1lgQ
         vsWPkRqLB5j0Ixabo90kfbZOalcYsQ25Ovxff58SAEcIk6d4hyhDoNeqBgOziBFdqqGR
         z90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195654; x=1777800454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=sCojK6Gb/rrLSLHShSXKhuyjfksq3fgLrsT+GbVRSfv2Nhgll3PC8KAuibzBmsb6f5
         MJGphdXNVlmOpoPC9u6Lpw9E9HyKpjw4DPx45a07mgK8dvYaiqbyXhZFVj7elpkKveAG
         tBLTa6J36Ohf8Ecr79rzAzeYR2VKBXxZLDD2LqRqGOgM+3EPdcYR4Y0mxxj9ZexRxT16
         UINcH/q70NDWvce9HUzrsfxWSGsujmekAVBGH2YRASRK7lyAEmUJ8eUrq7yEkscDk9P4
         cnYeszEX4l6TelGi/cBvCG+zLAB8cb9ZO5D1XrF8Zs25gFt+GqcUBlwoQixc87waoISS
         bGrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7zR9e4UavbTtjr+tNvaK8abZ7O9N0kGVWoqakW4mh/sXRaulJU7CyVKDCl4HOu+JPd+6ysciAKetoo9s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwoGiiajZVLNRReDH3lsu272hLAdAxPRKX41pzaJunyEXKJqSCb
	9sWdxZTOMOCqlx5JHmLLFfMrPaJ9IdorDKu2TxEvHomur5wRN7mGmZsJY40JAmiyEJ8=
X-Gm-Gg: AeBDievS6O0BF8JiDlNKE8SdjwOfJ8IzVmxm80Yymg5fw2tqz09eWYZiX0Z1yn0Dxtr
	i4PyVq/44CDwnIo2Ce98JYzTffsxpxKHeQwrGVKflTJTm/VIWdMoh6aU2wabR0WcUA1ajPgMni4
	lGmGO0v5yILWZ+rSrjznAXH3huzTXYOzL7q1/58N5P23esv06XtZ7VTnGg4l3h9FaneMNvt+U2W
	WP3SFxN8k8F+vvqZdKEMo/ua9JL4j4e/UPPmV9fmAwYfmrrUxSuB/hfOHvqenGVl5QEN8E1EbVh
	3rG+qZexv4OJB75h5fdW61yjKB/MkeHEvwUTkD5YpysHv6QThtcu18OS7cqlR2/g9lNDrcKmkvI
	3IlQlbf3x3VRVmWCxQdgayTA65+i7LHijM8rWL/TIDhYjmyQfwF0ce4pZUewrjeJ1+f08Ek4SAa
	h7ZPYNsksO9wAEZiWkjFoffmwEwutd
X-Received: by 2002:a17:902:da8b:b0:2b9:547d:ccc8 with SMTP id d9443c01a7336-2b9547dce05mr31133985ad.30.1777195654294;
        Sun, 26 Apr 2026 02:27:34 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm270352885ad.40.2026.04.26.02.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:27:33 -0700 (PDT)
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
Subject: [PATCH v7 5/6] mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
Date: Sun, 26 Apr 2026 17:26:39 +0800
Message-Id: <20260426092640.375967-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260426092640.375967-1-songmuchun@bytedance.com>
References: <20260426092640.375967-1-songmuchun@bytedance.com>
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

Also remove the stale confusing comment about MEMINIT_HOTPLUG above
the migratetype setting since it is an obsolete relic from commit
966cf44f637e ("mm: defer ZONE_DEVICE page initialization to the point
where we init pgmap") and no longer makes sense here.

Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound pages")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mm_init.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..cfc76953e249 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -674,6 +674,20 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_ZONE_DEVICE
+static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
+		unsigned long nr_pages, int migratetype)
+{
+	const unsigned long end = pfn + nr_pages;
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
@@ -1011,21 +1025,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
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
@@ -1122,6 +1121,9 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+
 		if (pfns_per_compound == 1)
 			continue;
 
@@ -1129,6 +1131,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				     compound_nr_pages(altmap, pgmap));
 	}
 
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
+
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
 }
-- 
2.20.1


