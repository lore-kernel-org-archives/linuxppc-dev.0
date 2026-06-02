Return-Path: <linuxppc-dev+bounces-21890-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505FCCD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:12:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV6825l2Wz3brC;
	Tue, 02 Jun 2026 20:12:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395138;
	cv=none; b=CoxICJRLnOrvmTPlM25kiM+GK3WDPn5S7yW/hlsqyaIf4s11YsmH5O+R80xATxz55Pb40t+mBdEbMRlXbdHn+O4Z/MCVnsKfQPzWpkED3OcFLowVOW7hBTIHZjWTpYEzxsgsRtnT9m9W+gJZaNBrUv4j4BO/BI0zDNOuS45Nuy6Y0etC0evj6ubYJ7MF77NhQqAM8/nTD42065TnLheTE/W6MR09vbdwrVijib2git9eXtVOlsF3uT3oRCAR8t14K75yp0PnReItz5NbefloEcnlQSnu5uD70KxojkfjZshg45axfiirc8ljYxSwreVu/mQnyDzZvFIKoQbGWXmn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395138; c=relaxed/relaxed;
	bh=oJaZoYtZ6J61gHq76uPvOqmXDVgTt0Xo6SthcejktT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNWqQoAcTcu/vFaKMJkfHN62dGxkXciuAuGVtXpuDtMmeg1aHH55ZdmZMl5FO2kS+zuNFmIrnYs/LxA2e0TFBvOcnQAocUAxcVW6Z6RnUwSQn6zH2qpYs421L61nj21R5GzxyOhiE6oqRJzwFL5kKOMdQ6jedquy3vf1UInXFVT0Y8lykWAFVkEKfzKp3/ZtRNjbengAIsx2HTF9ezJxzdjok0NL6YdApgVl+U9wrTy6F5u1ESQoemXkDGNPLsAG74Q+j3s5JSNSOQJaarkv/SwEE/IjE5QZVX9EoEGXs9xfaDgFuqGbRqYUYysPdsagUejaTBkjJfF6NAZHXTicjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XAxcDm07; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XAxcDm07;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV68211KBz3br5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:12:18 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8423f236418so1016868b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395136; x=1780999936; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJaZoYtZ6J61gHq76uPvOqmXDVgTt0Xo6SthcejktT8=;
        b=XAxcDm07fhnfjgqibmmB694rEbJbqlJid0Ci51CKVk70uBgJqJLkCZMnltTM50hFpX
         v62TgWt6fwWqFYi9CMnB0tLfwV8zMYE98bluzBDmyS7VpTTBg/iM0ERCwfHvGk44O2Af
         St9NQo2dF1aW3zf+1HvL/nVcFc8/KQPpuYrJJehxkHTJLmZhOUPFcbUeHCqdCNAiPWuF
         v3knYG1Mdo1KQegIHUCDRIWTBkbMYXKK1etnE7KSG6Uz4Z50o1Cp7YL55RE7paysXSII
         2dej/A96pyG25Oq9/nTGPJJwxA1jpy34kwZTtgceb+RNMdy75HgyDiO4kLaSBUZNYLN6
         831A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395136; x=1780999936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oJaZoYtZ6J61gHq76uPvOqmXDVgTt0Xo6SthcejktT8=;
        b=PcW9Aiz5lJNn3R9ofzNRjkmPAG+Aio8RLA8hc2fBbcY8gSaDy9v8nCH99A4e5b0Vye
         km7rusX4RBQFXzcGBcA+mtw3+2XQo2OJQHG4jXx6aVCXWgUxsFVgk5C7QHg86eubz/hE
         oxssQeNNEWRG6rrCNLEV4red8UwX0n218sn0B7HIH9uko5rQ57Cx2xEssc9FoIng65XQ
         iHj0adwaW2gOZjAfUkXMY3V/E41HX0gG+m7USZdsTD2EF/ztaIqYj4Aih+70Q3WlhoVR
         ITHkU5cw7vlYHY71QMGBo8K7Ri/CXj3JY7OF386o5dzWXIaLfmPgm13QJlj0joAuLzLZ
         eyTA==
X-Forwarded-Encrypted: i=1; AFNElJ+cl0W1P6yQss4h6EbToj4+EtoeHer/nAW0sWXO9CL6uTEawZn4dsiL7tqd4RasrEU8IPqx3wnBLJfa4yU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxxc8WTvdp2dWDS20hJHEggEuIq854tKA8o00j2vSfw8V3Q13GC
	K5+7bQSTzapslsikE5L+M0tZrd/l0Kz2G179wldOmAakN4bPmezEFdIlbRhJ1zbBDGRJv5hmh0L
	mEgUXb5A=
X-Gm-Gg: Acq92OH0IgRz2bXh65sU92U6G1QTRlH+DZSGZsHQt7XPXxMXc3nFxDfwazSagcYQn/q
	9S56oHoCTE0TuWHyyu0ZXI2rUIUyUKTUVUyqVutO7W0BGgJaACEppOwCHneDlrq2XWndjQeDkpM
	YJdoHOavlMOxIkhPyOg1mw/bA6JeUVrzrROyJO9TWd8R8eMKhWXlzikL/A3zumfJQ14n4o+26I1
	WzQ4a1Ff1tPo6PzBb9t+oru/M4PmAog1kb893IZYWKZtxDnDjeDfRMkw0tjW7P84SKSXyXoy7H8
	q2vD62ZxJoMD/+gWsYmN8oQJnUFvYR6UqXYSiEqbx3ZvMxjQZO5qcMQeJhuq2Ic0jeKfrESL8iR
	VVgqeQeRMh/AFmsYP/165Bjd76VlSGrPihtpF1OCoG5aL6QFduHlEQOK25HgXpQbAKbCe7reLIR
	SaMrCcnyR+nD0WplM6wSbaGlUsZ9nHtAbzrt9nWt1MEOrTmWJnW0RrxYY=
