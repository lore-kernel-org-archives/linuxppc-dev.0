Return-Path: <linuxppc-dev+bounces-27099-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B0EC79FA1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:04:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2X302y5z2yqq;
	Fri, 11 Sep 2026 15:04:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103058;
	cv=none; b=nlffuI6RgsgxDOxvMk/OYbBWFw80wiA2HgrRwsFVfIFh14ALbhqoAsZlYcDGGkGgvUvSuxkGoWpsTMLL/pLOyHeh42i0d8E3fUtexgnhi8KAQFLciwZZQ1VkPETXFHu+y71F7pPVe23U+sIL6cJTEyKbLM+iKI/aJEKSv7dcnwrv2NG1BXj7prFa0oSlQ6L7CLgvfv3ksoG6KzBFbPBCBvf6J6Eegyha/+pT5HICK7s4iBXP2iRoEuQj43zFQQeqxElEqWzd8Vgh97TCMxTqNkPZFtdHFAsGoX+F0D44rOxjGx3FmpMecJDadmsrY4ox5qCG+Qti/W3E2SHh6beW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103058; c=relaxed/relaxed;
	bh=iM8j8Wu3fwHIWd8x6lR8eMq2Esw45qvi78c+WOmPzrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qs/lAvKMMnOQA0k4BctgZPhEXQBWk3OEZxJvEXhL8DQKm1cqikb4/ExdiBgKu7KlvgP6qBX9NZ1Pf6SQRIt5q4W+KJJQIvMd8IN68Oy4/1MUwDJZtBC9FAOmzlNVj5HOIVTNETeHFdW7DGZ5xLl74E6NtYL3oC8KPGPEBeHsqb0fXOjvyV+PdZAwXvZjpnWjWdxeJASdEHr0c2/gwiPVoWuukVJwHcCcoYBIMAoL0Om888Q54jjremaGD3IvnbTzwMSBK5qU2A1U14559I9JtKzx0cvsLxuHwBtVU/4KTfSlHtHyiVPjEIOPZn4ueVrxhIFFf1qXhUiNO8pH52DNqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kTQM6qeJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kTQM6qeJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2X22fB7z2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:04:18 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-38759bcd877so576396a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789103056; x=1789707856; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iM8j8Wu3fwHIWd8x6lR8eMq2Esw45qvi78c+WOmPzrM=;
        b=kTQM6qeJGoH9XO3Hj0kJE/9MXH7lqX6ipQ00leIHzOC0/Oqi8CQwxcw8YHWiIZ9Q+t
         0dDzLUiS1Xb+/Is1pEDeH84WWYvlg+TjgB8DO9mAFxLnR8/ede+jR4BbiDhUYWgQfD5F
         UeUoCTNbjTHJm/3oXphIOSKRifafLP5oRGat0MryEnIM0tYFPZ2CakdibJVQ0GADctzp
         rISmokjIDYJDy0tw5hFa7cnTL2N1KWr18hqbJbZfoLbLsIOrtxB3eUSLOl4Be+DlnhBi
         6BU+ILUEEEm5hD5YMyXgXSGQPYMah6bSCf4+a9bEeBNQyVs0Obr8cUxN9wPG0rPsSo8B
         Ph6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103056; x=1789707856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iM8j8Wu3fwHIWd8x6lR8eMq2Esw45qvi78c+WOmPzrM=;
        b=TNjA0vKYPyPg/iCWlqZTih4wUfdhtLB5DB0k4x0BEqIsR8U/Zqn/p9mC1pqF24lHRq
         R2u+YMvkzKX28wh5f03KykR5udDtl0uA9yYuLFKIO4nIJ82k4mJviaPFX5WDHuD2k1VD
         YkjLRg217KDEdn+VuEcfYR9OII+3Xaja3wq0NojQOMtj3wgJycJ8FF2Ik4Z5rEKCIw6h
         mSba+E2KSeRNPPNHJkoZMorwKMiAYCUaKYCZHgRLv5a8dw+aRXKDuouWWqBirCcqb2D4
         CBrBoG1VRS07XBq8h169YZdGYRa69W82/f0Y6bstP+JMS70ulns91RACJINQ4YmAav9A
         lzCA==
