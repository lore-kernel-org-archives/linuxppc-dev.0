Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B00FC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:37:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24A820877
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="AQG+pw4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24A820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qv856kmfzDqZ1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:37:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="AQG+pw4D";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qrvr1bM9zF3Jq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="AQG+pw4D"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Qrvq6jXtzB4Mq; Thu,  4 Oct 2018 21:56:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Qrvq0y44zB4NP;
 Thu,  4 Oct 2018 21:56:39 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654199; bh=35YwwPY6coOsarA0fTW69h1UXBxucZzDyAX9W/vVgKc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AQG+pw4D7KFdIlfB0ywdLAHQT/FX8LjtcJqWpdEkTIfhE88oq37EYbuV5p1PTfW7m
 U31S6QQPZdTql6iZr7ksDCfJxOGFh/dOQtHfNVrz+3zd2moZIbWKRV5OtpnKFAvdGy
 7JqscuZcEv50L3vcqfZifyVtkLQUjxQFz2JDSHxMTGDVPeBU00HRvZTCDhBgTGR2Kb
 j8ILwevWFhDeRpb0f7/Z3+FRjv8PnSVX6tR17RT33PqT9U4TJD6bQg3EpLL13gjfN4
 u6YKy+CpfTSLCk48xxUKuZwA+L0UNW7QV8yNKz+pZKA7ZTsHdSl6o3womak+/XRfEi
 jMCWAHoFcmK9g==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 32/32] KVM: PPC: Book3S HV: Add a VM capability to enable
 nested virtualization
Date: Thu,  4 Oct 2018 21:56:09 +1000
Message-Id: <1538654169-15602-33-git-send-email-paulus@ozlabs.org>
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
 arch/powerpc/kvm/book3s_hv.c       | 19 +++++++++++++++++++
 arch/powerpc/kvm/powerpc.c         | 12 ++++++++++++
 include/uapi/linux/kvm.h           |  1 +
 5 files changed, 47 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 017d851..a2d4832 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4522,6 +4522,20 @@ hpage module parameter is not set to 1, -EINVAL is returned.
 While it is generally possible to create a huge page backed VM without
 this capability, the VM will not be able to run.
 
+7.15 KVM_CAP_PPC_NESTED_HV
+
+Architectures: ppc
+Parameters: enable flag (0 to disable, non-zero to enable)
+Returns: 0 on success, -EINVAL when the implementation doesn't support
+nested-HV virtualization.
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
index 245e564..80f0091 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -327,6 +327,7 @@ struct kvmppc_ops {
 	int (*set_smt_mode)(struct kvm *kvm, unsigned long mode,
 			    unsigned long flags);
 	void (*giveup_ext)(struct kvm_vcpu *vcpu, ulong msr);
+	int (*enable_nested)(struct kvm *kvm, bool enable);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7f89b22..d3cc013 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -118,6 +118,11 @@ module_param_cb(h_ipi_redirect, &module_param_ops, &h_ipi_redirect, 0644);
 MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host core");
 #endif
 
+/* If set, guests are allowed to create and control nested guests */
+static bool nested = true;
+module_param(nested, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(nested, "Enable nested virtualization (only on POWER9)");
+
 /* If set, the threads on each CPU core have to be in the same MMU mode */
 static bool no_mixing_hpt_and_radix;
 
@@ -5165,6 +5170,19 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
 	return err;
 }
 
+static int kvmhv_enable_nested(struct kvm *kvm, bool enable)
+{
+	if (!nested)
+		return -EPERM;
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		return -ENODEV;
+
+	/* kvm == NULL means the caller is testing if the capability exists */
+	if (kvm)
+		kvm->arch.nested_enable = enable;
+	return 0;
+}
+
 static struct kvmppc_ops kvm_ops_hv = {
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
@@ -5204,6 +5222,7 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.configure_mmu = kvmhv_configure_mmu,
 	.get_rmmu_info = kvmhv_get_rmmu_info,
 	.set_smt_mode = kvmhv_set_smt_mode,
+	.enable_nested = kvmhv_enable_nested,
 };
 
 static int kvm_init_subcore_bitmap(void)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index eba5756..449ae1d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -596,6 +596,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_PPC_MMU_HASH_V3:
 		r = !!(hv_enabled && cpu_has_feature(CPU_FTR_ARCH_300));
 		break;
+	case KVM_CAP_PPC_NESTED_HV:
+		r = !!(hv_enabled && kvmppc_hv_ops->enable_nested &&
+		       !kvmppc_hv_ops->enable_nested(NULL, false));
+		break;
 #endif
 	case KVM_CAP_SYNC_MMU:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -2114,6 +2118,14 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			r = kvm->arch.kvm_ops->set_smt_mode(kvm, mode, flags);
 		break;
 	}
+
+	case KVM_CAP_PPC_NESTED_HV:
+		r = -EINVAL;
+		if (!is_kvmppc_hv_enabled(kvm) ||
+		    !kvm->arch.kvm_ops->enable_nested)
+			break;
+		r = kvm->arch.kvm_ops->enable_nested(kvm, !!cap->args[0]);
+		break;
 #endif
 	default:
 		r = -EINVAL;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 07548de..a6d5a46 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -952,6 +952,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_HPAGE_1M 156
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
+#define KVM_CAP_PPC_NESTED_HV 160
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4

