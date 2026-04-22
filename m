Return-Path: <linuxppc-dev+bounces-19941-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A690F94CDF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:15:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0sTv0C5Gz308l;
	Wed, 22 Apr 2026 18:15:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776845714;
	cv=none; b=Xlh10aVNv/BLEXJMBqRXs5/t2dWzlDXp2DCqL/2dAQfiXqFB/o6klzfOvofX+Wv8pdW6T5PCKuEw8VTms/fH0qURWThzc1jdxrd2WpMvVMJtDbGNL1gYeNHjdCzqcQUy5nQCtnxq4yNz9NVTuNdPgqzRn0tIN9HnNrdPjpn4bvK5C8JTxi7fRKOcP+CKWzUfe3Y867Di6Il7rxKr4Evoqay1cjT5apOBJ8I0//zQ6RxpYM/Tq7RbJkZ2njf8tbi25raMlRPhDzl7IHuFDwiLljHHJIRG4hWWKS9OgRzQ4qYbjwwVOgGHQmrn9VTO7vSnUEz8SVvTj8pV2LrqnGumtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776845714; c=relaxed/relaxed;
	bh=zoaHiX3AHT0NhATrQNxOKRmMP5bMIl291LjVzN6aqQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZ2KgHFm4AK858fOaGe9sLZ8Mxw2KtPhcWUkqLFvPkHgNP536AsnxBJR3auWA6WxjebM1F3fjSlketMLF1w5zZ0qGY8ZcIYgR2whuD0xsBi1XpsViJbLhhLfygCgD1epNr/1m6GP6SbgBMrdn30DVMnb54FWbsAL4g0RhtBEaAtVm1a6urX5wyQohoFTp6pwgbHMwZXb46YguNvg0dUMFurjoqadO9q6UwSA7EOVGUjPuIqrOmzvvqJXAQmqPkvthRAZKXPjz42Poo+D/9Q8Ouq/x027KCJ7sfCwaazozJZ7LPvZDLhnNlhC9ud43YzWzkb3QvTmme7xcSYbqKgQ2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=I/n0wrKW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=I/n0wrKW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0sTt1bZ5z2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 18:15:14 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso3139473b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 01:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776845712; x=1777450512; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoaHiX3AHT0NhATrQNxOKRmMP5bMIl291LjVzN6aqQg=;
        b=I/n0wrKWjQGfFGqKjYb91IwRGTPkmpQzlkblbPAPdeWryYTmPl3f8h5xJr7I7s2bET
         7nvl3TFl2h2/Zk4A12ENjNsXWqnFOdvwf7NIdeU2rHeUu0cMUYDnvB3LSOhvQdqCoqgD
         6BjWfWyK4pw8yiI5FLFnJqujngj9HChK4b0Y/bnkRGGgH0MX8zu8wwGu7Ql86Ti9lM1f
         UF0TO5+g03mZwO3DqMc6Pb6L/KBQ/qgH1TWlyCi/ZDEdBXjqXV47jzS587fH5nUu8o/T
         qetdTE568X8Xhb3FY0lAC4zX8TFIEoLAqIAMvRaDFdFoBH99Nk6J1r5dBnot6929qyN3
         PUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776845712; x=1777450512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoaHiX3AHT0NhATrQNxOKRmMP5bMIl291LjVzN6aqQg=;
        b=CwDlnyAhd1JGCNX4UVTBh59G8Zu/IZdlxEksQE1OcZ6WDzsaxcu8LN2g9zNHuKQyew
         rORvey4yP9EXrqBbvQ070L3nsav1U00ZEE5M2CXbs9HfVH/8oJxjHSMsc41VARdYNW2B
         vphDzXMyCkLjCQmM23IDt9PX9/a2v/BwtOl7TNej33St8gbgFkUmNSgP9WFp/tSLol2B
         deXkpY0nfoMWuXliyMfZc9uUMrFCNsIo5RbJ81yNNDlwZQAAwqTY3MhLusGK3wcjPyp2
         os5kVf1lr/5UD5THcd2WhHmiAi3hAdhdit7soiwlbAZO18FRdcS/jc8SKU4eIoMt03x1
         HQCw==
X-Forwarded-Encrypted: i=1; AFNElJ+migE6bZtf+xKjBS4cVzYtqjXv5DFB6zVVEgoyZrsFFkzvQnpaiGUxpfOpwTyY85rw3nuXCR8vDit8rOg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywdo71PN+HRTEPVKj2x3oWJ2m2OG8Hdy6/uNgYFNOE4c/5YAYCh
	ebIYVIZSzNOyn2uXrXGukUcL5PH/60CREIM+6ClOlmR453edJgfCiDA42+jI6pcMG60=
X-Gm-Gg: AeBDies4w6MRx8EiUVitgvRRDdJDyDfp87TqEzhgdNaiK7aCljoxuUEtoYaofrEIclD
	RHhuomcaUBgCWhE1hfvUWVa//m62W6hnzN4s9ILLgAkD0UrglwJoKyPeGgZ+v+5Kld1P5uQb6jN
	TW7O0II6ripKrZilvKyYL6KFxdWIlIaNEAqzn5tI/5aNwbzAUaQsSJP3RJ0Mxajeh7lS9vn0b7t
	VqEDr2ME6w0ksbh9+5Z8AlA9PEQ6zNrIaoqatvUFWQkj9fRlxI0iVe8uo8XD/snAwm9ofkBsS8o
	fz8zXRgKzhHdzp8bbGR6lgw5hpyrXBzsOL+/tk2+FF+Xq5tx212ow/VQquFS1uo9z9L33jFNWDK
	1s6f1Eucbhm0fKDGwl2o57+ixBq9jxG7G0yt37EYa6w9pYCafmEfGzYSJuZrCLkuzzSz+Ho12mL
	vYOPBU/EMFzaPtSZkIbEroZTFuMuSS
X-Received: by 2002:a05:6a00:2988:b0:82f:58d4:d348 with SMTP id d2e1a72fcca58-82f8b57510dmr17881058b3a.35.1776845712042;
        Wed, 22 Apr 2026 01:15:12 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec0307esm16522874b3a.53.2026.04.22.01.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:15:11 -0700 (PDT)
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
Subject: [PATCH v4 5/5] mm/mm_init: Fix uninitialized struct pages for ZONE_DEVICE
Date: Wed, 22 Apr 2026 16:14:20 +0800
Message-Id: <20260422081420.4009847-6-songmuchun@bytedance.com>
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

If DAX memory is hotplugged into an unoccupied subsection of an early
section, section_activate() reuses the unoptimized boot memmap.
However, compound_nr_pages() still assumes that vmemmap optimization is
in effect and initializes only the reduced number of struct pages. As a
result, the remaining tail struct pages are left uninitialized, which
can later lead to unexpected behavior or crashes.

Fix this by treating early sections as unoptimized when calculating how
many struct pages to initialize.

Fixes: 6fd3620b3428 ("mm/page_alloc: reuse tail struct pages for compound devmaps")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mm_init.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9d0fe79a94de..3d5af40d0943 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1056,10 +1056,17 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
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
@@ -1129,7 +1136,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
 	/*
-- 
2.20.1


