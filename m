Return-Path: <linuxppc-dev+bounces-21891-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0EDCD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:12:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV6880l88z3brL;
	Tue, 02 Jun 2026 20:12:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395144;
	cv=none; b=Pc94X3LfbI0ErlrtaobchQNUrl9wUBDgThg+uzETqJzCvn0g0Bl/M8VOXMbgo0IQmtidXqXUUPweLreie0Da4rNXfACAAj8gQJ3AavzklRK8kXqLxUCMCpikldl71RZ7SWw849EPLwnt6Vygcegf71EzYUGGG394ooHiq7oejjaH9RJj+aaxKL8T8KLcTkMar4j3dn421Gqq/N/jcQcZ5nDcYT2VXHbO5ifmDGST6ArCU+lfrtkv+XedXOkUL9pjMPCkPssIJGcu/g8wfMambBNecjFc5rQ3XTNyh654zuxWQ5RLStRPLXLoddKkH4wEJjjvNkCy701NG1q5gD/hWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395144; c=relaxed/relaxed;
	bh=aqtFBpfBq6FrNHW9ccKxFbBIkIWdyfnMbN3qSInC4vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnNGUXHAzZsgMxUzsbd4TiT7+5dN6PBVQ0rlO2EkiW08XZG/PD93da/yz80SwY7BCqxi3FkkiK3DHl38hh778ZCXzwM7cfappRgnoa5l6S+RBWRVBFLaqaM6MskP0HD5okrlqC8di5a9DMPBWoshOo7+n9ksIrn9cmn1bM/zEsotls761G99fqdxAHII8dzV3Jdu46U8jFmDKavt5eXwwLqfIpz6zxw6q6tn+LTCpn5C9Ah77P8w1SIOfh6BF/8obalZfxNAxzhV53Cy3OePUrCnw9T+ccL+t6P/BRYCwp+1sROHnQJCl1NaolWXzxSF7Db/WLa7Lgk9Vj3JK8yhKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Xyg/1vJp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Xyg/1vJp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV6873Hrnz3brH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:12:23 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-84237c55ef9so1009683b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395141; x=1780999941; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqtFBpfBq6FrNHW9ccKxFbBIkIWdyfnMbN3qSInC4vE=;
        b=Xyg/1vJpOvpoxwZJRtPibUT7qa1P1hKeWrqNdBuD1a/3OG4hCUUA66NwQCw4nC6uiG
         ecxDy055FZ1BjooQYEYEDyZHwqMQggR9BocNlgN4gkStjgz3XOUUB/VZqsFhE9hABMsm
         iWzd6yu2cv3iHX7XBl4q3l4mC4JBGKVYDJIid4ld4q3eb8KhAeqNNfPLlyCGYatPtvxz
         7+3/cl2WVK2IwAFSaHzkcGDvkiA8/YVdPva2703WMRBzihmfCaKKYoc4vLkVSXc4UO6h
         lZz2RsUehQd8XUFiEPj3CinMk637gR24bOt5e11rqoPBBiMXDpDEjgG36S2zAfi43FHw
         74kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395141; x=1780999941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aqtFBpfBq6FrNHW9ccKxFbBIkIWdyfnMbN3qSInC4vE=;
        b=o51JLvljfcLB2tlELHGH+lEoe6jxNMIRlnI/NT5zPGzc8VPH2AflJMXukTMSChEKxr
         BTHBq5xxNHcLd3P4pg69BsMEKXzVbJ3UVVyRwvNdXZ4Xy41TMOWOkk7YtFJKL36QSB5b
         +c8QwSmyFk+DAPVOGRlUQN76cRnsOM/9MLiu7knhGencRbv/zUP3Q290O0LpiYLQnnAA
         r78BOx+FK0KS/Cs2pYGqteXDUG2Q6koiZdZhZCnvzWJ+QqWFCKZ7JDnafyCyShG8wXRN
         DOD4D1riGEVzbsxQo3jqJJ6kAXxTJBVD8p2A0EVa8E6paYFwqLZYN8bRN3LkU1Ef2dHb
         yDDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0W7YnBQD1xFDFSM46rsqDbB0DXbYzXlYtlf2rM4DbYQQOKvH2dXUmxL4MtILGAHX9nd4bqQi5byQrDzU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz/w2OX2HG8jciQ5SV+Qct1cgw7jyOGIshQ38OR+3yYNciUkHEw
	OGLltjIplHvrF5HhsgnXPYnMjr1wMKk03Jh4oAeBuoKGY+2fh9/CGPTmCHxMVi9y4Zg=
X-Gm-Gg: Acq92OEnkWFi010dAAgy7cqfC+W6srHjkQqSbloOW7FZVzZPQVvge32tNiQonvzO8vS
	NK66db4TRQ/yFQeyyaN4/3to6EK6ZqFr+hA7ZPaxhfdUFRkseIRuB02s0WF+DI049y+k4oqTCXg
	yLqzQ+KaPdTer29F4QYuCfEL7nmoo2/HDz22HsEP5gUNz6T2cfow4SEEpYp+szffF2+qAQn2Pkk
	cz2JBgIP8yEt8g36JNSQyFIA4vL6PiqK++8Em57MVPsZqdQNQUIMw/R2aNhW07JOFh7bNAC6oNZ
	QdDu9RZx5enOAr2HcOoYDsEZIDnnApZgCKII9goz0EoWTj6U5nufsg0EXO5iwfBc/HicnxntGJq
	xRxm48wHfVMbnYY+cw4ADJ1BZ/JGu5tActVBHtB7s3U5xsV848HX9822Bok9f6EC8PHJ8neVRp5
	pBg/KnWsrmh+kY8FOzDE0zUf1QLR3UKp27ywdzFTtDLqj4tK2pGYRXOa0=
