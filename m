Return-Path: <linuxppc-dev+bounces-20875-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A34CCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:11:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv2N2sQQz2yVZ;
	Wed, 13 May 2026 23:10:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677804;
	cv=none; b=PCzdJ6/vmtUBJBUQ9rJkgWf5dOXjUhA+M5BBx4bQjkdGlL1//fyrCvGcBG+eJYx6p7q7XfrieR9Ls9KU4MawvoDqit0NwooMu+CSE0dq8B7I0biyY8smtOaAldaEPM2v/angEWGBhJTbLwtEoEFpHS2O+PBw5jeRh6jUDd7VdDbtTzyMIW9z0p2BVk0Wxu7O0BqRYKCvne+rXs30ejme/pwFDSvMQtWkEUJSN1UegbYABEKzJcmJmhw2WEh4xBaGBU6cJGlDfnJ4JJAvOmyynoxiX4flNgJQJlmRGossR3+XTM3rRNJ3GgR9XAO0JbEUaEMYM0AdvaASXw5JAsQgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677804; c=relaxed/relaxed;
	bh=TcJbixi8CH0+fCoBl2UtMRXMhZzJhhVobMYZVtSUs0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/bHxkzGPnZd8S3XHmFs7AdcbZaxFtD1OYuSOPqBGbxTV8b5n/gUuEXKLRHZgSV7AVHedUR0kalmoyxL0bcuBPpvPTlhNI7flPNQqJn80o9jhmS+5oNaomvElNebRu0F85Ewc6t4ZcCkFHvehhx37smGFx9SxjLH+qbawvwOQDVlxCFh1HxHIVbcBIZEFJ2pzxA/o6ueb2f1bVTIXUxRRTc0Dzt6tUWN9QuPzt79w3zqYNj/k0xx6Zo4sJW7991aTQD/bhwLpxVNmrCnVd6SkZoqzvb4MQvolE4tWg++o4Rn2b+ISJtMvvyoT1/v+4FvQMxXlLnt49LE5Ap/RfDEpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OVHyTg7o; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OVHyTg7o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv2M4gPHz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:03 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2ba4efedbeaso47462435ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677802; x=1779282602; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcJbixi8CH0+fCoBl2UtMRXMhZzJhhVobMYZVtSUs0g=;
        b=OVHyTg7osLvQE0GcgRQC7VhyLt/0NF38M8lrEoJjwQvCULx+Id8rllbDXBtJlJUCzd
         Bv4A/y2dYhOMtyo6ucteuJJu6fHnx10UexYTcgFtHYKZyTBNk+Xz5UQfg09ItYpbuvZN
         oBqkUnLuqOg0BgALZvGA0y95lJxJj/zSUd2TbJye8CtOEeo82sOdXQ6nTRuM6t+GBAMw
         F/Zc0XQosCAyQkN6hkJvsJVvwcGPOfxCpzNOUSoZ3YHUPOb4slDBdJkFK2GVJg7obyPt
         V78SbCNolh0yM4mUIrQDYWwdkqa+7AuYmce70glrExSl0VAb2jvgU++gdioTTd/ey6dO
         ltNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677802; x=1779282602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcJbixi8CH0+fCoBl2UtMRXMhZzJhhVobMYZVtSUs0g=;
        b=j8Bryk8WFv/ZFmEVApcWIsr6DsnL8/a/3TBVePn89MsoS540i5IULuQu5m3ZlPxZV+
         boaTXJphCNC++yI2gLsXOxu5XkyGb6Gnp9bE0EJZt9BfUm42V0TOXtFWs9NEe4ii5Ir3
         0ZzGpFn1sC2dmMGxF/TvhyVuUSyPCdyfJTIafz6E9ry//kz8xKAQMTMTz7uyOtLOlhv4
         C6y0GGx3cP8PebzuaScQLn4ZrRSpZFpUjPpE/CccxIEE3pHphu5bqWbEHdICK4R3eDcQ
         dJHQJ50XjzpK8gELTTFKahCk3BJgPgUnfW7M9nBHLUtWWKLOVFM4EocqsgQaVyUYX01c
         /glw==
