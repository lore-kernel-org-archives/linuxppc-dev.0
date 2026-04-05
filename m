Return-Path: <linuxppc-dev+bounces-19334-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28108EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:53:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXTB3v0xz2yks;
	Sun, 05 Apr 2026 22:53:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393630;
	cv=none; b=TJHhPJJkFoGxGb/wNN9EmYKgfClACtGQmvD+nrePG+09KUIymFa2MyBJZ73310uLO8cyNrR4rGPHu0NKZD+JuHP75VoTZkGVPgH/awrMPrtpCaPHw/CbAAxkioxdxUZNEzfXIC1VCPaojI0J0TFCF/aliBaESGonFb2DEsbUbXLAr5LFoKOwg5K0ZpPUhwnyezy3EYY2Yljwj77W/YhPnaLBPhWWCB9sxMl9lYN7tNm0KLo+YJxK0A4P+GslLSaww6qMmcJsInbBIU49h5D6oAwzOw4wNxk9x393+x2u4IS1smCJWQ90XImDLr6S91oWHaMQhu+83XDBZHznxzD5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393630; c=relaxed/relaxed;
	bh=qqZiP5IDxjx5eZ19SJ749S5+pviMXDrT55UzwpoHOxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TnwZ7PTKHSgkrkNEE0uEqcOCLbMPnlbvpW1FzWgY6rVUFzoUy8HI49k5ucKWUlDtYLQKYo4sE6eI6oq8Yp9GVcHmtFNUnpceC0tWNBrLgEWbDPR8qDOOwJO+JhJGHzGeUQh5K5WVF1wltS2cz/oV4j5izhkfyOAS00qIQYVfpbp9EgLHsrhW4jYNqWWd8yrxGVXyFxSPPQS4CxCTZlB5lvE2Bt1JisJMwnkFdhEJk8JY+Ez0NQ5EMi43NVUx5/2GZxwYCcdwets0YO/Pr61pkLIlD/LuUX/axwYKPLH4wvKaFdbQwttWU0urzj68xuzW64cNJiY12vMfRobTtKAj3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=GkzEUzYR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=GkzEUzYR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXT94Pk0z2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:53:49 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so2804198a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393628; x=1775998428; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqZiP5IDxjx5eZ19SJ749S5+pviMXDrT55UzwpoHOxo=;
        b=GkzEUzYR9tmQjysSqQXsRhvSsti2SWLN4HVIg5vacO2vK+Vvmzm/0RqTEw2f0sGgqi
         gtiLDxlWfkWnjGRwJtKyoWPZ/OdOtD/MjzEuNa9+P2Rtw8itkPYNBmBBQ+0gcW5EfsYI
         CPMMNf3ZY8SBJ2YeTqitm1XAPFcpcti3AsIVy4R1o0sRdKTcxX2Mk5oUH/4kxRgNZ82F
         HQDlVOZZeXOwzFtygyoEaZ196hLNP/U2JaphQ7ifpOcA5eiwcyCMNl+30jeVDIWvfhtY
         QKLeTTrgKzuCSK+LkD2jpPfXP0nhy2jjojBoDvGgHdp4PVP+6ITsGNzZ7LekoFHrTuYh
         arGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393628; x=1775998428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qqZiP5IDxjx5eZ19SJ749S5+pviMXDrT55UzwpoHOxo=;
        b=VCKCLJiIf+kfzOKqfklOyMztT1nyP2Sp3CaTpSllUVuob4G/1LbeyNEXEXalNY7lpb
         RkhJGhrT5vWOxZ5SZYhsNtfJCMfQZ+1jsTRv8Zrgy9SMD9e8TvbhJQAv28D2Fo9CIJCq
         lF769Esu9xtGvaH5THP+sGZ2XIlFukCM+1YlqZTCIT+1eEFOd5FkGRg8PnP3Tf4rM5wB
         tZJieC49/CHsaLx+APJsGkdb2K8XXcWn1yDDxAX6rIQHlKSYeDeHqgv2s181deeB+Nau
         48THc0i+670ue5WapgMS+LTbXG2ddmYQgcDbbX49pmziLc1mYpAQMnJt9wTAGgzZWZBv
         POSw==
