Return-Path: <linuxppc-dev+bounces-22242-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D01CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:55:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4n5MkJz3dVy;
	Tue, 09 Jun 2026 00:52:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930357;
	cv=none; b=Mmlyd8N1Pq+jrIaxMoh1e8rHHLYbmFuzjCmDKhTaMFmU1bvYLQhBAs4biH9Pdi8XjKbCkitKdxjwRTKXr9dyfW+UHM6gPdaGnTcr1NTWqhaxipO+/bDKSZwiOBErfm2eZ+ZKfAyNkAuw4BavOActCFCx1E7mpmlTNRJS3yRfztkE+nsYXaS6JoOETMJcdDDytTr0Qe8pyZFTz1K9MEt0gjwO3v/5IfpDFBNJO994/gQhp2wNbB1OG+zVlRnvfgkaQTJsE9HfMEGFFZ2KE1Isf4MF40EgJc5N2ZBp+HIC7FDYJLEVYQQSRTSVBWLY8k3ra6vvmOhLKmuZ8QyC2mJh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930357; c=relaxed/relaxed;
	bh=QLQl4mcTCJJkecYSh/tVe4nXOxB6DsGl6T6pB2ut37k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk0Q+dYB4KFvYlqqAtfWD/HsTNiAyfzVTbo2q/FKtY9V7lDPBEkc5AybdtzzgEdRul6Q7tkOKA2TbJeViIV1RM+uSNU7m2HEFwYztrKTz/Ox5OCKjIjMVexPAVoJpbfqJFX82mBclTKgsPPNIwuTP3FEHARFxvyFqqN+tZ0lNMd2Tpy7GVAf3xvO8lcvSHRYAZ02/4GfThPFczcELXMZTIfHJfJR7g51E1aZv26pAkCIE6poHY3rBQq/YhL+FbEfbSWBswbBZp9DYYeeM7TT+TX3NuChWynyunI4stxNnfFM+l7/W2K3SB7rAsVWAbbt3VHOc7crV7l2pki+A1uUDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4T0b53z3c7b
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:25 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2E2042028D2;
	Mon,  8 Jun 2026 16:43:15 +0200 (CEST)
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
Subject: [PATCH 47/60] kvm: x86: Select a plane to run
Date: Mon,  8 Jun 2026 16:42:39 +0200
Message-ID: <20260608144252.351443-48-joro@8bytes.org>
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

In the KVM_RUN path, select a runnable VCPU plane and use it to enter
the guest. Also handle KVM_REQ_PLANE_RESCHED events to switch planes
without exiting to user-space.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/x86.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7e94a378b3d2..b9828cd31136 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11398,6 +11398,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 				goto out;
 			}
 		}
+
+		if (kvm_check_request(KVM_REQ_PLANE_RESCHED, vcpu)) {
+			vcpu->common->plane_switch = true;
+			r = 0;
+			goto out;
+		}
 	}
 
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
@@ -12076,7 +12082,7 @@ static int kvm_x86_vcpu_pre_run(struct kvm_vcpu *vcpu)
 	return kvm_x86_call(vcpu_pre_run)(vcpu);
 }
 
-int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
+static int __kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 {
 	struct kvm_queued_exception *ex = &vcpu->arch.exception;
 	struct kvm_run *kvm_run = vcpu->run;
@@ -12196,6 +12202,27 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	return r;
 }
 
+int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu_plane0)
+{
+	struct kvm_vcpu_common *common = vcpu_plane0->common;
+	int ret;
+
+	do {
+		struct kvm_vcpu *vcpu = kvm_vcpu_select_plane(vcpu_plane0);
+
+		if (vcpu == NULL)
+			return -EINVAL;
+
+		common->plane_switch = false;
+
+		ret = __kvm_arch_vcpu_ioctl_run(vcpu);
+		if (ret)
+		       break;
+	} while (vcpu_plane0->common->plane_switch);
+
+	return ret;
+}
+
 static void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	if (vcpu->arch.emulate_regs_need_sync_to_vcpu) {
-- 
2.53.0


