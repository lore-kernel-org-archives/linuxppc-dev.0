Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D26C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 14:34:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445442054F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 14:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfnAQX62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445442054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ggPx1mQ8zDqTN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 00:34:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HfnAQX62"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ggLQ4S4KzDqC9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 00:31:10 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id b3so5224872plr.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ycgIpnEDiTZiXd27c1ylsQRxkXqEnEX9tvsSE8HOZaE=;
 b=HfnAQX620PVqTvbvh9M3vg4hkwqAxRwWokU+MFhGwQj51HtDRJ4x1jNJNqIEPKqgqv
 JSyfUAsY4n7Sbvv59aG2/3p9xgVmXaqt8M2bDxl2yOQCwVZ4L04AM/pLS8Hm7E7QucdP
 OW9fDx6GvgrZFMGCqC61/9JPcIDVaj7sa/wgel0hlUF19q3XhgDiGvQSFh9DiEWEQ0uq
 IQZiFp2klnN/G3vZyMTkNNGuqOWsU8xhcPeTVo9RE2yozZWnGYRpEChLMX6aVG55akSW
 FqK9Do+fd/PEC/MDynmm9CIRvoKa+ELqleD47vuaKTicByB96WSPEZQiwGUMiehSiW81
 n31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ycgIpnEDiTZiXd27c1ylsQRxkXqEnEX9tvsSE8HOZaE=;
 b=maqE+4g/byjgNsiINlQ3Lbmq+VqC8w5MtFsxnKOYl45jHTVV81xS44N+937BUs7n8B
 8ii9rnHoD8db0gRLFR1zsDQz42VV9nCKrfEG1oNt4Q/CB4QcaZjfB2lLbQQcZqhNO1nr
 gkfn+pMVvdo1eVUaozUDsZSre6n1Q2SbvFMG436abD8KqFe65YWA0k91a7TZZ/U7pOrF
 b7Q0fpeLBPMmahvE1dm8gncjb1lMtuU/TgfVO4q9dv9EBnpnTbRSZ+ro8FuLxoLk8KAB
 hJ5/B79DDF5HKCHW1VJF13HxsbJqt1E+ifka/kAA/MJRo58PBj0ySXuMMLPjaTWg7+1z
 qpOQ==
X-Gm-Message-State: APjAAAXbfesbYYFFGgHqMqzzmp/CYfTYTZzCg0eohetPBkz3Ahl7GVZp
 Q5go2fP9Gy8Z2YoG52OWsGz0VovF
X-Google-Smtp-Source: APXvYqwpeiJbjbFYJYq59d89u7+luyGwj+DvFXjgv0frHgzzsLRw3jZkCRqlQ9IpKaQhoWC5HP9ONQ==
X-Received: by 2002:a17:902:9b83:: with SMTP id
 y3mr55737747plp.165.1555079467986; 
 Fri, 12 Apr 2019 07:31:07 -0700 (PDT)
Received: from bobo.local0.net (115-64-237-195.tpgi.com.au. [115.64.237.195])
 by smtp.gmail.com with ESMTPSA id
 p66sm60802703pfb.4.2019.04.12.07.31.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Apr 2019 07:31:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v9 2/2] powerpc/64s: KVM update for reimplement book3s idle
 code in C
Date: Sat, 13 Apr 2019 00:30:53 +1000
Message-Id: <20190412143053.18567-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412143053.18567-1-npiggin@gmail.com>
References: <20190412143053.18567-1-npiggin@gmail.com>
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is the KVM update to the new idle code. A few improvements:

- Idle sleepers now always return to caller rather than branch out
  to KVM first.
- This allows optimisations like very fast return to caller when no
  state has been lost.
- KVM no longer requires nap_state_lost because it controls NVGPR
  save/restore itself on the way in and out.
- The heavy idle wakeup KVM request check can be moved out of the
  normal host idle code and into the not-performance-critical offline
  code.
- KVM nap code now returns from where it is called, which makes the
  flow a bit easier to follow.
---
 arch/powerpc/include/asm/paca.h         |   1 -
 arch/powerpc/kernel/asm-offsets.c       |   1 -
 arch/powerpc/kernel/exceptions-64s.S    |  14 ++-
 arch/powerpc/kernel/idle_book3s.S       |  22 -----
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 119 ++++++++++++++----------
 arch/powerpc/platforms/powernv/idle.c   |  15 +++
 arch/powerpc/xmon/xmon.c                |   3 -
 7 files changed, 93 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e55dedd7ee3e..245d11a71784 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -174,7 +174,6 @@ struct paca_struct {
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
 	u8 pmcregs_in_use;		/* pseries puts this in lppaca */
 #endif
 	u64 sprg_vdso;			/* Saved user-visible sprg */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 167a59fda12e..83ad99f9f05d 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -268,7 +268,6 @@ int main(void)
 	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime);
 	OFFSET(ACCOUNT_SYSTEM_TIME, paca_struct, accounting.stime);
 	OFFSET(PACA_TRAP_SAVE, paca_struct, trap_save);
