Return-Path: <linuxppc-dev+bounces-28443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9204CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:33:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv6Kj4996z30Vy;
	Tue, 29 Sep 2026 15:33:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790660025;
	cv=none; b=SyNf+B/CfF3/znCs3DDuQayfW/dIKDcDaQCLsy8RMkWY7fbbMNT0PpIGtJS/ilC4BYulMy2GdkhWHjqqxlyQuQBpDhfx2EsQchKxNkki/Y8+yF8jfm/ulu2nSnaReCPXlKLAmRwvUtyJa66AI+lqeMRZCwRql3EXssZ+XRWkMw8/gv03tbpX9LMj6YO4Dl7yC03oaDZDHpebnC+6710zzb7Vg3CwOq1tn5qFDQKgslvUgpKU71l+fdkUoTdZawUrlL+eGHzG/GHatNEr4lfVQBa1JhzJbFng0MgB+meV1LH1AqgktUHG8aCpw63lXa6wXcziofsHidPqZxDRga3r6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790660025; c=relaxed/relaxed;
	bh=YJAndcCm6vhI/WUnYbFErakp824Wpkra2IAgLjHGuUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anxE0LV//qfR0PlS74D031M3psaTmQ9bh4GrgPLEfd5VAaZqrk6sVq8x7b0GflWhgVHrYvbK+Y7DfazZokqkBWOYrS86wQ4cpR+wIMxD3KIVEBFp3DY6OGUEVALpbTFYomxzBpGxD9SqpVv4dUE22XdU4HeguBt1upusYmIlZBAPPUOy1X5SPoCYa2lEmBbM5wKFJIUrZ22X+O+uWEe11PD9YeGqvC2Z0Du+7YPHvSkZP089WPEEI1f6Yt48N9g6+jaHt9Lp0yJXnp9NvEa524HyECrjs4JtDOszNt3+5ku+ty0i5DcT+dUbKmyuWPJdQUKJkpoZvA4Biv56+W6flw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kL7/phjl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kL7/phjl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv6Kh32D9z30WF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 15:33:44 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d8fb334e72so15073085ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 22:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790660022; x=1791264822; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJAndcCm6vhI/WUnYbFErakp824Wpkra2IAgLjHGuUY=;
        b=kL7/phjlKucaaGkAb3ynUC+4V8/BMkJjsm6OusFCKOt0alvr6K9jOF5E1eOCSWLxJW
         ScG54orTKIutm/og19fcPKQw+C9BpScNOewe7RUqFeHEWyTa2cfrb8R8DYCZaHGwXSXK
         unTF00cVrZe3tXJ9p735hID8eR9WkDnrxvQoW91fVHcTbjKqitDhMA/J+QtALD/07CWq
         dsEN67FVSnjHUNL+QT+8adHMYkz+yHJQaycckPZnoEQGxSIz3eO/gelYPR6O/JMzX4DU
         JC12jnzcbvVVnyQyYbKcQSzGsDuP+xyZ0oxVxj87mNCuvOzKmnLjvHuV1hdvz9eaE9Tc
         B68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660022; x=1791264822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YJAndcCm6vhI/WUnYbFErakp824Wpkra2IAgLjHGuUY=;
        b=RQGmnbNNVGjdDZPDgBaFyEe5lj5g8PFfIeaFPyEyMrExgOhNeNHZDHK6eZYoZrOzUd
         Z2LpSaOc39MxLL0t4XBUqPAOol3hOb9N5hHU5gaZ52gOhzWxYWnO2HBYWtfrTtupE5tF
         tMM/qw+oXrNFV0C2tXezqaxdpIO7Up+3epK8lRq3bz9Fj3StVSYvn185fBbamvOgTg/f
         yD+Moj72OtGjbU7W93QeNhoTydy0WRMRFJSazbqhQIIEl3LVUOkYR0fS1SaLdKg5SwZi
         vXBIT6Fjy09xgiTLLHOO+NxaQQrtNbTuqu/0WC16eyR2Kv5kbV7zhVChXcNRClQpYBED
         leug==
