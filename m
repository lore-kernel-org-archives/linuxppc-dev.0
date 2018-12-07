Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A517C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:04:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60112064D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9ssLjiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60112064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439zPg3tCLzDr2j
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 15:04:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P9ssLjiI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="P9ssLjiI"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439yy05sl5zDrX4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 14:44:08 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id g189so1095359pgc.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 19:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=neA6L1GivAbcYv4OovfE82MXl4tAG0cPox3pKUy95s8=;
 b=P9ssLjiIxjMOKkDwD0EveLOT0YhjWkGVY3JVZytSNZ4gzMp96X+sNsMHROLttHkSDA
 S4KpvqFouxHIopjbRE2eApT8jv4FPUH90Zzg4SeB0EN00djLPLO1IJ2+ijagVHxcWYt6
 dh4W8QMVpUeATiOUP+Fsg8EsQ902NYZMaanrVWb3OREEuadxMAWjHD5ShnUPJOZ9ausX
 Ao0Gt4xNQ+GMxxM13xsx7ZqKUIlWyW4Al8dEVgfkUQ86JywLf8EF4lHqwbVfBNqR4YPQ
 N7kJDESQPWQa6lr6jgEjJyK9OoB23tOZXgTB8NFaSeMpyczF7L3m4MJWH5b+zAHSje2K
 PylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=neA6L1GivAbcYv4OovfE82MXl4tAG0cPox3pKUy95s8=;
 b=hmtlAv5pDvmOZg5pdRuR9y/YrRKu0zeLX4pLSXZG3E9mU5X3ijYyxWqlibwNO0Dtwt
 MH6dlm0Mbbn0zlIVTKi5jbRVdNhGjsgy9OgOiiwi6Dq/600E1w+/XuVS8q6IiT4i2rom
 k9fHestv53S1YnbFx8sp2u5dQlYVShyz6dIghr6OTwuQI4xFtgsohiRUvbtLkkpKOo1h
 jaTBZlD9aMnwjYNH/Mwyo+Wnquqafjz/1qVYnGMWG+nWpNLBpaFBk5EN5e0h+yoOA6I4
 C24PUWrUJjl1xxynJ+DoNr2AZFjq98Cip21UhN7TQCmRroiDFiEz9fTM+QJhc6mz/6Hi
 a2ag==
X-Gm-Message-State: AA+aEWZeRwJU1Vy2lacWcxJ5f+NKmlTDml0dXtfuHlPoeKPPSGwqEOVb
 Wg1EEAKEMMNk0u2/Gvedh6w=
X-Google-Smtp-Source: AFSGD/V5IbAkkNB5BmguIvv65Dngk1XaLOGQSqzEUpMS5ssBLF95Q7mFhBA0yZOEHf/BrYmCsVzdgw==
X-Received: by 2002:a63:504d:: with SMTP id q13mr559612pgl.319.1544154247054; 
 Thu, 06 Dec 2018 19:44:07 -0800 (PST)
Received: from localhost.localdomain ([1.129.152.198])
 by smtp.gmail.com with ESMTPSA id e23sm2262646pfh.68.2018.12.06.19.44.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 19:44:06 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 6/8] KVM: PPC: Book3S HV: Allow passthrough of an emulated
 device to an L2 guest
Date: Fri,  7 Dec 2018 14:43:24 +1100
Message-Id: <20181207034326.3564-8-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181207034326.3564-1-sjitindarsingh@gmail.com>
References: <20181207034326.3564-1-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 sjitindarsingh@gmail.com
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
 arch/powerpc/kvm/powerpc.c            |  4 ++++
 5 files changed, 53 insertions(+), 11 deletions(-)

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
index 6c8b4f632168..e7233499e063 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -984,6 +984,10 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		if (ret == H_INTERRUPT) {
 			kvmppc_set_gpr(vcpu, 3, 0);
 			return -EINTR;
+		} else if (ret == H_TOO_HARD) {
+			kvmppc_set_gpr(vcpu, 3, 0);
+			vcpu->arch.hcall_needed = 0;
+			return RESUME_HOST;
 		}
 		break;
 	case H_TLB_INVALIDATE:
@@ -1335,7 +1339,7 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return r;
 }
 
-static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
+static int kvmppc_handle_nested_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	int r;
 	int srcu_idx;
@@ -1393,7 +1397,7 @@ static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
 	 */
 	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
 		srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = kvmhv_nested_page_fault(vcpu);
+		r = kvmhv_nested_page_fault(run, vcpu);
 		srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
 		break;
 	case BOOK3S_INTERRUPT_H_INST_STORAGE:
@@ -1403,7 +1407,7 @@ static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
 		if (vcpu->arch.shregs.msr & HSRR1_HISI_WRITE)
 			vcpu->arch.fault_dsisr |= DSISR_ISSTORE;
 		srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = kvmhv_nested_page_fault(vcpu);
+		r = kvmhv_nested_page_fault(run, vcpu);
 		srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
 		break;
 
@@ -4058,7 +4062,7 @@ int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
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
index cb029fcab404..9636cce0353d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1210,6 +1210,10 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 			kvmppc_set_vmx_byte(vcpu, gpr);
 		break;
 #endif
+	case KVM_MMIO_REG_NESTED_GPR:
+		kvm_vcpu_write_guest(vcpu, vcpu->arch.nested_io_gpr, &gpr,
+				     sizeof(gpr));
+		break;
 	default:
 		BUG();
 	}
-- 
2.13.6

