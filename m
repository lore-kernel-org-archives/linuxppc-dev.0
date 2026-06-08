Return-Path: <linuxppc-dev+bounces-22222-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE72CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:53:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4R4nFxz3c5J;
	Tue, 09 Jun 2026 00:52:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930342;
	cv=none; b=lvt1n+mGhcCl3Hm4YGoTqKdknhpdTEqTM1NaT/PoH5jgpKGyRi5Cd40/hPQddPMdZN+E4ADjww/c3Pdf9LO6Of7Ny7PoaWnUAXIQSkjPh+unyUPAec+7Qgav3DjFCTJuVcXkC+YoKM8C/u28OQ4Rvri0xzS1Dlk4S+7aWZD+Yhq4X9ghvWGZ1DioBtI03c/xMFcmp4U7Vj14S9EPqSVqi6F4POuKAKju65/A0KGqKolbLlJGEMp59qGg2YSyVIOV17E6VnxNa4CD4ri997sOKWlxXZF9FwvUOsMh/5lzkT/zrPjyWsQMM95evM3y8oD2iwXLav7yboR0cDPC89nktA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930342; c=relaxed/relaxed;
	bh=rt1rp+CREwIHUhdETzqNqnn91aXd15btjFtTngyGv/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqOmT2RtsG0egZ2TmZoqXXwdBp2NBT5+Kg3xNvBlb3RrNOG2Fh77Sy+zzel1FLioEOXFs1M7VJ7TS/V3kiUVpai/EaBHg7ZmIIkrwdWC9CYOz1eltj4SzyRydqJ9fMCCU3Vy7ybD0jfmNI1HN/STwaEDnIHje1igqqtry2vV51h8kkswNFxiMJaclZsoQJXLfJa/u3rzoesgbps0pUUxEZHfKj09wA/WJT/Bm4EXc03afjMvZZGMut8nWsCgH4SlhK7hBpeynMUkYl/lo5PpJC+PqyGbuWFjBDr0Xx9RzMe/4b1ZL+dtnPJ1+cnK3ux+cyx3cZtDQoLZTs8PSb+KRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4J4p3hz3btj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:15 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 841DF2028DD;
	Mon,  8 Jun 2026 16:43:17 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	nsaenz@amazon.com,
	anelkz@amazon.de,
	James.Bottomley@HansenPartnership.com,
	Melody Wang <huibo.wang@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	x86@kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [PATCH 58/60] kvm: svm: Invoke a specified VMPL level VMSA for the vCPU
Date: Mon,  8 Jun 2026 16:42:50 +0200
Message-ID: <20260608144252.351443-59-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144252.351443-1-joro@8bytes.org>
References: <20260608144252.351443-1-joro@8bytes.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tom Lendacky <thomas.lendacky@amd.com>

