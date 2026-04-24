Return-Path: <linuxppc-dev+bounces-20032-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CBDF589DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 02:56:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1yK953Tqz2yxk;
	Fri, 24 Apr 2026 12:56:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776999389;
	cv=none; b=IetTv31Fnasu7OG6045riCan3tCNWF61MFV+b7Svx2iTox2OzVNX2DUsg9rO78WGk52Vt/62898yoogjS5Ws6bjEKAjFEqZUEYaKQBDw9JUzjvesH7Jv+eadATVKmQGHnRTxFNYRIIP504QE6dwcH9VNc72G2dgmepKuqfKqgbgWQY8ZtYp0Tm+9FaYfbk8l5B28h8kHcxAVt/a30IfN/hUTPCrRsCiges1uNcTBxGH+Bi99E2oM5FwgYkgN+LsyuRs0UY0GzXlzBZhdKwj+wasmD4smXtn7cCJzGEMrUifUmll0kw1wSf1OdvGuTdP4TgxDeCJ8DkpnqSv7QpVzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776999389; c=relaxed/relaxed;
	bh=gorQ8nwUKwQQqSP5JrI9Qb+od9YHCs59YbEIcdvGJzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXAtAehBfEv+iIIFPAiqIXyOSIe5trVLcE8nPorjQ7MmJqNvHooT9lZKDZnRyZZUi8yV1BSj8y8HKm7C9Pi5NUGO3nczwpYvE41dlcW6BMmWLcmbwJyGHLJDqqcG+1folpiRYhen9tNeYSMBeaPWpnAs8m5xFQe6aZSD3D7Ir8EkdqavBjFQuXEomSpup+x2Xuyq0bhPlIl5gkXviVUlHdM3bGd6z7i6sy6zfJEl76v4bOqZm4oDDX40DtIXnVmC4A+2BRdr8+cJcNnNNZrRva7kMiy4wfpHiVnTcy/hVxAU/TQbQ3+Di1tfq2FbFM/EGsF6FB8wyVYS4rCR7zVx3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PuBNGDMd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PuBNGDMd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1yK86m07z2xls
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 12:56:28 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2ad21f437eeso48207485ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 19:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999387; x=1777604187; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gorQ8nwUKwQQqSP5JrI9Qb+od9YHCs59YbEIcdvGJzM=;
        b=PuBNGDMdSj5uEVf1f7lYNxEgd+qqyj4u6Sg8PYjuqoC1R/N19z/bNC5U+QwoVNQGSX
         sRLz6rl/JKXibFAmvkuOfCPkwF9ody6tyHfk0HzvsRHz+lbPannXb+wTKur4T1CYrFsC
         x+Spj5WxpFSmYMLr30JjsnFfEEhtQmBFikal6e19Le9BaxAjpbY2hdcXg1TtugrtRtD1
         CmAmBxnwN1pRtd08U2xDgVDLzA9ENNCcarcPYEpO5QquAxroBlFvTJYNdOkP5Zngr0tL
         Egarp4Jv1qvO184j+H8kt/TU9awcW27yVqkTLt6tuAO1bzhsn8IQXAiE40mUbJC1Vrts
         rkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999387; x=1777604187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gorQ8nwUKwQQqSP5JrI9Qb+od9YHCs59YbEIcdvGJzM=;
        b=S9t8JIrBLLuFNpoFTllsHiOTfep0UW7sPgBo9l+tljnrC+QBuoIUYeu+GJBr1vRGBO
         mXfsliw1OtzoFaPiyeo+B92hO7ur7jxDrI7rhBD5rbq5egzc2+QHfZXWQRs394D/hPJW
         /Z232IcWlsY8O2f935QEP94W+kSA1ax6b7F3gOs3j9CYo3+tuVprRCJn44e2oOFeGq5k
         9JxKSzT2of/1vQ9J5lTUVwx/ExyDyV+1fhLNsCrAgslylPyRyca8wDoJBBGLih6yXome
         UMnRK7lEQ8x8BUr/9qMBluIf/OIwQeigDlHrUygNRNTJUbRK4aZMLbmCn4PKTMTAZYZK
         QqMg==
