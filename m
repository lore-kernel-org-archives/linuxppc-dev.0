Return-Path: <linuxppc-dev+bounces-19341-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444C8EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:54:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXV56ZVvz2yqT;
	Sun, 05 Apr 2026 22:54:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393677;
	cv=none; b=ir5GsCrWMgearSwSytF8DBjSEoXaRQPfm/WKbaIoHszOPGV8EacTSaEbbuAtB1O5i+eVhdCb8Ir/q9Qqe9w9EH4+Lmdi4QGnc4sApuxb9Ymoh9uCdJT2v4Kwa5bHSMuKdIvbrgoaNftWNCZilxnqXhhV5ApUB7eQgCW/azzBCJvYxPXQRh70IQWGz/caxS/qo+mzd/t4ofne8xiITqpM2mtrBsIzKdxGNISGSNbyIRqBnt/eMswO0TEbk0DSQdP7/aTHITqJSSY40N93f8OtbpiHhXY8ZNgiKcMNJ5aNOM2Vlbaa0FDiHluotccvUtG+gdO2eGTEF7baGtaE0aAm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393677; c=relaxed/relaxed;
	bh=kuz46CNuL6O0+N77LBKvrgQNIe8WIqaWxa3OjXOrUz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VuAx8x+W6SUeZNji+6oE0/LAq1b8jqdSRSURCXFb77edz0SspGPGc3zF38+UtPz05Y+SJDy82yCXzixC5EZ0iGUfIqqxyAVLV91c/Ypjth2j66NeY/ryaNoxheHl/vyzpq6fJghjiQ+4ewLL+mA092VB4bECSZyIczDTFlL+iko6i+l/jvYzPw3w9lVujTK5yI75zxZNOMdN+DW9PfYUNThjYbVQs/UhA5vQVTBr7D2nrd1pcUl+a5AH3ASQAaeeQh6626ZUCceOfdqkvNAR+zra5PfiKREV9PcC4Q+OLPx1kSh1NyXsPxG67hqNSmsdFC8jBf+VNy5hhBe4K4DU4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ifMLwWJW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ifMLwWJW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXV51F7tz2ypw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:54:37 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35d95017a68so1680826a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393675; x=1775998475; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuz46CNuL6O0+N77LBKvrgQNIe8WIqaWxa3OjXOrUz0=;
        b=ifMLwWJWGw68ZdIdriJh9l/EpbK32ZiyRhqHyjbTltktw6raaQtqSO6am/ZwUzIzWv
         NnJO4P1eKoefhJATbU6wlkJeX5xFxoVUyS1x69BeVbevvepjuu2EcwR4jgGTN/ewMKd7
         8c93bbwGFtmAVciULsNLCJm9JNbDN09nlpGB2rQ7PGgyyRSwcmE2DW58gJlaS+sKDmZG
         CeMwF3LSaL3Q4DFqagcCq4w8jydpu/LZYrSIDyDkWBUL6+p2VMfopc81Ba+FrSkZUk2k
         A/UG787Q0eR06aHIhUHb7Iu1oaRZTv41j2x4svjg+mgj6ZC5IhBFLvaxbM3Si11Dy+4f
         56xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393675; x=1775998475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kuz46CNuL6O0+N77LBKvrgQNIe8WIqaWxa3OjXOrUz0=;
        b=B0MUedczzd9aR8XUpEJocHcr5e7LdM/FfH7PVnbxHqtyT+XX97XYHCr6knNPcgssQ7
         b0ICzjabZWtvI3RgDzTPqqGK/euXaVfq95X9D+E2SOMtShAejcQNZeDy0GYFOD+lAm/O
         vNgEAJush+sNIQAFI3uKHJBOQ4OoTSZkvoNntOiDeAJpKB4I72dhEM025WwMwGAfQF7V
         iURlSper1voLFfPeieow3usPXgWLSCs090dtd8awYt8VpYiB0ajTi9pfFh4by4fpm8A3
         vQYnAag73Urew0SOV7+BlueGlO99U+/s2/zNg/KYQURgRlsoO7MUX6KL9HwKKh/4+krL
         W6wA==
X-Forwarded-Encrypted: i=1; AJvYcCWmQ7BiqG8lHozX7SroIoRj0/GXHwpwFmUvaegVl8VcOeCtYPpkW3NYLu+ZKUEA/phL84NLwmkxtcBHk5Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxtFkMmfQS41uxz15Rr6n7hwlXyUzc60sqRW1qvyR3XUTgwGR49
	L+ZZu3KvO9psjz8dqt9eE3/kACTaEtXgh1p3j/qsNPNmkU1MRqdsg+Tes8AtaJcP2SI=
