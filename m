Return-Path: <linuxppc-dev+bounces-22229-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB4CCD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:54:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4Z3Z5Gz3cPl;
	Tue, 09 Jun 2026 00:52:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930349;
	cv=none; b=gpd/C57Jhajqn2m2D4UCHtGcS0PYOuCDVswFXeBwhK6F9D4F2NXj6UxFA5Cq64y/KrqLOP1SUZ3b4DbRpYn8hdGvGNY5o370pTkIZ0xbV8mB+sB6/2k0LTjsV4QmjM7LYw4a2d3aVKB9jxhcxxA/uIv488DLPodqMguelGylH3h/hq6Pkhws3rcP/YH/3CMKYyfEJZDkfQ4Ag2A0hfc7VERGYObJvT8iECeYafrmYhLQMI4KACiItR3zI9ZkSgRDt2L/cJ7WTCvPQpU4yCFzQDmQ90wOvAba71gqu+fLNCBKVZe6IbC3vrGWiF7O6cLl3xOxZ6vAMkeRVgS4V4fDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930349; c=relaxed/relaxed;
	bh=4idPmv3gw5ipZVUWVE9OuU2Z0pQsmOCSderM6jApiyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSoCfRwqkI8l3wDzVFBu05OLESfv8Os/zyMKf7or/HqAb91mEmvkhKtH5s/inoe8M3eD6qkbF/3omUaghADYmnCjFk/5PnSNEIYhV7ZP2Nw/44tGdgIyQQB6atohyOnHyECdrfGSIPKza59g1OzwNY3JdUaTgOoUq+BMuNR3z8f6OOSl3tlt/TT5rINSirM9ugVMXjh4hGmS9OiAgXhTKU6waYLGCj44GmZVuXvfqm+kXnbfrjb5m5FDQaAMhwong4bKBqCS8ZANHGBXXdXfC9Pi1k/6wXJyNxaizWDxYsU9sOx1hEjz9vAlM6zbJ4pv1yK2Lui3gOPFKKDpvs8z7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4P1kR0z3c2C
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:20 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EF1012028D1;
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
Subject: [PATCH 46/60] kvm: x86: Share MTRR state across planes
Date: Mon,  8 Jun 2026 16:42:38 +0200
Message-ID: <20260608144252.351443-47-joro@8bytes.org>
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

Share the MTRR state across all planes of a given VCPU index.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  3 ++-
 arch/x86/kvm/mtrr.c             | 12 +++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b0d040528f9d..f30173093c44 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -817,6 +817,8 @@ struct kvm_vcpu_arch_common {
 	 */
 	u32 cpu_caps[NR_KVM_CPU_CAPS];
 
+	/* Cache configuration state */
+	struct kvm_mtrr mtrr_state;
 };
 
 int kvm_arch_vcpu_common_init(struct kvm_vcpu_common *common);
@@ -994,7 +996,6 @@ struct kvm_vcpu_arch {
 	bool smi_pending;    /* SMI queued after currently running handler */
 	u8 handling_intr_from_guest;
 
-	struct kvm_mtrr mtrr_state;
 	u64 pat;
 
 	unsigned switch_db_regs;
diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
index 6f74e2b27c1e..610ff975e022 100644
--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -23,18 +23,20 @@
 
 static u64 *find_mtrr(struct kvm_vcpu *vcpu, unsigned int msr)
 {
+	struct kvm_vcpu_common *common = vcpu->common;
+
 	int index;
 
 	switch (msr) {
 	case MTRRphysBase_MSR(0) ... MTRRphysMask_MSR(KVM_NR_VAR_MTRR - 1):
 		index = msr - MTRRphysBase_MSR(0);
-		return &vcpu->arch.mtrr_state.var[index];
+		return &common->arch.mtrr_state.var[index];
 	case MSR_MTRRfix64K_00000:
-		return &vcpu->arch.mtrr_state.fixed_64k;
+		return &common->arch.mtrr_state.fixed_64k;
 	case MSR_MTRRfix16K_80000:
 	case MSR_MTRRfix16K_A0000:
 		index = msr - MSR_MTRRfix16K_80000;
-		return &vcpu->arch.mtrr_state.fixed_16k[index];
+		return &common->arch.mtrr_state.fixed_16k[index];
 	case MSR_MTRRfix4K_C0000:
 	case MSR_MTRRfix4K_C8000:
 	case MSR_MTRRfix4K_D0000:
@@ -44,9 +46,9 @@ static u64 *find_mtrr(struct kvm_vcpu *vcpu, unsigned int msr)
 	case MSR_MTRRfix4K_F0000:
 	case MSR_MTRRfix4K_F8000:
 		index = msr - MSR_MTRRfix4K_C0000;
-		return &vcpu->arch.mtrr_state.fixed_4k[index];
+		return &common->arch.mtrr_state.fixed_4k[index];
 	case MSR_MTRRdefType:
-		return &vcpu->arch.mtrr_state.deftype;
+		return &common->arch.mtrr_state.deftype;
 	default:
 		break;
 	}
-- 
2.53.0


