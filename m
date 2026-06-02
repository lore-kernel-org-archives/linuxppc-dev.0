Return-Path: <linuxppc-dev+bounces-21887-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C57ACD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:12:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV67l0BzVz3bpt;
	Tue, 02 Jun 2026 20:12:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395122;
	cv=none; b=T8ocbUQ2HVzFy1jV2ppoPQS+RM175OKrmLIhLNLXx3hmvvIlC1Vd8WQGkaSJnmBGBoq0/1/JLUmQQQml0kkUCZfKdUY8viyxTneYjjXaf7dQH8IrlVynujKF0ZlIHG1UVa9lEYN/aArRxu9rc9cAl0mx8CrXNznHyoVTG63VW84X/8JB3W5Ub8Vb+ISoqLj5ySEWYtv08OweqaRHsDhpaN0jdrg1jG2yrvl1ViyD8umiQ3nVQp3AchRCqGHQxDOHikkvBiQf/MA8A7M0Hm7Jhcwcsa/G4bZZGaLfx9MNMO058Kn/xIZK0VIEb9L6SRQJ+tFyonxsFL0wsRv7Gp+KCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395122; c=relaxed/relaxed;
	bh=VWUO3+cl7MWVyS5m22bSK5o78fH+CF71Q5m4ETc4a2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFbtrn35eJfh5acIEKAqbxnPRE/VdcxSTZpy6AvoeTMWiZYc7jei1IvGblhlG2qVS5U76PG7eYxVl9UF63pr8KtY+nIUUEfdqh/zcBiMsrZl74x6EeqrcthPkwOXPL8dhLtoD2zVzz+vCnt973kXbngLL2prlDWFFAVivSi0f/ptRm0RXLZZ0GWJCqD5I7PA2w+9IkX8oveiU/YOcIgTdhNaZEj9dI7kigLzvD71C7om7KDCA7G1OtOmw+pmk3pjVJcCX3zVCGbpRDVc49FaEGf4eKi+jnI+zVIFXqef2LYdbDGNS4vbpKw2Q2XslqPkl5s6RDOQy/GjAEJJ23il6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=V6yIWFl7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=V6yIWFl7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV67k0zxTz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:12:02 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c857d04cc99so1334173a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395120; x=1780999920; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWUO3+cl7MWVyS5m22bSK5o78fH+CF71Q5m4ETc4a2A=;
        b=V6yIWFl7nW3EZePoab9Bx7CER1+QkkaQc9NZVhjTFtsOBgGspuVIiTGuN1iE0MrHK7
         niDv5y0x+Z/YTyhxrUsZ5Fwifhp74BB5mIrWgCsz9pbM80R5DRtBYnR0BDSYp9pTxLRD
         S18uYW/INEIf7nuKglDu4h3rZDAMmfX6UMsnW/XMagsb0HipymPvdWmk7QX3yhGR8V7o
         BequaQ0fu39KYHO9fBGtDUz72onDiK4vbYKjzaYDntfnu7YiRod/3NgmemUEuwOPKePm
         cVvr6PaEm+mYS0KzoE0JARkRSTixO+WN7bIDLHiWNF/I1mJxFGx+o0jG7ldTg1Ej5zCH
         WABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395120; x=1780999920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VWUO3+cl7MWVyS5m22bSK5o78fH+CF71Q5m4ETc4a2A=;
        b=oU2cNyPs4MbI+nSw/R6PE4eG5b9LcSPorZEyoofL7ASFFcQo9IuVvOnMbx8wdvfjPH
         u1IKdWrvTUOZTq2btK7GiFz/6KbhJgwefIX8QcQN9Odw/Kd7OltIiSiZEpE0yJfy9zUZ
         PTGPQz8MXMAM6l32od378/8sqDq8vr//M0vF1KmzwZxiZM1UZjRhy+BJ6x4LrnSizu47
         EkvOOdHF0eOMi0CSpEzuN2GBbVBU8t08tslIfVyMILyu+BbhM76t/WtVtwYR9KBDPoSi
         qnBdJ0PCzQEa7VgI+Qbe1KVcrJeG2JqoriYhLyd1zjJ4T5ceae7y92CoZuBUdwztXz7/
         8KnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9O08CD+bGhgcB2C3vmUT1BQcmz4Ei3YgmW0+Gcb66XIujfLzjW5vUXZtTaEKESqt9oFj32UNtzgdKJ8h0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yww2Fv9uZX9fyZ4d86ctvUs5ZG9SiCtVIY1NolzHc5IdN8YPn0R
	8iPHFxkTsvsXUdDvkgqm2y54WiQdphJEJukmIXhhhTACNGQi1oPJPwdTH1cIy2f5SxA=
