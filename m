Return-Path: <SRS0=hK36=HL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A631DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 10:41:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA3564E66
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 10:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA3564E66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DZfZ86hj8zDqrg
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 21:41:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DZdb510SlzDqqk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2021 20:56:49 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DZdb12Gqkz9txgM;
 Tue,  9 Feb 2021 10:56:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id uXQnUI5lCfaE; Tue,  9 Feb 2021 10:56:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdb11Tmqz9txg8;
 Tue,  9 Feb 2021 10:56:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 334C18B7D6;
 Tue,  9 Feb 2021 10:56:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id D6wOtj2OavjE; Tue,  9 Feb 2021 10:56:46 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DE83F8B7D4;
 Tue,  9 Feb 2021 10:56:45 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A1A0F67342; Tue,  9 Feb 2021 09:56:45 +0000 (UTC)
Message-Id: <736efc134f17caeec61ae39fa950936837ef36af.1612864003.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 21/41] powerpc/32: Refactor booke critical registers
 saving
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com
Date: Tue,  9 Feb 2021 09:56:45 +0000 (UTC)
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

Refactor booke critical registers saving into a few macros
and move it into the exception prolog directly.

Keep the dedicated transfert_to_handler entry point for the
moment allthough they are empty. They will be removed in a
later patch to reduce churn.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S   | 33 -------------------------
 arch/powerpc/kernel/head_booke.h | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index f244e7846031..dce0f03a0e88 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -51,49 +51,16 @@
 #ifdef CONFIG_BOOKE
 	.globl	mcheck_transfer_to_handler
 mcheck_transfer_to_handler:
-	mfspr	r0,SPRN_DSRR0
-	stw	r0,_DSRR0(r11)
-	mfspr	r0,SPRN_DSRR1
-	stw	r0,_DSRR1(r11)
 	/* fall through */
 _ASM_NOKPROBE_SYMBOL(mcheck_transfer_to_handler)
 
 	.globl	debug_transfer_to_handler
 debug_transfer_to_handler:
-	mfspr	r0,SPRN_CSRR0
-	stw	r0,_CSRR0(r11)
-	mfspr	r0,SPRN_CSRR1
-	stw	r0,_CSRR1(r11)
 	/* fall through */
 _ASM_NOKPROBE_SYMBOL(debug_transfer_to_handler)
 
 	.globl	crit_transfer_to_handler
 crit_transfer_to_handler:
-#ifdef CONFIG_PPC_BOOK3E_MMU
-	mfspr	r0,SPRN_MAS0
-	stw	r0,MAS0(r11)
-	mfspr	r0,SPRN_MAS1
-	stw	r0,MAS1(r11)
-	mfspr	r0,SPRN_MAS2
-	stw	r0,MAS2(r11)
-	mfspr	r0,SPRN_MAS3
-	stw	r0,MAS3(r11)
-	mfspr	r0,SPRN_MAS6
-	stw	r0,MAS6(r11)
-#ifdef CONFIG_PHYS_64BIT
-	mfspr	r0,SPRN_MAS7
-	stw	r0,MAS7(r11)
-#endif /* CONFIG_PHYS_64BIT */
-#endif /* CONFIG_PPC_BOOK3E_MMU */
-#ifdef CONFIG_44x
-	mfspr	r0,SPRN_MMUCR
-	stw	r0,MMUCR(r11)
-#endif
-	mfspr	r0,SPRN_SRR0
-	stw	r0,_SRR0(r11)
-	mfspr	r0,SPRN_SRR1
-	stw	r0,_SRR1(r11)
-
 	/* fall through */
 _ASM_NOKPROBE_SYMBOL(crit_transfer_to_handler)
 #endif
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index ff93ed519b3b..a57a312c7f86 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -229,6 +229,36 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	SAVE_4GPRS(3, r11);						     \
 	SAVE_2GPRS(7, r11)
 
+.macro SAVE_xSRR xSRR
+	mfspr	r0,SPRN_\xSRR\()0
+	stw	r0,_\xSRR\()0(r1)
+	mfspr	r0,SPRN_\xSRR\()1
+	stw	r0,_\xSRR\()1(r1)
+.endm
+
+.macro SAVE_MMU_REGS
+#ifdef CONFIG_PPC_BOOK3E_MMU
+	mfspr	r0,SPRN_MAS0
+	stw	r0,MAS0(r1)
+	mfspr	r0,SPRN_MAS1
+	stw	r0,MAS1(r1)
+	mfspr	r0,SPRN_MAS2
+	stw	r0,MAS2(r1)
+	mfspr	r0,SPRN_MAS3
+	stw	r0,MAS3(r1)
+	mfspr	r0,SPRN_MAS6
+	stw	r0,MAS6(r1)
+#ifdef CONFIG_PHYS_64BIT
+	mfspr	r0,SPRN_MAS7
+	stw	r0,MAS7(r1)
+#endif /* CONFIG_PHYS_64BIT */
+#endif /* CONFIG_PPC_BOOK3E_MMU */
+#ifdef CONFIG_44x
+	mfspr	r0,SPRN_MMUCR
+	stw	r0,MMUCR(r1)
+#endif
+.endm
+
 #define CRITICAL_EXCEPTION_PROLOG(intno) \
 		EXC_LEVEL_EXCEPTION_PROLOG(CRIT, intno, SPRN_CSRR0, SPRN_CSRR1)
 #define DEBUG_EXCEPTION_PROLOG \
@@ -271,6 +301,8 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	START_EXCEPTION(label);						\
 	CRITICAL_EXCEPTION_PROLOG(intno);				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
+	SAVE_MMU_REGS;							\
+	SAVE_xSRR SRR;							\
 	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
 			  crit_transfer_to_handler, ret_from_crit_exc)
 
@@ -280,6 +312,10 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	mfspr	r5,SPRN_ESR;					\
 	stw	r5,_ESR(r11);					\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	SAVE_xSRR DSRR;						\
+	SAVE_xSRR CSRR;						\
+	SAVE_MMU_REGS;						\
+	SAVE_xSRR SRR;						\
 	EXC_XFER_TEMPLATE(hdlr, n+4, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
 			  mcheck_transfer_to_handler, ret_from_mcheck_exc)
 
@@ -363,6 +399,9 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 2:	mfspr	r4,SPRN_DBSR;						      \
 	stw	r4,_ESR(r11);		/* DebugException takes DBSR in _ESR */\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	SAVE_xSRR CSRR;							      \
+	SAVE_MMU_REGS;							      \
+	SAVE_xSRR SRR;							      \
 	EXC_XFER_TEMPLATE(DebugException, 0x2008, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), debug_transfer_to_handler, ret_from_debug_exc)
 
 #define DEBUG_CRIT_EXCEPTION						      \
@@ -417,6 +456,8 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 2:	mfspr	r4,SPRN_DBSR;						      \
 	stw	r4,_ESR(r11);		/* DebugException takes DBSR in _ESR */\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	SAVE_MMU_REGS;							      \
+	SAVE_xSRR SRR;							      \
 	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), crit_transfer_to_handler, ret_from_crit_exc)
 
 #define DATA_STORAGE_EXCEPTION						      \
-- 
2.25.0

