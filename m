Return-Path: <linuxppc-dev+bounces-28101-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF6AC98314
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:58:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr5my0GNLz30T9;
	Thu, 24 Sep 2026 17:58:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790236705;
	cv=none; b=VIOjTR5TXGx3tAtkcmxK8iCn1G0x7+eU8A68Bd6EOpacvGKhuLVq4LVKJbeyUFR9z694k9+TyXWY6AK2re7C7NGTkRVNNo0oy75PuLUJyi6R9d4eUsmhAKmEMo7GG9ae/YDlWd7R3t4SBOaBVGFSBOmgfU8Pbkw7CMJCwCENoAgO7erMer4W9h7QggeVvZElSicqqMZVrCtt0flIpOTOl+13/MpoXGtk94zYgTdRSDMRGr3MNYLrKy+Y6FrBRut1VBzFmgmw7ItVODmy+8cqzzTJ7yZmusnZLsBFBBXffND/ei2dKW24N3/KM8WeNIE/pfQb+3UtPuM4aPckdT5Bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790236705; c=relaxed/relaxed;
	bh=vIuII5z6VGpIszxqYOaYyPM2+uByFb+jC50FCk2K+v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmKg8tBQWqQRc66baDcNM5qiXFhr6ye4rx8pAYM1EB87bWsIgeHNuO6uv81wG8TcXdNsZZO+mzHB6j5WCPCvBsc73pEAV3DXAuOqRgkCzoOtW+E6/iirv3IxPsSYfR6gIh1mwFA90gWmOCDLdxqjAXV6czupoMQtX8XljM6Bq5RVn/OEHb9GtNwRmyv4EZmJBa17wrPKtcymxx2azBe2fpJdjMRtgBem/xc1SKZumeKsT7DSPKFlgo6rg/f1frO/uFaEOriS9vv2H0Rtn6Iob3yWCnjqyC/c3NLB4x5pZt4pHMxqYCcFlj4gE4apDdObTF5AYzHv2C25Nx5vh1o2ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QF/duTrJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QF/duTrJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr5mx2t8Fz30Tf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 17:58:25 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1232374a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790236704; x=1790841504; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vIuII5z6VGpIszxqYOaYyPM2+uByFb+jC50FCk2K+v0=;
        b=QF/duTrJzqhXeX0TNWRrqeHBeiieBG4RQnnJLxH7zusF0lpy1iOVjh8+puhIda2CjL
         f0HRJsGlB8YTXCg3lJTNaQzbXgOfDSs2uaDuhc0n8F97l2qGYLiXla0BTTXJpvscf3zd
         QHW+NWCAfzmYhnt5rJMvJRGafY03dK8pgJLeL8sWTGsuwznKMMM+QCPoOv+uDUYUhd4q
         QxVpmT/+W1/Bbnpm1v5iOzGGmw4WQqDVm1PbBr/2hTSs3+1DhKDlQDhYl31OygKzP9Ux
         tsFzoCXEiGBYEFPIN3mN6mBQH4mzK2QHCXIkt0TuFeGfdwffC4B9AHwusFnIz1Wxpckd
         Ykcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236704; x=1790841504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vIuII5z6VGpIszxqYOaYyPM2+uByFb+jC50FCk2K+v0=;
        b=JvS0KeFJx1rxwhaLsdXA5+J8YKp0j3MyVsZf6kUO8JdTDkPjf3NUSqKbM2V9Yi7ieZ
         5i50vo5SnulWk2DiPo2DnnpGHIJ96kKf+7DP++1FTxlHXn4Mc+uBGI3hwBY+Q+FLNXcX
         mxPULVSFpKds7byHzHpqYt1hHxe4fUrP/4oCAiPd5Tyk5hr9VkRPFBgbCvyjbjeBuzCz
         Kvl53oxwJ/0ZfpkeHBuwRBzzEFJd9CioYao08ec15gBA4VWVO81DIBXxwjpcSnnBJnTj
         k6Jq/qXZk0QoQPaMOUD2jeQh00KIY9JGC2Rjw8K63MHtTUvXoJ57nvKC95PskGuQoKly
         1LtA==
X-Forwarded-Encrypted: i=1; AKwUvBxKmVMpl7QGwt0zz0bshX3mqTdP8zCV/yaW0l8AO/RdgPl1d4aj/asyHBbFIvuqt3LADPR39HOezCngUn4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kKa5pr9toBe/2YwofD0zqTM46Aic1yV8l5CtAINa344IBYfudu
	iXhFSPObvywllU9DMZM36+kKtFK9uFafwydtHnuZQAm0G6wkX4I5mfEJICS4jZQJD3w=
X-Gm-Gg: AYBFou2nZOL6SxWZNLo3SGzFfsVlrUiNpuqc8Ai3Ix2Bd6L/Mk0dqrc4tcwnnoXqwV0
	uh+dPPVxAAi8cXf2j+hi0SSCuvTFFLTkqU6Q7GZsKFgXK4cV5gcDg/OPXMUlU47INaSCFNFPCpX
	ARGc73sfvmJeby/qKZjSGXmxi5nPCENpL8RhoGTQMOTIuLa6PjyaPmc8cJ02SSxm47RrSZPmnBU
	v39n0jwT5mDSWYQ9pkpfOKNTB02bUiWhFLksAp4ASP4zX6Mh3BU54PQk4GP6KNHFRj5NQpH9Hnz
	mJMhh8dc2or2o/gxQhtFphr5QLfDgfinfpXTj37yLbFBghkBSbq7vPrmZsiy0RVZvGqdbXUaVCq
	rcfuG/JxLmNbSsW0ucof3C3dkl2TuY/kbvecUDwD63IXoDFktSm+LmmVgCe7Li3tDKck9K69fTC
	Fzdoh0GPlEp5PNIcynMxL/vLKZ9KpgSTyWsph5l5Qi0+8o/izU06+sw5nNSccfAXhcswCvkplIR
	R2A8rw++yw0inxziFaG
X-Received: by 2002:a17:90a:e7ce:b0:3a0:2662:815a with SMTP id 98e67ed59e1d1-3a098db8c10mr1546074a91.43.1790236703641;
        Thu, 24 Sep 2026 00:58:23 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm3575622a91.7.2026.09.24.00.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:58:23 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
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
Subject: [PATCH v2 4/6] mm/sparse-vmemmap: remove the unused ptpfn argument
Date: Thu, 24 Sep 2026 15:52:57 +0800
Message-ID: <20260924075259.2013039-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924075259.2013039-1-songmuchun@bytedance.com>
References: <20260924075259.2013039-1-songmuchun@bytedance.com>
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
index 4aae22beca21..a5b47e496322 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -245,7 +245,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-		struct vmem_altmap *altmap, unsigned long ptpfn)
+		struct vmem_altmap *altmap)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	unsigned long pfn = page_to_pfn((struct page *)addr);
@@ -316,8 +316,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 }
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
-					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn)
+						  struct vmem_altmap *altmap)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -337,7 +336,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -347,15 +346,13 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 
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
@@ -366,7 +363,7 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_range(start, end, node, altmap, -1);
+	return vmemmap_populate_range(start, end, node, altmap);
 }
 
 /*
-- 
2.54.0


