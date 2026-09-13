Return-Path: <linuxppc-dev+bounces-27189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03575C88E56
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Sep 2026 08:40:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjMF454G3z30M6;
	Sun, 13 Sep 2026 18:40:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789288856;
	cv=none; b=FstFjXAcWyA2ka2oD4jH56FHggPPPhRPQyTRva01BUEls3LD288xf6JaC+6Fndg/SR5Mqhs2fGX7fGzxNuweQfuBVrd4JmneaFNLnqh0DpfKNrWcj0A2ibCBV/C3O8Yprqbopi2VgzOdShFSS9ihcFiOGlqrNFMaxJY6SviSTfLziHY1af14+adPfcauFIMwTZrK5gXDBQd7oz569lusoOSkYtCxUsppNJtgEG09mDupDLJq78Anw22q6vkSPHSpyHqbtLmWuZg3hFv/MMGsYwOx5c3LVx1Vj0/eSh6GEcPc1NGSNGesHNoXXQQLqNMEk89PUePiS6AmviyzUl+Hag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789288856; c=relaxed/relaxed;
	bh=kHX0G+rfBcj3IGbPNWjgGAyawAROo7044LYJmYZedOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swj7xSdPUAlar4xDAbI1Mh14v1zNLqfKOQP90sCMTIfRSJnc+zHIcv1v1CfRNV3KagtMrDavN4P/B0kajYTSILai6n0oL8u2WmGFZOPRgTia3YIn5ZeL6ED0KES6E1F+F5zvSnvnjP8UCu/Mbb1tqRzFUH/e+bTF0pnxk8u3Xa5I2mXa1PgF4/1Nh9BA1YfCAdQVxRXuUoPi0vCkrKSePeMpqRm8pgtcdoWvZeAh7MRM0zPlMPyKNK3K2YisMs5TnzrO4Q+XAocEhwm97DiOUC8XwN+gJgLy2j3Bx9Sv43yH4KFjrRwDM0dkXhMnaQXlEk89xd3AGkY1dO74BW5tjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kjO3FAl/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kjO3FAl/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjMF40N4Cz2xkr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 18:40:55 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so1673490b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789288854; x=1789893654; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHX0G+rfBcj3IGbPNWjgGAyawAROo7044LYJmYZedOU=;
        b=kjO3FAl/KW5BqY6mW+lmovkyBdvaHvKZZrtYhw0HXNPatsUFRDte/YqBwHHT1CcM74
         rovcGxz1g67ElTrlhhnWN/CwQ+FWR20txlM0KtYAMhyO/80m9aN+Yq3isFZxdI+JdRwo
         2tEyJe+Jlm3AzlKUTy4o2KutBLkmejbEr1setTKRZVeKNIwIOERJnSiVEv21DDJwU+Bt
         VGYIXt02Xm7bCyt0kWpVA0UlO7bVVYQB2aaa3EDVmrETRlNwwwnbT6Gj7W5xg0ZRBiaf
         y3m4XaloLApC218hkXPItCLczVJ4jQ1/K63fKSslBPTRHxsbt58+x73IKnAJPs6oTwl4
         SXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789288854; x=1789893654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kHX0G+rfBcj3IGbPNWjgGAyawAROo7044LYJmYZedOU=;
        b=JZgtVce0o1aqYnxm+XOIw5/YAb9dDT+EvrXLd5PW2eQDsiPFvqh89ayHtGBoOrhgLr
         SRmwGEvUHc32ckhNUtY5GqInepqiZDF8rwe/0alVi8VQP5m6nNRoCJEdjx6FYvsj9RZ3
         yOl0x4garc/RWtXK8Gyof+hvVxh3ZcE6htum84CFMkFASWEuYI1VJ/bsAF3iGCEUGHLA
         AsYD4IEDlNBmq6hLKKoXk9FfBwH1U6X8AlrlCL4sLjMzSBYYWrwY7JLnMofAKVvcv0bN
         tcLUtoCNJIm5QMyUL7uIFGwThHQHy5wqaTiCsDOazsau11U5qN3r6ZUfaGCrc6XFqggD
         n41A==
X-Forwarded-Encrypted: i=1; AKwUvBxo0TBgjV8+DyJTU6MWMEgRgvpf+2IPo+DoPITOdZ6tmokvbBUhcb0sTu/Ymy0QSIe610nkXStSVcp6UVQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++meNY2tPHGpyKlz3dmhrt0axkW7PljCvQzWGz8xFdnJgmRDB7O0
	ZTj1ZmUShRILPYtRTSVM1CRjogEi/He+F+cF0ITOsVcrY8JeNfAaY3xflN0ShzTAWr8=
X-Gm-Gg: AYBFou0icFYN/jl24RiLIDoxXvnQrrJN8C8CSScNIjPEDNmMn8lH42q/UpwOMLe18ix
	SOeegb1+jZiJLrsd6fHA6YJDvfN91A1BA4D6Xfbf+feNeiaRUWHc6UkH5uvbWRtsQh5TpUTzANP
	/Q5OVObU/8/rEs49xEZOfF21KoILBtfi5aCKeYQiYbcfGiukrYrRBmnw8c6z0YQoCnaXQJzQl7G
	eh9zlJfFmpaC+3VHtMKcBIA0qhvSrUHOgmI0J0mI4iGJhspH0Mhup4buIa4HnmcJKIKOvOBcY1h
	ISSq4KLvi9galle1H9DA3PKUTKf1RE9s3E1o+v+APCbACv7XOksO30628yQJwmZrmQrVjtNyOqt
	dcrfW8lqvoySgQzRkO7ZCqUZAhuQQ0ixx/WuNa3sjghau7J100YgG1rcotldjax+BuhePgt6uM8
	lFlAdYEtC9mHIyRy+ATEyudKI9liZzcH0yKk4GqYe3jqUOWx2xQjVb8rPQjYNhSuKalwgy7qnq0
	t/cuMT9YL0/tMGy+UaFCmqOBaw=
X-Received: by 2002:aa7:9304:0:b0:86a:9be:6bf3 with SMTP id d2e1a72fcca58-86b31704588mr20617548b3a.23.1789288853781;
        Sun, 13 Sep 2026 01:40:53 -0700 (PDT)
Received: from G6L4RL2QG9 ([2409:8a00:1832:cf0:5137:990:100e:cc7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29cbb0d3sm3070531b3a.42.2026.09.13.01.40.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 01:40:53 -0700 (PDT)
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
Subject: [PATCH 4/6] mm/sparse-vmemmap: remove the unused ptpfn argument
Date: Sun, 13 Sep 2026 16:37:32 +0800
Message-ID: <20260913083734.86802-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260913083734.86802-1-songmuchun@bytedance.com>
References: <20260913083734.86802-1-songmuchun@bytedance.com>
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
---
 mm/sparse-vmemmap.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 028f844c90f5..8b4904d9c65e 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -233,7 +233,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-		struct vmem_altmap *altmap, unsigned long ptpfn)
+		struct vmem_altmap *altmap)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	unsigned long pfn = page_to_pfn((struct page *)addr);
@@ -304,8 +304,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 }
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
-					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn)
+						  struct vmem_altmap *altmap)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -325,7 +324,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -335,15 +334,13 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 
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
@@ -354,7 +351,7 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_range(start, end, node, altmap, -1);
+	return vmemmap_populate_range(start, end, node, altmap);
 }
 
 /*
-- 
2.54.0


