Return-Path: <linuxppc-dev+bounces-20856-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C790CCD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:08:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv0G1CB8z2yFQ;
	Wed, 13 May 2026 23:08:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677694;
	cv=none; b=P0843o36pjo83Z9bvYEJHubTsDq8Yf+GMCmYoywNUaHg3o5ynu9/lqrF7dYTHAT8iYvhdwT6EqBi23y0mMOGcE6i+ngxbBU2RhfD9xDKKaZr2Nf+rDL0BGsizxS4w2mnUzWHCiiVRcuamxmrmDqLH1cpu7T5DC7cbXZOAwvO7XqVA7OZvLBEGhs6PPtxKPW/ZfJTxXjDrqjvnBJWiyk3MhKelXco4ImvISAFtbFHORSd3rIvpW2q5N8TfiSx6Yx1J38cDTH1p99fmURBhmBZ7c65boIE8yKz42bgGtz/p0Oe20CeB/l6+/WKiy51eQkoU90yoCyNuZQmpc433gzkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677694; c=relaxed/relaxed;
	bh=5UyK7iOrAjDiLiKTgZmma+Goz9i15/Iarg4XyDf9KyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzRgPDwhboxiCl8dVndKHS1bHwZQ32/RDzSAUNA+NHLn7FyFGPLWdsapp5J7zUzs1Yp5yNjg577kcfE4yt0/Q53Z8D9VpVZyFsTf/n083S2aaD/w+pCOfqoI3CK29aKh8PDKR8YST8Fn3UayVxoQJmFFyEd3Al4gEN2FHkbtWqcrF/XSZE0DzfbNFwyCQWo269hpPeeOSyn9eYpvevC6cE0QoJCr1S+CEiVKd9gnwLyRxOov6fuvkNbzityfN4akn4lnFowkkUzZPGjkfNWQltegow+H8uQkLYbBuBR5/f6EQ3u17FFI+DyhWaFSMDFzGyo6+2isJBi4aP0uBp0r2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QzacGz+W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QzacGz+W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv0F3Bbtz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:08:13 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2bab2548e8bso31477855ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677692; x=1779282492; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UyK7iOrAjDiLiKTgZmma+Goz9i15/Iarg4XyDf9KyI=;
        b=QzacGz+W9BjjvDxDXT4a8v4OMyLtPZpud/NwPy4XoyEwmt9pAAsBug5ZfbIJNeA/Vy
         PwgCJXi8QNtkp2xNElRBctJ6aWemFo3z/oFcYf4q0XhE1tVDhfBZudJoMthM2YVJhREJ
         TID0yzCNCvjDj1Iz8WtNqfpR1Oi6j8f0sIlXZGuTHmkS/ijGm4S/ucGCzlm24y39vYZO
         /P6CmaTj0uHcStb2Anms1VjwhAuD33ZC62Jz8bUxqrOYdJ25cmdUzZx3CtCVL2X9MxBP
         yluVTR1bOsYYbhwtOnqGGLVnSkMFatOx5aMwYRJD3qhH2x6fu4uINAQdYdUy92qgkGWU
         3bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677692; x=1779282492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5UyK7iOrAjDiLiKTgZmma+Goz9i15/Iarg4XyDf9KyI=;
        b=Kkhf9eYA6fEHL9KVdOgK9qtUzHf0uxMtRZYD6UxAj2rpPqu6lJaiRn7IpGHxhoTg1O
         NuFY3gwSvmlaCnM2Aa2WdR0lL4fSerQQAgjvwnpiTJoBTA3AR45JZ07SdFx7D45xBlCo
         gW1fjjiQHkrs1mKxm6QTRUL1MmQuPLsvbb4hKUWtrfz3e4uRwGV/ZvVcR2iXWHpFOLIS
         KMZQ6BOAsy8p/fnc85xxgs6milqOYhMBtqGdY++bfLjvt7O2NBgmeefjC3VrlS/jBaOb
         AgdQQZoh0Bx7YokNCaous1MMelyuwaDg59/vYnsiCZoGQd2ejVp+nhP3lmqxm+n94H2d
         SXLw==
X-Forwarded-Encrypted: i=1; AFNElJ8dsO0xWc50x1OZXu1DuMSpy4gpUzJM2i4PZ0kDfa9cFcpVs/yG17GtCcINofCEv9MRaSWTV0gSUGjAhyk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzWZdDMxuPwxg0wRXQkrjxu/TO1vKzXAqpXtFTGHbpscYYn7PPh
	EbXn/odtREqilPQKeQb9CDeHDzmO2dKyaF+t88ycgZLux4xgLAz5+PEGuXouKYDKRpg=
