Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603A606A33F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=figfd3fx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvKB6lR3z3bSn;
	Thu, 26 Nov 2026 22:22:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795692142;
	cv=none; b=i+GGkievKi0+HqIITLcsRuHMvKQDWbFYzquTKZts1MIO4BSflwT5JPM4Y6ke6DdU8/05eQmW0LUjvUc+lO93rc09iw3MQK9TocFR040ZYVayzPjBIBPA0bvlCtvXmx6z4JmkzjAhb6RA2IXvaUK1SMI6j+wBzxRBby7eMHfnuq8BfmttwyXGeCyL4Hhn9M/iWTItgsfgL+9GonHVkbke1wH2SEwpyJAQWD3ec3hLFWfaV8QuCS/fskT4pe2gbmcYPXcbF9cjr8pkrtMer81HdiJFCoT8OHLkr5roqz+H83YWlE84Ix9tP4Zv9hMR6ToyD+0u+upuP81Zzqf7LX5plg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795692142; c=relaxed/relaxed;
	bh=RHsZcGFHHORpSCEjNn8E8Q2ufv0UX5M3uRjs8u8EpXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N38uX1kyb5MLCpXwW/V3rnPuCdPQfTvWMmWmsLZdicIgrFz/v9GLDw6fuyX3IlgRK3DLYUa45fZdUX0FG7bThiIhzaxvDNKmOmXyQtWZKEanaeK5NIo0n+Bv3zcCH9UEPuZe4YIEumFa10OKRzbuuYOWu7BI9DRN4LmOvCEcVD2w6X5doRxnmHfIGVNnu2RqArM4mgxlMmk9NbXdaOC95GqcaTWt03j5ZR36jts74Fy4tsKl0pzSm+fiAWojuntn9apIP9LyzdKLjoCMSvKb6PzQ5wLhythWTBLdI5hBwWchaiNT1egs8vRgNajOrrm1PjqJRPx1nrfvt/cOP1s+IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=figfd3fx; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=figfd3fx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvKB1GM0z3bRp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:22:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 01E5E63440;
	Thu, 26 Nov 2026 11:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E2D1F00A3D;
	Thu, 26 Nov 2026 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692139;
	bh=RHsZcGFHHORpSCEjNn8E8Q2ufv0UX5M3uRjs8u8EpXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=figfd3fxv8brNBoXJh3GBvsyrUW879Fc/OGGgoULpsbzUWm/xERpvcOTMh4rOCkbN
	 9LyH02BeSv4GmU3Et2zH5B3cTxOpzRpRgMc0Iuf385p6Cun8u7wsLWWbug1PptSVbt
	 S6N77WW2fljQqVRrgHgYaBItpZXJSzavkuu2MdWfLQva2IpXzZ6eLnHxuMBin8h2n8
	 2ISpqPnNk4A6ryHTGIDY7pdYd5h+b8eGhX3F5UxAeAQ+Z6eAN0OSpj6Zls7YqXwX32
	 pUhlOUmKEIx7agVW5OxVXL/Aw+tx6pA7FjhQuJYFQlwO4mUn5/UuBLT3xO/B6nlhMd
	 Cr33daaPBar4Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:15:02 +0200
Subject: [PATCH RFC v2 49/54] arm64: mm: allocate page tables in the
 callers of split_p{mu}d()
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-49-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The generic CPA core allocates the page table for a split before it takes
cpa_lock and hands it to the architecture hook that splits a large mapping.

Let the callers of split_pmd() and split_pud() allocate the table, so that
the arm64's hook can use the helpers as they are.

No functional change.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/mm/mmu.c | 93 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 140520b351e2..0f96efea9057 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -601,20 +601,14 @@ static void split_contpte(pte_t *ptep)
 		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
 }
 
-static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
+static void split_pmd(pmd_t *pmdp, pmd_t pmd, pte_t *ptep, bool to_cont)
 {
 	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
+	phys_addr_t pte_phys = virt_to_phys(ptep);
 	unsigned long pfn = pmd_pfn(pmd);
 	pgprot_t prot = pmd_pgprot(pmd);
-	phys_addr_t pte_phys;
-	pte_t *ptep;
 	int i;
 
-	pte_phys = pgd_pgtable_alloc_init_mm_gfp(PGTABLE_LEVEL_PTE, gfp);
-	if (pte_phys == INVALID_PHYS_ADDR)
-		return -ENOMEM;
-	ptep = (pte_t *)phys_to_virt(pte_phys);
-
 	if (pgprot_val(prot) & PMD_SECT_PXN)
 		tableprot |= PMD_TABLE_PXN;
 
@@ -634,8 +628,6 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
 	 */
 	dsb(ishst);
 	__pmd_populate(pmdp, pte_phys, tableprot);
-
-	return 0;
 }
 
 static void split_contpmd(pmd_t *pmdp)
