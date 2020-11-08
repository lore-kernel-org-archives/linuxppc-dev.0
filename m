Return-Path: <SRS0=GXYn=EO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95916C388F9
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2020 17:02:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9730B206C0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2020 17:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9730B206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CTgRX5cv5zDqyS
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2020 04:02:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CTgKj158jzDqZH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Nov 2020 03:57:42 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CTgKT3wZXz9tyqT;
 Sun,  8 Nov 2020 17:57:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8pQCq4HOlVkq; Sun,  8 Nov 2020 17:57:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CTgKT3689z9tyqR;
 Sun,  8 Nov 2020 17:57:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 33A758B77F;
 Sun,  8 Nov 2020 17:57:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PFwlpPKVlyhe; Sun,  8 Nov 2020 17:57:37 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E2A5F8B75B;
 Sun,  8 Nov 2020 17:57:36 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id B88E166855; Sun,  8 Nov 2020 16:57:36 +0000 (UTC)
Message-Id: <b901ddfdeb8a0a3b7cb59999599cdfde1bbfe834.1604854583.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7719261b0a0d2787772339484c33eb809723bca7.1604854583.git.christophe.leroy@csgroup.eu>
References: <7719261b0a0d2787772339484c33eb809723bca7.1604854583.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/3] powerpc: Replace RFI by rfi on book3s/32 and booke
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Sun,  8 Nov 2020 16:57:36 +0000 (UTC)
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

For book3s/32 and for booke, RFI is just an rfi.
Only 40x has a non trivial RFI.
CONFIG_PPC_RTAS is never selected by 40x platforms.

Make it more explicit by replacing RFI by rfi wherever possible.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S       |  6 +++---
 arch/powerpc/kernel/head_book3s_32.S | 18 +++++++++---------
 arch/powerpc/kernel/head_booke.h     |  2 +-
 arch/powerpc/kvm/book3s_rmhandlers.S |  4 ++--
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 8cdc8bcde703..e10e1167ffb1 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1027,7 +1027,7 @@ exc_exit_restart:
 	lwz	r1,GPR1(r1)
 	.globl exc_exit_restart_end
 exc_exit_restart_end:
-	RFI
+	rfi
 _ASM_NOKPROBE_SYMBOL(exc_exit_restart)
 _ASM_NOKPROBE_SYMBOL(exc_exit_restart_end)
 
@@ -1356,7 +1356,7 @@ _GLOBAL(enter_rtas)
 	stw	r7, THREAD + RTAS_SP(r2)
 	mtspr	SPRN_SRR0,r8
 	mtspr	SPRN_SRR1,r9
-	RFI
+	rfi
 1:	tophys_novmstack r9, r1
 #ifdef CONFIG_VMAP_STACK
 	li	r0, MSR_KERNEL & ~MSR_IR	/* can take DTLB miss */
@@ -1371,6 +1371,6 @@ _GLOBAL(enter_rtas)
 	stw	r0, THREAD + RTAS_SP(r7)
 	mtspr	SPRN_SRR0,r8
 	mtspr	SPRN_SRR1,r9
-	RFI			/* return to caller */
+	rfi			/* return to caller */
 _ASM_NOKPROBE_SYMBOL(enter_rtas)
 #endif /* CONFIG_PPC_RTAS */
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 5eb9eedac920..40e8c8ce4018 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -206,7 +206,7 @@ turn_on_mmu:
 	lis	r0,start_here@h
 	ori	r0,r0,start_here@l
 	mtspr	SPRN_SRR0,r0
-	RFI				/* enables MMU */
+	rfi				/* enables MMU */
 
 /*
  * We need __secondary_hold as a place to hold the other cpus on
@@ -769,13 +769,13 @@ fast_hash_page_return:
 	mtcr	r11
 	lwz	r11, THR11(r10)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-	RFI
+	rfi
 
 1:	/* ISI */
 	mtcr	r11
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-	RFI
+	rfi
 
 stack_overflow:
 	vmap_stack_overflow_exception
@@ -910,7 +910,7 @@ __secondary_start:
 	ori	r3,r3,start_secondary@l
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
-	RFI
+	rfi
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_KVM_BOOK3S_HANDLER
@@ -1038,7 +1038,7 @@ start_here:
 	.align	4
 	mtspr	SPRN_SRR0,r4
 	mtspr	SPRN_SRR1,r3
-	RFI
+	rfi
 /* Load up the kernel context */
 2:	bl	load_up_mmu
 
@@ -1062,7 +1062,7 @@ start_here:
 	ori	r3,r3,start_kernel@l
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
-	RFI
+	rfi
 
 /*
  * void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next);
@@ -1177,7 +1177,7 @@ _ENTRY(update_bats)
 	.align	4
 	mtspr	SPRN_SRR0, r4
 	mtspr	SPRN_SRR1, r3
-	RFI
+	rfi
 1:	bl	clear_bats
 	lis	r3, BATS@ha
 	addi	r3, r3, BATS@l
@@ -1196,7 +1196,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 	mtmsr	r3
 	mtspr	SPRN_SRR0, r7
 	mtspr	SPRN_SRR1, r6
-	RFI
+	rfi
 
 flush_tlbs:
 	lis	r10, 0x40
@@ -1217,7 +1217,7 @@ mmu_off:
 	mtspr	SPRN_SRR0,r4
 	mtspr	SPRN_SRR1,r3
 	sync
-	RFI
+	rfi
 
 /* We use one BAT to map up to 256M of RAM at _PAGE_OFFSET */
 initial_bats:
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 71c359d438b5..e26d35de27e5 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -176,7 +176,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 #endif
 	mtspr	SPRN_SRR1,r10
 	mtspr	SPRN_SRR0,r11
-	RFI				/* jump to handler, enable MMU */
+	rfi				/* jump to handler, enable MMU */
 99:	b	ret_from_kernel_syscall
 .endm
 
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 3dc129a254b5..b45b750fa77a 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -36,8 +36,8 @@
 
 #define FUNC(name)		name
 
-#define RFI_TO_KERNEL	RFI
-#define RFI_TO_GUEST	RFI
+#define RFI_TO_KERNEL	rfi
+#define RFI_TO_GUEST	rfi
 
 .macro INTERRUPT_TRAMPOLINE intno
 
-- 
2.25.0

