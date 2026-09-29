Return-Path: <linuxppc-dev+bounces-28444-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D76CA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:33:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv6Kt0cPnz30Vn;
	Tue, 29 Sep 2026 15:33:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790660034;
	cv=none; b=SlTRTYoF0/CZ+EQN2KjyhT/UsCYjACx1khEE3ITIiIUyljxcjK9uZbH9Tl58Tg9XzdMLGyQJXaEZVQqWw8IuL3KqKEXkk5IogsJz2nX6A93EI47OPqWdOo+kozlaKMxzg0PyCM0v27xVyqDNpqiFfMaLo3cOyl2ymDZJ3Iifxt1aNyS0NJ2Xm5X25qWLBreSMhMIpuY/8BAe6z6VGAzZGoqG0JSZ9HHd1Vwr3btk79+3BFxo0PVhX3eNbABkLAgLpmsyIFOKkJlsHC1vMbQfNQgIXs6qlhpMoS1ijHenDfZr2EXQqN3gLM/+VosjLz6dNtEmRqk7axjj+Z0c+S4I1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790660034; c=relaxed/relaxed;
	bh=mw8H//cBUjqDniGMsK1MLuH6vPH2dGolHqesV1qp9nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R14W986V3nqDBM9cNdIlpAZ+Yx0v7uab8Wd3u3pdyG49ZF9dFDQsgpwABODlmauDq2SLbawPwR36CBgZ+lO5fWwjAVqNaKvEqwm04rHGcyVFBABqv1alg+zY7tGZsci3dLurANqyEgWzqDxnDdnlhOvVIvD0kHMV3CzQykAv+hjobXdtxhcRsZNlS74JxLxoPij/N/zUeRLKZ5vI2RpdTPP4mtaEjGQeRxLkl3N04iy9Kmag9gCtpVJNR7aU8z8eh/Iift83uewfp2FKLiKsNi17mNm8+nFtM9um5PWJQ3elYAfXpNRGhtDXep5M26T2TPn24aZgMYMVdIYH7ck3+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lO19E250; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lO19E250;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv6Ks2Blsz30Pp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 15:33:53 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so259552a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 22:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790660031; x=1791264831; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mw8H//cBUjqDniGMsK1MLuH6vPH2dGolHqesV1qp9nQ=;
        b=lO19E250mAVfiDNSvAX1N5Zbx9B8xN12GJFiZhFYv2deC/7tvmWZ0O+A3W2Gm5UdVH
         ItPf8WH5yK5CijGjHQgH6KZbiDSqnCZjG7l8fdsdSyEUTQtGZZ913mDz2Sq8nSiy3lBr
         EKr4ZEG3qs0/eOAlQseoBy/RxNaTiFWBuAltzZdMLuZeDT9DkhbO+ohlgzVgOYIlw9FR
         dw91StgBLcEN4H0JTh2rduYR982AqEUiU1F3lTB20cJJjLMXkGE5OVEiAo2MlJcQMyqd
         884C2B7KXt9FPzM0vpuDvOQeaHsZIuIkksjOEWHRQd+ocq0hqLaEwUCj0BsnDXGiENLn
         EkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660031; x=1791264831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mw8H//cBUjqDniGMsK1MLuH6vPH2dGolHqesV1qp9nQ=;
        b=x2tG0MKBrQOx8Ra9Kj/WMKWhi623RHEb6YT1ZyUsUuOZB+VvlSGca859tOT63s4v1R
         AMP4fi2pz4RMHGnoGSiOLrmh+8ZyxT8McH13/oUwPfedIbepkdgLJv37+Vq7M4NB2rJW
         4wLISKMqEi4atgkvD9A/haNtCiukCtQ/3MrFJ6trKhWnMh/X7otZ1f1xx0PSGvCTWxz8
         elqnwJy8Bx06oFtKdlbq9UqL3URoY85/WbJpfziw4jflQihQddSUfNTxqErWSaDmczXu
         IhIKvzehhh0Hig278dsOigKX0ak7DrCeO1aRhYGIYi9aOKUomj/4LzEpGIgbywLQI6hA
         LJBA==
X-Forwarded-Encrypted: i=1; AKwUvBwZmL1PqJkmVKCbmNLA5bbzjwaBi7ivLNnivHjcrVtEVQ/P6obduZE0pNP41aPBE5Pch8BinymmUQI8m/g=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIPkYhhrq7eVL7UYUBwQA8Gvmxxt4XMgNjESJ7aCFRGDiaHMV3M
	uFrra9cIfkccmgNF7dIiVAhhoaagugXWqhby4mBJs5OJwAPp6pnQkq5A9O5Sm4D1IHo=
