Return-Path: <linuxppc-dev+bounces-22536-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E11CD98D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:00:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5Pk2NLsz3bsd;
	Fri, 12 Jun 2026 13:59:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236794;
	cv=none; b=A+lhI3r/M+aB7pQ2GTkZBG4EKY7494uTlBoQPzoVDJXrC5O/58pruxNI4RvQV6vYNMXF1tlf0D506I5pxaIpKrvoToAxAZ0XetsUeWP6o4BweNMO3F1KH+2Rh3x0O2lh+xMVoiaLMO1E5CFhJCNRVgtZdDWbv36rDwWc0hvqpqvSInhuMzqW7yf0U8QAl3zy4KbTeEW34XZn7qY9HmlVth9EdPhON6LHRGrPZS7TzPGM9pfK9yxyEhEI3pGb8aECmZrVS1NwdPp14abCgQ3FeipyreOjRAIKu12MXV9yCkqhsQkuOkhAPhHFtPqmYJkL7thrb+GvJ//zNnjQ93g/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236794; c=relaxed/relaxed;
	bh=yvhwqnMK3KcBoOi11nGPI5ToHj8BHKdLuYKZ2RNMESg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oH3EpFpCm9g0/DIjXTHl0/gpxjRSGQEeDqVOzzgNfWMkwzJt/pAIzL+CbgovRabk4qLp+N0HG9RWIKVanPzVN2sm4I47lHgHdM+800XjYIXNs33favAjlgT1XVGwg04Lr4MUW9+Buo2lSIeugwhRD87dLJp058cGAHZJk9rlDDmwqCZmNR9Z48IL/0odDr4w9HWq4u2nZEW6JA0nvyoi+DgbK3EcFCmydgllPNjPYkeY06jGDf5rYqnYI70OGP6LkIJ4Qlfj4J46cHijbeRlZ6MvtnIaVNQl2wmexoELJEKu9U35jDzpIzOozsmB4tILMxWXMSh806kwV5jFbpgB+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PjXG7M25; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PjXG7M25;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5Pj4ybpz3bsZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 13:59:53 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so296322b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236792; x=1781841592; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvhwqnMK3KcBoOi11nGPI5ToHj8BHKdLuYKZ2RNMESg=;
        b=PjXG7M25zVLBduYQ6aZvFYELcgzAth60i7ZcSBonUKq3SrCOlYNF6RowdSeBXGGRGv
         DsbnoqJcbLrZMlrC+tUCbpSaBeA2g9b/kDPRNsP41jYhrZiAjPHXZOOTvrITgoQqa8rI
         2dqCXWKFmAl8i5Z61SkUcD/n6g8FHlIje5gZ+l5thhExkYxirpgav0gy63p5xIpI5xA7
         ovtSud9Ki4zG6OjS5d2eCqu/my0g9i4PAQtD/SGY5rvUPZNTY+TLqDQTBdnaktYZgn7+
         HdilHBSPJbUCZGySie5IngLVWf2eAuWKykL5/LZ3lHaLl8KnwK22jCaU0VAxKcI0Fw6B
         jsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236792; x=1781841592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yvhwqnMK3KcBoOi11nGPI5ToHj8BHKdLuYKZ2RNMESg=;
        b=JvaogCB4i5CPgN7Omr7F9fy5CMi7/9IGf5pGq69Y9p6fqDDiu3XrLPgvSUVENnfvqj
         I+Y2w7XX/BXnr6u6gZTq/gioJeY4+0ffCh8Pkk23JxMQVCMjHIxWW60k09kw1gW7gyAA
         yS87lPsNLi29i/AkuAVFTUQ9ZNrccB96YALiRRfvo5TuWofhaYuWQ/BwByd8E9g4uqYn
         7h9WCO/Urk6sEl6os4+iQTgo/3ofh16GITAx8L4zS2UVyukZxI2eeA77uKT2t+RWNrvx
         mMdJvPgebR9DlC/GBJfI3Qd+X3cdI4wQnTZyQsE/0ytCtZBzrqcU2MhN8/+A1m7HIfl/
         Lfhw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ypxc/ZcVjfc069Z5rupI1AOZ2MGpCE5dZsa6ZiFGic75VSRKBlfQcWWQaY4RPIoCF0i58B4sdc1vL8ZM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyRgIuLQOnqPlftXQTM9DyQhyK6u5k8w81nS6LeJ8suvtPcS1Ed
	29ily7GLp+ALG+GIzK/i0z1OcS7Z+/RSuhck9cMf2u8hxsU1EWns5AENpUSfPeb6fE4=
