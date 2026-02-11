Return-Path: <linuxppc-dev+bounces-16806-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53192EB2719
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Feb 2026 10:32:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9vs10C86z2yY0;
	Wed, 11 Feb 2026 21:32:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770805972;
	cv=none; b=V70DOOWlLD/JEpvoE9E7fc2De5fLCEscXsMXA+uN9SS06f6s9ZlI7GiqHpN10xzDEwj2WhhFd90g77099K8F18m09nAcQMsD42OzoY7WgC0rZx03KcWBQajFwwJIEkxrpgNUEKnv9ShyF8B03Tb1vjujBPxq+3pTrF2ndeHDxNzp412gvnOPoouTz5E9SXrhhzPRMtCZ629SvE99Kwh7pxe8AQ/vVY/3Vfqw9EtXs3lm/zK5CE2aRjpNGPQfR+CSaxxJaFNy0EjuGWzTPSyQ6Z/Kjlr1dbemPRVObdq9WkvNax1FWfI+DRNb9I6qd7mXlEihSLkfDPvy/XRxiWMevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770805972; c=relaxed/relaxed;
	bh=WoHQIuiEqdW57fPr0bquSmA5wnTLfNUngV079oNlBzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdtVumPQM2exg+DSkzff+rp3qRHsdEPe5V2xGxSKHD5T5M7/Fu7tBtu6aKtaROF594uM982fARjN0SKesgz9bx1c8VpwOKREGHyLkP89UUZXV8+Ll13SjgYh5FfA/jFLAa2VN93RJDOE2b7qfI5Qsnc2GGD5O9gdhAfovXHSHTZ+DgtwVnIrZLrWNBetPbnoEOfAwk/5QebtaFMrVZx4zaJWM1/zzG/oiCjfv4WC2RZOh0yIwyhcMSSD2kUCsKVTz25KriSXlFuTUeXaLZAI3N0/5m4jSr20vptzSCl/o9JlRAXUZ01r3DXykK7dTIfGEC3UrsuNyKD3soP+cS4NOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VUycx2g0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VUycx2g0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9vs02Rlmz2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 21:32:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9DD6140DFA;
	Wed, 11 Feb 2026 10:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37C2C2BCAF;
	Wed, 11 Feb 2026 10:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770805970;
	bh=WXj3bDUynhmJwIWcqszyv0wbTX5I8QPCpk4+eeqSnq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUycx2g0refsXHYPZVpEU+UC7PHYsiruAyCk0E2NjULDdTGpkmomFQafKHUOTFGfN
	 gxdwH68dJxpGp5uoQ4bCIYVF9q/ZtWZyBrRXQKklHUNBBv4tXopKimIWb6HO1xITWD
	 v5Le7kpV2WyO2ymXn0Iru7RhLgig1FDLpKEZLiaW4uloDE3fqoRPWZQHcg4WZLcxzC
	 Dem6wAhAyVX6Jeh2Hi5hO5aKu49m5ADtB9baTMfm2NL2MQ5Xgny2uugfwPkwNfT/Sh
	 55TTMaB6nztE9wmgPYA3G+uvSqqAXPlhRNT70FMQNqDaWyvoaKR0G5d15Xri9RCkaK
	 z/9dYoHmO4k7Q==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v3 4/4] mm: cache struct page for empty_zero_page and return it from ZERO_PAGE()
Date: Wed, 11 Feb 2026 12:31:41 +0200
Message-ID: <20260211103141.3215197-5-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211103141.3215197-1-rppt@kernel.org>
References: <20260211103141.3215197-1-rppt@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

For most architectures every invocation of ZERO_PAGE() does
virt_to_page(empty_zero_page). But empty_zero_page is in BSS and it is
enough to get its struct page once at initialization time and then use
it whenever a zero page should be accessed.

Add yet another __zero_page variable that will be initialized as
virt_to_page(empty_zero_page) for most architectures in a weak
arch_setup_zero_pages() function.

For architectures that use colored zero pages (MIPS and s390) rename their
setup_zero_pages() to arch_setup_zero_pages() and make it global rather
than static.