X-Forwarded-Encrypted: i=1; AFNElJ/8RUvYzk9Ybxku7dTi0cY6vJ6LnQv8GjGRD/bRLknpDn9+HCp1Q29lBwzegaVYNgzSvD8BMub32CM5DJI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyzCW4HHlW/VUDsikiuWyVntucKefCWKieZGrJ361PFEzLRNN58
	OVrSaMzSl8Ii7htUl+DJ6BKFVYzxrm8xGTflgwrq8Su+VxEiiID6RUsJ3YgMVQhhFHY=
X-Gm-Gg: AeBDiesS37TGeD821Pxgd3dle4aghYPjMfOx27VddKl5wpFs85BzcJ8ooALDhMy9JTK
	qK3zaas+h6P1wkgMsButkV55MMEPQ4EvrauZs+lUk/s/oeAx9iEqc+8jxK9zavxAlV+TUpfUDXn
	pzpxxF1824UdLa0a28zzmt+PhiURJhUIvB1wAWcx7zSAL1XoO5kKbuYX0JEt10R5lwVB+YlmCrj
	c7X9NUHNLjMSuPP4FUeH98lKiroTRHcfkpC3fWNGGBheRcieLsGvUUFi+OuXd96I9MS2LKun7lP
	TMkbu56R5SkOE8N4/1smPGJyJsEe4ikI0oQ1KUgDWNVpilfgln/EX9lZ0EhL3OhKsJDQkqa171i
	sz1ujyVQ0r8T6VQAAlzsSDwmUeXFr0zMGgAzvzMzMCg/JlGkyzq+YzrgEvAXLofBqpRFB4oV9K/
	/tvS5cHf1IGphChL0Wjrk7zvDxd5mCXPaX4H0ioKWgXgumfBlYRJI3FfKMtkdUug+nzA==
X-Received: by 2002:a17:902:e748:b0:2b4:5d0c:7a85 with SMTP id d9443c01a7336-2b5f9dbcd42mr277705665ad.3.1776999387049;
        Thu, 23 Apr 2026 19:56:27 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:56:26 -0700 (PDT)
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
Subject: [PATCH v6 6/7] mm/mm_init: Fix uninitialized struct pages for ZONE_DEVICE
Date: Fri, 24 Apr 2026 10:55:46 +0800
Message-Id: <20260424025547.3806072-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260424025547.3806072-1-songmuchun@bytedance.com>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
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

If DAX memory is hotplugged into an unoccupied subsection of an early
section, section_activate() reuses the unoptimized boot memmap.
However, compound_nr_pages() still assumes that vmemmap optimization is
in effect and initializes only the reduced number of struct pages. As a
result, the remaining tail struct pages are left uninitialized, which
can later lead to unexpected behavior or crashes.

Fix this by treating early sections as unoptimized when calculating how
many struct pages to initialize.

Fixes: 6fd3620b3428 ("mm/page_alloc: reuse tail struct pages for compound devmaps")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mm_init.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index cfc76953e249..bd466a3c10c8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1055,10 +1055,17 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
  * of how the sparse_vmemmap internals handle compound pages in the lack
  * of an altmap. See vmemmap_populate_compound_pages().
  */
-static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
+static inline unsigned long compound_nr_pages(unsigned long pfn,
+					      struct vmem_altmap *altmap,
 					      struct dev_pagemap *pgmap)
 {
-	if (!vmemmap_can_optimize(altmap, pgmap))
+	/*
+	 * If DAX memory is hot-plugged into an unoccupied subsection
+	 * of an early section, the unoptimized boot memmap is reused.
+	 * See section_activate().
+	 */
+	if (early_section(__pfn_to_section(pfn)) ||
+	    !vmemmap_can_optimize(altmap, pgmap))
 		return pgmap_vmemmap_nr(pgmap);
 
 	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
@@ -1128,7 +1135,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
-- 
2.20.1


