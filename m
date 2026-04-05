Return-Path: <linuxppc-dev+bounces-19344-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB634F3D5E1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:55:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXVS2WS1z2yr4;
	Sun, 05 Apr 2026 22:54:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393696;
	cv=none; b=EKxg+hApuFvETJ3EHHfFxV+Y/K1m5TARkMyqk7AKp9kSphZ7Rgm1b/6u/RPNckBQmjKGgRIsB0IKeKjfdwRtjK93e3vOC6ZHGpFXREOXkBI9zqsP2rCkzdWQ+R6Y+aIL0K52H2YlpasEKTqR4XK7Tf2WizlYCFtfuERlCXYiNT5EfiJhEvEErMfQ5XOTWtsoc0XmH2D173YG8Kq35S8gBWRo+pcIkCPFq1Nii4Cu8qKB18LJpTcp0sdyIcPzCwbnJRAQ7/E6rpibvFSi/WtSWfPEBJiDAkOjr2DW7sopXMyqLfgZqrJCn5l1654Vt47mvBcqF9AVt6VZ1qcaRtO6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393696; c=relaxed/relaxed;
	bh=TjgvWFWYEgCOLeyYyMsHcBGvGVNPbR5pUUyMN0Stxt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ApQgGvYL7AITEYe/M6MMrTfWLmEjqCSNn6uXOJfB4AYxG50hr1j+8cfoXxhBqSeE5HljJ98PAPoQBt5GqhxX4r1kGaQRxI/7Q2sz3HO5Nz07hqXIl4dAEg2QYjPc6gzFpP3bEN9Q7iBgE6E/irtaFOjA//PG5Zgn/ffKV/TwY83N8sEWuTPGqchPubbROYddWsDPBGVWsG+H/kABka6vSX87GKsFMwvWWpJMjYgQYGF5VCwSfcEqtrBQOOOPp1XShg5oL8SLSCsUef7IxIE4F/A35FiUjK8LwHvObkA63O0uXZ0lyKLzGVfXcK+QyK/mfEdYuQIlYr+XlW1ZpTW0lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gfOiV+YW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gfOiV+YW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXVR56tWz2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:54:55 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2009048a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393694; x=1775998494; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjgvWFWYEgCOLeyYyMsHcBGvGVNPbR5pUUyMN0Stxt4=;
        b=gfOiV+YWLphw+KKXukt7yS/OSkiVazNkqcYKl+u7t17j+bqZkOnLU4VM4ghRxb1vjA
         JNWnxcCthAFfWCjToSRSqXf84xT2psTRNcTubqpyGiVRUEBoxNGZ0XiTihTagp4YL7nV
         8LAqxKj4KSmgsjNNPDcK4m16aa3JWyxgNAvykK0z4hmDCoYXFSZUTprLu4OvwvKc7LRX
         ShunJ/BahWnzMBxfNR4vjdXnIVr1GnAF7utqCh0VKrF6uRvh3n+cunrD6eC3xX+x+poA
         9F1TI6ClfuhC1QaPKq/38E7mTAB5ACt+86C47viuLM/DBQ2RIEGyEy6HhBB5x0H53loI
         KXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393694; x=1775998494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TjgvWFWYEgCOLeyYyMsHcBGvGVNPbR5pUUyMN0Stxt4=;
        b=WJDVSqHFYNy3cq+t5f6trxqScctR5RUtevGLowLJesSOmq/1+DHh114v91Z63VeUuU
         69ldu4vdBpQqZyIpp+rVEn/BBKPPUfWulzo5mj37LXslem4wviEFOuA27aAOsJDj3il8
         vXG2F5wtG9GBh9Y4CPQu3AhqyDBN/zBVmBylx5D9k9mhfbwEhGutyx/IrimlkKhyfDWc
         sPaCZ42IQ63mb0+wX8sQkxgVpFRBLXfQMchz0uF1AHXl96cznHOwUSaOOq6cg7hMSB56
         0jBsh2NVhxiiBG+IG9kkDSjI1Pzs1SrUrHV+QPStutegE8PDTGUuCydzldV9QpFgVooF
         3AqA==
