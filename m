Return-Path: <linuxppc-dev+bounces-20117-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DD3FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 09:27:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3LvS1CNkz2yl2;
	Sun, 26 Apr 2026 19:27:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777195652;
	cv=none; b=IfJzxKU1YwrSZU6SVHgIf9OW8iea60++5YTHaNrFijHWQG0+UC2B9RavLlzqtkt0jOvTAZWQDQ5TxNJm+3osRY33rlsehY3bonNkac7Inaq8yF48CbvFnBxvPedT3qHQyoVvNVJuGbn+UHw+LKNMX3syb4rqmj8Zka4x81PHRRnDlU6oYyJW0himNdtXnC7ySuKBjV9LUaPz+VABVU/wEM2pLw0DI1k3osrVlSXXUxmpVG9HXD13iuWMSdUHQj60T3v2TPH0TeeQbt7Gqy9or9VJMLZvmHS0YOvhStZbdN3Q3x8kn2N9DapeRbztKMC8gFPFuvbS/I1p3k6Yq9Dvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777195652; c=relaxed/relaxed;
	bh=CoquneTBQ8S9NM0KYy8UH3zDqZYMfaQ5136cWznpdGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eivq/5UBoV38mdb915RGanDOHVX1B+7UvWWvSA3oAIQp0ttVBybJI5TEJVki8dYtxzXL8YjemLIXyY0EyOAzq0kaUxN7NBPZjP53oD31DBZdf8qmfizrcWzVPIG6h9Xg3ofkxJcPOqmfw/FPHOb6Nkceq5Bu8IV462+tUWEiXxgBdHIuE+uoYOS5Ycri8XzLCEfmy7b2Xokg/mql6nIgOyAPKONBLsNJraVjrDZl4zhkwfTusySFNkIPKWETbgbgd2zL5r8GRWTPJTLpSkF00CQDP4nYTjxbFQIE7aLMmGLTt8IQSK+9spE2HqUR9mk5yiQPTJidaCV+Np+4a/5Swg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KclFQd+g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KclFQd+g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3LvR2wJ3z2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 19:27:31 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2b23fcf90b2so88169915ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 02:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777195650; x=1777800450; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoquneTBQ8S9NM0KYy8UH3zDqZYMfaQ5136cWznpdGc=;
        b=KclFQd+g9QXs5RHfGB173tw8z5OWMQGg5ZC6eDS/wfm6Vz+HJsnNrM5PrMhV9qqe7l
         2k8pAJ45Ct9GVf29ifaKbxfT2xBK5IfEiSsGmGYRd1qYtACIk536oGlGvpEwRxSKIZfO
         NtnQ1dNgQwD/k9LNfncvqbZst3yzSWiq6WPT0wUdcfBPQalSy4FmvyT5mwwb8o7fDqQ1
         GkgLXp5Gk4/lDd0q7oCzlrx665H2gafskyfOd6tuy1lzlH9YllllRYwgjTUoqTIxyyyr
         BeAfVIJ6pX/t/F+59ahH21lUs4KPdiadKIhbZ4rI7ZDWwVu8x38PEuFR6xldNeAMPRXo
         kEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195650; x=1777800450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CoquneTBQ8S9NM0KYy8UH3zDqZYMfaQ5136cWznpdGc=;
        b=OfV/PCzSSyBxz0ScbGSjgXqheuOmlJdoHGNFK8V65UrZ+Rz9ralQpVusOWkZcvat2m
         GA7ZPntjXZruqwftT0a6rO0WYHLZf7W2xcp5aDtNnEANN6t+SfkLuNfVJ2D1++hD3lzN
         WTKD/tsZy+ldF/Ea2JNvig1UFKvjBLMN+I92jLdLx+KWxLRdEaMzaa32GLVxIIBI6eVA
         +yFHLj2zcypcQx2ElaeMj7eJ9D+RK1AFA5BOpaRzWGu3zfo7dFAav/OwH+2NydPZe3MU
         Kxo1D4zIejpLFim0C4KKEx+qmb0YMD8RbEFttvdOKPYbSuApu5xh3XqHMatfEcHzqayJ
         qypg==
