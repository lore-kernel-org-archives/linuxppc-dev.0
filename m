Return-Path: <linuxppc-dev+bounces-20866-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD9FCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:09:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv1K0wJnz2yRn;
	Wed, 13 May 2026 23:09:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677749;
	cv=none; b=Jgf8M7UTukcihSfVkf6vH+d/RIrZ3iPYCosY5VdFDvQNI6ptO23N43W4SMKYqyCCwTAa5JsH4rxqwxGiZi7rIZmt7r+lQqgf10DP6RTGNhbXHQTxbxWd1xnYWEdVHH4jTM2DtUYI6X9rx+xgHwtV6VV9huAL+DXLPvL3CT280IW62ywtl1ypB8+PwB1SaeZNc7eIpHNjAPT5K+qXylzctVZFWY2lskUZCA24P+ZacFc134aa11ZiWCfIBtgihdZzAmPn8cme2rwgIan8vhMNV9qUVu780t5WbVH0CyxdZas2fuwpgKxQF2gfvIeY6rgUYKxdQEedY++vRck0sw0DLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677749; c=relaxed/relaxed;
	bh=dkeVw3HOR7cCG2HPcJochpzFU9bdzNUhNCW0ub/Qsyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP+oJI02L7T3Tm1jeMsU9KHyYRh+DGwEVCRVUbduqyW4SoAKkd2lMoILNurRI65+ELfS8RO/wXpmJkN0iMj/NrVWCNOln5LHUMFuTcgMoufw5vN6RRi54lsQRG1cq/ugHysgnLhXhH1NxdeXBUM3ZFpPC7nujh4vBAadvNEyCSq4vvvtkaG1TDQGUYcOBfwgCS3LACeI6QHbZtNtbG0tX5FdjInEjSTIXskSeyU7LDuKGhnBjyCvYLnXzDNumQjuxLoGTWPaA/5/YKMTh9TjE8CYqigLVh6KGFgzdV/GykKPqyluvXLLLzx0MgFHQHyJMFSzafj+NV5RquXtcgzkLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CjPulOsI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CjPulOsI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv1J3kTZz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:09:08 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2bab2548e8bso31486845ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677747; x=1779282547; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkeVw3HOR7cCG2HPcJochpzFU9bdzNUhNCW0ub/Qsyw=;
        b=CjPulOsIukYM3DsRRRJoWRhP1pDFO/2ylhE2WspylPsh+b6tfIrsifL262KKMQBBrp
         XKtrVujhD/E9ynF3O9nt5lq7dpMQ23cxYQF11tConr6XyPaHM8EdKp2LKxO0a2SEwvOV
         PL4KkhS2op7ustRHXrHSJ3bnEJuMawM7u/SN7trXD+QQJyzMx/PmO3T/pVLfsa+Tvvsa
         JDStjEjymDAtBPKvS/1xOoJPu9piqnKDiBSIYPkRiveRiUIMY7+1qOcqr7t7kWIOYrSR
         p7TssmJO0vS8XOkf+yunukzmSsffmgivalzUbcvF1MBWfqwQ9CRY/xU02dRdlJgNDdLv
         cYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677747; x=1779282547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dkeVw3HOR7cCG2HPcJochpzFU9bdzNUhNCW0ub/Qsyw=;
        b=s6pWm/80FoQ0Tdhq7WG97XJAUXTCPnkeyiA8Vz0txTJQR132P944Tg1q/0ufkLQrzr
         kAlhX9F1RQTbC6n0K8PyhwkB9TrXY5/ov/NtbMSSkUZMTRBKUeLHcHgOH+YJEklVGBmX
         D++s8H19QTDRjwNkt3T0e5Yk79Fy17cQICJeix9I1G+5p9nDw+RGHZag7vyitj28dJCV
         rSJU+bZEyWKBxOV0l44VCV23oXHE2IJGKT+StBnOAjt1KAlPiZdE2Oj6plCmySUrOW4l
         uPoOihjyAvxMcEjnLQ57u/Zv0QZFa5smE1x6vttisLtFBA30Q/TWdzSxAKa4V2/yOdcf
         1uLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Dq1+waopJZyM6fzfhKZEZUGic8snGnGHVB0wzHrB5S/efCp2yo97pLrrH7yt7SSMP7ZsdeBHvwFuDjZY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyLUpJ40AEqMwJVtJHHcr6xBQx9i8HV8gO4Hu1VJNEh5MATX2vS
	HjUhCx79hdsDLzb5/E+eHUZyPGxPXfrmHG8YxqqdexNWB3KjBDphcfQTAaYQI8CD67E=
