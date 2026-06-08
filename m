Return-Path: <linuxppc-dev+bounces-22256-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B243CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:57:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw502BDJz3f7H;
	Tue, 09 Jun 2026 00:52:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930372;
	cv=none; b=F59MQBOn0ZfUZ2lJGF9Qnl4fs2JkxcjXKqAFsGvMBlSu84WR6IzK4U2TLpDx58F6yIV+HQFkrLKwVQHZrxnDtiv+FT1W2QPE5tO9mACerFO1A1b9mSJ+XBkILkrAuC0p51VsBapudxah1oRHukTqQkikoE8I38g33grr6/rh8gOMjXlxD3jVwO8KTifMykHkwQt8cH5yu1yJlD9XxhChDoRypILP1ufq5yPyj3HVCmKrP3Kz5QF9EPKXtBgp/DgR181C3OMuvdhJzYXqTftrQvqAXhmrb3KVy8BB4/bMcdNgvk6Ibaswm5zIzPucaBWcVziu8U3RmrbOQWx40v/MQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930372; c=relaxed/relaxed;
	bh=hNQP7/EdSG3cCeW6Faawmy/E0oUQJiBDgFzOTeJqXM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwBmkWVViLP0xG2SGYnde5EL9GH8R1v26zk1RMh3UOmsb5pBT/KckFyklKluyCD+35wF6p8Hev73kab6plgj3r2cMQVqLJLJNvMJgg4++F1tREVBk9X+Z6yObJtbI+C8FFBH/A7myTTZXSYRkWjKvhBuz596knoxn0oT+h+m2eET5qkYAxOc4mr/hLvmqT9pC50b/dSjfM5bwfwuQkJUzfCOQTZ6JxLbc+nRhpaERsrCCWppRFl0/QrNSbUWsc87184N5/4Br0QNKp5zarp+y0JeEoy/J+UVrpmNUOZDnXSVss/EtC6Y1BoHf0/EFDCnFAgPy/LfBCubpJnqq3v9TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4f4Wlqz3chX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:34 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 337162028BB;
	Mon,  8 Jun 2026 16:43:10 +0200 (CEST)
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
Subject: [PATCH 24/60] kvm: Move kvm_vcpu spinloop members to struct kvm_vcpu_common
Date: Mon,  8 Jun 2026 16:42:16 +0200
Message-ID: <20260608144252.351443-25-joro@8bytes.org>
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

