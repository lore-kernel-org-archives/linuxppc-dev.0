Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32114C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:44:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57DC2085A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="k4O4eEWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57DC2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444rhK5nzYzDqNp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 21:44:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="k4O4eEWW"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444rXQ2NSBzDqNN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 21:37:58 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444rXK5jt6z9tylT;
 Thu, 21 Feb 2019 11:37:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=k4O4eEWW; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id nXrKAVz6YsZ5; Thu, 21 Feb 2019 11:37:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444rXK4Mxpz9tylQ;
 Thu, 21 Feb 2019 11:37:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550745473; bh=wZd5jaR0//XRcVMqR3Pmqwte8klyCIOu2QVpvlqTbmY=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=k4O4eEWWp35CiqDpMGLa+WhTAtUUAG+/azPA7zrmJ7rlA8aEIHPdN9iDcXMRSth2l
 Sn8Ieo7VuLTzEYRp1fKeXtBsKaFnP+R0fljMaWPN1btihg0BEKU0LXn1lMC3ExWbS/
 c75GJepsQh3/cJMM+7dBSxs0r0h3zqyuir52STPI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C00E98B859;
 Thu, 21 Feb 2019 11:37:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZARi-9vJjN-v; Thu, 21 Feb 2019 11:37:54 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F48C8B852;
 Thu, 21 Feb 2019 11:37:54 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 515CB6E856; Thu, 21 Feb 2019 10:37:54 +0000 (UTC)
Message-Id: <c2b0dfd6066db54add31aa67e7291a5106bbad5b.1550745320.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550745320.git.christophe.leroy@c-s.fr>
References: <cover.1550745320.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 02/10] powerpc/6xx: Don't use SPRN_SPRG2 for storing stack
 pointer while in RTAS
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 21 Feb 2019 10:37:54 +0000 (UTC)
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

When calling RTAS, the stack pointer is stored in SPRN_SPRG2
in order to be able to restore it in case of machine check in RTAS.

As machine check is not a perfomance critical path, this patch
frees SPRN_SPRG2 by using a field in thread struct instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/processor.h |  3 +++
 arch/powerpc/include/asm/reg.h       |  1 -
 arch/powerpc/kernel/asm-offsets.c    |  3 +++
 arch/powerpc/kernel/entry_32.S       |  5 +++--
 arch/powerpc/kernel/head_32.S        | 22 ++++++++++++----------
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ee58526cb6c2..e8682122ea3d 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -250,6 +250,9 @@ struct thread_struct {
 #ifdef CONFIG_PPC32
 	void		*pgdir;		/* root of page-table tree */
 	unsigned long	ksp_limit;	/* if ksp <= ksp_limit stack overflow */
+#ifdef CONFIG_PPC_RTAS
+	unsigned long	rtas_sp;	/* stack pointer for when in RTAS */
+#endif
 #endif
 	/* Debug Registers */
 	struct debug_reg debug;
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1c98ef1f2d5b..371ef6e8248e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1167,7 +1167,6 @@
 #ifdef CONFIG_PPC_BOOK3S_32
 #define SPRN_SPRG_SCRATCH0	SPRN_SPRG0
 #define SPRN_SPRG_SCRATCH1	SPRN_SPRG1
-#define SPRN_SPRG_RTAS		SPRN_SPRG2
 #define SPRN_SPRG_603_LRU	SPRN_SPRG4
 #endif
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9ffc72ded73a..d6f9bdb1eb2e 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -93,6 +93,9 @@ int main(void)
 	OFFSET(THREAD_INFO, task_struct, stack);
 	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
 	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
+#ifdef CONFIG_PPC_RTAS
+	OFFSET(RTAS_SP, thread_struct, rtas_sp);
+#endif
 #endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_LIVEPATCH
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0768dfd8a64e..394772b0a6e2 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1335,7 +1335,7 @@ _GLOBAL(enter_rtas)
 	MTMSRD(r0)		/* don't get trashed */
 	li	r9,MSR_KERNEL & ~(MSR_IR|MSR_DR)
 	mtlr	r6
-	mtspr	SPRN_SPRG_RTAS,r7
+	stw	r7, THREAD + RTAS_SP(r2)
 	mtspr	SPRN_SRR0,r8
 	mtspr	SPRN_SRR1,r9
 	RFI
@@ -1344,7 +1344,8 @@ _GLOBAL(enter_rtas)
 	lwz	r9,8(r9)	/* original msr value */
 	addi	r1,r1,INT_FRAME_SIZE
 	li	r0,0
-	mtspr	SPRN_SPRG_RTAS,r0
+	tophys(r7, r2)
+	stw	r0, THREAD + RTAS_SP(r7)
 	mtspr	SPRN_SRR0,r8
 	mtspr	SPRN_SRR1,r9
 	RFI			/* return to caller */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index c2f564690778..04128899a0a5 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -352,9 +352,8 @@ i##n:								\
  * registers that might have bad values includes all the GPRs
  * and all the BATs.  We indicate that we are in RTAS by putting
  * a non-zero value, the address of the exception frame to use,
- * in SPRG2.  The machine check handler checks SPRG2 and uses its
- * value if it is non-zero.  If we ever needed to free up SPRG2,
- * we could use a field in the thread_info or thread_struct instead.
+ * in thread.rtas_sp.  The machine check handler checks thread.rtas_sp
+ * and uses its value if it is non-zero.
  * (Other exception handlers assume that r1 is a valid kernel stack
  * pointer when we take an exception from supervisor mode.)
  *	-- paulus.
@@ -365,16 +364,15 @@ i##n:								\
 	mtspr	SPRN_SPRG_SCRATCH1,r11
 	mfcr	r10
 #ifdef CONFIG_PPC_CHRP
-	mfspr	r11,SPRN_SPRG_RTAS
-	cmpwi	0,r11,0
-	bne	7f
+	mfspr	r11, SPRN_SPRG_THREAD
+	lwz	r11, RTAS_SP(r11)
+	cmpwi	cr1, r11, 0
+	bne	cr1, 7f
 #endif /* CONFIG_PPC_CHRP */
 	EXCEPTION_PROLOG_1
 7:	EXCEPTION_PROLOG_2
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 #ifdef CONFIG_PPC_CHRP
-	mfspr	r4,SPRN_SPRG_RTAS
-	cmpwi	cr1,r4,0
 	bne	cr1,1f
 #endif
 	EXC_XFER_STD(0x200, machine_check_exception)
@@ -865,8 +863,10 @@ __secondary_start:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* phys address of our thread_struct */
 	mtspr	SPRN_SPRG_THREAD,r4
+#ifdef CONFIG_PPC_RTAS
 	li	r3,0
-	mtspr	SPRN_SPRG_RTAS,r3	/* 0 => not in RTAS */
+	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
+#endif
 
 	/* enable MMU and jump to start_secondary */
 	li	r4,MSR_KERNEL
@@ -950,8 +950,10 @@ start_here:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* init task's THREAD */
 	mtspr	SPRN_SPRG_THREAD,r4
+#ifdef CONFIG_PPC_RTAS
 	li	r3,0
-	mtspr	SPRN_SPRG_RTAS,r3	/* 0 => not in RTAS */
+	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
+#endif
 
 	/* stack */
 	lis	r1,init_thread_union@ha
-- 
2.13.3

