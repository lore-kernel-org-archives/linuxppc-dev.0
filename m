Return-Path: <linuxppc-dev+bounces-22254-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B8BCD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:56:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4z1xssz3f5L;
	Tue, 09 Jun 2026 00:52:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930368;
	cv=none; b=VeXn+A4BvyFJ4ubH/FVyDzgZX8n3i8WzBcVBQvYpJaWc8VVVEnebHlLR+vuSmKGQL7mJ/NZCbqr90RiIdvgEhAE5PL7jjKpk69NTFVg+UC2lYarpg5rN9N3WaXXTW0P/M3MSUg5s/Elb+XmBQOU9dQ10EQ/m+xIpNzdhBGHGcQEPnvDd0fMc/u1MopqoNJFrg6iUbqTW0NxX5IFE/ooAddEJoJHXXR9H9Dg8PCXTech7g38VO+/Kz3ShmR8+YBzl0UMI+KHjZAmMHwRu8OTnrSCB883B3lI/XJQa+NPyGAuqQJSlirTR6rh8CrRBUC92v+rzsdT8uZw874DMFclVog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930368; c=relaxed/relaxed;
	bh=iFIbHwWWO2LhYSD26nC22ENp+hQzYklv2ZwxGebaksc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4oxjjO7XRm7/A16nOY9XmQybJGDJRjrfuyvX8cLfh/ggfHfRj3bMoRFHIfvnOVfFGiV9eGgwFofso+jDflIb4YnbND7fm3DIfUeOe3hUEmsbnedZD1XQK4/cvjZsbm21+5i4jRkJYzNTIYPf5lZ/f5f7/UAC88eRUI5Pbqovfir7W/j8Dc0ZG+NjoLXACqGmcCagGv4wTcHzG5ruOq6XVTI2PioanITKoB3ii7T1tVFGau789SZXOSpVYKY9XwVtVmtQpTk2o2ABtrYt0OJsGIiHSZWIRNux3ZOPOhqRTXgspeVzVx40I9InNKXq5qFwi+S4lLFU6C/HIxS3OBBqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4b0cVSz3cYG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:31 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9229F2028C6;
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
Subject: [PATCH 35/60] kvm: Add VCPU plane-scheduling state and helpers
Date: Mon,  8 Jun 2026 16:42:27 +0200
Message-ID: <20260608144252.351443-36-joro@8bytes.org>
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

The algorithm is to always run the lowest runnable plane. Plane
switches are done by stopping the current plane and setting another
runnable.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h | 16 ++++++++++++++
 virt/kvm/kvm_main.c      | 45 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5c3f9dfa15ea..e3611e6cc3e4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -168,6 +168,7 @@ static inline bool kvm_is_error_gpa(gpa_t gpa)
 #define KVM_REQ_VM_DEAD			(1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_UNBLOCK			2
 #define KVM_REQ_DIRTY_RING_SOFT_FULL	3
+#define KVM_REQ_PLANE_RESCHED		4
 #define KVM_REQUEST_ARCH_BASE		8
 
 /*
@@ -324,6 +325,8 @@ struct kvm_mmio_fragment {
 	unsigned int len;
 };
 
+
+
 struct kvm_vcpu_common {
 	struct kvm *kvm;
 
@@ -381,6 +384,8 @@ struct kvm_vcpu_common {
 
 	struct kvm_dirty_ring dirty_ring;
 
+	bool plane_switch;
+
 	struct kvm_vcpu_arch_common arch;
 };
 
@@ -388,6 +393,12 @@ struct kvm_vcpu_common {
 	for ((i) = 0; (i) < KVM_MAX_PLANES; ++(i))		\
 		if (((v) = common->vcpus[(i)]) != NULL)
 
+/* Tracked per plane-VCPU - used for deciding which plane-vcpu to run */
+enum kvm_vcpu_state {
+	STOPPED,
+	RUNNABLE,
+};
+
 struct kvm_vcpu {
 	struct kvm *kvm;
 	struct kvm_plane *plane;
@@ -401,6 +412,7 @@ struct kvm_vcpu {
 	struct kvm_run *run;
 
 	u64 plane_requests;
+	enum kvm_vcpu_state plane_state;
 
 	/* S390 only */
 	bool valid_wakeup;
@@ -440,6 +452,10 @@ struct kvm_vcpu {
 	unsigned plane_level;
 };
 
+void kvm_vcpu_set_plane_runnable(struct kvm_vcpu *vcpu);
+void kvm_vcpu_set_plane_stopped(struct kvm_vcpu *vcpu);
+struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu);
+
 static inline bool kvm_vcpu_wants_to_run(struct kvm_vcpu *vcpu)
 {
 	return vcpu->common->wants_to_run;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9d30fd85ce5f..a30123b77112 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4397,6 +4397,7 @@ static int kvm_plane_ioctl_create_vcpu(struct kvm_plane *plane, unsigned long id
 	vcpu->vcpu_idx = vcpu->common->vcpu_idx;
 	vcpu->plane = plane;
 	vcpu->plane_level = plane->level;
+	vcpu->plane_state = STOPPED;
 	vcpu->run = vcpu->common->run;
 
 	kvm_vcpu_init(vcpu, kvm, id);
@@ -4938,6 +4939,50 @@ static struct file_operations kvm_plane_fops = {
 	KVM_COMPAT(kvm_plane_ioctl),
 };
 
+void kvm_vcpu_set_plane_runnable(struct kvm_vcpu *vcpu)
+{
+	vcpu->plane_state = RUNNABLE;
+	vcpu->common->plane_switch = true;
+	kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_set_plane_runnable);
+
+void kvm_vcpu_set_plane_stopped(struct kvm_vcpu *vcpu)
+{
+	vcpu->plane_state = STOPPED;
+	kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_set_plane_stopped);
+
+struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_common *common = vcpu->common;
+	struct kvm_vcpu *ret = NULL;
+	unsigned i;
+
+	for (i = 0; i < KVM_MAX_PLANES; i++) {
+		if (common->vcpus[i] == NULL)
+			continue;
+
+		if (common->vcpus[i]->plane_state == RUNNABLE) {
+			ret = common->vcpus[i];
+			break;
+		}
+	}
+
+	if (ret == NULL) {
+		ret = common->vcpus[0];
+		ret->plane_state = RUNNABLE;
+	}
+
+	common->current_vcpu = ret;
+
+	common->plane_switch = false;
+
+	return ret;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_select_plane);
+
 static int kvm_device_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct kvm_device *dev = filp->private_data;
-- 
2.53.0