X-Forwarded-Encrypted: i=1; AFNElJ8VFphrmRNPNss7TlXD1usTtqn7Jac4amRttotIYD6c5FX1qMPoqPCkER2hhdSnLXpXo6KxB+1nfrfsHdU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz40SQW/dLsiRXkFc/hWPZqvuOA1rPT2pw6gpjW5qsH4P8bkNX1
	czdb4lYYuz7vi6Uor5xFQPulNmIHj/4pCv4gcN6ZwIO/rQZUm2oxyPgZc+2oN1Q6UNs=
X-Gm-Gg: AeBDiev0991nWOljq5Pyf/VBvStlfF3h9aPLO0zvB1cv7JB8Tk16iczBxd7d64HLq1j
	Sjt0Q4cjGvZn9om0k6C4EUr9mM8zpG/bDazX5zYdb2y3G1BRyHJ65CCvIDO2NWIZnuTu7bgH8wP
	KhmNuZcI8GZoZawsamNHROGXN1Garai9aGEv6Pe7If5fvHeODvYQ1iWvbWH8gIJxmStqGbL1Ufg
	z52m4OjKZRcqW2cRsdF1rVloxtaBuj3L4QzUlKYDCIEVrYLckZshjM7HpgAKNGZEgZdoSTKNzdY
	ihl2fPooHmw2iOvGzbUXuBF3Ly76CJ1jYtlHH7IEIlCS+UPsT70mmRnaUDHElN6h3nR84Pu0UvF
	lUbej+Rb5mgsTx9E2eu3bgwBqIdlR3cDXdEXfHWqiWp7DcZHXzPPmTthiTFyhLCj9KxOIbWF31t
	KxU9vxvn7qvWEzi3n5+IGDA1uq4SJE
X-Received: by 2002:a17:902:e746:b0:2b0:5a4c:7263 with SMTP id d9443c01a7336-2b5f9ef646amr454625165ad.18.1777195649505;
        Sun, 26 Apr 2026 02:27:29 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm270352885ad.40.2026.04.26.02.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:27:29 -0700 (PDT)
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
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Sun, 26 Apr 2026 17:26:38 +0800
Message-Id: <20260426092640.375967-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260426092640.375967-1-songmuchun@bytedance.com>
References: <20260426092640.375967-1-songmuchun@bytedance.com>
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

When vmemmap optimization is enabled for DAX, the nr_memmap_pages
counter in /proc/vmstat is incorrect. The current code always accounts
for the full, non-optimized vmemmap size, but vmemmap optimization
reduces the actual number of vmemmap pages by reusing tail pages. This
causes the system to overcount vmemmap usage, leading to inaccurate
page statistics in /proc/vmstat.

Fix this by introducing section_nr_vmemmap_pages(), which returns the exact
vmemmap page count for a given pfn range based on whether optimization
is in effect.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v6 -> v7:
- Refine the alignment assertions in section_nr_vmemmap_pages().
---
 mm/sparse-vmemmap.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3340f6d30b01..01f448607bad 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -652,6 +652,31 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }
 
+static int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+{
+	const unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
+	const unsigned long pages_per_compound = 1UL << order;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
+
+	if (!vmemmap_can_optimize(altmap, pgmap))
+		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+
+	if (order < PFN_SECTION_SHIFT) {
+		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
+		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
+	}
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
+	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
+
+	if (IS_ALIGNED(pfn, pages_per_compound))
+		return VMEMMAP_RESERVE_NR;
+
+	return 0;
+}
+
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
@@ -659,7 +684,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 
 	return page;
 }
@@ -670,7 +695,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -678,9 +703,10 @@ static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
+	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
-						  PAGE_SIZE)));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
+							NULL, NULL));
 	vmemmap_free(start, end, NULL);
 }
 
-- 
2.20.1