-	OFFSET(PACA_NAPSTATELOST, paca_struct, nap_state_lost);
 	OFFSET(PACA_SPRG_VDSO, paca_struct, sprg_vdso);
 #else /* CONFIG_PPC64 */
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index c4c50bca12c7..6247b5bbfa5c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -121,6 +121,8 @@ EXC_VIRT_NONE(0x4000, 0x100)
 	rlwinm.	r10,r10,47-31,30,31 ;					\
 	beq-	1f ;							\
 	cmpwi	cr1,r10,2 ;						\
+	mfspr	r3,SPRN_SRR1 ;						\
+	bltlr	cr1 ;	/* no state loss, return to idle caller */	\
 	BRANCH_TO_C000(r10, system_reset_idle_common) ;			\
 1:									\
 	KVMTEST_PR(n) ;							\
@@ -144,12 +146,10 @@ TRAMP_KVM(PACA_EXNMI, 0x100)
 
 #ifdef CONFIG_PPC_P7_NAP
 EXC_COMMON_BEGIN(system_reset_idle_common)
-	mfspr	r3,SPRN_SRR1
-#ifndef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	/* this bltlr could  be moved before the branch_to, and the
-	 * branch_to could maybe go straight to idle_return */
-	bltlr	cr1	/* no state loss, return to idle caller */
-#endif
+	/*
+	 * This must be a direct branch (without linker branch stub) because
+	 * we can not use TOC at this point as r2 may not be restored yet.
+	 */
 	b	idle_return_gpr_loss
 #endif
 
@@ -441,9 +441,7 @@ EXC_COMMON_BEGIN(machine_check_idle_common)
 	mtlr	r4
 	rlwinm	r10,r3,47-31,30,31
 	cmpwi	cr1,r10,2
-#ifndef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	bltlr	cr1	/* no state loss, return to idle caller */
-#endif
 	b	idle_return_gpr_loss
 #endif
 	/*
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 0fb2eb731a29..2dfbd5d5b932 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -19,9 +19,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/ppc-opcode.h>
 #include <asm/cpuidle.h>
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-#include <asm/kvm_book3s_asm.h>
-#endif
 
 /*
  * Desired PSSCR in r3
@@ -93,25 +90,6 @@ _GLOBAL(isa300_idle_stop_mayloss)
  * a simple blr instead).
  */
 _GLOBAL(idle_return_gpr_loss)
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	lbz	r0,HSTATE_HWTHREAD_STATE(r13)
-	cmpwi	r0,KVM_HWTHREAD_IN_KERNEL
-	beq	0f
-	li	r0,KVM_HWTHREAD_IN_KERNEL
-	stb	r0,HSTATE_HWTHREAD_STATE(r13)
-	/* Order setting hwthread_state vs. testing hwthread_req */
-	sync
-0:	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
-	cmpwi	r0,0
-	beq	1f
-	b	kvm_start_guest
-1:
-	lbz	r0,PACA_NAPSTATELOST(r13)
-	cmpwi	r0,0
-	bne	2f
-	bltlr	cr1
-2:
-#endif
 	ld	r1,PACAR1(r13)
 	ld	r4,-8*19(r1)
 	ld	r5,-8*20(r1)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 58d0f1ba845d..e9c69089080a 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -35,6 +35,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
+#include <asm/cpuidle.h>
 
 /* Sign-extend HDEC if not on POWER9 */
 #define EXTEND_HDEC(reg)			\
@@ -45,6 +46,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 /* Values in HSTATE_NAPPING(r13) */
 #define NAPPING_CEDE	1
 #define NAPPING_NOVCPU	2
+#define NAPPING_UNSPLIT	3
 
 /* Stack frame offsets for kvmppc_hv_entry */
 #define SFS			208
@@ -290,17 +292,20 @@ kvm_novcpu_exit:
 	b	kvmhv_switch_to_host
 
 /*
- * We come in here when wakened from nap mode.
- * Relocation is off and most register values are lost.
- * r13 points to the PACA.
+ * We come in here when wakened from Linux offline idle code.
+ * Relocation is off
  * r3 contains the SRR1 wakeup value, SRR1 is trashed.
  */
