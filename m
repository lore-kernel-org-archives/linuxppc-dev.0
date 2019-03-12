Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95A4C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:32:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B32214D8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="My1K5mvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B32214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JHX82fB5zDqH3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 12:32:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="My1K5mvY"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JHLv6pxYzDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 12:24:23 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id j5so574920pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 18:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5MFf+Sv2MGhkMm701ULEhWcjMAOcrTqPNBZ2v20h180=;
 b=My1K5mvYDPkuoPBI/FF7yBgzauZjpseRxvHn0WkbzFw30qa4QC2mAdHumpUNCkT1h8
 9Lpjis7M8CKraacC32VdD6VTL2Gm2IyLbPcyy72Yun4GrzT1kYrNws3BSczzWi+Dg75/
 YQDlfm5jzvCKoXfVWDrFPDpZ8cRPR2xLSWO6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5MFf+Sv2MGhkMm701ULEhWcjMAOcrTqPNBZ2v20h180=;
 b=HQelJSiw8XN8o1rzZ7+p1/FsVKH7VPpbQ5l4e2L3RtWwJqev+uu1WeskUUx/bJpXy8
 GqUPpomZoA4/4WRx1TnL70tvh/1+aV2yQ0tU9tIV0tewj8LP0OWpyzS06/m+40lBspC5
 lQXgT8hw1pfsZNA62IsxR7PnFHYqMh9C0gbakQZCT5qbRbGAjEvLlgR2l57RiZCl2JBD
 rhqZPSeVSbj3eeECssNn123bwt4WHefCG3rNibpqL1jXAh7pTyX3egewhQrj3Au9n4Xj
 EcPW+2M41KsAtj1YRWsl00wx41IVb6+LAWalYpr8yjT3nAf+p8Ucod7rtTfdG5AoK+7+
 aBdg==
X-Gm-Message-State: APjAAAX2wfvoHIKu772v2N2qQKG6bUCqrQz311GhbRQy0B51kzcGKR4L
 ACQnq25GvXM+FadZ6Hg1xCOx8f/AWN0=
X-Google-Smtp-Source: APXvYqyY5CrOgsJ2WOrooZAEwwZ5BRvaqLFrTrcYnZ74N+OmxXAjW7L6gxJWNxUT6m5xzoZ0SGPGDg==
X-Received: by 2002:a17:902:70c9:: with SMTP id
 l9mr11720517plt.131.1552353862236; 
 Mon, 11 Mar 2019 18:24:22 -0700 (PDT)
Received: from localhost (124-171-102-1.dyn.iinet.net.au. [124.171.102.1])
 by smtp.gmail.com with ESMTPSA id i72sm20929571pfj.147.2019.03.11.18.24.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Mar 2019 18:24:21 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr, bsingharora@gmail.com
Subject: [RFCv2 PATCH 4/4] powerpc: KASAN for 64bit Book3E
Date: Tue, 12 Mar 2019 12:23:48 +1100
Message-Id: <20190312012348.4854-5-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190312012348.4854-1-dja@axtens.net>
References: <20190312012348.4854-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 kasan-dev@googlegroups.com, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Wire up KASAN. Only outline instrumentation is supported.

The KASAN shadow area is mapped into vmemmap space:
0x8000 0400 0000 0000 to 0x8000 0600 0000 0000.
To do this we require that vmemmap be disabled. (This is the default
in the kernel config that QorIQ provides for the machine in their
SDK anyway - they use flat memory.)

Only the kernel linear mapping (0xc000...) is checked. The vmalloc and
ioremap areas (also in 0x800...) are all mapped to the zero page. As
with the Book3S hash series, this requires overriding the memory <->
shadow mapping.

Also, as with both previous 64-bit series, early instrumentation is not
supported.  It would allow us to drop the check_return_arch_not_ready()
hook in the KASAN core, but it's tricky to get it set up early enough:
we need it setup before the first call to instrumented code like printk().
Perhaps in the future.

Only KASAN_MINIMAL works.

Tested on e6500. KVM, kexec and xmon have not been tested.

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

