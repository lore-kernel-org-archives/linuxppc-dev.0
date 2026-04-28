Return-Path: <linuxppc-dev+bounces-20225-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233FCFF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 08:19:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4YHz488Rz2ySf;
	Tue, 28 Apr 2026 18:19:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777364367;
	cv=none; b=WIgVZlT7u84D/a3329n/9dpkM8VxpRvwtONpDnzCH5oV23xMvZTvPLQw69iBbz17MBGYSOWc3CdFEVnS5gfTCefNjinvK23aTVcmchaqyxLP9She3iE4xfKzy313Zqn6cJOH0WfNepuhuP9WTEL2o2F+A74WgmhiMCPbrkX2gPl+WOLS6WlPSYXnzAyPDjEsagmC5p6VkHDntmHfBLDqnjdHKuAyB24kbWR9dYto53+s58F5rN3cRd3jpEnfJ0N1cX/Oy/4fG+wtV6g98wRvZG361T8bLwBgxmaEs0NUxsMkkweIZmrP7VRsdQDEHYhusxKOnDF8HT3joOzl5wAYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777364367; c=relaxed/relaxed;
	bh=rL183+C/B0Npg+SiHlF1+/ufB8oZmfwNupE6AmX40Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ht/ZuFkxsuKn0koWz3cz+flOFseGvvfj+pHfKuwqP/xgax8J5HegdFy5C06YlXPmIPWGOyvzwd6FJbcycYQK0Rx4s1JFfjOo8qiT4PNR86yzKE0yEdoha5HrvIOPr8KjwOFcaGuIqat8rNY5WqnfLDAqOcpHOhZFTQhOOfEHvaTIX3N3VrcNbHVCWU9LpDkDvFRNAuJTOkDq16ACmweJI3twiTYtspgY/2gEe6hUwWsGGcWzLp1BEYyDaMwL73GDUmjXssYCDqU+xhRDetXWYzYy/p+06Hic52sLi2mGpdETRYbyjyF5lrTf82YqK8688H9kINA6sfFgzgOCbco2Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kbarLWTO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kbarLWTO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4YHy5yLLz2yr4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 18:19:26 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-35fb7c1a455so4112469a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777364365; x=1777969165; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL183+C/B0Npg+SiHlF1+/ufB8oZmfwNupE6AmX40Ic=;
        b=kbarLWTOjs54Fuaop4Y7A/QTI3FWw+4UkNEi1QojID4PymS2Sir9KZkzY6JejIvvIn
         QaUt94tCxATiPy1WuV8Ic4I/d6vvE4rWhtdfEhdN1oVJk43fDlI+62LU8YSCZO12iWqH
         CQKQyXVVw+iaG8ZK6He8fvRmFLkKO/WEu1ZYGIMN+vKskduM/At3hp6G1WOQG1c4xRxc
         oz0ZzP7/oaTx/WRiq8VRYx1cOP77jC7kmWkDl6GQXPKdv9Nb7Ne5A/5uR6YKQ9O2OC/L
         iYNd77QCEzIaFbZFYBFCf9t/zpIvR7N7ekbUiVdFxRieN3xi5FD33b5+VJcYzTCRhaRx
         kl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364365; x=1777969165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rL183+C/B0Npg+SiHlF1+/ufB8oZmfwNupE6AmX40Ic=;
        b=dA1SV3tXHavFJAvKyCSIigUHxzmaAhglOgx3KCyJUCUggtxTcMSM5XWmmh60FlfLgt
         UERn7yByK//oJmUd5qNDGYm85RTOjT2QyNDty7XMz/WyQukKHO7IKFhdlcP+hSDvZ3Sv
         5vzvseJHdOsNNz5nQZcuQgVvg2yKaWn0s5aN78DZfdlpDuia0u8VCjXDVdwF9jp8o7dU
         0I65G+TCJR/m5cKD4/sn5IIwSSfcSnelziIMiazHoVB/puxIvUMCYz3NdpJe1anCudKd
         +rlhUmnaVyeZRtM/STjFUk3vM3D3gDX4W6Nnxt8V7dHpKEkn5rldsjyCZKlFYi8oNqxp
         z+MA==
