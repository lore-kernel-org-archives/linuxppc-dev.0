Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0C606A323
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kx1Ab6qc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvHB38P8z3bmN;
	Thu, 26 Nov 2026 22:20:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795692038;
	cv=none; b=oFOaO/NyipVgbirX9YgQku4vhBMaevMEYXDRJxhkhSVkj8nfS7twYabOYzaVsEgG/CPx/vma+01CUrGKN3Z52ijsO4EAXWUzBp+AIxjpEolfoacKPnLSy8LbqvmgUWw5BrhyXAaJPz6pIU5J8Qh/zesHPwpjvzalZOeqBhq9QVyxDy3UfMVz0a627qEFvJ5xrx0Thr0+v+gY0rFkkvLPtBB1OLdf8pTJ5UXccLH3KIFhWlxBY3s/2WLX1od7i0jPKd2ONwOAJYhJLzYb+G7qRcHE3WjuVkO/RCohRY8f5ttMV6cQ3i4qWICmtD2nXyvssLm8SqOYn3EjG+tFSSbQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795692038; c=relaxed/relaxed;
	bh=rM4+cSkBP6X510/nTqJRrow0GCDm2EsnlCpLERs/6as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=di8OyutMT0Tf2/jdAyIOPzYhnyuTNAjFCHpg89eS2RZERQqAVGMumW2UKcTjSH60DhzOxqgODfQFYfA7FUQuhsKoK2YFLavudG8B065Fu0H8jlQggLD8PwJwgzu1MbARYgv//4XAZmQkT3r2fCpnXcNQxBO0pm4tuC5kHzFdMdTX8opQO1wHDgz752DwweYQltrlfGj8OyQQUWgCCLEOTmmn2iwwVZYL7nv3hgiS8Nw9QYQth42MkS27dpbIq5FGgunKP4EumtwqR6ly1Fxn1WoSUqpg435YOCIri2ziZyyUSCVhw2lGOSGB/625NumnsWq9dcwHR8xWlLj2ufBQvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kx1Ab6qc; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kx1Ab6qc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvH94q01z3bmM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:20:37 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CA26E630FE;
	Thu, 26 Nov 2026 11:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E567B1F000C4;
	Thu, 26 Nov 2026 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692035;
	bh=rM4+cSkBP6X510/nTqJRrow0GCDm2EsnlCpLERs/6as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kx1Ab6qcUM54KkRHDXzVtjMBXuOGt7snMFzSHdZ1b+HJhSZECrTxp+suhOQIt05g8
	 ulPmTyAEzO4hD9Ksq3FP/lBfAG0GX3OSIuJUGLtsmT/CJyQNAPUaAFCgsP4m+6oFjR
	 Ji37csI6i2qNNeSvLjaR3D5hcSPiZUbUkK6vvXbTtxl1JjVIa4eHvVFsfTlpvVJCrl
	 tA4ItitFRfmXoZROL1Pe+z85u0flpuI5rw+XvECSxELuxJdBKYYJNObc4IuioomJLf
	 xMxc6AEhf6CPOk0lTAC7OJsOyG9QxzRrmH4CZOpr+pFhI9qGci+fadxeBxhmr+g7Ww
	 yG7EIx3Ocf//A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:51 +0200
Subject: [PATCH RFC v2 38/54] mm/pageattr: let a leaf cover a contiguous
 block of entries
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-38-723f1e33c3d8@kernel.org>
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

Some architectures map a naturally aligned range with a block of adjacent
entries that the TLB may cache as a single translation: the 16K, 512K and
8M pages of powerpc 8xx, Svnapot on riscv and the contiguous bit of arm64.

The entries of such a block have to change together, or the block has to be
broken up first, exactly like a large page.

Let arch_cpa_decode_leaf() extend a leaf to the whole block, so that the
core keeps the block when a request covers it entirely and splits it
otherwise.

