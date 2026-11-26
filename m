Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF3606A33F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvGXWZv+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvGq11gKz30V2;
	Thu, 26 Nov 2026 22:20:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795692019;
	cv=none; b=TQKFHqIlR4oumyQxX1tAYS8JaV0SQbmGrlGEnR+PRohUn2wzWM6XX1ixsMlolLgDHn0P39nkWgYPiUwn7TPTe+xQaiveZtUEsD4nIMOJMmP2Fc4aKgAAiOebhKLGvd5HxzfuG3wUEhESTvHtyO8Jj/Co92SRN5wEqQxBvaoFNGOEkIeRKlAGdCLkrgE856ao0j+lTWdTpLSdSwpAd+EWHvxLMUZpqy/LXrmhnlLYma2JB364h4h5iB3/cmbFnGb/Nd3bOLD4KPbjiayaQ3Le/IBOvQhZPUZcyuj9YQTc93Tx6LYbQ8O6jPwe61u9MgtjkmQ1TdXHXk8ZNoQft/5PeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795692019; c=relaxed/relaxed;
	bh=ITguBAtaeU1JouI5XylgxXLQvJx8CTSOCOcbVUzTjd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CdOuLj4f7Oul490G5kNiVASdXgHNA+KCzWjo8WZG8O51dAEh0SUYWDdDtKXuEoydc6BW0TxgTUev9Adb2Uq14qUkkKjB8sp6aewytrF4jIPyPj2b/SDDaYJ+tEKWOnaGKt4cbYyDdXqR/d2l4Z7Dv6GaqjqzLi7TetiENV36LR9OnawWBULio13htGLSgTw6fjnlK0LJwcgb/uYgxuDdzlJ4O+rYflB8r3sRtJZYBA6TGCz0xStpjrmO7sAjvZvw6solhLw2qr9jmWufYocZyCCQ8Uu79yGcIHAKqXPWOIavRgXPkyoiZxbphQGhGRzuUrSCkaHm19YM9F+Iv+U+Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvGXWZv+; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvGXWZv+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvGp1S8hz3blv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:20:18 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3F84F4588F;
	Thu, 26 Nov 2026 11:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962C01F00A3D;
	Thu, 26 Nov 2026 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692016;
	bh=ITguBAtaeU1JouI5XylgxXLQvJx8CTSOCOcbVUzTjd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fvGXWZv+8pi99qzU7b5EhDoIXdzzJsiCfHc+1Zlntkr3m3pkhun1WINtqz4rdzsie
	 jziiCB0LdrTQeKoKP+cu5R80r2pIsX/Y0JsIKlz5jTCWUHlJ5PjjGI7kbGWq6SQUBC
	 OH/NSmXziwPx8bzuosEs4237MSu29h0F0RtcX8jYgwEoV/Vjg9phJULHmw3gJouIze
	 9hIqTpIOLEN8A567d+YKTz+F7fcaL7zu2Hm9VGG6vowtOIjNt2ZwOa9fzC16hdBprX
	 fyURUQ8TtPloWpWF1yAFJ3g1MUNAfNtlp8BhC8QfIDp8DVvIbbD1Do5rDdAqZmpJqT
	 FPBg70e6baOtw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:49 +0200
Subject: [PATCH RFC v2 36/54] LoongArch: use the generic CPA core
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-36-723f1e33c3d8@kernel.org>
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

The availability of the generic CPA core makes LoongArch's implementation
of set_memory_*() APIs unnecessary.

The page table walk in arch/loongarch/mm/pageattr.c can be replaced with
several simple hooks required by CPA core.

This way the core can manage the policy decisions and the architecture only
has to take care of the page table manipulation.

Switch to the generic CPA core and its set_memory() entry points.
For LoongArch this means that:

* an empty entry in the range is reported with a warning and -EFAULT
* nothing is written or flushed when nothing changes
* a request that fails flushes the entire TLB
* set_memory_rox() is a single request instead of set_memory_ro() followed
  by set_memory_x()
* requests are serialized by the core, rather than by the init_mm write
  lock
* lazily unmapped vmap areas are purged before a request, so that they do
  not keep stale TLB entries with the old protection

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/loongarch/Kconfig                  |   1 +
 arch/loongarch/include/asm/set_memory.h |   8 +--
 arch/loongarch/mm/pageattr.c            | 102 ++++++++------------------------
 3 files changed, 28 insertions(+), 83 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index bad699e2847f..455a72b8669d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -107,6 +107,7 @@ config LOONGARCH
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
+	select GENERIC_PAGEATTR
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/include/asm/set_memory.h
index 64c7f942e8ec..5496a3ee27da 100644
--- a/arch/loongarch/include/asm/set_memory.h
+++ b/arch/loongarch/include/asm/set_memory.h
@@ -6,12 +6,6 @@
 #ifndef _ASM_LOONGARCH_SET_MEMORY_H
 #define _ASM_LOONGARCH_SET_MEMORY_H
 