X-Gm-Gg: AeBDietW2W1otNRVqK2wLFcJ8+YqRKp0yemNZTuSYbfXa0gs1YyoWqrJuXw+xnvFaOD
	xCq0qZPwQYywjzT/3ZKO+jBVLpjBENnmfHoVJjcpHpgtETm1NGv3NwD3f8yrhEwny51R4IabD4V
	bNpur5YZCl/3p0/qN12JZjF73iu5oDyT4xc+E4b709jeCvmY+XNFm52wwvW/NHLGOqfq+aNfQhr
	obByQQKhZaIsZBtqLiImoeK7h3vtKmOxei4vKyJzlOJL6/hS2avvKTQqx0rqqNwoG65ono0dCQL
	gwimL5VjYRUaqGiw3F17UYX4o4EuxKRsrdn4eH3rCAocGXPmPdPT/FrXSER4fHmvXHqK3mYWdQV
	+IRv7ghslrwIutRF91x6Mz8Bv8VyvVRsMuSwfa5V5LH53dfdI8fqUI8+PyjDveXLnhqu2U2IMMV
	MSnREBJm4dOyh3tNYDvvxSuGRmDX1io4YAfy0l80/mqvs=
X-Received: by 2002:a17:90b:48d0:b0:35c:a8f:5c5f with SMTP id 98e67ed59e1d1-35de68655bdmr8575177a91.8.1775393675104;
        Sun, 05 Apr 2026 05:54:35 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:54:34 -0700 (PDT)
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
Subject: [PATCH 11/49] mm: defer sparse_init() until after zone initialization
Date: Sun,  5 Apr 2026 20:52:02 +0800
Message-Id: <20260405125240.2558577-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

According to the comment of free_area_init(), its main goal is to
initialise all pg_data_t and zone data. However, sparse_init() and
memmap_init() are aimed at allocating vmemmap pages and initializing
struct page respectively, which differs from the goal of free_area_init().
Therefore, it is reasonable to move them out of free_area_init().

Call sparse_init() after free_area_init() to guarantee that zone data
structures are available when sparse_init() executes. This change is a
prerequisite for integrating vmemmap initialization steps and allows
sparse_init() to safely access zone information if needed (e.g. HVO case).

Also, move hugetlb reservation functions (hugetlb_cma_reserve() and
hugetlb_bootmem_alloc()) to be after free_area_init(). This allows
hugetlb reservation to access zone information to ensure that contiguous
pages are not allocated across zone boundaries, which simplifies the
hugetlb code. So this is a preparation for subsequent changes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mm_init.c | 15 ++++++++-------
 mm/sparse.c  |  3 ---
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5ca4503e7622..72604d02a853 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1807,7 +1807,6 @@ static void __init free_area_init(void)
 	bool descending;
 
 	arch_zone_limits_init(max_zone_pfn);
-	sparse_init();
 
 	start_pfn = PHYS_PFN(memblock_start_of_DRAM());
 	descending = arch_has_descending_max_zone_pfns();
@@ -1896,11 +1895,7 @@ static void __init free_area_init(void)
 		}
 	}
 
-	for_each_node_state(nid, N_MEMORY)
-		sparse_vmemmap_init_nid_late(nid);
-
 	calc_nr_kernel_pages();
-	memmap_init();
 
 	/* disable hash distribution for systems with a single node */
 	fixup_hashdist();
@@ -2669,10 +2664,16 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
-	hugetlb_cma_reserve();
-	hugetlb_bootmem_alloc();
+	int nid;
 
 	free_area_init();
+	/* Zone data structures are available from here. */
+	hugetlb_cma_reserve();
+	hugetlb_bootmem_alloc();
+	sparse_init();
+	for_each_node_state(nid, N_MEMORY)
+		sparse_vmemmap_init_nid_late(nid);
+	memmap_init();
 }
 
 /*
diff --git a/mm/sparse.c b/mm/sparse.c
index c7f91dc2e5b5..5fe0a7e66775 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -406,9 +406,6 @@ void __init sparse_init(void)
 	pnum_begin = first_present_section_nr();
 	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
 
-	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
-	set_pageblock_order();
-
 	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
 		int nid = sparse_early_nid(__nr_to_section(pnum_end));
 
-- 
2.20.1


