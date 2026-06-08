Return-Path: <linuxppc-dev+bounces-22225-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BEDCD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:53:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4V3FRWz3c9j;
	Tue, 09 Jun 2026 00:52:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930345;
	cv=none; b=YhbquhH8Y6dn1SShgUVnZdu+9X11W1zsCgzDiKU2+nVoUVtF5ziNsH4thBPdt2c1DVo+7Bw7I2xMipbcBkGQEFFk26X65C9WDz7AvjlqSKPZ17kONLzk1MOPCQHwrs+1TA7+xLlnKZP5/9pWtgRcMAGpyoE0fMOQoUDbGo8e6q6ktpLd98ofJLtyKVxmYMw+vXTgiEgTqT4tAGMGftMo/l2FhDcd7RPIMzFYFBviJ3+DaPW8SZaOyIQKcdvbiCJYhOWtDnI3AwerixseUC0HmksDutpmYHjxU7S5xdW8svzdyTial3Z2ajJRCoVbcRnv2O5lI5EnvjftB4DuDpwg9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930345; c=relaxed/relaxed;
	bh=My5MLwjyzAqnp4jO971RL3doflqPg87miFqNXGSw5vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpxOf5iOLYhYapvE+etLUoKaQhqAz4KYtbFMb+gH9HYmVFKl/JqFVUAE473xJZTPuxXKwC8vRqDHB7FsNcUnUleP4Rhpah4RlysqMrQI77tcpRTdQUuVwkbhoJXlEeZlkUc6+RD2lgdOgzxyFxvimUOux50TQFyYggiCl5CFuJI3G6+0ATZv7JXBotGfbnIcf4mPCz9WLlT+6Fm3vWfR6BSDgLLiTWi5lLtN5w9uR0bUBexowOZheVQ//iePEXT0hn3yrvIk94Jq7O4bnLS0uOIOvTXo6EQKztV6eB2RCecLX/EjDqofcDumnJVQNwSsEgvpn3o/WRgiLzUTYkbo4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4L67wZz3bxR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:18 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E5D642028B5;
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
Subject: [PATCH 18/60] kvm: Move kvm_vcpu->rcuwait to struct kvm_vcpu_common
Date: Mon,  8 Jun 2026 16:42:10 +0200
Message-ID: <20260608144252.351443-19-joro@8bytes.org>
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

The rcuwait member is used to block and wake a VCPU thread. Since all
plane VCPUs share a thread, there must only be a single wait object.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/loongarch/kvm/timer.c | 2 +-
 arch/mips/kvm/mips.c       | 4 ++--
 include/linux/kvm_host.h   | 9 +++++----
 virt/kvm/kvm_main.c        | 7 ++++---
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index 8356fce0043f..9da10aa90558 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -31,7 +31,7 @@ enum hrtimer_restart kvm_swtimer_wakeup(struct hrtimer *timer)
 
 	vcpu = container_of(timer, struct kvm_vcpu, arch.swtimer);
 	kvm_queue_irq(vcpu, INT_TI);
-	rcuwait_wake_up(&vcpu->wait);
+	rcuwait_wake_up(kvm_arch_vcpu_get_wait(vcpu));
 
 	return HRTIMER_NORESTART;
 }
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index f928ba105104..6469ec246dd6 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -265,7 +265,7 @@ static enum hrtimer_restart kvm_mips_comparecount_wakeup(struct hrtimer *timer)
 	kvm_mips_callbacks->queue_timer_int(vcpu);
 
 	vcpu->arch.wait = 0;
-	rcuwait_wake_up(&vcpu->wait);
+	rcuwait_wake_up(kvm_arch_vcpu_get_wait(vcpu));
 
 	return kvm_mips_count_timeout(vcpu);
 }
@@ -507,7 +507,7 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
 
 	dvcpu->arch.wait = 0;
 
-	rcuwait_wake_up(&dvcpu->wait);
+	rcuwait_wake_up(kvm_arch_vcpu_get_wait(dvcpu));
 
 	return 0;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c8085c23e18e..c08ede1cefd2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -337,6 +337,10 @@ struct kvm_vcpu_common {
 #endif
 	struct mutex mutex;
 
+#ifndef __KVM_HAVE_ARCH_WQP
+	struct rcuwait wait;
+#endif
+
 	/* Scheduling state */
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	struct preempt_notifier preempt_notifier;
@@ -361,9 +365,6 @@ struct kvm_vcpu {
 
 	struct kvm_run *run;
 
-#ifndef __KVM_HAVE_ARCH_WQP
-	struct rcuwait wait;
-#endif
 	struct pid *pid;
 	rwlock_t pid_lock;
 	int sigset_active;
@@ -1806,7 +1807,7 @@ static inline struct rcuwait *kvm_arch_vcpu_get_wait(struct kvm_vcpu *vcpu)
 #ifdef __KVM_HAVE_ARCH_WQP
 	return vcpu->arch.waitp;
 #else
-	return &vcpu->wait;
+	return &vcpu->common->wait;
 #endif
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9accca10c249..11e0d4af82df 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -468,6 +468,10 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 
 	mutex_init(&common->mutex);
 
+#ifndef __KVM_HAVE_ARCH_WQP
+	rcuwait_init(&common->wait);
+#endif
+
 	common->kvm = kvm;
 	common->current_vcpu = vcpu;
 
@@ -508,9 +512,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	vcpu->vcpu_id = id;
 	vcpu->pid = NULL;
 	rwlock_init(&vcpu->pid_lock);
-#ifndef __KVM_HAVE_ARCH_WQP
-	rcuwait_init(&vcpu->wait);
-#endif
 	kvm_async_pf_vcpu_init(vcpu);
 
 	kvm_vcpu_set_in_spin_loop(vcpu, false);
-- 
2.53.0