X-Forwarded-Encrypted: i=1; AJvYcCWC9nIXZ6/RXEFdvycTE3dikskSHbLS7iZ4aRsEM+ztWvji2MPTHvx6LsyU5YwPfDn1PQm1jdQOZS8m5Pc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz8kJdbOLFjyL/GU5Rdx9AuSJwupOxG+WHQ81LiGG0s4Sd46Pbj
	hZnpGQxzJvQRSv9iKyiuNgGYWN/S7FBIIi1nb+h9OxmjOEu84Ot2wuwiXShSyrMrRdw=
X-Gm-Gg: AeBDietWsAhnkhz7S7vCziAThPY1z9hufE2dgVhrxgcivLb2DJcsNsMnwaKJWpSL6LJ
	jZcfCnFx6J8q22TGca6X9iDPC9RAzOp/UDlzcqovmKKKICxXswlXPSiTme5BoppjhdegjaM2WM9
	+CYdX0BSaw81LVt/PdAOyLxXx02j2wHVdf2Mo4pgSZQvvFFOwLBznHxEsNs/OUQf+xUfYsFN6pM
	48S1gEEjXdgSuWczWhyi4zipgy3ceQZ7L38b5wN4fTD833lIteEpncZ6J366lX1GwFV2+6SuMnH
	YRe1eKbdBR+KaImlUAU+GmXgsm8GsCdFXRkqGpXcwSBiRsFvb//BWrZ8n+K6iRFBM0Iu70bA2tF
	Y1Z22sHbxzPxVPXBzRVUev8GDD4hVpaOwo0MI3Tt8xWByqGsouaBcnVwi9GrnBwijXnruKt+7LM
	/ynJfXtaZvRfwpFY/fgBWM37nTD8AXV5hiZshhqL7tr8w=
X-Received: by 2002:a17:90b:1dcc:b0:35d:a3b4:2f00 with SMTP id 98e67ed59e1d1-35de6810254mr8790455a91.8.1775393627679;
        Sun, 05 Apr 2026 05:53:47 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:53:46 -0700 (PDT)
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
Subject: [PATCH 04/49] mm/sparse: add a @pgmap parameter to arch vmemmap_populate()
Date: Sun,  5 Apr 2026 20:51:55 +0800
Message-Id: <20260405125240.2558577-5-songmuchun@bytedance.com>
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

Add the struct dev_pagemap pointer as a parameter to the architecture
specific vmemmap_populate(), vmemmap_populate_hugepages() and
vmemmap_populate_basepages() functions.

Currently, the vmemmap optimization for DAX is handled mostly in an
architecture-agnostic way via vmemmap_populate_compound_pages().
However, this approach skips crucial architecture-specific initialization
steps. For example, the x86 path must call sync_global_pgds() after
populating the vmemmap, which is currently being bypassed.

To fix this, we need to push the awareness of device memory optimization
(via the pgmap) down into the architecture-specific vmemmap_populate()
paths. This will allow each architecture to handle the optimization while
ensuring their specific initialization routines (like page directory
synchronization) are correctly invoked.

This is a preparatory patch only; it changes no behavior. The actual
architecture-specific implementations and fixes will follow.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm64/mm/mmu.c                        |  6 +++---
 arch/loongarch/mm/init.c                   |  7 ++++---
 arch/powerpc/include/asm/book3s/64/radix.h |  3 ++-
 arch/powerpc/mm/book3s64/radix_pgtable.c   |  2 +-
 arch/powerpc/mm/init_64.c                  |  4 ++--
 arch/riscv/mm/init.c                       |  4 ++--
 arch/s390/mm/vmem.c                        |  2 +-
 arch/sparc/mm/init_64.c                    |  5 +++--
 arch/x86/mm/init_64.c                      |  8 ++++----
 include/linux/mm.h                         |  8 +++++---
 mm/hugetlb_vmemmap.c                       |  4 ++--
 mm/sparse-vmemmap.c                        | 10 ++++++----
 12 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dc8a8281888c..86162aab5185 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1760,7 +1760,7 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-		struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 	/* [start, end] should be within one section */
