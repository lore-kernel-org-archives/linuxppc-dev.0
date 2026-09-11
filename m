Return-Path: <linuxppc-dev+bounces-27097-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4101AC79FA1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:04:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2Ws0QJvz305c;
	Fri, 11 Sep 2026 15:04:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103049;
	cv=none; b=c1WX1SBtzPOmkE2Oh18h/anE+G+R9ynUQeB44O5mUeuiwrKx86FWqrJx3Od95ipyvCb0D6XOfP/22hg8KsOVjLX2tzydGNG//PMH63xsZb5UJmz7WOQbcr6ySlh0/jGX/81iLZM2jq+JxIeYvz0/bjDbONlaikyNMQon1VkD7jo7fNThfQ299awZJEAKrTBvobHNEY2B15g+oq4ijsExXjDIfVrEAVkahtzqQX5z93428r0+goYQUXWvCtPJBweI3wN15s6FY9dVUbpk/44eusZexiqmjt4mO4qa+YpQ3EoXTyAjWNJ5U6fuFpSFLfXPfc8UygGblNthP7sxx5oCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103049; c=relaxed/relaxed;
	bh=TZbZ6WC7vZbHjIhgnid+8T29mCn5dRvITTk6eMnH6Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLGlcpcdOS8imE4MZ2jp40utPg4j31jlNdaO1kw1R+kEy/GHHPILx9ev+xvI5B99ZL18ZPKf9Sue6bPqmkfqz61pzQgtwHZPUxHhw2DIgEsHGkYKrEoHldK0T0MCpjBv07xOGVYwFrQSzNug11AspGXYyhPm3SsS6H+u6tDCUuqj7iYLOdWjpD+vPtlZ8kDxCclwkHEE56778pTxujO02jF0SCZj4Ckw7zGckEU3TlX7eGuZiAQR3mrEPMoBs0DN+W+s1IXj4J7mLuHX4jWqUowd4VOIoR0ltFVBwRRRLAWYc40ba7OOcIPQMfKS2dJqt3JNM6e+jkww2IeLfvRUvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NigQ/GYh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NigQ/GYh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2Wr1S3sz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:04:08 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so456230a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789103046; x=1789707846; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TZbZ6WC7vZbHjIhgnid+8T29mCn5dRvITTk6eMnH6Vk=;
        b=NigQ/GYhpYpgLBdjcqM1zzm/iSFryA1aCOC/XV9IcPgjQzI/Xfb8/TlSB2eYVJN/TM
         HfNr7x8Mnb+B0rW9TpaASKXM71xtVXgexRl+DC/WKR1UZ0rl5UMUKph2BnmJ199g46Tg
         hi4UIo1Kd1tR2MEP3mltuH6lwVq+caZQOfsaAo0OlyDFkchkgfedJ3eV5d+3K219NXL8
         aMG4UhmRYyCm6MtkH7trEvwtbBGJqtfNPplfcLaGKt4Tvze8vH4FYVkG9DFYHhnMv2Ht
         9niUVuEDzECtiZOYTVnCSrcB4+koF01oBKv6TewAAuzF9kmsY8ntQYCvwaYGSZ14lmvB
         hWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103046; x=1789707846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TZbZ6WC7vZbHjIhgnid+8T29mCn5dRvITTk6eMnH6Vk=;
        b=hA2ZS5FrfasKwTnt59i8dm8bNL6/NfVSkjYC4B0N+2GK58MtK1Dl4+5hN3D9DHNwOr
         EN3QP1Va4ntJcAHI9GcGrjH433GZlpyrfBOHtqUeRhBDB50AGsxeU1azEdtflc9oImlC
         LbkJxdaiADQ3WTJ37hoanMI8sl+TK7qBDBLXWP3GITvT5K9K2nPeVxRoFdcYRs9+UEge
         eQVJWh/Ly0GWBuompz77AycIJlrnfjYZwFPssS7tqBtL3dBh3ASEJPPgmX59zjU6Kr60
         wT661KWsBAfKJtn0FwjrCVEKsIiUeyIEDF+ORAE87q2uolto4i+YVkjvm72wqJAFFzkH
         RrtA==
X-Forwarded-Encrypted: i=1; AKwUvBwj0lnTw8S6TSypm8H+eBCI1tLf6pZwu0Spm/IfgJvPbZl0paVj6KuFSQZcTrixSCv3aQ/PeILvi56awPo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nyruiD4EfqgtOygvaVfSrFn/nMqG4smIgjdY1fBNMXClrMIoBM
	FAU1tt6jhkH+ZIFrpBru+Fq0AC/vDDdkyIrRtcDUonyT212XmOZW/WEAtgNGGsOBiLVknjGg8LO
	mAnsE
X-Gm-Gg: AYBFou2djxNBerAQDfaEovXlZv2cOGUXB7MyxqUQJP2vRwKn5RiglqzM/QTrxd8SL8E
	k3ix9OYdk0atD9RRD1e8Nx500n950++jSHdVrIfL59O+j4HJ5VJTFxHRV7bRARix9Z9eT8oR5KI
	QycYF2XOlzek/TSOhM/guifkLq+qVMrpSrl+FRrzUwNSw3Qfv0KydYYQshmKxmC2VTZ4S3iy55m
	7013xc9OkbBQ3B9IhGWsxEbdxG5n/ny5uQ8GfeFsSs6mi1Qkwu+nlMDq4JGUTlZSw05Nff3bGjJ
	6G2a2dS7Aj+b9kH9eZdj1lgIZPlAXzt8oN/slY9Nh6aXr6BtS4uk58BKR+ccD+pYS93Gk8A8UdS
	+VCcLbsnuX4+AKARfpD5nGVvZ2shdloJp4+6LXsvpm8o5SEgfCiFYrerEroZhHeAQlL9tine7Xb
	qlmiGPnBMVzW0oIFFMk31MynQnlGw94+6u6oJRYc9+plfSMjQYPDsms+tjEfeDk5b7MHfqD7TZe
	wrsXIVgUsXrMil9x1r3FeQp3Nhzxar3zcjP
X-Received: by 2002:a17:90a:fc48:b0:39a:e983:d4bd with SMTP id 98e67ed59e1d1-39d9c3527b5mr3643408a91.24.1789103045863;
        Thu, 10 Sep 2026 22:04:05 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2651561a91.14.2026.09.10.22.04.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 22:04:05 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 08/11] powerpc/mm: switch device DAX to shared tail vmemmap pages
Date: Fri, 11 Sep 2026 13:02:25 +0800
Message-ID: <20260911050228.58884-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260911050228.58884-1-songmuchun@bytedance.com>
References: <20260911050228.58884-1-songmuchun@bytedance.com>
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
 1 file changed, 9 insertions(+), 71 deletions(-)

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
-- 
2.54.0


