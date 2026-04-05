Return-Path: <linuxppc-dev+bounces-19357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0460CEEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:56:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXX71Fhtz2yks;
	Sun, 05 Apr 2026 22:56:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393783;
	cv=none; b=MYM12ZxGDpp/Gf//+MIpkIHzUQGpxRTLpADD9mwH1XuAPnVY9D2qy5Cs5q4RY8RfrW9Wg/Mm/iUpz18jKpq+rQoTC878l/uAUDZBwgo1qn7fZeo6RM0cA6tIfZqvtGRmwpjP4pAc1Xmn4PINOdzZwL7Zofi+N9915a/9Bi9lL3rmUgSVVr86ifyckJu9nFIzsIZJG65YtYw0v5SusM9BWu+G+HL+wxtN576bkA3upbKTfzRwpkdo4837yi+GNp3goxNiYnVgb8XyL3HYp7UaD0qjuPww0rZAQGyN3aUPcYW+eXEsNWq0gNFYdWvA9arClRWogXhHA4I3tyo/mZ8CfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393783; c=relaxed/relaxed;
	bh=i+vulRN5m4Yydq260oUv4yelbrwHrOXM8b9fFHhOg90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fBris22l5bsj4NfR34w4I9XYzpaR6ROU/K9qvu3xTC3No78ACzKD1HW5G91W2fEtsG3mxYHdhVIocF5Yyx4JLXfNlf6TOMaJu7rd6SaqljyA6dC1Lxn4+9jE76XLmQHdzn5Y/vTex1sfOExAOx9uAyj0pZgFry44DaVCZctcKSyvFRxsCdm+t06B6Qufn8PAgA47kv9pvaVZvERQi5lXNiR05/NAZs5uOHronGTH5V+bnfjzlvjMf4QGDJg1V5mCAM8NU4eQ4AxbMi5XyVt7IYYis3qm+3whtKJoLTQySSqSFbJWbWRyFz0geKAjGNxoOgtB49unlyllODf/IQ/WNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Noa295pn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Noa295pn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXX63jhmz2yv4
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:56:22 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso1813522a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393781; x=1775998581; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+vulRN5m4Yydq260oUv4yelbrwHrOXM8b9fFHhOg90=;
        b=Noa295pn/iuVb+Z/IoNHix+uDt7vIAkIDAlFLt4AG2vgz5/MspfLlDS5JN4NUk1Dhi
         kZMen2Zw/QyB0YytM4ff1cL4rw7oNlIMBQ97Z/w76B/N2LtYfQo5O2K1q1gsv3lMJF9v
         oCjm2f1kGfIBUUgJBODb8ayts4RXJiC+mD4xycrcMCZHdxxh7CqekYzu8kSzV8pzt4RY
         PSECFe1cjDzPI8SXNB6hiPJtnwijCt0SM579LWH4S0J2/gVg2jnp+nFpYj5r7wPwPB72
         4KJZHSD/52E75PfssMKaybL/GSy2YxVCkyQgBukzy3LDbsqNL33fiNfXYI1RHeZl6+8t
         g0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393781; x=1775998581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+vulRN5m4Yydq260oUv4yelbrwHrOXM8b9fFHhOg90=;
        b=DbDI/2WMzN5zsuLrskA1MnDaEN8jBpWEcGRwgZq94NzAgNgDvzY5X65c4MIggTKUxx
         LQ0LBRXVGabriRVywmdKm8Bk3O99J1kuhgngwX/FCNR0SyfmGXvUujFm50ghPrfWJgMY
         7X4UrfFLO6zDiBl7qBrLudo9OzCUKRUt4zPUrhpdxedOE+fB7so/JfPZ4z0A2G/Y33HZ
         h6cjXpdgdusFhHZ2L1+SGuDJPswBJnXgvlM6XxNZHeY3QPcmPSikdLNdSG5oHJMa6rwj
         OdopS+bKALxM/1Y7/oGFIOkRlmBqiSZayBQJmTaWsUDkBeZ44Z+bRmxVnsro7q6/u/7D
         3IdA==