X-Gm-Gg: Acq92OGLjtj8MPGXEy5nQ+GmfVwZX/E0ZT2Up5qSjLEd/5/vLKQNtDDwTKT0wtcMhJE
	1heWayLYAN1H9SCqwMs0eL0rJWVgtojFOJDg8/0EQcFczp26gTqo2VNZC6EzCEjWLpLLmACk8uD
	r1E0FJnmpGHYhwb9/2Y8vO7KaAi8P5bmonnyxvVxjYaIuTDz4Afe03A4+jwwyLZhbfPfg0uzdTw
	tJaWuV7YmmO6Qgn1B4iP8vvRxa6tob68xGV4Qho3ugfXLoUQ1isqW5179Yz9w963cZfoSRcBSxO
	qurE8fCVtSw9BbW17XEqpmz1mD+m+nVnYaNl8W7uOJztE5wH36ktapTqH7Bl76KSBAgvEz7GtnJ
	voltjQWbYzCDn9Bzn9AHp0WdX4jBaONcavx4dRu7bbqbm6lA1rW5+7DkKZwhbN6o+4v2CTbQwnN
	IMCWkT88U/hSaWsMMhyG64+IkYMm4UXymi91mlxyHWMUY0JEvoRsqsNb3G7gU=
X-Received: by 2002:a17:903:290f:b0:2b2:539b:d2b1 with SMTP id d9443c01a7336-2bd2f6071femr19430235ad.16.1778677691580;
        Wed, 13 May 2026 06:08:11 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.08.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:08:11 -0700 (PDT)
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
Subject: [PATCH v2 07/69] mm/sparse: Move subsection_map_init() into sparse_init()
Date: Wed, 13 May 2026 21:04:35 +0800
Message-ID: <20260513130542.35604-8-songmuchun@bytedance.com>
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

subsection_map_init() is part of sparse memory initialization, but it is
currently called from free_area_init().

Move it into sparse_init() so the sparse-specific setup stays together
instead of being split across the generic free_area_init() path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
v1->v2:
- Add Acked-by from Mike Rapoport
---
 mm/internal.h       |  5 ++---
 mm/mm_init.c        | 10 ++--------
 mm/sparse-vmemmap.c | 11 ++++++++++-
 mm/sparse.c         |  1 +
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 5a2ddcf68e0b..28d179cbc451 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1003,10 +1003,9 @@ static inline void sparse_init(void) {}
  * mm/sparse-vmemmap.c
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-void sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages);
+void sparse_init_subsection_map(void);
 #else
-static inline void sparse_init_subsection_map(unsigned long pfn,
-		unsigned long nr_pages)
+static inline void sparse_init_subsection_map(void)
 {
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 96e0f2d8c3ea..12fe21c4e26c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1876,18 +1876,12 @@ static void __init free_area_init(void)
 			       (u64)zone_movable_pfn[i] << PAGE_SHIFT);
 	}
 
-	/*
-	 * Print out the early node map, and initialize the
-	 * subsection-map relative to active online memory ranges to
-	 * enable future "sub-section" extensions of the memory map.
-	 */
+	/* Print out the early node map. */
 	pr_info("Early memory node ranges\n");
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid)
 		pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
 			(u64)start_pfn << PAGE_SHIFT,
 			((u64)end_pfn << PAGE_SHIFT) - 1);
-		sparse_init_subsection_map(start_pfn, end_pfn - start_pfn);
-	}
 
 	/* Initialise every node */
 	mminit_verify_pageflags_layout();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 112ccf9c71ca..fcf0ce5212f1 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -596,7 +596,7 @@ static void subsection_mask_set(unsigned long *map, unsigned long pfn,
 	bitmap_set(map, idx, end - idx + 1);
 }
 
-void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages)
+static void __init sparse_init_subsection_map_range(unsigned long pfn, unsigned long nr_pages)
 {
 	int end_sec_nr = pfn_to_section_nr(pfn + nr_pages - 1);
 	unsigned long nr, start_sec_nr = pfn_to_section_nr(pfn);
@@ -619,6 +619,15 @@ void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages
 	}
 }
 
+void __init sparse_init_subsection_map(void)
+{
+	int i, nid;
+	unsigned long start, end;
+
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
+		sparse_init_subsection_map_range(start, end - start);
+}
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 
 /* Mark all memory sections within the pfn range as online */
diff --git a/mm/sparse.c b/mm/sparse.c
index c92bbc3f3aa3..85557ef387c7 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -361,5 +361,6 @@ void __init sparse_init(void)
 	}
 	/* cover the last node */
 	sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
+	sparse_init_subsection_map();
 	vmemmap_populate_print_last();
 }
-- 
2.54.0