@@ -1768,9 +1768,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 
 	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
 	    (end - start < PAGES_PER_SECTION * sizeof(struct page)))
-		return vmemmap_populate_basepages(start, end, node, altmap);
+		return vmemmap_populate_basepages(start, end, node, altmap, pgmap);
 	else
-		return vmemmap_populate_hugepages(start, end, node, altmap);
+		return vmemmap_populate_hugepages(start, end, node, altmap, pgmap);
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index c9c57f08fa2c..d61c2e09caae 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -123,12 +123,13 @@ int __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end,
-			       int node, struct vmem_altmap *altmap)
+			       int node, struct vmem_altmap *altmap,
+			       struct dev_pagemap *pgmap)
 {
 #if CONFIG_PGTABLE_LEVELS == 2
-	return vmemmap_populate_basepages(start, end, node, NULL);
+	return vmemmap_populate_basepages(start, end, node, NULL, pgmap);
 #else
-	return vmemmap_populate_hugepages(start, end, node, NULL);
+	return vmemmap_populate_hugepages(start, end, node, NULL, pgmap);
 #endif
 }
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index da954e779744..bde07c6f900f 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -321,7 +321,8 @@ extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
 					     unsigned long page_size,
 					     unsigned long phys);
 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end,
-				      int node, struct vmem_altmap *altmap);
+				      int node, struct vmem_altmap *altmap,
+				      struct dev_pagemap *pgmap);
 void __ref radix__vmemmap_free(unsigned long start, unsigned long end,
 			       struct vmem_altmap *altmap);
 extern void radix__vmemmap_remove_mapping(unsigned long start,
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 10aced261cff..568500343e5f 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1112,7 +1112,7 @@ static inline pte_t *vmemmap_pte_alloc(pmd_t *pmdp, int node,
 
 
 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, int node,
-				      struct vmem_altmap *altmap)
+				      struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	unsigned long addr;
 	unsigned long next;
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index b6f3ae03ca9e..8f4aa5b32186 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -275,12 +275,12 @@ static int __meminit __vmemmap_populate(unsigned long start, unsigned long end,
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-			       struct vmem_altmap *altmap)
+			       struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (radix_enabled())
-		return radix__vmemmap_populate(start, end, node, altmap);
+		return radix__vmemmap_populate(start, end, node, altmap, pgmap);
 #endif
 
 	return __vmemmap_populate(start, end, node, altmap);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 980f693e6b19..277c89661dff 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1443,7 +1443,7 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-			       struct vmem_altmap *altmap)
+			       struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	/*
 	 * Note that SPARSEMEM_VMEMMAP is only selected for rv64 and that we
@@ -1451,7 +1451,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	 * memory hotplug, we are not able to update all the page tables with
 	 * the new PMDs.
 	 */
-	return vmemmap_populate_hugepages(start, end, node, altmap);
+	return vmemmap_populate_hugepages(start, end, node, altmap, pgmap);
 }
 #endif
 
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index eeadff45e0e1..a7bf8d3d5601 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -506,7 +506,7 @@ static void vmem_remove_range(unsigned long start, unsigned long size)
  * Add a backed mem_map array to the virtual mem_map array.
  */
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-			       struct vmem_altmap *altmap)
+			       struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	int ret;
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 367c269305e5..f870ca330f9e 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2591,9 +2591,10 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 }
 
 int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
