Return-Path: <linuxppc-dev+bounces-22216-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2020CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:52:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4L2SWCz3bx1;
	Tue, 09 Jun 2026 00:52:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930338;
	cv=none; b=fDge6UoMkQhGBqYM+B/OojzxxEL2NvslTN+Rmijct2twwfV/iq8rB/IxnlzfOpQmrMlEeORwncAPQRCx8kheO7FAVU00tyjdbGy+SdlST2pzpkhh26X5S4NECRmxbcffk0jcLswhq5E7i2Z8vJMJr4a1jxAjBCiYcp3R/qOTTjlhl+Q7jiRdQy7id+CafxItrgeGLFfjFY7XZoJaVjbP2ZrK3c9oS2QswgSBeT+6Pz+ZyJig2KvS7sx6Dqmq8rtqlV4g8lnL2ltFEJJrQ0Ix0hS3F5PJjreDTkN3bI/PEljMPOrSsa+6gX2psEpwhFY7gJMUH5/I5BM+rOaGAdcyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930338; c=relaxed/relaxed;
	bh=FWOGUYeWOxsT4UPy/dLhzZ1VIiE+P/0sgaBT4DvO4Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8t7jk5TUH36+E6GZvFnKuS0fsWzmWA8YlngTWzwNGHXhpH8LXmub94Z5s0eHPvvJPWQsZV+/E99kIxRIb9q7EUKEzSqqVvHNZQ87aJXDY5P0srdB1R8n+h8T2pTmceiUu4RX5CBDhQgRV9NV8jHP2tVIwHRDF35uPRCbGVhPtmI/cDjCcRQeGCv4IYsrexnK2CgzhSGSWiNmIkYFklU1mC6zCiBSR8kjUtqhTAuQOlg9TCtz5naIw8H10sgS5BMrXapm288ALtVQka5U9uiIEYjYtYavT8igMcKxTx0vdR//OItCH5aZZqRuHSlmA8IE+KH43J+AvyjItkReoGj+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4G6ZfXz3bsX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:14 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B9A7C2028D0;
	Mon,  8 Jun 2026 16:43:14 +0200 (CEST)
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
Subject: [PATCH 45/60] kvm: x86: Update state for all plane VCPUs after CPUID update
Date: Mon,  8 Jun 2026 16:42:37 +0200
Message-ID: <20260608144252.351443-46-joro@8bytes.org>
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

Make sure to update CPUID dependent state for all VCPUs of a given
plane when CPUID state is updated.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/cpuid.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 27e2f7e25038..fab075bb6fdc 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -513,6 +513,8 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 {
 	struct kvm_vcpu_common *common = vcpu->common;
 	u32 vcpu_caps[NR_KVM_CPU_CAPS];
+	struct kvm_vcpu *v;
+	unsigned i;
 	int r;
 
 	/*
@@ -562,9 +564,11 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 
 #ifdef CONFIG_KVM_HYPERV
 	if (kvm_cpuid_has_hyperv(vcpu)) {
-		r = kvm_hv_vcpu_init(vcpu);
-		if (r)
-			goto err;
+		vcpu_for_each_plane(common, i, v) {
+			r = kvm_hv_vcpu_init(vcpu);
+			if (r)
+				goto err;
+		}
 	}
 #endif
 
@@ -572,10 +576,12 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 	if (r)
 		goto err;
 
+	vcpu_for_each_plane(vcpu->common, i, v) {
 #ifdef CONFIG_KVM_XEN
-	vcpu->arch.xen.cpuid = kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
+		v->arch.xen.cpuid = kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
 #endif
-	kvm_vcpu_after_set_cpuid(vcpu);
+		kvm_vcpu_after_set_cpuid(v);
+	}
 
 success:
 	kvfree(e2);
-- 
2.53.0


