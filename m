Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49E606A338
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lmcmXhXj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKsRZ53gMz2yD3;
	Thu, 05 Nov 2026 17:12:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793859162;
	cv=none; b=RzPkEx1HLmV3UHuTOPfUKjLMNR6uPnd84ub6ZBOKNAjaduXHzWpdDjy1xVKAckeKyADv7w1w7e2fyim7sm5IWtpaXORk1NfbSt5sdxlXFXKvLUKWgs9A0rDstNGEy5fh5Q/Ht6tYaTqi43VXv6q5IPYF0I5OAg4KCE00PsKI1iIRt7RTiFnZ4pgXj5tepGBJhfovCul8PPwrjQLVRVqTbNJYQ3HXx0vqN3/f+PsTp7Sqj+SccPEr9npe1TVQcegesuvMmgQJg+Z5X5FEJVYhRkvLkWsYXmmLif3rOiS0EhYGQ1kApHDtOAQpN2fj9IojDBmenZvkl/jfZKjNP+xj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793859162; c=relaxed/relaxed;
	bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gzc5Hx9on/ngwFssc5zBQSk5WGaDyR12J9j7uKMZryOAQm1nc78LiAlzmAa1UtfAgzILvdvTK7BsrSS3RM8k/OTPl/HcPwBeOli658MLmgOTtpr0YA5vzz0OjXm9PvLCBgAncN5OdF4SrHe/yBzs6nkWWzgqL/1i+wIo2EKJXIUG6Fnnju8fXHG3X74+0oxL6+s8uvO2cz6bKCJ6brhn8HiruWcpNexb1jodrafWl+y5pw6oWy95iWNGPDgwzGyZVNkQhjUHxtYs4yrzUaxoprAdDH5x0Xfb3Cnrcovt9vzCdOiSkUTW4NUMXvq/KmoRYUgt6ThJ28K2gyUTbzcSrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lmcmXhXj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lmcmXhXj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKsRY5cBHz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 17:12:41 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso788216a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 22:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793859159; x=1794463959; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
        b=lmcmXhXjmK2PsAEslCaCTHFkqG0yM1WKfBMfPjbJ6PkyQEIVWZ3exuRHoEKUxzhElx
         ZmOTc29XKUAIb6aFZTYJOrxO7vRSrKzSUNdcegJZ0nco70QQBmDpFJODymxVYzJK9Xkq
         PgIhDoUbuwXxumLvmACLuNzXG6Kmnj7XHumu3wzQC9WYEEGMGhAlHTeLflihHdfdFhwJ
         TP7rvey6SHNc1ALXbSEqXbl2Qu7eaOhPPn4DpFyxbcVZUU5z3AwuVEIlvL3Quw4TGY59
         efUwQSQytdX+lyBj+0TA+NvYq3qUYY46qEUYvdDxcDSPcGye324gYt8PTxE8eEPmcTbf
         tTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793859159; x=1794463959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
        b=JiRKputNYAg5/AosnHNgaKtGUmb0wJcY39KeBi3nojMa4zrTX1uCdy7KWAzaqFVarB
         KhkTU8QR/2Xx4gF7m8339sHkslrJ4yU1iyGflqowfuI5IN+ruaic1u55rKRNlgvnycU6
         x8MRvXvLg1wH0etwhEdpmxJcDqDB7+d4QoIXN/E3d+zDcVxdR2okeBBCewTsEubW2UrH
         ZuoHQwc/cm1xr80Mgyo8Yn11iCMg2Nv7H+xqEUfgXDey1rDXGMC6wfWmWFzooZUodj5K
         M8j4xwYwAQWYVfxQydgtEyGkV7/VVvIDF++id/ZCGtEiRE30asN57QnoHRibienxGvpX
         A8JA==
