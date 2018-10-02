Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFAEC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:53:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF5220684
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Jm85SJya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF5220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PfFw6C2fzF3HS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:53:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Jm85SJya";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSc4PRxzF36D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:32:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Jm85SJya"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSc1KcDz9t17; Tue,  2 Oct 2018 21:32:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSb5hsYz9t5G;
 Tue,  2 Oct 2018 21:32:15 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479935; bh=onpZ30losX6L9FWkz08sx4+UyR673j3BVHYTaKFeDhM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jm85SJyaG/KfMI5L3oVUZp6i7Zh/KA4ISf+VKhsq/D39Kn+/VT3bzsY118J0z5eNW
 IASPd+rjR0HZ/sWhY5vYejvgAg0U2cuRfWIINpr7d2OoGJi+xl/SNpiDqbHLT8VRJE
 ijuJW6WrcrvWxEmnCHRgZVKuXH4oLhPwuPmAtg/0mDucPMeMnKgbedoypJgGpl2vck
 kc9eFwKJbhqz/7ZHQ4OXc5YodxXwHWBqmTxBd00TYSc7kVmwa5Rwb5v3NNSxbVeRs/
 RJRjgjROVjDXXMe+CxpBXjIxTcUxKUTDez/6FeQOWrQ1vvYEzk5hNsD+Ts/6CwejV0
 G7/1LMTeZ9nhg==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 30/33] KVM: PPC: Book3S HV: Allow HV module to load without
 hypervisor mode
Date: Tue,  2 Oct 2018 21:31:29 +1000
Message-Id: <1538479892-14835-31-git-send-email-paulus@ozlabs.org>
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
index f630e91..196bff1 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4237,6 +4237,10 @@ static int kvm_vm_ioctl_get_smmu_info_hv(struct kvm *kvm,
 {
 	struct kvm_ppc_one_seg_page_size *sps;
 
+	/* If we're a nested hypervisor, we only support radix guests */
+	if (kvmhv_on_pseries())
+		return -EINVAL;
+
 	/*
 	 * POWER7, POWER8 and POWER9 all support 32 storage keys for data.
 	 * POWER7 doesn't support keys for instruction accesses,
@@ -4822,11 +4826,15 @@ static int kvmppc_core_emulate_mfspr_hv(struct kvm_vcpu *vcpu, int sprn,
 
 static int kvmppc_core_check_processor_compat_hv(void)
 {
-	if (!cpu_has_feature(CPU_FTR_HVMODE) ||
-	    !cpu_has_feature(CPU_FTR_ARCH_206))
-		return -EIO;
+	if (cpu_has_feature(CPU_FTR_HVMODE) &&
+	    cpu_has_feature(CPU_FTR_ARCH_206))
+		return 0;
 
-	return 0;
+	/* Can run as nested hypervisor on POWER9 in radix mode. */
+	if (cpu_has_feature(CPU_FTR_ARCH_300) && radix_enabled())
+		return 0;
+
+	return -EIO;
 }
 
 #ifdef CONFIG_KVM_XICS
@@ -5144,6 +5152,10 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
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

