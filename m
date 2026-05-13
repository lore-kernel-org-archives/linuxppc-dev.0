Return-Path: <linuxppc-dev+bounces-20889-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E930CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:12:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv3l47q2z2ygG;
	Wed, 13 May 2026 23:11:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677875;
	cv=none; b=MVQC64cnRT/1Yu0t0BfMiZhg2AlhGlMJeWmRn8wnL4A9RLkwRoMmjeUWZBoSoA+29YMDp5FiYJO4cW2ZaB7TnGMDbehcRcCQp3+zK0NxScJintB8b+ELEJkXb2wnMNhHCW5D0xwQFBPtV6kE7uFggufI0Lb1JoFy5ngMkXdBu/+tyUWIFIrTNnlqAYitfmu3lWXUE26Sv6HHya3eQaNTvK5KK1sdxVBjwYIWsb0o21fihQzBqAm4VnXIu8jSqiEB9iMe+np/JoYCkxK40z7FXOqQkEmpsRv56rAa1yKZa3HRqsHHIpLSV8I5V7unP2nC9q9c54KK9ZwO9sgwFILYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677875; c=relaxed/relaxed;
	bh=zm8LOv4zY1TsfsxyQCLJwzqDtIAwoZz5LOnZLOy8d38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShegUKciAsnkWKjrDGcKVK9k2p2VnqwYWyOoFpo2cUxFtHOoSkRd8VyYNTX2moTux2zuuwBjTGX7eKUcvB3jDAbhhzBFQj+Lv5AQAw6AdHs7eiBPRthxA4mXBKqytFbdOyA6TVmsvKlmVjn7HDMqA0qOcCFzu4l+n3kcw8kaaHoEFcN+XXcABp+r7Xk6n/RFLpjcSl/lQypOjCaw/DSWkeUVdX0reOLqDqX7Bt8raVbNSMKbpYiIBaUJse7kkS0PsW42qKIqUvJnNlFA3/ZImJJxjByIEHlTez3TemFYz8xvlcXNobZ8bJK8bpOY4yiWXY173+ZSqir/YXp1KTVm2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=HWUaCopO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=HWUaCopO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv3k5p46z2xvH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:11:14 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c70c112cb61so5197589a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677873; x=1779282673; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm8LOv4zY1TsfsxyQCLJwzqDtIAwoZz5LOnZLOy8d38=;
        b=HWUaCopO8bmuAIYEBMmn4y5jPEhpEPijNdW3hEZEPHF1GNSoO5zDRNk+zf8Me/lmoQ
         n+bXZXJj5Ad46qPEYIN6SH8MxpQJ/EkSBl7Wh5Drtx2KCH8TJxuTNnFtcYzjCGKNnnWS
         o7UtYUzZURytee6A3ITR4zxiP6s0KNzXdUXjUQCbeZOMHfS71F8e9qvED6yPDRWkX0Jb
         0hm2oyLNEMwmmLEE2EZxxQsBDIFJ1YAflUNQKh7iuzTHUFEJQSiS5G2yGhL9bSRsfGh6
         nRJZzF0Ca7PjktEs6H6Rqn4s3poks6d8h/LxBFQDe6YyYFVmipEAtJ/Sz7g+A02gw+ms
         Y6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677873; x=1779282673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zm8LOv4zY1TsfsxyQCLJwzqDtIAwoZz5LOnZLOy8d38=;
        b=TTHsYdV8UBnKu254BO6U5UseneoTkzRLwyFfyB5hzU1xvbon0evUD/jn/vG3TL6oxZ
         7Jpu12pMZIwcwP/ZvEWD4NI4G4XGVwhYtKl7KfEzVKobAukvSVvT75xnyn6JPQ4NU7Qu
         58P68zJ54IRSgtH3TzUuE9d7AIO2LjOyNpNh9fyeFo/B8qSMxEyHhvVc2rs3dMj23wGJ
         oUBG2wzbu+5/DGj5IbOIZ+2qONR7h+Or77KWSSMSWS2dtbuiaIgU+AWolLAI9X/112kB
         nbhFJF4SW5N7sqZIww7I+XQg4N0d1t30iyKPm1jI3mm0l+kb1mnHek1C6/nPdNTbWKMJ
         7Ylw==