X-Gm-Gg: Acq92OHhKUkTfCsGx5+vCEKuYeAG4eApQyL/eQoZbzuYq71LC/XlcsrULDX9euU/deE
	awMYnhSp2JqQrJHPFQXqUeYmIKkd/UcPtAagnmu9XZzitDyffmdc85dfYl2DZRCJbShA1LFKjW/
	5G3rkjDDh6fo5jGnr2oRM77syozCMzTnqtoQ4kaMnKyJu4mDLmDUQwT86Txhiugpn+ywwyz3K8i
	RMW/NSzAGNXGsK/lHUT20CFsj4/uwOVRmc8qm+8kp3VYPzA4jcm/Ur24TLHCGZu6n80V/K5nO5g
	xhNHuOkQ2a2tpeRmt5XdgQecELPy25szV7jMgevBaoGfOwWeVCa59r7oeaK6QfAUkSHdVnxOA+V
	WaP7qjcN/Sbja/snJ2wM1XqlnW8vPC2m2p1yX2UJwDVfFzcgJLdu44kWXVw6QSVJ6QIObqT1ztb
	TOSVUHU+sVxpscc9TyMtrUR6bRieI13vkXMTAuFGGLmZCLZA35zeR3fliQPdQ=
X-Received: by 2002:a17:903:1b4f:b0:2b0:9c2b:641d with SMTP id d9443c01a7336-2bd2f4dbc06mr31387055ad.2.1778677746427;
        Wed, 13 May 2026 06:09:06 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.09.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:09:06 -0700 (PDT)
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
Subject: [PATCH v2 17/69] mm/sparse-vmemmap: Remove sparse_vmemmap_init_nid_late()
Date: Wed, 13 May 2026 21:04:45 +0800
Message-ID: <20260513130542.35604-18-songmuchun@bytedance.com>
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

hugetlb_vmemmap_init_late() no longer has any users, so the remaining
late-init path in sparse_vmemmap_init_nid_late() is dead code.

Remove sparse_vmemmap_init_nid_late() and its declarations.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h |  7 -------
 mm/hugetlb_vmemmap.c   |  4 ----
 mm/hugetlb_vmemmap.h   |  5 -----
 mm/sparse-vmemmap.c    | 11 -----------
 mm/sparse.c            |  1 -
 5 files changed, 28 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9adb2ad21da5..362e16497533 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2167,8 +2167,6 @@ static inline int preinited_vmemmap_section(const struct mem_section *section)
 }
 
 void sparse_vmemmap_init_nid_early(int nid);
-void sparse_vmemmap_init_nid_late(int nid);
-
 #else
 static inline int preinited_vmemmap_section(const struct mem_section *section)
 {
@@ -2177,10 +2175,6 @@ static inline int preinited_vmemmap_section(const struct mem_section *section)
 static inline void sparse_vmemmap_init_nid_early(int nid)
 {
 }
-
-static inline void sparse_vmemmap_init_nid_late(int nid)
-{
-}
 #endif
 
 static inline int online_section_nr(unsigned long nr)
@@ -2385,7 +2379,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 
 #else
 #define sparse_vmemmap_init_nid_early(_nid) do {} while (0)
-#define sparse_vmemmap_init_nid_late(_nid) do {} while (0)
 #define pfn_in_present_section pfn_valid
 #endif /* CONFIG_SPARSEMEM */
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index e2251bc47444..952216a49bcb 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -810,10 +810,6 @@ static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
 
 	return NULL;
 }
-
-void __init hugetlb_vmemmap_init_late(int nid)
-{
-}
 #endif
 
 static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 18b490825215..7ac49c52457d 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -29,7 +29,6 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list);
 #ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
 void hugetlb_vmemmap_init_early(int nid);
-void hugetlb_vmemmap_init_late(int nid);
 #endif
 
 
@@ -81,10 +80,6 @@ static inline void hugetlb_vmemmap_init_early(int nid)
 {
 }
 
-static inline void hugetlb_vmemmap_init_late(int nid)
-{
-}
-
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index fcf0ce5212f1..17d45dac4324 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -574,17 +574,6 @@ void __init sparse_vmemmap_init_nid_early(int nid)
 {
 	hugetlb_vmemmap_init_early(nid);
 }
-
-/*
- * This is called just before the initialization of page structures
- * through memmap_init. Zones are now initialized, so any work that
- * needs to be done that needs zone information can be done from
- * here.
- */
-void __init sparse_vmemmap_init_nid_late(int nid)
-{
-	hugetlb_vmemmap_init_late(nid);
-}
 #endif
 
 static void subsection_mask_set(unsigned long *map, unsigned long pfn,
diff --git a/mm/sparse.c b/mm/sparse.c
index 3917a47153d8..324213d8bdcb 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -320,7 +320,6 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 		}
 	}
 	sparse_usage_fini();
-	sparse_vmemmap_init_nid_late(nid);
 }
 
 /*
-- 
2.54.0


