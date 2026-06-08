Return-Path: <linuxppc-dev+bounces-22257-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28009CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:56:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw503HHWz3f7V;
	Tue, 09 Jun 2026 00:52:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930371;
	cv=none; b=OyvLI2XEDEpAgI/Mf46G7BR1ywLW57qfXZAM+ACSUyCSzRAmCtFNSnm41q5mQGbaeNEdnqOKPQPThnnrU0vFO3P8c4/4JJJwW0UE9xU2kM7gEnBKQ6N6ZGoULY6b+jjtrcfkp/zm+m4H+2Wg85JVZ9i2v/r+DEVPag9dQkzmDUQ0o7m5qPKwXuAJlCTMjGPlQ6nyIN+Gn4WAYQPW2fDZ+xEKLHCEJZ1bQny16uEtHF6TWmMdLFrqI2xqMbB7Ngc/dWbIxz1vY1ZB4bx4s6EKuanVlB4fBb7NYNkP60tuuTwwX1GxabsF5zMo8n9FRW9tr5PrU0gM9lF7f9B8H9SvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930371; c=relaxed/relaxed;
	bh=qhXIZn2iNOpxOTHTwlYy27ejC1w4zAgv6hKbWt9T82E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duHEZ9mf6ny1qsyyCOMy0aE6bIHZY9s46SkZvVpafAYASSN6+3bUVmxdlcRTbgg/azJqhWhOlnHBLsOkgQceylR8qlYBQu4xbeQyCcrG/8ve+Nu8vCAocWmH+YYezRPaP5YGx4LX85p0vh3YGUr3CtushQ29oXaI5tgNaXF6sTvVQm4iTiyl69S/S4M8s0+dzqWTSoEz+BTYtjnKUQJcbHOW+QO+4NkJSUDAie/8vP/7VgIXhErZw50hVUgdJxjT5EE6CAUcKvm1O9dYyZb/jfy565INba5NT9nBlRaWtZ/h2KXaNGGQAWM2PRi008CYsCgT195GVoTWABNl8ySDRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4h13Y5z3d8N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:35 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C4D122028C7;
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
Subject: [PATCH 36/60] kvm: Add plane_level to kvm_kernel_irq_routing_entry
Date: Mon,  8 Jun 2026 16:42:28 +0200
Message-ID: <20260608144252.351443-37-joro@8bytes.org>
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

Track the target plane-level of MSI irqs in struct
kvm_kernel_irq_routing_entry. This will be used to send MSI IRQs to
the right plane-level once planes are supported.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/arm64/kvm/vgic/vgic-irqfd.c | 1 +
 arch/loongarch/kvm/irqfd.c       | 1 +
 arch/powerpc/kvm/mpic.c          | 1 +
 arch/riscv/kvm/vm.c              | 1 +
 arch/x86/kvm/irq.c               | 1 +
 include/linux/kvm_host.h         | 1 +
 virt/kvm/irqchip.c               | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-irqfd.c b/arch/arm64/kvm/vgic/vgic-irqfd.c
index b9b86e3a6c86..479b896c8954 100644
--- a/arch/arm64/kvm/vgic/vgic-irqfd.c
+++ b/arch/arm64/kvm/vgic/vgic-irqfd.c
@@ -57,6 +57,7 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->msi.data = ue->u.msi.data;
 		e->msi.flags = ue->flags;
 		e->msi.devid = ue->u.msi.devid;
+		e->msi.plane_level = 0;
 		break;
 	default:
 		goto out;
diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
index f4f953b22419..50f0c32df46c 100644
--- a/arch/loongarch/kvm/irqfd.c
+++ b/arch/loongarch/kvm/irqfd.c
@@ -60,6 +60,7 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->msi.address_lo = ue->u.msi.address_lo;
 		e->msi.address_hi = ue->u.msi.address_hi;
 		e->msi.data = ue->u.msi.data;
+		e->msi.plane_level = 0;
 		return 0;
 	default:
 		return -EINVAL;
diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 3070f36d9fb8..0f568f5fff8b 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -1841,6 +1841,7 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->msi.address_lo = ue->u.msi.address_lo;
 		e->msi.address_hi = ue->u.msi.address_hi;
 		e->msi.data = ue->u.msi.data;
+		e->msi.plane_level = 0;
 		break;
 	default:
 		goto out;
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index a9f083feeb76..f518247e699b 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -138,6 +138,7 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->msi.data = ue->u.msi.data;
 		e->msi.flags = ue->flags;
 		e->msi.devid = ue->u.msi.devid;
+		e->msi.plane_level = 0;
 		break;
 	default:
 		goto out;
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 9519fec09ee6..b7e08eddb765 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -332,6 +332,7 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->msi.address_lo = ue->u.msi.address_lo;
 		e->msi.address_hi = ue->u.msi.address_hi;
 		e->msi.data = ue->u.msi.data;
+		e->msi.plane_level = 0;
 
 		if (kvm_msi_route_invalid(kvm, e))
 			return -EINVAL;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e3611e6cc3e4..16dcca3132d3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -782,6 +782,7 @@ struct kvm_kernel_irq_routing_entry {
 			u32 data;
 			u32 flags;
 			u32 devid;
+			unsigned plane_level;
 		} msi;
 		struct kvm_s390_adapter_int adapter;
 		struct kvm_hv_sint hv_sint;
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 462c70621247..ae47e56176f1 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -57,6 +57,7 @@ int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi)
 	route.msi.data = msi->data;
 	route.msi.flags = msi->flags;
 	route.msi.devid = msi->devid;
+	route.msi.plane_level = 0;
 
 	return kvm_set_msi(&route, kvm, KVM_USERSPACE_IRQ_SOURCE_ID, 1, false);
 }
-- 
2.53.0