-	.globl	kvm_start_guest
-kvm_start_guest:
-	/* Set runlatch bit the minute you wake up from nap */
-	mfspr	r0, SPRN_CTRLF
-	ori 	r0, r0, 1
-	mtspr	SPRN_CTRLT, r0
+	.globl	idle_kvm_start_guest
+idle_kvm_start_guest:
+	ld	r4,PACAEMERGSP(r13)
+	mfcr	r5
+	mflr	r0
+	std	r1,0(r4)
+	std	r5,8(r4)
+	std	r0,16(r4)
+	subi	r1,r4,STACK_FRAME_OVERHEAD
+	SAVE_NVGPRS(r1)
 
 	/*
 	 * Could avoid this and pass it through in r3. For now,
@@ -308,27 +313,23 @@ kvm_start_guest:
 	 */
 	mtspr	SPRN_SRR1,r3
 
-	ld	r2,PACATOC(r13)
-
 	li	r0,0
 	stb	r0,PACA_FTRACE_ENABLED(r13)
 
 	li	r0,KVM_HWTHREAD_IN_KVM
 	stb	r0,HSTATE_HWTHREAD_STATE(r13)
 
-	/* NV GPR values from power7_idle() will no longer be valid */
-	li	r0,1
-	stb	r0,PACA_NAPSTATELOST(r13)
-
-	/* were we napping due to cede? */
+	/* kvm cede / napping does not come through here */
 	lbz	r0,HSTATE_NAPPING(r13)
-	cmpwi	r0,NAPPING_CEDE
-	beq	kvm_end_cede
-	cmpwi	r0,NAPPING_NOVCPU
-	beq	kvm_novcpu_wakeup
+	twnei	r0,0
+
+	b	1f
 
-	ld	r1,PACAEMERGSP(r13)
-	subi	r1,r1,STACK_FRAME_OVERHEAD
+kvm_unsplit_wakeup:
+	li	r0, 0
+	stb	r0, HSTATE_NAPPING(r13)
+
+1:
 
 	/*
 	 * We weren't napping due to cede, so this must be a secondary
@@ -437,21 +438,25 @@ kvm_no_guest:
 	lbz	r3, HSTATE_HWTHREAD_REQ(r13)
 	cmpwi	r3, 0
 	bne	54f
-/*
- * We jump to pnv_wakeup_loss, which will return to the caller
- * of power7_nap in the powernv cpu offline loop.  The value we
- * put in r3 becomes the return value for power7_nap. pnv_wakeup_loss
- * requires SRR1 in r12.
- */
+
+	/*
+	 * Jump to idle_return_gpr_loss, which returns to the
+	 * idle_kvm_start_guest caller.
+	 */
 	li	r3, LPCR_PECE0
 	mfspr	r4, SPRN_LPCR
 	rlwimi	r4, r3, 0, LPCR_PECE0 | LPCR_PECE1
 	mtspr	SPRN_LPCR, r4
-	li	r3, 0
-	/* set up cr3 and r3 for return */
-	cmpdi	cr3, r3, 0
+	/* set up r3 for return */
 	mfspr	r3,SPRN_SRR1
-	b	idle_return_gpr_loss
+	REST_NVGPRS(r1)
+	addi	r1, r1, STACK_FRAME_OVERHEAD
+	ld	r0, 16(r1)
+	ld	r5, 8(r1)
+	ld	r1, 0(r1)
+	mtlr	r0
+	mtcr	r5
+	blr
 
 53:	HMT_LOW
 	ld	r5, HSTATE_KVM_VCORE(r13)
@@ -536,6 +541,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	lbz	r0, KVM_SPLIT_DO_NAP(r3)
 	cmpwi	r0, 0
 	beq	57f
+	li	r3, NAPPING_UNSPLIT
+	stb	r3, HSTATE_NAPPING(r13)
 	li	r3, (LPCR_PECEDH | LPCR_PECE0) >> 4
 	mfspr	r5, SPRN_LPCR
 	rlwimi	r5, r3, 4, (LPCR_PECEDP | LPCR_PECEDH | LPCR_PECE0 | LPCR_PECE1)
@@ -2656,6 +2663,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
 	lis	r3, LPCR_PECEDP@h	/* Do wake on privileged doorbell */
 
