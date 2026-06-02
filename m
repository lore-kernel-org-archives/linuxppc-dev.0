Return-Path: <linuxppc-dev+bounces-21893-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F97BCD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:13:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV68L4xvvz3cFf;
	Tue, 02 Jun 2026 20:12:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395154;
	cv=none; b=jJr4mdnWVsDdoTMsu135kSFs6kGBI2BBYNQo9zwL5aafXLPgAqx38PF3wpOTL8vqIqnm1J6a2O1RYDoxjc7qA7EBLSBYgtU4MiUPXqOAdOnEcSWDlfyDx+heVZv/kZntmbMOiTaRPk/l6C1u9tIZiIReGwNeQqbLqVjpb37oybDGy67Y5Ujysq2fiSFopKk13J8mWEQi6sSjkJY2EFlaoaAWsoBcjvvDcLjVcFJjVjff9VsyhRamuxzXQJEJrJNXfg3tbdrvvHELoA4bmZ6Viks3g9vOfqStCom+whB2P9nwrmCuHE+J8o7gY1c1I+lDx99tbxuDZfs3pCTpqonQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395154; c=relaxed/relaxed;
	bh=1RCwi6UfDOd+MCdFxykpsofvVeescXETLa8L+kiLjU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THX3MXPZcXnFeYG7cDRxskInVXw+mvnEwujjz5pOtF3XUYbfuJNYRVVtVUT15/pmaqNt16NDE3bcg/LnlpihNW48YBF+WxQUdCRPzjfr0Qz9gcATR1rhk14ix28dFc7YSoxjGJ8Sk7pYR3a26Ct1nEhSlBbvW6aiQdZhnyHjDJVnYH2anwaTvKVgS+bglo/sBvgk8lNqq/VJ+5cDbmKLiLiM6BW38O+tKEL0wqXr1BSc/l/jS7O0Fz7u1qgTG3yZcWjLfu53tpcqd8TUy+GjqxIOxQCtoILUanLdWSrp5ktaK9ZBA0yPNaWd8zLdRyth1JlUmok3L3rlxLAuNr6bJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=R8bZ5Uih; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=R8bZ5Uih;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV68L0YGjz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:12:33 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-8423f1e2f8eso1696554b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395152; x=1780999952; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RCwi6UfDOd+MCdFxykpsofvVeescXETLa8L+kiLjU4=;
        b=R8bZ5UihaeIVqr2OXaLkYSRgCWPhcO7pq/bAzMy1pijYEa00fwEbsb3tTCpYgo2Ll/
         45vHexFHTqQoXd/1uZr3nGS9F1ogYih4TTt/IMci+EeSQukMTcJWtzaZ2XPhGdD9O6fW
         DCurDJxDB6lwmgmhaisjc43V4xy1/5iq7PlCzpDmytO+wtwGJmfp7ZwqzdZ2TaymAOyc
         M1oa4og0YJb3g48z7rDFGs6zI1ZueD6CXMR5eV61fxUydTkKShjDZ/Z3C7Iupy6U6vkw
         YiiOrCudyfuK0WOJ4Lbipovjip8XLAo2M23ZHixBIO3cwpuRLa4ftkEXmRQdLdqBcit0
         02HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395152; x=1780999952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1RCwi6UfDOd+MCdFxykpsofvVeescXETLa8L+kiLjU4=;
        b=dx9Oz2QrycvaBoMGhKd0GkrQWSX2QI2jCxSFGamzcAmTdM2hqYgfpni10jItIJRenV
         PRH0nsbtdX0P8iuNiKzH1Z1GqBp/2gEcWzRqNMe9zLnwM0kJwqfbT0hpUq/TiweHjAZP
         mm94S1o67JYeOhoP31YTHOWaA3lj4M50A6MbSZUq1/L9kGbz/w5ppt40FmU0ucS1rZaq
         MHvQtK4bzKKvnK9i5g8i8Eb1e0cAfVlD3+z/k/zNXELuvuAmp+NMAA/wSaqs0TZSvApo
         NHwumcjNZYmoweb1fvqxceCE/b7VuWZe2Lu0zfQ0SSQLIbie7gWFISL01oKr0QNzjqDO
         ebDw==
X-Forwarded-Encrypted: i=1; AFNElJ9cqaqUO76XW0+EiP61if0UDLi1bWaw+XWsqncAm2B7ZiHb4a6/LhfcjSeW4jU7IkValLHzDX5lN5PZNZU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxUoT7g7zyS88VX4UYfk54/La8kBfP3IS+RmZXhV3GLoP01Rjhg
	fPLENVyioh8ehAaDU/OkKFio5LbslKLjLR7H1Zarn5q48c3FlgtCXML2a/O4y5+qFuc=
