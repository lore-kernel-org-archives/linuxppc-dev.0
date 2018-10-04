Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C48C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:30:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FD920877
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="nbwce5F8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FD920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qv0Z2Zn5zF3LY
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:30:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="nbwce5F8";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qrvp2cVJzF3Js
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="nbwce5F8"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Qrvp1zPGz9sj8; Thu,  4 Oct 2018 21:56:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Qrvp08PZz9sBj;
 Thu,  4 Oct 2018 21:56:38 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654198; bh=0pLjL7uOaI6nsdejBHUIOaSvgEcgItQge07EGxc8suw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nbwce5F8dc42dZONenxW7QKQpwOb8m9zMGPv/4CPeTTadE+OQg5dQd0ktN2Bqv4Mx
 dv3MUqghKajw5XdcpnV/YigJ1O/ktPQcCFeb2EGCDIz3O2e/qKWwHXKht3IPhCTh6e
 MxEHqjkwAvhtF2NtVpY+ffi9UV2kuF5gDl52x61KRfTpI04cyc+28po3D89Qh4aJzV
 b1IYOw7zakqBPuG5vnqI+/HjbhERJg0cyS4xPrJD4liWwrXqnOhnpE2vmUfaj4vZFL
 +AmptY5cNP+n5DIMQh+FAVQQVxxDLkKlWW4KU/+ooWc5TIH+3MTDmm3Nii9lydOads
 86Hzbfu+VpQjQ==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 30/32] KVM: PPC: Book3S HV: Allow HV module to load without
 hypervisor mode
Date: Thu,  4 Oct 2018 21:56:07 +1000
Message-Id: <1538654169-15602-31-git-send-email-paulus@ozlabs.org>
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

With this, the KVM-HV module can be loaded in a guest running under
KVM-HV, and if the hypervisor supports nested virtualization, this
guest can now act as a nested hypervisor and run nested guests.

This also adds some checks to inform userspace that HPT guests are not
supported by nested hypervisors, and to prevent userspace from
configuring a guest to use HPT mode.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7561c99..7f89b22 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4214,6 +4214,10 @@ static int kvm_vm_ioctl_get_smmu_info_hv(struct kvm *kvm,
 {
 	struct kvm_ppc_one_seg_page_size *sps;
 
+	/* If we're a nested hypervisor, we only support radix guests */
+	if (kvmhv_on_pseries())
+		return -EINVAL;
+
 	/*
 	 * POWER7, POWER8 and POWER9 all support 32 storage keys for data.
 	 * POWER7 doesn't support keys for instruction accesses,
@@ -4799,11 +4803,15 @@ static int kvmppc_core_emulate_mfspr_hv(struct kvm_vcpu *vcpu, int sprn,
 
 static int kvmppc_core_check_processor_compat_hv(void)
 {
-	if (!cpu_has_feature(CPU_FTR_HVMODE) ||
-	    !cpu_has_feature(CPU_FTR_ARCH_206))
-		return -EIO;
+	if (cpu_has_feature(CPU_FTR_HVMODE) &&
+	    cpu_has_feature(CPU_FTR_ARCH_206))
+		return 0;
 
-	return 0;
+	/* POWER9 in radix mode is capable of being a nested hypervisor. */
+	if (cpu_has_feature(CPU_FTR_ARCH_300) && radix_enabled())
+		return 0;
+
+	return -EIO;
 }
 
 #ifdef CONFIG_KVM_XICS
@@ -5121,6 +5129,10 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
 	if (radix && !radix_enabled())
 		return -EINVAL;
 
+	/* If we're a nested hypervisor, we currently only support radix */
+	if (kvmhv_on_pseries() && !radix)
+		return -EINVAL;
+
 	mutex_lock(&kvm->lock);
 	if (radix != kvm_is_radix(kvm)) {
 		if (kvm->arch.mmu_ready) {
-- 
2.7.4

