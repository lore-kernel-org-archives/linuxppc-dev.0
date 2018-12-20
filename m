Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C849DC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 06:48:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4232176F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 06:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4232176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L2R831XXzDr45
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 17:48:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L2Fl6qvKzDqnV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 17:40:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43L2Fh0h7SzB09Zv;
 Thu, 20 Dec 2018 07:40:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id bPUh9yFPwcNh; Thu, 20 Dec 2018 07:40:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43L2Fh072lz9vB1r;
 Thu, 20 Dec 2018 07:40:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DC2C68B796;
 Thu, 20 Dec 2018 07:40:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id I3tyefgU1-1G; Thu, 20 Dec 2018 07:40:40 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 89A438B755;
 Thu, 20 Dec 2018 07:40:40 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 6160271733; Thu, 20 Dec 2018 06:40:40 +0000 (UTC)
Message-Id: <e306d91808a906cfc0db33f803bb01eed93b6015.1545287470.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1545287470.git.christophe.leroy@c-s.fr>
References: <cover.1545287470.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 3/3] powerpc/nohash32: Add KASAN support
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com, aneesh.kumar@linux.ibm.com
Date: Thu, 20 Dec 2018 06:40:40 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch adds KASAN support for nohash PPC32.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                         |  1 +
 arch/powerpc/include/asm/kasan.h             | 22 +++++++++
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +
 arch/powerpc/include/asm/ppc_asm.h           |  5 ++
 arch/powerpc/include/asm/setup.h             |  5 ++
 arch/powerpc/include/asm/string.h            | 14 ++++++
 arch/powerpc/kernel/Makefile                 |  3 ++
 arch/powerpc/kernel/setup-common.c           |  2 +
 arch/powerpc/kernel/setup_32.c               |  3 ++
 arch/powerpc/lib/Makefile                    |  2 +
 arch/powerpc/lib/copy_32.S                   |  9 ++--
 arch/powerpc/mm/Makefile                     |  3 ++
 arch/powerpc/mm/dump_linuxpagetables.c       |  8 +++
 arch/powerpc/mm/kasan_init.c                 | 73 ++++++++++++++++++++++++++++
 arch/powerpc/mm/mem.c                        |  4 ++
 15 files changed, 153 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kasan.h
 create mode 100644 arch/powerpc/mm/kasan_init.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8ea7c2c02cbf..44be55c087be 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -174,6 +174,7 @@ config PPC
 	select GENERIC_TIME_VSYSCALL
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_KASAN			if PPC32 && PPC_MMU_NOHASH
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
new file mode 100644
index 000000000000..3c2f98c40307
--- /dev/null
+++ b/arch/powerpc/include/asm/kasan.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_KASAN_H
+#define __ASM_KASAN_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/page.h>
+#include <asm/pgtable-types.h>
+#include <asm/fixmap.h>
+
+#define KASAN_SHADOW_SCALE_SHIFT	3
+#define KASAN_SHADOW_SIZE	((~0UL - PAGE_OFFSET + 1) >> KASAN_SHADOW_SCALE_SHIFT)
+
+#define KASAN_SHADOW_START      (ALIGN_DOWN(FIXADDR_START - KASAN_SHADOW_SIZE, PGDIR_SIZE))
+#define KASAN_SHADOW_END        (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
+#define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_START - (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT))
+
+void kasan_early_init(void);
+void kasan_init(void);
+
+#endif
+#endif
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index bed433358260..b3b52f02be1a 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -71,6 +71,8 @@ extern int icache_44x_need_flush;
  */
 #ifdef CONFIG_HIGHMEM
 #define KVIRT_TOP	PKMAP_BASE
+#elif defined(CONFIG_KASAN)
+#define KVIRT_TOP	KASAN_SHADOW_START
 #else
 #define KVIRT_TOP	(0xfe000000UL)	/* for now, could be FIXMAP_BASE ? */
 #endif
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index b5d023680801..80d520e34552 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -251,6 +251,11 @@ GLUE(.,name):
 
 #define _GLOBAL_TOC(name) _GLOBAL(name)
 
+#define KASAN_OVERRIDE(x, y) \
+	.weak x;	     \
+	.set x, y
+
+
 #endif
 
 /*
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 1fffbba8d6a5..16572484149c 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -67,6 +67,11 @@ void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
 static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
 #endif
 
+#ifndef CONFIG_KASAN
+static inline void kasan_early_init(void) { }
+static inline void kasan_init(void) { }
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_SETUP_H */
diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 1647de15a31e..28795a72aba1 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -27,6 +27,20 @@ extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
 extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
 
