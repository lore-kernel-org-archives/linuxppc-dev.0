Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54216C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:50:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A7C2087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="HG9K9bZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A7C2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T9wF4L3dzDrNP
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:50:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="HG9K9bZS";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T8BF08R0zF37Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:32:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="HG9K9bZS"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T8BC2mhwzB2xm; Mon,  8 Oct 2018 16:32:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T8BB2WMLzB4NW;
 Mon,  8 Oct 2018 16:32:02 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976722; bh=wy7ackH/b32+NYcRU69briMwS7L0CXa33LO/gRtA7m8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HG9K9bZSUxMi20m/o0/o3Ho2Mj56yId3aQnE0H/+num1VjTpgwEOb7nmpbDBiagkl
 MSdCgM4vVuDaTZJmPkYlMxFakz4yxDY0DbC375IyK6uN76mYkLpK/Bxhtt7XIuwITB
 As3NEyRIFQbx6EuiMwQB+3hii5+7En5knQSBVlNo4yg5cFNwlp0z8yD5rsFpykyKUf
 ZtiyjIv+lnXzP5j6Exm3Xpm0UAMf54Y74O1mrxMyyX/tzNSEQBDeBJ5BrCt8Jo5ti9
 TlfnaR55hDLK+NmWWLqRPrsWLzV/kedxsviwKGdjD4ZP3dr9XHXA04nfXdIpoAn+sx
 vCC1Y3ZI4dSQg==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 30/33] KVM: PPC: Book3S HV: Allow HV module to load without
 hypervisor mode
Date: Mon,  8 Oct 2018 16:31:16 +1100
Message-Id: <1538976679-1363-31-git-send-email-paulus@ozlabs.org>
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

With this, the KVM-HV module can be loaded in a guest running under
KVM-HV, and if the hypervisor supports nested virtualization, this
guest can now act as a nested hypervisor and run nested guests.

This also adds some checks to inform userspace that HPT guests are not
supported by nested hypervisors (by returning false for the
KVM_CAP_PPC_MMU_HASH_V3 capability), and to prevent userspace from
configuring a guest to use HPT mode.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 16 ++++++++++++----
 arch/powerpc/kvm/powerpc.c   |  3 ++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 127bb5f..152bf75 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4807,11 +4807,15 @@ static int kvmppc_core_emulate_mfspr_hv(struct kvm_vcpu *vcpu, int sprn,
 
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
@@ -5129,6 +5133,10 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
 	if (radix && !radix_enabled())
 		return -EINVAL;
 
+	/* If we're a nested hypervisor, we currently only support radix */
+	if (kvmhv_on_pseries() && !radix)
+		return -EINVAL;
+
 	mutex_lock(&kvm->lock);
 	if (radix != kvm_is_radix(kvm)) {
 		if (kvm->arch.mmu_ready) {
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index eba5756..1f4b128 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -594,7 +594,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = !!(hv_enabled && radix_enabled());
 		break;
 	case KVM_CAP_PPC_MMU_HASH_V3:
-		r = !!(hv_enabled && cpu_has_feature(CPU_FTR_ARCH_300));
+		r = !!(hv_enabled && cpu_has_feature(CPU_FTR_ARCH_300) &&
+		       cpu_has_feature(CPU_FTR_HVMODE));
 		break;
 #endif
 	case KVM_CAP_SYNC_MMU:
-- 
2.7.4