@@ -647,21 +639,15 @@ static void split_contpmd(pmd_t *pmdp)
 		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
 }
 
-static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
+static void split_pud(pud_t *pudp, pud_t pud, pmd_t *pmdp, bool to_cont)
 {
 	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
 	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
+	phys_addr_t pmd_phys = virt_to_phys(pmdp);
 	unsigned long pfn = pud_pfn(pud);
 	pgprot_t prot = pud_pgprot(pud);
-	phys_addr_t pmd_phys;
-	pmd_t *pmdp;
 	int i;
 
-	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(PGTABLE_LEVEL_PMD, gfp);
-	if (pmd_phys == INVALID_PHYS_ADDR)
-		return -ENOMEM;
-	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
-
 	if (pgprot_val(prot) & PMD_SECT_PXN)
 		tableprot |= PUD_TABLE_PXN;
 
@@ -681,8 +667,17 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
 	 */
 	dsb(ishst);
 	__pud_populate(pudp, pmd_phys, tableprot);
+}
 
-	return 0;
+static void *split_pgtable_alloc(enum pgtable_level level, gfp_t gfp)
+{
+	phys_addr_t phys;
+
+	phys = pgd_pgtable_alloc_init_mm_gfp(level, gfp);
+	if (phys == INVALID_PHYS_ADDR)
+		return NULL;
+
+	return phys_to_virt(phys);
 }
 
 static int split_kernel_leaf_mapping_locked(unsigned long addr)
@@ -692,6 +687,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 	pud_t *pudp, pud;
 	pmd_t *pmdp, pmd;
 	pte_t *ptep, pte;
+	void *table;
 	int ret = 0;
 
 	/*
@@ -728,9 +724,13 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 	if (!pud_present(pud))
 		goto out;
 	if (pud_leaf(pud)) {
-		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
-		if (ret)
+		table = split_pgtable_alloc(PGTABLE_LEVEL_PMD,
+					    GFP_PGTABLE_KERNEL);
+		if (!table) {
+			ret = -ENOMEM;
 			goto out;
+		}
+		split_pud(pudp, pud, table, true);
 	}
 
 	/*
@@ -753,9 +753,13 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 		 */
 		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
 			goto out;
-		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
-		if (ret)
+		table = split_pgtable_alloc(PGTABLE_LEVEL_PTE,
+					    GFP_PGTABLE_KERNEL);
+		if (!table) {
+			ret = -ENOMEM;
 			goto out;
+		}
+		split_pmd(pmdp, pmd, table, true);
 	}
 
 	/*
@@ -874,12 +878,18 @@ static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
 {
 	gfp_t gfp = *(gfp_t *)walk->private;
 	pud_t pud = pudp_get(pudp);
-	int ret = 0;
+	pmd_t *pmdp;
 
-	if (pud_leaf(pud))
-		ret = split_pud(pudp, pud, gfp, false);
+	if (!pud_leaf(pud))
+		return 0;
 
-	return ret;
+	pmdp = split_pgtable_alloc(PGTABLE_LEVEL_PMD, gfp);
+	if (!pmdp)
+		return -ENOMEM;
+
+	split_pud(pudp, pud, pmdp, false);
+
+	return 0;
 }
 
 static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
@@ -887,21 +897,26 @@ static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
 {
 	gfp_t gfp = *(gfp_t *)walk->private;
 	pmd_t pmd = pmdp_get(pmdp);
-	int ret = 0;
+	pte_t *ptep;
 
-	if (pmd_leaf(pmd)) {
-		if (pmd_cont(pmd))
-			split_contpmd(pmdp);
-		ret = split_pmd(pmdp, pmd, gfp, false);
+	if (!pmd_leaf(pmd))
+		return 0;
 
-		/*
-		 * We have split the pmd directly to ptes so there is no need to
-		 * visit each pte to check if they are contpte.
-		 */
-		walk->action = ACTION_CONTINUE;
-	}
+	ptep = split_pgtable_alloc(PGTABLE_LEVEL_PTE, gfp);
+	if (!ptep)
+		return -ENOMEM;
 
-	return ret;
+	if (pmd_cont(pmd))
+		split_contpmd(pmdp);
+	split_pmd(pmdp, pmd, ptep, false);
+
+	/*
+	 * We have split the pmd directly to ptes so there is no need to
+	 * visit each pte to check if they are contpte.
+	 */
+	walk->action = ACTION_CONTINUE;
+
+	return 0;
 }
 
 static int split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,

-- 
2.53.0


