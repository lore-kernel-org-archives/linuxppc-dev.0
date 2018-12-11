Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46C9C07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:28:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F302082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F302082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Dd4L1k03zDqjZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:28:50 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dcyh5Jt5zDqjG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 22:23:56 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43Dcyc3Ng5zB09bC;
 Tue, 11 Dec 2018 12:23:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Iu_1_KTjI0F2; Tue, 11 Dec 2018 12:23:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43Dcyc2tvBzB09b7;
 Tue, 11 Dec 2018 12:23:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B94F8B7EB;
 Tue, 11 Dec 2018 12:23:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Gin37YTydpmC; Tue, 11 Dec 2018 12:23:53 +0100 (CET)
Received: from PO15451.localdomain (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CF4EE8B7E7;
 Tue, 11 Dec 2018 12:23:52 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 8FECD71702; Tue, 11 Dec 2018 11:23:52 +0000 (UTC)
Message-Id: <d364c900d988e491cb363a27133c0849b71b4e0a.1544519035.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1544519035.git.christophe.leroy@c-s.fr>
References: <cover.1544519035.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 1/3] powerpc/32: prepare for CONFIG_VMAP_STACK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 11 Dec 2018 11:23:52 +0000 (UTC)
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

To support CONFIG_VMAP_STACK, the kernel must be able to activate
Data MMU Translation for accessing the stack. Before doing that
it must save SRR0, SRR1 and DAR in order to not loose them in
case there is a Data TLB Miss once the translation is reactivated.

This patch defines fields in the thread struct for saving those
registers. It also prepares entry_32.S to handle exception entry
with Data MMU Translation enabled.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/processor.h   |  5 +++++
 arch/powerpc/include/asm/thread_info.h |  5 +++++
 arch/powerpc/kernel/asm-offsets.c      |  5 +++++
 arch/powerpc/kernel/entry_32.S         | 16 ++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 8179b64871ed..e839a1231b17 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -218,6 +218,11 @@ struct thread_struct {
 #ifdef CONFIG_PPC32
 	void		*pgdir;		/* root of page-table tree */
 	unsigned long	ksp_limit;	/* if ksp <= ksp_limit stack overflow */
+#ifdef CONFIG_VMAP_STACK
+	unsigned long	dar;
+	unsigned long	srr0;
+	unsigned long	srr1;
+#endif
 #endif
 	/* Debug Registers */
 	struct debug_reg debug;
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 8e1d0195ac36..488d5c4670ff 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -10,10 +10,15 @@
 #define _ASM_POWERPC_THREAD_INFO_H
 
 #include <asm/asm-const.h>
+#include <asm/page.h>
 
 #ifdef __KERNEL__
 
+#if defined(CONFIG_VMAP_STACK) && CONFIG_THREAD_SHIFT < PAGE_SHIFT
+#define THREAD_SHIFT		PAGE_SHIFT
+#else
 #define THREAD_SHIFT		CONFIG_THREAD_SHIFT
+#endif
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 03439785c2ea..985523ef23e8 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -128,6 +128,11 @@ int main(void)
 	OFFSET(KSP_VSID, thread_struct, ksp_vsid);
 #else /* CONFIG_PPC64 */
 	OFFSET(PGDIR, thread_struct, pgdir);
+#ifdef CONFIG_VMAP_STACK
+	OFFSET(SRR0, thread_struct, srr0);
+	OFFSET(SRR1, thread_struct, srr1);
+	OFFSET(DAR, thread_struct, dar);
+#endif
 #ifdef CONFIG_SPE
 	OFFSET(THREAD_EVR0, thread_struct, evr[0]);
 	OFFSET(THREAD_ACC, thread_struct, acc);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 52a061f14c7d..6e2c45fdd2c0 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -150,8 +150,13 @@ transfer_to_handler:
 	stw	r12,_CTR(r11)
 	stw	r2,_XER(r11)
 	mfspr	r12,SPRN_SPRG_THREAD
+#ifdef CONFIG_VMAP_STACK
+	tovirt(r12, r12)
+#endif
 	addi	r2,r12,-THREAD
+#ifndef CONFIG_VMAP_STACK
 	tovirt(r2,r2)			/* set r2 to current */
+#endif
 	beq	2f			/* if from user, fix up THREAD.regs */
 	addi	r11,r1,STACK_FRAME_OVERHEAD
 	stw	r11,PT_REGS(r12)
@@ -179,9 +184,13 @@ transfer_to_handler:
 	stw	r12,4(r11)
 #endif
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+#ifdef CONFIG_VMAP_STACK
+	ACCOUNT_CPU_USER_ENTRY(r2, r11, r12)
+#else
 	tophys(r9, r2)
 	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
 #endif
+#endif
 
 	b	3f
 
@@ -193,8 +202,12 @@ transfer_to_handler:
 	ble-	stack_ovf		/* then the kernel stack overflowed */
 5:
 #if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
+#ifdef CONFIG_VMAP_STACK
+	lwz	r12, TI_LOCAL_FLAGS(r2)
+#else
 	tophys(r9,r2)			/* check local flags */
 	lwz	r12,TI_LOCAL_FLAGS(r9)
+#endif
 	mtcrf	0x01,r12
 	bt-	31-TLF_NAPPING,4f
 	bt-	31-TLF_SLEEPING,7f
@@ -203,6 +216,9 @@ transfer_to_handler:
 transfer_to_handler_cont:
 3:
 	mflr	r9
+#ifdef CONFIG_VMAP_STACK
+	tovirt(r9,r9)
+#endif
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
-- 
2.13.3

