Return-Path: <linuxppc-dev+bounces-22215-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95486CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:52:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4J2Nsmz3btX;
	Tue, 09 Jun 2026 00:52:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930335;
	cv=none; b=oYKv8usng5zE7a4clP1PWmCXDCzdx7yHfIg2hLPbMrDq4N6516QDrXPPSxDhOK+KcXCOtKvD9QjXVVPv6YV/m6mXuyForkdlztY8goDkqjHAkhHU7WBoYcElFj+PF4G2f9XnqsMhDjonttQV/1rYl4mhV5UiUFNZOFlOtabfYaQh4bA9zP/Lc+KKOwNd7uGvUUti5rK4SaOBSlYA+QNnt3bwFbfIGVViz8WO2UCFKSejaQ24bDcoOpp/OJq+zU+Z1sa6+XJl7jf07P3TcMPuvK4WRC3MwnrUYxMu8uoRgNzs4lFP5+6yphYUmdltSuP+sxXAw1aXlfSaWegXCzr5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930335; c=relaxed/relaxed;
	bh=Mj+hs0sYQ+/o05kx/FdOil2vLVriuTFBHpVIuNF2BLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5brGph7uc9XN7xEX+xkiAEoe2TOPK0B2NNTpFo02qK73oGRNBTakS43jFBUPzB1qi8QIsNIpfD2QDtt6eUPHrcAFSObyiatuqJGV1dyRABYQCIDqbjTVvylThZeGrfB2CtgRLTgWGblBJx8xaRCZFLcBOoItawcMA/5fUnMyt97pKi1p9PuWtQWqzDJtIzA3gNTkJSSVrPqiRhBwwwvsldXC8B5b6YruRKkqkonlD0IC2CLyGHrC5X0iGXNH0gPtN0gREy1cG+oidib5fg1PBWhlYQpGuZ37eJEZAh/LZJW8hw5A5Tgfny2QSLgdGsF2U9k9By6FK/mpp9NLxe8Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4C2w2Tz3brD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:11 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B17262028B4;
	Mon,  8 Jun 2026 16:43:08 +0200 (CEST)
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
Subject: [PATCH 17/60] kvm: Move VCPU locking to struct kvm_vcpu_common
Date: Mon,  8 Jun 2026 16:42:09 +0200
Message-ID: <20260608144252.351443-18-joro@8bytes.org>
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

Fields in struct kvm_vcpu which are protected by these locks is going
to move to struct kvm_vcpu_common. So move the locks as well.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h | 31 +++++++++++++++++--------------
 virt/kvm/kvm_main.c      |  3 ++-
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 611bba515ac0..c8085c23e18e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -330,6 +330,13 @@ struct kvm_vcpu_common {
 	/* Currently active VCPU */
 	struct kvm_vcpu *current_vcpu;
 
+	/* Locks */
+	int ____srcu_idx; /* Don't use this directly.  You've been warned. */
+#ifdef CONFIG_PROVE_RCU
+	int srcu_depth;
+#endif
+	struct mutex mutex;
+
 	/* Scheduling state */
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	struct preempt_notifier preempt_notifier;
@@ -347,15 +354,11 @@ struct kvm_vcpu {
 	int cpu;
 	int vcpu_id; /* id given by userspace at creation */
 	int vcpu_idx; /* index into kvm->planes[]->vcpu_array */
-	int ____srcu_idx; /* Don't use this directly.  You've been warned. */
-#ifdef CONFIG_PROVE_RCU
-	int srcu_depth;
-#endif
+
 	int mode;
 	u64 requests;
 	unsigned long guest_debug;
 
-	struct mutex mutex;
 	struct kvm_run *run;
 
 #ifndef __KVM_HAVE_ARCH_WQP
@@ -1001,35 +1004,35 @@ static inline void kvm_vm_bugged(struct kvm *kvm)
 
 static inline void kvm_vcpu_lock(struct kvm_vcpu *vcpu)
 {
-	mutex_lock(&vcpu->mutex);
+	mutex_lock(&vcpu->common->mutex);
 }
 
 static inline void kvm_vcpu_unlock(struct kvm_vcpu *vcpu)
 {
-	mutex_unlock(&vcpu->mutex);
+	mutex_unlock(&vcpu->common->mutex);
 }
 
 static inline struct mutex *kvm_vcpu_mutex(struct kvm_vcpu *vcpu)
 {
-	return &vcpu->mutex;
+	return &vcpu->common->mutex;
 }
 
 static inline void kvm_vcpu_srcu_read_lock(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_PROVE_RCU
-	WARN_ONCE(vcpu->srcu_depth++,
-		  "KVM: Illegal vCPU srcu_idx LOCK, depth=%d", vcpu->srcu_depth - 1);
+	WARN_ONCE(vcpu->common->srcu_depth++,
+		  "KVM: Illegal vCPU srcu_idx LOCK, depth=%d", vcpu->common->srcu_depth - 1);
 #endif
-	vcpu->____srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+	vcpu->common->____srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 }
 
 static inline void kvm_vcpu_srcu_read_unlock(struct kvm_vcpu *vcpu)
 {
-	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->____srcu_idx);
+	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->common->____srcu_idx);
 
 #ifdef CONFIG_PROVE_RCU
-	WARN_ONCE(--vcpu->srcu_depth,
-		  "KVM: Illegal vCPU srcu_idx UNLOCK, depth=%d", vcpu->srcu_depth);
+	WARN_ONCE(--vcpu->common->srcu_depth,
+		  "KVM: Illegal vCPU srcu_idx UNLOCK, depth=%d", vcpu->common->srcu_depth);
 #endif
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d6975a5c60b4..9accca10c249 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -466,6 +466,8 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 
 	common->vcpu_idx = atomic_read(&kvm->online_vcpus);
 
+	mutex_init(&common->mutex);
+
 	common->kvm = kvm;
 	common->current_vcpu = vcpu;
 
@@ -500,7 +502,6 @@ static void kvm_vcpu_finish_common(struct kvm_vcpu *vcpu)
 
 static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 {
-	mutex_init(&vcpu->mutex);
 	vcpu->cpu = -1;
 	vcpu->kvm = kvm;
 	vcpu->plane = kvm->planes[0];
-- 
2.53.0


