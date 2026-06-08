Return-Path: <linuxppc-dev+bounces-22238-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD50CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:54:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4j49M6z3dHc;
	Tue, 09 Jun 2026 00:52:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930354;
	cv=none; b=UiuMBVkJMdCWpb5GtSbEEg2M3Pcr2mYaJyzk6nHrq3OI3jifLlD/WLDHlYEAa1TqbE6HNgAcSJJACNs8eJ0UbRrfHXHi492NDz6se9/0Kpb1h5eUJf8znHCUiJbx4Xxkdol/71wS2Q3qMGmG3Qc2vo0+OrFYj6Vxywk+jFBrsafGcs5CUYKEYhCF3dMJhhHOAazNK+YQB66wL/jX5wchf5fU1/1hyC7tIo6t5/+R02I21igz4sSAa12IVST4FTv374fuD2170v4+HJ8S9N/20+tZhmuEkgXJkw0Pju0/yogHoIk+0zxZw6M/+8khjxre1gV4ttayYlCL35stOk85CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930354; c=relaxed/relaxed;
	bh=xPy/a2evO56iISUey6hMITHDSlt7ojykGtQqTg5ULm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrqOEGJmEPYDJ+0VooEomhx14bD96A5srZeWXVGpgTeDAQyOjS8bv79+VupNT27PkB+2g4WFITs2PQv6oEojF5iiosVALAugAlKdutSyFIKOre3KHdyuhIeEznNkDMUNlUQtV3HHBni16l3FqNs6tt91lDTBbLiwvllGMOXvrD/YeYrQ+wRNFlRhFXoJpyp3hdT5wbGosRt+uET2nPL0cENjQolvzdbcPsu7W1X137Yw01Qg3GTYWkV8Sz+xgxIu7bftHmxJPIxBkviXP5yOOyi/iXBRG7kHoRdClaEfvMYHt5gtKDN/pq/rrpEakYgmMKdqI+Se8pfZ7AhLYVMqag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4Q6rGqz3c4d
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:22 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4B2B22028B2;
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
Subject: [PATCH 15/60] kvm: Move VCPU scheduling state to struct kvm_vcpu_common
Date: Mon,  8 Jun 2026 16:42:07 +0200
Message-ID: <20260608144252.351443-16-joro@8bytes.org>
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

The scheduling state of the KVM VCPU is shared between all per-plane
VCPU objects. Move it to struct kvm_vcpu_common.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/svm/svm.c   |  2 +-
 include/linux/kvm_host.h | 24 ++++++++++----------
 virt/kvm/kvm_main.c      | 47 +++++++++++++++++++++-------------------
 3 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1524c1bb4f37..f5cc30a6732f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -229,7 +229,7 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 			 * and only if the vCPU is actively running, e.g. to
 			 * avoid positives if userspace is stuffing state.
 			 */
-			if (is_guest_mode(vcpu) && vcpu->wants_to_run)
+			if (is_guest_mode(vcpu) && vcpu->common->wants_to_run)
 				kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
 			svm_leave_nested(vcpu);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d54f299218a4..a6aacd507c02 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -329,15 +329,21 @@ struct kvm_vcpu_common {
 
 	/* Currently active VCPU */
 	struct kvm_vcpu *current_vcpu;
+
+	/* Scheduling state */
+#ifdef CONFIG_PREEMPT_NOTIFIERS
+	struct preempt_notifier preempt_notifier;
+#endif
+	bool wants_to_run;
+	bool preempted;
+	bool ready;
+	bool scheduled_out;
 };
 
 struct kvm_vcpu {
 	struct kvm *kvm;
 	struct kvm_plane *plane;
 
-#ifdef CONFIG_PREEMPT_NOTIFIERS
-	struct preempt_notifier preempt_notifier;
-#endif
 	int cpu;
 	int vcpu_id; /* id given by userspace at creation */
 	int vcpu_idx; /* index into kvm->planes[]->vcpu_array */
@@ -392,10 +398,6 @@ struct kvm_vcpu {
 		bool dy_eligible;
 	} spin_loop;
 #endif
-	bool wants_to_run;
-	bool preempted;
-	bool ready;
-	bool scheduled_out;
 	struct kvm_vcpu_arch arch;
 	struct kvm_vcpu_stat stat;
 	char stats_id[KVM_STATS_NAME_SIZE];
@@ -416,22 +418,22 @@ struct kvm_vcpu {
 
 static inline bool kvm_vcpu_wants_to_run(struct kvm_vcpu *vcpu)
 {
-	return vcpu->wants_to_run;
+	return vcpu->common->wants_to_run;
 }
 
 static inline bool kvm_vcpu_preempted(struct kvm_vcpu *vcpu)
 {
-	return READ_ONCE(vcpu->preempted);
+	return READ_ONCE(vcpu->common->preempted);
 }
 
 static inline bool kvm_vcpu_ready(struct kvm_vcpu *vcpu)
 {
-	return READ_ONCE(vcpu->ready);
+	return READ_ONCE(vcpu->common->ready);
 }
 
 static inline bool kvm_vcpu_scheduled_out(struct kvm_vcpu *vcpu)
 {
-	return vcpu->scheduled_out;
+	return vcpu->common->scheduled_out;
 }
 
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9c07321e30f4..a44f8dc8418a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -166,7 +166,7 @@ void vcpu_load(struct kvm_vcpu *vcpu)
 	int cpu = get_cpu();
 
 	__this_cpu_write(kvm_running_vcpu, vcpu->common);
-	preempt_notifier_register(&vcpu->preempt_notifier);
+	preempt_notifier_register(&vcpu->common->preempt_notifier);
 	kvm_arch_vcpu_load(vcpu, cpu);
 	put_cpu();
 }
@@ -176,7 +176,7 @@ void vcpu_put(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
 	kvm_arch_vcpu_put(vcpu);
-	preempt_notifier_unregister(&vcpu->preempt_notifier);
+	preempt_notifier_unregister(&vcpu->common->preempt_notifier);
 	__this_cpu_write(kvm_running_vcpu, NULL);
 	preempt_enable();
 }
@@ -468,6 +468,12 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 
 	common->kvm = kvm;
 	common->current_vcpu = vcpu;
+
+	common->wants_to_run = false;
+	common->preempted = false;
+	common->ready = false;
+	preempt_notifier_init(&common->preempt_notifier, &kvm_preempt_ops);
+
 	vcpu->common = no_free_ptr(common);
 
 	return 0;
@@ -508,9 +514,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 
 	kvm_vcpu_set_in_spin_loop(vcpu, false);
 	kvm_vcpu_set_dy_eligible(vcpu, false);
-	vcpu->preempted = false;
-	vcpu->ready = false;
-	preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);
 	vcpu->last_used_slot = NULL;
 
 	vcpu->plane_level = 0;
