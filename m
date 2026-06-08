Return-Path: <linuxppc-dev+bounces-22212-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69F2CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:52:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4G2VNtz3bsP;
	Tue, 09 Jun 2026 00:52:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930334;
	cv=none; b=kARrnvnDTllbVKwo4bJ3S311Dh/vyE6GVSOWVc1/ocmSkv2kreixJwo+hNPxGoMKyYigAcm2hcx4tblxczlor9hBpnshkMWoy9g0srY/e0081zxGPezJ5LVfrTNP0IZzRgyDJZ9jo5z+mEoWozHULNUKEKBxTy6pkei62OdJWJBD9fyZswTcvsR6Su+CtYIpTDX22Z2rxnztgHbqQ9VN8FiqtQ11r9PBOJwfveIYx+RnM+cJ5dHbM8/do7c0y3VrGxn2MXjrgI7v8ADGL8IgP7eFfL8Q794Xa1AQc4P1kQueCKZXVwhFsv8JfaWxK84MZtU/VaaQrb3+0Ol+2T20qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930334; c=relaxed/relaxed;
	bh=OA/Qd+jF0Q1QozMre9m+KdODkx0ma/FNTcWiPF5Ir44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjHNyGUcGbm0pDoCTRcXAs+TLr7sU7Qcd9/z5soBDuMlaKTOFpigPANjer0n6PdCNnO4pQZBDjRgowxa6kiDPRp4g8ANhBljoFVWEvSAEdvbzqIhX/pPQwXtWKlif0pzIjMe3aVafs/crbUG6kwy5BZO4vH84w0ViqyL15z6wBmf9zQy+em01riYAs3meBeI/orG1EyFt0Ql6B0LofPV5CzngzkEKdAq4RcIIZbfL79KAQOK8BYPBhVOxlsv/2xDt9Jizqa9YQvgAEe2VaTSY4PUwmr48uzakxI91DfOr6Og5+Nu/yfDScapWr42f00968bi2YOMLm0CAvRiy3HLUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw483R2gz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:07 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7319F2028CA;
	Mon,  8 Jun 2026 16:43:13 +0200 (CEST)
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
Subject: [PATCH 39/60] kvm: Make KVM_SET_GSI_ROUTING per plane
Date: Mon,  8 Jun 2026 16:42:31 +0200
Message-ID: <20260608144252.351443-40-joro@8bytes.org>
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

Allow the KVM_SET_GSI_ROUTING on each plane. There is still only one
GSI routing table maintained per VM by the KVM module, the plane this
IOCTL was last issued at will get all GSI interrupts.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/arm64/kvm/vgic/vgic-irqfd.c  |  2 +-
 arch/loongarch/kvm/intc/pch_pic.c |  2 +-
 arch/powerpc/kvm/mpic.c           |  2 +-
 arch/riscv/kvm/vm.c               |  2 +-
 arch/x86/kvm/irq.c                |  2 +-
 include/linux/kvm_host.h          |  3 +-
 virt/kvm/irqchip.c                | 10 +++--
 virt/kvm/kvm_main.c               | 62 +++++++++++++++----------------
 8 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-irqfd.c b/arch/arm64/kvm/vgic/vgic-irqfd.c
index 53e5fcc591d7..96981dd29a6e 100644
--- a/arch/arm64/kvm/vgic/vgic-irqfd.c
+++ b/arch/arm64/kvm/vgic/vgic-irqfd.c
@@ -153,7 +153,7 @@ int kvm_vgic_setup_default_irq_routing(struct kvm *kvm)
 		entries[i].u.irqchip.irqchip = 0;
 		entries[i].u.irqchip.pin = i;
 	}
-	ret = kvm_set_irq_routing(kvm, entries, nr, 0);
+	ret = kvm_set_irq_routing(kvm, entries, nr, 0, 0);
 	kfree(entries);
 	return ret;
 }
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index aa0ed59ae8cf..a0d04ffa8a71 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -423,7 +423,7 @@ static int kvm_setup_default_irq_routing(struct kvm *kvm)
 		entries[i].u.irqchip.irqchip = 0;
 		entries[i].u.irqchip.pin = i;
 	}
-	ret = kvm_set_irq_routing(kvm, entries, nr, 0);
+	ret = kvm_set_irq_routing(kvm, entries, nr, 0, 0);
 	kfree(entries);
 
 	return ret;
diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 6b6eba7fbf75..1e493179ee4f 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -1646,7 +1646,7 @@ static int mpic_set_default_irq_routing(struct openpic *opp)
 	if (!routing)
 		return -ENOMEM;
 
-	kvm_set_irq_routing(opp->kvm, routing, 0, 0);
+	kvm_set_irq_routing(opp->kvm, routing, 0, 0, 0);
 
 	kfree(routing);
 	return 0;
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 6b3c8a0e74e2..bd9ab3240e4f 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -105,7 +105,7 @@ int kvm_riscv_setup_default_irq_routing(struct kvm *kvm, u32 lines)
 		ents[i].u.irqchip.irqchip = 0;
 		ents[i].u.irqchip.pin = i;
 	}
