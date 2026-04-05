Return-Path: <linuxppc-dev+bounces-19333-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEE1F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:53:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXT327sYz2ybQ;
	Sun, 05 Apr 2026 22:53:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393623;
	cv=none; b=obc1frRv5pehGG8qMbd6imEXdhrI3Q17bmESUL3fQ0nWeaYF4uXLZAqXHDYiXaZL3OxRWOuUAQU+JsvJtvqKRViVGGvfXz06QNg54JdBUdS0Zki/nig8HtgrdeYS7RjpByVGqNpkCK3rP6JApRcfaH0m3Yf4yVbsnNcHYlfrJc9VCn+hAXtQCwz9CYhAcZlR9D/AqaaEf3gGCQOlwmgDHwYc93gviWlHHq3djUNaFktb+mz1ClsFkKzKFZCZ6D7xXw47+qOjeL8X6gLBwgE42ygb78sTEcUTxxFZpuhkQ8kXGtYTvYjvV31tLoHGTxu6q60g1q8C63x1FdEqoF//Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393623; c=relaxed/relaxed;
	bh=svlwS891ot0oMz7BvAOAaxoIhgC5OOWs0OTR+KAyilA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RhRRbyVetL5APRsyoq9isgA6uQWV6k5PonXqjHcmgTmFd7GbcBpnXDttrbTXycPekRxV+F+5rJK3i+iRATepAZHPp2qcupN85iup+rTuR5J+bWyuVZh0QoNGJjYUS6nPT9fDW10Q3mXQMHaN2tdkZjY6slWIhoEeTMYCqsa50FUp86eMs79kBLtxQBtD3mOozrDcFbOWBQ8OGu5y49qGhDpQuUycZ6FcNSVWkfgSzoDl2kTVfNMZ4ZvqGBtqPOS6EJu1HNTK2pfG0bT4QqLG+YWSBHWuYGRKy3Lr/JPzle6ATjrOmUgKGUQkRYJMJGdxCBb/CTlgc+/ev5s4o6hoow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gG4/6QvN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gG4/6QvN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXT24kStz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:53:42 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-35c124d2613so1749940a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393621; x=1775998421; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svlwS891ot0oMz7BvAOAaxoIhgC5OOWs0OTR+KAyilA=;
        b=gG4/6QvNlZsOZr8HeRyRx2+IdAKYooxYkLPZTfLjLLcb2fFK84EwS0YfGHLLoQUCUr
         /0J8QFDHE02g/+Db8wa+1XJR8VSqoWxDwEBKE3kHm/cSb8krpkfJBZTjg5zBLNliKltJ
         DzJQu1HcOZZrCjqoh3rzzlXyAqovg472loVxx2OO/AmRhJVo8uDCb8qJgVVcaKnPOapk
         hujWTeAqlnNWFluaQo94dsymxbj0QuL8j+UNhCgx/Zna10UuBK952/2JYCr4yYddXaLq
         CbDJKgVkyhfx4gQWhEVKD+wn58Fj6ahCXkV7OLYf6o9qRVc1Bqe7ZypvohZcGiFf9xuJ
         5Slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393621; x=1775998421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svlwS891ot0oMz7BvAOAaxoIhgC5OOWs0OTR+KAyilA=;
        b=fEUKl5mAu/vQ0RnGsU95Yg1+f+kN3yRQjastMsvjcn5V89P+8M90lgW6CeCysMEwYw
         bddMr9GQ1qYpAh65rSHzpiJiXTKg1urgzyv8AaW4NmvdASWA1wb3NImHn8OOmA6yoBpx
         eK5p37GdZ9P9t/Z/CgOxyNsBnAheBHZzTMvUivp98R+Vge7kq3OPGzSCfxIQ1/IhnXP1
         T+zH7l5ad/YhTmKWi8eHJxmb8JBNNgv4J0z0d1tvXR90HFHvqXl1BU2xFbL9p/5U0Brj
         zPm/W8BqOMSvFSuB2ExM8FBwW9hQ9+WZFt+fiSv8sjWLfPtOq0H7QA4IU3YiBiIiJg6n
         frpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk7sSrNPPl9dnEbUYWYD3AXsxGcClFMOIY6sSL2pj0cTbNyDKRWPo3cfGtzoXJWXN7zEteTC3DE0xS0kI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwzBTTryrZpdVp/jTOTqsdsHYadKAZiKVMFYaWtIjZVzOFe5c8d
	EokCOeozwyZG1+IKA5bTx+dYfgItU8iBdOJaMdPRhCS5kq4PQSCu4gbywED28HBTQFY=
