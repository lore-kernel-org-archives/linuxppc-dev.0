Return-Path: <linuxppc-dev+bounces-22209-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24602CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:52:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4B06w6z2yv2;
	Tue, 09 Jun 2026 00:52:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930329;
	cv=none; b=bxCt0lxn0fz7Nz1faW4deimZZBZ1yMppqPbC0NqOq3enXlXFcFsBQc8ppP+G2P0O96CgkS2pFdAg71NM94gLiziHyKbKe1qewhuzJMIsCcu5k89u3KrXW0JntkN5zmMKEZG9oPP7FIeAC9SH/d3CRqcU/YCJRK3+lejjqhYqJBtyiVd4Lixs2LFBUa/N8rpWDg3tiLPmtgo+WB96m8DIwkd2X3WH5z/bO4MGVzTT4Fo9co3xpEID5du9P6I/LlzH/1H7n6q90jfl3UUfTXNaBm47e1LkcjYiKL+e4obo081tp/53zpsWLmQPKz3fTYeFAfBIbEsq6d5w04GICYb71g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930329; c=relaxed/relaxed;
	bh=TsY8PFH6mjuuhNLAgryFJthFUEMRXvNuzSHKevD19kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYniPx1qV6CfMbYydZ/COgzrrYQpRAPTP4W4VDm5AaWJgl2SaKpPAxGlvdBdPyXeuMitMG6ZEiN4tlHedpG/h9/aZqdf9l0Eo3O5lhYcN/QCx/D9GFHzFHv+oTJvYEpc65h3A0Yt8j0QcpvhhKZiiyYPRvb31z1hLyv01WhVU/JO8TDu0GU2V0Db/NIquhp9WrzTwCqiJBJHkrvtuWRp2VnIBtr7Bxgm4sY1Tpcz/VNvMGVNGqdxE3JfAcTiHoA0Wz7sSybX3IFtDRbYqIBhC12jAdqsfjkt/+rP9aoMqQ2rpks9gvGgDhY4fFKXFiXTc5phOAI1LPJ4nbPPmVzz8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw483V1hz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:07 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 725222028A5;
	Mon,  8 Jun 2026 16:43:05 +0200 (CEST)
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
Subject: [PATCH 02/60] KVM: SVM: Add support for the SEV-SNP #HV doorbell page NAE event
Date: Mon,  8 Jun 2026 16:41:54 +0200
Message-ID: <20260608144252.351443-3-joro@8bytes.org>
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

From: Melody Wang <huibo.wang@amd.com>

To support Restricted Injection, the SEV-SNP guest must register a doorbell
page for use with #HV. This is done using the #HV doorbell page NAE event.

This event consists of four actions: GET_PREFERRED, SET, QUERY, CLEAR.
Implement it per the GHCB specification.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/uapi/asm/svm.h |  5 +++
 arch/x86/kvm/svm/sev.c          | 71 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c          |  3 ++
 arch/x86/kvm/svm/svm.h          |  2 +
 4 files changed, 81 insertions(+)

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 010a45c9f614..d84a13ac4627 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -117,6 +117,11 @@
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
+#define SVM_VMGEXIT_HVDB_PAGE			0x80000014ull
+#define SVM_VMGEXIT_HVDB_GET_PREFERRED		0
+#define SVM_VMGEXIT_HVDB_SET			1
+#define SVM_VMGEXIT_HVDB_QUERY			2
+#define SVM_VMGEXIT_HVDB_CLEAR			3
 #define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018ull
 #define SVM_VMGEXIT_SAVIC			0x8000001aull
 #define SVM_VMGEXIT_SAVIC_REGISTER_GPA		0
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6c6a6d663e29..b9ad1169cb2c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3522,6 +3522,10 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		    control->exit_info_1 == control->exit_info_2)
 			goto vmgexit_err;
 		break;
+	case SVM_VMGEXIT_HVDB_PAGE:
+		if (!is_sev_snp_guest(vcpu))
+			goto vmgexit_err;
+		break;
 	default:
 		reason = GHCB_ERR_INVALID_EVENT;
 		goto vmgexit_err;
@@ -4341,6 +4345,65 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 	return 1; /* resume guest */
 }
 
+static int sev_snp_hv_doorbell_page(struct vcpu_svm *svm)
+{
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm_host_map hvdb_map;
+	gpa_t hvdb_gpa;
+	u64 request;
+
+	if (!is_sev_snp_guest(vcpu))
+		return -EINVAL;
+
+	request = svm->vmcb->control.exit_info_1;
+	hvdb_gpa = svm->vmcb->control.exit_info_2;
+
+	switch (request) {
+	case SVM_VMGEXIT_HVDB_GET_PREFERRED:
+		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, ~0ULL);
+		break;
+	case SVM_VMGEXIT_HVDB_SET:
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
+
+		if (!PAGE_ALIGNED(hvdb_gpa)) {
+			vcpu_unimpl(vcpu, "vmgexit: unaligned #HV doorbell page address [%#llx] from guest\n",
+				    hvdb_gpa);
+			return -EINVAL;
+		}
+
+		if (!page_address_valid(vcpu, hvdb_gpa)) {
+			vcpu_unimpl(vcpu, "vmgexit: invalid #HV doorbell page address [%#llx] from guest\n",
+				    hvdb_gpa);
+			return -EINVAL;
+		}
+
+		/* Map and unmap the GPA just to be sure the GPA is valid */
+		if (kvm_vcpu_map(vcpu, gpa_to_gfn(hvdb_gpa), &hvdb_map)) {
+			vcpu_unimpl(vcpu, "vmgexit: error mapping #HV doorbell page [%#llx] from guest\n",
+				    hvdb_gpa);
+			return -EINVAL;
+		}
+		kvm_vcpu_unmap(vcpu, &hvdb_map);
+
+		svm->sev_es.hvdb_gpa = hvdb_gpa;
+		fallthrough;
+	case SVM_VMGEXIT_HVDB_QUERY:
+		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, svm->sev_es.hvdb_gpa);
+		break;
+	case SVM_VMGEXIT_HVDB_CLEAR:
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
+		break;
+	default:
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
+
+		vcpu_unimpl(vcpu, "vmgexit: invalid #HV doorbell page request [%#llx] from guest\n",
+			    request);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -4617,6 +4680,14 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
 		ret = snp_handle_ext_guest_req(svm, control->exit_info_1, control->exit_info_2);
 		break;
+	case SVM_VMGEXIT_HVDB_PAGE:
+		if (sev_snp_hv_doorbell_page(svm)) {
+			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
+			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
+		}
+
+		ret = 1;
+		break;
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		vcpu_unimpl(vcpu,
 			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e02a38da5296..7981e7583384 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1277,6 +1277,9 @@ static void __svm_vcpu_reset(struct kvm_vcpu *vcpu)
 
 	svm->nmi_masked = false;
 	svm->awaiting_iret_completion = false;
+
+	if (is_sev_es_guest(vcpu))
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
 }
 
 static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5137416be593..fb956c37c941 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -270,6 +270,8 @@ struct vcpu_sev_es_state {
 	gpa_t snp_vmsa_gpa;
 	bool snp_ap_waiting_for_reset;
 	bool snp_has_guest_vmsa;
+
+	gpa_t hvdb_gpa;
 };
 
 struct vcpu_svm {
-- 
2.53.0