X-Forwarded-Encrypted: i=1; AKwUvBzI9J6VRw2nsHP9vHohViL4g4luW5CwYuuX3UdhJuSKa7YBZVntvp/kVWtIZsDdW6rKvwWrSG2nRkPIANs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mUe1ZD/n4uvfWoRoxHtocwmWgXRXE728CMBfpczdW1pDcAO2RE
	Yl6pktLFcYuNcxqEZfu7MdONsVslZIhYvKyoVOQZpsMFnQI6BLucWqm/NE907TIVZAE=
X-Gm-Gg: AYBFou0YY1/isFo1XWvOUGLDS2ZuIeZwwNlW5FtLSLO5rU92Ni1zlMDgGAN928xbfRO
	QzhQ5kEM13uw1kq7gNVTy3C4U76LFHrWef4c28LxZF6Bk7owBFI1/oyRGDgz35JsPP3Ak0owvex
	2fzqv7t17hQRgEaU21Xv6m54uVGv2MYPMI5Or6tmdQnwo7LiQollqKSGjEJwL6qKmn1yiaWrjCV
	qarE0EbxssoAk48rwgf6YB6SaSAkKSRF1UWM2rgDI6Kk6nSKmOmORvjLKCi+r6Jqr6BHV8k83nx
	iBBnCrn7LF17zpWv7b49rz+TexuO9Xg2KZ7WVRgk0xZJm2DzUcaE0+/6PZQn7nvTGr4auPMW6El
	aSe1ZEWJ1LVDlBvdHUT9vpi27FY8i9q2suqYTv/M8rsNT0ADgoM9po/rluHGx/3pw5ZFjShV4At
	Qbd0g87L6pskooH3Dg41G0+LYcq7iypEyFdPGiVyjW8hLjMvglnGH8rMUdrDWv003vYQqTuifv9
	IpXaV3GLKyUMnHEMWRaT8FDFnqzWxJwaeOh
X-Received: by 2002:a17:90b:3ecc:b0:380:540:d499 with SMTP id 98e67ed59e1d1-39d9bc382b7mr3533958a91.6.1789103056004;
        Thu, 10 Sep 2026 22:04:16 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2651561a91.14.2026.09.10.22.04.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 22:04:15 -0700 (PDT)
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
Subject: [PATCH v3 10/11] mm/sparse-vmemmap: drop unused section_nr_vmemmap_pages() arguments
Date: Fri, 11 Sep 2026 13:02:27 +0800
Message-ID: <20260911050228.58884-11-songmuchun@bytedance.com>
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

section_nr_vmemmap_pages() no longer uses the altmap or pgmap
arguments, so drop them from the helper and its callers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v3:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 10 ++++------
 mm/sparse.c         |  3 +--
 mm/sparse.h         |  6 ++----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 39f0cfeefc6a..96506f594924 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -131,8 +131,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
-int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
 	const int order = section_compound_order(ms);
@@ -637,7 +636,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages));
 
 	return page;
 }
@@ -648,7 +647,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -658,8 +657,7 @@ static void free_map_bootmem(struct page *memmap)
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							NULL, NULL));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 	vmemmap_free(start, end, NULL);
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index cc28bb41fdb1..b75921c622ed 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -250,8 +250,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 						nid, NULL, NULL);
 		if (!map)
 			panic("Failed to allocate memmap for section %lu\n", pnum);
-		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							       NULL, NULL));
+		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
 					SECTION_IS_EARLY);
 		usage = (void *)usage + mem_section_usage_size();
diff --git a/mm/sparse.h b/mm/sparse.h
index a5111087ee3a..530692cdd516 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -70,12 +70,10 @@ static inline void sparse_sections_init(void) {}
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 void sparse_init_subsection_map(void);
-int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
+int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages);
 #else
 static inline void sparse_init_subsection_map(void) {}
-static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 }
-- 
2.54.0