X-Gm-Gg: AeBDievnXlAgsuWL0Hj+b14q4kv/Pz4pVgDNkgXBtFei7fN863FRvXBDDAA92gzZueg
	CnbSW6W71yadFK7Gr8haB7etkXhXDBCL8dB2h8Fgoq5YuhVWK+Q0y5N6cnHTzZrQngkTop5NM6q
	Jqg45P3Bm9X5RQBUKeDZMA7GAfYKeUhdwzW+/ORztNfKTKly1p0Yis9dNXDNOpUR2p0jaY4jrve
	9D5ra9vfeGsL96VOX2C7RLiCcaUxySwg1soRyrLmXgGRmTyhv5AxZTxA1DAJf4FaKmBNS4D7Q/Y
	HkpdIy5FFlGttic6fUP5+CDl+lTOIqIMpXRVrvKmN6h28mqd7jum7HOecDjYY0U5/bFCqC5tEbr
	siOBehP049Ap5z2wH51AdGTQfTQvrKO3d6fA4cfaP+zGdumLRYLsCezxhBsSwzhXGo/PcaINt5e
	nu52Ht9VbD8IguFH5rTi9RRBsIoVSNzo/xOCXKg9pccFL87r7U+ktlZg==
X-Received: by 2002:a17:90b:3143:b0:35b:9777:8bb1 with SMTP id 98e67ed59e1d1-35de68ec770mr8284643a91.19.1775393620585;
        Sun, 05 Apr 2026 05:53:40 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:53:40 -0700 (PDT)
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
Subject: [PATCH 03/49] mm/sparse: fix vmemmap page accounting for HVOed DAX
Date: Sun,  5 Apr 2026 20:51:54 +0800
Message-Id: <20260405125240.2558577-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

When HVO is enabled for DAX, the vmemmap page accounting is wrong since
it only accounts for non-HVO case.

Fix the accounting by introducing section_vmemmap_pages() that returns
the exact number of vmemmap pages needed for the given pfn range.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 7aa9a97498eb..0ef96b1afbcc 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -724,6 +724,27 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 	return rc;
 }
 
+static int __meminit section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+					   struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+{
+	unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
+	unsigned long pages_per_compound = 1L << order;
+
+	VM_BUG_ON(!IS_ALIGNED(pfn | nr_pages, min(pages_per_compound, PAGES_PER_SECTION)));
+	VM_BUG_ON(pfn_to_section_nr(pfn) != pfn_to_section_nr(pfn + nr_pages - 1));
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
 /*
  * To deactivate a memory region, there are 3 cases to handle:
  *
@@ -775,11 +796,12 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * section_activate() and pfn_valid() .
 	 */
 	if (!section_is_early) {
-		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+		memmap_pages_add(-section_vmemmap_pages(pfn, nr_pages, altmap,
+							pgmap));
 		depopulate_section_memmap(pfn, nr_pages, altmap);
 	} else if (memmap) {
-		memmap_boot_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page),
-							  PAGE_SIZE)));
+		memmap_pages_add(-section_vmemmap_pages(pfn, nr_pages, altmap,
+							pgmap));
 		free_map_bootmem(memmap);
 	}
 
@@ -822,7 +844,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		return pfn_to_page(pfn);
 
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+	memmap_pages_add(section_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap, pgmap);
 		return ERR_PTR(-ENOMEM);
-- 
2.20.1


