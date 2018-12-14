Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211DAC67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 05:47:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A05920645
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 05:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON08mbCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A05920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GKMB66QvzDqQT
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 16:47:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ON08mbCa";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ON08mbCa"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GJyt1crRzDr9N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 16:29:58 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id z9so2266548pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 21:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=73xmD+6vNWYRYaZFcAAcF9TgqXDoiwoVhrfKCNNsels=;
 b=ON08mbCa7MDqsw7NRz8/oS7kQ/n/C/PQ7epdvjlOSDSQ7v4/QYSF2NEjSA+NsZon/D
 IxxLbhNh/rmS5Vwif4Nqx8IbYlCxA5E2DYn8s6kQxfimQAu9uR1qdxZ+RQagdCXexZ+1
 C4KNfnlXdYpKFMGRBj4G1Fqolp0OsgqGnhxrFAEiMuNFrFqxG1kvYFSdRbPtGYP22TYx
 2dJU5js11x83387I14ICdK1zNM3Kd09bNXI5Zgc4nGDdgl+woUFGWiOFTY4t9xMImcnc
 V91hK7dMeOR1NWhlyZRG/ucikuhN0d8xDoqrulVwuBXtVmnFBnsOxohLRAvd3eVQhMRI
 cslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=73xmD+6vNWYRYaZFcAAcF9TgqXDoiwoVhrfKCNNsels=;
 b=IDrdHRu2cUPUv3wxFAlZGse8m9TBCVSAGnXEsK9sK+qrofo10rsE4owUMjK0HSWmGS
 huIP6s6/6K2a7r+7M5y5lo2Cnl5asoltI1kCQfH1rNeufgd5wOdfrZ8yHR2SZNZp/qeF
 EIpII7aYDvALDUi2g9agFub46oTfVYr20dvUtaSGRx76kQPF1gxWSayQBfpNGtEdg7aI
 JIfiBk3SECQUOTyT9A3uecl5zWww1NQ92/dFzYRet34/pP17xfKTcIl5O5DPV6bjl2bK
 Tf4+iLmKE+kQ+qOS22dk66bNFz6ubcb8+gbGt5P4ZOeCd5ImiMLZhETdbjuU/XQy0t+w
 SBpg==
X-Gm-Message-State: AA+aEWYgpOYH3SX0sJYXiArgrr1DYK40mOQIjMpUm/nCtOlQeaxxGYPy
 8XkU0v3fYdzufFMciQsxsYQ=
X-Google-Smtp-Source: AFSGD/WNvkiAfiYnSWhTLca1XgJ+Ge/i8tqyBdlt/CgXf9fHsT/TmjWvVFb4MpBXn2SMYD8FFSeJ2A==
X-Received: by 2002:a63:4c5:: with SMTP id 188mr1516490pge.391.1544765396548; 
 Thu, 13 Dec 2018 21:29:56 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d21sm5358697pgv.37.2018.12.13.21.29.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 21:29:55 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V4 6/8] KVM: PPC: Book3S HV: Allow passthrough of an emulated
 device to an L2 guest
Date: Fri, 14 Dec 2018 16:29:08 +1100
Message-Id: <20181214052910.23639-7-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181214052910.23639-1-sjitindarsingh@gmail.com>
References: <20181214052910.23639-1-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, sjitindarsingh@gmail.com,
 kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Allow for a device which is being emulated at L0 (the host) for an L1
guest to be passed through to a nested (L2) guest.

The existing kvmppc_hv_emulate_mmio function can be used here. The main
challenge is that for a load the result must be stored into the L2 gpr,
not an L1 gpr as would normally be the case after going out to qemu to
complete the operation. This presents a challenge as at this point the
L2 gpr state has been written back into L1 memory.

To work around this we store the address in L1 memory of the L2 gpr
where the result of the load is to be stored and use the new io_gpr
value KVM_MMIO_REG_NESTED_GPR to indicate that this is a nested load for
which completion must be done when returning back into the kernel. Then
in kvmppc_complete_mmio_load() the resultant value is written into L1
memory at the location of the indicated L2 gpr.

Note that we don't currently let an L1 guest emulate a device for an L2
guest which is then passed through to an L3 guest.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  2 +-
 arch/powerpc/include/asm/kvm_host.h   |  3 +++
 arch/powerpc/kvm/book3s_hv.c          | 12 ++++++----
 arch/powerpc/kvm/book3s_hv_nested.c   | 43 ++++++++++++++++++++++++++++++-----
 arch/powerpc/kvm/powerpc.c            |  8 +++++++
 5 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 5883fcce7009..ea94110bfde4 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -311,7 +311,7 @@ int kvmhv_run_single_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu,
 void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr);
 void kvmhv_restore_hv_return_state(struct kvm_vcpu *vcpu,
 				   struct hv_guest_state *hr);
-long int kvmhv_nested_page_fault(struct kvm_vcpu *vcpu);
+long int kvmhv_nested_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu);
 
 void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index fac6f631ed29..7a2483a139cf 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -793,6 +793,7 @@ struct kvm_vcpu_arch {
 	/* For support of nested guests */
 	struct kvm_nested_guest *nested;
 	u32 nested_vcpu_id;
+	gpa_t nested_io_gpr;
 #endif
 
 #ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
@@ -827,6 +828,8 @@ struct kvm_vcpu_arch {
 #define KVM_MMIO_REG_FQPR	0x00c0
 #define KVM_MMIO_REG_VSX	0x0100
 #define KVM_MMIO_REG_VMX	0x0180
+#define KVM_MMIO_REG_NESTED_GPR	0xffc0
+
 
 #define __KVM_HAVE_ARCH_WQP
 #define __KVM_HAVE_CREATE_DEVICE
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8a0921176a60..2280bc4778f5 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -985,6 +985,10 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 			kvmppc_set_gpr(vcpu, 3, 0);
 			vcpu->arch.hcall_needed = 0;
 			return -EINTR;
+		} else if (ret == H_TOO_HARD) {
+			kvmppc_set_gpr(vcpu, 3, 0);
+			vcpu->arch.hcall_needed = 0;
+			return RESUME_HOST;
 		}
 		break;
 	case H_TLB_INVALIDATE:
@@ -1336,7 +1340,7 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return r;
 }
 
