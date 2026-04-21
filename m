Return-Path: <linuxppc-dev+bounces-19861-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B361F5A8D1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 02:21:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g05hD2N8vz2yv4;
	Tue, 21 Apr 2026 12:21:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776738092;
	cv=none; b=m6XK6rDmU9+ejE4XJP8Es4qgXDzdyhbMEiwll1ebsO1JVIT09RZnaDagPW3/5/UVYlDQ1QDuTm+DomWVlnX/Q4z/djEtbYiQU37G4P8zja64Uh4OnzL42kSDLLFWBHeeuhhiRBeMHGnZPO2IsoFXXg1y4EEJpUDUbhQufzTZhzWO8ogq8UXnMZXsHButs6Mbgjw6Eljuj9340l0olQ7TAnUkqfQQQ2dzefzZ34t0z04qR9u2X2i9lh1PiKRQJ7P8dONuj0bv6xHP+KscZWtaZCK3Xd9I30VC0rlIeoOznGXrQoDAPE/NuIVb6Sox35VGy25p9eNQs/HXPJ8Vm3iuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776738092; c=relaxed/relaxed;
	bh=AHmsLfWP4VqB6EidVCtZitT2oU+Ddzspq2XDJx69+hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B4kZiH9oU7NhuO6lfLwdORGMWdlj0B9PX4QB8bZYa2lMsLQDHWLRNPwvaquVf8BwtjuvPdXMFCE+OGZskmaHoRdv+b/ocKOJ9cOfWyCGZ10gUMdhoaHxPf1ZTl+JRslsSeqEWBhRYxSwfcbvuGKg7+Pwd6cKBPwET1nbe55YkZeSrN9uV1gpaS0SHS7TkQONTBHVTP1zKAGgq309Q/FTHp3KCEndtlkjeGt1GzTrbkXZ21rYcmIBQm9VIh7pr3tU516q99716NFFwGFT2wxCN8B8ikKkSLNBdDmUPc+p+Imrezp1kZC5PYkY4ODo3Oc3WxXgHyz2YG5HGFVxi1gj7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WR/GTrB7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WR/GTrB7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g05hC4805z2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 12:21:31 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-82f8bf96b46so1783640b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 19:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776738090; x=1777342890; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHmsLfWP4VqB6EidVCtZitT2oU+Ddzspq2XDJx69+hM=;
        b=WR/GTrB7pLUyhu83NsY3oUsGhT3DgfaGzp9JF0dO9ugqVs6XNOOM59qkT2Dy/84Mjy
         cFeiCwb6YH1qFxYf+5kOXqyumrG5ocA25mKOBtX7L65SitbLs1NTLwuS+rTRpz38GK9I
         7Segg7CgCg11e9mjr0jfJKF/Z461k75flpZeq5Ft/shgcIVghu0vTY/n4Ol6jjy0APUz
         B82aEqR8rlqzwjW1yYLgwGyPvTESfvp5bR4VnZgJXoA0RrkXfG7ZhNc6XNprMDcDb7nH
         3Bwx0aWS/VjeqIHogj7PIm6Z+jpVSQwVJwx9tR94K/C3JYVty+kxCQ4TadJvmnIfXXNu
         50nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776738090; x=1777342890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AHmsLfWP4VqB6EidVCtZitT2oU+Ddzspq2XDJx69+hM=;
        b=RDTz068SRIknMN2k6A295xhO3PTuhUQvPsnZB6SI++Df061TCusrauU8SUxgymVB6s
         6S4HSOJtAKGzp/pfcvMOL7MA7FCm7pRul4hbA/5uIedfWyQLeM9KPp6ol28ON7x1f6Wk
         /tDyuf4OX2zqMQg6vRT9waljTL3Ly+B0r/7XYeH8AfXcTdrHyf6aGmteKoPuG16bu/qo
         do23kmQuiPVk9DIDYd+vh62DeuKJgg4bO+vuZtFNaOS/13lqdoEEb6Nx2C+VViiv6uij
         YT6yl0zx0QvP4bC4cGhlzSSjUTzyCp27mvzwERnmb6azZmMKCuU06xmjqePo1D1u9pFA
         0tIw==
X-Forwarded-Encrypted: i=1; AFNElJ8cNW8aBaqsM+nH4bIxcJaYzu/K17Hey4r10h5ON5nt7CGXYVNk/cIBKS7Wcqs3pI2OkrNVBEmtI59kS/A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyl59T8W52t9gH6obR/DVf4lb1yi+C/Sppv15pEy/MKbGsc6Bde
	kMUYuxbs+1kwt25x5/psqD0BDdSz5/jO11uDpIhwSf6qV2OWHyBY9TvT392tknHHDR0=
X-Gm-Gg: AeBDiesx3ReoBRMU2ZzxU6RJQJhF4yZGscAfUaLKTe0NhqmSpZ/F6FspBmuoEvZBBoW
	3YqV3emr8rArHk9XS+RGGAGYZTjW1xeGaQgwsukA8JHRVwFWSaQ3ZMfVjLox16T0qS+dLGLoldU
	2SZzT80S+Cd9IXPdX+He/gWnMJZ6OAxTjFJ4GMuWG2XZKzYb5TZDIFrMVPGYsveKTPuJgcgnOIk
	Y1y75mLfBqR8dSw7WquI9lTfIJMt96Ki3e49FeT8C6qOzRRcSDkacYpVV8KVZgQS34ckaL9keHa
	v0UVHvsBESwUrXwJJEPRCw6b8KdV+Ai3lm38AyUsW4dIPSzBoiqnkjkCrnX+NIfmp68mkzD1zic
	vB/+iLqwBn41tpFSYjEinBOSKtJCoR45LqpAkPLdbXRnjmLQ+CDfhnM3pR5uQzRh9cJ+nNatiFS
	/xRODmNtrJ2uHsYELuz1INJEOYyhRLEmmYZqf2pnQ=
X-Received: by 2002:a05:6a00:2993:b0:82a:6461:6d1e with SMTP id d2e1a72fcca58-82f8c92a5fbmr15190526b3a.46.1776738089510;
        Mon, 20 Apr 2026 19:21:29 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::340])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f932dabd4sm11538780b3a.51.2026.04.20.19.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:21:29 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
Date: Tue, 21 Apr 2026 10:20:44 +0800
Message-Id: <20260421022044.1217503-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260421022044.1217503-1-songmuchun@bytedance.com>
References: <20260421022044.1217503-1-songmuchun@bytedance.com>
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
---
 mm/mm_init.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..e2d8eae23aa3 100644
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
@@ -1122,6 +1120,9 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+
 		if (pfns_per_compound == 1)
 			continue;
 
@@ -1129,6 +1130,18 @@ void __ref memmap_init_zone_device(struct zone *zone,
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