X-Received: by 2002:a05:6a00:92a9:b0:842:6f13:1461 with SMTP id d2e1a72fcca58-8426f131bffmr2620970b3a.11.1780395141260;
        Tue, 02 Jun 2026 03:12:21 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:12:20 -0700 (PDT)
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
Subject: [PATCH v3 16/19] mm/hugetlb: Remove obsolete bootmem cross-zone checks
Date: Tue,  2 Jun 2026 18:10:36 +0800
Message-ID: <20260602101039.1867613-17-songmuchun@bytedance.com>
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

Bootmem gigantic HugeTLB pages used to be validated again during
gather_bootmem_prealloc_node() and any cross-zone pages were discarded
there.

That validation is no longer needed. Cross-zone bootmem gigantic pages
are now detected during allocation and freed before they reach the later
bootmem gathering path, so the remaining pages are already zone-valid.

Remove the obsolete cross-zone validation, invalid-page freeing, and the
associated discarded-page accounting.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  3 --
 mm/hugetlb.c            | 70 -----------------------------------------
 2 files changed, 73 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 09f28dd773b7..f68a390d43bd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -678,9 +678,6 @@ struct hstate {
 #define HUGE_BOOTMEM_ZONES_VALID	0x0002
 #define HUGE_BOOTMEM_CMA		0x0004
 
-struct huge_bootmem_page;
-bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
-
 int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 void wait_for_freed_hugetlb_folios(void);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 218fb1ca45f4..47c3d6d11c58 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -58,7 +58,6 @@ struct hstate hstates[HUGE_MAX_HSTATE];
 
 __initdata nodemask_t hugetlb_bootmem_nodes;
 __initdata struct list_head huge_boot_pages[MAX_NUMNODES];
-static unsigned long hstate_boot_nrinvalid[HUGE_MAX_HSTATE] __initdata;
 
 /*
  * Due to ordering constraints across the init code for various
@@ -3221,57 +3220,6 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 	}
 }
 
-bool __init hugetlb_bootmem_page_zones_valid(int nid,
-					     struct huge_bootmem_page *m)
-{
-	unsigned long start_pfn;
-	bool valid;
-
-	if (m->flags & HUGE_BOOTMEM_ZONES_VALID) {
-		/*
-		 * Already validated, skip check.
-		 */
-		return true;
-	}
-
-	if (hugetlb_bootmem_page_earlycma(m)) {
-		valid = cma_validate_zones(m->cma);
-		goto out;
-	}
-
-	start_pfn = virt_to_phys(m) >> PAGE_SHIFT;
-
-	valid = !pfn_range_intersects_zones(nid, start_pfn,
-			pages_per_huge_page(m->hstate));
-out:
-	if (!valid)
-		hstate_boot_nrinvalid[hstate_index(m->hstate)]++;
-
-	return valid;
-}
-
-/*
- * Free a bootmem page that was found to be invalid (intersecting with
- * multiple zones).
- *
- * Since it intersects with multiple zones, we can't just do a free
- * operation on all pages at once, but instead have to walk all
- * pages, freeing them one by one.
- */
-static void __init hugetlb_bootmem_free_invalid_page(int nid, struct page *page,
-					     struct hstate *h)
-{
-	unsigned long npages = pages_per_huge_page(h);
-	unsigned long pfn;
-
-	while (npages--) {
-		pfn = page_to_pfn(page);
-		__init_page_from_nid(pfn, nid);
-		free_reserved_page(page);
-		page++;
-	}
-}
-
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
@@ -3287,17 +3235,6 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 		struct folio *folio = (void *)page;
 
 		h = m->hstate;
-		if (!hugetlb_bootmem_page_zones_valid(nid, m)) {
-			/*
-			 * Can't use this page. Initialize the
-			 * page structures if that hasn't already
-			 * been done, and give them to the page
-			 * allocator.
-			 */
-			hugetlb_bootmem_free_invalid_page(nid, page, h);
-			continue;
-		}
-
 		/*
 		 * It is possible to have multiple huge page sizes (hstates)
 		 * in this list.  If so, process each size separately.
@@ -3692,20 +3629,13 @@ static void __init hugetlb_init_hstates(void)
 static void __init report_hugepages(void)
 {
 	struct hstate *h;
-	unsigned long nrinvalid;
 
 	for_each_hstate(h) {
 		char buf[32];
 
-		nrinvalid = hstate_boot_nrinvalid[hstate_index(h)];
-		h->max_huge_pages -= nrinvalid;
-
 		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
 		pr_info("HugeTLB: registered %s page size, pre-allocated %ld pages\n",
 			buf, h->nr_huge_pages);
-		if (nrinvalid)
-			pr_info("HugeTLB: %s page size: %lu invalid page%s discarded\n",
-					buf, nrinvalid, str_plural(nrinvalid));
 		pr_info("HugeTLB: %d KiB vmemmap can be freed for a %s page\n",
 			hugetlb_vmemmap_optimizable_size(h) / SZ_1K, buf);
 	}
-- 
2.54.0