Onlyh one struct kvm_vcpu across all planes can be in a spin-loop.
Move the state to struct kvm_vcpu_common to make detection independent
of the active struct kvm_vcpu.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h | 32 +++++++++++++++----------------
 virt/kvm/kvm_main.c      | 41 ++++++++++++++++++++++------------------
 2 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9220c452aa3a..f6e8a0b653b3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -350,6 +350,20 @@ struct kvm_vcpu_common {
 	rwlock_t pid_lock;
 	int sigset_active;
 	sigset_t sigset;
+	unsigned int halt_poll_ns;
+
+#ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
+	/*
+	 * Cpu relax intercept or pause loop exit optimization
+	 * in_spin_loop: set when a vcpu does a pause loop exit
+	 *  or cpu relax intercepted.
+	 * dy_eligible: indicates whether vcpu is eligible for directed yield.
+	 */
+	struct {
+		bool in_spin_loop;
+		bool dy_eligible;
+	} spin_loop;
+#endif
 
 	/* Scheduling state */
 #ifdef CONFIG_PREEMPT_NOTIFIERS
@@ -373,8 +387,6 @@ struct kvm_vcpu {
 
 	struct kvm_run *run;
 
-	unsigned int halt_poll_ns;
-
 	u64 plane_requests;
 
 	/* S390 only */
@@ -398,18 +410,6 @@ struct kvm_vcpu {
 	} async_pf;
 #endif
 
-#ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
-	/*
-	 * Cpu relax intercept or pause loop exit optimization
-	 * in_spin_loop: set when a vcpu does a pause loop exit
-	 *  or cpu relax intercepted.
-	 * dy_eligible: indicates whether vcpu is eligible for directed yield.
-	 */
-	struct {
-		bool in_spin_loop;
-		bool dy_eligible;
-	} spin_loop;
-#endif
 	struct kvm_vcpu_arch arch;
 	struct kvm_vcpu_stat stat;
 	char stats_id[KVM_STATS_NAME_SIZE];
@@ -2500,11 +2500,11 @@ extern struct kvm_device_ops kvm_arm_vgic_v5_ops;
 
 static inline void kvm_vcpu_set_in_spin_loop(struct kvm_vcpu *vcpu, bool val)
 {
-	vcpu->spin_loop.in_spin_loop = val;
+	vcpu->common->spin_loop.in_spin_loop = val;
 }
 static inline void kvm_vcpu_set_dy_eligible(struct kvm_vcpu *vcpu, bool val)
 {
-	vcpu->spin_loop.dy_eligible = val;
+	vcpu->common->spin_loop.dy_eligible = val;
 }
 
 #else /* !CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1858880ee3d3..24ff8748a317 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -485,6 +485,9 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 
 	vcpu->common = no_free_ptr(common);
 
+	kvm_vcpu_set_in_spin_loop(vcpu, false);
+	kvm_vcpu_set_dy_eligible(vcpu, false);
+
 	return 0;
 
 out_drop_counter:
@@ -515,8 +518,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	vcpu->vcpu_id = id;
 	kvm_async_pf_vcpu_init(vcpu);
 
-	kvm_vcpu_set_in_spin_loop(vcpu, false);
-	kvm_vcpu_set_dy_eligible(vcpu, false);
 	vcpu->last_used_slot = NULL;
 
 	vcpu->plane_level = 0;
@@ -3721,9 +3722,10 @@ void kvm_sigset_deactivate(struct kvm_vcpu *vcpu)
 
 static void grow_halt_poll_ns(struct kvm_vcpu *vcpu)
 {
+	struct kvm_vcpu_common *common = vcpu->common;
 	unsigned int old, val, grow, grow_start;
 
-	old = val = vcpu->halt_poll_ns;
+	old = val = common->halt_poll_ns;
 	grow_start = READ_ONCE(halt_poll_ns_grow_start);
 	grow = READ_ONCE(halt_poll_ns_grow);
 	if (!grow)
@@ -3733,16 +3735,17 @@ static void grow_halt_poll_ns(struct kvm_vcpu *vcpu)
 	if (val < grow_start)
 		val = grow_start;
 
-	vcpu->halt_poll_ns = val;
+	common->halt_poll_ns = val;
 out:
 	trace_kvm_halt_poll_ns_grow(vcpu->vcpu_id, val, old);
 }
 
 static void shrink_halt_poll_ns(struct kvm_vcpu *vcpu)
 {
+	struct kvm_vcpu_common *common = vcpu->common;
 	unsigned int old, val, shrink, grow_start;
 
-	old = val = vcpu->halt_poll_ns;
+	old = val = common->halt_poll_ns;
 	shrink = READ_ONCE(halt_poll_ns_shrink);
 	grow_start = READ_ONCE(halt_poll_ns_grow_start);
 	if (shrink == 0)
@@ -3753,7 +3756,7 @@ static void shrink_halt_poll_ns(struct kvm_vcpu *vcpu)
 	if (val < grow_start)
 		val = 0;
 
-	vcpu->halt_poll_ns = val;
+	common->halt_poll_ns = val;
 	trace_kvm_halt_poll_ns_shrink(vcpu->vcpu_id, val, old);
 }
 
@@ -3864,19 +3867,20 @@ void kvm_vcpu_halt(struct kvm_vcpu *vcpu)
 {
 	unsigned int max_halt_poll_ns = kvm_vcpu_max_halt_poll_ns(vcpu);
 	bool halt_poll_allowed = !kvm_arch_no_poll(vcpu);
+	struct kvm_vcpu_common *common = vcpu->common;
 	ktime_t start, cur, poll_end;
 	bool waited = false;
 	bool do_halt_poll;
 	u64 halt_ns;
 
-	if (vcpu->halt_poll_ns > max_halt_poll_ns)
-		vcpu->halt_poll_ns = max_halt_poll_ns;
+	if (common->halt_poll_ns > max_halt_poll_ns)
+		common->halt_poll_ns = max_halt_poll_ns;
 
-	do_halt_poll = halt_poll_allowed && vcpu->halt_poll_ns;
+	do_halt_poll = halt_poll_allowed && common->halt_poll_ns;
 
 	start = cur = poll_end = ktime_get();
 	if (do_halt_poll) {
-		ktime_t stop = ktime_add_ns(start, vcpu->halt_poll_ns);
+		ktime_t stop = ktime_add_ns(start, common->halt_poll_ns);
 
 		do {
 			if (kvm_vcpu_check_block(vcpu) < 0)
@@ -3914,18 +3918,18 @@ void kvm_vcpu_halt(struct kvm_vcpu *vcpu)
 		if (!vcpu_valid_wakeup(vcpu)) {
 			shrink_halt_poll_ns(vcpu);
 		} else if (max_halt_poll_ns) {
-			if (halt_ns <= vcpu->halt_poll_ns)
+			if (halt_ns <= common->halt_poll_ns)
 				;
 			/* we had a long block, shrink polling */
-			else if (vcpu->halt_poll_ns &&
+			else if (common->halt_poll_ns &&
 				 halt_ns > max_halt_poll_ns)
 				shrink_halt_poll_ns(vcpu);
 			/* we had a short halt and our poll time is too small */
-			else if (vcpu->halt_poll_ns < max_halt_poll_ns &&
+			else if (common->halt_poll_ns < max_halt_poll_ns &&
 				 halt_ns < max_halt_poll_ns)
 				grow_halt_poll_ns(vcpu);
 		} else {
-			vcpu->halt_poll_ns = 0;
+			common->halt_poll_ns = 0;
 		}
 	}
 
@@ -4046,13 +4050,14 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_yield_to);
 static bool kvm_vcpu_eligible_for_directed_yield(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
+	struct kvm_vcpu_common *common = vcpu->common;
 	bool eligible;
 
-	eligible = !vcpu->spin_loop.in_spin_loop ||
-		    vcpu->spin_loop.dy_eligible;
+	eligible = !common->spin_loop.in_spin_loop ||
+		    common->spin_loop.dy_eligible;
 
-	if (vcpu->spin_loop.in_spin_loop)
-		kvm_vcpu_set_dy_eligible(vcpu, !vcpu->spin_loop.dy_eligible);
+	if (common->spin_loop.in_spin_loop)
+		kvm_vcpu_set_dy_eligible(vcpu, !common->spin_loop.dy_eligible);
 
 	return eligible;
 #else
-- 
2.53.0


