Return-Path: <linuxppc-dev+bounces-21883-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93624CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:11:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV67D49kSz3c05;
	Tue, 02 Jun 2026 20:11:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395096;
	cv=none; b=XyNBQOYinzFznuNrpBqsE+v881UmK/kjuuVp4Gsu/R/gUSElo/b01ME1KRl5P9T6Hgh19YyCFOBweroZpKk51La3RaGtOHFBek3BJQYIIFy75cJWgiIzYby3vpG8kBFQCAnEwFmJIWxTkrBmG9pLPbHywX8h2MBQxS7msn+yCXugukzHRCej7gbh2Ri3CiGvrWXxyvKR3sMS/pdosy0CXfgtk9UOP5S4lcKDL+4IW3P+tx5iseR24AIe0OA/2DHKzJJCD2W66FMHSYkAPV0pzDL0XBbxJCgFpHjnFSdo3Z96NCfTlFtOkMI5e1aKGzK/0MzWSB7gboXEcrhg7Tlyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395096; c=relaxed/relaxed;
	bh=r2XnUrRZ1W0TfW9t5CZRJtozKMCRYAjD9rqyDyxjcoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCMrnn2gxwIzGH2ittIkqy609brH7GSbX+y0ydHMlIjNSQsW8LhntwWYJlbs1ojFrs6VIFrPFntCeVgrhupTZVR+PwtrzDeYNROw7L8RgjGiQoRth66v1WAYf/fCWvWopmuHVtr7GH6CWy5Mlwtg/P+r4KMB4+zIn5vqHB0UENdVlhRORpFIokAXjAsq3GX/NuZy3ZIqPyhTO0rrRDWOXEAmlAopMIuj5gJvmBBAsLNJal7JlwjjmxX6mjOgoAzjPXxLIFWWq4oALgwLM5ll7CQBfJkF1qdhsCpbqG6+Iruew916yZb+w+XDsjrLPsCQZRgxY3Jtk5gng6KPnAm59Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=h9wrmvpC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=h9wrmvpC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV67C53XXz3byl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:11:35 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-84237c55ef9so1009271b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395094; x=1780999894; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2XnUrRZ1W0TfW9t5CZRJtozKMCRYAjD9rqyDyxjcoI=;
        b=h9wrmvpCClfTsKtw1oNR5VKr3VrxTymdWh2LPbYxMaDJwUGP6ajii6uxZQJabWSYGU
         QMcAwa4jN681QuwuYvTHPcHyYZwm/pcLaL+Ctp2eFSHLfk5Pj1+u0QZnch41ut3P0lsb
         RS0gc59EvMyX7qOVOfQWANElUrJ+YuHTFar89TSHhzFVM3unNk5wooFKXuT2Mh1p6XbT
         n36In5UsWWWb98t903ubC6bIFfdHxFxjkS8yuG9SAPMsj1ia7KfL0bHLfl7n1rq2hEKk
         2HEemt12OX1XiOI5wgCeSk3pl30CclP2r9qqwFIrp0ABTdEiwgVZkO/MLWyTHY671wDb
         d1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395094; x=1780999894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2XnUrRZ1W0TfW9t5CZRJtozKMCRYAjD9rqyDyxjcoI=;
        b=izUjedxTF4gNLdbek+ReVGEQhMuOng6yc1zc7QeSde237dAGuqrE5IQwxWjxMLFLWc
         vItHor1G5rb5s4Lq0E7GIlNaD58HflkS5JybCmJHhgWpMOUJOfw2RkygaVVrFgMqxuQ/
         GjYyJaDzMgdZI/3Z7wtOl0OwB3aQhHbtJVg63HloaiC14kMw4Q/2pVJQmtv/0uv7t8CV
         BiyELNrF4CuSxjFZbzw93mwdzQZjH6Uxdn+qlnnQ+wy+XiH4W0T8gOTdRucgSRmE/9sA
         dve/az22xzUxFbmYbRrQxS7tkloOXSBM/NntOb3ylZFSFjrAlowQFhJI2z9DRy3JeyAb
         6fMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vRq7npTJY8aAlVe6qGk91/wrCUxl0u1iw03gFJE9//BORzQJ56qhTWbH3xtwzY/+MdmCqViL+IY0M1rA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUrCG/O2SnAaZuOn4AVtZQrIxGT4BFOP+tUOsJ7Ii9a9J5g9mv
	Oseme297/hTc4cW5P0EtioPjy39xe4Jc8oVjYby8IzXyGhp0Qb2+uV7Lm4z+Ep3iLck=
X-Gm-Gg: Acq92OE5Uvm/ivBl1ZIdO61bzbew+4HTYYZDGu+R1wjhkCD3h6zIAkjr/ipKWJkvAp2
	ldpeWywDWTgWFWQ+VRiiPK1FcjvBD+S0wPH2qeKPQtwUiIcT0rW1R9zW+4NbhTmubZ5CJtmkdEg
	6XICLcMRfiCMn7eAGatOQENuXd5QXPELUB50fUs5tYm/sCpqbDvPFZ16JMpZ+TTiYqf2RmR+bbe
	YFR6dnuEy7Mv1XNQYFEsCkRvMg17yuvZ5RPpF9ch4ctvgz1daE0LfKxBiHGk0n4qy2nnDI+zomy
	gg0b++TmIxH5EXx5f0gu73VNd01iieF1fMFfvFSyWymfr/z4s1fdOKMgkJCdZ36SkvWjIS5Mf4j
	rFKB6h415PilAhghvamP3JB6/moX7bQUk8xbj1fBXt661g1oHap4LXu3Xr+m/BjboxY5BKuzAQ6
	UwklDUQA8wkuTtTd6B4ovyOPXU7QFOsRHUpCG5rJghpBUFhzmJ3g7x7tkd7nciMLUWsQ==
X-Received: by 2002:a05:6a00:4b50:b0:841:edbf:6424 with SMTP id d2e1a72fcca58-842253d6616mr12648288b3a.13.1780395093559;
        Tue, 02 Jun 2026 03:11:33 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:11:33 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>
Subject: [PATCH v3 08/19] mm/mm_init: Defer sparse_init() until after zone initialization
Date: Tue,  2 Jun 2026 18:10:28 +0800
Message-ID: <20260602101039.1867613-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602101039.1867613-1-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
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
v2->v3:
- collect Reviewed-by from Oscar Salvador
---
 mm/mm_init.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3a57bf5a9b46..f349a6f34139 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1829,7 +1829,6 @@ static void __init free_area_init(void)
 	bool descending;
 
 	arch_zone_limits_init(max_zone_pfn);
-	sparse_init();
 
 	start_pfn = PHYS_PFN(memblock_start_of_DRAM());
 	descending = arch_has_descending_max_zone_pfns();
@@ -1918,11 +1917,7 @@ static void __init free_area_init(void)
 		}
 	}
 
-	for_each_node_state(nid, N_MEMORY)
-		sparse_vmemmap_init_nid_late(nid);
-
 	calc_nr_kernel_pages();
-	memmap_init();
 
 	/* disable hash distribution for systems with a single node */
 	fixup_hashdist();
@@ -2694,10 +2689,17 @@ void __init __weak mem_init(void)
 
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


