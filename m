Return-Path: <linuxppc-dev+bounces-22543-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF68ACD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:01:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5QR41pZz3c7M;
	Fri, 12 Jun 2026 14:00:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236831;
	cv=none; b=gYVJuoaRLSTMhl5LaXy0rk40PpqbOHivB9TyhjC9MFBSYp1i5T45j9alevZBjopmXopW6r0gmdsukZ7OAaSV2wQUBBwo2oY0KOKCqAJoRqtfDIr8An6TP8vuhFtZNbBhu4X5lR+Nknddh3RgtYEqN2ltH/aslJgo2HvuU3g/HKe0J/7K4PvMaTWyx/MxhyBzqV2+DmmYUWNmkxM4MSRYlgxBCvf/JJBC6ylZeBIm2BTWmiadqSBtGBH/wUbxTMsy1F5VX3jMUUhuuA8VgsLxq2cCWcVknJKc9wzTG/ONCHpSXJlfnqWMrN+PEvnvUtfbgoXBsvzImvwumESMlFG3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236831; c=relaxed/relaxed;
	bh=z7F0jyR+NYrp4SN+/Gr3YYzk571idnjCyjkNavYszN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoGKkMPzsmp2gu8oHpIQfMlb6Aou/NdQCa1LxCajn6NrWxndzfnkHiCyLMMxLyrYEL54JFfc5YYCi+lFbmCzxTmcyzcg2x/MGoCb4Swmf61zflTPtAEEr5RuRnc0Zp7T8nrfmqTPYO36RfxdbUoiSMrRR0oltnWRmFDVfVOK/0JyvWH7X15Lo3mgyOUDC7yOWWzK/ltCMQxlaljSu4f2lqJaX1BQt/KT92tu/eeqiGqwdZKCUK1pHtH47iU/0aDzGi7CulUNq7QyfQ6SApzv9QtKHITl8S+hrVL1pADliV/3RkjgITvxtedLWLX20r7Q6dTuxlrvUe3kq/X4M4etLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hD48GBwp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hD48GBwp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5QQ3hb5z3bsQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 14:00:30 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-8422f395a4aso418687b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236829; x=1781841629; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7F0jyR+NYrp4SN+/Gr3YYzk571idnjCyjkNavYszN4=;
        b=hD48GBwpCzYb3qBSXsYD/sOuBA03hpc/TXqvdUjOPlpUJ+qLLV0lUbPtkLSVE2/bFX
         BCiYYTeCv74yykNVOFSyMvnvp1DwLWy7Iirv5NwWFyhDjP6O2Gk6fmCWUNKelHbrjap/
         gqMylg3e5MNv0Tu17vx6jvRzIAxf6ULSvxD/cSG3Rrmc37XgYl867s3IMgUFTAtxDj3U
         1wQiYGWitN37Y/7XSiKr99KaC7hLX73J6rZJ+8umjrhse7iNf0c2S09sLsZHQDNrLxtD
         dfsww4ZxUv5CwPCucvAygbzPzgMv3Q80SL2xnn5+PGCuZf/O2ucWZQZLIrwoPnLNEglv
         LgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236829; x=1781841629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7F0jyR+NYrp4SN+/Gr3YYzk571idnjCyjkNavYszN4=;
        b=nYOQfeGju5gbAhMzQbl8UvrXyFG7+9h3VQ4im0BjeDN0VruP9eZFVCC4lomJVwVPcL
         RyrDdqcDUdAiHaf70NPT4om3qEdaTTYm7TMRpkIQL6yJmlRZSpmmXB8cgdk6KGA9ctYB
         +VFZrMva6HZoek+InI3eDhJRJA/cctmRtz2o1kHotl8u2hY5b0QnLHjTGJ+iFZDgqGIX
         H16UAU47cOtF+Y1PIdRZb26L6CdZ26nbA9MuOMuk4ILvD5SjIVSQzo2/UBsK2aKQnrg+
         vaTS45QHXNMVqfWilTnlBLet/fByke8ECR6QNbGoziGHSrh2b9QOyCyGbMHPlNN4yfgF
         tQeQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gweUI4Ov8Fow494Hn42dvX0w4xR07/y0ODohmso/OP6ZBcWWqD33yD8QcXu6eP06Kw72CE5pw98YQAUM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyHyXZ5juea5qnm6SzTcW2IvFGU6EhaLA+jvp8AYzCpOrnq3sL3
	qjI/milmo5H86QcwMk/9qUriG3dM1dfZtcCpl3Y69XLosX9nCI0MNvNpqKEy9VjcjUs=
