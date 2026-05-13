Return-Path: <linuxppc-dev+bounces-20894-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09D5CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:13:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv4G2979z2yj1;
	Wed, 13 May 2026 23:11:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677902;
	cv=none; b=mewCp0lhMOpqELYUJxZtFdhf03860OYTNhuKXzUbA1S6NF/tYrJ5RAa5DDaiGZ8L0aEcJ5xQBIIZpsP9UsxNyJeiGRf5QZ6L5DayVdveiaGpwyvApzVwCK2M0Y5g6vLR0/4IYgEXWG04VIG22AKnfts4BgE+7KGCRxwu5Do4sWnOLLYwHlaCHcxToOJvC5dc70VAOIQVgZo/RGc2kLlsm/Uu/NEaxrMkeJYjfvy90zPBYZBL1H+ucvbd8fB0hewvnpKwJaZCP6a2WvWh3rIRdJLVWXsFGUQGbwVDenEC33FhL5oa6KTvmkfDYli0rxJZ5aJ0tamhnlgoU31LojD05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677902; c=relaxed/relaxed;
	bh=cQTyOkGmfxy6eUFBRtUP+rZk74jFDbmzM0hnLmumWs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dw65ZrtR1l0orohfcTuGgMvzJNz6b++aJjbG2iB2CnA6TXEqe0+u31156j6viRjXyREdgKdV4P8Ytr4HVerVHIf2dFvyRknCBzB1kOfiwLtH0X3ggP+mx9WLp+KwRiWMGKPAStxDJa9e8trHnxl7jUE7+LthNgerlfCWlT9vkS88Vfp8nTEudb4dVHk4Kenzi7sVqj/ZRog4yM89lzdd4UmVZjBmhteetG33/AzDhlDX3u3J5Dkl+xEIikrdaTIyKXK1+qS+FbQrvCHO0/b/d5LUXUvT0WY6mFqHSns43O1Uw0Hkfs5TXuy72PmBEbiGqFuOpOp51z7nAjP7ppjwnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BRmWBD6s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BRmWBD6s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv4F4m2zz2ygX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:11:41 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2bc7b311e77so17545905ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677900; x=1779282700; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQTyOkGmfxy6eUFBRtUP+rZk74jFDbmzM0hnLmumWs8=;
        b=BRmWBD6sSJw9zSlzjRP+7G17/4HDI6sxDFTN7BkMre2sYNFRtsG7MowSFATVXP42q9
         6ZQA/MKaf3FkNKUPyurIQaLYBlBqgli31ViulsVuF/AAGLR9wFsT8trI9AZkaaksW0Q8
         HOdGiI7pYPTin/Fq/Iu5adUod1t530XVtE5L+g9UlgDBRVLoRphD/HbPo/QHbIoQSYMS
         dgAe1nCNUiq0AWgQZaVHGJaN7CQGwl0CjJv3pd/yekGCDlOvQqrJ6VaaVWROyNiDIO81
         bA3a/gAIkorI25BGEAunScDpOGlpm3rH3xzNIjUxjMEtG63PVzBOH3s+Zv0FWSIdNEBn
         zVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677900; x=1779282700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQTyOkGmfxy6eUFBRtUP+rZk74jFDbmzM0hnLmumWs8=;
        b=TiMmGUFMF9ZKJ5hm5sSL4lRcdoQsJJZjMkLZSyWzrsQ1kV0+Bs1YObbkgACLRgInUh
         ndlJPWgWLi7lIbgYdCP2N0kWFyha5MpJrWLiyT/bCVwkZYALSwnBtmZBi0oMYqw344In
         xiCz+fGfarfRn2YC6PnZgz+ZYgsAqyRFc8fOdc5dl1ljaJ6GDHRlOdwGOk48f+brMt0b
         BUVRqRfK8QWBqeMAGuRb6xQBlsbvyrx8a28rctB1owO7je5/JggHSxm4VV8hS+3u4EQO
         yNQbizH5LZcvLNLGJI500kPm31aqJOl8CfArnXJINqSEkGlN5Pyg4kYMf7BbM9v4yRgE
         0mgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KFsgbrClkXcFunyDty2dxLJhJssGhLaS4nJX+l8/oXKD3LlW31HIeqL1jhdTW8Kcx/uhbcYcegcahyYQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxiUgMctKzZfp4Huc+55q80OTxKWY3NjMn9ukXMcbMHNoBsr4J5
	zea7pr4ghVuorPyHW9O8AlNePwGdAoAOQWS9ZkELtZyRApQOl9Z6WNGph1QcAHqFTg4=
