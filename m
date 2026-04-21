Return-Path: <linuxppc-dev+bounces-19858-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB8EF5A8A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 02:21:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g05gw6M2qz2yvY;
	Tue, 21 Apr 2026 12:21:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776738076;
	cv=none; b=mbRHGBiqOytqXYZQPsELjKpX1uBtBpogw+m6gffk4j54K4OJvV8/LLekcQuC8wcyj/IyEq5rxG1Qs9PBPb4SYqT6YziMHrf+eaIiBVK1ZT1Tlt/eaCPVNWNHTUtBzBiaUJiu60R5ZuOSZT3R9sJWQFgipYe9jkQHZB8vJdsO66iLBQu4hGyWu5RdHIFywPueoRFyN8BLkkkBBPqwmWsA5UveznvIQM91OBLFC9FSeVkXBJ1eMl4rZFun7yK9G2hun72CzKeq3fV+hpCz+i9G1xexn31dsZUGT6pyGrdLKpQ0T1yS87U9/kcR6A4A7UUGeHTPwPy2SaVsryakFqe8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776738076; c=relaxed/relaxed;
	bh=mFMUe4eU96PwNZ4hmEg9N6ajvO6DYLBIUThz3MnM+0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bh7n9+4vn9IQl552fyp0xnpvC37VyKV2m+OoGoP7JYyFENs0T3ad6lZ132YYDfIac+SnLho/yUBcunVo4Rl6lZbune2MptjlqsO0XflSHogCN2gquWaEoStN69OWBm6wDHE+CXDlMUF3qCcLMHohvJtfAmKkjGnRfhuhXuie2cQEjxgMs3vg30XLwmHgnORJ80paoIqG88FKO6IOM7etlHxi3YuyxRjeYGiMhLHcqeLHO78sP+B7fxmkeR8dQ6CXtL74C2W3ce/1rW84uARczKZI+f1Z2g8Nv/xLKFvrWwzCLXdVueDE6FLUH81UR/qUr0RktFcHtJofnKOCLwoKCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TWLqSQRX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TWLqSQRX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g05gw142Qz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 12:21:16 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-82748257f5fso2517476b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 19:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776738074; x=1777342874; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFMUe4eU96PwNZ4hmEg9N6ajvO6DYLBIUThz3MnM+0w=;
        b=TWLqSQRXTer69/04oN7N5HyuJ1rEP92/voWzYSH3EXj4HT4iD8nMTCZMuL4abugwq4
         tSyNQQs1xBkUJ3BGJUNVIebqKGat4A+B25dAbO1Ilj3cEOOHdqcoqhAQa8LAhkMGGgf+
         uPij/SupWJDWAo1un2h48Fr9bJimsNzTVfsLsLDs5FmY22UIuKrqyc5vU/m9/KV5Rd5M
         LrQgPhkqZtB90B48CUUrLkQQh3is4psGSw9uqQDO0SdkCw5AQBu85XrGVA7vG6fNfzlS
         GmfigJBb/FrCt8IacYZ9X0OOnbWnGf+tWtZoqr+Jm203a98/rFaF/9TvLSgMzG/Hu8ll
         SsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776738074; x=1777342874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFMUe4eU96PwNZ4hmEg9N6ajvO6DYLBIUThz3MnM+0w=;
        b=ZEOGDNK03Xe7e2ep6iM638XNqyYbTkd0+mpfZGNIf6mWnPC6rFA6YLkzPs4MNoLVsD
         6gqWhQmCTjYL1F/zMcRS0QQ2IUK5JnHKOBybaJeXysim7N/4bBWMvpdgR+e1MauqN/kp
         dwA6A6Poa7ijZi/Yi9Iokzd6BVoqWFL1apU2R+C40Q125Lly3jUmxf9WpoPveq0lMspK
         BUfwFsxyjkGo4x0rCh7g/VPXx2kwVIichacktiTWDVH7ywRkSBKClmeuMbryW5Jt9dWD
         Pu/kPnX90QO0Z1nLw9XWQ+tCutw6XNHIsjI9tBbY9rY4YZBBD8fzkwIFSte0GoFPgkBP
         i7lQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2tcToML79w6wG1LxdISlbVnGo0vGEU+mEHgVx0qD1YQTOOLXOa2fAShoq0Kj1TgUsB4MQFLuyDGAQv4I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQ0Z6kzQ5pSd1eUVMzFmv0eg23PYrrvywXq3s0zrBR9AVA1pe+
	H32yfN6sqSYXvisKNOUE6xjLkPchxap7tceQAvllyF4x3Xe+dBQybcmZ2QEJkq553pj0L+QjyLX
	aeh5xA+o=
