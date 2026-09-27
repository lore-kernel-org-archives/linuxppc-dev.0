Return-Path: <linuxppc-dev+bounces-28301-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4E9C9832A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:56:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspw92Hbdz30Vv;
	Sun, 27 Sep 2026 12:55:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477737;
	cv=none; b=kSfeCoB4lkKO9X6cLEDZ3xxP4T2zDORSSmyz/5xCiRsUmZ3Xd/iOEU1xgyoRhibUORzvpPpt3/+NIYeaxx7t8Gy1OLLJ84lvy0u6R/Zi11AIhkLVgssaY/NfF5Qdu3b8GduLMpC1fLoa0KN3FPDCrjveooaIw99MUnKdou4LGmOmTQ5k89CoJqOo7V2m5MeLjJDLkGm9UoY+TpxFW4+GL2Scf/AU1NeC3c1QuwQr76nMYD/Bv0p1QsVY7yYzzDGnoHtrRylj73rrAkaQ4ymmT8XYx6OspIrrGY3yneLXuL02/Jy/lZNCffExZuFcTRzKY55WMPesk93z+kSUGNbRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477737; c=relaxed/relaxed;
	bh=vDyOFF6NxHUIale2EKP70eICKc/klrg6ENuabN+7zVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeHuz0W9QhrPugwAQELpYtpjFs8E3PHi15VnfQR+tGAaMLqydlsjWaozcmDKXveGqa90K3QTsr13nG6NATDaisks896ZUT2O2M7nRpjNEs6Hq3w0NjyMy3jnDqerLikKiGffrsoXl8uewuzVRIAA/ONgMcfunyZhHpGNkkZdD/ASMcmDs/SszZPbRhb2bk+33hHivBM9VgOonnfO4gOzeVyV+Til9zdOPM5L2y0+FTmITEam9X+wdlFi64joOH2BzRNa2968MG8jVWN3fBbRY//C6exk7e75qkwLuQ8RBb6t1k7hAd0ET+oUVD4yYjcbcg365k4Pb9XiJV3655zZPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZKhX9yOK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZKhX9yOK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspw83GZtz3048
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:55:36 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so1082531a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477735; x=1791082535; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDyOFF6NxHUIale2EKP70eICKc/klrg6ENuabN+7zVI=;
        b=ZKhX9yOKfiQxiTlr9XV2Trecqg+KxsYk4lUg02cykA95hUFOOqEMRhJlVf6BWbUwUf
         rg6poAhtV4E2FdcBzVxjXdXG0HO0gaQRQYX2Na3PyiF5YhmfXn80TLMoPVB4k4K0Oxwv
         o42b+gTg+ydHNq0zASvvi+UopogSVIQcB+c3gFQzQ409cKlpyNqRZ5iU79v+hsfEgMYp
         dzKltoH6qFJj/5CJK4KE+5oPC7SlC8UnMr2yXBJAXlROqKpjysmAmVai/NOUgBBMTdvp
         G0lZBsPCxWYIGfyO4rkkHPopEwlFWC/GoTA0LPYWIYY4rWZpdUPOIQ+TBJp6bzjbGq2Y
         MmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477735; x=1791082535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDyOFF6NxHUIale2EKP70eICKc/klrg6ENuabN+7zVI=;
        b=LjsBPOpz+Unfz3EjNmEWopCAzlMWxDKxPbtYSn/0ZNNJcI/ssW0CdRlE2NwhIHNkOL
         tklZ8wVdgd33wgSUlDNyCgAZVIdFC97oy4da5UT02wIQrdKzMsyBcfmCXdnTcvvskkLn
         6TS4bp9vAEkEhHM9/XkKS3czh+2BkVNHil8/tY75i3AgvEhm+s46lFoTMF/KQnSAet0f
         83YK3G8ZkmfqDkIbz/HrysE31U72Hv5lUMt0FY2uo5gDkc+uXK5Ahw5NFuGUJDispYP/
         8ZtrwnZKpBLuMcA7jcZ88QHX6LO/FxdCihntEen0jmiHdj5x97Cs+00LJdKFGa5sZR5I
         3m/Q==
