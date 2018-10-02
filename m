Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF07BC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 11:42:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49224206B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 11:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ey6x+f14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49224206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PchR2YBczF3CF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 21:42:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ey6x+f14";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSC5LldzF36D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:31:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ey6x+f14"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSC3mqPz9t0J; Tue,  2 Oct 2018 21:31:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSC1st8z9t0G;
 Tue,  2 Oct 2018 21:31:55 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479915; bh=LZ7YHdWgYUnWjnAjzveTEW6l+922CIaZwEKdlvAJOLE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ey6x+f14HkDuES4VHCZ22DBFEn4Bz9Ff4tGon70tsM/xRt9XAMLXwDu9+U+yfMWxs
 nBprSaf4DLwr61t+PUpoSSrJ+bMZnb09CUNbmfnfKRQY7dHTTKuTiSfj0Z37JuPdAH
 S+P+6sE1TeXTPXLPvJriwTTi2t4FIaMHe64Zf1rBdEtLxKgP+tM/wj4ameyvzSHyjp
 LqAUy/48C6TMFUILjqIdz34fTRZvuTnb5x0KrytCWsEx0GuEMy0XKwBlZjtfe4loPK
 4tjqFRkVFKQIBenAcZQSOrt/xn7bDraQqpFfP4zqsJ62PpD4layTvYmQm2MiUwZF7O
 B9H/k1ssdZ0Gw==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 04/33] KVM: PPC: Book3S HV: Move interrupt delivery on
 guest entry to C code
Date: Tue,  2 Oct 2018 21:31:03 +1000
Message-Id: <1538479892-14835-5-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is based on a patch by Suraj Jitindar Singh.

This moves the code in book3s_hv_rmhandlers.S that generates an
external, decrementer or privileged doorbell interrupt just before
entering the guest to C code in book3s_hv_builtin.c.  This is to
make future maintenance and modification easier.  The algorithm
expressed in the C code is almost identical to the previous
algorithm.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_ppc.h      |  1 +
 arch/powerpc/kvm/book3s_hv.c            |  3 +-
 arch/powerpc/kvm/book3s_hv_builtin.c    | 48 ++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 70 ++++++++-------------------------
 4 files changed, 67 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index e991821..83d61b8 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -652,6 +652,7 @@ int kvmppc_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
                     unsigned long mfrr);
 int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
 int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr);
+void kvmppc_guest_entry_inject_int(struct kvm_vcpu *vcpu);
 
 /*
  * Host-side operations we want to set up while running in real
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3e3a715..49a686c 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -730,8 +730,7 @@ static bool kvmppc_doorbell_pending(struct kvm_vcpu *vcpu)
 	/*
 	 * Ensure that the read of vcore->dpdes comes after the read
 	 * of vcpu->doorbell_request.  This barrier matches the
-	 * lwsync in book3s_hv_rmhandlers.S just before the
-	 * fast_guest_return label.
+	 * smb_wmb() in kvmppc_guest_entry_inject().
 	 */
 	smp_rmb();
 	vc = vcpu->arch.vcore;
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index fc6bb96..ccfea5b 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -729,3 +729,51 @@ void kvmhv_p9_restore_lpcr(struct kvm_split_mode *sip)
 	smp_mb();
 	local_paca->kvm_hstate.kvm_split_mode = NULL;
 }
+
+/*
+ * Is there a PRIV_DOORBELL pending for the guest (on POWER9)?
+ * Can we inject a Decrementer or a External interrupt?
+ */
+void kvmppc_guest_entry_inject_int(struct kvm_vcpu *vcpu)
+{
+	int ext;
+	unsigned long vec = 0;
+	unsigned long lpcr;
+
+	/* Insert EXTERNAL bit into LPCR at the MER bit position */
+	ext = (vcpu->arch.pending_exceptions >> BOOK3S_IRQPRIO_EXTERNAL) & 1;
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr |= ext << LPCR_MER_SH;
+	mtspr(SPRN_LPCR, lpcr);
+	isync();
+
+	if (vcpu->arch.shregs.msr & MSR_EE) {
+		if (ext) {
+			vec = BOOK3S_INTERRUPT_EXTERNAL;
+		} else {
+			long int dec = mfspr(SPRN_DEC);
+			if (!(lpcr & LPCR_LD))
+				dec = (int) dec;
+			if (dec < 0)
+				vec = BOOK3S_INTERRUPT_DECREMENTER;
+		}
+	}
+	if (vec) {
+		unsigned long msr, old_msr = vcpu->arch.shregs.msr;
+
+		kvmppc_set_srr0(vcpu, kvmppc_get_pc(vcpu));
+		kvmppc_set_srr1(vcpu, old_msr);
+		kvmppc_set_pc(vcpu, vec);
+		msr = vcpu->arch.intr_msr;
+		if (MSR_TM_ACTIVE(old_msr))
+			msr |= MSR_TS_S;
+		vcpu->arch.shregs.msr = msr;
+	}
+
+	if (vcpu->arch.doorbell_request) {
+		mtspr(SPRN_DPDES, 1);
+		vcpu->arch.vcore->dpdes = 1;
+		smp_wmb();
+		vcpu->arch.doorbell_request = 0;
+	}
+}
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 77960e6..6752da1 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1101,13 +1101,20 @@ no_xive:
 #endif /* CONFIG_KVM_XICS */
 
 deliver_guest_interrupt:
