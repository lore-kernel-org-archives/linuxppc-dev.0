Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC3606A331
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 04:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jUg0s4SS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jM36d1Gc2z2yDr;
	Sat, 07 Nov 2026 15:32:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794025929;
	cv=none; b=JbNLZMTRPqTFkNTUcuycmefhGgrM/XHXgRim+TRmNzI45UWk39Q9J2DD53iHBgHocWpGhHPXZ2yZ+hf7dfx4wc9jJ+0STl2hXfDve1/BMsEsEKNSiQA/vyxktGWylpih65+xHlUV6ZRUFsgGWBp/fxWNo+nlHpkgXea0RzzXdiBLR0E1ejjO7wxsHabhD4htfbl8BSP8Qn3UbfLroWiCHMuXdq5zTvHaKr3UzsKgv/YMWG8F74RUJqIqJKCtgZ5FND7RcuE1B7BGRufj/5gcXpMtTeuUeFGlni7DGBphgLrXUqLxcN5LmD0kpPL6ZR4ksn/MMW4fUUdMJv5cmf+pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794025929; c=relaxed/relaxed;
	bh=K3n9ukDrxII5BXz/7vbmrUFxcX10DGV7r2as+LtHfBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQbKdq7O3p2IEhdmvX6P7lq66tDU2ClTOw9NpWGE7S4l35fCRpFNxu4V5Jom5PiwtbWRqzKTnmq79C5w34h5M8XuanRHFwkK2cjyLg9d1IfLlUNsWlj12zIAJUHOAOHEY6Fu/DcNPIwCis4WwHHQgw5FAC2mTdPi4ryBwlQyrEW03PDmMEkZwsX5L6jUrHj9oaFeDYsUqB8ChaI4xSccr3mhJRRbiDjZNkbl5bxuUx27K8C3ethIpFxT0mbJf+wz9uAYHwmSUKMEGeRiTva0IeO+NnFVCN9DG5M59jaceuMgQu33zmiAwBiSaWyQN/1NzYa29+g3kdclY/1QzN64xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jUg0s4SS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jUg0s4SS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jM36c3nvQz2xS6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 15:32:08 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2ed1414df17so4937455ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 20:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794025926; x=1794630726; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K3n9ukDrxII5BXz/7vbmrUFxcX10DGV7r2as+LtHfBI=;
        b=jUg0s4SSmuBFs3fSAtWkGaT6SnO/Aa8q62Y5ANExWvpDsw7OucyRZ4NeDOeR4l10Sq
         BcPKIBb1B1MfNIby9ywuDDWM5PmwaDULU6ZF+kPBENpxoGP3YiKFSs8TceOJftrH1mz+
         mhk2GXzn/X87KtDCNbKaqdiPqUO3qsjB3kgL1AUQG2DZccbFeaXpxZ71J9NNFu0fOD1K
         ytRBJoB/GAmaedbdou0xic6yAgLms/ZbXsT2YGu13M17oUgIEFl4tehj992Ei+MTJutv
         ArPFFgJR6YcmsnQsd/gqBg6Xm/M4xviZii7M/IeN5EgQzURX4dkUJpmS3XBtvJ4RNd54
         snww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025926; x=1794630726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K3n9ukDrxII5BXz/7vbmrUFxcX10DGV7r2as+LtHfBI=;
        b=hhAl2pYs1/fZNHHa6QNY4LDDvi5RQ/x7xJMgG0ZaHgUL4LfChxZC1SM+XGABP4QT1r
         VZr3hnFHzlFSHnJ48XaKeMc1du8AgH1DsfW2on6//rdRNiQa0lt+fucjQMl5l716Yh+i
         QTTiLxJ125Q0jCsI9GhjjsRB1pa2MvCewE/gsOFm729V2jjOeLL7N7AZYo6zBRJ448kS
         tGlsAQtWL70FBrLwS9sx38V2KsK3fVqOreWFMwTwTe9WRF06MYVH5gp385fPGaEgUBLF
         9Sn5iUvB4MwFJ3lZCPHpDTIokb/1o75EW71++5IQzP1x+za9zfIM+ZAXu9sO7O4mKure
         2PCg==
X-Forwarded-Encrypted: i=1; AL+hErEUCgE4ioCK7iVxiwHDt8Jfefa/fsOWAZlbpDDHaKysc8EfzggeEIkIf4RcCLb8j8k5u0HAwlNsdPAmlyU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8WiZyennm+K9pOUKCSI68h+gETNlHqdC6yQPiBkLP6wfdU9qvV
	gnn0+S26+LBJTuwCQiEpa+sDqovhG2qM49kE5rOZiLWDiPEG/8VX7iEjTL2C8AorORY=
X-Gm-Gg: AYBFou39da/85yRWP+WX3mnmMLMj79BcqQSBpxbNo/TyOomV265kMFDtTd4F+TmdkNN
	xpGraZKykA02J8DxkIRwgnYwU0Y/iy6fFFIq4qcB0jJq7v8fIYdm/O81RsMzzbhGZcMI4TT7Vwj
	WOh++muis44dDVXs6ZeeXnylVfFluafLrJs/D4AhTlfJ/gSMPHgIx3CCj9IwgSpCj43ROOukDJI
	wgh+64rg+gU4N8yTorAcnncLYraj6GnGrNaFu/Q/P+ngmpbynWH+y5z0mDShEzAUetj2rVsEfzX
	Rd0xPWlkmaNTBXR5Z4h5lzzUTQfAr/GdhXzOjQWcWjDFPxGGkA4jJeT55E3ruyCZR859LDhUHNY
	UWND5JXVbUS/luEQajkNAt31PV4ilx9nDcU/0HPrdS5CXMhjHvNyJHLRtTABBpP0xqtIuTch3WE
	IZOXNCNikrj3JsXJG6UlvbbFhh6Nnh/KAt4uG4AGfRTlC69nJYZxLFMAxB5hS8ZUKwbxQvD3kSG
	QtIg7XTJl4yQplyRFrOdDubF+uPPuMM4wkTQAz6VlLMvRP7aAaIn8YfXi499nzOXtTh1KZjYjiK
	g0WwPT83Z4j2PNVtSHxQO9keppv4gD63h3SEbgibFtC6KA4YfB2bG8imBtj9
X-Received: by 2002:a17:90a:c107:b0:3ab:36c4:b4ff with SMTP id 98e67ed59e1d1-3b0db6b8083mr4981632a91.24.1794025926246;
        Fri, 06 Nov 2026 20:32:06 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10584b66bsm1578451a91.14.2026.11.06.20.31.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 20:32:04 -0800 (PST)
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
Subject: [PATCH v3 1/5] powerpc/mm: make vmemmap_populate_compound_pages() static
Date: Sat,  7 Nov 2026 12:31:18 +0800
Message-ID: <20261107043122.25650-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107043122.25650-1-songmuchun@bytedance.com>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
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
Reviewed-by: Lance Yang <lance.yang@linux.dev>
---
v3:
- Collect Reviewed-by from Lance Yang
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


