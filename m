Return-Path: <linuxppc-dev+bounces-20119-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBB1FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 09:27:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3Lvf6nwJz2ynn;
	Sun, 26 Apr 2026 19:27:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777195662;
	cv=none; b=AVNQmuFgl5pPmkJigGFnPkhIWk4IL5rR2y79BfMHT2sSmU6o27GOgBmL8OXFqVBrK+j7E96LsDI2iFjZ166lZVzzBHGKdEGnAH8V1mKN2AhQk5REPqwzd1i1jrJi1oi4XSD1aOPmPqROxDzjEGWi9kfUI5QP86hYYhJ3c2C5FNpVpYUScpaprzX3gGL8x/4LupIr9akhD1jeEUM3RNETH2xkCBZSArRNmzqhBHvrxjf/GdVmXrZjVP9aq1Xb9AgbPUB13GV5jSlGwE/b0p3V+ETh7lDzqVNzf4QHCxKlSNlFchG9yPeXTXji1RQwnVhaZ9K2tLV3vIGsnl8AFuVsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777195662; c=relaxed/relaxed;
	bh=sKHGjwyqOWL6rVsBt0Sw/YSvydX7Gt+2C2Tpk5skGPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bur3PPK25bcNBDQtnavt8d42ShHm1RH9wCW/b3g3+PpH+jrINNrs3d+5DP1/2XaFonzLS1Bh/1b+1gwcV5lTivjs9ZX0Tj6fn5AuyDztXzMxkw0UKEFMoIDJCDzJhA1Hy6NucIjq/Fnj6RJmWQKYAX01pZgsC6zu4RtocuTsjnyARGcgNpRfDCIQjcj5K2zWkjeGuGFxpI8HGg1cS4fXGACU4eFmEcoeYgRvPXLxSXNT9TReqIigs2mms1wJ68Aw2gYXa3SCZUCpt1yDec231MaHn0Gec8TRPD/pCa5v8NZkMveWHmogRtl8kbW+hzkRuL0Ecf0gzL0r2KsEL8//7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Jsx+OURj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Jsx+OURj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Lvf1VWrz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 19:27:41 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2b23fcf90b2so88170445ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777195660; x=1777800460; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKHGjwyqOWL6rVsBt0Sw/YSvydX7Gt+2C2Tpk5skGPU=;
        b=Jsx+OURjxkcE8Q/0HjFQ9DfSVmGbnl2VOhnnUzawho7Z6cfeJXUtyJsvSB8TjJxcCY
         tcvYE9t493uAZXn1SAIzQQr1B6l2MXGcUaEqfvooYC078kB2O4hvFt8oAZ2kRLo25ozX
         fJ0CWUjAgLcrLeBHpI7FDPE5xwXPHeGAmJI2+K/PAawD+bdazdwTExSV5U+fA40Jwnzy
         Mb1tQ0AEW8HUdU0ZhM5y3of7T27LJSe+NH0rMkUEfitO51zQ2Ak4tTpzia0HFN+hT3jc
         MrfZHKgMwXcchCmAwEb1LKTrpO7Z06hVql1xb7wfn+wCMVffkyVo/SupyirQMvJ+dz1G
         LsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195660; x=1777800460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKHGjwyqOWL6rVsBt0Sw/YSvydX7Gt+2C2Tpk5skGPU=;
        b=Z/G7cLVtuvZ4ONn5uCiiRHuApzSzGbW5W9z7thmcm2xb3xr5x2dPUbBg5CKWqeOHYn
         2xtNRRhn0E2AImroNNIaW+o9MHGH6TIMbWI/dN0rjcaBeVMMV3VNqy2qlqrYw3Z8FZAS
         CcQ3fk8XRW36p/x2lRL0nDkow3gMV3BYNqfnqV+C0+t/JCdT+1fIODF38MU6sGDPtOZh
         amyxFoDX9JNENI1AvH8mLp0vAiIYOkNLZIOBiyQlgec/pkNpLKwsEqBo2LhPZ0oDNt57
         X2XtCTqTL/YR7NvYZNsmFHWGvv/YRFHXSVZgVsiuHx8i3GslnHjawyf9j3SLlQOw8Yh6
         OJaA==
X-Forwarded-Encrypted: i=1; AFNElJ/3OXVwM+YetZE0Rlp2TCs4MNJ3x1sNhw6C+HuaTvdPeq4pt/Ej9JHPPLHTP9xl3WExdwWTmAMO9HhRiCA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxRktM4fsEPYZksx7JfPUPFz0NMF8l6Uk3SYOFT3VnKD4WERObd
	tWmmOiQmCU+m0BC1ZIurWys0nWEU9RJRceC/7gq5tn6WOAzn3hhgf6+bG1jimfqQAMM=
X-Gm-Gg: AeBDiesK29n7sMtEBcTicbMvw2JWm1Pzf0fnQTmOpr2MT64fDcW3I3kPLd7uV96O6RL
	je89M/h2NIQtkrhdA13Ny6y7qzuH/UCZXUwWGTELePhfLxV5/3FiKcEtHCYIWRCc9vczucP4/Jf
	2JW2v+fWKOar1a4ra6rkhnfQhx/TLoF9Eie5j/mca8SBk/P4LkJw9nxXOX8BTJ7h+5q2togTcj3
	M0A2xCzokX2pMobFxv3HD3mxtWwDgv0a5pOfxgib/IzKWgZHtIOlaT6wdQDAyLRXIDb8qRmQp09
	BNJMl3cCpYZbYJWFzp27WgiTIQ2sV67EpX/ZotjQs10HA3DcLKBZ6WROnVdA7x+fUqFKPRVaKUp
	kxehId37m7k2Ac1bzdUzgdecyD24/1vIGrdfcvO5pFTpfscX8VQpJfV1sMbz1qaGFB4sTjIynzz
	fm9ctmyn7w0lGLv8S38FtDYnIdbFWi
X-Received: by 2002:a17:902:d652:b0:2b4:62bd:ee3 with SMTP id d9443c01a7336-2b5f9f5eac7mr310134635ad.33.1777195659828;
        Sun, 26 Apr 2026 02:27:39 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm270352885ad.40.2026.04.26.02.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:27:39 -0700 (PDT)
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
Subject: [PATCH v7 6/6] mm/mm_init: Fix uninitialized struct pages for ZONE_DEVICE
Date: Sun, 26 Apr 2026 17:26:40 +0800
Message-Id: <20260426092640.375967-7-songmuchun@bytedance.com>
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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