X-Gm-Gg: Acq92OGB0j2R7cM95pzwhNxjRevo5CqcBhdcGpH6RCxp4MgnNNqBw0SmVhu1os1BRIX
	m+T2Ywoy6v+ofeeE67VRrgh+EWEcRyGq8HO2txJLEEr3CsPeKCkg7/Umna/f2p6puonm1JyupeL
	e9HeqQqWFffXOwi3HRAHZhvWjWYEfILADyRIWIbuVrVmCUUYhwhnyzjqtobcQJoKPLFUaeb8HFb
	E/rT2vc35jSzrrDsAJB8sPlexwUPsVyqWTRSD16ovBPDipCoi4Fl2xzIv+ZcnnmkZ7oql04mWjb
	nTmHuEt98IF3igUogFwBJeStW7rx5/2blGVoIlQwgeoxp2R6F9Be4RQHD844ELLEPxogzRi6zlc
	ch8P8wRFnM3FsLxjBRtH6/yV77RP7XFK0956FEzcbS00krQDUgCm40n7nKj/rTFryJjiVtJsHDl
	z3sFoBmVA7DDfd1Llt4jrK2arllKnfcLi2bR3V6kTno4Syys4wm6r+RcY=
X-Received: by 2002:a05:6a20:c79a:b0:3b4:613f:90b1 with SMTP id adf61e73a8af0-3b478a4a8ffmr3176243637.16.1780395116512;
        Tue, 02 Jun 2026 03:11:56 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:11:55 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 12/19] mm/hugetlb_cma: Validate hugetlb CMA range by zone at reserve time
Date: Tue,  2 Jun 2026 18:10:32 +0800
Message-ID: <20260602101039.1867613-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602101039.1867613-1-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
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

Hugetlb CMA allocation currently has to cope with CMA areas that span
multiple zones.

Validate the reserved CMA range up front in hugetlb_cma_reserve() so
later hugetlb CMA allocations can assume a zone-consistent area.

Also drop the pfn_valid() check from cma_validate_zones(). mem_section
is not fully initialized at this point, so the check can trigger false
warnings. Keep the sanity check in cma_activate_area() instead.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador (SUSE) <osalvador@suse.de>
---
v2->v3:
- collect Reviewed-by from Oscar Salvador
---
 mm/cma.c         | 3 ++-
 mm/hugetlb_cma.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index a13ce4999b39..31073738f2ac 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -126,7 +126,6 @@ bool cma_validate_zones(struct cma *cma)
 		 * to be in the same zone. Simplify by forcing the entire
 		 * CMA resv range to be in the same zone.
 		 */
-		WARN_ON_ONCE(!pfn_valid(base_pfn));
 		if (pfn_range_intersects_zones(cma->nid, base_pfn, cmr->count)) {
 			set_bit(CMA_ZONES_INVALID, &cma->flags);
 			return false;
@@ -165,6 +164,8 @@ static void __init cma_activate_area(struct cma *cma)
 			bitmap_set(cmr->bitmap, 0, bitmap_count);
 		}
 
+		WARN_ON_ONCE(!pfn_valid(cmr->base_pfn));
+
 		for (pfn = early_pfn[r]; pfn < cmr->base_pfn + cmr->count;
 		     pfn += pageblock_nr_pages)
 			init_cma_reserved_pageblock(pfn_to_page(pfn));
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index 39344d6c78d8..ce999391cc14 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -231,9 +231,11 @@ void __init hugetlb_cma_reserve(void)
 		res = cma_declare_contiguous_multi(size, gigantic_page_size,
 					HUGETLB_PAGE_ORDER, name,
 					&hugetlb_cma[nid], nid);
-		if (res) {
-			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
+		if (res || !cma_validate_zones(hugetlb_cma[nid])) {
+			pr_warn("hugetlb_cma: %s: err %d, node %d\n",
+				res ? "reservation failed" : "reserved area spans zones",
 				res, nid);
+			hugetlb_cma[nid] = NULL;
 			continue;
 		}
 
-- 
2.54.0