For architectures that cannot use virt_to_page() for BSS (arm64 and
sparc64) add override of arch_setup_zero_pages().

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/include/asm/pgtable.h    |  6 ------
 arch/arm64/mm/init.c                |  5 +++++
 arch/mips/mm/init.c                 | 11 +----------
 arch/s390/mm/init.c                 |  4 +---
 arch/sparc/include/asm/pgtable_64.h |  3 ---
 arch/sparc/mm/init_64.c             | 17 +++++++----------
 include/linux/pgtable.h             | 11 ++++++++---
 mm/mm_init.c                        | 21 +++++++++++++++++----
 8 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 63da07398a30..2c1ec7cc8612 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -106,12 +106,6 @@ static inline void arch_leave_lazy_mmu_mode(void)
 #define flush_tlb_fix_spurious_fault_pmd(vma, address, pmdp)	\
 	local_flush_tlb_page_nonotify(vma, address)
 
-/*
- * ZERO_PAGE is a global shared page that is always zero: used
- * for zero-mapped memory areas etc..
- */
-#define ZERO_PAGE(vaddr)	phys_to_page(__pa_symbol(empty_zero_page))
-
 #define pte_ERROR(e)	\
 	pr_err("%s:%d: bad pte %016llx.\n", __FILE__, __LINE__, pte_val(e))
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 96711b8578fd..417ec7efe569 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -328,6 +328,11 @@ void __init bootmem_init(void)
 	memblock_dump_all();
 }
 
+void __init arch_setup_zero_pages(void)
+{
+	__zero_page = phys_to_page(__pa_symbol(empty_zero_page));
+}
+
 void __init arch_mm_preinit(void)
 {
 	unsigned int flags = SWIOTLB_VERBOSE;
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 4f6449ad02ca..55b25e85122a 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -56,10 +56,7 @@ unsigned long empty_zero_page, zero_page_mask;
 EXPORT_SYMBOL_GPL(empty_zero_page);
 EXPORT_SYMBOL(zero_page_mask);
 
-/*
- * Not static inline because used by IP27 special magic initialization code
- */
-static void __init setup_zero_pages(void)
+void __init arch_setup_zero_pages(void)
 {
 	unsigned int order;
 
@@ -450,7 +447,6 @@ void __init arch_mm_preinit(void)
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (PFN_PTE_SHIFT > PAGE_SHIFT));
 
 	maar_init();
-	setup_zero_pages();	/* Setup zeroed pages.  */
 	highmem_init();
 
 #ifdef CONFIG_64BIT
@@ -461,11 +457,6 @@ void __init arch_mm_preinit(void)
 				0x80000000 - 4, KCORE_TEXT);
 #endif
 }
-#else  /* CONFIG_NUMA */
-void __init arch_mm_preinit(void)
-{
-	setup_zero_pages();	/* This comes from node 0 */
-}
 #endif /* !CONFIG_NUMA */
 
 void free_init_pages(const char *what, unsigned long begin, unsigned long end)
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 3c20475cbee2..1f72efc2a579 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -69,7 +69,7 @@ unsigned long empty_zero_page, zero_page_mask;
 EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(zero_page_mask);
 
-static void __init setup_zero_pages(void)
+void __init arch_setup_zero_pages(void)
 {
 	unsigned long total_pages = memblock_estimated_nr_free_pages();
 	unsigned int order;
@@ -159,8 +159,6 @@ void __init arch_mm_preinit(void)
 	cpumask_set_cpu(0, mm_cpumask(&init_mm));
 
 	pv_init();
-
-	setup_zero_pages();	/* Setup zeroed pages. */
 }
 
 unsigned long memory_block_size_bytes(void)
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 615f460c50af..74ede706fb32 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -210,9 +210,6 @@ extern unsigned long _PAGE_CACHE;
 extern unsigned long pg_iobits;
 extern unsigned long _PAGE_ALL_SZ_BITS;
 
