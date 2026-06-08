Return-Path: <linuxppc-dev+bounces-22255-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E6FCD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:57:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4z6g4tz3f6l;
	Tue, 09 Jun 2026 00:52:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930368;
	cv=none; b=PHlZJjl0E1TpxNsGFM6TdMqMZTAeugpmWejyQo5fGe03HIzV2RgiC9TdIKe03KBM74lTaS3jzXf/J9oqz5SGW6m2dMzVdlsIgxaNq5LpeiUnzF0OOj1KWCrkZAdhu1FuH8Xuq/DvG4MC/k5q5v5xZrCbm89veBiYx2RDPwNgcKOGiOxGs5LniI/fvbCWtBCYo7MpiYhj2cZqiOktuJ7XWzdwjhd4fKgxnlv0hixHYjRSYBDuLUoUQRZOyTCUvEvvj0M4h7liBtv/sWik7WpIoQF9+JPrBoJ/w63bjDm5uDHbiBtINyoSSebEjt/0PWyeX/8gvpEaIaUD7tg2lsJFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930368; c=relaxed/relaxed;
	bh=STlOpZpwZIlLpyw3d7KR2i06AWJsp1Rt5Zbvp0hyfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqObR86iR0Mbs/THctDjU8CC04EOJdB9MH4+iuNnDRb8dTD8/Qpdvoi/xsGihGh9RFOyx/mdQ41dVURO8vAuPCOBh3/Z5f/3Xgdy/itwLlIiQuZaFnBBtZYkUINpiU3ukbinjGqgc3OKHnPDzXWVuK6aHRUKd/M4E55fsINn3CskY1WAX+CadplnUJJ+CWDn7IQwcc3q2b/8haLzZazBTscplAQeCjpcEkiLbnqvyLicZy4SS8OhAQVh13AX2V6KP2Rb8HjK/jG0bdcA6yqEKCsunR/9iVly/ClWueWaaSTo1yV8TGfGzgCCDPg+U9vuhLFgg8/nhh6OabHebMvTAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4b2sfXz3cYk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:31 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3F1722028C9;
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
Subject: [PATCH 38/60] kvm: Make KVM_SIGNAL_MSI per plane
Date: Mon,  8 Jun 2026 16:42:30 +0200
Message-ID: <20260608144252.351443-39-joro@8bytes.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Allow the KVM_SIGNAL_MSI ioctl for every plane instead of per VM.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h |  2 +-
 virt/kvm/irqchip.c       |  4 ++--
 virt/kvm/kvm_main.c      | 25 ++++++++++++++-----------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index cfb6911d6771..05a10836d92d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2370,7 +2370,7 @@ static inline int kvm_init_irq_routing(struct kvm *kvm)
 
 #endif
 
-int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi);
+int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi, unsigned plane_level);
 
 void kvm_eventfd_init(struct kvm *kvm);
 int kvm_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args);
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 14480d1df4f9..a4fea7d8dde6 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -45,7 +45,7 @@ int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
 	return irq_rt->chip[irqchip][pin];
 }
 
-int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi)
+int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi, unsigned plane_level)
 {
 	struct kvm_kernel_irq_routing_entry route;
 
@@ -57,7 +57,7 @@ int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi)
 	route.msi.data = msi->data;
 	route.msi.flags = msi->flags;
 	route.msi.devid = msi->devid;
-	route.msi.plane_level = 0;
+	route.msi.plane_level = plane_level;
 
 	return kvm_set_msi(&route, kvm, KVM_USERSPACE_IRQ_SOURCE_ID, 1, false);
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a30123b77112..dc59f2f9d405 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4907,6 +4907,17 @@ static long __kvm_plane_ioctl(struct kvm_plane *plane, unsigned int ioctl, unsig
 	case KVM_CREATE_VCPU:
 		r = kvm_plane_ioctl_create_vcpu(plane, arg);
 		break;
+#ifdef CONFIG_HAVE_KVM_MSI
+	case KVM_SIGNAL_MSI: {
+		void __user *argp = (void __user *)arg;
+		struct kvm_msi msi;
+
+		if (copy_from_user(&msi, argp, sizeof(msi)))
+			return -EFAULT;
+		r = kvm_send_userspace_msi(plane->kvm, &msi, plane->level);
+		break;
+	}
+#endif
 	default:
 		r = -ENOTTY;
 	}
@@ -5493,6 +5504,9 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_create_plane(kvm, arg);
 		break;
 	case KVM_CREATE_VCPU:
+#ifdef CONFIG_HAVE_KVM_MSI
+	case KVM_SIGNAL_MSI:
+#endif
 		r = __kvm_plane_ioctl(kvm->planes[0], ioctl, arg);
 		break;
 	case KVM_ENABLE_CAP: {
@@ -5597,17 +5611,6 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_ioeventfd(kvm, &data);
 		break;
 	}
-#ifdef CONFIG_HAVE_KVM_MSI
-	case KVM_SIGNAL_MSI: {
-		struct kvm_msi msi;
-
-		r = -EFAULT;
-		if (copy_from_user(&msi, argp, sizeof(msi)))
-			goto out;
-		r = kvm_send_userspace_msi(kvm, &msi);
-		break;
-	}
-#endif
 #ifdef __KVM_HAVE_IRQ_LINE
 	case KVM_IRQ_LINE_STATUS:
 	case KVM_IRQ_LINE: {
-- 
2.53.0