X-Forwarded-Encrypted: i=1; AKwUvByTuaH5ScnPjKpWzwWVuqMigVqqsC2C2UeLgdCnRusalk6pEc008uK/BPk6+xVUemENDK3+iulckilJE/0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLF5jqWm60CsTx6odc026yYwDGEtOe4oUomwjnhS+WPoQhFP2no
	axXekG0m4NTolu6ijOOwS3YfNHLC4ULnLkMESorthH/9A1tSPFStCpksUq4DBeRuRKY=
X-Gm-Gg: AYBFou0nCwZuJ6wbFrqOx5CJsTrwu/peFiGSHnmd3r1OsIwUobnPFYxX/tPEkmsA7Ek
	F4BPqjAmzwfV8trH4lXXxYQjnUdvHgtekMprWz1IXufNJqfzglKoCsDt/M+bcmloOqNluh25LMH
	fC5XOnMgX1b1/0Pu9P71mbmL8VFtinmJlbr9Janh6PnITbRpn6aSQLcFbQH5HJGOs9MFLAD1YBA
	HaxnxlkfmQFmd/o8C1ADCPtrdjAcD3OSHxD1Dj2RorJl4g0NRDkJytI1nt9TDFC5jFy+cTB6AhD
	WTQ0Mb9IzzEl3qLg/fAVTwXak9aRF4TtFOQqdQzMCoHtU9YoUSwCQJ5inxkXAt7n5qicK/oJ7uO
	WyYFfLG0LihmEZp6O6/zP47Q0Q3xxQRB8xz/dwQL4g8ZJtrfcqDp0yN1qmws7KF2xTD3bIbN+no
	Dn/ZgKCsuovR7LWtSmquAkL/GCw+z2qk6PyMBCUBhqpAsM6OlIQ+9JtGSyi3dfbQy5lQ3x+pKGt
	1WybUJPSNssc12W208u
X-Received: by 2002:a17:90b:51cb:b0:3a0:516d:9f87 with SMTP id 98e67ed59e1d1-3a0985710a5mr8073880a91.13.1790477734640;
        Sat, 26 Sep 2026 19:55:34 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:55:34 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v5 09/12] powerpc/mm: switch device DAX to shared tail vmemmap pages
Date: Sun, 27 Sep 2026 10:54:38 +0800
Message-ID: <20260927025441.741633-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927025441.741633-1-songmuchun@bytedance.com>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
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

The powerpc radix compound vmemmap population path still finds a reusable
tail page by walking the vmemmap page tables.

Switch it to the common vmemmap_shared_tail_page() helper instead, so it
can use the shared vmemmap page directly to simplify the code.

This removes the powerpc-specific tail-page lookup and its fallback path
and aligns the device DAX vmemmap optimization path with HugeTLB.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 80 +++---------------------
 include/linux/vmemmap-optimization.h     |  6 ++
 mm/sparse-vmemmap.c                      |  6 --
 3 files changed, 15 insertions(+), 77 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index cf692b2b5f7b..ee068f24a79f 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -19,6 +19,7 @@
 #include <linux/string_helpers.h>
 #include <linux/memory.h>
 #include <linux/kfence.h>
+#include <linux/vmemmap-optimization.h>
 
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
@@ -1250,59 +1251,6 @@ static pte_t * __meminit radix__vmemmap_populate_address(unsigned long addr, int
 	return pte;
 }
 