@@ -3927,7 +3930,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_halt);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 {
 	if (__kvm_vcpu_wake_up(vcpu)) {
-		WRITE_ONCE(vcpu->ready, true);
+		WRITE_ONCE(vcpu->common->ready, true);
 		++vcpu->stat.generic.halt_wakeup;
 		return true;
 	}
@@ -4580,9 +4583,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 
 			put_pid(oldpid);
 		}
-		vcpu->wants_to_run = !READ_ONCE(vcpu->run->immediate_exit__unsafe);
+		vcpu->common->wants_to_run = !READ_ONCE(vcpu->run->immediate_exit__unsafe);
 		r = kvm_arch_vcpu_ioctl_run(vcpu);
-		vcpu->wants_to_run = false;
+		vcpu->common->wants_to_run = false;
 
 		/*
 		 * FIXME: Remove this hack once all KVM architectures
@@ -6488,36 +6491,36 @@ static void kvm_init_debug(void)
 }
 
 static inline
-struct kvm_vcpu *preempt_notifier_to_vcpu(struct preempt_notifier *pn)
+struct kvm_vcpu_common *preempt_notifier_to_vcpu_common(struct preempt_notifier *pn)
 {
-	return container_of(pn, struct kvm_vcpu, preempt_notifier);
+	return container_of(pn, struct kvm_vcpu_common, preempt_notifier);
 }
 
 static void kvm_sched_in(struct preempt_notifier *pn, int cpu)
 {
-	struct kvm_vcpu *vcpu = preempt_notifier_to_vcpu(pn);
+	struct kvm_vcpu_common *common = preempt_notifier_to_vcpu_common(pn);
 
-	WRITE_ONCE(vcpu->preempted, false);
-	WRITE_ONCE(vcpu->ready, false);
+	WRITE_ONCE(common->preempted, false);
+	WRITE_ONCE(common->ready, false);
 
-	__this_cpu_write(kvm_running_vcpu, vcpu->common);
-	kvm_arch_vcpu_load(vcpu, cpu);
+	__this_cpu_write(kvm_running_vcpu, common);
+	kvm_arch_vcpu_load(common->current_vcpu, cpu);
 
-	WRITE_ONCE(vcpu->scheduled_out, false);
+	WRITE_ONCE(common->scheduled_out, false);
 }
 
 static void kvm_sched_out(struct preempt_notifier *pn,
 			  struct task_struct *next)
 {
-	struct kvm_vcpu *vcpu = preempt_notifier_to_vcpu(pn);
+	struct kvm_vcpu_common *common = preempt_notifier_to_vcpu_common(pn);
 
-	WRITE_ONCE(vcpu->scheduled_out, true);
+	WRITE_ONCE(common->scheduled_out, true);
 
-	if (task_is_runnable(current) && kvm_vcpu_wants_to_run(vcpu)) {
-		WRITE_ONCE(vcpu->preempted, true);
-		WRITE_ONCE(vcpu->ready, true);
+	if (task_is_runnable(current) && common->wants_to_run) {
+		WRITE_ONCE(common->preempted, true);
+		WRITE_ONCE(common->ready, true);
 	}
-	kvm_arch_vcpu_put(vcpu);
+	kvm_arch_vcpu_put(common->current_vcpu);
 	__this_cpu_write(kvm_running_vcpu, NULL);
 }
 
-- 
2.53.0


