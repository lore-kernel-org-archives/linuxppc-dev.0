Return-Path: <linuxppc-dev+bounces-22252-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AB8CD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:56:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4y1K1pz3f28;
	Tue, 09 Jun 2026 00:52:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930368;
	cv=none; b=XPaywJkSxxZ6040eHmZ3xcEQKnqcYIBGCmSduGb5fbAcs59cPMr9ZBoSbqd7ES1vMoDxJ+zlgeWlfQ7IkUuM6v40QjX5VbANQbJ3zBc6FTV7kZnMsFbJs00K/UAIaYFx+v1iy9dq8FHseTt1FbVS/mZTUK1Qh9RP0NKzalPwkBv0rNRXrt6/ZTSePDmsLWdTvYOotWys7CuMLjTQnlS/2X+bk/+iwW+D/SaioT9x1w3qFr/moW+FelnKS6Zz3hc47KxP1H9kcox6PHKaqR0lgPNQcVGMp4kRXOzAm8zUkEiAVlnDB33jto4VIahiOAmKeJRuaYYDblNn9J6BwhuLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930368; c=relaxed/relaxed;
	bh=jDGfPEEE+GfImF6BMhy60GIEtP+1f8zKD1+ZKs6XQMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D86g5k+ZDQQiRqLr3UutG9zDY/o0RcH8Tn0yNLMZ49tq2zvMVqSvaoYtSHbotRpmdpBVl5O+Vrb5s2lpo7OpPktLl98yVm1uBDoBjECco1PebKQRj/0j3S3pYEnUGJ/+JbDDV/9Q0vS5rdrAL3ztQ1rAwjD8iiuXE5EFkBGOn2oxOEIifxp8zNigRWWu9BFbiKqofW3z4Qp2wvZN2Wu92y9Rqm1niUGK6fpvXnQtv93OB2y/ByjO2nhciEAUyfQW2iNVsnIBlIw0RfgxPEiSputIRVwFDgijOFfDGnfEgBDv9aYisCw+UoP4NoQZ15fFi0s8kc2ZIvTjKy5J0HIf6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4c3MNjz3cZf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:32 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3B9172028D7;
	Mon,  8 Jun 2026 16:43:16 +0200 (CEST)
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
Subject: [PATCH 52/60] kvm: x86: Switch to plane0 if it has events
Date: Mon,  8 Jun 2026 16:42:44 +0200
Message-ID: <20260608144252.351443-53-joro@8bytes.org>
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

From: Joerg Roedel <joerg.roedel@amd.com>

When there are IRQs or events pending for plane0, make sure it can
handle it.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/x86.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 08fe65b8d57d..60b34bd4da9d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10962,6 +10962,20 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 	return r;
 }
 
+static inline bool kvm_check_plane0_events(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu *vcpu_plane0;
+
+	if (vcpu->plane_level == 0)
+		return false;
+
+	vcpu_plane0 = vcpu->common->vcpus[0];
+
+	return kvm_cpu_has_injectable_intr(vcpu_plane0) ||
+		vcpu_plane0->arch.nmi_pending ||
+		vcpu_plane0->arch.smi_pending;
+}
+
 static void process_nmi(struct kvm_vcpu *vcpu)
 {
 	unsigned int limit;
@@ -11410,12 +11424,19 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 				goto out;
 			}
 		}
+	}
 
-		if (kvm_check_request(KVM_REQ_PLANE_RESCHED, vcpu)) {
-			vcpu->common->plane_switch = true;
-			r = 0;
-			goto out;
-		}
+	if (kvm_check_plane0_events(vcpu)) {
+		kvm_vcpu_set_plane_runnable(vcpu->common->vcpus[0]);
+
+		kvm_make_request(KVM_REQ_EVENT, vcpu);
+		kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
+	}
+
+	if (kvm_check_request(KVM_REQ_PLANE_RESCHED, vcpu)) {
+		vcpu->common->plane_switch = true;
+		r = 0;
+		goto out;
 	}
 
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
@@ -11737,6 +11758,9 @@ bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_test_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, vcpu))
 		return true;
 
+	if (kvm_test_request(KVM_REQ_PLANE_RESCHED, vcpu))
+		return true;
+
 	if (kvm_arch_interrupt_allowed(vcpu) && kvm_cpu_has_interrupt(vcpu))
 		return true;
 
-- 
2.53.0


