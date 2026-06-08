Return-Path: <linuxppc-dev+bounces-22234-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5ACCD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:54:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4d1mc3z3cb7;
	Tue, 09 Jun 2026 00:52:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930351;
	cv=none; b=GxjQ4zWdN3sOh32/+HV9IVJnMDU9GWfr0JkzZC/0a+5MQP0SqVgFY6prdw7EJ4kSZl6PIu4zHmHdERW+QtQV3alDsR8CmLF67k08I7Fnl3IHX5AfnRwDaXhMeOv3OrO4+LoxupcC3za4xTfmf4OLXpvwVxA0tjXwW1VuGjfJnEol3S09r4tX6SnX6ShjNAjhDA51sW1JicpYLDrMb4NMrSkdEMyDMkmQkaKAKZQEux9fnZnJxNPxFUuI4CvrRxOSJDEskLYUrABCcWa2H6f3ujDfKQM3kTFlnuTFJxQaj8ErOx5FfDIFyvfB4LkTN4+zsfJjN0OByiwqhVuFWQNPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930351; c=relaxed/relaxed;
	bh=jFFUvyiHES8ja/EMt+EoKa2gVZyIvQ++Vm5xoc+AD98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSysxVeuOOP3WQgp5Hp4630ouG288rngDo2QFCaPcozE+fTMeFSe9GJ+vzjniLgOyuuFTQ25av7mGleX2AxENfgyOejisU5BG88g4Sn/rZOqYKIkQvpEG/Mxoi/Hz8TR6LaUjgbnOORj7R1k3zF0tE1zzj6OqHrKglGpva5bU1XSGF1gEIhmhoslCmG8IVeNtGh0H8nBgN4k8nf0zaahBcz/b3c5iWSVldGQifqvX0yNBGSzgRjyekRUSC1x4moEVa0hgeVFIxX3NH/5nARpbu9qaYMolNw6SWqnnV+ZLBJtl2d4PTv7UioXWD4pVNQn05n6QBeMcHkWzRTJT/uLmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4Q31cHz3c3x
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:22 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5E0962028C5;
	Mon,  8 Jun 2026 16:43:12 +0200 (CEST)
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
Subject: [PATCH 34/60] kvm: Keep track of plane VCPUs in struct kvm_vcpu_common
Date: Mon,  8 Jun 2026 16:42:26 +0200
Message-ID: <20260608144252.351443-35-joro@8bytes.org>
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

Introduce an array which keeps track of per-plane VCPU instances for a
single VCPU index. This is a short-cut to not always tranverse the
xarrays on plane switches.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h | 6 ++++++
 virt/kvm/kvm_main.c      | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b8c3f8f11cb4..5c3f9dfa15ea 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -335,6 +335,8 @@ struct kvm_vcpu_common {
 	/* Currently active VCPU */
 	struct kvm_vcpu *current_vcpu;
 
+	struct kvm_vcpu *vcpus[KVM_MAX_PLANES];
+
 	/* Locks */
 	int ____srcu_idx; /* Don't use this directly.  You've been warned. */
 #ifdef CONFIG_PROVE_RCU
@@ -382,6 +384,10 @@ struct kvm_vcpu_common {
 	struct kvm_vcpu_arch_common arch;
 };
 
+#define vcpu_for_each_plane(common, i, v)			\
+	for ((i) = 0; (i) < KVM_MAX_PLANES; ++(i))		\
+		if (((v) = common->vcpus[(i)]) != NULL)
+
 struct kvm_vcpu {
 	struct kvm *kvm;
 	struct kvm_plane *plane;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8839f91fd15e..9d30fd85ce5f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -524,6 +524,8 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 
 static void kvm_vcpu_finish_common(struct kvm_vcpu *vcpu)
 {
+	WARN_ON(vcpu->common->vcpus[vcpu->plane_level] != NULL);
+	vcpu->common->vcpus[vcpu->plane_level] = vcpu;
 	smp_wmb();
 	if (vcpu->plane_level == 0) {
 		/*
@@ -555,6 +557,7 @@ static void kvm_vcpu_common_destroy(struct kvm_vcpu *vcpu)
 
 	vcpu->common = NULL;
 	vcpu->run = NULL;
+	common->vcpus[vcpu->plane_level] = NULL;
 
 	if (vcpu->plane_level != 0)
 	       return;
-- 
2.53.0


