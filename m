Return-Path: <linuxppc-dev+bounces-20865-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C7DCD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:09:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv1C57Btz2yQL;
	Wed, 13 May 2026 23:09:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677743;
	cv=none; b=YC1pIKgqF554J5qNiQjENIej/mrha1eCGvE2JpdT6mzDSrnwCSAFEUsGjFP0cRkb59Zu0IbuR7v4XECJmOwHnv1tKZn+hW2JG6QRCp0S1h9kKASQ8agVxYHKLKtsgjmo4bF5K8LWnhmFp0tkhrx/sNcbaC8D4v6jJ7JTiU4qGhNiCbV5Q2hqO6vQe8q7WPsKjPKPGw5HI/P7HMSa5b5K2cHRJ7NbRpnaPUyVWmCpHe5cmN0+Vht2B8nK+bbwJ8nPAsNmKnYkfJ4e90YsUxDtJh8ugyNAD2T+NHD0PU4S8+mSMNzXdUB13n5EEs6tn9DqB4hnTEzvD4IfkcQA0PjYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677743; c=relaxed/relaxed;
	bh=J6ElOBv7vrKvKF8FNit7K/7AGAfvZCZIjE1YfuNh7wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJT1ACVjKFzgQ8QBHGCpfF7hPAy+f56OUcsrjf82NpdthG1x0LwKoIdLAuinYD/+HVno1kYlW5ktFBPnpgcJOaZWCjJoHcP1UNpvI9UhueDQ1mYHFUNrPe+74Cofjt3EsK8sj8dJiyn5Y6OAjKBMGj1/ddaMFLQHW6wJ3dz6pLib/u9CF7Wn1llFwq3Y/80TQx+ea12Qv0+1bZr9Zz9SMPDv1V+LM3rsIVzhELBzGc0J44OFtwI0asYF1Fi1YhBIenyX617+Sb6Ukt72fUde6xPP05lOFFS+hN9vL3p7Xt3gbUkrLbktlBeW3Zciudk5FynPO8OiDQHbYMoZ9iHdWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Vm7S0MN6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Vm7S0MN6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv1B6wM6z2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:09:02 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso67451965ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677741; x=1779282541; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6ElOBv7vrKvKF8FNit7K/7AGAfvZCZIjE1YfuNh7wQ=;
        b=Vm7S0MN6Lvs9+Ra2LTqISkVQ849DsQUtHsc4j7DIPPOYcCB/tQIgFosXWzAx3cz003
         CAhBMNk66g5NS2wD1nuP3DyCpfNMDvWo0KLwJ+HNSfwRx3yUXvbge8tFHNSYM+kkCy2S
         oqbByB63TqalBq0gOnv+K7dAcivNkBOw0U92KGLjeHmk3kwkgw+NN83zY9B4ImebX+NJ
         YiG8hhDTgjOD/18JWawpVsOheiM8wq3q43XQod8Zp0ts+mqxvze6djzDQ9jUY4LQglO6
         izGyUSycXQHfjrp++oqYSxo84JOKrJcOucd5NP5kp3BJYYuF+5gI83f7kRCBJyYyhyLc
         d2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677741; x=1779282541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J6ElOBv7vrKvKF8FNit7K/7AGAfvZCZIjE1YfuNh7wQ=;
        b=jzp3t1Asl18ghEXeAWr5WQjdfqMXHkFMTjTaJENANGmtXfL6DSirk3fsxv3SyPAVfo
         lCroAesHPu7jK4BMeGD5cjrii7gPszEn9qhWe3piHnJO++2xNkRPOPvD6oX71STudd0+
         IZ2S9lzsxPEp8j9fVYwB++93TFOFV8dtKE5BdRzolyxXCHnCkz8szIW6O+B2tTVzY+PC
         IcAGViwJkeelokqgXD3CTnl5TMfsQISY0K/2/v0KT0LinMKI3VSHeWg3A5IOtTqPOM/3
         vE5ERuODCmbScYwSMiYcwH9cM68i+DLBGxA1AdZMoG7okdDdMPdazsPmMdTMa0eWyYxm
         PK7g==
X-Forwarded-Encrypted: i=1; AFNElJ+4uDwaGHJM7gJjV5VfTjCGls9ComEiK4yQM78AVKpdA3x6CO9B6M1hTZHipLyElkRc707SiCAWqwuFtlA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7tVuPs2GnYfdiGUOsgJhyrh9ZATaFfvcVGgFKXkECkv+IYsAD
	P7J85ygOzDeafiLmdMCjHZ2asesRpL7vEjYqhjPJj6eovxKuw6BpTE3yP3BMWQjlAkM=
X-Gm-Gg: Acq92OFywsd6VLHnWDyueHe42pwRrACs4uOnaHSIH+drylpc8A0gzYcgoIoBug5Z5//
	h+L+Fv8GJ+HkxvZcxL73qhhz6KR33xIuDMSKZ2zG3krDychZE6w7k4Y+I7sHoQFGWQuWYLoo/zc
	Q3tgR+knSXohdF3FfTKZopXhhYXFvdzM93y6EELGZCJRH3doP2reqyh7KHzIeCGQ2ofd6gudbvU
	g6/jyGszFsDH4rRCH34bv5aHHand2W3c++6B9I9xZsqChOvi11YLnEBnc4hRKFTpjK4dEcU7uSX
	WwTHoRMBVs23FUG2fGWzxRFSDfHZpEzhFPIPEQWumt4l5hn3p//SoRozehmIHm/pHvZvuiho6zV
	MygqsME2+ev0vbEDY0kfLiSiOxhHsnulsbiBmE57lhc/myNMRTDwu48E+17s4kcuFKZ8v5Kg8Qq
	AX7AXflG+aXtL2nPIJbWtUO5sgsah/d7dQKMRpoWNfyDc3Cnfo0CG43rQnV7HQknGBZiYovQ==
X-Received: by 2002:a17:903:46c4:b0:2bd:2de3:51ad with SMTP id d9443c01a7336-2bd3043ca95mr32688825ad.34.1778677740889;
        Wed, 13 May 2026 06:09:00 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.08.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:09:00 -0700 (PDT)
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
Subject: [PATCH v2 16/69] mm/hugetlb: Remove obsolete bootmem cross-zone checks
Date: Wed, 13 May 2026 21:04:44 +0800
Message-ID: <20260513130542.35604-17-songmuchun@bytedance.com>
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
 include/linux/hugetlb.h |  2 --
 mm/hugetlb.c            | 70 -----------------------------------------
 2 files changed, 72 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9a65271d167c..ece4e6a4a4c6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -701,8 +701,6 @@ struct huge_bootmem_page {
 #define HUGE_BOOTMEM_ZONES_VALID	0x0002
 #define HUGE_BOOTMEM_CMA		0x0004
 
-bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
-
 int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 void wait_for_freed_hugetlb_folios(void);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d5d324f69d7a..dcf8e09ec6be 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -58,7 +58,6 @@ struct hstate hstates[HUGE_MAX_HSTATE];
 
 __initdata nodemask_t hugetlb_bootmem_nodes;
 __initdata struct list_head huge_boot_pages[MAX_NUMNODES];
-static unsigned long hstate_boot_nrinvalid[HUGE_MAX_HSTATE] __initdata;
 
 /*
  * Due to ordering constraints across the init code for various
@@ -3238,57 +3237,6 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
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
@@ -3304,17 +3252,6 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
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
@@ -3703,20 +3640,13 @@ static void __init hugetlb_init_hstates(void)
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