-	rc = kvm_set_irq_routing(kvm, ents, lines, 0);
+	rc = kvm_set_irq_routing(kvm, ents, lines, 0, 0);
 	kfree(ents);
 
 	return rc;
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index d2ecfd54d57a..90e2d2db2123 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -576,7 +576,7 @@ static const struct kvm_irq_routing_entry default_routing[] = {
 int kvm_setup_default_ioapic_and_pic_routing(struct kvm *kvm)
 {
 	return kvm_set_irq_routing(kvm, default_routing,
-				   ARRAY_SIZE(default_routing), 0);
+				   ARRAY_SIZE(default_routing), 0, 0);
 }
 
 int kvm_vm_ioctl_get_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 05a10836d92d..3b62fb354267 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2351,7 +2351,8 @@ bool kvm_arch_can_set_irq_routing(struct kvm *kvm);
 int kvm_set_irq_routing(struct kvm *kvm,
 			const struct kvm_irq_routing_entry *entries,
 			unsigned nr,
-			unsigned flags);
+			unsigned flags,
+			unsigned plane_level);
 int kvm_init_irq_routing(struct kvm *kvm);
 int kvm_set_routing_entry(struct kvm *kvm,
 			  struct kvm_kernel_irq_routing_entry *e,
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index a4fea7d8dde6..e0793ae0c719 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -128,7 +128,8 @@ void kvm_free_irq_routing(struct kvm *kvm)
 static int setup_routing_entry(struct kvm *kvm,
 			       struct kvm_irq_routing_table *rt,
 			       struct kvm_kernel_irq_routing_entry *e,
-			       const struct kvm_irq_routing_entry *ue)
+			       const struct kvm_irq_routing_entry *ue,
+			       unsigned plane_level)
 {
 	struct kvm_kernel_irq_routing_entry *ei;
 	int r;
@@ -146,7 +147,7 @@ static int setup_routing_entry(struct kvm *kvm,
 
 	e->gsi = gsi;
 	e->type = ue->type;
-	r = kvm_set_routing_entry(kvm, e, ue, 0);
+	r = kvm_set_routing_entry(kvm, e, ue, plane_level);
 	if (r)
 		return r;
 	if (e->type == KVM_IRQ_ROUTING_IRQCHIP)
@@ -169,7 +170,8 @@ bool __weak kvm_arch_can_set_irq_routing(struct kvm *kvm)
 int kvm_set_irq_routing(struct kvm *kvm,
 			const struct kvm_irq_routing_entry *ue,
 			unsigned nr,
-			unsigned flags)
+			unsigned flags,
+			unsigned plane_level)
 {
 	struct kvm_irq_routing_table *new, *old;
 	struct kvm_kernel_irq_routing_entry *e;
@@ -210,7 +212,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
 				goto free_entry;
 			break;
 		}
-		r = setup_routing_entry(kvm, new, e, ue);
+		r = setup_routing_entry(kvm, new, e, ue, plane_level);
 		if (r)
 			goto free_entry;
 		++ue;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dc59f2f9d405..a6d7601c3412 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4918,6 +4918,34 @@ static long __kvm_plane_ioctl(struct kvm_plane *plane, unsigned int ioctl, unsig
 		break;
 	}
 #endif
+#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
+	case KVM_SET_GSI_ROUTING: {
+		void __user *argp = (void __user *)arg;
+		struct kvm_irq_routing routing;
+		struct kvm_irq_routing __user *urouting;
+		struct kvm_irq_routing_entry *entries = NULL;
+
+		if (copy_from_user(&routing, argp, sizeof(routing)))
+			return -EFAULT;
+		if (!kvm_arch_can_set_irq_routing(plane->kvm) ||
+		    routing.nr > KVM_MAX_IRQ_ROUTES ||
+		    routing.flags)
+			return -EINVAL;
+		if (routing.nr) {
+			urouting = argp;
+			entries = vmemdup_array_user(urouting->entries,
+						     routing.nr, sizeof(*entries));
+			if (IS_ERR(entries)) {
+				r = PTR_ERR(entries);
+				return r;
+			}
+		}
+		r = kvm_set_irq_routing(plane->kvm, entries, routing.nr,
+					routing.flags, plane->level);
+		kvfree(entries);
+		break;
+	}
+#endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
 	default:
 		r = -ENOTTY;
 	}
@@ -5506,6 +5534,9 @@ static long kvm_vm_ioctl(struct file *filp,
 	case KVM_CREATE_VCPU:
 #ifdef CONFIG_HAVE_KVM_MSI
 	case KVM_SIGNAL_MSI:
+#endif
+#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
+	case KVM_SET_GSI_ROUTING:
 #endif
 		r = __kvm_plane_ioctl(kvm->planes[0], ioctl, arg);
 		break;
@@ -5635,37 +5666,6 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif
-#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
-	case KVM_SET_GSI_ROUTING: {
-		struct kvm_irq_routing routing;
-		struct kvm_irq_routing __user *urouting;
-		struct kvm_irq_routing_entry *entries = NULL;
-
-		r = -EFAULT;
-		if (copy_from_user(&routing, argp, sizeof(routing)))
-			goto out;
-		r = -EINVAL;
-		if (!kvm_arch_can_set_irq_routing(kvm))
-			goto out;
-		if (routing.nr > KVM_MAX_IRQ_ROUTES)
-			goto out;
-		if (routing.flags)
-			goto out;
-		if (routing.nr) {
-			urouting = argp;
-			entries = vmemdup_array_user(urouting->entries,
-						     routing.nr, sizeof(*entries));
-			if (IS_ERR(entries)) {
-				r = PTR_ERR(entries);
-				goto out;
-			}
-		}
-		r = kvm_set_irq_routing(kvm, entries, routing.nr,
-					routing.flags);
-		kvfree(entries);
-		break;
-	}
-#endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 	case KVM_SET_MEMORY_ATTRIBUTES: {
 		struct kvm_memory_attributes attrs;
-- 
2.53.0


