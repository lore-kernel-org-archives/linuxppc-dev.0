Return-Path: <linuxppc-dev+bounces-22546-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444A0CD98CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:01:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5Qj5fbrz3brB;
	Fri, 12 Jun 2026 14:00:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236845;
	cv=none; b=iIZkFwX5sjxmwbj4FBt6fRb8keCNGnWujztVA4rhOhE0EqtF7OGlcptT8KvU583Q/eKC35YxZoNTDHMoxInbeWlKxPOhC/6t8+lteY7dAVLPM0tNnjE7qHC+n/3Ou1SM956YKGdhL8yBTzTgou3s6bSS/6eXrNd7UDBK1aDpZ/gefblnkrITIGPQZYQRrO8WERlt5RQ6aQbNTSey6beHSt+eI0xlUZZ46aCjnx9j9xkPWY92JmDgqrYL6D9iNBmCzO1VpGEbFKF6IgT0NHwLAzq2IB5zXaNEcV8s1of/OTPGtkI9EHs2CrS5SwSfPEfed17Vip4KI293afJvUJZLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236845; c=relaxed/relaxed;
	bh=3pqeOYOFlkduDfAEfXJoLwswwYJKmlexz4b6SAwRMuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2ve78gjs9X+WbQHp3sDV9msb+RnfOiyzGzF9h+3kacwE4Lib8rsW3iAVxjKVXLoRUjSIa7u4pOhKfblcKJNM+Rx+hdNg53K7ZPyJETWsE+z9l2VovREsi7UkzDgHE2Zk7dFTqr/J/+VUzDqBgJivf3hGYH54EQQFFJYn7XchsX2brIkeNmKk98IwQVPL/MgvDYxDfJ/r0RiZ8eaELGGE29xI1dfFi+9wq7YJEBMJ9FKnqYmPkaFmY7nNLgb3jF7xYpcJpEzKnXU2cI3cL73Bcdn9Tf8xxMuE0PjYhP/8Eyq/RKNP7m2YHQMB/mKsxNJEiXTMQfpqlulRumrM9sP7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PtXk/hT5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PtXk/hT5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5Qh4WTLz3cJr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 14:00:44 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-842cd900ee0so268006b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236843; x=1781841643; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pqeOYOFlkduDfAEfXJoLwswwYJKmlexz4b6SAwRMuQ=;
        b=PtXk/hT5lmAZc39+rEjVz3azsKUoi7WoE49E7nahLlekozsorLISrRtop0+2xv9Cx3
         BkB/5gQobWJZVibSsOXcx3SYHDWeEUnXYyhpV9NKo9egX67YBEPe3xrRebyf3d/vXLMB
         LIpqcd6ifpCLyZ4+2uHJuqlNMfqtJu6Grixqf+QLqTQWF+0DbRFKXHlfpWkg/SMLqvmF
         pI2miYDLTGzqEd/JGMiHLeykwTv9aXMJHIumOvloxdK60MKIS90ScWNxfsV8IrO9z9rE
         PffvYXOuHsJxsuSIp3wUgqH+4iE9uLbjY1Z92dG7NugmlmQlXP97iXx0zspqP6qURfrq
         82OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236843; x=1781841643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3pqeOYOFlkduDfAEfXJoLwswwYJKmlexz4b6SAwRMuQ=;
        b=CWAJbcKNKDXlWA5sYZxbhx3qOwLG7ofibOq6S7oRUX5qyFU0D0wp9fP5/bcxRE9d2G
         TnzPaYtyCaCrVrcsI9Q4YUogRd9twkhJSBII3I22QAVG0rTW892PIrieGNmdbAtCoBSE
         iLp4gGvqpRCGE2nUNZKY4we2xA6n1pYeIEZ4LHWDrBWtAFUWhNVg2wan6yiXkm5YUJrD
         qxsBdGxvyvKwKV9JtMoVnDZ3mvITfvkNP++XLHDNbxSHyy68oUum4V3+VwVgn1lXpiYr
         CQxdn0Vu9Iy3G76WCbxLFwomES/JF6Oc0P7mJCRUNkS1gTvc4NO9QZ1tkl6qAryNZBEc
         qFSw==
X-Forwarded-Encrypted: i=1; AFNElJ978wW+gFfiZyw0fMPmc+jqXpSIOSlXzJzsWebdCR1f2EuwoJKNrhXC+0F5rgUfe2pyN1Po27ZrV9Ob4xA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzb+gip25EynOle9lvTKhIcZvQYynKGcaUrpzLrrKTbNRBGVQS4
	4kvutmwJckzJlO9HUTihgCkPZTq5BewIi2I2nd3laiTKfiHGQMKlKZ1aoitGz+9SE5E=
X-Gm-Gg: Acq92OEekE/T9JzVe0reC1Ydg7OxMs1Km4F+INRol8GKc13uRxJxkeX2VgTxIhIbtfd
	JExDvTb6L5Y8Uf74wNsq5QOI4lsKMuSyJCyP/DY2wXuw4EQXPqzE90/pDPKhpeMa7jKyMS0sLZt
	/0n17rmpD30C9Kw+wwRzJ6P6rqa+c+kxtlrzQRuPSyYe69UhWxWqZ2+NVeI00/luqlngQ9LdylI
	3Rl8Qtse8xPSqAViMCZ9B7FHC1P9E+rk8UFvCYdDGoY58e91yvbd73xBqxsL2jV2T+kFUKv5fKN
	W2ZSuTUwaKuSa06NhJlvzl6mY3qxBLgvX3blOMKAsPQQI0cmCRj3Av9TS0QXr+kmxEPQIiriVok
	RKhDChn/WbIiB3bIt7kWBq4a/TlVN2MKtmhMtdrNtJjvPC8hwvj60WrxPaIfswuhZ9nphdZAtL3
	1X5eXwRY+5j19RhuPG4mO7/GAQQGeyFog+ayjmCGCJOsc=
X-Received: by 2002:a05:6a00:2d95:b0:841:dcbf:e82b with SMTP id d2e1a72fcca58-8434cea0464mr1038514b3a.12.1781236841705;
        Thu, 11 Jun 2026 21:00:41 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.21.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:00:41 -0700 (PDT)
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
Subject: [PATCH v4 18/19] mm/hugetlb: Remove unused bootmem cma field
Date: Fri, 12 Jun 2026 11:59:02 +0800
Message-ID: <20260612035903.2468601-19-songmuchun@bytedance.com>
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

struct huge_bootmem_page no longer needs to keep the CMA pointer. The
bootmem path only needs to remember whether a huge page came from CMA,
which is already encoded in the flags field.

Set HUGE_BOOTMEM_CMA when the page is allocated, drop the unused cma
field together with the redundant assignments, and simplify the early
CMA bootmem allocation fallback path now that the cma pointer no longer
has to be stored in struct huge_bootmem_page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>

---
v3->v4:
- Clarify in the changelog that the patch also refactors the early CMA
  bootmem allocation path (suggested by Mike Rapoport)
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
index 3401759924d9..39c9564fba0e 100644
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


