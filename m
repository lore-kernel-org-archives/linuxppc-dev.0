Return-Path: <linuxppc-dev+bounces-22535-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831CACD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:00:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5Pd2bFWz3brx;
	Fri, 12 Jun 2026 13:59:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236789;
	cv=none; b=G/pmSUz6RQrWuZfasTzQcZ58fwi1KqH8y/Am7KG+s5NBOtVbdv7iVtmFHihB0DoVfw/iZdKPjp+ZLofRaqA61uJkRzVclFRSmE2MUT51vYvFgm5cJsT1lWt6WNpmBlj2rkAwJF5q2pwrGeucReMFk0jmF+6kFzwE9uf5OjO7N1ru/R8y4RACbQ06VYCirOlPZq8tFfRxLHbqzQvjQ4s0eCd2KlMR+B/EtF6FeSN37WSmXbPdkis0RpZonBiat76BBBNpn3+jYXde+uAfzEhVQjJCm7ukV0mkh2oGQznqM55jfBTCJfGUtvkpzpC7MbvMTnvwCT+LbotEKQnZEyqhPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236789; c=relaxed/relaxed;
	bh=okNQn7jBY8GYg30w4rV+l+0LtWk7klxQgPQSIxA5238=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ge8wwpCE4z9/hBtq4x9eJpaMPf7Ff3lO2TX9z5AycoJhNuZuYWzEpNeUZ/gBYnUHGRDf2eUDztwolwBPIPc3bgk1TY+LuAxjfBwofx1eSzA3mW1gvp/p8BNowNvcxkLdmkVE8+oh90Y6zLqe3Ai3NgYocosIUelfzw+YmdTGta0Z8xLtrJzy4ctfyJZjWAXZrf9V1/SfAjtawHLappo+g79lPQdQV81ZRw/3IY019lJThPP47kc4Bnu9Hk1raba7uNHJqVTaLgSen6qJYvah2Ts93MWCDiz7HL9y/G5pz+x0vRrYoECHDDpf8hxL+PyNFMBdBHlzhfBTyhAxHzmUwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QxU3Iurb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QxU3Iurb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5Pc4BjZz3c3H
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 13:59:48 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8423f420455so308156b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236787; x=1781841587; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okNQn7jBY8GYg30w4rV+l+0LtWk7klxQgPQSIxA5238=;
        b=QxU3IurbhCwuP/fNTwYVWAV9qc94y8aZegVvMCnXFT1/J+gfkayihhNdevpuHq9VGX
         cR0M1/ePlBZW3PzpXSORkghuEE/7mOEfII879HbV7RSPIdJoVl5qnT/du887FHcPfnvV
         yUg9g1leEMtq+IVy+OBz1jU5AfXr0DM7x/QV6WUwk3o2bmJ/ttmN2Rr2baoqwr6dkYwP
         FqGIKsum0ERvfLDwPEoB7xhd0kNByiT0KntM0BZZt/STeoQi0CM6+UgytcZuXtV8vLMn
         LsT3dAmoDtFIW/k5nZNNAHSKw3RQQ9KaU5jRJQl2igdKzaIxiNuoIlEW5ZMNDUlZM9Xl
         NP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236787; x=1781841587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=okNQn7jBY8GYg30w4rV+l+0LtWk7klxQgPQSIxA5238=;
        b=RvQW0CsWCZcs3TVtoit5oqG178sagri55yMZKz30OG8DUufBF+FEEIS2p/l74XB8Xa
         rzKzXqWkoDWGde6Ow09QUe+8vI5Ch+9t/x0MnulUjz4xIO+V9YpsedQmwICXX0ukJDAc
         VOpXTySrvnObltu/jIJ0MiSpSopBZwsWiXusCP/SiGNi9ZVAolzu6zPNeaEiVXM54qFh
         VWJM5e7tY8TL7/jV9wiHHVfzffK27mqDmU0kjfzsY55yiC3YHMUo1z/pHftEb8JpMKYL
         MzayPE4szMwVuU+9WzKep651YUgH6KZGDLFLwNxOP8dB531DgXsf/XN28IkotMew/NdH
         igwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dm2hjEGFoVMq9Cqq6ogWY6uXT4HfGO5SGbCuDAyHUtx0a4AhjyditClEff851Q1YNcTsv0+4B/Bt8Cu4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwySUOP2p8mfZEOzHNqtH0FfmSHTXlWFjhqnUrZdvQFtVbS01Eh
	ne498B0pUwS7Y2e8Q2cHZlLpUiw+5+w4Kbc/vnxiKUUM11SwuwZpMVvLmzl2W2/XwFTdPSozSPP
	G/SeX7hEiJA==
X-Gm-Gg: Acq92OGLNIckxiAEHw5NXbmzgupfj5DsqzGgu62tF4sbsT3HcQwemn1o8sf28YZY+K1
	ta/DOe7bHWylzqSZgEJvBrbWTzd0hbhD0EXH8VW+K3hSSMUwAh8QorTWnv4hjXs1JyDwDOpsxzA
	jEIIlT++9e9er/RAOWYJePbYMbGlDV6I7EcF7Q7KWUDc1BqvinHhnG8NWZrJy966C7Yanufm44E
	I5ShWazLQi3f9W1kJ8VifBUFD9My+xCc8zK081a9nTFVrvDnbfOX128NxgxVDteFQiQgFIOoi7K
	ExCMzTHXMCy8gciGxxheFNN1zUIPHlhWoXnX8t1HkEsCqP9GCz+Qjpq7D5lK47dP9MA+xc1q1hJ
	B5AEsagG2fP9ZLal3XOL5ysOXxSQHxe3vKJl3NLQO/PtaW+7+i1umo8sRDIhmRikNp4bcU4lB9X
	R+WbyGVavEpMQKKeuxQvJG9UJlpsHSklvqiINNbf53X2Dc1ktfTERhXw==
X-Received: by 2002:a05:6a00:4207:b0:842:5a8d:3036 with SMTP id d2e1a72fcca58-8434ced1de3mr1125462b3a.35.1781236786557;
        Thu, 11 Jun 2026 20:59:46 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:46 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 07/19] mm/sparse: Move subsection_map_init() into sparse_init()
Date: Fri, 12 Jun 2026 11:58:51 +0800
Message-ID: <20260612035903.2468601-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
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
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 mm/internal.h       |  5 ++---
 mm/mm_init.c        | 10 ++--------
 mm/sparse-vmemmap.c | 11 ++++++++++-
 mm/sparse.c         |  1 +
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 181e79f1d6a2..dccd4727de46 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -994,10 +994,9 @@ static inline void sparse_init(void) {}
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
index 5c7359693ba2..dbcd60a38c49 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1864,18 +1864,12 @@ static void __init free_area_init(void)
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
index 6e09000ed3e1..0b4019a93188 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -601,7 +601,7 @@ static void subsection_mask_set(unsigned long *map, unsigned long pfn,
 	bitmap_set(map, idx, end - idx + 1);
 }
 
-void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages)
+static void __init sparse_init_subsection_map_range(unsigned long pfn, unsigned long nr_pages)
 {
 	int end_sec_nr = pfn_to_section_nr(pfn + nr_pages - 1);
 	unsigned long nr, start_sec_nr = pfn_to_section_nr(pfn);
@@ -624,6 +624,15 @@ void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages
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


