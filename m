Return-Path: <linuxppc-dev+bounces-22545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4F2CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:01:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5Qb6Z8vz3bsQ;
	Fri, 12 Jun 2026 14:00:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236839;
	cv=none; b=nOIWEGgRB48dmbzUhcz6xp/9iEgptOrV1HRRAegNr2Uv7LhMoACZbeUcsZClHG5NxG9HlkNf74jcqV6HTeUIM5as6U/4BXxcA66KDxVrO79V3nWrWTZ7k3itZksXp5MiYRuVcmS8jDnEY0Y5a8Mc9VasdQbGz5L1LWcqRzJhfgn24UxlkO16Ko4bIXxcknJlHPRlz2N9/YIa8Se0zrYicgQIWsNV9R9cGDBg3+Nq98IntXkUbkuUcy+AFVOEsRVMs4FMn8fCUoBcpq5Z8mTE7uqSJVUCvFqrgCZoc1Herq8Vj0dAlzrZGTVfiH1QhfSkt91a4KmMZMX994YXlejvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236839; c=relaxed/relaxed;
	bh=jCx1RUengY48xTOlIsoUMtEFNjaipzvLjVymwrQ/1F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGAMmfUdHF12VxkyEk0JgxQeiDjCSopROLMcZjfDj4Si8EaRRBTutVut2SESIssoe8pP/oOPnqoGKsl5VpaO3P+oZe9bZeOG/SUNgUf57vdh17MxxeCg5/1wLvWEzTcR3lP/05qKyHiNHeL0GNy7FwNpqGNjZwZZjaaJNkn/+fQqL48ldlMZ8e4z5ZZnpuR1b+40JOGTviR9z0EFYLpDA7JqSoQ0s1YX8xUrqDA0QOrHSd4JG0fxKnpfigV9f9Nmx0RikcqgXminGudUw7YGW4+A5YUHHj2lTSD8IXrBnpPkgi0MCd0Hi7WYRt2D62xsp/dtIv2NYkjIYVc1VMd04g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PG8OtKfc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PG8OtKfc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5QZ6S2Mz3cJr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 14:00:38 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-84232e83ca9so293369b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236837; x=1781841637; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCx1RUengY48xTOlIsoUMtEFNjaipzvLjVymwrQ/1F0=;
        b=PG8OtKfcyDzT+8mgcMwt3CRv13HvbIaR3pRiS0ibOGPc00kCHES0NHMnrPOI8YEdj1
         arz3nrX34Ln2J1Ti/VcL3cMqTdOW59auoXBw1N32DtJXRvS64e9KTucZBppIiXKwZ2oQ
         /NJEBecPsLnh2AvfyZTrhlA966vlok50tok8D28mTEnx7qxS109U2+PNG+Jq4bgzL6ok
         wiSLsCcUCIaK32x7OtkVaVJbK0U5bOJdgKte+HnO17iLPrL/fei63nfJcF3W9ivetOqe
         4rWaPq2GOJ6pi2sSoM+8uCKssAbl+u1hDtHdhvd2nvUd9yWRIMf5KfTl9KqwLe6SMqHj
         aqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236837; x=1781841637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCx1RUengY48xTOlIsoUMtEFNjaipzvLjVymwrQ/1F0=;
        b=s9xeZnLQGs7YdQkde+qRnoCFwN6hYMyKTgMZvN5uxkdi6WerN+2C3Sxtqv9mgONZyg
         FXBNJu/cukrOsQuP/WreSmaxvlgNyZ9cH0zvgj19PTzlPWRVJ95ihtKjtkMrfgI+vO5i
         QOJQbLGNtQgl9lGnZNp2E7Y/Cb23Fu/F6fHnhsaBB9qa1IK4rsACqrH93fiYLivdHZ3c
         2vmTsf5jJ3LzEeQIP9ChukIolKycvN5t0geCpjdnHLoRzQaFqTaZgH751691c9jmq0AJ
         FFbRESSVcVyK69ZWBy3HqQMIUZ3lvNobwYXIUUaDOEJA6LnZMN52+WQ9W6PurY6IbAXI
         5cNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gGvYcwHB/jb34tyV/V+h77h4hTB0IZCnbpRocgnm+CNWu6k2aprhEo27yCHHeethChPLyB+NBEkSRbq0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyKphgdKJHSrg0BLsK8O7GJ6+y5ICMmWNzB9THQHT6d+YxZPInZ
	OnbbZDRC8REdvJUuklrEh8P2WsHiM+qKfeCAU04HHUlOoKgtaMyZzpWH7l+NNd690/4=
