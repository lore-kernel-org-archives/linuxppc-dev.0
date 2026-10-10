Return-Path: <linuxppc-dev+bounces-29168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B82CA9EBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 07:59:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1x2H52KXz3bSn;
	Sat, 10 Oct 2026 18:59:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791619143;
	cv=none; b=hpoEido0way3r22/rYk3uLkmL/x+kl7uttbJKTvkqWrJh8qasOnKpQS7bzUtUjCqV0dhGFbVEU67ppC+z+yD2hlRbH9g0hCd0Nfi+agtwCzJkl18X3EJMkdK046+ozFzSnyofWLq13mn2zz90Y1PV4wXiKfK5IeDzncd8/cUPuRiVBkfwVItLw0HV8lh7SKUefBWFrVC9/y15LgOJMpudcrribs9hfVCxfgKlwXfIZxrcZv9UtKIKm2rIV0Zfz2WdvP4Kg3o9e93u8JxuZSoMvA//69WvKe8tSZ8nWnOcr0YyCo7Q7Ku9W+l6w9k0IgoWSVH/yi7BOAWvk1XIB97UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791619143; c=relaxed/relaxed;
	bh=41VYVIz+zTmPkAQO5l9k2UXneMzLxonPZ50UDfJ1RYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7SjMpqAhNPYCCyGO4dlRg2OBNzqS0jQF+kGRympFgd20taKBMyFYanep8FpvKWi/js5hkRlX/JgU2pCvdxQ19AGhxWElxXaevQ/yF6kD+hhCsSwPnqKCoSm/XnoCw4Zlj2gCUztcsLImvuQwf8tU2P7A2EuXleV4IRwOZ6GmGnWgcEb2DN7PZCFPRzqy05+o3PmskWtKEKL3TqUKg1CFt+AFrPN4xHoJF6U8IxxQEjtgTitNUTaQVDyQbJlCC/IxQoVX1StzzgVPxPWJ9g0uDE/xSex0G3wdRpkMuJ/B+t2DDVsh2sCPs2cm1DqJLxyeR4V1CqPDb603X7QGofe4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EiiGsArE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EiiGsArE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1x2G75Sqz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 18:59:02 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2dd9cbb661bso3181235ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791619140; x=1792223940; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=41VYVIz+zTmPkAQO5l9k2UXneMzLxonPZ50UDfJ1RYo=;
        b=EiiGsArEmUZF/xQWNX7A7XxEEzjGC672vknvgMjF318cKFZ16bysswGp/1P1S1lF9X
         CI1COGDVeuLrp8emi7lS23wUukK5oXVEWgvGIAh/MEH6cRJOtl4dpPFB0/OeVLSBinK8
         yMUjeD9xxVHv2ghQ+9312LNGE4AQL0oqd9L5H1oEgDW3zuQpy6k+B7Eizv73LWrlnFSC
         QZ1zVWB3ZrtFbqYvZ9P+8yJaBTjfYbZBqFC/V6+n9Y6nN+ZIrwPgAUU/s7KZFHT6raWK
         ENHxTs7jFZL4dqDbLBrPTGKrAMqkClfqDoPeA651PAfxhVQbTvfLzYLxkkJayeUtp5G3
         139w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619140; x=1792223940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=41VYVIz+zTmPkAQO5l9k2UXneMzLxonPZ50UDfJ1RYo=;
        b=vx7Li2mg120DWqirL/feqo4CN5RkXyn8MxxLoxhDG6uUrkECSvrS8LO7GTeh/E5rTA
         4la/5tFwdRgDJXkbUBHTQ8a768IFsfVTwZZH1e+qoJnXJm+MnNk9L8HWsyfjjxpiKCrk
         6YkalL+ZN7PmrUguidLRyGRvkWVgEqNvX7CbsLcYdjhqYTnTLQUV/GY4Z+ZZvS3CT9Zj
         5L9Q8gXNjdLrCF8/FZKEuELapsU1XxuAVMP6QXu9wQZYvLKZEN4GL2nmIs3XTLxhugwr
         YxnpPAKiWrlNEP4Sjic66sVIeoe5qPMyJBGlFGrW21N4K38utXH0KQSn3wgh4DDQtDrz
         YpNw==
X-Forwarded-Encrypted: i=1; AKwUvBwfieMH8l4ccfO0WTeB17YVqcha+aIfwwr+fnPqKqQQaMMh78bnmGwVKfHdnO7OVYgnXxLPoeppZxznD/I=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJMdpUTrua7TvZ+hy8Mb2lQWxtln7VShd7g8yPKZeBNR1nKdsmv
	pzS/deLVpeVDQDOwBvH9FOdeqf+49X4lz/5sfVIDeqz/9p4zklCgN7LEgyMx8szcT5Y=
X-Gm-Gg: AYBFou1foU3iWSQWS0W1kpXqN8qXQQThuAlDpii7EqyVXMihnXF6ug6orQLfuBQukgr
	En13rl4pIE8L6puTQqJN94o/zpgncr1KlHscaAo8ovQ06UG/N8b6hMdnEYlSBVOM3VRo7yYXgkv
	1J0svBwkrhXlYxyDsUG1XVXJumljMCO7G9yMYS2GL+Cj7e6fZ4blxKnrYozsTh3KioUqrisxKie
	gAtKKpfv7JwserS43NmWhnlOXWqpT0Qr5WH9vpTS8fJYYoqOdBIOGGiMuzuEyVYyH5guXGtFmxL
	r7pIAr6krChSZxRS4wK3T0/+0xK+VKT2YYkoUbeHZ3Lv+NmyiLiHhRiprchbMNIr+QJXO5eME+9
	qFbO3fXj9KxyJKdzH48ZYs7paqfN5l/DX61K4kMbvb0p1bY0TogmoH+4fO1VuLxPPmtwjhEsUGx
	g76W4DZqgE8TVqpupQyjNld5q5DhK4fvVdYcsoH2NTNsXykkQyJ5k6JsiBWnnVc+NOXwaclEjl6
	3dm2JumCeKDddLu5Ng1tWhCJPOj2TyfIboJ7w==
X-Received: by 2002:a17:90a:d604:b0:3aa:f4af:1e12 with SMTP id 98e67ed59e1d1-3ab3a736ac8mr3952987a91.11.1791619140221;
        Sat, 10 Oct 2026 00:59:00 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab57c05724sm3473569a91.4.2026.10.10.00.58.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 00:58:58 -0700 (PDT)
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
	Lance Yang <lance.yang@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v4 4/6] mm/sparse-vmemmap: remove the unused ptpfn argument
Date: Sat, 10 Oct 2026 15:57:53 +0800
Message-ID: <20261010075755.83339-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261010075755.83339-1-songmuchun@bytedance.com>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
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
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v4:
- Collect Reviewed-by from Lance Yang

v2:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 270b5def58e1..07188cdf00f6 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -282,7 +282,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-		struct vmem_altmap *altmap, unsigned long ptpfn)
+		struct vmem_altmap *altmap)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	unsigned long pfn = page_to_pfn((struct page *)addr);
@@ -353,8 +353,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 }
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
-					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn)
+						  struct vmem_altmap *altmap)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -374,7 +373,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -384,15 +383,13 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 
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
@@ -403,7 +400,7 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_range(start, end, node, altmap, -1);
+	return vmemmap_populate_range(start, end, node, altmap);
 }
 
 /*
-- 
2.54.0


