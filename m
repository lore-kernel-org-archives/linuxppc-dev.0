Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBA0C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:42:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37EB20657
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pcYDF3Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37EB20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Hs6J0KhrzDqCh
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 19:42:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="pcYDF3Bb"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HrsF2ntYzDqCp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 19:30:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Hrs35ZHbzB09b4;
 Mon, 11 Mar 2019 09:30:31 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=pcYDF3Bb; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id WCaKN9_CoLmu; Mon, 11 Mar 2019 09:30:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Hrs34ThDzB09ZD;
 Mon, 11 Mar 2019 09:30:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552293031; bh=5i+ufLQ52j6q9g9a60ZKSXC+uHIJQ/dcnsp3eevJfz4=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=pcYDF3BbRy591YxEqP5D1o/dvhgIOK7hvTvq9v+Y1xwx+UH47FU36s19u/4RWlRcZ
 lG7DrmbY7Xxxp6ARBgTnYg0l8WTmf4V3A3x413gAsh4TGLpvrjyrf4JjzbRgNvglwI
 WZGvyldwpfXDaA1aSoVQDiILa0PSwkk60WJHjQ9A=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 322BA8B813;
 Mon, 11 Mar 2019 09:30:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id xMuGqDOtx_KB; Mon, 11 Mar 2019 09:30:36 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E8C78B7FE;
 Mon, 11 Mar 2019 09:30:36 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id EE7A06FA08; Mon, 11 Mar 2019 08:30:35 +0000 (UTC)
Message-Id: <ce7449bcbc0ed221e5df7e60b29dd6f6b89aad24.1552292207.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552292207.git.christophe.leroy@c-s.fr>
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 08/10] powerpc/32s: Implement Kernel Userspace Execution
 Prevention.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 ruscur@russell.cc
Date: Mon, 11 Mar 2019 08:30:35 +0000 (UTC)
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

To implement Kernel Userspace Execution Prevention, this patch
sets NX bit on all user segments on kernel entry and clears NX bit
on all user segments on kernel exit.

Note that powerpc 601 doesn't have the NX bit, so KUEP will not
work on it. A warning is displayed at startup.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/kup.h      | 42 +++++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  3 ++
 arch/powerpc/include/asm/kup.h                |  3 ++
 arch/powerpc/kernel/entry_32.S                |  9 ++++++
 arch/powerpc/kernel/head_32.S                 | 15 +++++++++-
 arch/powerpc/mm/ppc_mmu_32.c                  | 13 +++++++++
 arch/powerpc/platforms/Kconfig.cputype        |  1 +
 7 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/book3s/32/kup.h

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
new file mode 100644
index 000000000000..5f97c742ca71
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_BOOK3S_32_KUP_H
+#define _ASM_POWERPC_BOOK3S_32_KUP_H
+
+#include <asm/book3s/32/mmu-hash.h>
+
+#ifdef __ASSEMBLY__
+
+.macro kuep_update_sr	gpr1, gpr2		/* NEVER use r0 as gpr2 due to addis */
+101:	mtsrin	\gpr1, \gpr2
+	addi	\gpr1, \gpr1, 0x111		/* next VSID */
+	rlwinm	\gpr1, \gpr1, 0, 0xf0ffffff	/* clear VSID overflow */
+	addis	\gpr2, \gpr2, 0x1000		/* address of next segment */
+	bdnz	101b
+	isync
+.endm
+
+.macro kuep_lock	gpr1, gpr2
+#ifdef CONFIG_PPC_KUEP
+	li	\gpr1, NUM_USER_SEGMENTS
+	li	\gpr2, 0
+	mtctr	\gpr1
+	mfsrin	\gpr1, \gpr2
+	oris	\gpr1, \gpr1, SR_NX@h		/* set Nx */
+	kuep_update_sr \gpr1, \gpr2
+#endif
+.endm
+
+.macro kuep_unlock	gpr1, gpr2
+#ifdef CONFIG_PPC_KUEP
+	li	\gpr1, NUM_USER_SEGMENTS
+	li	\gpr2, 0
+	mtctr	\gpr1
+	mfsrin	\gpr1, \gpr2
+	rlwinm	\gpr1, \gpr1, 0, ~SR_NX		/* Clear Nx */
+	kuep_update_sr \gpr1, \gpr2
+#endif
+.endm
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_BOOK3S_32_KUP_H */
diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 5cb588395fdc..8c5727a322b1 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -63,6 +63,9 @@ typedef pte_t *pgtable_t;
 #define PP_RWRW 2	/* Supervisor read/write, User read/write */
 #define PP_RXRX 3	/* Supervisor read,       User read */
 