X-Forwarded-Encrypted: i=1; AJvYcCXOTRtwbhVKRupg36U5Bh7j42Mp72nWH9dJaac93rw9W4XMCzJPlt54hWarjoyFgwlYZnpdu8LQY0q5JWE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy4mrslcqkU8MV70xU4Im4FT5aLkHxELCTrXAT2poMDxNm6Qvp8
	OFYK9ynCDt7S/ePICfdDf/BFoXAeWNHAiaE0N+PG0t3VwDvHXzKgKld6uTFaK9niULE=
X-Gm-Gg: AeBDieuze0cRfe0hPzzy1pEfzXCFPxxNVfoxtgrm3V8zb9eVPCEMypa7VN1n7oR3mKW
	F5YoiXJWULIA8o9RfSFB8h6utK4mNdg5//3uo28IzLKxRGn8cxrshtBXWNHnaHy9Dbcfd/dnzRq
	LN6sYCQEQrhPEUHKhcCaOBgi732deOEwFW3GliVLAJPE3CpwUu52hOBy6Jm8ZeI8yvOxSOMwlqO
	/SY5eUnzjnCIHItjo1J9KPd6Sbcs5q6TcMoGEdgyh0pdqu3NVGYK9RMJciXysScVeDwINl8hf0E
	Un0iN3UdyUk3vwUj2wy6pjlxQfk1+KW0crX2ySNjilwcBEOnrNx2LtzHxBjhu/toKLliN5AqU4D
	wGNKGRPw5vLkkJNB6tvVi1CwpBRGt+211G9PviWvltljPX0QViyHK24gUSO96IScr9+Uc0Kldlk
	CiaC8j8cOsfDm3hQ9Y9HE26tSLpkPpUjM7ALFIEJnps3M=
X-Received: by 2002:a17:90b:1344:b0:35b:90e7:c453 with SMTP id 98e67ed59e1d1-35de67d6677mr7866778a91.6.1775393693495;
        Sun, 05 Apr 2026 05:54:53 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:54:53 -0700 (PDT)
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
Subject: [PATCH 14/49] mm/cma: validate hugetlb CMA range by zone at reserve time
Date: Sun,  5 Apr 2026 20:52:05 +0800
Message-Id: <20260405125240.2558577-15-songmuchun@bytedance.com>
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

During hugetlb_cma_reserve() we already have access to zone information, so we
can validate that the reserved CMA range does not span multiple zones.

Doing this check up front allows future hugetlb allocations from CMA to assume
zone-valid CMA areas, avoiding additional validity checks and potential
fallback/rollback paths, greatly simplifying the code.

The pfn_valid() check is removed from cma_validate_zones() because mem_section is
not initialized at that stage and it can trigger false warnings; keep the
sanity check in cma_activate_area() instead. This is preparatory work for the
follow-up simplification.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/cma.c         | 3 ++-
 mm/hugetlb_cma.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 15cc0ae76c8e..dd046a23f467 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -125,7 +125,6 @@ bool cma_validate_zones(struct cma *cma)
 		 * to be in the same zone. Simplify by forcing the entire
 		 * CMA resv range to be in the same zone.
 		 */
-		WARN_ON_ONCE(!pfn_valid(base_pfn));
 		if (pfn_range_intersects_zones(cma->nid, base_pfn, cmr->count)) {
 			set_bit(CMA_ZONES_INVALID, &cma->flags);
 			return false;
@@ -164,6 +163,8 @@ static void __init cma_activate_area(struct cma *cma)
 			bitmap_set(cmr->bitmap, 0, bitmap_count);
 		}
 
+		WARN_ON_ONCE(!pfn_valid(cmr->base_pfn));
+
 		for (pfn = early_pfn[r]; pfn < cmr->base_pfn + cmr->count;
 		     pfn += pageblock_nr_pages)
 			init_cma_reserved_pageblock(pfn_to_page(pfn));
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index f83ae4998990..b068e9bf6537 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -233,9 +233,10 @@ void __init hugetlb_cma_reserve(void)
 		res = cma_declare_contiguous_multi(size, PAGE_SIZE << order,
 					HUGETLB_PAGE_ORDER, name,
 					&hugetlb_cma[nid], nid);
-		if (res) {
+		if (res || !cma_validate_zones(hugetlb_cma[nid])) {
 			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
 				res, nid);
+			hugetlb_cma[nid] = NULL;
 			continue;
 		}
 
-- 
2.20.1


