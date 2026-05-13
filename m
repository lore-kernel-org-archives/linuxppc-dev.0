Return-Path: <linuxppc-dev+bounces-20868-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17969CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:10:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv1X2TzWz2ySS;
	Wed, 13 May 2026 23:09:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677760;
	cv=none; b=B8/EEu430jUUnDuR8kN3aej+qnerGnI4ihhyM8E/okYX/6KkQmd6Hsm4pCXDCimKbvfvlekhCSV8KuqeG27wHqKfHcUvnO0OsKl13C2uahsCG0vZWM2oUXESpaaxbbRsCkP5BxUk+SHFQU8Jl0HktVDqe8BCEyCteyKgLQh8gE7rj9wH9Tq1FRcZ2Dbte5/InLTG15GsQd4MwWveW624Lu82N+/wsf5lifvHIFzXevFwdGoYrCPJPv/FvVHTrC+50Tp0LhKGmQTWEdvE5jYfTBm8B3AZ0UNjfPLPT4j9rW3Y5fp4hvVwEr/Qnd0iaskTBT9i91BL8DJ4fnMV/lv7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677760; c=relaxed/relaxed;
	bh=4Fut968wGN1n7g7zLkJRGy6a00PEkBTyJzeVX+ErWGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRp8+hocrbZYPQkuwNb6Lc5VCqYiC8XulvPb035j4o6PwUmGPXazFxuznGz3klFYT4GXL7i1X/zdw2u2PSqw6rbmqg9mZ6sVpTztWP/iNB1PEtgCF+6smZaAvfyGF0O9YfU3cT1q/HXuWo/AxetLgvWojNnB1nesljT7t5AaetqngHabXqNQsE0muRv2DYv+s9qCodhx9OB0nA3iQA16r2hePDK3jWfwCG58fa0naJRe8ZAlz7Hg+bciGUHBkaXVDu6X/z8uQk3ZB/zrTc6ywDBWkFtpYKEAkHfexZfzvwrt3CbsHgnPEqUl2imkUuVWsAkIPA0hA1mCPE5LpZnm6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aDnJIndo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aDnJIndo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv1W46ykz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:09:19 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso67456615ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677758; x=1779282558; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Fut968wGN1n7g7zLkJRGy6a00PEkBTyJzeVX+ErWGA=;
        b=aDnJIndosSLLLpyzoQKTwYM/nhC03iVs0vLyMp/+MpiisivsKWAop0Hj/m922Mg1zH
         SSPhiapD32Iqsy+S/mzf5M0TEHDabDlInIMygj8pUqh+emm8QJVVpkxe476W+B9nrGXI
         h3fB2fzEixumo3R656YxijDOePdAZVCcStRofBCX81Qp6zj/lLZt4eaB/1GU3Qmhtk1l
         Qj3+nAYXZXIQ4lj002/hEjhcV0KeLfn6TpD0e8/gQ3jyAtWUcp/t03CRdju3FJ6i3PQK
         Pofk1fexhWsgv5W/Cq3z9hB15yJtOdQIHhYDpVYRR2wKUR+lNibIXHObAexO3Ln0IJap
         25Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677758; x=1779282558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Fut968wGN1n7g7zLkJRGy6a00PEkBTyJzeVX+ErWGA=;
        b=dsp1TezZx+5UcHq1ftO2YYX8sI5PMshoLExpbRpwBTTiags5VhfHj5Vai4rXi8nsf8
         X8CSPMGarb95p5YWAdkQmhRar7bb0Nzj5HIn2Sek2TSapK7mbXeSEzB3wr30fXOU9pIL
         rxg/j/DurbB2cId8tHWJ53z2IxKlRRSu3xaxHtOhw2HKsC71OIwVQe/0pJQ/OUi2jhqz
         csIEZ17LDrqvvwo0kWat9EdKM7ezOwWd+hVR0ASA+6jOa8NTibdxLfs9zufzhbf+cTC4
         MkzdH7GeTLleGvW589G1I/ktZUDWhamnqSRdd4t9vI9khYEKAZyrtAIpqoF6lSl8pScj
         hfog==
X-Forwarded-Encrypted: i=1; AFNElJ8v9Runv3EPmQ83uH6KSuMo5cccHGiZmP6uqy7IrAGjymJbuxALaRtkxlBHdrrfbMNMrYGHpWRP/2CbFlI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwzOAl2LDIPgEyXTFtIUJaNfIdBCZ91IY7PipS6x0bakf5DoiXp
	QdS1ahtS8A/k0NEsRAxYh0aSWkAfX/Qvw0Ih2IP6fR725ix2LByea+uJfyt2lgEgkpQ=
X-Gm-Gg: Acq92OEJ86kkAmPWz6FuLPI6hjoHuZLYouaI2dJF0ujLU1A3PIsPGkwIy0kHLc7R3H3
	cexLDuLToH200EsPMk6DU+PHHAMkfIZrO5RAx5UT2DhS/GybX9TsAY5lNX723I9l3ty0YV9dxk1
	lROCOyqZTofQb5m5up4ZxpzacHT4aG+5kShTRKZYo9HtXQm/xZhL3Zz6wRH7zAzSox288JixkrM
	sB9juiRCK2ZDCfJ4EPXMH3IdK9NC7fZNpdmbUpXv/jnpBN9MI7DCm38U8iqWpB6vnDMPi+26W+f
	y/QlibBG/hTERDfU/L+rzGLCsCGiuzfRte+BnG6NIQSa4Pixv4VIDoyx8ZqU5d1xsTQJyCL+PH1
	eid8hrLbxvIQEWB5D4EkjEdW5B++rYzktmoGHdgALEsl232fHqnSIZ6/2xojx7+VUFUoeFBEJ2e
	gzI0hsk2UorVe7e7Pr4gP9yKEEaC6cqtK+lLH7x57TMwpV1A1H5OtMbVBcWuA=
X-Received: by 2002:a17:903:bcb:b0:2b9:cd2d:6f14 with SMTP id d9443c01a7336-2bd2f4f740fmr22553475ad.2.1778677757605;
        Wed, 13 May 2026 06:09:17 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.09.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:09:17 -0700 (PDT)
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
Subject: [PATCH v2 19/69] mm/mm_init: Make __init_page_from_nid() static
Date: Wed, 13 May 2026 21:04:47 +0800
Message-ID: <20260513130542.35604-20-songmuchun@bytedance.com>
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

__init_page_from_nid() no longer has external users and is only used
locally in mm/mm_init.c under CONFIG_DEFERRED_STRUCT_PAGE_INIT.

Make it static and keep it inside that block.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h | 1 -
 mm/mm_init.c  | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 6bd9aa37b952..4a5053368078 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1754,7 +1754,6 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
-void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 
 /* shrinker related functions */
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 165b83c9a9c3..c64e5d63c4ae 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -688,10 +688,11 @@ static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
 }
 #endif
 
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 /*
  * Initialize a reserved page unconditionally, finding its zone first.
  */
-void __meminit __init_page_from_nid(unsigned long pfn, int nid)
+static void __meminit __init_page_from_nid(unsigned long pfn, int nid)
 {
 	pg_data_t *pgdat;
 	int zid;
@@ -713,7 +714,6 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid)
 	}
 }
 
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
 {
 	pgdat->first_deferred_pfn = ULONG_MAX;
-- 
2.54.0


