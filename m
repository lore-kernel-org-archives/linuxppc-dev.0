Return-Path: <linuxppc-dev+bounces-19366-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62990F3D5E1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:57:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXYB2DzBz2yvY;
	Sun, 05 Apr 2026 22:57:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393838;
	cv=none; b=cT3PACsSryEeFt7zIo7HHM7r6OZmxfWc1qKKKHBOaUMo24xr1rC+maEBdRTRPoqFx+JP2Owa+Xe5LYBdjx5rPk0jjNAJ1llguat1ZmOcbIqAHKzj95Gr48k9ynwRVvDXAt3bqXyM2ntssc1lws1U2sLAHqZHIZ/TN5CsdekDKeO5zGja8il2qWEkNNfk/bwYJWG0PQDMGanXsf/ZgrNv0TKx8tICsRS9RRrLXX6XHunhhe59FxasmTe9/88aj4MRRfNjNVBLRhmFgHB9d8WnobimwAOteIOuaw9vhiy7X2RSXl0vMxfaHK00HwMxQyNHoTFd8Xf7ey/mdL2ua0JTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393838; c=relaxed/relaxed;
	bh=dhCvzWzEYwqtXTRdhJr7F88/ilDc9KP9wceAmsw7dyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8SwNQAEj6qCZSlNXHTRkTB8yKcRRfDCJmOhci7bGxxcLcmxdaSij84FMF/IrWxxTHB1Wl10YY1RQ3+QCYaDDtrGdsYZLazvKUAHYZszM/j5cCnQv3SoyL99eH+8512sILgGhHwrHAQx/BfchSX+F0Wffve/Npl6XKIa3x7IHYWDjHRn4YJkyQc0YtmjlX1h6pbqgTBeMYedxLItmf3zio6sUeKG253Da133Izh2fCrcbExnWS/Y86a0XShj5D5M5qNqJvnPPyYCCfvw8Nr4dzvSObL09XqaGHbMmaLKGhtrzGr463sZTLvch2Dc08kt/JlzwIWuFzaOHuy1YX20eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Aa4NB7kw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Aa4NB7kw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXY947ZSz2yvW
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:57:17 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35c238f1063so1899571a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393836; x=1775998636; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhCvzWzEYwqtXTRdhJr7F88/ilDc9KP9wceAmsw7dyk=;
        b=Aa4NB7kwIxJkBZ1LzIpYH+qYbuXtLJiFVIQYRU/Ybj34k24eQzX6Z1U6T7uEBMqe8w
         KqAnZZVol50AdYNGwmqRcSSFji5zyHDt8h7QSiwSqgJcM7hRtJZbjXZ2fa2UyTKcEtZS
         MW+9MaZG++ruHCLsS4aQpRNYEe30JkEogx2KKpGTUUtej6Blkzwa18mDPZS+k1oyms9B
         dKeWPIsNPxQvTBFXh+ZYhErvxKCjcwC4BEPxOGLROemEIh9v1hAERD/RWAQJjTSpKCx+
         REU6o7H0+X6yEYLjRMgcY/qfu+EdpY8IqK0VKK0Wwhd6HGnmvw34SMXv8z/iqoZ7xA+z
         Q0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393836; x=1775998636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dhCvzWzEYwqtXTRdhJr7F88/ilDc9KP9wceAmsw7dyk=;
        b=B64c1qr/IOIoEv33mpgnmFWA8Ju11MweC2U9ajZ5G8s05p2eGEwWzrja7eeJY4ktFs
         cWl4zrpTFk9XwCI5W5NU8hyG80Je62qLntnp/D5VsVEnTvXoTLl90eVJV/vnxmBGwKKk
         IPJhdorHWCgfPg0MaTMNODkTo5LjKrPKFHpwIiStkwNgPThpawetydQnARrBKNr0c9j7
         OOjqELloRn7i61irm2RztmVvwym87qR0loc6k2LOPNO9nsWU0BoASk5AgZzmLxUZ9PKt
         JusUWcJ96lm3bJmmWJV3vvDazzo6GiFkV7eIN8lyEeaQDK1gjaczBGitjR+sJU5FBpBy
         8IIg==
