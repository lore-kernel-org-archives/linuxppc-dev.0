Return-Path: <linuxppc-dev+bounces-22531-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3BBCD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 03:59:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5PF2rbqz3bwX;
	Fri, 12 Jun 2026 13:59:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236769;
	cv=none; b=l8SA45oi+yNkX/c/18Y+WJ75QENYuwwJTJ3p8f8am2gV1LooGKxXKHib/WkdQlWVn6dazxoHSlqxBQLTHU1XilneiyqSupyQ7GwxJC8ANkwodX3VKfBbRJ0fOeN8X79ixvLZ9N3kGmAnryEAnPzmsuFPOLGTnebAHvgOYclLd2AszXwhSrtV35q1Z21sFSiCTx8IxUWlBpHBKQZsLzr1mvoLo1LD4COtpB0gUhkKhDMFg2emi1yuLvVtzJ5rztRaRsUHTEEQq5dzqG1f5Nj+GqkjqAuPzueVyabXfkYi+vy9bracxeImAh9iak0wY1wjOjYT0gNjtw6C9EQcZabrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236769; c=relaxed/relaxed;
	bh=A38edv4qBFIhST2C0H/v4DfDnWwAK1V2ZV54LtDXngc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJG3hueLXxrU4cujhPtkUEMO18r6f84LWEKOjT3twF76CyDi3fWYWknvjtgO6ylN/ARBfcgD2KgQAPKpWhs0MR5aP5/XE/sT1vo6H1MKnN3alHgYAS80mhN4nUHrv8boLJvqeTQeiNYI5DBmYl98jBJDRWhA3svbgpRXs/W0RWjxvsc6qpghu276Kk/iFg24R47NGSTJw+AIMe2/ZEvtZR0vcIC5iuyNHwX1dUINrqUMsqF1h7w+heeMzQNcVWmq62vG/WY+xJ5K5+/uoL3XA8lw/IA8eeJQpBrP3EQWgcubAKGF+NUYpRjZRuLOi5zI7dJW5TYYstkNvAs/jFV2yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VeZuC317; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VeZuC317;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5PD3mtHz3btc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 13:59:28 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so407813b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236766; x=1781841566; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A38edv4qBFIhST2C0H/v4DfDnWwAK1V2ZV54LtDXngc=;
        b=VeZuC317IyOv//uIb7+gSaB9KCg1GgnQC8uz8uFHWkpKvlEojUQbvgXoFxbSo9UOUz
         gbkwupQcShbP1+3UZl/bf/3DP3Xfr+Y5SXLdL/cPpcKUVQdX0Rb8nwKK9CBkjfThXTP4
         ZBJ3qaHR2d4GDFWYRfGEQ1QuPKC3X0iZEd9MdNAqWWDQdpyGihwHobPz6QFxzXbDQydK
         x25kJm6XRoL+1MjbKOaa/LNQzkntVTOrrnwc4fC6jgS64TRoqGQI/j27FCWQ9F6GAUzB
         9Vhiij9aSG507R633Mr4d6EuB6fkmfx9NPhmF0x7Nxn0lBjEmK3yQ16azgQi2JJmfQkt
         XseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236766; x=1781841566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A38edv4qBFIhST2C0H/v4DfDnWwAK1V2ZV54LtDXngc=;
        b=dsebGpMamjaYQWGpwdNLJG7ehszyqyQLn1WsVxKOuTh82pQL5GG7WQIMOY0XdAS9da
         ggMyc+1CvSvBilF0+QRwj05TXIs+69eHfhK2PamPPBMF/1FV8cR/bRFUnZFWpI+wUD/D
         HznCO6Lv6I7t4/4gfZXIShbwM5HK3xVYITjPl4t1PPcwTecWkLjrtxCNnRlryRx2+1rJ
         niWtya1eNlazSL8gsSqeSI7wNc1HXOKd+Dk60TaiJ85CdGEyJZo5AKBx0pYxgWH6iz45
         MGuKM5jM18jFye7rPXXge7feFbIZ0g9gqQHSDWNf9g2BPGQQOz1rQKqfX7qSmulWODGH
         /40A==
X-Forwarded-Encrypted: i=1; AFNElJ/NGyyQR+YxMQpQwQKH/5O8pt2jq4sbrMkGKeY88X+TVQVFPPRfIGif1VeLxSKpTNWUmwUEfPDe/M7mkFA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxVK2sRBb3oJj+PrxxX9QdXhNv4Cvyw3iUfz1hEP2cBv5N0cHZp
	mNol666MclSrOX8Dvdxr6wCe5ZS9uk5MJVOGqP552yTRF2S+wEVLDpXm0Ku6C044Udk=