X-Forwarded-Encrypted: i=1; AKwUvBz5lRvPSN/0sk0wNKt+c3XvLS/AUvE+fyJMbhnFsmTr/o1zdqyZEC+YANq77U2rs7EZv59alL1d5GsNybA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLWVjDD19JQKLd/YxQ1MpMOrLJX1Puoji++JOaJRODtUw546H0g
	RybuWnRs6qe8kzYh6sqEIUQIcOdpLlAG6qOQKv8UN277AjtOrKwU6l5xhZ0X/zK6vkg=
X-Gm-Gg: AYBFou2QhM5cJuxrKczp4qPWY4vH8yPdIb/YuEvYGoK13oMvNQszR46rkRK3PdWnu11
	vl5PhqbgdrNfHwTyO/xMxGSxqxQO4cEN5lhx/H/bKJzhnxVVdHhVLLTYw9onVfGecDdx+614Vy8
	bRWNzWVz70x9apEwq1MfL58yZI3PiX1CjRT171Hfis6Wsg8qWQmVF29hsN2DiGeB+YLgGqrYydR
	5gdaDCKBwtfcmEWUveUGdMAx/+Hd6c+9BI+V4mW3Wq85YKIjR6BCTZxgRfrnRHtyowLPqFenRLJ
	SBHMWqZSGzGYHjTYIRjf2WmkCCjWixbr6mGbgOhHxy0N5iPWGrbiYVt8LLJsCuk/k00YcmmOucA
	2AgBGA9Iv0b8g7h4C1la4pKoQGerFJw3BLjTTNbJA0AW6JstRC3e+8PTdshumrbL2a303DoYldN
	l/1snMcGio7Edg6N0+S3GjsPYnOlbZt8AiTnAmYNaMQNWfdilVXpo/6jmpZ9gR/A+71BYoVXgYo
	Z7W+Wbz7UDjQ3J4KQA=
X-Received: by 2002:a17:902:d54f:b0:2dd:c100:7ccd with SMTP id d9443c01a7336-2df7dd8bb87mr125260505ad.73.1790660022267;
        Mon, 28 Sep 2026 22:33:42 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142bafesm49251765ad.51.2026.09.28.22.33.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 22:33:41 -0700 (PDT)
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
Subject: [PATCH v3 4/6] mm/sparse-vmemmap: remove the unused ptpfn argument
Date: Tue, 29 Sep 2026 13:32:29 +0800
Message-ID: <20260929053231.66085-5-songmuchun@bytedance.com>
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

vmemmap_pte_populate() no longer uses ptpfn as an input. Drop the
argument to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v2:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index dee95e520376..5fd2df2b516f 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -278,7 +278,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-		struct vmem_altmap *altmap, unsigned long ptpfn)
+		struct vmem_altmap *altmap)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	unsigned long pfn = page_to_pfn((struct page *)addr);
@@ -349,8 +349,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 }
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
-					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn)
+						  struct vmem_altmap *altmap)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -370,7 +369,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -380,15 +379,13 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 
 static int __meminit vmemmap_populate_range(unsigned long start,
 					    unsigned long end, int node,
-					    struct vmem_altmap *altmap,
-					    unsigned long ptpfn)
+					    struct vmem_altmap *altmap)
 {
 	unsigned long addr = start;
 	pte_t *pte;
 
 	for (; addr < end; addr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(addr, node, altmap,
-					       ptpfn);
+		pte = vmemmap_populate_address(addr, node, altmap);
 		if (!pte)
 			return -ENOMEM;
 	}
@@ -399,7 +396,7 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_range(start, end, node, altmap, -1);
+	return vmemmap_populate_range(start, end, node, altmap);
 }
 
 /*
-- 
2.54.0


