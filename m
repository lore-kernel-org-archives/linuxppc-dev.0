Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC75AC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 17:42:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE662077B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 17:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pUEdzvU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE662077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443p2k2rYyzDqFm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 04:42:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="pUEdzvU1"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443nmn2bQ3zDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 04:30:01 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 443nmh356zz9v4Y1;
 Tue, 19 Feb 2019 18:29:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=pUEdzvU1; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ud03FGk05IFf; Tue, 19 Feb 2019 18:29:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 443nmh1v9kz9v4Xq;
 Tue, 19 Feb 2019 18:29:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550597396; bh=pOPjSMbDL2AOqdn2vAGCGHTn/6m4V17A4t9fXj2wmXE=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=pUEdzvU1VDg4s+yI21lTHnWo09trbeDljdy8DzIRuFiL/PX36Sp0QzasZnZz7WKku
 qpiWHktl0ERcKll2RvIW8EcnVAHyOOv6XXyQGZd95E31WEWMWcG1rYLReK2/LM6Y3Q
 G3J4dJPuKa8Y7q6xl1IPQoDg8tEsAFMAaFpGmHrk=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E4F308B7FF;
 Tue, 19 Feb 2019 18:29:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Eg-KedQKj9m9; Tue, 19 Feb 2019 18:29:57 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 98AC78B7F9;
 Tue, 19 Feb 2019 18:29:57 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 7FF0C6E81D; Tue, 19 Feb 2019 17:29:57 +0000 (UTC)
Message-Id: <72731efff99d1b9b86a75501711d212f0c0d473d.1550597162.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550597162.git.christophe.leroy@c-s.fr>
References: <cover.1550597162.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC WIP PATCH 3/3] powerpc: KASAN for 64bit Book3E
To: Daniel Axtens <dja@axtens.net>
Date: Tue, 19 Feb 2019 17:29:57 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Daniel Axtens <dja@axtens.net>

Wire up KASAN. Only outline instrumentation is supported.

The KASAN shadow area is mapped into vmemmap space:
0x8000 0400 0000 0000 to 0x8000 0600 0000 0000.
To do this we require that vmemmap be disabled. (This is the default
in the kernel config that QorIQ provides for the machine in their
SDK anyway - they use flat memory.)

Only the kernel linear mapping (0xc000...) is checked. The vmalloc and
ioremap areas (also in 0x800...) are all mapped to a zero page. As
with the Book3S hash series, this requires overriding the memory <->
shadow mapping.

Also, as with both previous 64-bit series, early instrumentation is not
supported.  It would allow us to drop the kasan_arch_is_ready()
hook in the KASAN core, but it's tricky to get it set up early enough:
we need it setup before the first call to instrumented code like printk().
Perhaps in the future.

Only KASAN_MINIMAL works.

Lightly tested on e6500. KVM, kexec and xmon have not been tested.

The test_kasan module fires warnings as expected, except for the
following tests:

 - Expected/by design:
kasan test: memcg_accounted_kmem_cache allocate memcg accounted object

 - Due to only supporting KASAN_MINIMAL:
kasan test: kasan_stack_oob out-of-bounds on stack
kasan test: kasan_global_oob out-of-bounds global variable
kasan test: kasan_alloca_oob_left out-of-bounds to left on alloca
kasan test: kasan_alloca_oob_right out-of-bounds to right on alloca
kasan test: use_after_scope_test use-after-scope on int
kasan test: use_after_scope_test use-after-scope on array

Thanks to those who have done the heavy lifting over the past several years:
 - Christophe's 32 bit series: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-February/185379.html
 - Aneesh's Book3S hash series: https://lwn.net/Articles/655642/
 - Balbir's Book3S radix series: https://patchwork.ozlabs.org/patch/795211/

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/Kconfig                         |  1 +
 arch/powerpc/Makefile                        |  2 +
 arch/powerpc/include/asm/kasan.h             | 56 +++++++++++++++++++++++++++-
 arch/powerpc/mm/Makefile                     |  2 +
 arch/powerpc/mm/kasan/Makefile               |  1 +
 arch/powerpc/mm/kasan/kasan_init_book3e_64.c | 51 +++++++++++++++++++++++++
 6 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/mm/kasan/kasan_init_book3e_64.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 850b06def84f..2c7c20d52778 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -176,6 +176,7 @@ config PPC
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN			if PPC32
+	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && !SPARSEMEM_VMEMMAP
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 06d085558d21..d1943d892db2 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -428,6 +428,7 @@ endif
 endif
 
 ifdef CONFIG_KASAN
+ifdef CONFIG_PPC32
 ifndef CONFIG_PPC_BOOK3S_32
 prepare: kasan_prepare
 
@@ -435,6 +436,7 @@ kasan_prepare: prepare0
        $(eval KASAN_SHADOW_OFFSET = $(shell awk '{if ($$2 == "KASAN_SHADOW_OFFSET") print $$3;}' include/generated/asm-offsets.h))
 endif
 endif
+endif
 
 # Check toolchain versions:
 # - gcc-4.6 is the minimum kernel-wide version so nothing required.
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index 97b5ccf0702f..6b2cd5ade185 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -15,6 +15,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/page.h>
+#include <asm/pgtable.h>
 #include <asm/pgtable-types.h>
 #include <linux/jump_label.h>
 
@@ -25,6 +26,7 @@
 
 #define KASAN_SHADOW_END	(KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
 
