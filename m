Return-Path: <linuxppc-dev+bounces-20914-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6D5CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:23:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvK96LCvz3cPp;
	Wed, 13 May 2026 23:22:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678573;
	cv=none; b=Bfd3yHz3KPw3y6jKHEgTzN0v+4yD8l5KvyKmK2hbxfMcLphG4G7ynPMs8NU//41knA3XZne+54VzUYiU0WyilAhPIhFY9w7b1Xzj1WnVJhknRUumwRrN8QZ0ueR/8B218BpfkUoYanYRH3TQgLNrRO38cV4sVr5zi7a182AdVqEsH9c+QzKuHwlaa7IqXZi9t38yD/zQbepawpa7t6uG87ITJ5pBFsCXcD43LBDardHC2c4pAtKJb7acI4edqL3481ZQ5fY5eKzjAuuL5wzNTdRJNoIML38ghnLs6/WraMG6stSJy6GTQKB8tEOxbNvvf5zZBvyrDofzKipaofGbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678573; c=relaxed/relaxed;
	bh=z+xjNGO48cR5AqDS1JugnvXgVXjO+vzOT6RKvB10/GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbVlTaXo5wD5GGuf3Fqe958Vcvs/QvMocUaoTErGQJ0yOsp5z8EMRLm+ZtqYf2eG0hoKrDWgjpqcAWI4nlpUViSHbDoA8LwiiaOd8NlUAJFb/TXiK7Q9NIdALe3ax6Qsop2aatw6BkxmcSHRCVfTXQDNjNi2Iu1YlRFgl++cBvQhdVibVXFmwKqMBBwW3irEWLgswuPZDumVFLGXl/twlRHuq1fN6wD1TCQZk+Nq64jYVy8W1O1NcSt32aEUfi7D9a3tUYC2S0ka/cMZBhmXOShhigzePp+7N0C31k3tD8sVydOiJD98fXgNyPaBDuy0NlC8QYXuRaMIt4CYhREWlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VZVjICez; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VZVjICez;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvK91JStz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:22:53 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3680540a6efso2536486a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678571; x=1779283371; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+xjNGO48cR5AqDS1JugnvXgVXjO+vzOT6RKvB10/GY=;
        b=VZVjICezV0YFyjruwGfWwhcI9XKsM5t+FyBESVrKVH9dgb18kCKtyNaG9V6beFaX1+
         VRA1zNm9vMnowSkzPOVGjPGzXmmMS8/4oMYRzgE1t9qFQm6Tl5NLwFrrz0tuLXEqYSXM
         iqRyJc5bN84kwt+XDBYROfBFeS+ZdxtISTh/6NY/8+jYOCOYIfIBQn8JyvwmAvsXUTbL
         PwghUkLATlybH6uwri32iDU/R+i9jv9H4r1jgL1Bv8Qbw2ZUr7UcI2YPTxY7blkhsjXF
         BmqPxXIQzkoqPFuq/WjqQhiIDWn6Bz+8k60HH3Mux3CBGgaI8U9iwdSc5lNcd9S//ty+
         ftkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678571; x=1779283371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+xjNGO48cR5AqDS1JugnvXgVXjO+vzOT6RKvB10/GY=;
        b=WxsI2+iBEmiUVTBj4I6saBNrWcR767pKIavYWNl/AdXCMe/snhwUxBaKAm7iIzscA6
         MF1zOP8eFrGevs0B4zq9RfH6PnuEHJ5EFMw8Jr20XvXsFMV2IhbDPAAvnXe/IZAWXvEJ
         wfEneJD8OHyKaGDr12tDUN6sPPlcaHJUe/NNTbnFO4As7oKvEeAnJd2BshQVsQWudIrU
         A5/f+e6kfAKqWUKIRz7YrYZdT+3k9aWWxS4eStDVVOV9Da8jzINa/8eFx9Hrslw+xz8v
         4h6y7p7lgpSk27i9yZi7T2rUT+OUcdvVmSG8vQ2xuuNrrgvC8IQ0tB/Dp5uAqZN28qro
         Mcow==
X-Forwarded-Encrypted: i=1; AFNElJ8/IShliPxqj/6+VjfHyAiYZpYTn33P8dY2bdx09ZVDlPxgT8ahCXOMWVbkHF/VJ1qLbb8clNaerUSRR74=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yznkumy2l9J0WNn6MFMjEaXtRmuCxyjFoSOHqvL/3IB2DIPpxuo
	gqdFWOfNSsW2sE4K/XegqRtGETVrQy35Fz4IAM8rJPqRpR7EApXRJUGFgpn/MMqzwJc=
X-Gm-Gg: Acq92OE/PEG5ceAUn6+8c8lYZEAKOZwuAl8l/gSD+fFl56DLtanDPOw2tLFKfb2L1F0
	avrH2VVAIuqKaBosaF1PjVGYIFIIh3p3pMHFVNd8iEtC/yHWBCjTH0Sfj2Nk6hczgZghtPZhQye
	Ih5WWkp+R9gozM8htASr8q52Tv7rGR7vFvLATqmerdoHlxyOwUM62Fo5+7s9WN/65ip5IXkS52E
	OWqqkwmds3klpg74tHO7Nfh2YNZPeiNSwEK+z8B/T6HDGljHpNYaSFZU0UEbiQxp5BqTTMhGVOz
	FJuXjOmRj/vsXdtEBkZaT9SMlWprrPSfFCpN+HCuGKjE9LXkswKqp1kXd9C0mgO78KJO5t7qb6y
	eZQBj0dFrbbkVXSx8OcNJL/pTu1BQDS1AqlKieF8k1JjORL0+sLLRUYhKw3hC6yZ+BhYaTCy6P/
	WuCj0LSaQsOg/RGkuPgRAneDRBnTElet7IkxPlx2/SmoyNCo9ej9Ev6bPX2ahI
X-Received: by 2002:a17:90b:574f:b0:368:6159:980c with SMTP id 98e67ed59e1d1-368f79b61camr2563736a91.20.1778678571207;
        Wed, 13 May 2026 06:22:51 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.22.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:22:50 -0700 (PDT)
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
Subject: [PATCH v2 65/69] mm/mm_init: Make __init_single_page() static
Date: Wed, 13 May 2026 21:20:30 +0800
Message-ID: <20260513132044.41690-19-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

__init_single_page() is only used within mm/mm_init.c, so make it
static.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h | 2 --
 mm/mm_init.c  | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2c67ae25124b..80b9ab594dc5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1791,8 +1791,6 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
 	return vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte);
 }
 
-void __meminit __init_single_page(struct page *page, unsigned long pfn,
-				unsigned long zone, int nid);
 void __meminit memmap_init_compound_page_frozen(struct page *head, unsigned long pfn,
 		enum zone_type zone, int nid, unsigned int order);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9b23c31db8c6..1e11fd683292 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -589,7 +589,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 	node_states[N_MEMORY] = saved_node_state;
 }
 
-void __meminit __init_single_page(struct page *page, unsigned long pfn,
+static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid)
 {
 	mm_zero_struct_page(page);
-- 
2.54.0


