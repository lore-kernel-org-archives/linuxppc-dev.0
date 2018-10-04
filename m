Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205CFC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:17:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810E42082A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="neV9SiwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810E42082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qths31kCzF35n
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:17:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="neV9SiwC";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qrvl3f3zzF3Js
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="neV9SiwC"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Qrvk50Gsz9sBj; Thu,  4 Oct 2018 21:56:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Qrvk2SNTzB4Md;
 Thu,  4 Oct 2018 21:56:34 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654194; bh=RU8vJXOkGPvnQbcHEEmeMKAvoSyfp/MVaDz48MQ+ovs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=neV9SiwCVZUOIb1zicectAfG+amqtCuQXcUGcFE2aRMV3L4pM4EhTus081layWmu6
 5iXtcNzfoEwAqJUWZj8dP6QI0C85+v8RHzDyKuKVlBh7W64HnFUxpiABI46MA4dzKr
 eLuUZm4YAf5dlTjIQI1cU1UQs0RiRz+4Za0CJQcoKeVZRxWZOlmEaJS4LcW/ePHAqQ
 USS6DwX7EEp3wBzlxc87fSwTdoMEy9djuqLtoW2n5tfmKGRG3SuR2/uFhvHPhFD/iI
 yIHqpFnIYuPjLBVyS4MhanHPr5WTHQAqUfIcSH4SDnu86XrWeFEzC+aePDcsq6bJAC
 7wtG9QJM1AnTg==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 26/32] KVM: PPC: Book3S HV: Don't access HFSCR,
 LPIDR or LPCR when running nested
Date: Thu,  4 Oct 2018 21:56:03 +1000
Message-Id: <1538654169-15602-27-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
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
index 53a967ea..4da9564 100644
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
 
@@ -4001,8 +4004,10 @@ int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 
 	srcu_read_unlock(&vc->kvm->srcu, srcu_idx);
 
-	mtspr(SPRN_LPID, vc->kvm->arch.host_lpid);
-	isync();
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		mtspr(SPRN_LPID, vc->kvm->arch.host_lpid);
+		isync();
+	}
 
 	trace_hardirqs_off();
 	set_irq_happened(trap);
@@ -4622,9 +4627,13 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
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

