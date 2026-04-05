Return-Path: <linuxppc-dev+bounces-19348-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD44EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:55:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXVx4HMKz2yjx;
	Sun, 05 Apr 2026 22:55:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393721;
	cv=none; b=TxKrQNzkuLjCnj1YinIX1lQ4dACgmfRJs3QVlpnxpTnhpLahQHi1qF1cDsIFrR4anB7C9EkUQSxXMsQ5d74kGnHtoPSPhHbrt5UNNVUeTwdLubap7VaCATRMaIGJJ4NAfWLBEwi49wHXKv3pIaKi9Twhx3/5fJCOEQrqjNLB3cdm2kCqKDeBJD8Sds081OBNyf+JNC2plsRiGY8bhhIgBQnmvrZDg8BfPPpeoPXwdvcyycZNUWeCVJeJi2bGptb0oE5+NA9dGKHBBtIukazzmdzoso5/eGpjDuzoppGVU92J1RGcveXTuA58uZyT+ALQ7nLktxIODkPtpfiV/ELwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393721; c=relaxed/relaxed;
	bh=VJ1CmGSdxm9qljCoiKFVSLrEpkjzI4pVEVcuHUoMZpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUUi352l7To7mXt/yLJKdIbtbOPuKM6Bv90YHtu0K1SbmBETYZdcdLyw6v7GTFKcZA4rYHVlCKB7O0BqKqoln2iNemLbq+Z2qvniM1+JuCcdlkxE/TsNDTRuu+r8ny0JoDkSkN9Uh4KQasHKiYu7ACUTIlHzn/LqLhmR4woA4SIqV0314f8hBuYTDWAtSePFr1LTBcSmMAxheLW/GFcPZtsUCEJSd1JPtEALZ9ptszba6JvGpxS7YpL3SCujB/780c9XIvC5StKAGWAdgVN0Id9jG1SbvAOg88pRC8I3EEKmCwD5+PpxL8g6yzlri6nTZrc/itbcNj00INly5MxWdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hNp3kjb/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hNp3kjb/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXVw6B1yz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:55:20 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so2875369a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393719; x=1775998519; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJ1CmGSdxm9qljCoiKFVSLrEpkjzI4pVEVcuHUoMZpY=;
        b=hNp3kjb/542R8VhHRzaM7JbiQiI9xsplhySBeZAMW1ftqp+bJmFsMlwgQ8T66Fw4vH
         CCBFFJw3Fdesy+ECFfx9uKXJcKjKEFkWLJ/X/Kw6ZLpKHACYaBFEVFV2NBlZfBUTeTwj
         lO7DPdN2kjcbQdc2MEthwuPvU8XJW0Dov6mGYEsbcmN32ulyTttOY1qlJ2jDVz6QasGW
         X1t4I26T4UxhElusi63D3zDW3eomOxvE+q/ngC/LBjK7xj2s6j0AnqLEqckxpsFY3IGt
         9HxOrjqMI81JKiHpARvkCerDQmNyxpOAYOdNHzdlajhne4MFkS5pjFh+rEa+B07jy1eZ
         BOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393719; x=1775998519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VJ1CmGSdxm9qljCoiKFVSLrEpkjzI4pVEVcuHUoMZpY=;
        b=jis2fIUMsnOgJCTykRM7nL6Q5yolA5VHAqW6MHtl04/fARiZGHsyf9IsBWpOEGB5E8
         R8VEFW64wy3UUz4z0CSrXa7B4oK6Rd6z8ZMlAAjk0X1uf8/1ImCV3aV2UVyCtENiYMcd
         mjqruRJ51Wb558U6l3VKZCyaa7JCd8WM+nzFLlqG70UmRpYUo2RdFK1bflmYiOo5NF/O
         rAGYRKNmyKyLG7tubcq2VbsESZPSgXh8hZP55IeuVwdu3+f8DkTagxZRuJuaiKPnX+G4
         0ueEu7xbUNMDBRUVD3DnqS6fEgbWTScEAw7K8yYXaoIii4NcRSag+ZVRncWSehAC47fT
         MzOg==
X-Forwarded-Encrypted: i=1; AJvYcCWn/M1oVDI33HXCKUJpltLV0VajqI7yOfggjBgv1wFtU+t9MafPdcQ3zgmDe1B8ELwsj2rGhDmL7I6GOfM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxvW4za7ytMNNlNhSEpcf1Dt3ScryGE4pp2GViE0Hfk+Uhdnj9W
	3dyS3lLZoDgvFjCu/PckZXySr/PpmlXKtaAldnr0haD5U1p73MD2z6nGPjIB+2Y0ARQ=
X-Gm-Gg: AeBDietfA0MQYTcOJ/pMP/GPHsMaQyZKHgyEnET6BJ4M3tUmfF70lPRuDg31VSQ64hm
	uCHwRQGu9qMivS4vL671Zsq0XYWObxCmo4CRgcheXtKiRdtL3YeGHjJcvKjmjH5KoFiBBhoq7BG
	nkDK7BmChlL40IzCFw1keDYcgU0pIeRfV0gnKIRPbYLLj8tVG9pbkk5bUlaDzxZ+Z9yOgz4Knpk
	j2NwyMtGmKnV/UfJ8yzjJMDONZfGjX8gQmXCj+Lv6BwoAsSzsjlXOawH029m1tJtAH5gtAPTcbe
	sQaZxBdVCeP+GPmnMdUf7hGQWJ0hdu0f6L1rGRCyN/ncGN3RCvwER9E5aooAApu4eGM/PV7YPaw
	tcDNPYOJFqNYSGYb5JzET95pJ01eTk24EL/dq3f0DatKJBwue+VD8KA9hIJZnWKsVBcEsGBmqK/
	Y8bTvXOuhhTtKz86tQpdn+nOCCsTR+OKhgUxz61rUeHE4=
X-Received: by 2002:a17:90b:268a:b0:35b:8d89:7199 with SMTP id 98e67ed59e1d1-35de68ec6eemr8630177a91.15.1775393718992;
        Sun, 05 Apr 2026 05:55:18 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:55:18 -0700 (PDT)
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
Subject: [PATCH 18/49] mm/mm_init: make __init_page_from_nid() static
Date: Sun,  5 Apr 2026 20:52:09 +0800
Message-Id: <20260405125240.2558577-19-songmuchun@bytedance.com>
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

Since last commit removed the only external user of __init_page_from_nid(),
this function is now only used locally within mm/mm_init.c under the
CONFIG_DEFERRED_STRUCT_PAGE_INIT block.

Make __init_page_from_nid() static, move it inside the
CONFIG_DEFERRED_STRUCT_PAGE_INIT block to clean up the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h | 1 -
 mm/mm_init.c  | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8232084f0c5e..a8acabcd1d93 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1755,7 +1755,6 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
-void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 
 /* shrinker related functions */
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7a710fcbe3c8..977a837b7ef6 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -686,10 +686,11 @@ static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
 	}
 }
 
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 /*
  * Initialize a reserved page unconditionally, finding its zone first.
  */
-void __meminit __init_page_from_nid(unsigned long pfn, int nid)
+static void __meminit __init_page_from_nid(unsigned long pfn, int nid)
 {
 	pg_data_t *pgdat;
 	int zid;
@@ -709,7 +710,6 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid)
 				false);
 }
 
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
 {
 	pgdat->first_deferred_pfn = ULONG_MAX;
-- 
2.20.1


