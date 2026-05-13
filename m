Return-Path: <linuxppc-dev+bounces-20880-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15932CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:11:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv2q1ysnz2yYs;
	Wed, 13 May 2026 23:10:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677827;
	cv=none; b=FJPRA6xPL43Zm19B8xWVHmhbV3GQdl7kCsGZKvFZhQmisXdK07RAPsMD6twUbVkugEGxqvm0I97PfRd9A+kbnCG7DyWG+QcrouFbuV4RkhIxu+JWV5oBaOXc7uew1TGD0PsZEmSHMRgKyW0NhQsW4dMr15fedgapKt1or0zCGidE63ibYaLYZq4trZsSvcjPwnJvVD4IHlPyiKA40pMAkTrWxMxx2JuDe1dxoECiHYpwWVbKGdLamB+zUc+mE4/8XT4nymd5GxMwItVzKPBXRxQRf7cfyaRJTAbhBtG1te0VZZnLGtT2VSyNENzYOr5cYob68YFUhG5pU/RKZ9O+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677827; c=relaxed/relaxed;
	bh=MIg/xuUWJQhpBPpGQxQRETv9f5LqZHFddPqDq17HTHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmoD+TezRZAsmH3S7TrzlPo3q+wCnV3YQvz6yBQTHXYiJxQR7f/TgCH3u5nxNrppl0U9yv9EGqGKvb1MU6qHLackPxJ1vqwUpmW0OAXVE49MmyyzZrk71NaOfonkk1704pHIG0HFi6r3EVgkgIJamG7Gqw6Ilt3XsZxarNMs2PV47Rm/VUGc4epcClljxVQhduIpT4Mxpa04LDvHjwP2s9bN3qKrP9OyNXPqOrr2wssatbQ1m+uJWae2iZSQQi0mEYn4i91igiOkaGVXsBYgNcHx6CzBCojP5O6WjaOneCrVyTtF9nBrCOLwqsBhVmKRcAQMGxvpouNqmRkIZLv0eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dp3khBqD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dp3khBqD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv2p0hYbz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:26 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2bc85eda6b6so20791205ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677824; x=1779282624; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIg/xuUWJQhpBPpGQxQRETv9f5LqZHFddPqDq17HTHk=;
        b=dp3khBqDa9iw+RXj3WO/zCmK0fmj6YL9P5EoEX9O0Wx5ag6t1uRCwxdI/Na5CgcA2v
         2q7OY9GLhzeNc71iRc8jwjU+Tx1etAx1YMuqJzwsSTVXxZGrWtn7eDA6d/xwvC0RUv6r
         hAbNP8Wcg68gjOBrz8CfCYX1inZBX+VKHCC2ailt7okWXxtpNxtGRzcIn5pmxF8I2gMJ
         zI697XGIRNshSQH4QciaAhnOO8IOreeedUjYHck1e/LMpcJriA959YU7XHX/uivYfkZU
         bFrKVM0Uwu1Mvqgl4UgCIot/mqJOhV0L3weq+72f7QYD3r6J3Xxi+8w7uJbd0DFf8rNZ
         /8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677824; x=1779282624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MIg/xuUWJQhpBPpGQxQRETv9f5LqZHFddPqDq17HTHk=;
        b=m4e6d9598/Ibx0CxPdYrpqGCGN+DaxwR2753VMfIK1yVRG7JY6EcpMYwCNg7IMyXcR
         lOZRV++PLCbu0IlCrkJNZvVWAL8AzkI9F8ymGHnlUp5LzLS5u+GJo69WhZbQx9BJnUcs
         j1fG+yMWZqwYdXERxx2IlTy5j4Nr7LTEnTQwdPHsMN57uio95JteEongi/s5oXnCn7Dn
         A3hpL8DR6Dm8eTHJpbTCXff5OGpPNMWQq4V8FDgVDVq7hgFFI81lsXCGwXTk3A8Vk37R
         Akh+CIPKksTjaILSyX0cTs0LSga+rLrwQxyH1ktb3QgHppVi1xRNXLdWnzTb+8tDLOoj
         R5hw==