X-Forwarded-Encrypted: i=1; AFNElJ/QdrjfcOw+tlciREApnPXlAONOG0PaFTwIZX7oaLdjVgJJNzUpMH/+XSm4nVjDksVW08tkxZRzxkZfno8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz56UjwaP9x22fna6j8yEU4KOBLqAc9MFCZiWPURc/eow+Eo2Hv
	ZAvUoAlbsZM1NbBQrs3Jvru8Y4Q/Xgudnik1w1LkZkBKv7HjU5joZ7gSU6TPw1lUM4k=
X-Gm-Gg: Acq92OHpnPe7vdD6JeVjT2wBie3FcLnNJExlKsKWy636UHFGokguH26o6G5OMJDq5L+
	ugvdkfnUhggSeReegk9/riNU27IYkDb1tR482XriFE7c2MX2LddAbHnjPstdxULDHJAUHsj6elq
	T7/BMNCletiAfpEy8HC8LqmUDyBYDHFcD0JV/8s2vhI0yHrY7Z8pC16/Z0SJNYONNIPUqY3KqRR
	IViCu0U9ftMDmPYQRBd8UBA9kOIxf/hRMW28hAdA6l9/mM0nxlS6ZzsIuWbVy4TVmSa9HRybGTV
	8xkdVt7Ete7CThWZrUZodtZsYDod9dwkQHnZReEutI8lb4dqv3m0J6+5BeDc+fsze+0uZy42Ke7
	n4ec1SUWb6kHGCGK91i2R4KB3gH3tMFbJZfLpMWSPt2mFa4ct/Nmbzqbl+bzxoVGE/mgpe8YWYP
	G7RIltr3wvwDWdN5x+klO/UwVuuOM3mnRPLLhjmQsOVGaiAu3thDSXPKJXmzQ=
X-Received: by 2002:a17:902:ced0:b0:2ba:67f7:9326 with SMTP id d9443c01a7336-2bd2f6080a2mr31395015ad.9.1778677796975;
        Wed, 13 May 2026 06:09:56 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.09.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:09:56 -0700 (PDT)
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
Subject: [PATCH v2 26/69] mm/sparse-vmemmap: Support section-based vmemmap accounting
Date: Wed, 13 May 2026 21:04:54 +0800
Message-ID: <20260513130542.35604-27-songmuchun@bytedance.com>
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

Teach section_nr_vmemmap_pages() to account for section-based vmemmap
optimization, so the helper can report the vmemmap page usage for a
memory section with or without shared tail vmemmap pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h |  8 ++++++++
 mm/sparse-vmemmap.c    | 13 +++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5fc968bac1f7..0974205abd3d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2269,6 +2269,14 @@ static inline unsigned int pfn_to_section_order(unsigned long pfn)
 	return section_order(__pfn_to_section(pfn));
 }
 
+static inline bool section_vmemmap_optimizable(const struct mem_section *section)
+{
+	if (!is_power_of_2(sizeof(struct page)))
+		return false;
+
+	return section_order(section) >= OPTIMIZABLE_FOLIO_MIN_ORDER;
+}
+
 void sparse_init_early_section(int nid, struct page *map, unsigned long pnum,
 			       unsigned long flags);
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 60d5330a8399..94964363d95c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -629,24 +629,29 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 static int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
-	const unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
+	const struct mem_section *ms = __pfn_to_section(pfn);
+	const unsigned int order = pgmap ? pgmap->vmemmap_shift : section_order(ms);
 	const unsigned long pages_per_compound = 1UL << order;
+	unsigned int vmemmap_pages = OPTIMIZED_FOLIO_VMEMMAP_PAGES;
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
 	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
 
-	if (!vmemmap_can_optimize(altmap, pgmap))
+	if (vmemmap_can_optimize(altmap, pgmap))
+		vmemmap_pages = VMEMMAP_RESERVE_NR;
+
+	if (!vmemmap_can_optimize(altmap, pgmap) && !section_vmemmap_optimizable(ms))
 		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 
 	if (order < PFN_SECTION_SHIFT) {
 		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
-		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
+		return vmemmap_pages * nr_pages / pages_per_compound;
 	}
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
 
 	if (IS_ALIGNED(pfn, pages_per_compound))
-		return VMEMMAP_RESERVE_NR;
+		return vmemmap_pages;
 
 	return 0;
 }
-- 
2.54.0


