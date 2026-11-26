Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64E606A684
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aS+hd1Aj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvCv1lF0z2yRP;
	Thu, 26 Nov 2026 22:17:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691867;
	cv=none; b=L81U2B/zaUN0HNQA0SDKm/Laowj7WFyIB5K/7kuBLDoWkeHmh3/TuYoTAA2hoGTDemMK9HUv+ql6wysvsDkswzNlvMFtP8gnmDfgGiRbq1f5CQ2I4FoeKC4Zj2LJtskDvWkNHjaXUtGPF4fnhnkPeziuO63kYBzxBT7HjQOkG4yJfBXNclAW6hA9Ee0uRp67jrV0nlrwzj/awoMe8cM+4lZbGkjmx8jwp1kWPp0dp6z6l3POsXA6JGEg0VP6yfBQ+xvqVEWHrfnvmVB0cQuJCCd0L5UZ+5vVK/Fcg4PVzcikNdAaw0By/SWok4hcYR1A6Y3RrN9zMyqifZ4d9mp9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691867; c=relaxed/relaxed;
	bh=Kz6N2VohMG3ZruiYALtY6EKQITdyxhPrOz7uPba4HMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSlGJlOFlvnR892PC7YO1dBZhTVF78GpUhNIRHOu1uDmkzt/k4IiAmGpIN5qqJkVEMiAVsU4PKsg3RDmCVw10kjossKIjCessBj+Mh2gVknPHfMOKEYF9CuHJYBj5B1j7PyLokz6FeQLMiK+18vthlSU3Cldw6CnkJmx64Cy4cNOKEWGVC/dJeCsTSAg80X5cVbaOMaWj3v5E+beEvS0sRs0uxmujY2p8LO8FpFE+P2TPm6a2Z4KyROw/u2gZAFc4LboUVubD1+i6ZYGdu4uNMzC2YYFuN/ablpORi2BIgXey3BlfU+4A8mtiFOi1NuC05KvaypHnxvHOWTRciMNcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aS+hd1Aj; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aS+hd1Aj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvCt3dLNz3bZm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:17:46 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9FC01623F6;
	Thu, 26 Nov 2026 11:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBF11F000D3;
	Thu, 26 Nov 2026 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691864;
	bh=Kz6N2VohMG3ZruiYALtY6EKQITdyxhPrOz7uPba4HMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aS+hd1AjkS1QYoJbIi4PHFdZ3P7Ob8y0ffR5ZfLo62IfN0ojR0cCjfeG5n9B6hoDy
	 DJTkKQptCFQo0yZe66PyRV9+XE9vT4gM+yFas4z11qWmHPoo4MEtGlKja4KD8en9BX
	 iP5ilV4a53PHoXVGD88tMFuhNGWLEK4Y+I3FlbuBSFaOv4/EO+aFIZs0B/fuysY4Og
	 y6oRmrVksohemPg8fT47vG6i8WMkRJPhSPg0aNVOakR1Nf4wu9JfIwAK6pWhyh9PmR
	 ySKwFA6052jSfoaJBZ4+M7JdT5078pxsqgHVdEfV2o3i5YRL2PL4llJZQ20Vcss786
	 m2CPOwU53f+tw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:33 +0200
Subject: [PATCH RFC v2 20/54] x86/mm/pat: index the CPA statistics by page
 table level
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-20-723f1e33c3d8@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CPA statistics have a variable per page size and every helper picks one
with a level check. This works for the x86 page sizes, but other
architectures can have different page sizes.

Index the counters by enum pgtable_level and derive the page size printed
for each line from the level.

The output changes on 32-bit kernels without PAE: the large page lines say
"4M pages" instead of "2M pages", and so do the always zero lines of the
folded PUD level instead of "1G pages". The 4K line is spelled "4k" as in
/proc/meminfo.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 87 ++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 36f5031f1a0e..44e350c54899 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -142,54 +142,64 @@ static inline void collapse_page_count(int level) { }
 
 #ifdef CONFIG_X86_CPA_STATISTICS
 
-static unsigned long cpa_1g_checked;
-static unsigned long cpa_1g_sameprot;
-static unsigned long cpa_1g_preserved;
-static unsigned long cpa_2m_checked;
-static unsigned long cpa_2m_sameprot;
-static unsigned long cpa_2m_preserved;
-static unsigned long cpa_4k_install;
+static unsigned long cpa_checked[PGTABLE_LEVEL_NUM];
+static unsigned long cpa_sameprot[PGTABLE_LEVEL_NUM];
+static unsigned long cpa_preserved[PGTABLE_LEVEL_NUM];
 
-static inline void cpa_inc_1g_checked(void)
+static inline void cpa_inc_pxd_checked(enum pgtable_level level)
 {
-	cpa_1g_checked++;
+	cpa_checked[level]++;
 }
 
-static inline void cpa_inc_2m_checked(void)
+static inline void cpa_inc_pte_install(void)
 {
-	cpa_2m_checked++;
+	cpa_checked[PGTABLE_LEVEL_PTE]++;
 }
 
-static inline void cpa_inc_4k_install(void)
+static inline void cpa_inc_pxd_sameprot(enum pgtable_level level)
 {
-	cpa_4k_install++;
+	cpa_sameprot[level]++;
 }
 