X-Gm-Gg: Acq92OF0Atr63/d/KeKU9Lq/hCXcIEpVT0CZ/1ZkmWMrqtKiH8iGjKrSmKO+qg+QkyL
	xi1i2+D/WGEUFF3xduZMuH0GTLwdOeId83Y+rz4kixw2hwX+WTFyA25CuWtL7dB4mt6+hv3I2sk
	2IMt00IcMDEl0pmHWGCf9Gynfoq8u3WZ2pIB7nkqj2r2QLsaYjG21XNCHMUqQHO3X1fhFqORwXo
	7snxfIAwp/ngnnbWtKCKgVtTBYrsc3XSh8PQZbPSZQs9ZOVa0U7cvi1uC50ukQHSsaF8oR6Jyhh
	daHLwb5HUvd0LgYp1ArDjeO/RfEexYAiXFAwt+INnF/XTmgygLq/rymzWx5EEOK9RoXs3W0xNlG
	RR9TwBZvacM/M6Mzz1Bk0QhpDD5Y0JX+9+TK0fBaIWojdxweodI0LE13mbG/ckibPTIc0QA1VmO
	cDPk1DJsu8ipFNXM6cM+CUHPZX5ZTyFlxcKm+4o8od3tip1dS81oa3g/M=
X-Received: by 2002:a05:6a00:3c91:b0:841:58b0:82c7 with SMTP id d2e1a72fcca58-84225327e9amr13634126b3a.8.1780395152058;
        Tue, 02 Jun 2026 03:12:32 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:12:31 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 18/19] mm/hugetlb: Remove unused bootmem cma field
Date: Tue,  2 Jun 2026 18:10:38 +0800
Message-ID: <20260602101039.1867613-19-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602101039.1867613-1-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
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

struct huge_bootmem_page no longer needs to keep the CMA pointer. The
bootmem path only needs to remember whether a huge page came from CMA,
which is already encoded in the flags field.

Set HUGE_BOOTMEM_CMA when the page is allocated and drop the unused cma
field together with the redundant assignments.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c     |  5 +----
 mm/hugetlb_cma.c | 29 +++++++++++------------------
 mm/internal.h    |  2 --
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 47c3d6d11c58..fb7ad2a4a26b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3076,10 +3076,7 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 	 */
 	INIT_LIST_HEAD(&m->list);
 	m->hstate = h;
-	if (!hugetlb_early_cma(h)) {
-		m->cma = NULL;
-		m->flags = 0;
-	}
+	m->flags = hugetlb_early_cma(h) ? HUGE_BOOTMEM_CMA : 0;
 
 	/* CMA pages: zone-crossing is validated in hugetlb_cma_reserve(). */
 	if (!hugetlb_early_cma(h) &&
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index e487d0ffffc0..4dfce68b354a 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -59,31 +59,24 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
 void * __init hugetlb_cma_alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 {
 	struct cma *cma;
-	struct huge_bootmem_page *m;
+	void *m;
 	int node;
 
 	cma = hugetlb_cma[nid];
 	m = cma_reserve_early(cma, huge_page_size(h));
-	if (!m) {
-		if (node_exact)
-			return NULL;
+	if (m || node_exact)
+		return m;
 
-		for_each_node_mask(node, hugetlb_bootmem_nodes) {
-			cma = hugetlb_cma[node];
-			if (!cma || node == nid)
-				continue;
-			m = cma_reserve_early(cma, huge_page_size(h));
-			if (m)
-				break;
-		}
-	}
-
-	if (m) {
-		m->flags = HUGE_BOOTMEM_CMA;
-		m->cma = cma;
+	for_each_node_mask(node, hugetlb_bootmem_nodes) {
+		cma = hugetlb_cma[node];
+		if (!cma || node == nid)
+			continue;
+		m = cma_reserve_early(cma, huge_page_size(h));
+		if (m)
+			return m;
 	}
 
-	return m;
+	return NULL;
 }
 
 static int __init cmdline_parse_hugetlb_cma(char *p)
diff --git a/mm/internal.h b/mm/internal.h
index 6b9802460a7c..8497673d0ac3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -24,13 +24,11 @@
 
 struct folio_batch;
 struct hstate;
-struct cma;
 
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
 	unsigned long flags;
-	struct cma *cma;
 };
 
 /*
-- 
2.54.0