-	ld	r6, VCPU_CTR(r4)
-	ld	r7, VCPU_XER(r4)
-
-	mtctr	r6
-	mtxer	r7
-
 kvmppc_cede_reentry:		/* r4 = vcpu, r13 = paca */
+	/* Check if we can deliver an external or decrementer interrupt now */
+	ld	r0, VCPU_PENDING_EXC(r4)
+BEGIN_FTR_SECTION
+	/* On POWER9, also check for emulated doorbell interrupt */
+	lbz	r3, VCPU_DBELL_REQ(r4)
+	or	r0, r0, r3
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+	cmpdi	r0, 0
+	beq	71f
+	mr	r3, r4
+	bl	kvmppc_guest_entry_inject_int
+	ld	r4, HSTATE_KVM_VCPU(r13)
+71:
 	ld	r10, VCPU_PC(r4)
 	ld	r11, VCPU_MSR(r4)
 	ld	r6, VCPU_SRR0(r4)
@@ -1120,53 +1127,10 @@ kvmppc_cede_reentry:		/* r4 = vcpu, r13 = paca */
 	rotldi	r11, r11, 1 + MSR_HV_LG
 	ori	r11, r11, MSR_ME
 
-	/* Check if we can deliver an external or decrementer interrupt now */
-	ld	r0, VCPU_PENDING_EXC(r4)
-	rldicl	r0, r0, 64 - BOOK3S_IRQPRIO_EXTERNAL, 63
-	cmpdi	cr1, r0, 0
-	andi.	r8, r11, MSR_EE
-	mfspr	r8, SPRN_LPCR
-	/* Insert EXTERNAL bit into LPCR at the MER bit position */
-	rldimi	r8, r0, LPCR_MER_SH, 63 - LPCR_MER_SH
-	mtspr	SPRN_LPCR, r8
-	isync
-	beq	5f
-	li	r0, BOOK3S_INTERRUPT_EXTERNAL
-	bne	cr1, 12f
-	mfspr	r0, SPRN_DEC
-BEGIN_FTR_SECTION
-	/* On POWER9 check whether the guest has large decrementer enabled */
-	andis.	r8, r8, LPCR_LD@h
-	bne	15f
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
-	extsw	r0, r0
-15:	cmpdi	r0, 0
-	li	r0, BOOK3S_INTERRUPT_DECREMENTER
-	bge	5f
-
-12:	mtspr	SPRN_SRR0, r10
-	mr	r10,r0
-	mtspr	SPRN_SRR1, r11
-	mr	r9, r4
-	bl	kvmppc_msr_interrupt
-5:
-BEGIN_FTR_SECTION
-	b	fast_guest_return
-END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
-	/* On POWER9, check for pending doorbell requests */
-	lbz	r0, VCPU_DBELL_REQ(r4)
-	cmpwi	r0, 0
-	beq	fast_guest_return
-	ld	r5, HSTATE_KVM_VCORE(r13)
-	/* Set DPDES register so the CPU will take a doorbell interrupt */
-	li	r0, 1
-	mtspr	SPRN_DPDES, r0
-	std	r0, VCORE_DPDES(r5)
-	/* Make sure other cpus see vcore->dpdes set before dbell req clear */
-	lwsync
-	/* Clear the pending doorbell request */
-	li	r0, 0
-	stb	r0, VCPU_DBELL_REQ(r4)
+	ld	r6, VCPU_CTR(r4)
+	ld	r7, VCPU_XER(r4)
+	mtctr	r6
+	mtxer	r7
 
 /*
  * Required state:
-- 
2.7.4

