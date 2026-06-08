Return-Path: <linuxppc-dev+bounces-22231-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEB5CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:54:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4Z6r9cz3cY7;
	Tue, 09 Jun 2026 00:52:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930350;
	cv=none; b=R0yvdeWmx6QS+H/FvLsiSssGc4iHLhDl6gG+wWpCHtG8oPlW+ogVIZIlVXs/9pzplxmnqgVmBqSyV/xfODlnOrPeeygFP3spPdk8kPAR2G7yRTL4Re+C0EZ9BW9CtaaDLWRzXtqus+iyPyPHCPNyIF7M69lN5zO4lUKBoFYmlY7J+VaQjLksBOQQR2rFQOTBBLJ1yRLEQvoV/7LgY+T+Te3yGZNqx4uCNvgksjNQpo8Q27pj5s20ChyLi9vTiaxLD4z+ISCxfPDQk3MRXabVgBmgv7H6GDnLn/epS7/OEbZ2xjhkgrc1SW5TPI0P7knubYQZtu61D0KkDvgap0A1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930350; c=relaxed/relaxed;
	bh=sm5Nes0CBHSHzrIXDQYXiFAfxGVdcZUPLZZ4Ymn3KuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxNzTVKb0l4x/f/8VPDxDh6JIOBEiG835pLYl3RqN5gfwtWzh1O/WOI6j02S8jBtneHh6aQYnDnLkvWbH4QqPShmxx7lBlg+iuCEuLm51zxmrRVLmDb640Z2QHTqcADH9OTW+HstBE2sFqhinfWvLNuiXtDXGZEdP6eTPTrtchK1UR4g6UHWpRUvKekCkIcx/q+20GL9wOBH9K5Of+fmAH/F0l4E3RKhspxF4MSTJD3SeDsLQmpm7yc7oxsQlDt4HHJmurgPDt3ivmySiVqYYieEsk4piIRUfkhneJl5kPWnESePpRhWTZwhXa34jISs97gV6V5Se8N/1olieqUgNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4P6g55z3c2l
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:21 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4CB882028C0;
	Mon,  8 Jun 2026 16:43:11 +0200 (CEST)
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
Subject: [PATCH 29/60] kvm: Implement KVM_CREATE_PLANE ioctl
Date: Mon,  8 Jun 2026 16:42:21 +0200
Message-ID: <20260608144252.351443-30-joro@8bytes.org>
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

Add a new VM ioctl to create a new plane. It returns a new file
descriptor which supports per-plane ioctls.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/uapi/linux/kvm.h |  2 ++
 virt/kvm/kvm_main.c      | 75 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 813f964a6dc1..24e34b8e4819 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1355,6 +1355,8 @@ struct kvm_s390_keyop {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
+#define KVM_CREATE_PLANE	  _IO(KVMIO, 0xe4)
+
 /*
  * ioctls for vcpu fds
  */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5a0277e2ac7c..03a44ff62f0f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4843,6 +4843,34 @@ static long kvm_vcpu_compat_ioctl(struct file *filp,
 }
 #endif
 
+static long kvm_plane_ioctl(struct file *filp, unsigned int ioctl,
+			    unsigned long arg)
+{
+	struct kvm_plane *plane = filp->private_data;
+
+	if (plane->kvm->mm != current->mm || plane->kvm->vm_dead)
+		return -EIO;
+
+	switch (ioctl) {
+	default:
+		return -ENOTTY;
+	}
+}
+
+static int kvm_plane_release(struct inode *inode, struct file *filp)
+{
+	struct kvm_plane *plane = filp->private_data;
+
+	kvm_put_kvm(plane->kvm);
+	return 0;
+}
+
+static struct file_operations kvm_plane_fops = {
+	.unlocked_ioctl = kvm_plane_ioctl,
+	.release = kvm_plane_release,
+	KVM_COMPAT(kvm_plane_ioctl),
+};
+
 static int kvm_device_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct kvm_device *dev = filp->private_data;
@@ -5288,6 +5316,49 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
 	return fd;
 }
 
+static int kvm_vm_ioctl_create_plane(struct kvm *kvm, unsigned id)
+{
+	struct kvm_plane *plane;
+	struct file *file;
+	int r, fd;
+
+	if (id >= kvm_arch_max_planes(kvm) ||
+	    WARN_ON_ONCE(id >= KVM_MAX_PLANES))
+		return -EINVAL;
+
+	guard(mutex)(&kvm->lock);
+	if (kvm->planes[id])
+		return -EEXIST;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+
+	plane = kvm_create_plane(kvm, id);
+	if (!plane) {
+		r = -ENOMEM;
+		goto put_fd;
+	}
+
+	kvm_get_kvm(kvm);
+	file = anon_inode_getfile("kvm-plane", &kvm_plane_fops, plane, O_RDWR);
+	if (IS_ERR(file)) {
+		r = PTR_ERR(file);
+		goto put_kvm;
+	}
+
+	fd_install(fd, file);
+	return fd;
+
+put_kvm:
+	kvm_put_kvm(kvm);
+	kvm_destroy_one_plane(plane);
+put_fd:
+	put_unused_fd(fd);
+	return r;
+}
+
+
 #define SANITY_CHECK_MEM_REGION_FIELD(field)					\
 do {										\
 	BUILD_BUG_ON(offsetof(struct kvm_userspace_memory_region, field) !=		\
@@ -5306,6 +5377,9 @@ static long kvm_vm_ioctl(struct file *filp,
 	if (kvm->mm != current->mm || kvm->vm_dead)
 		return -EIO;
 	switch (ioctl) {
+	case KVM_CREATE_PLANE:
+		r = kvm_vm_ioctl_create_plane(kvm, arg);
+		break;
 	case KVM_CREATE_VCPU:
 		r = kvm_vm_ioctl_create_vcpu(kvm, arg);
 		break;
@@ -6676,6 +6750,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	kvm_chardev_ops.owner = module;
 	kvm_vm_fops.owner = module;
 	kvm_vcpu_fops.owner = module;
+	kvm_plane_fops.owner = module;
 	kvm_device_fops.owner = module;
 
 	kvm_preempt_ops.sched_in = kvm_sched_in;
-- 
2.53.0


