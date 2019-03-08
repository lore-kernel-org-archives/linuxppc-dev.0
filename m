Return-Path: <SRS0=I4jZ=RL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B6CC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 01:27:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D95220675
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 01:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D95220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FqcW47G6zDqJQ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 12:27:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FqMv3pkNzDqGN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 12:16:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44FqMv20TLz9ryj; Fri,  8 Mar 2019 12:16:43 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44FqMv0RHVz9sBb; Fri,  8 Mar 2019 12:16:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v5 07/10] powerpc/mm/radix: Use KUEP API for Radix MMU
Date: Fri,  8 Mar 2019 12:16:16 +1100
Message-Id: <20190308011619.22402-7-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308011619.22402-1-mpe@ellerman.id.au>
References: <20190308011619.22402-1-mpe@ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Russell Currey <ruscur@russell.cc>

Execution protection already exists on radix, this just refactors
the radix init to provide the KUEP setup function instead.

Thus, the only functional change is that it can now be disabled.

Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
v5: Unchanged.

 arch/powerpc/mm/pgtable-radix.c        | 12 +++++++++---
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 931156069a81..224bcd4be5ae 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -535,8 +535,15 @@ static void radix_init_amor(void)
 	mtspr(SPRN_AMOR, (3ul << 62));
 }
 
-static void radix_init_iamr(void)
+#ifdef CONFIG_PPC_KUEP
+void __init setup_kuep(bool disabled)
 {
+	if (disabled || !early_radix_enabled())
+		return;
+
+	if (smp_processor_id() == boot_cpuid)
+		pr_info("Activating Kernel Userspace Execution Prevention\n");
+
 	/*
 	 * Radix always uses key0 of the IAMR to determine if an access is
 	 * allowed. We set bit 0 (IBM bit 1) of key0, to prevent instruction
@@ -544,6 +551,7 @@ static void radix_init_iamr(void)
 	 */
 	mtspr(SPRN_IAMR, (1ul << 62));
 }
+#endif
 
 void __init radix__early_init_mmu(void)
 {
@@ -605,7 +613,6 @@ void __init radix__early_init_mmu(void)
 
 	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
 
-	radix_init_iamr();
 	radix_init_pgtable();
 	/* Switch to the guard PID before turning on MMU */
 	radix__switch_mmu_context(NULL, &init_mm);
@@ -627,7 +634,6 @@ void radix__early_init_mmu_secondary(void)
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
 		radix_init_amor();
 	}
-	radix_init_iamr();
 
 	radix__switch_mmu_context(NULL, &init_mm);
 	if (cpu_has_feature(CPU_FTR_HVMODE))
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 457fc3a5ed93..60371784c9f1 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -326,6 +326,7 @@ config PPC_RADIX_MMU
 	bool "Radix MMU Support"
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
+	select PPC_HAVE_KUEP
 	default y
 	help
 	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
-- 
2.20.1

