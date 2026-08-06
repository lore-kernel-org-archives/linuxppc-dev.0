Return-Path: <linuxppc-dev+bounces-25480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B3DC55ABF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 10:04:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hG2vJ6G8vz2yh4;
	Thu, 06 Aug 2026 20:04:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786010684;
	cv=none; b=mzc03Q06cM4ZyvfS6OZi2YXTf8p8cew3K5M2WTU5MvY0O+1zdwZ/bUvHV64SEcv0tBAkyxKLG6sbkZVsrxQYVp1w7rozL4ElVfnRjaXMQN9BMWS4kjEWbw4ajDu+u5m8qKdQax2Vu/qYnfLSd3BT6aF4u+aJBHGD4U4pYiPgKIpueOngnnL3zijMdHPFlkYb0LBkCsI/gXcPAPk0+8dyihNdXSaDaTF9ROe+bE30S+BuGllrO2TEbWbr4Ua0f4IRQJxPJ7IsbBC0WHRsDm546UAr24Gqm7c/KhmVVlt2GNa0iNzDFSTmOoAOjkpfsVoFyByC4hR7Rvhs7EkiLlsu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786010684; c=relaxed/relaxed;
	bh=XbvQbFMu9FpzLP51q2agJRmM6RlOhIh48gDVj0jWfHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+6957ZFQPS2GrrgrYHWeS+VAudr9ziP6J7tL6s+Q5UtkNGXaZ8BJsPNxfHtrk/UhdC2T8r1m//GBdB94z+Vu5THeB3rJ6B5/XFMJ7Bq8gosEcJHuuy9vY87ciLYSpxrqB/p0Noz2uXxHfdGT9ML/HHdOU17Ee8P4543B6YLsPYTS2hQQDpZY0bmlt71Jk/SW3sxssvmfb7QC3WzZMBAicS4NZOSSEleutXWU6Sag0yOoVTW2jQSlwyngR5jVXLxbaJF7oHVVMxzCU2i2wfAFUm0ida+UvfueclDwuVtLqM8klBwHw0ibatvrG6dDSwk6WGZJU4g8RQmBV0s7jHlvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=i0PLq67x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=i0PLq67x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hG2vG44Xmz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 20:04:40 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-8484f229529so1726878b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786010678; x=1786615478; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XbvQbFMu9FpzLP51q2agJRmM6RlOhIh48gDVj0jWfHU=;
        b=i0PLq67xz1NBg21o6lYl+nnQKUtS5Ei5uZbrlO/cRhDwhn0IXAxGWzDaGzd7wkDUKP
         vvo5tRll+K91PR2xXLnnKVbU032RjWMgyEcfrocciohh2awRjv7SrD//hn5XATfvejo8
         ESl86jHYx0nyYdR8ySLREKSEgD+ncbSWdWHrUcvnzij+snWcSLSGdQ2JQLihKew9ijYM
         sE/5fWCLfrr3hg8IVgs+dPJ3ui9q6gXxcVrgkBkv8Dq9uqbTE+ttSAJPAoP34cQp7+Yp
         o3Fpmd42KDHDKe9QUk/gKNKbbNrdAYbKcpg8gJgr/U4ILxe6NMl1ZFZJsTjll+Bv1IyW
         DdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786010678; x=1786615478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XbvQbFMu9FpzLP51q2agJRmM6RlOhIh48gDVj0jWfHU=;
        b=LJiv02svL4CYjNt2UIRWtBd6nslJSuOvi/WCVtToTcq7rqOac+huKLcRSuGPr31GVw
         I2AKKP4greWDvTeCsi9hRsCQEz3efgRG+P9C/7/hkk2aWeIHUqqnqQMIx6ULRV7Y4rh6
         szBIev3xXDMHLwd0cMHZ5YrZBYfUJ1v1GXDoAXs1oLFd6jvj0sk9lPDgNr00x3JE2ITH
         s54tY+1hGUZDDGpu2W2y4SZax4VcqEKD8rlAjqSK8+GuafG9/LwfJndGHT0crIwIQGZc
         0W0hjqWkpyq3ZLjVZaa3jZvhU1RITqZ5pN+a7ehESxWYzjHp9f10KizvGx+exCnJsjWe
         PFZw==