-/*
- * Functions to change memory attributes.
- */
-int set_memory_x(unsigned long addr, int numpages);
-int set_memory_nx(unsigned long addr, int numpages);
-int set_memory_ro(unsigned long addr, int numpages);
-int set_memory_rw(unsigned long addr, int numpages);
+#include <asm-generic/set_memory.h>
 
 #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index 11cea93c7415..a90380b387d3 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -3,100 +3,50 @@
  * Copyright (C) 2024 Loongson Technology Corporation Limited
  */
 
-#include <linux/pagewalk.h>
+#include <linux/pageattr.h>
 #include <linux/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/tlbflush.h>
 
-struct pageattr_masks {
-	pgprot_t set_mask;
-	pgprot_t clear_mask;
-};
-
-static unsigned long set_pageattr_masks(unsigned long val, struct mm_walk *walk)
-{
-	unsigned long new_val = val;
-	struct pageattr_masks *masks = walk->private;
-
-	new_val &= ~(pgprot_val(masks->clear_mask));
-	new_val |= (pgprot_val(masks->set_mask));
-
-	return new_val;
-}
-
-static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
-			      unsigned long next, struct mm_walk *walk)
+void arch_cpa_decode_leaf(struct cpa_leaf *leaf)
 {
-	pte_t val = ptep_get(pte);
-
-	val = __pte(set_pageattr_masks(pte_val(val), walk));
-	set_pte(pte, val);
+	pte_t pte = ptep_get(leaf->kpte);
 
-	return 0;
+	leaf->pfn = pte_pfn(pte);
+	leaf->prot = pte_pgprot(pte);
 }
 
-static int pageattr_pte_hole(unsigned long addr, unsigned long next,
-			     int depth, struct mm_walk *walk)
+void arch_cpa_modify_leaf(struct cpa_leaf *leaf, pgprot_t prot)
 {
-	return 0;
+	set_pte(leaf->kpte, pfn_pte(leaf->pfn, prot));
 }
 
-static const struct mm_walk_ops pageattr_ops = {
-	.pte_entry = pageattr_pte_entry,
-	.pte_hole = pageattr_pte_hole,
-	.walk_lock = PGWALK_RDLOCK,
-};
-
-static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask, pgprot_t clear_mask)
+void arch_cpa_flush(struct cpa_data *cpa)
 {
-	int ret;
-	unsigned long start = addr;
-	unsigned long end = start + PAGE_SIZE * numpages;
-	struct pageattr_masks masks = {
-		.set_mask = set_mask,
-		.clear_mask = clear_mask
-	};
-
-	if (!numpages)
-		return 0;
-
-	mmap_write_lock(&init_mm);
-	ret = walk_kernel_page_table_range(start, end, &pageattr_ops, NULL, &masks);
-	mmap_write_unlock(&init_mm);
-
-	flush_tlb_kernel_range(start, end);
+	if (cpa->state & CPA_ST_FLUSH_ALL) {
+		flush_tlb_all();
+		return;
+	}
 
-	return ret;
+	cpa_flush_tlb_kernel_range(cpa);
 }
 
-int set_memory_x(unsigned long addr, int numpages)
-{
-	if (addr < vm_map_base)
-		return 0;
-
-	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_NO_EXEC));
-}
-
-int set_memory_nx(unsigned long addr, int numpages)
-{
-	if (addr < vm_map_base)
-		return 0;
-
-	return __set_memory(addr, numpages, __pgprot(_PAGE_NO_EXEC), __pgprot(0));
-}
+static const struct cpa_op_prot cpa_ops[CPA_OP_NR] = {
+	[CPA_OP_RO]	= { .clr = __pgprot(_PAGE_WRITE | _PAGE_DIRTY) },
+	[CPA_OP_RW]	= { .set = __pgprot(_PAGE_WRITE | _PAGE_DIRTY) },
+	[CPA_OP_X]	= { .clr = __pgprot(_PAGE_NO_EXEC) },
+	[CPA_OP_NX]	= { .set = __pgprot(_PAGE_NO_EXEC) },
+	[CPA_OP_ROX]	= { .clr = __pgprot(_PAGE_WRITE | _PAGE_DIRTY |
+					   _PAGE_NO_EXEC) },
+};
 
-int set_memory_ro(unsigned long addr, int numpages)
+int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op)
 {
-	if (addr < vm_map_base)
+	/* The direct mapping windows below vm_map_base have no page tables */
+	if (cpa->addr < vm_map_base)
 		return 0;
 
-	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_WRITE | _PAGE_DIRTY));
-}
+	cpa_init_op(cpa, &cpa_ops[op]);
 
-int set_memory_rw(unsigned long addr, int numpages)
-{
-	if (addr < vm_map_base)
-		return 0;
-
-	return __set_memory(addr, numpages, __pgprot(_PAGE_WRITE | _PAGE_DIRTY), __pgprot(0));
+	return 0;
 }

-- 
2.53.0