While useful if you have a book3e device, this is mostly intended
as a warm-up exercise for reviving Aneesh's series for book3s hash.
In particular, changes to the kasan core are going to be required
for hash and radix as well.
---
 arch/powerpc/Kconfig                         |  1 +
 arch/powerpc/Kconfig.debug                   |  2 +-
 arch/powerpc/include/asm/kasan.h             | 73 +++++++++++++++++++-
 arch/powerpc/mm/Makefile                     |  2 +
 arch/powerpc/mm/kasan/Makefile               |  1 +
 arch/powerpc/mm/kasan/kasan_init_book3e_64.c | 53 ++++++++++++++
 6 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/mm/kasan/kasan_init_book3e_64.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8d6108c83299..01540873a79f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -173,6 +173,7 @@ config PPC
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN			if PPC32
+	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && !SPARSEMEM_VMEMMAP
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 61febbbdd02b..fc1f5fa7554e 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -369,5 +369,5 @@ config PPC_FAST_ENDIAN_SWITCH
 
 config KASAN_SHADOW_OFFSET
 	hex
-	depends on KASAN
+	depends on KASAN && PPC32
 	default 0xe0000000
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index e4adc6bc1e8f..661a5700869b 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -15,14 +15,16 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/page.h>
+#include <asm/pgtable.h>
 
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
-#define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
-
 #define KASAN_SHADOW_START	(KASAN_SHADOW_OFFSET + \
 				 (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT))
 
+#ifdef CONFIG_PPC32
+#define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
+
 #define KASAN_SHADOW_END	0UL
 
 #define KASAN_SHADOW_SIZE	(KASAN_SHADOW_END - KASAN_SHADOW_START)
@@ -30,6 +32,73 @@
 #ifdef CONFIG_KASAN
 void kasan_early_init(void);
 void kasan_mmu_init(void);
+#endif
+#endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_PPC_BOOK3E_64
+
+/* we don't put this in Kconfig as we only support KASAN_MINIMAL, and
+ * that will be disabled if the symbol is availabe in Kconfig */
+#define KASAN_SHADOW_OFFSET ASM_CONST(0x6800040000000000)
+
+#define KASAN_SHADOW_SIZE	(KERN_VIRT_SIZE >> KASAN_SHADOW_SCALE_SHIFT)
+
+extern struct static_key_false powerpc_kasan_enabled_key;
+static inline bool kasan_arch_is_ready_book3e(void) {
+	if (static_branch_likely(&powerpc_kasan_enabled_key))
+				return true;
+	return false;
+}
+#define kasan_arch_is_ready kasan_arch_is_ready_book3e
+
+extern unsigned char kasan_zero_page[PAGE_SIZE];
+static inline void *kasan_mem_to_shadow_book3e(const void *addr)
+{
+	if ((unsigned long)addr >= KERN_VIRT_START &&
+		(unsigned long)addr < (KERN_VIRT_START + KERN_VIRT_SIZE)) {
+		return (void *)kasan_zero_page;
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
+	if (shadow_addr >= (void *)kasan_zero_page &&
+		shadow_addr < (void *)(kasan_zero_page + PAGE_SIZE)) {
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
+#ifdef CONFIG_KASAN
 void kasan_init(void);
 #else
 static inline void kasan_init(void) { }
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 80382a2d169b..fc49231f807c 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -8,9 +8,11 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
 
 KASAN_SANITIZE_ppc_mmu_32.o := n
+KASAN_SANITIZE_fsl_booke_mmu.o := n
 
 ifdef CONFIG_KASAN
 CFLAGS_ppc_mmu_32.o  		+= -DDISABLE_BRANCH_PROFILING
+CFLAGS_fsl_booke_mmu.o		+= -DDISABLE_BRANCH_PROFILING
 endif
 
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
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
index 000000000000..93b9afcf1020
--- /dev/null
+++ b/arch/powerpc/mm/kasan/kasan_init_book3e_64.c
@@ -0,0 +1,53 @@
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
+unsigned char kasan_zero_page[PAGE_SIZE] __page_aligned_bss;
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
+	map_kernel_page((unsigned long)kasan_zero_page,
+					__pa(kasan_zero_page), PAGE_KERNEL_RO);
+
+	kasan_init_tags();
+
+	/* Turn on checking */
+	static_branch_inc(&powerpc_kasan_enabled_key);
+
+	/* Enable error messages */
+	init_task.kasan_depth = 0;
+	pr_info("KASAN init done (64-bit Book3E)\n");
+}
-- 
2.19.1