-extern struct page *mem_map_zero;
-#define ZERO_PAGE(vaddr)	(mem_map_zero)
-
 /* PFNs are real physical page numbers.  However, mem_map only begins to record
  * per-page information starting at pfn_base.  This is to handle systems where
  * the first physical page in the machine is at some huge physical address,
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 0cc8de2fea90..707c1df67d79 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -177,9 +177,6 @@ extern unsigned long sparc_ramdisk_image64;
 extern unsigned int sparc_ramdisk_image;
 extern unsigned int sparc_ramdisk_size;
 
-struct page *mem_map_zero __read_mostly;
-EXPORT_SYMBOL(mem_map_zero);
-
 unsigned int sparc64_highest_unlocked_tlb_ent __read_mostly;
 
 unsigned long sparc64_kern_pri_context __read_mostly;
@@ -2496,11 +2493,17 @@ static void __init register_page_bootmem_info(void)
 			register_page_bootmem_info_node(NODE_DATA(i));
 #endif
 }
-void __init mem_init(void)
+
+void __init arch_setup_zero_pages(void)
 {
 	phys_addr_t zero_page_pa = kern_base +
 		((unsigned long)&empty_zero_page[0] - KERNBASE);
 
+	__zero_page = phys_to_page(zero_page_pa);
+}
+
+void __init mem_init(void)
+{
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
 	 * might set fields in deferred struct pages that have not yet been
@@ -2509,12 +2512,6 @@ void __init mem_init(void)
 	 */
 	register_page_bootmem_info();
 
-	/*
-	 * Set up the zero page, mark it reserved, so that page count
-	 * is not manipulated when freeing the page from user ptes.
-	 */
-	mem_map_zero = pfn_to_page(PHYS_PFN(zero_page_pa));
-
 	if (tlb_type == cheetah || tlb_type == cheetah_plus)
 		cheetah_ecache_flush_init();
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 3d48eea57cd2..1da21ec62836 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1894,6 +1894,8 @@ static inline void pfnmap_setup_cachemode_pfn(unsigned long pfn, pgprot_t *prot)
  * For architectures that don't __HAVE_COLOR_ZERO_PAGE the zero page lives in
  * empty_zero_page in BSS.
  */
+void arch_setup_zero_pages(void);
+
 #ifdef __HAVE_COLOR_ZERO_PAGE
 static inline int is_zero_pfn(unsigned long pfn)
 {
@@ -1921,10 +1923,13 @@ static inline unsigned long zero_pfn(unsigned long addr)
 }
 
 extern uint8_t empty_zero_page[PAGE_SIZE];
+extern struct page *__zero_page;
 
-#ifndef ZERO_PAGE
-#define ZERO_PAGE(vaddr) ((void)(vaddr),virt_to_page(empty_zero_page))
-#endif
+static inline struct page *_zero_page(unsigned long addr)
+{
+	return __zero_page;
+}
+#define ZERO_PAGE(vaddr) _zero_page(vaddr)
 
 #endif /* __HAVE_COLOR_ZERO_PAGE */
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1eac634ece1a..b08608c1b71d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -59,7 +59,10 @@ EXPORT_SYMBOL(zero_page_pfn);
 #ifndef __HAVE_COLOR_ZERO_PAGE
 uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
-#endif
+
+struct page *__zero_page __ro_after_init;
+EXPORT_SYMBOL(__zero_page);
+#endif /* __HAVE_COLOR_ZERO_PAGE */
 
 #ifdef CONFIG_DEBUG_MEMORY_INIT
 int __meminitdata mminit_loglevel;
@@ -2675,12 +2678,21 @@ static void __init mem_init_print_info(void)
 		);
 }
 
-static int __init init_zero_page_pfn(void)
+#ifndef __HAVE_COLOR_ZERO_PAGE
+/*
+ * architectures that __HAVE_COLOR_ZERO_PAGE must define this function
+ */
+void __init __weak arch_setup_zero_pages(void)
+{
+	__zero_page = virt_to_page(empty_zero_page);
+}
+#endif
+
+static void __init init_zero_page_pfn(void)
 {
+	arch_setup_zero_pages();
 	zero_page_pfn = page_to_pfn(ZERO_PAGE(0));
-	return 0;
 }
-early_initcall(init_zero_page_pfn);
 
 void __init __weak arch_mm_preinit(void)
 {
@@ -2704,6 +2716,7 @@ void __init mm_core_init_early(void)
 void __init mm_core_init(void)
 {
 	arch_mm_preinit();
+	init_zero_page_pfn();
 
 	/* Initializations relying on SMP setup */
 	BUILD_BUG_ON(MAX_ZONELISTS > 2);
-- 
2.51.0


