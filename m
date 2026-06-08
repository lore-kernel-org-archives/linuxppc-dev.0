Return-Path: <linuxppc-dev+bounces-22261-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058A7CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:57:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw5523dFz3fJk;
	Tue, 09 Jun 2026 00:52:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930373;
	cv=none; b=HGej9XJVV8uVc29vwIpvG1l8voNZD+qMDUCd9vQiPD7GNd01gvKuoH4bAFvtfXt6n5+EPomegQ0F6eTFNg0PjmSHBnEe/s/FNO3etD27gyBBjkqqG6cSzUIZLT2aiep4OnNndd/wEVjXl19bNISgwrCkkzrVwRlH44xGlCv+fHMYN/Sj96gNUYQnI9EDMmxjLu0tjCxLLZ592nmN/meDvaHKQLc6IvlGkx2lJlKmKOVOx++8lRJtre4nSXbNGlo7YJIL6AFTxYVNG3vom1sUktfrW5bI6T14RFC3CB/OcizFVWrLZsHl0ogIxgG2xFtvce+tPcEtIl93fPxN8Si5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930373; c=relaxed/relaxed;
	bh=Sqz6oc6V65sByVcNtBRvB28gocilrV2AZxK4TPrvyCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmxdNvE/zjKa+K0ZVFDc81ozEIg+CLIjvI+z0SDW0LKde2n7vtmP6WtFsCnB0tRYrqsX5lXtYvC9uWWlP8pIW8NEktKD8k9MPza6afnenl9QsCXzppSM6Y91iyFpqa+iDAxPQCGjnQ+9rlThezZ/BNFdSAEbUCQmrmMe49ubpmbZ0+/dzl7OiGxlEH+IVq6Rja1x/ulGltczajV3zRVoPiEdEBZwa31Sz4kaIBKNzPEpkRJjaW+hmS1JlAMDClZYUxAACZo6/VwoSp7cyaiDK7rK1ItvwG9y5Vq8zWMe3JtRyJ/e91Sr56jOkWdZFpEEbecT6i6+nNl7TAyETiVp7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4k0FXPz3dJq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:37 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A4CBA2028D9;
	Mon,  8 Jun 2026 16:43:16 +0200 (CEST)
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
Subject: [PATCH 54/60] kvm: x86: Restrict KVM planes support to KVM_IRQCHIP_SPLIT
Date: Mon,  8 Jun 2026 16:42:46 +0200
Message-ID: <20260608144252.351443-55-joro@8bytes.org>
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

The code right now only supports plane-aware IOAPIC IRQ routing for
IRQ-chip in split mode. Enforce that restriction in the KVM x86 code.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/x86.c       | 8 ++++++--
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 5 +++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c6910356b061..0b9fa1059481 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -490,6 +490,10 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_default_max_planes);
 
 unsigned kvm_arch_max_planes(struct kvm *kvm)
 {
+	/* For now, planes are only supported with irqchip=split */
+	if (!irqchip_split(kvm))
+		return 1;
+
 	return kvm_x86_call(max_planes)(kvm);
 }
 
@@ -6833,7 +6837,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if (cap->args[0] > KVM_MAX_IRQ_ROUTES)
 			goto split_irqchip_unlock;
 		r = -EEXIST;
-		if (irqchip_in_kernel(kvm))
+		if (irqchip_in_kernel(kvm) || kvm->has_planes)
 			goto split_irqchip_unlock;
 		if (kvm->created_vcpus)
 			goto split_irqchip_unlock;
@@ -7398,7 +7402,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 			goto create_irqchip_unlock;
 
 		r = -EINVAL;
-		if (kvm->created_vcpus)
+		if (kvm->created_vcpus || kvm->has_planes)
 			goto create_irqchip_unlock;
 
 		r = kvm_pic_init(kvm);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3b62fb354267..dbf81e2520f2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -918,6 +918,7 @@ struct kvm {
 	struct list_head gpc_list;
 
 	struct kvm_plane *planes[KVM_MAX_PLANES];
+	bool has_planes;
 
 	/*
 	 * created_vcpus is protected by kvm->lock, and is incremented
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8f1a16af519a..ff27cdbe8d92 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5477,6 +5477,10 @@ static int kvm_vm_ioctl_create_plane(struct kvm *kvm, unsigned id)
 	    WARN_ON_ONCE(id >= KVM_MAX_PLANES))
 		return -EINVAL;
 
+	/* Planes are only supported with in-kernel IRQ-chip */
+	if (!kvm_arch_irqchip_in_kernel(kvm))
+		return -EINVAL;
+
 	guard(mutex)(&kvm->lock);
 	if (kvm->planes[id])
 		return -EEXIST;
@@ -5498,6 +5502,7 @@ static int kvm_vm_ioctl_create_plane(struct kvm *kvm, unsigned id)
 		goto put_kvm;
 	}
 
+	kvm->has_planes = true;
 	fd_install(fd, file);
 	return fd;
 
-- 
2.53.0