+	/* Go back to host stack */
+	ld	r1, HSTATE_HOST_R1(r13)
+
 	/*
 	 * Take a nap until a decrementer or external or doobell interrupt
 	 * occurs, with PECE1 and PECE0 set in LPCR.
@@ -2684,26 +2694,42 @@ BEGIN_FTR_SECTION
 	 *		requested level = 0 (just stop dispatching)
 	 */
 	lis	r3, (PSSCR_EC | PSSCR_ESL)@h
-	mtspr	SPRN_PSSCR, r3
 	/* Set LPCR_PECE_HVEE bit to enable wakeup by HV interrupts */
 	li	r4, LPCR_PECE_HVEE@higher
 	sldi	r4, r4, 32
 	or	r5, r5, r4
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+FTR_SECTION_ELSE
+	li	r3, PNV_THREAD_NAP
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	mtspr	SPRN_LPCR,r5
 	isync
-	li	r0, 0
-	std	r0, HSTATE_SCRATCH0(r13)
-	ptesync
-	ld	r0, HSTATE_SCRATCH0(r13)
-1:	cmpd	r0, r0
-	bne	1b
+
 BEGIN_FTR_SECTION
-	nap
+	bl	isa300_idle_stop_mayloss
 FTR_SECTION_ELSE
-	PPC_STOP
-ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
-	b	.
+	bl	isa206_idle_insn_mayloss
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
+
+	mfspr	r0, SPRN_CTRLF
+	ori	r0, r0, 1
+	mtspr	SPRN_CTRLT, r0
+
+	mtspr	SPRN_SRR1, r3
+
+	li	r0, 0
+	stb	r0, PACA_FTRACE_ENABLED(r13)
+
+	li	r0, KVM_HWTHREAD_IN_KVM
+	stb	r0, HSTATE_HWTHREAD_STATE(r13)
+
+	lbz	r0, HSTATE_NAPPING(r13)
+	cmpwi	r0, NAPPING_CEDE
+	beq	kvm_end_cede
+	cmpwi	r0, NAPPING_NOVCPU
+	beq	kvm_novcpu_wakeup
+	cmpwi	r0, NAPPING_UNSPLIT
+	beq	kvm_unsplit_wakeup
+	twi	31,0,0 /* Nap state must not be zero */
 
 33:	mr	r4, r3
 	li	r3, 0
@@ -2711,12 +2737,11 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 	b	34f
 
 kvm_end_cede:
+	/* Woken by external or decrementer interrupt */
+
 	/* get vcpu pointer */
 	ld	r4, HSTATE_KVM_VCPU(r13)
 
-	/* Woken by external or decrementer interrupt */
-	ld	r1, HSTATE_HOST_R1(r13)
-
 #ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
 	addi	r3, r4, VCPU_TB_RMINTR
 	bl	kvmhv_accumulate_time
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 36bafeaa5514..7f7e7cdffcf5 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -482,6 +482,8 @@ static unsigned long power7_idle_insn(unsigned long type)
 	return srr1;
 }
 
+extern unsigned long idle_kvm_start_guest(unsigned long srr1);
+
 #ifdef CONFIG_HOTPLUG_CPU
 static unsigned long power7_offline(void)
 {
@@ -513,6 +515,14 @@ static unsigned long power7_offline(void)
 	srr1 = power7_idle_insn(power7_offline_type);
 	__ppc64_runlatch_on();
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_KERNEL;
+	/* Order setting hwthread_state vs. testing hwthread_req */
+	smp_mb();
+	if (local_paca->kvm_hstate.hwthread_req)
+		srr1 = idle_kvm_start_guest(srr1);
+#endif
+
 	mtmsr(MSR_KERNEL);
 
 	return srr1;
@@ -784,6 +794,11 @@ static unsigned long power9_offline_stop(unsigned long psscr)
 	srr1 = power9_idle_stop(psscr, false);
 	__ppc64_runlatch_on();
 
+	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_KERNEL;
+	/* Order setting hwthread_state vs. testing hwthread_req */
+	smp_mb();
+	if (local_paca->kvm_hstate.hwthread_req)
+		srr1 = idle_kvm_start_guest(srr1);
 	mtmsr(MSR_KERNEL);
 #endif
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 77197110e900..e583ed3f6b93 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2431,9 +2431,6 @@ static void dump_one_paca(int cpu)
 	DUMP(p, irq_happened, "%#-*x");
 	DUMP(p, io_sync, "%#-*x");
 	DUMP(p, irq_work_pending, "%#-*x");
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	DUMP(p, nap_state_lost, "%#-*x");
-#endif
 	DUMP(p, sprg_vdso, "%#-*llx");
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-- 
2.20.1