X-Received: by 2002:a05:6a00:b806:b0:842:655d:1232 with SMTP id d2e1a72fcca58-842655d14a9mr4627780b3a.0.1780395136206;
        Tue, 02 Jun 2026 03:12:16 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:12:15 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 15/19] mm/hugetlb_vmemmap: Move bootmem HVO setup to early init
Date: Tue,  2 Jun 2026 18:10:35 +0800
Message-ID: <20260602101039.1867613-16-songmuchun@bytedance.com>
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

Bootmem HugeTLB pages currently defer HVO setup to
hugetlb_vmemmap_init_late(), because the optimization needs zone
information.

Now that zone initialization is available earlier, the bootmem HVO setup
can be done directly from hugetlb_vmemmap_init_early(). This lets
gigantic HugeTLB pages apply HVO as soon as they are allocated.

Bootmem gigantic pages that span multiple zones are now filtered out
when they are allocated, so the remaining bootmem gigantic pages seen by
later hugetlb initialization are already zone-valid. As a result,
hugetlb_vmemmap_init_late() no longer needs to handle bootmem HVO setup.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 67 +++++++++-----------------------------------
 1 file changed, 13 insertions(+), 54 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ea6af85bfec1..464578ee246e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -745,6 +745,8 @@ static bool vmemmap_should_optimize_bootmem_page(struct huge_bootmem_page *m)
 	return true;
 }
 
+static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn);
+
 /*
  * Initialize memmap section for a gigantic page, HVO-style.
  */
@@ -752,6 +754,7 @@ void __init hugetlb_vmemmap_init_early(int nid)
 {
 	unsigned long psize, paddr, section_size;
 	unsigned long ns, i, pnum, pfn, nr_pages;
+	unsigned long start, end;
 	struct huge_bootmem_page *m = NULL;
 	void *map;
 
@@ -761,6 +764,8 @@ void __init hugetlb_vmemmap_init_early(int nid)
 	section_size = (1UL << PA_SECTION_SHIFT);
 
 	list_for_each_entry(m, &huge_boot_pages[nid], list) {
+		struct zone *zone;
+
 		if (!vmemmap_should_optimize_bootmem_page(m))
 			continue;
 
@@ -769,6 +774,14 @@ void __init hugetlb_vmemmap_init_early(int nid)
 		paddr = virt_to_phys(m);
 		pfn = PHYS_PFN(paddr);
 		map = pfn_to_page(pfn);
+		start = (unsigned long)map;
+		end = start + hugetlb_vmemmap_size(m->hstate);
+		zone = pfn_to_zone(nid, pfn);
+
+		if (vmemmap_populate_hvo(start, end, huge_page_order(m->hstate),
+					 zone, HUGETLB_VMEMMAP_RESERVE_SIZE))
+			panic("Failed to allocate memmap for HugeTLB page\n");
+		memmap_boot_pages_add(DIV_ROUND_UP(HUGETLB_VMEMMAP_RESERVE_SIZE, PAGE_SIZE));
 
 		pnum = pfn_to_section_nr(pfn);
 		ns = psize / section_size;
@@ -800,60 +813,6 @@ static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
 
 void __init hugetlb_vmemmap_init_late(int nid)
 {
-	struct huge_bootmem_page *m, *tm;
-	unsigned long phys, nr_pages, start, end;
-	unsigned long pfn, nr_mmap;
-	struct zone *zone = NULL;
-	struct hstate *h;
-	void *map;
-
-	if (!READ_ONCE(vmemmap_optimize_enabled))
-		return;
-
-	list_for_each_entry_safe(m, tm, &huge_boot_pages[nid], list) {
-		if (!(m->flags & HUGE_BOOTMEM_HVO))
-			continue;
-
-		phys = virt_to_phys(m);
-		h = m->hstate;
-		pfn = PHYS_PFN(phys);
-		nr_pages = pages_per_huge_page(h);
-		map = pfn_to_page(pfn);
-		start = (unsigned long)map;
-		end = start + nr_pages * sizeof(struct page);
-
-		if (!hugetlb_bootmem_page_zones_valid(nid, m)) {
-			/*
-			 * Oops, the hugetlb page spans multiple zones.
-			 * Remove it from the list, and populate it normally.
-			 */
-			list_del(&m->list);
-
-			vmemmap_populate(start, end, nid, NULL);
-			nr_mmap = end - start;
-			memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
-
-			memblock_phys_free(phys, huge_page_size(h));
-			continue;
-		}
-
-		if (!zone || !zone_spans_pfn(zone, pfn))
-			zone = pfn_to_zone(nid, pfn);
-		if (WARN_ON_ONCE(!zone))
-			continue;
-
-		if (vmemmap_populate_hvo(start, end, huge_page_order(h), zone,
-					 HUGETLB_VMEMMAP_RESERVE_SIZE) < 0) {
-			/* Fallback if HVO population fails */
-			vmemmap_populate(start, end, nid, NULL);
-			nr_mmap = end - start;
-		} else {
-			m->flags |= HUGE_BOOTMEM_ZONES_VALID;
-			nr_mmap = HUGETLB_VMEMMAP_RESERVE_SIZE;
-		}
-
-		memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
-	}
 }
 #endif
 
-- 
2.54.0