-			       int node, struct vmem_altmap *altmap)
+			       int node, struct vmem_altmap *altmap,
+			       struct dev_pagemap *pgmap)
 {
-	return vmemmap_populate_hugepages(vstart, vend, node, NULL);
+	return vmemmap_populate_hugepages(vstart, vend, node, NULL, pgmap);
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 77b889b71cf3..e18cc81a30b4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1557,7 +1557,7 @@ int __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-		struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	int err;
 
@@ -1565,15 +1565,15 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	VM_BUG_ON(!PAGE_ALIGNED(end));
 
 	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
-		err = vmemmap_populate_basepages(start, end, node, NULL);
+		err = vmemmap_populate_basepages(start, end, node, NULL, pgmap);
 	else if (boot_cpu_has(X86_FEATURE_PSE))
-		err = vmemmap_populate_hugepages(start, end, node, altmap);
+		err = vmemmap_populate_hugepages(start, end, node, altmap, pgmap);
 	else if (altmap) {
 		pr_err_once("%s: no cpu support for altmap allocations\n",
 				__func__);
 		err = -ENOMEM;
 	} else
-		err = vmemmap_populate_basepages(start, end, node, NULL);
+		err = vmemmap_populate_basepages(start, end, node, NULL, pgmap);
 	if (!err)
 		sync_global_pgds(start, end - 1);
 	return err;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0b776907152e..bebc5f892f81 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4877,11 +4877,13 @@ void vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 int vmemmap_check_pmd(pmd_t *pmd, int node,
 		      unsigned long addr, unsigned long next);
 int vmemmap_populate_basepages(unsigned long start, unsigned long end,
-			       int node, struct vmem_altmap *altmap);
+			       int node, struct vmem_altmap *altmap,
+			       struct dev_pagemap *pgmap);
 int vmemmap_populate_hugepages(unsigned long start, unsigned long end,
-			       int node, struct vmem_altmap *altmap);
+			       int node, struct vmem_altmap *altmap,
+			       struct dev_pagemap *pgmap);
 int vmemmap_populate(unsigned long start, unsigned long end, int node,
-		struct vmem_altmap *altmap);
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 int vmemmap_populate_hvo(unsigned long start, unsigned long end,
 			 unsigned int order, struct zone *zone,
 			 unsigned long headsize);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4a077d231d3a..50b7123f3bdd 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -829,7 +829,7 @@ void __init hugetlb_vmemmap_init_late(int nid)
 			 */
 			list_del(&m->list);
 
-			vmemmap_populate(start, end, nid, NULL);
+			vmemmap_populate(start, end, nid, NULL, NULL);
 			nr_mmap = end - start;
 			memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
 
@@ -845,7 +845,7 @@ void __init hugetlb_vmemmap_init_late(int nid)
 		if (vmemmap_populate_hvo(start, end, huge_page_order(h), zone,
 					 HUGETLB_VMEMMAP_RESERVE_SIZE) < 0) {
 			/* Fallback if HVO population fails */
-			vmemmap_populate(start, end, nid, NULL);
+			vmemmap_populate(start, end, nid, NULL, NULL);
 			nr_mmap = end - start;
 		} else {
 			m->flags |= HUGE_BOOTMEM_ZONES_VALID;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 0ef96b1afbcc..387337bba05e 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -297,7 +297,8 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 }
 
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
+					 int node, struct vmem_altmap *altmap,
+					 struct dev_pagemap *pgmap)
 {
 	return vmemmap_populate_range(start, end, node, altmap, -1, 0);
 }
@@ -400,7 +401,8 @@ int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
 }
 
 int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
+					 int node, struct vmem_altmap *altmap,
+					 struct dev_pagemap *pgmap)
 {
 	unsigned long addr;
 	unsigned long next;
@@ -445,7 +447,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			}
 		} else if (vmemmap_check_pmd(pmd, node, addr, next))
 			continue;
-		if (vmemmap_populate_basepages(addr, next, node, altmap))
+		if (vmemmap_populate_basepages(addr, next, node, altmap, pgmap))
 			return -ENOMEM;
 	}
 	return 0;
@@ -559,7 +561,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (vmemmap_can_optimize(altmap, pgmap))
 		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
 	else
-		r = vmemmap_populate(start, end, nid, altmap);
+		r = vmemmap_populate(start, end, nid, altmap, pgmap);
 
 	if (r < 0)
 		return NULL;
-- 
2.20.1


