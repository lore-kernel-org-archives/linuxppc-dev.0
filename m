Return-Path: <linuxppc-dev+bounces-19764-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45714F41990
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 11:14:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwdny1QDDz300V;
	Wed, 15 Apr 2026 21:14:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776251670;
	cv=none; b=Pzqgl2kO3jPqj24XdogCWrkMBrLyyotO4xQ5T7Xq6b//Tknb9JtmfuPolYATpvHZA2+FuWe4E6Lu7uL6tH1Nx7T6QUWjPiebRSCzJkGE4edg1BVWS3uKPB2nq9k7pWb8Lx8p80GpxUTTzVPtnozIp7IXsCPxiz8JM9/Etb0pIo4HM0DvLaE73a93Xjc+GiblfKftGe/tcKmkeTB08I5PQ550c8fQoDtTUHaMa2aiaVmMB9dHQEpUBOedfc4Nmx8UciNHGXFsm6yeGLBM+B8fMEmc46QitYhkIFB6dJ5BoTDFw7KDUD2doTZxWda3VRYS7Hirdp/wLY8hoPQadAItNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776251670; c=relaxed/relaxed;
	bh=t2IwsSjULj2cdQGLjgGLVnmP99rI03lQ3ndkxR63O5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLPGMa9Lo4cdt60lAui/E9UEXjMzSdSpdiIyG2Rpm97uhueUFUbw3j5ADZ2vn94cvse5y3tTzPqw6qp2kP6/BzhVqg7uV9AW9+6eyPEAuS3JBfbifR+vqTxp7gSXntsTEQ8G3yJWqZI0PmOi7qGfZ9qHW/4D9ccWt0iYcvaRYAGeLrNRWxSzt2vLclDpAM8r7JkNkoxNryP3evTqp+DlMQTAS7jUO67X5UyaRlCMvcHhMk39s1NN6j2TQTszvivqog0XsrKs3Fa3foteXTngntA8xv4UdxExgiK1Rx93jiF6DO632GM47c57JRBrSYTN+lyeFJ+jbk69SQ2xxMqrKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=j7Bz8odD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=j7Bz8odD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwdnx1mCpz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 21:14:28 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so4284094a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776251666; x=1776856466; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2IwsSjULj2cdQGLjgGLVnmP99rI03lQ3ndkxR63O5c=;
        b=j7Bz8odDboFwges/CzlKXxlCCXugRiJ9E1VDIUSoIJzwsuYZCmN+YPs4QdrWBoCbV4
         965UGETJ+Gy72YeIgsiwVP/1Q6u0cTDD4y9eySEVPbPhUFHEkhyfwZbLPKNcbRv2ZD+e
         KB/iRnyK1cj1FvXfgY2k4p4hVIYRTpmRENC+zvH+sgpqiMB0D2+1ii/gTyLueEZC3rgY
         ePV+zFpLOGjjfssFnXLtMRiTimnlRkgPKR3BqRaETgXc4WFl+BbFImzER7apN6sU2AA8
         45ZOaEuPknx/tRP7KIFv4Fk5iHwP615tUwt7w0wLsBYft1ECHLs9zGyGwvfZmY18e0tV
         ysgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251666; x=1776856466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2IwsSjULj2cdQGLjgGLVnmP99rI03lQ3ndkxR63O5c=;
        b=CjANGwpDtURWws6u8Exn34GxxSZRtUQ1AVt7BSMGOc7gjlKyJJGSuVkh7tl56LT7CF
         y0Gk3n9g7jcvZWk9HaObXKxqe16dO94ycuZ41bAkbOudCwl9oISrXcM/InHPFyo60gU6
         4sH1PGDbED16u4ZHpM5Y/IqefTIjAflUDtJQ5rLI1TJAbMTu0zWdCcXjGSx63NnwQxxh
         DNqssU2d3mpGmvluQbuKqP/0/qbVwsc3BG9wowY58yB9uTnOpxITqlpEw96DkhFReDDY
         g1yykWg8W5P27Ar+/Nv8qQ9D7Dl6KNTXX7WtX5ioAO7ZE7tFjcORI0xDviKJCpphJe5f
         WQvg==
X-Forwarded-Encrypted: i=1; AFNElJ9U5R8tEIULMRKHT5tgSswCoIbjcEgII13zfo1y2OQPmh+6yWVJftuFLcQXT5BAGSPmzZMrYi+m2rEiiIw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzgBhacnRNvrocbbmqitu37G3FjJFzDYJODqyQ4ywO2bKOQl8BX
	AuJvsgqgeKIwY8RWAnq9sITNJiW2BB7OyebAX+fOyp6CeHPr1AYG6xyE9iNzQlY35gg=
X-Gm-Gg: AeBDietX7moUWxOhf8q77UNr3vXjmA8EGD0YoKqXb+oKfw4mr8yM9rS2bL+Jzj3AJCQ
	96hg7PpnLlcA/W/fDLkzTwl4JQyu58NMXj8kjqR/6SyY2HUIcDspC7Yk5e+WXEOq/6ec528ww9B
	WeJ0y4rLqMe2w8uLhgTmblRiANMVWIVndaY6tIhgBBKIUiYp92uIPjIkXj5z3TvAZxh7GVcDBIt
	rwuMfVlAuL0h7GEdzljGBbu+FFBzf6gBmdpfhiTK1FtzauEXzq0GwyXZWQq8DSix+iRoGgMzIo7
	R0qVtlheSSb/tN0+MHnoeXgpy1K6E3mbz+nvX0I9z/Kgbq3i0V1ghrMy2uSLDvqJ6trb6x6dGKl
	9c9kKLr8wX4IcekplDtcuS7gPfrwZrqPnyHQYOYL2D3ujw8ZPkXGIErHPSt9FoftRhBc/F4zxTf
	hyluChn/UrlBu1AZBn/bxgyHHGyG4GSy/HGmGLBeLM4CQ=
X-Received: by 2002:a17:90b:17cd:b0:35f:c1e1:a263 with SMTP id 98e67ed59e1d1-35fc1f0e974mr7643499a91.19.1776251666069;
        Wed, 15 Apr 2026 04:14:26 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b477fd3724sm19509485ad.0.2026.04.15.04.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:14:25 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 1/6] mm/sparse-vmemmap: Fix vmemmap accounting underflow
Date: Wed, 15 Apr 2026 19:14:07 +0800
Message-Id: <20260415111412.1003526-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260415111412.1003526-1-songmuchun@bytedance.com>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
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
  - free_map_bootmem() handles early bootmem section accounting

This ensures proper accounting in all code paths, including error
handling and early section cases.

Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
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