X-Forwarded-Encrypted: i=1; AHgh+RozwesyUoPFPVtHzIlXK9Eh0GpKnbuJEJNr+k1QDN78ByY1eLhhpzMKAQiIsE1QPHo1fA8zSCZc2cAVcjw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxquY7WU2QmSXCk9g+G0TcIcODp1kS8molO4Sr8re2bVJ2kCnaz
	JCMrhmd9CV9YZw/7ypRMfs1QZuXUf8B5dXjAAOhKHnmvuiPXR8H31Ye0Os6CjJMFu64=
X-Gm-Gg: AR+sD11wyHizs2Aq51FqtbwLD5P2Yono97Srr1MmQVpaEGBADut+uNwdJrLtIM2ov5x
	JTc6t3aFmb0a9pIEJlsCm/z5kYUXJOCvNh3OOKrdIXmFPWGbUbw7qgv6N7ICvK5snTeSNaD57+5
	8TegEfgHSbWOq8TpmOh0lCI+s+TautBRpy9UE15HXWPjV1znYkKIIIfV7czguZpEWrOpXja4kq3
	LGugoOpOIlLuFbhVU831YFS1w7z6roscjVz5O8QVQUmrARmwYnvHVA7lTPPl4DaHqzu6OqYLOKj
	JJ9MRfZJsX2MEqSCI27h1V7pGNkzUoJztk2w9tAWCFYJ/kc+pIEgZF5O/yhb9iSPnHTAN/n2BAs
	S3njrVIcoUbjzvoQzjyAxQuD0lpyU3rodg59CyoXVFI2oYDId9I5TzeoVsKr8kCTBkHWS5T7fsI
	quFBjK4DcpZ+nKlwjv3/KPRvy7vzAf1X5qhntRq8C8eI1d85Ln0PRJyBD0d8a7VxDGvRoAeIbG8
	exDNqo8
X-Received: by 2002:a05:6a00:b90:b0:848:6447:e09c with SMTP id d2e1a72fcca58-84f2e152a10mr13558367b3a.39.1786010677915;
        Thu, 06 Aug 2026 03:04:37 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45389e68sm1089248b3a.4.2026.08.06.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:04:37 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Rohan McLure <rmclure@linux.ibm.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] powerpc/mm: remove radix-specific vmemmap PMD overrides
Date: Thu,  6 Aug 2026 18:04:31 +0800
Message-ID: <20260806100431.507837-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
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

PowerPC radix vmemmap population has private implementations of
vmemmap_set_pmd() and vmemmap_check_pmd() that duplicate the generic
helpers in mm/sparse-vmemmap.c.

Remove the radix-specific overrides so the common helpers are used
instead. Since commit 4edd70ee6a7d ("mm/sparse-vmemmap:
flush_cache_vmap() after hotplugging vmemmap"), the generic sparse
vmemmap code calls flush_cache_vmap() after vmemmap population. On
PowerPC, that provides the necessary ptesync.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 26 ------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index cf692b2b5f7b..08ab371e4722 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -987,31 +987,6 @@ bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 }
 #endif
 
-int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
-				unsigned long addr, unsigned long next)
-{
-	int large = pmd_leaf(*pmdp);
-
-	if (large)
-		vmemmap_verify(pmdp_ptep(pmdp), node, addr, next);
-
-	return large;
-}
-
-void __meminit vmemmap_set_pmd(pmd_t *pmdp, void *p, int node,
-			       unsigned long addr, unsigned long next)
-{
-	pte_t entry;
-	pte_t *ptep = pmdp_ptep(pmdp);
-
-	VM_BUG_ON(!IS_ALIGNED(addr, PMD_SIZE));
-	entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
-	set_pte_at(&init_mm, addr, ptep, entry);
-	asm volatile("ptesync": : :"memory");
-
-	vmemmap_verify(ptep, node, addr, next);
-}
-
 static pte_t * __meminit radix__vmemmap_pte_populate(pmd_t *pmdp, unsigned long addr,
 						     int node,
 						     struct vmem_altmap *altmap,
@@ -1055,7 +1030,6 @@ static pte_t * __meminit radix__vmemmap_pte_populate(pmd_t *pmdp, unsigned long
 		VM_BUG_ON(!PAGE_ALIGNED(addr));
 		entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
 		set_pte_at(&init_mm, addr, pte, entry);
-		asm volatile("ptesync": : :"memory");
 	}
 	return pte;
 }

base-commit: 9a4cdc958dd79fc6c3b20b51a10debec6ca09fec
-- 
2.54.0


