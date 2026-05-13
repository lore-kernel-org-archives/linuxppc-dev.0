Return-Path: <linuxppc-dev+bounces-20904-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B79CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:21:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvHz13QYz2yvB;
	Wed, 13 May 2026 23:21:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678511;
	cv=none; b=mMBAfj6AKDHuKoeNuPo1cE9YEGyumimP1++94F2Dan+NupGBy7fLSWCPItjA4bnjR55F8o/yHwhQ+eLiHsshqU3zMhs/O1fWOBSz5TWAkpUXXjL6YIC1+ZBCbJMaF4uOP7tTa38jz91UJNoUqHDQYbbkOzu5xln7cVUThbBWn+lgFEvZv6+5ggEI6ZiDej8C7bAVSB3l7RS5Fy4tTzQyzKlTjp4VHKyoLUuYQrEuv4gStoi3khi+E17zHhGLt2rjCdh0GeNFm/8E9i3PmzQT3DiqXqzvhXiJG8aS8CeQkteWdaQ2an6l8xRxmuj543IzptY8ehwO73yPL1XvMqmYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678511; c=relaxed/relaxed;
	bh=bX0eh9yAs1Ger4W6kkJzAbg+VRL/E8mjDpD877qpJLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiinqDUIXiBswwfYWb6aCyeAbq0u3ALK7CWYxH5w0K2BGK9CSVB5f4CfSjL4ER0F9Z7Q+SuG2E3csEr2+25rv9UXZHmVOweJBUH+1QMIR98kJEoR+3iZx31FaEeBcwe7B/WrSbip+inI7Gqi0tdvffv4ki/vy0eehQaV8dMcgGf6fJBlnbfuJtmxDa3Tk37AS0tBppZ2OTEwen/bN7pz9XJZ65jQXDIN9ETmvL/xBOhXcImd0a9dOr2j22FiJkMhDPZpyMuGRYvH8R3q1BLyo0ksO5E4PYRNCr4VyEAA4hstjSAfExD47kUnpfj2kLF2aSBYBZwvNq6aEdQpkfwGGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LH1X93Z9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LH1X93Z9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvHy2kFsz2yTP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:21:50 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3664df32e91so5493821a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678508; x=1779283308; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX0eh9yAs1Ger4W6kkJzAbg+VRL/E8mjDpD877qpJLc=;
        b=LH1X93Z9nBmjUxWgAi1Gxt0xY5OCY40WHqbQv8NEIxzqBb+HiL8S522atloG7a7bFF
         wWtk2E+ViLlLspUiORsZlbN6fIYZ228m8z7CE1J0IYRC8IDoVfQpJBkXsIx5K4MW8wUr
         Ra3FAIkcisNZGLVtUw9hieHCQ6ZpS+8koch3TQ8ITiRb7Hz9OFpeHHW6FGtZLjKMcrid
         HmvRUyqRpX8/GGFBskVUAL2aSvo9NshskMNNBDuaostbcek279Uc1CLt08YYaNCx6P/t
         gFHZb6svfizXqNEJYIFEqcOgtVi0AlRhVd8dQwAneBwxYb0H+afZjcT/wZLitKs1Tc2d
         98Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678508; x=1779283308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bX0eh9yAs1Ger4W6kkJzAbg+VRL/E8mjDpD877qpJLc=;
        b=OoaVDaj2NlZp6wA12iYF9kWxCTevjn9FQ7oJdPMGKE4iwBynlcqmzfYDcqxTwSWEIO
         9l4UsyyVlHGeaL73z5ZlKEiZxxC1Ha8EQyADPaefPW/laOsKoK1Gx+DvWB5IST2Ty/+b
         8wqJSHwdkrSoj9z0UOEfMPW+hpFrehuiV1roCi2KDgdQi1nkrsmMyWV53zlWiBOVoc4y
         KzXyo1lmk1UtcQVDqZB/zFyvTpKMLXDpXt5KnYuvswHPgnA5gmDu8rDITzMb1fllLc+c
         cgfUW7UooO0BkJc2LiC3b7bIVfRpN8DekcEtEb0Q/yvCHwTq5IrR2f5NynYbw3ZrR0h6
         s5Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/rgkawkyiwtanxd623pfkMdD4QPuH/Eh+3+tjCcDx5UACfNThZvRn3zm6WZepTIsTrps9mQxeOBUM7Q9g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyAIhN8GZu+ap1BFs7YpYe8LsUTPXn+wD+IdC5EfLRJ3Znc2Kc8
	SpE9+6oXCO9IwZ5aEiYx4uZm8DomaOqJmNFY4jvF1wzwEQ9xynzj6cO/m1HqPeTahdo=