Implement the SNP Run VMPL NAE event and MSR protocol to allow a guest to
request a different VMPL level VMSA be run for the vCPU. This allows the
guest to "call" an SVSM to process an SVSM request.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/asm/sev-common.h |  6 +++
 arch/x86/kvm/svm/sev.c            | 71 +++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index cedb7ea91da5..a09cf5690aba 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -114,6 +114,8 @@ enum psc_op {
 
 /* GHCB Run at VMPL Request/Response */
 #define GHCB_MSR_VMPL_REQ		0x016
+#define GHCB_MSR_VMPL_LEVEL_POS		32
+#define GHCB_MSR_VMPL_LEVEL_MASK	GENMASK_ULL(7, 0)
 #define GHCB_MSR_VMPL_REQ_LEVEL(v)			\
 	/* GHCBData[39:32] */				\
 	((((u64)(v) & GENMASK_ULL(7, 0)) << 32) |	\
@@ -121,6 +123,10 @@ enum psc_op {
 	GHCB_MSR_VMPL_REQ)
 
 #define GHCB_MSR_VMPL_RESP		0x017
+#define GHCB_MSR_VMPL_ERROR_POS		32
+#define GHCB_MSR_VMPL_ERROR_MASK	GENMASK_ULL(31, 0)
+#define GHCB_MSR_VMPL_RSVD_POS		12
+#define GHCB_MSR_VMPL_RSVD_MASK		GENMASK_ULL(19, 0)
 #define GHCB_MSR_VMPL_RESP_VAL(v)			\
 	/* GHCBData[63:32] */				\
 	(((u64)(v) & GENMASK_ULL(63, 32)) >> 32)
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 53cd3aba7368..b67566fcb69e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3556,6 +3556,10 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		if (!sev_snp_guest(vcpu->kvm))
 			goto vmgexit_err;
 		break;
+	case SVM_VMGEXIT_SNP_RUN_VMPL:
+		if (!sev_snp_guest(vcpu->kvm))
+			goto vmgexit_err;
+		break;
 	default:
 		reason = GHCB_ERR_INVALID_EVENT;
 		goto vmgexit_err;
@@ -4593,6 +4597,45 @@ static void sev_get_apic_ids(struct vcpu_svm *svm)
 	kvfree(desc);
 }
 
+static int __sev_snp_run_vmpl(struct vcpu_svm *svm, unsigned int vmpl)
+{
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm_vcpu *target = vcpu->common->vcpus[vmpl];
+	struct vcpu_svm *target_svm = to_svm(target);
+
+	if (!target)
+		return -EINVAL;
+
+	/* Mark current plane as stopped so it is not selected */
+	kvm_set_mp_state(target, KVM_MP_STATE_RUNNABLE);
+	/* In case KVM_REQ_UPDATE_PROTECTED_GUEST_STATE is set - mark the new VMSA as runnable */
+	target_svm->sev_es.snp_ap_runnable = true;
+	kvm_vcpu_set_plane_runnable(target);
+	kvm_vcpu_set_plane_stopped(vcpu);
+
+	kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
+
+	return 1;
+}
+
+static int sev_snp_run_vmpl(struct vcpu_svm *svm)
+{
+	struct ghcb *ghcb = svm->sev_es.ghcb;
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	unsigned int vmpl;
+
+	vmpl = lower_32_bits(svm->vmcb->control.exit_info_1);
+	if (vmpl >= SVM_SEV_VMPL_MAX) {
+		vcpu_unimpl(vcpu, "vmgexit: invalid VMPL level [%u] from guest\n", vmpl);
+		return -EINVAL;
+	}
+
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	return __sev_snp_run_vmpl(svm, vmpl);
+}
+
 static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -4704,6 +4747,27 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 
 		ret = snp_begin_psc_msr(svm, control->ghcb_gpa);
 		break;
+	case GHCB_MSR_VMPL_REQ: {
+		unsigned int vmpl;
+
+		if (!sev_snp_guest(vcpu->kvm))
+			goto out_terminate;
+
+		vmpl = get_ghcb_msr_bits(svm, GHCB_MSR_VMPL_LEVEL_MASK, GHCB_MSR_VMPL_LEVEL_POS);
+
+		set_ghcb_msr_bits(svm, 0, GHCB_MSR_VMPL_ERROR_MASK, GHCB_MSR_VMPL_ERROR_POS);
+		set_ghcb_msr_bits(svm, 0, GHCB_MSR_VMPL_RSVD_MASK, GHCB_MSR_VMPL_RSVD_POS);
+		set_ghcb_msr_bits(svm, GHCB_MSR_VMPL_RESP, GHCB_MSR_INFO_MASK, GHCB_MSR_INFO_POS);
+
+		if (vmpl >= SVM_SEV_VMPL_MAX) {
+			vcpu_unimpl(vcpu, "vmgexit: invalid VMPL level [%u] from guest\n", vmpl);
+			set_ghcb_msr_bits(svm, 1, GHCB_MSR_VMPL_ERROR_MASK, GHCB_MSR_VMPL_ERROR_POS);
+			break;
+		}
+
+		ret = __sev_snp_run_vmpl(svm, vmpl);
+		break;
+	}
 	case GHCB_MSR_TERM_REQ: {
 		u64 reason_set, reason_code;
 
@@ -4887,6 +4951,13 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		sev_get_apic_ids(svm);
 		ret = 1;
 		break;
+	case SVM_VMGEXIT_SNP_RUN_VMPL:
+		ret = sev_snp_run_vmpl(svm);
+		if (ret < 0) {
+			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+			ret = 1;
+		}
+		break;
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		vcpu_unimpl(vcpu,
 			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
-- 
2.53.0