+/* Values for Segment Registers */
+#define SR_NX	0x10000000	/* No Execute */
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 75ade5a54607..c34627967901 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -8,6 +8,9 @@
 #ifdef CONFIG_PPC_8xx
 #include <asm/nohash/32/kup-8xx.h>
 #endif
+#ifdef CONFIG_PPC_BOOK3S_32
+#include <asm/book3s/32/kup.h>
+#endif
 
 #ifdef __ASSEMBLY__
 #ifndef CONFIG_PPC_KUAP
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 1182bf603d3c..2f3d159c11d7 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -162,6 +162,9 @@ transfer_to_handler:
 	andis.	r12,r12,DBCR0_IDM@h
 #endif
 	ACCOUNT_CPU_USER_ENTRY(r2, r11, r12)
+#ifdef CONFIG_PPC_BOOK3S_32
+	kuep_lock r11, r12
+#endif
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 	beq+	3f
 	/* From user and task is ptraced - load up global dbcr0 */
@@ -427,6 +430,9 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1			/* to clear the reservation */
 	ACCOUNT_CPU_USER_EXIT(r2, r5, r7)
+#ifdef CONFIG_PPC_BOOK3S_32
+	kuep_unlock r5, r7
+#endif
 	kuap_check r2, r4
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
@@ -821,6 +827,9 @@ restore_user:
 	bnel-	load_dbcr0
 #endif
 	ACCOUNT_CPU_USER_EXIT(r2, r10, r11)
+#ifdef CONFIG_PPC_BOOK3S_32
+	kuep_unlock	r10, r11
+#endif
 
 	b	restore
 
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 48051c8977c5..5e792f2634fc 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -900,14 +900,24 @@ load_up_mmu:
 	tophys(r6,r6)
 	lwz	r6,_SDR1@l(r6)
 	mtspr	SPRN_SDR1,r6
-	li	r0,16		/* load up segment register values */
+	li	r0, NUM_USER_SEGMENTS	/* load up segment register values */
 	mtctr	r0		/* for context 0 */
 	lis	r3,0x2000	/* Ku = 1, VSID = 0 */
+#ifdef CONFIG_PPC_KUEP
+	oris	r3, r3, SR_NX@h	/* Set Nx */
+#endif
 	li	r4,0
 3:	mtsrin	r3,r4
 	addi	r3,r3,0x111	/* increment VSID */
 	addis	r4,r4,0x1000	/* address of next segment */
 	bdnz	3b
+	li	r0, 16 - NUM_USER_SEGMENTS /* load up kernel segment registers */
+	mtctr	r0			/* for context 0 */
+	rlwinm	r3, r3, 0, ~SR_NX	/* Nx = 0 */
+3:	mtsrin	r3, r4
+	addi	r3, r3, 0x111	/* increment VSID */
+	addis	r4, r4, 0x1000	/* address of next segment */
+	bdnz	3b
 
 /* Load the BAT registers with the values set up by MMU_init.
    MMU_init takes care of whether we're on a 601 or not. */
@@ -1015,6 +1025,9 @@ _ENTRY(switch_mmu_context)
 	mulli	r3,r3,897	/* multiply context by skew factor */
 	rlwinm	r3,r3,4,8,27	/* VSID = (context & 0xfffff) << 4 */
 	addis	r3,r3,0x6000	/* Set Ks, Ku bits */
+#ifdef CONFIG_PPC_KUEP
+	oris	r3, r3, SR_NX@h	/* Set Nx */
+#endif
 	li	r0,NUM_USER_SEGMENTS
 	mtctr	r0
 
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 2d5b0d50fb31..a99ede671653 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -392,3 +392,16 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	else /* Anything else has 256M mapped */
 		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x10000000));
 }
+
+#ifdef CONFIG_PPC_KUEP
+void __init setup_kuep(bool disabled)
+{
+	pr_info("Activating Kernel Userspace Execution Prevention\n");
+
+	if (cpu_has_feature(CPU_FTR_601))
+		pr_warn("KUEP is not working on powerpc 601 (No NX bit in Seg Regs)\n");
+
+	if (disabled)
+		pr_warn("KUEP cannot be disabled yet on 6xx when compiled in\n");
+}
+#endif
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index ab586963893a..6bc0a4c08c1c 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -25,6 +25,7 @@ config PPC_BOOK3S_32
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
 	select PPC_HAVE_PMU_SUPPORT
+	select PPC_HAVE_KUEP
 
 config PPC_85xx
 	bool "Freescale 85xx"
-- 
2.13.3