X-Forwarded-Encrypted: i=1; AJvYcCX7gvoT8n6f7dRWe83ECX26Q6e3BRCJauqf+kUr24xmtZwRymG+A6gdDP1wY3qbN+0GRlFuPcYZ9M4p8Ds=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywd2Bsb5AirQ4ks2v2IMizKQIGNZ2xOeS18Fa1IuZl9yMFlBUTK
	ecMSv2ZBGkXnol/GxzUGe5CW6diFunHdqlCUPYzWuY15vWjZt1L28IbuERhidPSLzTM=
X-Gm-Gg: AeBDiesx4GXKxmfByjaZiFk3MaJV2ODaYRADSsSWDQyCKyBYUIMF+sLp5CgCI0yqovA
	oPWcb36N2ZxvlxixwF7oY0MuKiyB2DaxRAtdGcprRjCYZ1RR7ruHb4RN6llDBWGoU+Ad9Vy+vU+
	DeiS8cMXyDVoDfoxei9nH8+9XKLjOnzWuPudeNFaTXYEqXcyObAR+v3yBzAeSPfnmLKpJ32YZ/K
	g6PWHX/+mAANgy9BZruJQVxoGS4oLwn/t9AwFny62lpBDdNP3UOUK29HuDjq5EtTUPS1oIE2cbc
	4bLbRkkv1r0L9b2frIGu+qaHQmD+EQAugMl0vkSc1SOcGc1/1MOEzOc4yZoP86kI5ZEJaggmt6+
	0YiXBq/h9JKcj8ZUdQtWmDfS42EB4QraNqtt8KZNoyGO3u0+FxtQp1aAKd5hQOD4eJRqz5STffg
	9LfDCuVlRj+LT0OKlGHSlDhUw3GeSXY9kQ0j9qOJiiNseLbl/NXA0bOw==
X-Received: by 2002:a17:90b:1c10:b0:35d:9f7c:141c with SMTP id 98e67ed59e1d1-35de695a4c6mr8913118a91.27.1775393780469;
        Sun, 05 Apr 2026 05:56:20 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:56:20 -0700 (PDT)
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
Subject: [PATCH 27/49] mm: call memblocks_present() before HugeTLB initialization
Date: Sun,  5 Apr 2026 20:52:18 +0800
Message-Id: <20260405125240.2558577-28-songmuchun@bytedance.com>
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

Extract memblocks_present() from sparse_init() and call it earlier in
mm_core_init_early().

This ensures that the struct mem_section array is properly allocated
and marked as present before HugeTLB bootmem allocation. This is a
necessary preparation for the subsequent patches, which will need to
perform early setting of the section order for HugeTLB pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h | 2 ++
 mm/mm_init.c  | 1 +
 mm/sparse.c   | 4 +---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index c0d0f546864c..27c06250d6b8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -963,6 +963,7 @@ void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
  * mm/sparse.c
  */
 #ifdef CONFIG_SPARSEMEM
+void memblocks_present(void);
 void sparse_init(void);
 int sparse_index_init(unsigned long section_nr, int nid);
 
@@ -1000,6 +1001,7 @@ static inline void __section_mark_present(struct mem_section *ms,
 int section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
 			  struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 #else
+static inline void memblocks_present(void) {}
 static inline void sparse_init(void) {}
 #endif /* CONFIG_SPARSEMEM */
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7f5b326e9298..b47f65425bc1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2675,6 +2675,7 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
+	memblocks_present();
 	free_area_init();
 	/* Zone data structures are available from here. */
 	hugetlb_cma_reserve();
diff --git a/mm/sparse.c b/mm/sparse.c
index 62659752980e..7779554c5a0c 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -195,7 +195,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
  * This is a convenience function that is useful to mark all of the systems
  * memory as present during initialization.
  */
-static void __init memblocks_present(void)
+void __init memblocks_present(void)
 {
 	unsigned long start, end;
 	int i, nid;
@@ -420,8 +420,6 @@ void __init sparse_init(void)
 	unsigned long pnum_end, pnum_begin, map_count = 1;
 	int nid_begin;
 
-	memblocks_present();
-
 	if (compound_info_has_mask()) {
 		VM_WARN_ON_ONCE(!IS_ALIGNED((unsigned long) pfn_to_page(0),
 				    MAX_FOLIO_VMEMMAP_ALIGN));
-- 
2.20.1


