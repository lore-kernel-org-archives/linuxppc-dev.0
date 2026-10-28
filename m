Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD0606BFA5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FcBhlI49
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFGwD47VPz30Qv;
	Thu, 29 Oct 2026 06:03:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::546"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793214188;
	cv=none; b=R2o6fFCiJqS2uquXXH7CqI3VGQxl+nqAyxry+bbRzxbW0FNe0BPYGNFqpHtEjxQcPDglJP+HjmijqcBpGp3UHyeHYwq6BLYZed2oMtSw/nPtRWN/4pF9k1LqQxVHOGj4owa7FXP98jgVZSFCYbCLD3RH5cbxKcYke23paEf9W65w5344oXe7ldSXZbds4GMdfr0Te0/ItiJz10iTnQOwWn0LW+b+pUsKWtX4qsicYuvQHWesfYh1Gncro2IrSImFN0P6ysDoNNTeJSJ6iIvmk93hvzn7tXPVBIMqnYbF8Iy0hDje6aHCJcarGUb4iIn0/Cf2gSygOClMzBqd0nJ+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793214188; c=relaxed/relaxed;
	bh=kQihi39MSjxZBPCKWC1v+KxEdPYKoJ3DWZvMHVb+Z7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DR3NQ60J3XjcXfejjwRojfN8GL66wZU21Fu9miorIt/fysl5NlkO+UwSPfLgXENuGBKwyE1oJ+HMjV7X1zq5O0aKbeXYraUoKFD76JqRcJmy47zJe0MuxgiZ0AgMWxAriFF44h7xA0QA8WF7oX+Hly1WRQdAqjPWcW3HxMyp2wkxowi/WR5B8Jt2T2DarQW0Pv36xZFzAUn1ke8KRS5MxnHrXTWnOXytzkhzhFANJxAPvXFg622+JpOK31uCBCVk+O653EbjwZF40NyISq+1MbQWpZ0b0UTbgW9YZ2S2IdBzMF1G4QVSwiNo0vN7UkeIw0GXN//FCqU9/wPIbQQptA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FcBhlI49; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com; envelope-from=36ubiagykdf4oa6jf8ckkcha.8kihejqtll8-9arheopo.kvh67o.knc@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FcBhlI49;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com; envelope-from=36ubiagykdf4oa6jf8ckkcha.8kihejqtll8-9arheopo.kvh67o.knc@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com [IPv6:2607:f8b0:4864:20::546])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFGwC601Pz30FP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 06:03:07 +1100 (AEDT)
Received: by mail-pg1-x546.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso1431747a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 12:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214186; x=1793818986; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kQihi39MSjxZBPCKWC1v+KxEdPYKoJ3DWZvMHVb+Z7E=;
        b=FcBhlI49Ai9vxgXeISXipy0ZwWKIVkBRShdKQx4DeUvIbiXQpnc5ucQfmJd5BN2KLC
         3t4XU2nWMSvHV9dnSFPy7EjhtmQ0hsYaBx7AQGiJx8r/lepjvjwZIYyd3BpVLLjuMTu6
         3NGCvngbRzob5Bea/e6lXQfr9Y6E07xmx3KNEcYTa9fvbIWVpl7cA6JOcA3RupE3XchG
         MQtK15EznfqXSZreJSKIoIojpGqnxpWFtdv3HpjLc7W294Z339Wlch2uuGXNqomdAS+v
         uSrFGP/WA5+23E/yQnSvL1mEsi0MlIqEJKtixhySHsgtBUcDS7Y0gO6sdE8zTdTvtJDJ
         R6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214186; x=1793818986;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kQihi39MSjxZBPCKWC1v+KxEdPYKoJ3DWZvMHVb+Z7E=;
        b=y/sKRo2AZPAGupW6OMS1dgjnXd1Q4+guIgDKy/3JDwp+qiI6d9xZwus2OxDNpyXUcH
         pIIdH2ChZBCDnWZwr+XRdtiAJ4zGSN1C9M8NW36OJj3HzVzA2VWl3PaD6fHqEs/mjLJ6
         MicTXzs3elByFn4Dw5lFCZ0jVcbhJ9qDrm5Dw1gbIAiWuu5q+15vtUM9J8tXfNvOQcz8
         +wg+fLps1pXMcaI8Wzn/j6gM69sOJxU7bBOWSmSUc+knlVHzGt+/JmL3/v1TkJz1+3T3
         C8JQknPBazlCJEQiTVfwfJuDyN5cefV412y37rRLLLKI+em1Fcl2oUDgxIoWRugaRahY
         N41Q==
X-Forwarded-Encrypted: i=1; AKwUvBzV1Wq3AqeIYQkyL5IJbEnxg6d39Ow3IN621URdYuyVieRs+BUBq0Y8KQRfvHeeNuLm3R1vAbDGkrs/NYs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK0EKF/gJkz4qRGVXDFkFggwZCftHg9FiULWJ2P/Uh9bVT+UQON
	UIOhwvAa2PT0zx9vTruZQ+vdju36x6vLANqEcnoI3R+36CYqOY0mhSbShFXPi1CwyfJNWaeHdZX
	hNiijFQ==
X-Received: from pgx20.prod.google.com ([2002:a63:1754:0:b0:cd4:ef82:4e33])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a120:b0:3e1:5816:8749
 with SMTP id adf61e73a8af0-3e9023eda44mr2865201637.38.1793214185450; Wed, 28
 Oct 2026 12:03:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:55 -0700
In-Reply-To: <20261028190259.1819571-1-seanjc@google.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261028190259.1819571-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028190259.1819571-4-seanjc@google.com>
Subject: [PATCH 3/7] KVM: PPC: Explicitly force IPIs when directly kicking vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Explicitly force an IPI when invoking kvm_vcpu_kick() directly instead of
relying on kvm_arch_vcpu_should_kick() to unconditionally return 1/true.
This will allow dropping kvm_arch_vcpu_should_kick() in favor of
kvm_request_needs_ipi().