-static pte_t * __meminit vmemmap_compound_tail_page(unsigned long addr,
-						    unsigned long pfn_offset, int node)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	unsigned long map_addr;
-
-	/* the second vmemmap page which we use for duplication */
-	map_addr = addr - pfn_offset * sizeof(struct page) + PAGE_SIZE;
-	pgd = pgd_offset_k(map_addr);
-	p4d = p4d_offset(pgd, map_addr);
-	pud = vmemmap_pud_alloc(p4d, node, map_addr);
-	if (!pud)
-		return NULL;
-	pmd = vmemmap_pmd_alloc(pud, node, map_addr);
-	if (!pmd)
-		return NULL;
-	if (pmd_leaf(*pmd))
-		/*
-		 * The second page is mapped as a hugepage due to a nearby request.
-		 * Force our mapping to page size without deduplication
-		 */
-		return NULL;
-	pte = vmemmap_pte_alloc(pmd, node, map_addr);
-	if (!pte)
-		return NULL;
-	/*
-	 * Check if there exist a mapping to the left
-	 */
-	if (pte_none(*pte)) {
-		/*
-		 * Populate the head page vmemmap page.
-		 * It can fall in different pmd, hence
-		 * vmemmap_populate_address()
-		 */
-		pte = radix__vmemmap_populate_address(map_addr - PAGE_SIZE, node, NULL, NULL);
-		if (!pte)
-			return NULL;
-		/*
-		 * Populate the tail pages vmemmap page
-		 */
-		pte = radix__vmemmap_pte_populate(pmd, map_addr, node, NULL, NULL);
-		if (!pte)
-			return NULL;
-		vmemmap_verify(pte, node, map_addr, map_addr + PAGE_SIZE);
-		return pte;
-	}
-	return pte;
-}
-
 int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					      unsigned long start,
 					      unsigned long end, int node,
@@ -1320,6 +1268,12 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	struct page *tail_page;
+	unsigned int order = pfn_to_section_compound_order(start_pfn);
+
+	tail_page = vmemmap_shared_tail_page(order, device_zone(node));
+	if (!tail_page)
+		return -ENOMEM;
 
 	for (addr = start; addr < end; addr = next) {
 
@@ -1349,10 +1303,9 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			next = addr + PAGE_SIZE;
 			continue;
 		} else {
-			unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
+			unsigned long nr_pages = 1UL << order;
 			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
 			unsigned long pfn_offset = addr_pfn - ALIGN_DOWN(addr_pfn, nr_pages);
-			pte_t *tail_page_pte;
 
 			/*
 			 * if the address is aligned to huge page size it is the
@@ -1377,23 +1330,8 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 				next = addr + 2 * PAGE_SIZE;
 				continue;
 			}
-			/*
-			 * get the 2nd mapping details
-			 * Also create it if that doesn't exist
-			 */
-			tail_page_pte = vmemmap_compound_tail_page(addr, pfn_offset, node);
-			if (!tail_page_pte) {
-
-				pte = radix__vmemmap_pte_populate(pmd, addr, node, NULL, NULL);
-				if (!pte)
-					return -ENOMEM;
-				vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-
-				next = addr + PAGE_SIZE;
-				continue;
-			}
 
-			pte = radix__vmemmap_pte_populate(pmd, addr, node, NULL, pte_page(*tail_page_pte));
+			pte = radix__vmemmap_pte_populate(pmd, addr, node, NULL, tail_page);
 			if (!pte)
 				return -ENOMEM;
 			vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap-optimization.h
index bd0974b262a4..fa9e9abd6656 100644
--- a/include/linux/vmemmap-optimization.h
+++ b/include/linux/vmemmap-optimization.h
@@ -83,6 +83,12 @@ static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
 {
 	return 0;
 }
+
+static inline struct page *vmemmap_shared_tail_page(unsigned int order,
+						    struct zone *zone)
+{
+	return NULL;
+}
 #endif /* CONFIG_VMEMMAP_OPTIMIZATION */
 
 static inline bool vmemmap_optimizable_pfn(unsigned long pfn)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 2bc78aa053a1..4309f8b626f5 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -236,12 +236,6 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 
 	return page;
 }
-#else
-static inline struct page *vmemmap_shared_tail_page(unsigned int order,
-						    struct zone *zone)
-{
-	return NULL;
-}
 #endif
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
-- 
2.54.0