X-Gm-Gg: Acq92OFMm92Nevv4fKZB/MVXqb8NWmuUuXojpbcAuwIzSUTVYTQ158GUyzF6aVY6Pdj
	q+XcZaGyoBZ4DYFgCjSSST2RqTCI0dLKiEM3SMHm+NpivSMStuR+SW9+/EbKVS24FXYd9yAC3yE
	MdNcz/ymG7k/ab7MWMzjnQzjnSnzGg+LUnR9hX0r2jQSDoGjlmOCnm3o8120yLxnxS820BVd7CR
	Uyk8YoTa/tDa3U8fIow8xMprSJxI19gcCidL7WwG7KGugJL9Zsxi2+zQQK3tisVMX5GA+xnApfj
	EemBIeh/YzM//Y3NaplrB6Z4WKU0EOvjqeIB4e3ikuHmrBQQIaRD8opJEvuGxliclyzaU/NiW+F
	wIgo2fHhuPa3tqA2VUJ5FiqqHUQOiC/CegVCAxH/+7+SGzu0N+otfNIyc3agml1YqvEcqnnQzG9
	P0BUkisN6SA+fr2fvS8S9Xpp+QH8xIXMG3M8igK3335WE=
X-Received: by 2002:a05:6a00:3a10:b0:82a:146d:36a3 with SMTP id d2e1a72fcca58-8434d0d07f8mr834215b3a.21.1781236791584;
        Thu, 11 Jun 2026 20:59:51 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:51 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>
Subject: [PATCH v4 08/19] mm/mm_init: Defer sparse_init() until after zone initialization
Date: Fri, 12 Jun 2026 11:58:52 +0800
Message-ID: <20260612035903.2468601-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
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

free_area_init() is responsible for initializing pgdat and zone state.
Calling sparse_init() from there mixes in later vmemmap and struct page
setup, which makes the initialization flow less clear.

Defer sparse_init(), sparse_vmemmap_init_nid_late(), and memmap_init()
until after free_area_init() completes, when zone initialization is fully
done. This keeps free_area_init() focused on zone setup and ensures that
sparse_init() runs with the relevant zone state already available.

This is also a prerequisite for later hugetlb vmemmap changes that need
zone information during early sparse vmemmap setup.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
---
 mm/mm_init.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index dbcd60a38c49..bdeaceadb531 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1814,7 +1814,6 @@ static void __init free_area_init(void)
 	bool descending;
 
 	arch_zone_limits_init(max_zone_pfn);
-	sparse_init();
 
 	start_pfn = PHYS_PFN(memblock_start_of_DRAM());
 	descending = arch_has_descending_max_zone_pfns();
@@ -1903,11 +1902,7 @@ static void __init free_area_init(void)
 		}
 	}
 
-	for_each_node_state(nid, N_MEMORY)
-		sparse_vmemmap_init_nid_late(nid);
-
 	calc_nr_kernel_pages();
-	memmap_init();
 
 	/* disable hash distribution for systems with a single node */
 	fixup_hashdist();
@@ -2679,10 +2674,17 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
+	int nid;
+
 	hugetlb_cma_reserve();
 	hugetlb_bootmem_alloc();
 
 	free_area_init();
+
+	sparse_init();
+	for_each_node_state(nid, N_MEMORY)
+		sparse_vmemmap_init_nid_late(nid);
+	memmap_init();
 }
 
 /*
-- 
2.54.0