X-Gm-Gg: Acq92OGfDRNXcXo58Nwe3ZcXl97oa1/XCTKsMoBZlczhu3vxMMFLJlF6KSgAC1Xsl44
	AiegQVWov5HfeLUhpKRTqmVg3gRIM+0N2vm+7IsJkGfGMoTfzBqRniu9kIZHybmemr/G2ZaJW3P
	6IhCaVF9BGFPcaj7cH5Btn6ARDSyRdYCyrFx00jexW71klruCPm/HjhN0s+QfAJRc2IJLk7Vb4c
	kE2CeZohljyV6CdlrzDn4QSrBVq3BfgFTdgr9jKWchYzsK1TC0S+TPMqjNHJZb2y3iARfq9ue6U
	TcXrW7Qcp/imwfJvi6h0PNcZSyIFJqNi7G2HGo9hrcng3jf1zZh4ql7oeqRUxkVQVDMVfIIwxqZ
	49bokiuPMtLL5pG0vm13bC6Wufuatpym15s+L2wVSav13NrKCBsV8YsSThGI2kI/jRa68Oyo02F
	W/bq/qKttNy4YGVd1gGSyUMCgV5eg+NRhiiyemmdLw15mEdRWRjvG7e++OtdY=
X-Received: by 2002:a17:902:da2d:b0:2bc:e299:4b3f with SMTP id d9443c01a7336-2bd272a16c6mr34476025ad.10.1778677899685;
        Wed, 13 May 2026 06:11:39 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.11.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:11:39 -0700 (PDT)
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
Subject: [PATCH v2 45/69] powerpc/mm: Make vmemmap_populate_compound_pages() static
Date: Wed, 13 May 2026 21:05:13 +0800
Message-ID: <20260513130542.35604-46-songmuchun@bytedance.com>
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

vmemmap_populate_compound_pages() is no longer used outside
radix_pgtable.c.

Make it static and drop the unused dev_pagemap and start_pfn
argument from its only remaining caller.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  6 ------
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 14 +++++++-------
 2 files changed, 7 insertions(+), 13 deletions(-)

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
index c7f2327681cc..18b24bb891b7 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1109,7 +1109,8 @@ static inline pte_t *vmemmap_pte_alloc(pmd_t *pmdp, int node,
 	return pte_offset_kernel(pmdp, address);
 }
 
-
+static int __meminit vmemmap_populate_compound_pages(unsigned long start,
+						     unsigned long end, int node);
 
 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, int node,
 				      struct vmem_altmap *altmap)
@@ -1124,7 +1125,7 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	unsigned long pfn = page_to_pfn((struct page *)start);
 
 	if (section_vmemmap_optimizable(__pfn_to_section(pfn)))
-		return vmemmap_populate_compound_pages(pfn, start, end, node, NULL);
+		return vmemmap_populate_compound_pages(start, end, node);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
@@ -1220,10 +1221,8 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	return 0;
 }
 
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap)
+static int __meminit vmemmap_populate_compound_pages(unsigned long start,
+						     unsigned long end, int node)
 {
 	/*
 	 * we want to map things as base page size mapping so that
@@ -1238,8 +1237,9 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	pmd_t *pmd;
 	pte_t *pte;
 	struct page *tail_page;
-	const struct mem_section *ms = __pfn_to_section(start_pfn);
+	const struct mem_section *ms;
 
+	ms = __pfn_to_section(page_to_pfn((struct page *)start));
 	tail_page = vmemmap_shared_tail_page(section_order(ms), device_zone(node));
 	if (!tail_page)
 		return -ENOMEM;
-- 
2.54.0


