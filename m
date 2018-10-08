Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79813C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:37:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9BC2087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="d47LWGY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9BC2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T9f94hLPzF35X
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:37:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="d47LWGY7";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T8B71xG5zF35x
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:31:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="d47LWGY7"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T8B53tWBz9sj6; Mon,  8 Oct 2018 16:31:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T8B50vZkzB4Nq;
 Mon,  8 Oct 2018 16:31:57 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976717; bh=ut8iX+anoVAkT+jT6tiSd0HXbJlcYS1O4WNk7zXQ0fg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d47LWGY7G3FG2IW+YLUUTpXe7I94aN4SqS3xVbqw90hmlgShCalHnR29b/DTCD8hh
 OP4GDxhieR7PrMxxuiyANZqTsctwqEsD5eI+49778ZnW41hPFt7183b6CizyOss2Ml
 tLhFGaPOrwCAXNd623IOmvndxBbMCVO945H31lZ+pllef0HNDpIYj/uoI/Z54QSgdQ
 8QUDggFAuaJf16LVWqGSTs5KGe7Gt4lEj/q0qVTyKQ7bv/ltJ2d2Z4EmXH/ibF1s+c
 Rx3SgnlN922iWU/7zIwAshZiZEAjEC/A0dBu6yHiJBZTDkG3l57qaFq4r1eQEyoyKG
 VYZ5/Fkzecgtg==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 26/33] KVM: PPC: Book3S HV: Don't access HFSCR,
 LPIDR or LPCR when running nested
Date: Mon,  8 Oct 2018 16:31:12 +1100
Message-Id: <1538976679-1363-27-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
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

When running as a nested hypervisor, this avoids reading hypervisor
privileged registers (specifically HFSCR, LPIDR and LPCR) at startup;
instead reasonable default values are used.  This also avoids writing
LPIDR in the single-vcpu entry/exit path.

Also, this removes the check for CPU_FTR_HVMODE in kvmppc_mmu_hv_init()
since its only caller already checks this.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c |  7 +++----
 arch/powerpc/kvm/book3s_hv.c        | 33 +++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 68e14af..c615617 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -268,14 +268,13 @@ int kvmppc_mmu_hv_init(void)
 {
 	unsigned long host_lpid, rsvd_lpid;
 
-	if (!cpu_has_feature(CPU_FTR_HVMODE))
-		return -EINVAL;
-
 	if (!mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE))
 		return -EINVAL;
 
 	/* POWER7 has 10-bit LPIDs (12-bit in POWER8) */
-	host_lpid = mfspr(SPRN_LPID);
+	host_lpid = 0;
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		host_lpid = mfspr(SPRN_LPID);
 	rsvd_lpid = LPID_RSVD;
 
 	kvmppc_init_lpid(rsvd_lpid + 1);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 24a6683..b8f14ea 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2174,15 +2174,18 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	 * Set the default HFSCR for the guest from the host value.
 	 * This value is only used on POWER9.
 	 * On POWER9, we want to virtualize the doorbell facility, so we
-	 * turn off the HFSCR bit, which causes those instructions to trap.
+	 * don't set the HFSCR_MSGP bit, and that causes those instructions
+	 * to trap and then we emulate them.
 	 */
-	vcpu->arch.hfscr = mfspr(SPRN_HFSCR);
-	if (cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
+	vcpu->arch.hfscr = HFSCR_TAR | HFSCR_EBB | HFSCR_PM | HFSCR_BHRB |
+		HFSCR_DSCR | HFSCR_VECVSX | HFSCR_FP;
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		vcpu->arch.hfscr &= mfspr(SPRN_HFSCR);
+		if (cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
+			vcpu->arch.hfscr |= HFSCR_TM;
+	}
+	if (cpu_has_feature(CPU_FTR_TM_COMP))
 		vcpu->arch.hfscr |= HFSCR_TM;
-	else if (!cpu_has_feature(CPU_FTR_TM_COMP))
-		vcpu->arch.hfscr &= ~HFSCR_TM;
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		vcpu->arch.hfscr &= ~HFSCR_MSGP;
 
 	kvmppc_mmu_book3s_hv_init(vcpu);
 
@@ -4002,8 +4005,10 @@ int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 
-	mtspr(SPRN_LPID, kvm->arch.host_lpid);
-	isync();
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		mtspr(SPRN_LPID, kvm->arch.host_lpid);
+		isync();
+	}
 
 	trace_hardirqs_off();
 	set_irq_happened(trap);
@@ -4630,9 +4635,13 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 		kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
 
 	/* Init LPCR for virtual RMA mode */
-	kvm->arch.host_lpid = mfspr(SPRN_LPID);
-	kvm->arch.host_lpcr = lpcr = mfspr(SPRN_LPCR);
-	lpcr &= LPCR_PECE | LPCR_LPES;
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		kvm->arch.host_lpid = mfspr(SPRN_LPID);
+		kvm->arch.host_lpcr = lpcr = mfspr(SPRN_LPCR);
+		lpcr &= LPCR_PECE | LPCR_LPES;
+	} else {
+		lpcr = 0;
+	}
 	lpcr |= (4UL << LPCR_DPFD_SH) | LPCR_HDICE |
 		LPCR_VPM0 | LPCR_VPM1;
 	kvm->arch.vrma_slb_v = SLB_VSID_B_1T |
-- 
2.7.4