X-Gm-Gg: AYBFou1BqxtL/+TQ3yJWkVHpETF5mtz4fVrBruWAXVXVIPIzKsKoRZAgNUkumliwTKP
	EunT5m62pCoPT6H9r5LYmW8QZOgpxRmC7UuxDI+ndWKQruTJ+0ncE7a0qX7g5nY2JB/TkkfDcFr
	v1xYrQCMn/cLdzThXLl1kGEc+Jjwa9K1yMffHZsuaJehdbZad7oL4pOWYp5F3UbltQ3eju0MyzF
	fWcw2KenT2rKrAABGYsTtEgD/6/A9vJ3xgNZNNk/urBHUXVIy3xpWzY0a0Z2XFya5jo+uXhhd7t
	eYHXBXNuRV5CwPkzH9O5AWxvNjjsmJBIL8ols+pd1toujQNnMvO7JDCwl1HYJGjD4U8/Sfl3EnH
	3Y/IjlGoXQdmWgI6Hf7K5W4IzS5RXDQSa9MAcn0WnJR5TQOG0QH7v0TemBeYdSjHnWqE2BWoQhL
	jv786b8LedFFOyAWKbKdQfkNs0394Sru4ZoEm7PN9lcYb1rWnzGPXCsunZavAQNLhOsv8P2p6F2
	wAJNXZ3D06OmNkqFXk=
X-Received: by 2002:a17:902:f54a:b0:2df:3eaf:582f with SMTP id d9443c01a7336-2e2c49d6095mr8936165ad.32.1790660030889;
        Mon, 28 Sep 2026 22:33:50 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142bafesm49251765ad.51.2026.09.28.22.33.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 22:33:50 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v3 5/6] mm/sparse-vmemmap: open-code vmemmap_populate_address()
Date: Tue, 29 Sep 2026 13:32:30 +0800
Message-ID: <20260929053231.66085-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929053231.66085-1-songmuchun@bytedance.com>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
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

vmemmap_populate_address() no longer has any callers that need the
returned PTE.  Its only remaining user, vmemmap_populate_range(), only
checks whether population succeeded.

Open-code vmemmap_populate_address() directly in
vmemmap_populate_basepages(), remove the now-redundant range helper,
and return -ENOMEM directly on failure.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v2:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 54 ++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 5fd2df2b516f..9a58323dd628 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -348,8 +348,8 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 	return pgd;
 }
 
-static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
-						  struct vmem_altmap *altmap)
+int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
+					 int node, struct vmem_altmap *altmap)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -357,48 +357,28 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd_t *pmd;
 	pte_t *pte;
 
-	pgd = vmemmap_pgd_populate(addr, node);
-	if (!pgd)
-		return NULL;
-	p4d = vmemmap_p4d_populate(pgd, addr, node);
-	if (!p4d)
-		return NULL;
-	pud = vmemmap_pud_populate(p4d, addr, node);
-	if (!pud)
-		return NULL;
-	pmd = vmemmap_pmd_populate(pud, addr, node);
-	if (!pmd)
-		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
-	if (!pte)
-		return NULL;
-	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-
-	return pte;
-}
-
-static int __meminit vmemmap_populate_range(unsigned long start,
-					    unsigned long end, int node,
-					    struct vmem_altmap *altmap)
-{
-	unsigned long addr = start;
-	pte_t *pte;
-
-	for (; addr < end; addr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(addr, node, altmap);
+	for (unsigned long addr = start; addr < end; addr += PAGE_SIZE) {
+		pgd = vmemmap_pgd_populate(addr, node);
+		if (!pgd)
+			return -ENOMEM;
+		p4d = vmemmap_p4d_populate(pgd, addr, node);
+		if (!p4d)
+			return -ENOMEM;
+		pud = vmemmap_pud_populate(p4d, addr, node);
+		if (!pud)
+			return -ENOMEM;
+		pmd = vmemmap_pmd_populate(pud, addr, node);
+		if (!pmd)
+			return -ENOMEM;
+		pte = vmemmap_pte_populate(pmd, addr, node, altmap);
 		if (!pte)
 			return -ENOMEM;
+		vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 	}
 
 	return 0;
 }
 
-int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
-{
-	return vmemmap_populate_range(start, end, node, altmap);
-}
-
 /*
  * Write protect the mirrored tail page structs for HVO. This will be
  * called from the hugetlb code when gathering and initializing the
-- 
2.54.0