No functional change intended (1 || 1 == true).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/include/asm/kvm_ppc.h | 13 ++++++++++++-
 arch/powerpc/kvm/book3s.c          |  4 ++--
 arch/powerpc/kvm/book3s_pr.c       |  2 +-
 arch/powerpc/kvm/booke.c           |  6 +++---
 arch/powerpc/kvm/e500_emulate.c    |  2 +-
 arch/powerpc/kvm/powerpc.c         |  2 +-
 6 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 169ea6a7fbad..bbe7378ad0ef 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -30,6 +30,17 @@
 #endif
 #include <asm/inst.h>
 
+/*
+ * TODO: For unknown reasons, KVM PPC has historically ignored vcpu->mode when
+ *       determining if kicking a vCPU needs an IPI.  Either document why that
+ *       behavior is necessary, or drop this helper and the @force param from
+ *       __kvm_vcpu_kick().
+ */
+static inline void kvmppc_vcpu_kick(struct kvm_vcpu *vcpu)
+{
+	__kvm_vcpu_kick(vcpu, false, true);
+}
+
 /*
  * KVMPPC_INST_SW_BREAKPOINT is debug Instruction
  * for supporting software breakpoint.
@@ -598,7 +609,7 @@ static inline void kvmppc_clear_host_ipi(int cpu)
 
 static inline void kvmppc_fast_vcpu_kick(struct kvm_vcpu *vcpu)
 {
-	kvm_vcpu_kick(vcpu);
+	kvmppc_vcpu_kick(vcpu);
 }
 
 static inline bool kvm_hv_mode_active(void)		{ return false; }
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 2efbe05caed7..dce53c5a3868 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -260,7 +260,7 @@ void kvmppc_core_queue_external(struct kvm_vcpu *vcpu,
 	 * external interrupts for the guest just before entering
 	 * the guest.  That is OK even if userspace did do a
 	 * KVM_INTERRUPT_SET on a pseries guest vcpu, because the
-	 * caller (kvm_vcpu_ioctl_interrupt) does a kvm_vcpu_kick()
+	 * caller (kvm_vcpu_ioctl_interrupt) does a kvmppc_vcpu_kick()
 	 * which ends up doing a smp_send_reschedule(), which will
 	 * pull the guest all the way out to the host, meaning that
 	 * we will call kvmppc_core_prepare_to_enter() before entering
@@ -827,7 +827,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 void kvmppc_decrementer_func(struct kvm_vcpu *vcpu)
 {
 	kvmppc_core_queue_dec(vcpu);
-	kvm_vcpu_kick(vcpu);
+	kvmppc_vcpu_kick(vcpu);
 }
 
 int kvmppc_core_vcpu_create(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index ecfb88bf6464..1894968f2c25 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -2066,7 +2066,7 @@ static struct kvmppc_ops kvm_ops_pr = {
 	.emulate_op = kvmppc_core_emulate_op_pr,
 	.emulate_mtspr = kvmppc_core_emulate_mtspr_pr,
 	.emulate_mfspr = kvmppc_core_emulate_mfspr_pr,
-	.fast_vcpu_kick = kvm_vcpu_kick,
+	.fast_vcpu_kick = kvmppc_vcpu_kick,
 	.arch_vm_ioctl  = kvm_arch_vm_ioctl_pr,
 #ifdef CONFIG_PPC_BOOK3S_64
 	.hcall_implemented = kvmppc_hcall_impl_pr,
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 13ad4cf5fa71..fd7f24a68b31 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -650,7 +650,7 @@ static void kvmppc_watchdog_func(struct timer_list *t)
 	if (new_tsr & TSR_WIS) {
 		smp_wmb();
 		kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
-		kvm_vcpu_kick(vcpu);
+		kvmppc_vcpu_kick(vcpu);
 	}
 
 	/*
@@ -661,7 +661,7 @@ static void kvmppc_watchdog_func(struct timer_list *t)
 	    vcpu->arch.watchdog_enabled) {
 		smp_wmb();
 		kvm_make_request(KVM_REQ_WATCHDOG, vcpu);
-		kvm_vcpu_kick(vcpu);
+		kvmppc_vcpu_kick(vcpu);
 	}
 
 	/*
@@ -1872,7 +1872,7 @@ void kvmppc_set_tsr_bits(struct kvm_vcpu *vcpu, u32 tsr_bits)
 	set_bits(tsr_bits, &vcpu->arch.tsr);
 	smp_wmb();
 	kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
-	kvm_vcpu_kick(vcpu);
+	kvmppc_vcpu_kick(vcpu);
 }
 
 void kvmppc_clr_tsr_bits(struct kvm_vcpu *vcpu, u32 tsr_bits)
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 051102d50c31..10cd6b4ab456 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -75,7 +75,7 @@ static int kvmppc_e500_emul_msgsnd(struct kvm_vcpu *vcpu, int rb)
 		int cpir = cvcpu->arch.shared->pir;
 		if ((param & PPC_DBELL_MSG_BRDCAST) || (cpir == pir)) {
 			set_bit(prio, &cvcpu->arch.pending_exceptions);
-			kvm_vcpu_kick(cvcpu);
+			kvmppc_vcpu_kick(cvcpu);
 		}
 	}
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..09c94b849185 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1903,7 +1903,7 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
 
 	kvmppc_core_queue_external(vcpu, irq);
 
-	kvm_vcpu_kick(vcpu);
+	kvmppc_vcpu_kick(vcpu);
 
 	return 0;
 }
-- 
2.56.0.313.g2479322e68-goog


