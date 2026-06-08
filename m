Return-Path: <linuxppc-dev+bounces-22221-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EAECD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:53:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4Q5sFfz3c4P;
	Tue, 09 Jun 2026 00:52:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930341;
	cv=none; b=I595dpDchJfy+aoTz4E//GVl5y5v5dzz9q0ufn6Eo/2tRvgIOX7A8rasrvvvSMiqiPyqDxGkPUkV3wpnUQpPlF6gK11FBEZ7ss3Tbes+eL+QsQ2PDAoDMW34JFzl3OmWuGkh/MqkwwwWTW3Q9r7SdNdZ/fmUJTi3yku+LygLLgp0r4QkR3znlLMVchtFVmB5gRZH7rg91f+sIT5zECz9siV22ibtXFBwCBvafkvfAy+rJ9477RaV/fxoiHgfrUXIaDGOQvCh3k3ixTjR8c3pmKS9qbBpFNclkxZ/wq+uJBSuopOYUba41D8HfHGv25Hx/6SgTvBB1Gj/oewqY79/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930341; c=relaxed/relaxed;
	bh=PpRlZ8bHsEQcofpcprV068i76l8p2Ooj1Jvugv2drxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFY432KhCgceqyNqSTGyN3V9kTJNFbIEBXoqYX2VWFFBvl7AOe2llbfvG4z5mu8xGyfyWFEUyU24u//R6DErdGVQpo/aq9OrMtlgaM/y4EJ6HozJwxWb5bkxzBYFKYt82Ad9uR1KWpnm99QHpqIF7awgsFh7nQgegm52o5d4rpQzDW0wYMhKQBB+0VJZlGLLWWboWCtE6MP2clnOq/4Qn8TSXhFrC0Esdhu7WMYjqvRaD6GWSuj3jflG6dh7GjModDjw5Z2enqxKy/7cajQVNwV4eKeQfxRdbePnEmFwgEMK7MRLXDxNZFT3Hl7/O3+ITvH4uUaDVWSVpuu8AEnGRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4J0sMCz3btR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:15 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8C9352028B7;
	Mon,  8 Jun 2026 16:43:09 +0200 (CEST)
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
Subject: [PATCH 21/60] kvm: Introduce per-plane VCPU requests
Date: Mon,  8 Jun 2026 16:42:13 +0200
Message-ID: <20260608144252.351443-22-joro@8bytes.org>
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

The bitfield layout is shared with the global vcpu->common->requests
field. A new flag will indicate in which bitmap the request will be
set.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7704820986da..3c72a462ccfa 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -159,6 +159,7 @@ static inline bool kvm_is_error_gpa(gpa_t gpa)
 #define KVM_REQUEST_NO_WAKEUP      BIT(8)
 #define KVM_REQUEST_WAIT           BIT(9)
 #define KVM_REQUEST_NO_ACTION      BIT(10)
+#define KVM_REQUEST_PER_PLANE      BIT(11)
 /*
  * Architecture-independent vcpu->requests bit members
  * Bits 3-7 are reserved for more arch-independent bits.
@@ -184,6 +185,7 @@ static inline bool kvm_is_error_gpa(gpa_t gpa)
 	(unsigned)(((nr) + KVM_REQUEST_ARCH_BASE) | (flags)); \
 })
 #define KVM_ARCH_REQ(nr)           KVM_ARCH_REQ_FLAGS(nr, 0)
+#define KVM_ARCH_PLANE_REQ(nr)     KVM_ARCH_REQ_FLAGS(nr, KVM_REQUEST_PER_PLANE)
 
 bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
 				 unsigned long *vcpu_bitmap);
@@ -371,6 +373,10 @@ struct kvm_vcpu {
 	int sigset_active;
 	sigset_t sigset;
 	unsigned int halt_poll_ns;
+
+	u64 plane_requests;
+
+	/* S390 only */
 	bool valid_wakeup;
 
 #ifdef CONFIG_HAS_IOMEM
@@ -2356,7 +2362,10 @@ static inline void __kvm_make_request(int req, struct kvm_vcpu *vcpu)
 	 * caller.  Paired with the smp_mb__after_atomic in kvm_check_request.
 	 */
 	smp_wmb();
-	set_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->common->requests);
+	if (req & KVM_REQUEST_PER_PLANE)
+		set_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->plane_requests);
+	else
+		set_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->common->requests);
 }
 
 static __always_inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
@@ -2382,17 +2391,23 @@ static inline void kvm_make_request_and_kick(int req, struct kvm_vcpu *vcpu)
 
 static inline bool kvm_request_pending(struct kvm_vcpu *vcpu)
 {
-	return READ_ONCE(vcpu->common->requests);
+	return READ_ONCE(vcpu->common->requests) || READ_ONCE(vcpu->plane_requests);
 }
 
 static inline bool kvm_test_request(int req, struct kvm_vcpu *vcpu)
 {
-	return test_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->common->requests);
+	if (req & KVM_REQUEST_PER_PLANE)
+		return test_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->plane_requests);
+	else
+		return test_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->common->requests);
 }
 
 static inline void kvm_clear_request(int req, struct kvm_vcpu *vcpu)
 {
-	clear_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->common->requests);
+	if (req & KVM_REQUEST_PER_PLANE)
+		clear_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->plane_requests);
+	else
+		clear_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->common->requests);
 }
 
 static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
-- 
2.53.0


