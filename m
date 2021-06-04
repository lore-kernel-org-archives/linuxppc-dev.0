Return-Path: <SRS0=yrNn=K6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53A2C07E94
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jun 2021 09:58:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4EC61415
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jun 2021 09:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4EC61415
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FxJ9X6phGz309L
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jun 2021 19:58:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FxJ982GPyz2yjH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jun 2021 19:57:44 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4FxJ8y5zHqzBCh9;
 Fri,  4 Jun 2021 11:57:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cjOOqixGj5JY; Fri,  4 Jun 2021 11:57:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FxJ8y55mYz9ryy;
 Fri,  4 Jun 2021 11:57:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A914B8B876;
 Fri,  4 Jun 2021 11:57:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 3dMIB7lb-7uV; Fri,  4 Jun 2021 11:57:37 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 266718B86A;
 Fri,  4 Jun 2021 11:57:37 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id DEDE264BDD; Fri,  4 Jun 2021 09:57:36 +0000 (UTC)
Message-Id: <9fa9ba6807c17f93f35a582c199c646c4a8bfd9c.1622800638.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Remove klimit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 wangkefeng.wang@huawei.com
Date: Fri,  4 Jun 2021 09:57:36 +0000 (UTC)
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

klimit is a global variable initialised at build time with the
value of _end.

This variable is never modified, so _end symbol can be used directly.

Remove klimit.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/powerpc/include/asm/setup.h             | 1 -
 arch/powerpc/kernel/head_book3s_32.S         | 6 ++----
 arch/powerpc/kernel/prom.c                   | 2 +-
 arch/powerpc/kernel/setup-common.c           | 4 +---
 arch/powerpc/platforms/powermac/bootx_init.c | 2 +-
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index e89bfebd4e00..6c1a7d217d1a 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -10,7 +10,6 @@ extern void ppc_printk_progress(char *s, unsigned short hex);
 extern unsigned int rtas_data;
 extern unsigned long long memory_limit;
 extern bool init_mem_is_free;
-extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
 struct device_node;
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 326262030279..b724e88bcdaf 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -766,9 +766,6 @@ PerformanceMonitor:
  * the kernel image to physical address PHYSICAL_START.
  */
 relocate_kernel:
-	addis	r9,r26,klimit@ha	/* fetch klimit */
-	lwz	r25,klimit@l(r9)
-	addis	r25,r25,-KERNELBASE@h
 	lis	r3,PHYSICAL_START@h	/* Destination base address */
 	li	r6,0			/* Destination offset */
 	li	r5,0x4000		/* # bytes of memory to copy */
@@ -776,7 +773,8 @@ relocate_kernel:
 	addi	r0,r3,4f@l		/* jump to the address of 4f */
 	mtctr	r0			/* in copy and do the rest. */
 	bctr				/* jump to the copy */
-4:	mr	r5,r25
+4:	lis	r5,_end-KERNELBASE@h
+	ori	r5,r5,_end-KERNELBASE@l
 	bl	copy_and_flush		/* copy the rest */
 	b	turn_on_mmu
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fbe9deebc8e1..f620e04dc9bf 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -758,7 +758,7 @@ void __init early_init_devtree(void *params)
 		first_memblock_size = min_t(u64, first_memblock_size, memory_limit);
 	setup_initial_memory_limit(memstart_addr, first_memblock_size);
 	/* Reserve MEMBLOCK regions used by kernel, initrd, dt, etc... */
-	memblock_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
+	memblock_reserve(PHYSICAL_START, __pa(_end) - PHYSICAL_START);
 	/* If relocatable, reserve first 32k for interrupt vectors etc. */
 	if (PHYSICAL_START > MEMORY_START)
 		memblock_reserve(MEMORY_START, 0x8000);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 74a98fff2c2f..138bb7f49ef9 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -91,8 +91,6 @@ EXPORT_SYMBOL_GPL(boot_cpuid);
 int dcache_bsize;
 int icache_bsize;
 
-unsigned long klimit = (unsigned long) _end;
-
 /*
  * This still seems to be needed... -- paulus
  */ 
@@ -930,7 +928,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.start_code = (unsigned long)_stext;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
-	init_mm.brk = klimit;
+	init_mm.brk = (unsigned long)_end;
 
 	mm_iommu_init(&init_mm);
 	irqstack_early_init();
diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index 9d4ecd292255..d20ef35e6d9d 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -433,7 +433,7 @@ static void __init btext_welcome(boot_infos_t *bi)
 	bootx_printf("\nframe buffer at  : 0x%x", bi->dispDeviceBase);
 	bootx_printf(" (phys), 0x%x", bi->logicalDisplayBase);
 	bootx_printf(" (log)");
-	bootx_printf("\nklimit           : 0x%x",(unsigned long)klimit);
+	bootx_printf("\nklimit           : 0x%x",(unsigned long)_end);
 	bootx_printf("\nboot_info at     : 0x%x", bi);
 	__asm__ __volatile__ ("mfmsr %0" : "=r" (flags));
 	bootx_printf("\nMSR              : 0x%x", flags);
-- 
2.25.0

