Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F58DC282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 12:38:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DAC2146E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 12:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XbYkNb4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DAC2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mJVB1mvmzDqGX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 23:38:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="XbYkNb4y"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mJNt2WBxzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 23:34:06 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43mJNn2Bglz9tyxt;
 Fri, 25 Jan 2019 13:34:01 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=XbYkNb4y; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id mWZvesbFzYD7; Fri, 25 Jan 2019 13:34:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43mJNn105zz9tyxr;
 Fri, 25 Jan 2019 13:34:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548419641; bh=ge1wiHZra7rk+JGrJzu6zJRiaoRZAtpAAWM41Ep0gLY=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=XbYkNb4yM8UcNgYqGu8uk9DadgRrCjVq7kBhJXcL02MiPL/a+4zKUip/z4Si9EVGV
 wRDKVkf8sofUT4wlNB6yXNzUly1adeu5Y1cBiin2RvNC2w1A74SXpXhRR/zNWOZXMl
 LEOePzb7rMNO7HJLjXzNUBilBopdNRmTNuny3WK0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 703B58B87A;
 Fri, 25 Jan 2019 13:34:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KDGYCeD_-pBV; Fri, 25 Jan 2019 13:34:02 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5544A8B761;
 Fri, 25 Jan 2019 13:34:02 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 4DC0272DA9; Fri, 25 Jan 2019 12:34:02 +0000 (UTC)
Message-Id: <c6fb603cd68ed554f9f9b994d525cf0fdc5b5d07.1548419273.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548419273.git.christophe.leroy@c-s.fr>
References: <cover.1548419273.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 01/10] powerpc: simplify BDI switch
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 joakim.tjernlund@infinera.com
Date: Fri, 25 Jan 2019 12:34:02 +0000 (UTC)
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

There is no reason to re-read each time the pointer at
location 0xf0 as it is fixed and known.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu.h | 2 ++
 arch/powerpc/kernel/head_32.S  | 5 ++---
 arch/powerpc/kernel/head_40x.S | 5 ++---
 arch/powerpc/kernel/head_8xx.S | 1 +
 arch/powerpc/mm/8xx_mmu.c      | 7 ++-----
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 25607604a7a5..6d22a8e78fe2 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -356,6 +356,8 @@ extern void early_init_mmu_secondary(void);
 extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				       phys_addr_t first_memblock_size);
 static inline void mmu_early_init_devtree(void) { }
+
+extern void *abatron_pteptrs[2];
 #endif /* __ASSEMBLY__ */
 #endif
 
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 05b08db3901d..c2f564690778 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1027,9 +1027,8 @@ _ENTRY(switch_mmu_context)
 	 * The PGDIR is passed as second argument.
 	 */
 	lwz	r4,MM_PGD(r4)
-	lis	r5, KERNELBASE@h
-	lwz	r5, 0xf0(r5)
-	stw	r4, 0x4(r5)
+	lis	r5, abatron_pteptrs@ha
+	stw	r4, abatron_pteptrs@l + 0x4(r5)
 #endif
 	li	r4,0
 	isync
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index b19d78410511..11dd09d0ce1a 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -953,9 +953,8 @@ _GLOBAL(set_context)
 	/* Context switch the PTE pointer for the Abatron BDI2000.
 	 * The PGDIR is the second parameter.
 	 */
-	lis	r5, KERNELBASE@h
-	lwz	r5, 0xf0(r5)
-	stw	r4, 0x4(r5)
+	lis	r5, abatron_pteptrs@ha
+	stw	r4, abatron_pteptrs@l + 0x4(r5)
 #endif
 	sync
 	mtspr	SPRN_PID,r3
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index c3f776fda984..4a2e3ffdb5bb 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -1012,5 +1012,6 @@ swapper_pg_dir:
 /* Room for two PTE table poiners, usually the kernel and current user
  * pointer to their respective root page table (pgdir).
  */
+	.globl	abatron_pteptrs
 abatron_pteptrs:
 	.space	8
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index b5f6d794281d..e2c32bdb6023 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -159,14 +159,11 @@ void set_context(unsigned long id, pgd_t *pgd)
 {
 	s16 offset = (s16)(__pa(swapper_pg_dir));
 
-#ifdef CONFIG_BDI_SWITCH
-	pgd_t	**ptr = *(pgd_t ***)(KERNELBASE + 0xf0);
-
 	/* Context switch the PTE pointer for the Abatron BDI2000.
 	 * The PGDIR is passed as second argument.
 	 */
-	*(ptr + 1) = pgd;
-#endif
+	if (IS_ENABLED(CONFIG_BDI_SWITCH))
+		abatron_pteptrs[1] = pgd;
 
 	/* Register M_TWB will contain base address of level 1 table minus the
 	 * lower part of the kernel PGDIR base address, so that all accesses to
-- 
2.13.3