X-Forwarded-Encrypted: i=1; AKwUvBxNLk240wIxYA/WDy3j2ixrcPdjmElXg5slRxfJGYi2pDSnb/bnMGYOYmm92KhYEihyGfX0xp1h7C0R93w=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/YrIahncqrzxRXywL0GPnW1sPrq/yCZERQTaHYoipdk/rOTcIP
	rvdULoyJXvLhHHSqH5I91TfyIkRH0dC6nHaGEFVcCu6lnClHJNlujCoMvG2N7kbPo1E=
X-Gm-Gg: AYBFou1Q17xJ8s0H233s2PmRsPx+DKavq2LbAsGUaQPJm4E/9woedtX0OfW20CyRg2i
	aaLSBRytKCq8xBuCeZQwe6Lobz2S8nwy//atI1y7ODjneKGWQUCzljYvB1dlVLb5BhYyCbclQZv
	Xziq1Ib1U1N93meVmJke9Z2ILnYa4DeIgTDA/5mHSSn/NGFBkrEUtnJ43bX/I3gmCCpxjNys+Z2
	d/y9ycgHwioi4vIrzTku285zF9NqAiwjjeoUVj4rX2O4gkDL17KP96L9EEm0addujtcRclMmdVH
	DBlkJ8BF0llkCH9A2mJrhHVlQA9uOYU/N7kdu9fYgNz6KBmMULu6I3O+DL+Md25/pp1h+HmJTkG
	b8FNz6qFJV1S50RMwHWcxcHL7o5JPH+aWraupvSoPd0DYAtIY5satPKV/zJUM9DKrKTIWwRuOd1
	apj/E4pOQ82XK2tAnKWRoOvwRkYzdVAAuyE0ov66M7OLkdXYwPZN5+4MtyhPq5YBN/Tk4kw6JtK
	/cYr9J+NmiP7A+laKtAG4P0i0ufo0iWA8dVGd96PWxDpu0xuj3WJQ+/l9aKW6582GbEuF9X/pun
	bvKqR5Go5EuCn/5ohL3zepd/ewErECcNGncEnBvwSXbQEUhIHJrsP2v37xEocDSlEg==
X-Received: by 2002:a17:90b:3d4b:b0:3ad:eb4c:26fb with SMTP id 98e67ed59e1d1-3ae897c87acmr15846459a91.23.1793859159284;
        Wed, 04 Nov 2026 22:12:39 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323a1fdsm2107528a91.5.2026.11.04.22.12.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 22:12:38 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 1/5] powerpc/mm: make vmemmap_populate_compound_pages() static
Date: Thu,  5 Nov 2026 14:12:13 +0800
Message-ID: <20261105061217.13302-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105061217.13302-1-songmuchun@bytedance.com>
References: <20261105061217.13302-1-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vmemmap_populate_compound_pages() is no longer used outside
radix_pgtable.c.

Make it static and drop the unused dev_pagemap argument from
its only remaining caller to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  6 ------
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 13 +++++++------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index da954e779744..8452a2714cb1 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -356,11 +356,5 @@ int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #define vmemmap_can_optimize vmemmap_can_optimize
 bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 #endif
-
-#define vmemmap_populate_compound_pages vmemmap_populate_compound_pages
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap);
 #endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index ebac5f9058f6..2924604fbb38 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1117,7 +1117,9 @@ static inline pte_t *vmemmap_pte_alloc(pmd_t *pmdp, int node,
 	return pte_offset_kernel(pmdp, address);
 }
 
-
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						     unsigned long start,
+						     unsigned long end, int node);
 
 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, int node,
 				      struct vmem_altmap *altmap)
@@ -1132,7 +1134,7 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	unsigned long pfn = page_to_pfn((struct page *)start);
 
 	if (vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)))
-		return vmemmap_populate_compound_pages(pfn, start, end, node, NULL);
+		return vmemmap_populate_compound_pages(pfn, start, end, node);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
@@ -1228,10 +1230,9 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	return 0;
 }
 
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap)
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						     unsigned long start,
+						     unsigned long end, int node)
 {
 	/*
 	 * we want to map things as base page size mapping so that
-- 
2.54.0


