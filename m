Return-Path: <linuxppc-dev+bounces-19343-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19810EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:54:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXVL67KWz2yqs;
	Sun, 05 Apr 2026 22:54:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393690;
	cv=none; b=WXxzQsCAzuhIGiB2jJtAeulNaNTG3Z1FGeSPLL1QuIhSnIgy4oxXaG/YrDA6sNNoHucqLTCwVh/f1b3yEVBau2oKpsGC06I4RV1DKrtILFgv/veY8TXnxx+f1yr5Mmt9C9R2PC46M7oE/xvzO1vvaLje3cLx8qpnzIMZ8N+BCknoe6Gr9uvVw0/su2sTNIIbuagZR2b8jVlfrribSdUJHO9mQj2TCAkmDiXwnZwYFoVLb5PbSmQXIDEXaz/vIvHUH3FXfC+MFGc0s1hfS9GwDoxQBL5L0Nqq5mSIWV9+iyBHtc6TdEusp5nUX4lOB9uP6e7p/dYZm325/OXzZhImVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393690; c=relaxed/relaxed;
	bh=HEw5DKlzSRjrYp6HmZ+C9u13Pw0NEEG+M3MgilG+TeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWkXpk3JmA2T319GWJ92OF+yflPUJINzzevptmEfk3wXgD6saMnzipFohz7NhEqN4XZCsJAgb50cw6UrJBAk2wY5690gc1On2On7jgW5N1u9HaI6Sa03ugP9ycaLODoFovneE3beLz6onHtkk6ByJUB1jhIXmMqyDgMBXm84ihSkec4334d9o/D3ui6BwoIxu1fRKUeDcFwANsUgouaiMThBQK64+RCYGhaLtCSgu+esqdxj1dRhyWqGO+3ZcXnDskLP5kJAe1gSdUHliq6DWoR9ALJ2qiNtpxVVonym2YlBkmjQsIJ4vgBaBZttYHvStgVejEMj7CDxaN1O4CslxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Ar1A4Yy7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Ar1A4Yy7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXVL0xLWz2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:54:50 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2190911a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393688; x=1775998488; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEw5DKlzSRjrYp6HmZ+C9u13Pw0NEEG+M3MgilG+TeA=;
        b=Ar1A4Yy7VPdjeeI/3G5CFD+cDo8lUZAOBNOEy7zXkKMuBzGFDHmJrnU9SsVe9Ey7XI
         3imQpHJIvVMl/K/sQo5F4yoM8MeU/aGpskczml1WhbSqHZjWYKADamOAX7r81sfL/M8G
         8FCOcYk441pkO+orouGtsZISmOw0q5hwlyrsiDsFMA0F2AUp6UOk6kbJay6VjvBdMZzO
         l7nM+F5SWKa/l93hMfAbPzaEkTIfwdTY6U9n/WRJqe+5rSCqYBs9+khXoebpIvu1AdPh
         5/soarS2q7bXsPKYXuYc1fcKK4+zFfisBnYEqUsZUej/+GKFmS1g5vR/lf1qVxW6SBIA
         Iu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393688; x=1775998488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HEw5DKlzSRjrYp6HmZ+C9u13Pw0NEEG+M3MgilG+TeA=;
        b=tRmBdBTFGgp7zCXRlAB5EtQ7k1BBkPkNgdB60JiHkju41qqqfxenOYEWlNX3haWxei
         CQz6qYUXzhxsC5t3AF1W7txIZhbIiVAELYReoztXwD2BaI9kJnFTCHqQ2JpgYbsylNqd
         KJ/us2HRxBHy6/oeLjxta6Bn8xe5SCYNXxcqIjlzHO2rdW3c2EHRn/PumzJr75g/ar5j
         kkfDrXwmq4lHHaqJIUwdhBHOi5lokIL28eEibeZFy1ShpxvA8+g2ow45SzBkCx/81LoM
         2zaVU0SCQYCRrDquLN02AT7iF0+RFp3BAo3dOGII/AGr6XJNXIl5Mi4CfVyKV4sSX3lY
         sNTA==
X-Forwarded-Encrypted: i=1; AJvYcCVztS5T/CeIuzaJzZ1TqX82YuYi7rb1xnXXDlDFBTPAQNP7xqgxLbvPdDXVDzbsWvTLE5pr8DSusZWI/C4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxg76dw1aOg+DlQTMhPgwgbC1ycL98fHqpfd3uGJ577DKKbL3TU
	GZ5tNbjDdLscII8rlYcUOglYmFcxmxgzSw6yBRe2yoWPj3jN2PV5M1IoLqPADu+ZxSc=
X-Gm-Gg: AeBDiev7g7VPQFIvy+3pwE5T2nUrUWbCDt/mtp1kcbFYeAqq9FyPNh21O4T7PxWcdBb
	G0KbHA/gz1VlLKGgl0TRZAKNpsL1y9PrtMi1SbG749hLkBbXEERt4XInxdzeNCgDHSClVXbCymO
	GVCRtp7x2U/+8jKYD7lJrescQCP+1qvi2vJnto5SVh5r21jsLQBELX+U3LDEpBb4/MxXWK2OwSG
	/Vy3L3Lo33vovCbZ7CZK2zTaRAUXugO1qsL/+MYx91U2CmqkqSq0t5vbhLJZSvh9r8CY3qXUjhb
	wJwsaylAEXGcxVbbx0zzxbR/41LGtNaENyLaWSCFV1OvDrUtlNmRkizaglRK7GFI6+ZzBUDv1tO
	EDXHxSusHRWu8VD+R3IXBYRzpQ6NoKDMBXOreZaEI5e76UQhIEVpKJUuCJv9oS1+8jC88i52hQ7
	nVxSJHyzH7VzcE5HOd3Xh/zQyhPMDe77WCm9mLHDzW+Qo=
X-Received: by 2002:a17:90b:4cca:b0:35c:29ba:bf92 with SMTP id 98e67ed59e1d1-35de6811cedmr8847254a91.5.1775393688240;
        Sun, 05 Apr 2026 05:54:48 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:54:47 -0700 (PDT)
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
Subject: [PATCH 13/49] mm: integrate sparse_vmemmap_init_nid_late() into sparse_init_nid()
Date: Sun,  5 Apr 2026 20:52:04 +0800
Message-Id: <20260405125240.2558577-14-songmuchun@bytedance.com>
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

Move the call to sparse_vmemmap_init_nid_late() from mm_core_init_early()
into sparse_init_nid().

Since sparse_init() has been deferred until after zone initialization,
the zone data structures are now available during sparse_init(). This
satisfies the requirements of sparse_vmemmap_init_nid_late(), allowing
it to be moved safely.

This change unifies the vmemmap initialization steps by placing both
sparse_vmemmap_init_nid_early() and sparse_vmemmap_init_nid_late()
within the sparse memory initialization logic, making the code structure
clearer.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mm_init.c | 4 ----
 mm/sparse.c  | 2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 64363f35ad0d..7a710fcbe3c8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2664,15 +2664,11 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
-	int nid;
-
 	free_area_init();
 	/* Zone data structures are available from here. */
 	hugetlb_cma_reserve();
 	hugetlb_bootmem_alloc();
 	sparse_init();
-	for_each_node_state(nid, N_MEMORY)
-		sparse_vmemmap_init_nid_late(nid);
 	memmap_init();
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 5fe0a7e66775..d940b973df66 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -383,6 +383,8 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 	}
 	sparse_usage_fini();
 	sparse_buffer_fini();
+
+	sparse_vmemmap_init_nid_late(nid);
 }
 
 /*
-- 
2.20.1