X-Forwarded-Encrypted: i=1; AFNElJ8i1O8I+lJFCPbn+6VkD6Hg+EJD9DHM08ehfhQ0XPyM6avhX9jA7UJWkaC1eEVcHFP5AAitjocDD8/Ak8E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwOgPUfhQi0HBAgTKBNTlOD8LnyvERp8cuu9PUL859o2gPcVgv6
	RcNQ9fzacVMXZaiqPPdUSH2LovAeou8b0+TX3KJdEQaraP6r3//2L+MgjZ1qjh+1rNc=
X-Gm-Gg: AeBDievpXtuanvbrPO7PCbpsVfi4WSGJJ1Sv4wlhAwyRm9emclT+SqDur+iHK/z79lj
	8GXbbFRHDaC0/IPJYQySdJE4KV6wySk7tgH1V5izOh8mfhLrvVXw/tueCFRbzWFQ2qOp68iRT1I
	GvkPX0tHIyQh2np6qDmKK06etQHryBk/UPm1NNEpfEtfHBMyXq5OQMtVMRjJ7WbdFN27K+i1tLo
	y+4kqEgC5Na8ogagEaowG4hOcrlqERQKrkUBzQMhQDOniPWMHVnZrSeI9WN8CLlaRPMj5Co7/ap
	H+md+ir+kFBuDU3LIImoJqOxc4dae50aUSlytse4dPa16pw1zuk63vpElmGozMMfGMKBzxVvO3R
	S3+Wt0o7j3NQvgGy040Bz9uCjaTKNgg1okXZ6+seSKSdPbTrs2mQ4eNgvbTxORormtq/Xp/cVk+
	0X5TyoQUQIMHP3KMXuI2wclKjPqG4ogmVasblqv0qocFYvMbvuLMse7Gfwkrnbs+HULA==
X-Received: by 2002:a17:90b:56cf:b0:35b:96bb:47ba with SMTP id 98e67ed59e1d1-364921a915dmr2295268a91.26.1777364364837;
        Tue, 28 Apr 2026 01:19:24 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm2181356a91.8.2026.04.28.01.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:19:24 -0700 (PDT)
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
Subject: [PATCH v8 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Tue, 28 Apr 2026 16:18:53 +0800
Message-Id: <20260428081855.1249045-5-songmuchun@bytedance.com>
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

When vmemmap optimization is enabled for DAX, the nr_memmap_pages
counter in /proc/vmstat is incorrect. The current code always accounts
for the full, non-optimized vmemmap size, but vmemmap optimization
reduces the actual number of vmemmap pages by reusing tail pages. This
causes the system to overcount vmemmap usage, leading to inaccurate
page statistics in /proc/vmstat.

Fix this by introducing section_nr_vmemmap_pages(), which returns the exact
vmemmap page count for a given pfn range based on whether optimization
is in effect.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v7-v8:
- Move VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION); to the top of
  section_nr_vmemmap_pages().
- Add Acked-by from David.
---
 mm/sparse-vmemmap.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3340f6d30b01..932082296e8d 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -652,6 +652,31 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }
 
+static int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+{
+	const unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
+	const unsigned long pages_per_compound = 1UL << order;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
+	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
+
+	if (!vmemmap_can_optimize(altmap, pgmap))
+		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+
+	if (order < PFN_SECTION_SHIFT) {
+		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
+		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
+	}
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
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
@@ -659,7 +684,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 
 	return page;
 }
@@ -670,7 +695,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -678,9 +703,10 @@ static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
+	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
-						  PAGE_SIZE)));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
+							NULL, NULL));
 	vmemmap_free(start, end, NULL);
 }
 
-- 
2.20.1