X-Forwarded-Encrypted: i=1; AJvYcCVKp2llQj7JFGVW1Le+4nKNYSwkEAUxIU92JhJm9hiHz2iAGSNlntZ6D3E6A/VJuhMiiz80r3YVQXtgL8E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzjpl5WjSRkamLvHED03m72ZTC9OqUF0sru1WulPNZimSi5GsvV
	NCErPtxNqYyP9deimF0F79FytX6a+Vq61gUbinDUhMx/I3Pne3jaGsjwKddZwVZ/PBg=
X-Gm-Gg: AeBDieudWFMdVzye3mO95wzYHNK05PnycSZY/WZJTXcx122nNn7BMInkHT2UK3Uz2CX
	n3dT2SU2RFxlhjtRhmmpJtBPr7wKA+YUIXqSI8RSqb+idjVSgrTWAYe4NV5WHm5H8eGlsh1XbNF
	BQnGbH7+qAaTpu72pMdi2zbzAT8IuOnemNK5PeZ/TAJYkASVSDnOtrVL6QczrYc0nimWekq9nSm
	xyxl+2JuX/bJgbXZYTLiz5c1rMK8M6VUMloK0AZii1Q7u3mX7hWVPFCTlp9tsfJvXzCpYVY+c9v
	pgExqwNj6n3pczOr62dB5bPWYD3FptdMdCxDFAuRkkAFOPzt/9rcbAROzR1lGsYRXnl6lzb+S0R
	m4YzO70hOyS03vVLDp1BRoJDVct0HvrEiLqSuEV4HBW+r5ahKa9zcVj8+3QYqHr+5tA0QfkuoHJ
	oz5M+v1mygMDHgBKSQyxO2OvD6XHvLVERQp1pDo6quaRI=
X-Received: by 2002:a17:90b:3f4d:b0:35d:9482:2233 with SMTP id 98e67ed59e1d1-35de69a66e1mr8904624a91.24.1775393835707;
        Sun, 05 Apr 2026 05:57:15 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:57:15 -0700 (PDT)
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
Subject: [PATCH 36/49] powerpc/mm: use generic vmemmap_shared_tail_page() in compound vmemmap
Date: Sun,  5 Apr 2026 20:52:27 +0800
Message-Id: <20260405125240.2558577-37-songmuchun@bytedance.com>
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

The ultimate goal is to unify the vmemmap optimization logic for both
DAX and HugeTLB. To achieve this, all platforms need to align with the
standard HugeTLB approach of using vmemmap_shared_tail_page() for tail
page mappings.

This patch updates PowerPC to utilize vmemmap_shared_tail_page() to
retrieve the pre-allocated and initialized shared tail page, instead of
dynamically looking up and constructing the tail page mapping via
vmemmap_compound_tail_page().

As a byproduct of this alignment, it greatly simplifies the vmemmap
compound page mapping logic in radix_pgtable by removing
vmemmap_compound_tail_page() entirely.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 81 +++---------------------
 1 file changed, 9 insertions(+), 72 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index ad44883b1030..5ce3deb464d5 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1256,59 +1256,6 @@ static pte_t * __meminit radix__vmemmap_populate_address(unsigned long addr, int
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
 static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 						     unsigned long start,
 						     unsigned long end, int node,
@@ -1327,6 +1274,13 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	const struct mem_section *ms = __pfn_to_section(start_pfn);
+	struct page *tail_page;
+
+	tail_page = vmemmap_shared_tail_page(section_order(ms),
+					     &NODE_DATA(node)->node_zones[section_zone(ms)]);
+	if (!tail_page)
+		return -ENOMEM;
 
 	for (addr = start; addr < end; addr = next) {
 
@@ -1358,9 +1312,8 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			next = addr + PAGE_SIZE;
 			continue;
 		} else {
-			unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
+			unsigned long nr_pages = 1L << section_order(ms);
 			unsigned long pfn_offset = addr_pfn - ALIGN_DOWN(addr_pfn, nr_pages);
-			pte_t *tail_page_pte;
 
 			/*
 			 * if the address is aligned to huge page size it is the
@@ -1386,24 +1339,8 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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
-				addr_pfn += 1;
-				next = addr + PAGE_SIZE;
-				continue;
-			}
 
-			pte = radix__vmemmap_pte_populate(pmd, addr, node, NULL, pte_page(*tail_page_pte));
+			pte = radix__vmemmap_pte_populate(pmd, addr, node, NULL, tail_page);
 			if (!pte)
 				return -ENOMEM;
 			vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-- 
2.20.1