X-Gm-Gg: Acq92OFiQ2BbKSnFPdvkdkZIr2tNFlT5JL1aB7E2zzS/Er0mkhyyCCbQJUc0iP+H4DX
	i0eL2gd1PU+R8AGL0m2Oo9cL0Vrk0j6f0echfvLOz3sQJZzI6NQ1cHdLXBEoo0uBgsITU0QXefo
	7b7qKOOXz0GvI8eAEpgE0FoyX5mnrPZk53tiASOSeyNtEYBDsEIiEIJkZtexZFF6aaetgfJOKyL
	WwxV7NpRoethii1ib1ObuIKi9SjRpewApUU7jT/9ai0qsFPeg8LweKvalwB8ai4DYXXSpPB38dK
	38hjKq+zjFcI5KVcIaSgdnDgzrGp4a0stILCKUtBZT5zTB/cJRJN+H64vOc2pl6s33qLsq0d66Z
	Rk2Wayq+s7nZI6us4Bok0swwuXU6eaTyrlupGub8wImTgvWWu/my/3EXk6Kly6+BbTxQTZ4ZjFu
	ClW/tDkTE1A6tlaytgav8kgLYsfiWniX4xGR9Dzv0PjYg=
X-Received: by 2002:a05:6a00:2e92:b0:842:4f24:f3a2 with SMTP id d2e1a72fcca58-8434ce43264mr1187972b3a.28.1781236836875;
        Thu, 11 Jun 2026 21:00:36 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.21.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:00:36 -0700 (PDT)
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
Subject: [PATCH v4 17/19] mm/sparse-vmemmap: Remove sparse_vmemmap_init_nid_late()
Date: Fri, 12 Jun 2026 11:59:01 +0800
Message-ID: <20260612035903.2468601-18-songmuchun@bytedance.com>
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

hugetlb_vmemmap_init_late() no longer has any users, so the remaining
late-init path in sparse_vmemmap_init_nid_late() is dead code.

Remove sparse_vmemmap_init_nid_late() and its declarations.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

---
v3->v4:
- Collect Acked-by from Mike Rapoport
---
 include/linux/mmzone.h |  7 -------
 mm/hugetlb_vmemmap.c   |  4 ----
 mm/hugetlb_vmemmap.h   |  5 -----
 mm/sparse-vmemmap.c    | 11 -----------
 mm/sparse.c            |  1 -
 5 files changed, 28 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ca2712187147..db9bdf62b170 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2156,8 +2156,6 @@ static inline int preinited_vmemmap_section(const struct mem_section *section)
 }
 
 void sparse_vmemmap_init_nid_early(int nid);
-void sparse_vmemmap_init_nid_late(int nid);
-
 #else
 static inline int preinited_vmemmap_section(const struct mem_section *section)
 {
@@ -2166,10 +2164,6 @@ static inline int preinited_vmemmap_section(const struct mem_section *section)
 static inline void sparse_vmemmap_init_nid_early(int nid)
 {
 }
-
-static inline void sparse_vmemmap_init_nid_late(int nid)
-{
-}
 #endif
 
 static inline int online_section_nr(unsigned long nr)
@@ -2374,7 +2368,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 
 #else
 #define sparse_vmemmap_init_nid_early(_nid) do {} while (0)
-#define sparse_vmemmap_init_nid_late(_nid) do {} while (0)
 #define pfn_in_present_section pfn_valid
 #endif /* CONFIG_SPARSEMEM */
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ee4fbd5fed0d..eefd6b5f9706 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -808,10 +808,6 @@ void __init hugetlb_vmemmap_init_early(int nid)
 		m->flags |= HUGE_BOOTMEM_HVO;
 	}
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
index 0b4019a93188..515a404b66c0 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -579,17 +579,6 @@ void __init sparse_vmemmap_init_nid_early(int nid)
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