Breaking up a block only rewrites its entries and it does not need to
allocate new page table page, so the core can call arch_cpa_split_leaf()
without dropping cpa_lock.

Update the CPA statistics so that they count contiguous blocks separately
from large pages and single PTEs.

The block counters stay at zero on architectures without blocks.

There are no users yet. powerpc 8xx, riscv and arm64 will use it when they
switch to the core.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/pageattr.c | 79 ++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/mm/pageattr.c b/mm/pageattr.c
index 852e0989dac9..2f357a8c24d2 100644
--- a/mm/pageattr.c
+++ b/mm/pageattr.c
@@ -94,39 +94,63 @@ void cpa_report_meminfo(struct seq_file *m, unsigned long levels)
 
 #ifdef CONFIG_CPA_STATISTICS
 
-static unsigned long cpa_checked[PGTABLE_LEVEL_NUM];
-static unsigned long cpa_sameprot[PGTABLE_LEVEL_NUM];
-static unsigned long cpa_preserved[PGTABLE_LEVEL_NUM];
+struct cpa_stats {
+	unsigned long	checked;
+	unsigned long	sameprot;
+	unsigned long	preserved;
+};
+
+/* Large pages and contiguous blocks, by the level of their entries */
+static struct cpa_stats cpa_pages[PGTABLE_LEVEL_NUM];
+static struct cpa_stats cpa_blocks[PGTABLE_LEVEL_NUM];
 
-static inline void cpa_inc_pxd_checked(enum pgtable_level level)
+static struct cpa_stats *cpa_leaf_stats(const struct cpa_leaf *leaf)
 {
-	cpa_checked[level]++;
+	if (leaf->size != pgtable_level_size(leaf->level))
+		return &cpa_blocks[leaf->level];
+
+	return &cpa_pages[leaf->level];
+}
+
+static inline void cpa_inc_checked(const struct cpa_leaf *leaf)
+{
+	cpa_leaf_stats(leaf)->checked++;
 }
 
 static inline void cpa_inc_pte_install(void)
 {
-	cpa_checked[PGTABLE_LEVEL_PTE]++;
+	cpa_pages[PGTABLE_LEVEL_PTE].checked++;
 }
 
-static inline void cpa_inc_pxd_sameprot(enum pgtable_level level)
+static inline void cpa_inc_sameprot(const struct cpa_leaf *leaf)
 {
-	cpa_sameprot[level]++;
+	cpa_leaf_stats(leaf)->sameprot++;
 }
 
-static inline void cpa_inc_pxd_preserved(enum pgtable_level level)
+static inline void cpa_inc_preserved(const struct cpa_leaf *leaf)
 {
-	cpa_preserved[level]++;
+	cpa_leaf_stats(leaf)->preserved++;
 }
 
 static void cpastats_show_level(struct seq_file *m, enum pgtable_level level)
 {
+	struct cpa_stats *s = &cpa_pages[level];
 	char sz[20];
 
 	cpa_size_str(level, sz, sizeof(sz));
-	seq_printf(m, "%s pages checked:     %16lu\n", sz, cpa_checked[level]);
-	seq_printf(m, "%s pages sameprot:    %16lu\n", sz, cpa_sameprot[level]);
-	seq_printf(m, "%s pages preserved:   %16lu\n", sz,
-		   cpa_preserved[level]);
+	seq_printf(m, "%s pages checked:     %16lu\n", sz, s->checked);
+	seq_printf(m, "%s pages sameprot:    %16lu\n", sz, s->sameprot);
+	seq_printf(m, "%s pages preserved:   %16lu\n", sz, s->preserved);
+}
+
+static void cpastats_show_blocks(struct seq_file *m, enum pgtable_level level)
+{
+	const char *name = pgtable_level_to_str(level);
+	struct cpa_stats *s = &cpa_blocks[level];
+
+	seq_printf(m, "%s blocks checked:   %16lu\n", name, s->checked);
+	seq_printf(m, "%s blocks sameprot:  %16lu\n", name, s->sameprot);
+	seq_printf(m, "%s blocks preserved: %16lu\n", name, s->preserved);
 }
 
 static int cpastats_show(struct seq_file *m, void *p)
