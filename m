Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A4C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:52:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E9B20878
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="BpXvi0oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E9B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T9zR5GrGzDr1F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:52:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="BpXvi0oe";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T8BG2X5KzF37n
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:32:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="BpXvi0oe"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T8BF5qbnzB2xm; Mon,  8 Oct 2018 16:32:05 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T8BF1xsHzB4Mq;
 Mon,  8 Oct 2018 16:32:05 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976725; bh=c364lZu0hQT294S2xvyX2N5Y48GjzNbGOVXKO3zLwGE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BpXvi0oeQsSPb6aUKfBaOF5cNZpDxmtEORpxQiJbYVmmU3nyHSTPsbA6g04mLybaR
 zznuUDrTxCGk1+ILzcPlpGehptpkgBkp4dC809SDLimm1ymga0SRryfvHpguGRfb2D
 rTCpwcFzHqJbdxcEUvFPLrmRRuhpiUJNQNFTEb3kxCEwGT4o6SgOHWBceMKvZeRwJE
 YMfff+wcdmExdADevVCgdy2ZHPaV59/M3gllcSSKW098GSUZWhVlADtvSh0/Qnn9Xt
 TyPpysM88BRK7QAXIPYV2fJWUc9OEp3QXxMG08Kc7Dg/8sKEmq16Ma3Ikrw5vTQVlY
 WyaCXmtOiOp3w==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 32/33] KVM: PPC: Book3S HV: Add a VM capability to enable
 nested virtualization
Date: Mon,  8 Oct 2018 16:31:18 +1100
Message-Id: <1538976679-1363-33-git-send-email-paulus@ozlabs.org>
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

With this, userspace can enable a KVM-HV guest to run nested guests
under it.

The administrator can control whether any nested guests can be run;
setting the "nested" module parameter to false prevents any guests
becoming nested hypervisors (that is, any attempt to enable the nested
capability on a guest will fail).  Guests which are already nested
hypervisors will continue to be so.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 Documentation/virtual/kvm/api.txt  | 14 ++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h |  1 +
 arch/powerpc/kvm/book3s_hv.c       | 39 +++++++++++++++++++++++++++++---------
 arch/powerpc/kvm/powerpc.c         | 12 ++++++++++++
 include/uapi/linux/kvm.h           |  1 +
 5 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 2f5f9b7..fde48b6 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4532,6 +4532,20 @@ With this capability, a guest may read the MSR_PLATFORM_INFO MSR. Otherwise,
 a #GP would be raised when the guest tries to access. Currently, this
 capability does not enable write permissions of this MSR for the guest.
 