-static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
+static int kvmppc_handle_nested_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	int r;
 	int srcu_idx;
@@ -1394,7 +1398,7 @@ static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
 	 */
 	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
 		srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = kvmhv_nested_page_fault(vcpu);
+		r = kvmhv_nested_page_fault(run, vcpu);
 		srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
 		break;
 	case BOOK3S_INTERRUPT_H_INST_STORAGE:
@@ -1404,7 +1408,7 @@ static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
 		if (vcpu->arch.shregs.msr & HSRR1_HISI_WRITE)
 			vcpu->arch.fault_dsisr |= DSISR_ISSTORE;
 		srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = kvmhv_nested_page_fault(vcpu);
+		r = kvmhv_nested_page_fault(run, vcpu);
 		srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
 		break;
 
@@ -4059,7 +4063,7 @@ int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 		if (!nested)
 			r = kvmppc_handle_exit_hv(kvm_run, vcpu, current);
 		else
-			r = kvmppc_handle_nested_exit(vcpu);
+			r = kvmppc_handle_nested_exit(kvm_run, vcpu);
 	}
 	vcpu->arch.ret = r;
 
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 4fca462e54c4..991f40ce4eea 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -195,6 +195,26 @@ void kvmhv_restore_hv_return_state(struct kvm_vcpu *vcpu,
 	vcpu->arch.ppr = hr->ppr;
 }
 
+static void kvmhv_nested_mmio_needed(struct kvm_vcpu *vcpu, u64 regs_ptr)
+{
+	/* No need to reflect the page fault to L1, we've handled it */
+	vcpu->arch.trap = 0;
+
+	/*
+	 * Since the L2 gprs have already been written back into L1 memory when
+	 * we complete the mmio, store the L1 memory location of the L2 gpr
+	 * being loaded into by the mmio so that the loaded value can be
+	 * written there in kvmppc_complete_mmio_load()
+	 */
+	if (((vcpu->arch.io_gpr & KVM_MMIO_REG_EXT_MASK) == KVM_MMIO_REG_GPR)
+	    && (vcpu->mmio_is_write == 0)) {
+		vcpu->arch.nested_io_gpr = (gpa_t) regs_ptr +
+					   offsetof(struct pt_regs,
+						    gpr[vcpu->arch.io_gpr]);
+		vcpu->arch.io_gpr = KVM_MMIO_REG_NESTED_GPR;
+	}
+}
+
 long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 {
 	long int err, r;
@@ -316,6 +336,11 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 	if (r == -EINTR)
 		return H_INTERRUPT;
 
+	if (vcpu->mmio_needed) {
+		kvmhv_nested_mmio_needed(vcpu, regs_ptr);
+		return H_TOO_HARD;
+	}
+
 	return vcpu->arch.trap;
 }
 
@@ -1100,7 +1125,8 @@ static inline int kvmppc_radix_shift_to_level(int shift)
 }
 
 /* called with gp->tlb_lock held */
-static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
+static long int __kvmhv_nested_page_fault(struct kvm_run *run,
+					  struct kvm_vcpu *vcpu,
 					  struct kvm_nested_guest *gp)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -1181,9 +1207,14 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 			kvmppc_core_queue_data_storage(vcpu, ea, dsisr);
 			return RESUME_GUEST;
 		}
-		/* passthrough of emulated MMIO case... */
-		pr_err("emulated MMIO passthrough?\n");
-		return -EINVAL;
+
+		/* passthrough of emulated MMIO case */
+		if (kvmhv_on_pseries()) {
+			pr_err("emulated MMIO passthrough?\n");
+			return -EINVAL;
+		}
+
+		return kvmppc_hv_emulate_mmio(run, vcpu, gpa, ea, writing);
 	}
 	if (memslot->flags & KVM_MEM_READONLY) {
 		if (writing) {
@@ -1265,13 +1296,13 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 	return RESUME_GUEST;
 }
 
-long int kvmhv_nested_page_fault(struct kvm_vcpu *vcpu)
+long int kvmhv_nested_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	struct kvm_nested_guest *gp = vcpu->arch.nested;
 	long int ret;
 
 	mutex_lock(&gp->tlb_lock);
-	ret = __kvmhv_nested_page_fault(vcpu, gp);
+	ret = __kvmhv_nested_page_fault(run, vcpu, gp);
 	mutex_unlock(&gp->tlb_lock);
 	return ret;
 }
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index cb029fcab404..3138fa034546 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1210,6 +1210,14 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 			kvmppc_set_vmx_byte(vcpu, gpr);
 		break;
 #endif
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	case KVM_MMIO_REG_NESTED_GPR:
+		if (kvmppc_need_byteswap(vcpu))
+			gpr = swab64(gpr);
+		kvm_vcpu_write_guest(vcpu, vcpu->arch.nested_io_gpr, &gpr,
+				     sizeof(gpr));
+		break;
+#endif
 	default:
 		BUG();
 	}
-- 
2.13.6

