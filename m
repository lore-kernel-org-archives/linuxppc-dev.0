Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF0DC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:44:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB4120652
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="RyLxYspF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB4120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Pf3y4J4lzF3G1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:44:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="RyLxYspF";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSY65jKzF39y
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:32:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="RyLxYspF"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSX6zTrz9t2G; Tue,  2 Oct 2018 21:32:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSX3sHlz9t2g;
 Tue,  2 Oct 2018 21:32:12 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479932; bh=XEoPNls1gJ8R1w0gCYEMrqUX2ovyPHkY7vYDaK/MnVQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RyLxYspFI90Qe7cZG5AzxYRegtlW1M1GUtJV4EBavNNn5Z8cMp/HCb0o2wcC92Igs
 yixVFjrOrI3uPyFbq5t42w4LPcYykIJMzpM++mFnWG6VeLiZxvxH4pEv4dI+ZYK3j5
 xzknDuJfsckY2vYZsH6FGsV3PBYCbCFJnoqFZaPh6LW1jv+2GioM/s2766dU67o6Ra
 vDpoQWym+J/q42bVqXt6cHY0tkEuWYceYVFhuUPzhcZMhpDjj8hcDGL1YqXF+pjjci
 pfV7wTOaO2VB23vGvv3mh8Swya5wzUgmxKnyokM4spXsXLFHrdhUsZtdYthfBVjcJQ
 czd+BPolzx0nw==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 26/33] KVM: PPC: Book3S HV: Don't access HFSCR,
 LPIDR or LPCR when running nested
Date: Tue,  2 Oct 2018 21:31:25 +1000
Message-Id: <1538479892-14835-27-git-send-email-paulus@ozlabs.org>
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
index c87d3d0..120a82c 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2197,15 +2197,18 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
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
 
@@ -4024,8 +4027,10 @@ int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 
 	srcu_read_unlock(&vc->kvm->srcu, srcu_idx);
 
-	mtspr(SPRN_LPID, vc->kvm->arch.host_lpid);
-	isync();
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		mtspr(SPRN_LPID, vc->kvm->arch.host_lpid);
+		isync();
+	}
 
 	trace_hardirqs_off();
 	set_irq_happened(trap);
@@ -4645,9 +4650,13 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
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