+7.16 KVM_CAP_PPC_NESTED_HV
+
+Architectures: ppc
+Parameters: none
+Returns: 0 on success, -EINVAL when the implementation doesn't support
+	 nested-HV virtualization.
+
+HV-KVM on POWER9 and later systems allows for "nested-HV"
+virtualization, which provides a way for a guest VM to run guests that
+can run using the CPU's supervisor mode (privileged non-hypervisor
+state).  Enabling this capability on a VM depends on the CPU having
+the necessary functionality and on the facility being enabled with a
+kvm-hv module parameter.
+
 8. Other capabilities.
 ----------------------
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 245e564..b3796bd 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -327,6 +327,7 @@ struct kvmppc_ops {
 	int (*set_smt_mode)(struct kvm *kvm, unsigned long mode,
 			    unsigned long flags);
 	void (*giveup_ext)(struct kvm_vcpu *vcpu, ulong msr);
+	int (*enable_nested)(struct kvm *kvm);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 152bf75..fa61647 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -118,6 +118,16 @@ module_param_cb(h_ipi_redirect, &module_param_ops, &h_ipi_redirect, 0644);
 MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host core");
 #endif
 
+/* If set, guests are allowed to create and control nested guests */
+static bool nested = true;
+module_param(nested, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(nested, "Enable nested virtualization (only on POWER9)");
+
+static inline bool nesting_enabled(struct kvm *kvm)
+{
+	return kvm->arch.nested_enable && kvm_is_radix(kvm);
+}
+
 /* If set, the threads on each CPU core have to be in the same MMU mode */
 static bool no_mixing_hpt_and_radix;
 
@@ -959,12 +969,12 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 
 	case H_SET_PARTITION_TABLE:
 		ret = H_FUNCTION;
-		if (vcpu->kvm->arch.nested_enable)
+		if (nesting_enabled(vcpu->kvm))
 			ret = kvmhv_set_partition_table(vcpu);
 		break;
 	case H_ENTER_NESTED:
 		ret = H_FUNCTION;
-		if (!vcpu->kvm->arch.nested_enable)
+		if (!nesting_enabled(vcpu->kvm))
 			break;
 		ret = kvmhv_enter_nested_guest(vcpu);
 		if (ret == H_INTERRUPT) {
@@ -974,9 +984,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		break;
 	case H_TLB_INVALIDATE:
 		ret = H_FUNCTION;
-		if (!vcpu->kvm->arch.nested_enable)
-			break;
-		ret = kvmhv_do_nested_tlbie(vcpu);
+		if (nesting_enabled(vcpu->kvm))
+			ret = kvmhv_do_nested_tlbie(vcpu);
 		break;
 
 	default:
@@ -4496,10 +4505,8 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 /* Must be called with kvm->lock held and mmu_ready = 0 and no vcpus running */
 int kvmppc_switch_mmu_to_hpt(struct kvm *kvm)
 {
-	if (kvm->arch.nested_enable) {
-		kvm->arch.nested_enable = false;
+	if (nesting_enabled(kvm))
 		kvmhv_release_all_nested(kvm);
-	}
 	kvmppc_free_radix(kvm);
 	kvmppc_update_lpcr(kvm, LPCR_VPM1,
 			   LPCR_VPM1 | LPCR_UPRT | LPCR_GTSE | LPCR_HR);
@@ -4776,7 +4783,7 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 
 	/* Perform global invalidation and return lpid to the pool */
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		if (kvm->arch.nested_enable)
+		if (nesting_enabled(kvm))
 			kvmhv_release_all_nested(kvm);
 		kvm->arch.process_table = 0;
 		kvmhv_set_ptbl_entry(kvm->arch.lpid, 0, 0);
@@ -5169,6 +5176,19 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
 	return err;
 }
 
+static int kvmhv_enable_nested(struct kvm *kvm)
+{
+	if (!nested)
+		return -EPERM;
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		return -ENODEV;
+
+	/* kvm == NULL means the caller is testing if the capability exists */
+	if (kvm)
+		kvm->arch.nested_enable = true;
+	return 0;
+}
+
 static struct kvmppc_ops kvm_ops_hv = {
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
@@ -5208,6 +5228,7 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.configure_mmu = kvmhv_configure_mmu,
 	.get_rmmu_info = kvmhv_get_rmmu_info,
 	.set_smt_mode = kvmhv_set_smt_mode,
+	.enable_nested = kvmhv_enable_nested,
 };
 
 static int kvm_init_subcore_bitmap(void)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1f4b128..2869a29 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -597,6 +597,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = !!(hv_enabled && cpu_has_feature(CPU_FTR_ARCH_300) &&
 		       cpu_has_feature(CPU_FTR_HVMODE));
 		break;
+	case KVM_CAP_PPC_NESTED_HV:
+		r = !!(hv_enabled && kvmppc_hv_ops->enable_nested &&
+		       !kvmppc_hv_ops->enable_nested(NULL));
+		break;
 #endif
 	case KVM_CAP_SYNC_MMU:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -2115,6 +2119,14 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			r = kvm->arch.kvm_ops->set_smt_mode(kvm, mode, flags);
 		break;
 	}
+
+	case KVM_CAP_PPC_NESTED_HV:
+		r = -EINVAL;
+		if (!is_kvmppc_hv_enabled(kvm) ||
+		    !kvm->arch.kvm_ops->enable_nested)
+			break;
+		r = kvm->arch.kvm_ops->enable_nested(kvm);
+		break;
 #endif
 	default:
 		r = -EINVAL;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 251be35..d9cec6b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -953,6 +953,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
 #define KVM_CAP_MSR_PLATFORM_INFO 159
+#define KVM_CAP_PPC_NESTED_HV 160
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4

