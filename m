Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01C7C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 12:58:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1296A20877
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 12:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="OCYjkPjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1296A20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QtGb2y0TzF3L2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 22:57:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="OCYjkPjH";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qrvf3B1CzF3K0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="OCYjkPjH"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Qrvf0vY7zB4N0; Thu,  4 Oct 2018 21:56:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Qrvd6Gtvz9sCr;
 Thu,  4 Oct 2018 21:56:29 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654189; bh=AtPoCMJW5jUipmRf8cQjFxYm+PIwIvhpDvCpajBBNC8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OCYjkPjHIowXrydSdvQAxBGn7dnBYiT+r6hy4soQz10JZTfLNVodGaxzZrq+V96S/
 xKBJH3xE6QIvzyvGmyh0c0+b7O6G0r8PSTpEBzDWEVJYNcR4WhpynqaWabmE2RMft5
 0KuEmt+Kr9gt0qGrvnvU/zCpCiBj6aU+NEJP53eBLlPB3xzPniYwkei5JyZhTYKwcr
 FHcxaYqXxQXr6PTOkJyFSjIYoFGrfViiqshO+iKoPkBBgcLEEeYkFRirhQcL8Jn2eH
 RZMRGCodVtvtFMumCQTiVZcoshN7HRDOf/+Oc/0egS5rmElVK66DmZgHalV25s78uF
 8Mt2EY+6eo6iQ==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 20/32] KVM: PPC: Book3S HV: Handle hypercalls correctly
 when nested
Date: Thu,  4 Oct 2018 21:55:57 +1000
Message-Id: <1538654169-15602-21-git-send-email-paulus@ozlabs.org>
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

When we are running as a nested hypervisor, we use a hypercall to
enter the guest rather than code in book3s_hv_rmhandlers.S.  This means
that the hypercall handlers listed in hcall_real_table never get called.
There are some hypercalls that are handled there and not in
kvmppc_pseries_do_hcall(), which therefore won't get processed for
a nested guest.

To fix this, we add cases to kvmppc_pseries_do_hcall() to handle those
hypercalls, with the following exceptions:

- The HPT hypercalls (H_ENTER, H_REMOVE, etc.) are not handled because
  we only support radix mode for nested guests.

- H_CEDE has to be handled specially because the cede logic in
  kvmhv_run_single_vcpu assumes that it has been processed by the time
  that kvmhv_p9_guest_entry() returns.  Therefore we put a special
  case for H_CEDE in kvmhv_p9_guest_entry().

For the XICS hypercalls, if real-mode processing is enabled, then the
virtual-mode handlers assume that they are being called only to finish
up the operation.  Therefore we turn off the real-mode flag in the XICS
code when running as a nested hypervisor.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/asm-prototypes.h |  4 +++
 arch/powerpc/kvm/book3s_hv.c              | 43 +++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  2 ++
 arch/powerpc/kvm/book3s_xics.c            |  3 ++-
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 5c9b00c..c55ba3b 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -167,4 +167,8 @@ void kvmhv_load_guest_pmu(struct kvm_vcpu *vcpu);
 
 int __kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu);
 
+long kvmppc_h_set_dabr(struct kvm_vcpu *vcpu, unsigned long dabr);
+long kvmppc_h_set_xdabr(struct kvm_vcpu *vcpu, unsigned long dabr,
+			unsigned long dabrx);
+
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index a7cb310..134d7c7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -50,6 +50,7 @@
 #include <asm/reg.h>
 #include <asm/ppc-opcode.h>
 #include <asm/asm-prototypes.h>
+#include <asm/archrandom.h>
 #include <asm/debug.h>
 #include <asm/disassemble.h>
 #include <asm/cputable.h>
@@ -915,6 +916,19 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 			break;
 		}
 		return RESUME_HOST;