X-Gm-Gg: Acq92OEg743BT0RoXvoHoVsIf6ho30JpmxBYVZiFuIxp3jyYfrxzFoHXat2NYe/tSpF
	WCsz3I63pcclOxSV+QkI3GsuI0IPTVEaRsQhyEgbFL2xd8cg0uynTePKdjYTRaMkD4yprwlGGM+
	JgYWL9QQ3QcpnxILFeTFpbNpbedto+RhvXZfoUYmYWuK7YIIm2kHMYqoqXmaRdovesFuqgOIl6R
	p45IMPuogkA105b7sAlHHGygb0z8AvgVfTihUu+GN1RRrjiyMBaLOo9gDlzm0yiYjfM5+UgmjyR
	3QvcNnlMoNg3sTdCylNp9EwtdMwAUhNfbFEKYSa/7xcV3XTtHt/6FmhcytNzrWT1gxFbTcQuD/x
	HZfilPMiPhtlGwrIRQu1i457y4jFNG3jmqaTKQli+gr8Lk4XoisGypj7uo2bJ+/zGzTVP9b3nd2
	lfxjPsu7JkXmkt7Ku48DBM4kTQF7CtZRqD0NRcMpdz908xL84yD4IL5X7SIiqCHZ7XHy7YbO4=
X-Received: by 2002:a17:90b:3f86:b0:366:33a6:9921 with SMTP id 98e67ed59e1d1-368f3a909b4mr3551470a91.4.1778678508386;
        Wed, 13 May 2026 06:21:48 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.21.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:21:47 -0700 (PDT)
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
Subject: [PATCH v2 55/69] mm/sparse: Decouple section activation from ZONE_DEVICE
Date: Wed, 13 May 2026 21:20:20 +0800
Message-ID: <20260513132044.41690-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

sparse_add_section()/section_activate() currently takes struct
dev_pagemap only to obtain the compound page order.

Pass the order explicitly instead of routing it through a ZONE_DEVICE
specific structure. This removes the dev_pagemap dependency from the
generic sparse memory population path and keeps the interface usable for
other callers (if possible).

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memory_hotplug.h |  4 ++--
 mm/memory_hotplug.c            |  4 ++--
 mm/sparse-vmemmap.c            | 14 ++++++--------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 815e908c4135..083f0abea62d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -304,8 +304,8 @@ extern void remove_pfn_range_from_zone(struct zone *zone,
 				       unsigned long start_pfn,
 				       unsigned long nr_pages);
 extern int sparse_add_section(int nid, unsigned long pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap,
-		struct dev_pagemap *pgmap);
+		unsigned long nr_pages, unsigned int order,
+		struct vmem_altmap *altmap);
 extern void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
 				  struct vmem_altmap *altmap);
 extern struct zone *zone_for_pfn_range(enum mmop online_type,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5c60533677a1..ef1595bdfd3a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -385,6 +385,7 @@ int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	unsigned long cur_nr_pages;
 	int err;
 	struct vmem_altmap *altmap = params->altmap;
+	unsigned int order = params->pgmap ? params->pgmap->vmemmap_shift : 0;
 
 	if (WARN_ON_ONCE(!pgprot_val(params->pgprot)))
 		return -EINVAL;
@@ -412,8 +413,7 @@ int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages = min(end_pfn - pfn,
 				   SECTION_ALIGN_UP(pfn + 1) - pfn);
-		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap,
-					 params->pgmap);
+		err = sparse_add_section(nid, pfn, cur_nr_pages, order, altmap);
 		if (err)
 			break;
 		cond_resched();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a807210fe9e1..667424aadd6b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -613,16 +613,14 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 }
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap,
-		struct dev_pagemap *pgmap)
+		unsigned long nr_pages, unsigned int order,
+		struct vmem_altmap *altmap)
 {
 	struct mem_section *ms = __pfn_to_section(pfn);
 	struct mem_section_usage *usage = NULL;
 	struct page *memmap;
-	unsigned int order;
 	int rc;
 
-	order = pgmap ? pgmap->vmemmap_shift : 0;
 	/* All sub-sections within a section must share the same order. */
 	if (nr_pages < PAGES_PER_SECTION && section_order(ms) && section_order(ms) != order)
 		return ERR_PTR(-ENOTSUPP);
@@ -667,8 +665,8 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
  * @nid: The node to add section on
  * @start_pfn: start pfn of the memory range
  * @nr_pages: number of pfns to add in the section
+ * @order: section order
  * @altmap: alternate pfns to allocate the memmap backing store
- * @pgmap: alternate compound page geometry for devmap mappings
  *
  * This is only intended for hotplug.
  *
@@ -682,8 +680,8 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
  * * -ENOMEM	- Out of memory.
  */
 int __meminit sparse_add_section(int nid, unsigned long start_pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap,
-		struct dev_pagemap *pgmap)
+		unsigned long nr_pages, unsigned int order,
+		struct vmem_altmap *altmap)
 {
 	unsigned long section_nr = pfn_to_section_nr(start_pfn);
 	struct mem_section *ms;
@@ -694,7 +692,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	if (ret < 0)
 		return ret;
 
-	memmap = section_activate(nid, start_pfn, nr_pages, altmap, pgmap);
+	memmap = section_activate(nid, start_pfn, nr_pages, order, altmap);
 	if (IS_ERR(memmap))
 		return PTR_ERR(memmap);
 
-- 
2.54.0