X-Forwarded-Encrypted: i=1; AFNElJ+1QZJ6pevDWH04JPSFiRl+Oq2BY6+fetnphIDVEr3+wXtUTWCPgwpsa6w5NjhHQXbiON27chr0mqeXItM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8EpYaMydcYd7rXRu46U8e5/EQqdo9QGn1efuA+OHCy43anLgj
	piu0Ayh7Siy5fUuhrIS2OvAk4e7ZZOLjxpNVeMnT9LU1KGiwWTLsUmsd//cJF2O9ygg=
X-Gm-Gg: Acq92OGdihbYlEKVpkfsJv/ad8vcTCFXdU6eiA97ZHCAg6fu56ul4fGuUV6e1jwUBuo
	aKvUhDDZ8HlCF43LR3rf5YWBmKk5Bk9g05kKeXVIGE1ac4yp7+SbIM4e41zML5rRW4xDwka26yr
	qAZE6xa7CNB98gnlGAme/wiWivV0APg3sxzdtU/S4JsWfkkV2eSZENlch51Xvy9PvBRQKq5Yqql
	yg/uf0xwMYIIuaSSw9de1Y5O/tFmp6HL5csEqSCPdgu4x0UGEyYZJar8bkEOm+FgeZ28Mj0uTRW
	M/ISVQkCWHYDQohsuak5fa8RGwEFQajLpNWjkwf7T1XUPYWioef6iHCFP2poaij2UW1v4KX6Xxb
	dUNo8+n3jKRzM5B5o2Vqj1j86+kLQGlZqvsfAtl7s/NAtjDVFH0kOZrF302FSZT7MXSWsl+whOE
	IyPpzu0YfdyaVEWtKjWNYngcDqiYbQ4zkX95u4llL278hjEAphn2n9k/zlTxXMtOC45pSrBw==
X-Received: by 2002:a17:903:986:b0:2ba:6ca2:bd9 with SMTP id d9443c01a7336-2bd30640442mr29210365ad.41.1778677872675;
        Wed, 13 May 2026 06:11:12 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.11.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:11:12 -0700 (PDT)
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
Subject: [PATCH v2 40/69] powerpc/mm: Switch DAX to vmemmap_shared_tail_page()
Date: Wed, 13 May 2026 21:05:08 +0800
Message-ID: <20260513130542.35604-41-songmuchun@bytedance.com>
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

powerpc compound vmemmap population still finds a reusable tail page by
walking the vmemmap page tables.

Switch it to the common vmemmap_shared_tail_page() helper instead, so it
can use the shared tail page directly without probing or populating
neighboring mappings.

This removes the powerpc-specific tail-page lookup and its fallback path
and aligns the radix vmemmap optimization path with the generic shared
tail-page scheme.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 76 ++----------------------
 1 file changed, 6 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index cf692b2b5f7b..95e65ac8cdea 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1250,59 +1250,6 @@ static pte_t * __meminit radix__vmemmap_populate_address(unsigned long addr, int
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
@@ -1320,6 +1267,11 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	struct page *tail_page;
+
+	tail_page = vmemmap_shared_tail_page(pgmap->vmemmap_shift, device_zone(node));
+	if (!tail_page)
+		return -ENOMEM;
 
 	for (addr = start; addr < end; addr = next) {
 
@@ -1352,7 +1304,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
 			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
 			unsigned long pfn_offset = addr_pfn - ALIGN_DOWN(addr_pfn, nr_pages);
-			pte_t *tail_page_pte;
 
 			/*
 			 * if the address is aligned to huge page size it is the
@@ -1377,23 +1328,8 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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