-static inline void cpa_inc_lp_sameprot(int level)
+static inline void cpa_inc_pxd_preserved(enum pgtable_level level)
 {
-	if (level == PGTABLE_LEVEL_PUD)
-		cpa_1g_sameprot++;
-	else
-		cpa_2m_sameprot++;
+	cpa_preserved[level]++;
 }
 
-static inline void cpa_inc_lp_preserved(int level)
+static const char *cpa_size_str(enum pgtable_level level, char *buf, size_t len)
 {
-	if (level == PGTABLE_LEVEL_PUD)
-		cpa_1g_preserved++;
+	unsigned long size = pgtable_level_size(level);
+
+	if (size >= SZ_1G)
+		snprintf(buf, len, "%luG", size >> 30);
+	else if (size >= SZ_1M)
+		snprintf(buf, len, "%luM", size >> 20);
 	else
-		cpa_2m_preserved++;
+		snprintf(buf, len, "%luk", size >> 10);
+
+	return buf;
+}
+
+static void cpastats_show_level(struct seq_file *m, enum pgtable_level level)
+{
+	char sz[20];
+
+	cpa_size_str(level, sz, sizeof(sz));
+	seq_printf(m, "%s pages checked:     %16lu\n", sz, cpa_checked[level]);
+	seq_printf(m, "%s pages sameprot:    %16lu\n", sz, cpa_sameprot[level]);
+	seq_printf(m, "%s pages preserved:   %16lu\n", sz,
+		   cpa_preserved[level]);
 }
 
 static int cpastats_show(struct seq_file *m, void *p)
 {
-	seq_printf(m, "1G pages checked:     %16lu\n", cpa_1g_checked);
-	seq_printf(m, "1G pages sameprot:    %16lu\n", cpa_1g_sameprot);
-	seq_printf(m, "1G pages preserved:   %16lu\n", cpa_1g_preserved);
-	seq_printf(m, "2M pages checked:     %16lu\n", cpa_2m_checked);
-	seq_printf(m, "2M pages sameprot:    %16lu\n", cpa_2m_sameprot);
-	seq_printf(m, "2M pages preserved:   %16lu\n", cpa_2m_preserved);
-	seq_printf(m, "4K pages set-checked: %16lu\n", cpa_4k_install);
+	char sz[20];
+
+	cpastats_show_level(m, PGTABLE_LEVEL_PUD);
+	cpastats_show_level(m, PGTABLE_LEVEL_PMD);
+	seq_printf(m, "%s pages set-checked: %16lu\n",
+		   cpa_size_str(PGTABLE_LEVEL_PTE, sz, sizeof(sz)),
+		   cpa_checked[PGTABLE_LEVEL_PTE]);
 	return 0;
 }
 
@@ -213,11 +223,10 @@ static int __init cpa_stats_init(void)
 }
 late_initcall(cpa_stats_init);
 #else
-static inline void cpa_inc_1g_checked(void) { }
-static inline void cpa_inc_2m_checked(void) { }
-static inline void cpa_inc_4k_install(void) { }
-static inline void cpa_inc_lp_sameprot(int level) { }
-static inline void cpa_inc_lp_preserved(int level) { }
+static inline void cpa_inc_pxd_checked(enum pgtable_level level) { }
+static inline void cpa_inc_pte_install(void) { }
+static inline void cpa_inc_pxd_sameprot(enum pgtable_level level) { }
+static inline void cpa_inc_pxd_preserved(enum pgtable_level level) { }
 #endif
 
 
@@ -1041,17 +1050,17 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 	case PGTABLE_LEVEL_PMD:
 		old_prot = pmd_pgprot(*(pmd_t *)kpte);
 		old_pfn = pmd_pfn(*(pmd_t *)kpte);
-		cpa_inc_2m_checked();
 		break;
 	case PGTABLE_LEVEL_PUD:
 		old_prot = pud_pgprot(*(pud_t *)kpte);
 		old_pfn = pud_pfn(*(pud_t *)kpte);
-		cpa_inc_1g_checked();
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	cpa_inc_pxd_checked(level);
+
 	psize = pgtable_level_size(level);
 	pmask = pgtable_level_mask(level);
 
@@ -1097,7 +1106,7 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 	 * range.
 	 */
 	if (pgprot_val(req_prot) == pgprot_val(pgprot_large_2_4k(old_prot))) {
-		cpa_inc_lp_sameprot(level);
+		cpa_inc_pxd_sameprot(level);
 		return 0;
 	}
 
@@ -1133,7 +1142,7 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
 	new_pte = cpa_pte(level, old_pfn, new_prot);
 	__set_pmd_pte(kpte, address, new_pte);
 	cpa->state |= CPA_ST_FLUSHTLB;
-	cpa_inc_lp_preserved(level);
+	cpa_inc_pxd_preserved(level);
 	return 0;
 }
 
@@ -1866,7 +1875,7 @@ static int __change_page_attr(struct cpa_data *cpa)
 		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
-		cpa_inc_4k_install();
+		cpa_inc_pte_install();
 		/* Hand in lpsize = 0 to enforce the protection mechanism */
 		new_prot = static_protections(new_prot, address, pfn, 1, 0,
 					      CPA_PROTECT);

-- 
2.53.0