+#ifdef CONFIG_PPC32
 #include <asm/fixmap.h>
 
 #define KASAN_SHADOW_START	(ALIGN_DOWN(FIXADDR_START - KASAN_SHADOW_SIZE, \
@@ -33,13 +35,15 @@
 #define KASAN_SHADOW_SIZE	((~0UL - PAGE_OFFSET + 1) >> KASAN_SHADOW_SCALE_SHIFT)
 
 void kasan_early_init(void);
+#endif /* CONFIG_PPC32 */
+
 void kasan_init(void);
 
 extern struct static_key_false powerpc_kasan_enabled_key;
 
 static inline bool kasan_arch_is_ready(void)
 {
-	if (!IS_ENABLED(CONFIG_BOOK3S_32))
+	if (IS_ENABLED(CONFIG_PPC_32) && !IS_ENABLED(CONFIG_BOOK3S_32))
 		return true;
 	if (static_branch_likely(&powerpc_kasan_enabled_key))
 		return true;
@@ -47,5 +51,55 @@ static inline bool kasan_arch_is_ready(void)
 }
 #define kasan_arch_is_ready kasan_arch_is_ready
 
+#ifdef CONFIG_PPC_BOOK3E_64
+#define KASAN_SHADOW_START VMEMMAP_BASE
+#define KASAN_SHADOW_SIZE	(KERN_VIRT_SIZE >> KASAN_SHADOW_SCALE_SHIFT)
+
+static inline void *kasan_mem_to_shadow_book3e(const void *addr)
+{
+	if ((unsigned long)addr >= KERN_VIRT_START &&
+		(unsigned long)addr < (KERN_VIRT_START + KERN_VIRT_SIZE)) {
+		return (void *)kasan_early_shadow_page;
+	}
+
+	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
+		+ KASAN_SHADOW_OFFSET;
+}
+#define kasan_mem_to_shadow kasan_mem_to_shadow_book3e
+
+static inline void *kasan_shadow_to_mem_book3e(const void *shadow_addr)
+{
+	/*
+	 * We map the entire non-linear virtual mapping onto the zero page so if
+	 * we are asked to map the zero page back just pick the beginning of that
+	 * area.
+	 */
+	if (shadow_addr >= (void *)kasan_early_shadow_page &&
+		shadow_addr < (void *)(kasan_early_shadow_page + PAGE_SIZE)) {
+		return (void *)KERN_VIRT_START;
+	}
+
+	return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
+		<< KASAN_SHADOW_SCALE_SHIFT);
+}
+#define kasan_shadow_to_mem kasan_shadow_to_mem_book3e
+
+static inline bool kasan_addr_has_shadow_book3e(const void *addr)
+{
+	/*
+	 * We want to specifically assert that the addresses in the 0x8000...
+	 * region have a shadow, otherwise they are considered by the kasan
+	 * core to be wild pointers
+	 */
+	if ((unsigned long)addr >= KERN_VIRT_START &&
+		(unsigned long)addr < (KERN_VIRT_START + KERN_VIRT_SIZE)) {
+		return true;
+	}
+	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
+}
+#define kasan_addr_has_shadow kasan_addr_has_shadow_book3e
+
+#endif /* CONFIG_PPC_BOOK3E_64 */
+
 #endif /* __ASSEMBLY */
 #endif
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 292b96ce1efc..ab2ed80d224d 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -7,6 +7,8 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
 
+KASAN_SANITIZE_fsl_booke_mmu.o := n
+
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
 				   init-common.o mmu_context.o drmem.o
diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index 6577897673dd..f8f164ad8ade 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -3,3 +3,4 @@
 KASAN_SANITIZE := n
 
 obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC_BOOK3E_64)   += kasan_init_book3e_64.o
diff --git a/arch/powerpc/mm/kasan/kasan_init_book3e_64.c b/arch/powerpc/mm/kasan/kasan_init_book3e_64.c
new file mode 100644
index 000000000000..b37fceebcc3b
--- /dev/null
+++ b/arch/powerpc/mm/kasan/kasan_init_book3e_64.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define DISABLE_BRANCH_PROFILING
+
+#include <linux/kasan.h>
+#include <linux/printk.h>
+#include <linux/memblock.h>
+#include <linux/sched/task.h>
+#include <asm/pgalloc.h>
+
+DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
+EXPORT_SYMBOL(powerpc_kasan_enabled_key);
+
+static void __init kasan_init_region(struct memblock_region *reg)
+{
+	void *start = __va(reg->base);
+	void *end = __va(reg->base + reg->size);
+	unsigned long k_start, k_end, k_cur;
+
+	if (start >= end)
+		return;
+
+	k_start = (unsigned long)kasan_mem_to_shadow(start);
+	k_end = (unsigned long)kasan_mem_to_shadow(end);
+
+	for (k_cur = k_start; k_cur < k_end; k_cur += PAGE_SIZE) {
+		void *va = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+
+		map_kernel_page(k_cur, __pa(va), PAGE_KERNEL);
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
+	/* map the zero page RO */
+	map_kernel_page((unsigned long)kasan_early_shadow_page,
+			__pa(kasan_early_shadow_page), PAGE_KERNEL_RO);
+
+	/* Turn on checking */
+	static_branch_inc(&powerpc_kasan_enabled_key);
+
+	/* Enable error messages */
+	init_task.kasan_depth = 0;
+	pr_info("KASAN init done (64-bit Book3E)\n");
+}
-- 
2.13.3