@@ -137,7 +161,9 @@ static int cpastats_show(struct seq_file *m, void *p)
 	cpastats_show_level(m, PGTABLE_LEVEL_PMD);
 	seq_printf(m, "%s pages set-checked: %16lu\n",
 		   cpa_size_str(PGTABLE_LEVEL_PTE, sz, sizeof(sz)),
-		   cpa_checked[PGTABLE_LEVEL_PTE]);
+		   cpa_pages[PGTABLE_LEVEL_PTE].checked);
+	cpastats_show_blocks(m, PGTABLE_LEVEL_PMD);
+	cpastats_show_blocks(m, PGTABLE_LEVEL_PTE);
 	return 0;
 }
 
@@ -160,10 +186,10 @@ static int __init cpa_stats_init(void)
 }
 late_initcall(cpa_stats_init);
 #else
-static inline void cpa_inc_pxd_checked(enum pgtable_level level) { }
+static inline void cpa_inc_checked(const struct cpa_leaf *leaf) { }
 static inline void cpa_inc_pte_install(void) { }
-static inline void cpa_inc_pxd_sameprot(enum pgtable_level level) { }
-static inline void cpa_inc_pxd_preserved(enum pgtable_level level) { }
+static inline void cpa_inc_sameprot(const struct cpa_leaf *leaf) { }
+static inline void cpa_inc_preserved(const struct cpa_leaf *leaf) { }
 #endif
 
 static pte_t *cpa_lookup_in_pgd(pgd_t *pgdp, unsigned long address,
@@ -253,10 +279,10 @@ static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 	if (cpa->flags & CPA_REQ_SPLIT)
 		return 1;
 
-	if (level != PGTABLE_LEVEL_PMD && level != PGTABLE_LEVEL_PUD)
+	if (level > PGTABLE_LEVEL_PUD)
 		return -EINVAL;
 
-	cpa_inc_pxd_checked(level);
+	cpa_inc_checked(leaf);
 
 	/*
 	 * Calculate the number of pages, which fit into this large
@@ -284,7 +310,7 @@ static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 	 * range.
 	 */
 	if (pgprot_val(req_prot) == pgprot_val(old_prot)) {
-		cpa_inc_pxd_sameprot(level);
+		cpa_inc_sameprot(leaf);
 		return 0;
 	}
 
@@ -307,7 +333,7 @@ static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 	/* All checks passed. Update the large page mapping. */
 	arch_cpa_modify_leaf(leaf, new_prot);
 	cpa->state |= CPA_ST_FLUSHTLB;
-	cpa_inc_pxd_preserved(level);
+	cpa_inc_preserved(leaf);
 	return 0;
 }
 
@@ -319,6 +345,13 @@ static int split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
 	void *table;
 	int ret = 0;
 
+	/*
+	 * A block of entries is broken up in place, without a page table and
+	 * without dropping cpa_lock.
+	 */
+	if (leaf->size != pgtable_level_size(leaf->level))
+		return arch_cpa_split_leaf(cpa, leaf, NULL);
+
 	spin_unlock(&cpa_lock);
 	table = arch_cpa_alloc_pgtable(leaf);
 	spin_lock(&cpa_lock);
@@ -389,7 +422,7 @@ static int __change_page_attr(struct cpa_data *cpa)
 	if (!cpa_lookup(cpa, address, &leaf))
 		return arch_cpa_process_fault(cpa);
 
-	if (leaf.level == PGTABLE_LEVEL_PTE) {
+	if (leaf.size == PAGE_SIZE) {
 		pgprot_t new_prot;
 		unsigned long pfn = leaf.pfn;
 

-- 
2.53.0