X-Gm-Gg: Acq92OHttLWMxOV55raLQAVift/xGa5v0//TgrgJuerZif84mvjTyARJue40yF4NAC1
	BdOsn8AfYURWvS76ftkGeTmKfWu4Y8DJxFB1NNT2uA2fo4Mp4ALm/uOp1WPsyBV435+RWh8qaeI
	FuTAoQXEtynuAO9Ad2UJCy7ecAdX8SDmGQpdwDoYg7GdUbDFqbFu0MegKJDlRallz57fX24fA1j
	uNu81K3baoskEzzgfdWDDDuS0wxIDNqlgQaTClhqBn32Bcgv2ZqJD7i3R39Nx8c7a5BLemzMDJG
	uRm5q7jVAr15fMkaxbD6WarYs6owy2+u3xiRwidmQVS2vugLmmJLKu9iDAgvp5y5UUn3UQGrnJ9
	dN6Ja4rahoRapenK0xH3rc/8WH912+q7P+j1bel/Z/9pAIcTsnjiqzLoh9T9JGoRQJ4sVOfg/RI
	MtyKNq4tTTVwj0O4hUhYu73+gwCWChs04DSCBeRYZrhJQ=
X-Received: by 2002:a05:6a00:2288:b0:842:5988:470b with SMTP id d2e1a72fcca58-8434cc161cfmr1136338b3a.1.1781236766275;
        Thu, 11 Jun 2026 20:59:26 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:25 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH v4 03/19] powerpc/mm: Fix wrong addr_pfn tracking in compound vmemmap population
Date: Fri, 12 Jun 2026 11:58:47 +0800
Message-ID: <20260612035903.2468601-4-songmuchun@bytedance.com>
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

vmemmap_populate_compound_pages() uses addr_pfn to determine the PFN
offset within a compound page and to decide whether the current
vmemmap slot should be populated as a head page mapping or should reuse
a tail page mapping.

However, addr_pfn is advanced manually in parallel with addr.  The loop
itself progresses in vmemmap address space, so each PAGE_SIZE step in
addr covers PAGE_SIZE / sizeof(struct page) struct page slots.  Since
addr_pfn is compared against nr_pages in data-PFN units, it should
advance by the same number of PFNs.  The existing manual increments do
not match that and therefore do not reliably track the PFN
corresponding to the current addr.

As a result, pfn_offset can be computed from the wrong PFN and the code
can make the head/tail decision for the wrong compound-page position.

Fix this by deriving addr_pfn directly from the current vmemmap address
instead of carrying it as loop state.

Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

---
v3->v4:
- Add Cc: stable@vger.kernel.org (suggested by Ritesh Harjani)
- Collect Reviewed-by from Ritesh Harjani
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 10aced261cff..cf692b2b5f7b 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1314,7 +1314,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	 * covering out both edges.
 	 */
 	unsigned long addr;
-	unsigned long addr_pfn = start_pfn;
 	unsigned long next;
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -1335,7 +1334,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 
 		if (pmd_leaf(READ_ONCE(*pmd))) {
 			/* existing huge mapping. Skip the range */
-			addr_pfn += (PMD_SIZE >> PAGE_SHIFT);
 			next = pmd_addr_end(addr, end);
 			continue;
 		}
@@ -1348,11 +1346,11 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			 * page whose VMEMMAP_RESERVE_NR pages were mapped and
 			 * this request fall in those pages.
 			 */
-			addr_pfn += 1;
 			next = addr + PAGE_SIZE;
 			continue;
 		} else {
 			unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
+			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
 			unsigned long pfn_offset = addr_pfn - ALIGN_DOWN(addr_pfn, nr_pages);
 			pte_t *tail_page_pte;
 
@@ -1376,7 +1374,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 				if (!pte)
 					return -ENOMEM;
 
-				addr_pfn += 2;
 				next = addr + 2 * PAGE_SIZE;
 				continue;
 			}
@@ -1392,7 +1389,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					return -ENOMEM;
 				vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 
-				addr_pfn += 1;
 				next = addr + PAGE_SIZE;
 				continue;
 			}
@@ -1402,7 +1398,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 				return -ENOMEM;
 			vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 
-			addr_pfn += 1;
 			next = addr + PAGE_SIZE;
 			continue;
 		}
-- 
2.54.0