+void * __memset(void *, int, __kernel_size_t);
+void * __memcpy(void *, const void *, __kernel_size_t);
+void * __memmove(void *, const void *, __kernel_size_t);
+
+#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
+/*
+ * For files that are not instrumented (e.g. mm/slub.c) we
+ * should use not instrumented version of mem* functions.
+ */
+#define memcpy(dst, src, len) __memcpy(dst, src, len)
+#define memmove(dst, src, len) __memmove(dst, src, len)
+#define memset(s, c, n) __memset(s, c, n)
+#endif
+
 #ifdef CONFIG_PPC64
 #define __HAVE_ARCH_MEMSET32
 #define __HAVE_ARCH_MEMSET64
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index e9a9419b98b6..edcb65188d3e 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -31,6 +31,9 @@ CFLAGS_REMOVE_btext.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_prom.o = $(CC_FLAGS_FTRACE)
 endif
 
+KASAN_SANITIZE_early_32.o := n
+KASAN_SANITIZE_cputable.o := n
+
 obj-y				:= cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
 				   process.o systbl.o idle.o \
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 4fe7740917a7..31958e014c10 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -977,6 +977,8 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 
+	kasan_init();
+
 	/* Initialize the MMU context management stuff. */
 	mmu_context_init();
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 62efe32d890d..6676b2c786af 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -17,6 +17,7 @@
 #include <linux/console.h>
 #include <linux/memblock.h>
 #include <linux/export.h>
+#include <linux/kasan.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -77,6 +78,8 @@ notrace void __init machine_init(u64 dt_ptr)
 					       patch__memset_nocache);
 	unsigned long insn;
 
+	kasan_early_init();
+
 	/* Configure static keys first, now that we're relocated. */
 	setup_feature_keys();
 
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 3bf9fc6fd36c..0e7c6ae1ab7c 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -8,6 +8,8 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
 
+KASAN_SANITIZE_feature-fixups.o := n
+
 obj-y += string.o alloc.o code-patching.o feature-fixups.o
 
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o strlen_32.o
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index ba66846fe973..4d8a1c73b4cf 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -91,7 +91,8 @@ EXPORT_SYMBOL(memset16)
  * We therefore skip the optimised bloc that uses dcbz. This jump is
  * replaced by a nop once cache is active. This is done in machine_init()
  */
-_GLOBAL(memset)
+_GLOBAL(__memset)
+KASAN_OVERRIDE(memset, __memset)
 	cmplwi	0,r5,4
 	blt	7f
 
@@ -163,12 +164,14 @@ EXPORT_SYMBOL(memset)
  * We therefore jump to generic_memcpy which doesn't use dcbz. This jump is
  * replaced by a nop once cache is active. This is done in machine_init()
  */
-_GLOBAL(memmove)
+_GLOBAL(__memmove)
+KASAN_OVERRIDE(memmove, __memmove)
 	cmplw	0,r3,r4
 	bgt	backwards_memcpy
 	/* fall through */
 
-_GLOBAL(memcpy)
+_GLOBAL(__memcpy)
+KASAN_OVERRIDE(memcpy, __memcpy)
 1:	b	generic_memcpy
 	patch_site	1b, patch__memcpy_nocache
 
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index f965fc33a8b7..d6b76f25f6de 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -7,6 +7,8 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
 
+KASAN_SANITIZE_kasan_init.o := n
+
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
 				   init-common.o mmu_context.o drmem.o
@@ -55,3 +57,4 @@ obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o
 endif
 obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
 obj-$(CONFIG_PPC_MEM_KEYS)	+= pkeys.o
+obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 6aa41669ac1a..c862b48118f1 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -94,6 +94,10 @@ static struct addr_marker address_markers[] = {
 	{ 0,	"Consistent mem start" },
 	{ 0,	"Consistent mem end" },
 #endif
+#ifdef CONFIG_KASAN
+	{ 0,	"kasan shadow mem start" },
+	{ 0,	"kasan shadow mem end" },
+#endif
 #ifdef CONFIG_HIGHMEM
 	{ 0,	"Highmem PTEs start" },
 	{ 0,	"Highmem PTEs end" },
@@ -310,6 +314,10 @@ static void populate_markers(void)
 	address_markers[i++].start_address = IOREMAP_TOP +
 					     CONFIG_CONSISTENT_SIZE;
 #endif
+#ifdef CONFIG_KASAN
+	address_markers[i++].start_address = KASAN_SHADOW_START;
+	address_markers[i++].start_address = KASAN_SHADOW_END;
+#endif
 #ifdef CONFIG_HIGHMEM
 	address_markers[i++].start_address = PKMAP_BASE;
 	address_markers[i++].start_address = PKMAP_ADDR(LAST_PKMAP);
diff --git a/arch/powerpc/mm/kasan_init.c b/arch/powerpc/mm/kasan_init.c
new file mode 100644
index 000000000000..5547c82673f9
--- /dev/null
+++ b/arch/powerpc/mm/kasan_init.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kasan.h>
+#include <linux/printk.h>
+#include <linux/memblock.h>
+#include <asm/pgalloc.h>
+
+void __init kasan_early_init(void)
+{
+	unsigned long addr = KASAN_SHADOW_START & PGDIR_MASK;
+	unsigned long end = KASAN_SHADOW_END;
+	unsigned long next;
+	pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(addr), addr), addr);
+	int i;
+	phys_addr_t pa = __pa(kasan_zero_page);
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		__set_pte_at(&init_mm, (unsigned long)kasan_zero_page, kasan_zero_pte + i,
+			     pfn_pte(PHYS_PFN(pa), PAGE_KERNEL_RO), 0);
+
+	do {
+		next = pgd_addr_end(addr, end);
+		pmd_populate_kernel(&init_mm, pmd, kasan_zero_pte);
+	} while (pmd++, addr = next, addr != end);
+
+	pr_info("KASAN early init done\n");
+}
+
+static void __init kasan_init_region(struct memblock_region *reg)
+{
+	void *start = __va(reg->base);
+	void *end = __va(reg->base + reg->size);
+	unsigned long k_start, k_end, k_cur, k_next;
+	pmd_t *pmd;
+
+	if (start >= end)
+		return;
+
+	k_start = (unsigned long)kasan_mem_to_shadow(start);
+	k_end = (unsigned long)kasan_mem_to_shadow(end);
+	pmd = pmd_offset(pud_offset(pgd_offset_k(k_start), k_start), k_start);
+
+	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd++) {
+		k_next = pgd_addr_end(k_cur, k_end);
+		if ((void*)pmd_page_vaddr(*pmd) == kasan_zero_pte) {
+			pte_t *new = pte_alloc_one_kernel(&init_mm, k_cur);
+
+			if (!new)
+				panic("kasan: pte_alloc_one_kernel() failed");
+			memcpy(new, kasan_zero_pte, PTE_TABLE_SIZE);
+			pmd_populate_kernel(&init_mm, pmd, new);
+		}
+	};
+
+	for (k_cur = k_start; k_cur < k_end; k_cur += PAGE_SIZE) {
+		phys_addr_t pa = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+		pte_t pte = pfn_pte(PHYS_PFN(pa), PAGE_KERNEL);
+
+		pmd = pmd_offset(pud_offset(pgd_offset_k(k_cur), k_cur), k_cur);
+		pte_update(pte_offset_kernel(pmd, k_cur), ~0, pte_val(pte));
+	}
+	flush_tlb_kernel_range(k_start, k_end);
+}
+
+void __init kasan_init(void)
+{
+	struct memblock_region *reg;
+
+	for_each_memblock(memory, reg)
+		kasan_init_region(reg);
+
+	pr_info("KASAN init done\n");
+}
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 065c37d54b49..4fc3183654de 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -381,6 +381,10 @@ void __init mem_init(void)
 	pr_info("  * 0x%08lx..0x%08lx  : highmem PTEs\n",
 		PKMAP_BASE, PKMAP_ADDR(LAST_PKMAP));
 #endif /* CONFIG_HIGHMEM */
+#ifdef CONFIG_KASAN
+	pr_info("  * 0x%08lx..0x%08lx  : kasan shadow mem\n",
+		KASAN_SHADOW_START, KASAN_SHADOW_END);
+#endif
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	pr_info("  * 0x%08lx..0x%08lx  : consistent mem\n",
 		IOREMAP_TOP, IOREMAP_TOP + CONFIG_CONSISTENT_SIZE);
-- 
2.13.3