+	case H_SET_DABR:
+		ret = kvmppc_h_set_dabr(vcpu, kvmppc_get_gpr(vcpu, 4));
+		break;
+	case H_SET_XDABR:
+		ret = kvmppc_h_set_xdabr(vcpu, kvmppc_get_gpr(vcpu, 4),
+						kvmppc_get_gpr(vcpu, 5));
+		break;
+	case H_GET_TCE:
+		ret = kvmppc_h_get_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
+						kvmppc_get_gpr(vcpu, 5));
+		if (ret == H_TOO_HARD)
+			return RESUME_HOST;
+		break;
 	case H_PUT_TCE:
 		ret = kvmppc_h_put_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
 						kvmppc_get_gpr(vcpu, 5),
@@ -938,6 +952,10 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		if (ret == H_TOO_HARD)
 			return RESUME_HOST;
 		break;
+	case H_RANDOM:
+		if (!powernv_get_random_long(&vcpu->arch.regs.gpr[4]))
+			ret = H_HARDWARE;
+		break;
 
 	case H_SET_PARTITION_TABLE:
 		ret = H_FUNCTION;
@@ -966,6 +984,24 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 	return RESUME_GUEST;
 }
 
+/*
+ * Handle H_CEDE in the nested virtualization case where we haven't
+ * called the real-mode hcall handlers in book3s_hv_rmhandlers.S.
+ * This has to be done early, not in kvmppc_pseries_do_hcall(), so
+ * that the cede logic in kvmppc_run_single_vcpu() works properly.
+ */
+static void kvmppc_nested_cede(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.shregs.msr |= MSR_EE;
+	vcpu->arch.ceded = 1;
+	smp_mb();
+	if (vcpu->arch.prodded) {
+		vcpu->arch.prodded = 0;
+		smp_mb();
+		vcpu->arch.ceded = 0;
+	}
+}
+
 static int kvmppc_hcall_impl_hv(unsigned long cmd)
 {
 	switch (cmd) {
@@ -3422,6 +3458,13 @@ int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 		vcpu->arch.shregs.msr = vcpu->arch.regs.msr;
 		vcpu->arch.shregs.dar = mfspr(SPRN_DAR);
 		vcpu->arch.shregs.dsisr = mfspr(SPRN_DSISR);
+
+		/* H_CEDE has to be handled now, not later */
+		if (trap == BOOK3S_INTERRUPT_SYSCALL && !vcpu->arch.nested &&
+		    kvmppc_get_gpr(vcpu, 3) == H_CEDE) {
+			kvmppc_nested_cede(vcpu);
+			trap = 0;
+		}
 	} else {
 		trap = kvmhv_load_hv_regs_and_go(vcpu, time_limit, lpcr);
 	}
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 8da73ea..d8b26be 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2466,6 +2466,7 @@ hcall_real_table:
 hcall_real_table_end:
 
 _GLOBAL(kvmppc_h_set_xdabr)
+EXPORT_SYMBOL_GPL(kvmppc_h_set_xdabr)
 	andi.	r0, r5, DABRX_USER | DABRX_KERNEL
 	beq	6f
 	li	r0, DABRX_USER | DABRX_KERNEL | DABRX_BTI
@@ -2475,6 +2476,7 @@ _GLOBAL(kvmppc_h_set_xdabr)
 	blr
 
 _GLOBAL(kvmppc_h_set_dabr)
+EXPORT_SYMBOL_GPL(kvmppc_h_set_dabr)
 	li	r5, DABRX_USER | DABRX_KERNEL
 3:
 BEGIN_FTR_SECTION
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index d9ba1b0..b0b2bfc 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1390,7 +1390,8 @@ static int kvmppc_xics_create(struct kvm_device *dev, u32 type)
 	}
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	if (cpu_has_feature(CPU_FTR_ARCH_206)) {
+	if (cpu_has_feature(CPU_FTR_ARCH_206) &&
+	    cpu_has_feature(CPU_FTR_HVMODE)) {
 		/* Enable real mode support */
 		xics->real_mode = ENABLE_REALMODE;
 		xics->real_mode_dbg = DEBUG_REALMODE;
-- 
2.7.4

