Return-Path: <linuxppc-dev+bounces-20852-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B83CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:08:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFtzr3zDzz2xn3;
	Wed, 13 May 2026 23:07:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677672;
	cv=none; b=KUMAtpxxUyLLwo/u9s4jgyalL6uQqxKE/TFjtpoLBO0Oyvh5DahBlmqdTEbahA6nNLJdwLBCX5OgsDjrMevzr7feWl8VCYLFt2bR0RJoLVNLmjrCMq5zahXNeftVc0aR3y3tjdzb6zNRjnqd0kgXhTnIn97gWy+N5QdaqEUtt8sQZsvTjGRbsnwAUfNk0S74VbRENcUzF2L3v3cbGB6Oyni/KEJqA007/f3z3XpXoWPG6J85Se+2JmEro0BDgbJz4bedwiTVUshXBcXxX4AObKZlgaESyXMUdlhzpIkECZFyAEKmicUvlInmMtb7WxQ4Bbw9F3Hw58f7xC/FxT6P6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677672; c=relaxed/relaxed;
	bh=W+0ze7EIzQ8zDlwa2Xdpv+yLCfHzqyRtA/0pp8bbhmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIhWPvQ0ROJS3GkCCPRm75b5PAmwHfztd9HioeCPJ0oiAdSDDn7cUKhEtxiCKhLtHnYam5+29DmjgiroZINNmuvFSUkLLpFNjpCGenY7PCCpJqsSy5VJdOQOPsz+RiUq+p1jbDTJuO/eKZA1hoG26REzVM+hvAMbiy2HBJ8JBW8mo09GQyga/Y5im8DNb03YOrNUTg3HNwnhKnw6/USUPLZ4qIYP8H6o6m9wKaH2gUrKEtiwaDgjomMOhLY2tlw8L9f4mXeGhX8/XEuxYzFojFY2p8w3ImOF6m3YF+aShNDKApQgsHsEq20IkEzLZMupBaW75DFOsCC4nxvYQqJzmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TI4mI4Pg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TI4mI4Pg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFtzq6BRmz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:07:51 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-36900945df5so330561a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677670; x=1779282470; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+0ze7EIzQ8zDlwa2Xdpv+yLCfHzqyRtA/0pp8bbhmY=;
        b=TI4mI4PgWcCgWsFxubc33jt4smjGxm3ac7cpXI5kSPDz2Wr/Sj3/l0iCgGFzwA0RiY
         RQowrV5ZnRFXXy/EdC8d2s2t58B3nr2FzumSR+dCxK167fXhJSK4qZhlaFSHMVOLQyyZ
         Wz+w0THUoamEy2gvH6U9xjTfzw3VHeDWJpbUDM61S90YqUTEqY5q0/kGM8B8NU13NEjo
         tg77+EhQjhFA4vTsHRNgy1UX3c6GFK8VogjwscRv38TUx3iplRqmkodNrFq0v6yOhoX+
         yyRq+gBD/sqfhLvaRWdOC+yshCxtpNig4vMz+2R/8bif/K7TlP07o7bOFobmxVeJUDZy
         o4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677670; x=1779282470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+0ze7EIzQ8zDlwa2Xdpv+yLCfHzqyRtA/0pp8bbhmY=;
        b=NJhPexRZ3LnM6/2tjcQpo0frX6HDwoEFH20OvzBUe3fHcKw2SauZs0dhzKNQRkzh0S
         Mh6+2x4wykkIDFaj0hBlYsQJTMGGvLCNoNFOhVTPH3G2lv+SY3yHFwSDSoLelQ7kQROi
         B+pZB0cgJbKLbHgFF0MZQVwK/yK2EFpl+zqU0MCD4R3yk1qJroAnVoy6K00rRtJLlYTT
         Tcsm0yiQcqACtQT0zXSL4ClKHzdKOLMpq0B0s1UFZmmtWmGKQwmKxrBZJg+28AZFazSh
         3CTuT5EE/JRRICPuTWW7A0WUI88HNoRo9ymRnT3iyffoFeVv7w+MzquldVQP8zkwCBe9
         JPeA==
X-Forwarded-Encrypted: i=1; AFNElJ9BTTIpss3EPGxtFcX1XF+5MiZHfw+330HR8mCEc3LyfKl2kNUIvp1tlW9+PypPDcpIAAfPGDLmqTB7lAA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw71wt1/DKWhV/rNrIMVU6c6mHdq4sgol84qoCufTGQrcZPJrf6
	bmsr0gwStVDAe2fHMRkf5fhRAAgZOZB86a2ofvWUTcmBuLyhgggUxcOObkpAZBR7DYA=
X-Gm-Gg: Acq92OGFjfhl1JyLQw/N6VwQxSuh1NOdDYIF1T1iiPLo1z1S7sr500BZCs6MYvlvWyw
	zdGpo76JG7gt4hKncT0AX5pCFWc2AZpZjZRnKMQMM62OKb6GIGBv1X/+aK+w9IZ4JHM6U0qg5Xs
	QjFd/7YcBmVh7f2Ql5Zu0EEVuiilPDY5qPRK7DT1RSGKgDWph8nH4C1lJjaaYxMO4tvF/u/ynWY
	AZh0MGmYfTTZPC9//M0buLSqaQg5CUONCKrDOx6wiL4nLJowUfrsrgm+/cFxRnr96katVSJEXz6
	O4KKEuR3PgZIcmsbwAeghTzofkFjVV0G736+j2WpgAHGkA+hGYYdLOzm28r856k50fKIOFd49cn
	N4dYUj3iIlZ2c6XuAyKqk+kL6VPyJ4uN4aMh6+vLQG8WUp4BikKTV6c8p/UahyKdRBTjuaPAQGA
	RChg6WSO+l+VqDmRlAh3opMVEuE05S2ROSiLX/TUIhn+aEIV9gctVGjyXMlhc6mpdMqzMCJg==
X-Received: by 2002:a17:90b:3f8c:b0:368:ed92:6f5 with SMTP id 98e67ed59e1d1-368f77f6980mr2850344a91.4.1778677669469;
        Wed, 13 May 2026 06:07:49 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.07.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:07:49 -0700 (PDT)
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
Subject: [PATCH v2 03/69] powerpc/mm: Fix wrong addr_pfn tracking in compound vmemmap population
Date: Wed, 13 May 2026 21:04:31 +0800
Message-ID: <20260513130542.35604-4-songmuchun@bytedance.com>
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
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
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