X-Forwarded-Encrypted: i=1; AFNElJ+/WaELyd1XIkMd6D/q1qZRUrgzgut06Fyv01/a5anpW7VTDqzJKWQKB4mSdtuKEO5g2XT6Eomd3CjtSEo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YygqzxFaj0xW7LqqvbDgZN2Kj+Uj3W5JkAvWJ7wFU6JhJQQ3jKi
	4uXvhweEw1jxRsWGJkcsOqvxmLULYRj+rwH4qR5FvT1LRPCwO9hk6+ZPzbS59DFY9dk=
X-Gm-Gg: Acq92OGKVSo0+OqgDXJvgBLUhXPCVjkAWQficI9t9db0X00XPb0z4kghZvLpOl10eqD
	idjdqlHif7Y+D49WW1yziRairEalLUM6G7NWXzm2Yh0OxJ0MvkEqH3XxOX2cO8SKEp3aBvDKqQx
	qFRzfxhXL2FHRKAgSTqsTh5x8ab2/4KiL6ob81zPDh40o/Me/v96WfREblcUXxj2vBCGHTIwk0Q
	nG5b9f+XzYid8xgtm/Cu430aJ99Sz6lhHnIpKWde3ZUYI4wrVaqftSLkciCrpBmxVRbOaS7fDDR
	eJFrij2696U0zRt5P6zvCWJUb3Ywqqjs3x+jZI/pA/KkNhBC2DfGeKYAezun62DFqaJufiP1jqm
	4LlxsfwrqaOsRvy1jUI6A2pk1/AWa1qVeueCaNQ2BxCgSSIycNpeSbq1nIx/pC8Cs6pn2YcSrbj
	c+BeFKa/YCjg4M6xQHy6cn4nKFsZ6l9jf4o/vuuAj8XIAzk5hikI6wA1pGZoQ=
X-Received: by 2002:a17:903:bc2:b0:2b0:c45a:bc2 with SMTP id d9443c01a7336-2bd27139901mr29366285ad.16.1778677824098;
        Wed, 13 May 2026 06:10:24 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.10.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:10:23 -0700 (PDT)
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
Subject: [PATCH v2 31/69] mm/sparse: Remove section_map_size()
Date: Wed, 13 May 2026 21:04:59 +0800
Message-ID: <20260513130542.35604-32-songmuchun@bytedance.com>
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

section_map_size() no longer provides any shared logic.

After the sparse-vmemmap changes, its only remaining user is the
!CONFIG_SPARSEMEM_VMEMMAP path in __populate_section_memmap(), which can
compute the size inline with PAGE_ALIGN(sizeof(struct page) *
PAGES_PER_SECTION).

Remove section_map_size() and inline the remaining calculation.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h |  1 -
 mm/sparse.c        | 15 ++-------------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f39f6fca6551..fef39be8acd2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4845,7 +4845,6 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 }
 #endif
 
-unsigned long section_map_size(void);
 struct page * __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap);
diff --git a/mm/sparse.c b/mm/sparse.c
index 33e89bf1ec0c..47349f6f463f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -222,23 +222,12 @@ size_t mem_section_usage_size(void)
 	return sizeof(struct mem_section_usage) + usemap_size();
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-unsigned long __init section_map_size(void)
-{
-	return ALIGN(sizeof(struct page) * PAGES_PER_SECTION, PMD_SIZE);
-}
-
-#else
-unsigned long __init section_map_size(void)
-{
-	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
-}
-
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
 struct page __init *__populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
 {
-	unsigned long size = section_map_size();
+	unsigned long size = PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
 
 	return memmap_alloc(size, size, __pa(MAX_DMA_ADDRESS), nid, false);
 }
-- 
2.54.0