X-Gm-Gg: AeBDiev3sUKabLixHxhqfXUMhjvurmlAAo2A5c7FvXBzklGfcWgl0Gd6FUFBiAB1l+i
	kqrBD8E7ZRpQ8oPZLNGcysx72OUwbT3CvnrfBQLjdW4+D6oJOtOaUXjFIcXYqZ2y5j5HDcuAPMV
	omtDO36zBDEgCyYrahH8rbs/rNWoj5ECZYncrqon0lE25K2iQ5Yo4P9iWmKkA5UDp8E8lxlJeCG
	sfItV+SAlmCsCsxudDbBfZB+BIuOBtdgtzQt5yiuTzo9IK1XtNZCO9teE1tFuozHizrUAtvDUy1
	RfygWfneDgSBvRNyejr1wwYk63/KuDM1Zi1in9u18nTi6j0R1OVni/2IyajaQdINPBkAOoZRGh6
	hbub9zizdjLCuW8YoNaJk2EL/48gKye8cu4CeUq2ounMd8PmpHR1BYQMW3bP7D1ntB4xEInGl2z
	Cnk+8mfLIkFwTnczKY4K7L9DKJmjwX
X-Received: by 2002:a05:6a00:992:b0:82f:2aaa:c14c with SMTP id d2e1a72fcca58-82f8b5060f2mr13376259b3a.16.1776738073875;
        Mon, 20 Apr 2026 19:21:13 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::340])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f932dabd4sm11538780b3a.51.2026.04.20.19.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:21:13 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] mm/sparse-vmemmap: Fix vmemmap accounting underflow
Date: Tue, 21 Apr 2026 10:20:41 +0800
Message-Id: <20260421022044.1217503-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260421022044.1217503-1-songmuchun@bytedance.com>
References: <20260421022044.1217503-1-songmuchun@bytedance.com>
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

In section_activate(), if populate_section_memmap() fails, the error
handling path calls section_deactivate() to roll back the state. This
causes a vmemmap accounting imbalance.

Since commit c3576889d87b ("mm: fix accounting of memmap pages"),
memmap pages are accounted for only after populate_section_memmap()
succeeds. However, the failure path unconditionally calls
section_deactivate(), which decreases the vmemmap count. Consequently,
a failure in populate_section_memmap() leads to an accounting underflow,
incorrectly reducing the system's tracked vmemmap usage.

Fix this more thoroughly by moving all accounting calls into the lower
level functions that actually perform the vmemmap allocation and freeing:

  - populate_section_memmap() accounts for newly allocated vmemmap pages
  - depopulate_section_memmap() unaccounts when vmemmap is freed

This ensures proper accounting in all code paths, including error
handling and early section cases.

Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/sparse-vmemmap.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 6eadb9d116e4..a7b11248b989 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -656,7 +656,12 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
 {
-	return __populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
+	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
+						      pgmap);
+
+	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+
+	return page;
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
@@ -665,13 +670,17 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
+	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
+
 static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 
+	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
+						  PAGE_SIZE)));
 	vmemmap_free(start, end, NULL);
 }
 
@@ -774,14 +783,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * The memmap of early sections is always fully populated. See
 	 * section_activate() and pfn_valid() .
 	 */
-	if (!section_is_early) {
-		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	if (!section_is_early)
 		depopulate_section_memmap(pfn, nr_pages, altmap);
-	} else if (memmap) {
-		memmap_boot_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page),
-							  PAGE_SIZE)));
+	else if (memmap)
 		free_map_bootmem(memmap);
-	}
 
 	if (empty)
 		ms->section_mem_map = (unsigned long)NULL;
@@ -826,7 +831,6 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 
 	return memmap;
 }
-- 
2.20.1