X-Gm-Gg: Acq92OE0jmxH9URm04ZyfQ64FzBdY/ME5a7Tr3rDCp4aXSrTKb+TozU3BWbwDrwc5PR
	VM40eoBVm6Qi0W8ZLxtGX+XHeIUOjxNBs1vDyAgPhaHPTA8+D7vGskVMhLeDEFZTDUGgeW1FFqt
	tbevJh1332f1oRNfREuFhWgsuGidTk/bmNqXgjZX7stqsl56RzCfWs5AISe/EiI3GsuVUmg6oM2
	TVpr201xJIgqFDoygxI6TYhXYVjEp7xbu4SbDDAk2Fb7Mf05NHyFKZ/ReWtd33aM7NrLIvrMeMx
	oLAEuOt+Myojxvs7vpb814TcaRBkU69fqINfwJ4Q1EGNZOcN1r/ZTMuEhIXbvCcn29QVKVM7WTo
	TSkX+bk4ANmfwapUg2IwNFFwKqA6o0HfrqQqrr5aTi2YXUv9Ch/+cFUFx32Qn+2OycdAD97VDLQ
	7CO0m6RSToFvHwquoEGCAHuMWpRkYGTBudhfZNBddDFSUvtOrr0dv6Gw==
X-Received: by 2002:aa7:888f:0:b0:842:47f7:5f1 with SMTP id d2e1a72fcca58-8434978f969mr1354803b3a.28.1781236827034;
        Thu, 11 Jun 2026 21:00:27 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.21.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:00:26 -0700 (PDT)
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
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v4 15/19] mm/hugetlb_vmemmap: Move bootmem HVO setup to early init
Date: Fri, 12 Jun 2026 11:58:59 +0800
Message-ID: <20260612035903.2468601-16-songmuchun@bytedance.com>
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Usama Arif <usama.arif@linux.dev>

---
v3->v4:
- Move pfn_to_zone() before hugetlb_vmemmap_init_early() instead of
  adding a forward declaration (suggested by Mike Rapoport)
- Collect Acked-by from Mike Rapoport and Usama Arif
---
 mm/hugetlb_vmemmap.c | 93 ++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 68 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ea6af85bfec1..ee4fbd5fed0d 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -745,6 +745,20 @@ static bool vmemmap_should_optimize_bootmem_page(struct huge_bootmem_page *m)
 	return true;
 }
 
+static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
+{
+	struct zone *zone;
+	enum zone_type zone_type;
+
+	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
+		zone = &NODE_DATA(nid)->node_zones[zone_type];
+		if (zone_spans_pfn(zone, pfn))
+			return zone;
+	}
+
+	return NULL;
+}
+
 /*
  * Initialize memmap section for a gigantic page, HVO-style.
  */
@@ -752,6 +766,7 @@ void __init hugetlb_vmemmap_init_early(int nid)
 {
 	unsigned long psize, paddr, section_size;
 	unsigned long ns, i, pnum, pfn, nr_pages;
+	unsigned long start, end;
 	struct huge_bootmem_page *m = NULL;
 	void *map;
 
@@ -761,6 +776,8 @@ void __init hugetlb_vmemmap_init_early(int nid)
 	section_size = (1UL << PA_SECTION_SHIFT);
 
 	list_for_each_entry(m, &huge_boot_pages[nid], list) {
+		struct zone *zone;
+
 		if (!vmemmap_should_optimize_bootmem_page(m))
 			continue;
 
@@ -769,6 +786,14 @@ void __init hugetlb_vmemmap_init_early(int nid)
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
@@ -784,76 +809,8 @@ void __init hugetlb_vmemmap_init_early(int nid)
 	}
 }
 
-static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
-{
-	struct zone *zone;
-	enum zone_type zone_type;
-
-	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
-		zone = &NODE_DATA(nid)->node_zones[zone_type];
-		if (zone_spans_pfn(zone, pfn))
-			return zone;
-	}
-
-	return NULL;
-}
-
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


