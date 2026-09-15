Return-Path: <linuxppc-dev+bounces-27365-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627D6C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkg2n0SNFz3bdQ;
	Tue, 15 Sep 2026 21:36:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472193;
	cv=none; b=mmBnSryZobNyeiMHx4Ajh7m9I5cKyziVbvVnO5MTVcY2YY1bpOLyt9cYyWtLZtRUIN4bV90Wi5cy08Gks2av7dGdR7TKgvJYPC6N1+7UtNqmhqXtEH3Tk3jcS2tfdyiJnk3w7Wjwto06KpBM8w4oF+/3rNsg1/QRGN3AfDSZAfd04cVDnyWKpQeWvcRfEgA4HHlOP3i94cgj89JTmG7J5zAgnurrpcSY9OVOSeKB5dLMNOtteqEtd1HTVm4UvYVHF7d2qRg16XWmSZCU+fgK8qCbZ/3jvNDV/qps/7Mai6HpJYDJL10BuDgcHvqS6xjY7+HzqRJIDE35NW3sLC0YHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472193; c=relaxed/relaxed;
	bh=0ixA4Ace6BJn7IjrzCTCU0/h7/zoW2kue4sGkrY9xCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SC9qoxbfWtj+ey+2SZq/AXNpfLulaGwtecGRU1cLE/f/NKwBgpWpGbKI03ewmCrifrDUTDgmlYouLya+DbSnNIO2A5ReiOaJUDKpmHtzpTm2mL9tMfNZAVHdDJLekb70lfY9L1U6C1s85rD/z1WkLSpKAtXhz6axM/NPRjEKmm6G1ZFOIZcApfdKT8hwn+NZdaIub+eJe7ZtQJx5rjEVpfSVluiMzXSE7vN9CDm+zI5zl6t0oeiSKZ7KtcF0zp1fkXTHQhSxLP8a38FlKwsC09nES+BfTy14GrT9Gt2oFt4jydJ7NEeT9elhMqFS2glML1nmbwdrD/qDVwcBYwt9RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOl8mduH; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOl8mduH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkg2m1WWyz3bcj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:36:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 57141600D1;
	Tue, 15 Sep 2026 11:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A888C1F00898;
	Tue, 15 Sep 2026 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472190;
	bh=0ixA4Ace6BJn7IjrzCTCU0/h7/zoW2kue4sGkrY9xCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JOl8mduHPaeVv3eaq9MEhCqzMicOygBaK5O7Dzp/RHXpO7NODADnSsZqyfqWqEQZR
	 lR/VPeQyWMIddPe1rPhDu05Hlm3nHa5FLkG932tVgVvVmp1QfM/hVE5mMYh+azuISL
	 UmAM+w7jZ6/RT6AK2zvRXbcbWwva8oTaEAofof43ADeJYUXP4l+fKFnPm5nLpARsob
	 2FLL0ErbZn7q0fCeD9rQeCPTtW4yh3QMmMpEVQM39yn4qUnY43PiI3hNDpcRqaUIti
	 KY9m4cCM616bpCnYMsG+DY5wREnfHQo42u9v21mvFC1w6Cr6Wausbj6m5LHNP95jEM
	 Ck7KRCyZ89YTg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:26 +0200
Subject: [PATCH RFC POC 40/50] KVM: stop putting descriptors back on
 failure
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-40-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3135; i=brauner@kernel.org;
 h=from:subject:message-id; bh=78vO7PDsYGy3GJUzt5pCpyZhq20MYXeEqBv9mkCwUOM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KmrZTOP7Ev9FMJVxubVxbdNfUMIq6RooWz7Kg6W0
 u0ly+I7SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJmLaxPC/6MvkYx+dQ5OZjxmx
 1NY+4H3y0sQ15JTH4W0GqkVf38y+wsgwpWTB7u0yUtPOBqdErHHe3P2Vb+cBu4mdx15GLt51wuM
 UCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 virt/kvm/kvm_main.c | 65 +++++++++++++++++------------------------------------
 1 file changed, 21 insertions(+), 44 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..8d3d47a6c98a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4326,27 +4326,18 @@ static const struct file_operations kvm_vcpu_stats_fops = {
 
 static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 {
-	int fd;
-	struct file *file;
 	char name[15 + ITOA_MAX_LEN + 1];
 
 	snprintf(name, sizeof(name), "kvm-vcpu-stats:%d", vcpu->vcpu_id);
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	file = anon_inode_getfile_fmode(name, &kvm_vcpu_stats_fops, vcpu,
-					O_RDONLY, FMODE_PREAD);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
-	}
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile_fmode(name, &kvm_vcpu_stats_fops, vcpu,
+					    O_RDONLY, FMODE_PREAD));
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	kvm_get_kvm(vcpu->kvm);
-	fd_install(fd, file);
-
-	return fd;
+	return fd_prepare_fd(fdf);
 }
 
 #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
@@ -5136,24 +5127,14 @@ static const struct file_operations kvm_vm_stats_fops = {
 
 static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
 {
-	int fd;
-	struct file *file;
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	file = anon_inode_getfile_fmode("kvm-vm-stats",
-			&kvm_vm_stats_fops, kvm, O_RDONLY, FMODE_PREAD);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
-	}
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile_fmode("kvm-vm-stats", &kvm_vm_stats_fops,
+					    kvm, O_RDONLY, FMODE_PREAD));
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	kvm_get_kvm(kvm);
-	fd_install(fd, file);
-
-	return fd;
+	return fd_prepare_fd(fdf);
 }
 
 #define SANITY_CHECK_MEM_REGION_FIELD(field)					\
@@ -5499,21 +5480,20 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
 static int kvm_dev_ioctl_create_vm(unsigned long type)
 {
 	char fdname[ITOA_MAX_LEN + 1];
-	int r, fd;
 	struct kvm *kvm;
 	struct file *file;
+	const struct fd_slot *fd;
+	int r;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
+	fd = fd_prepare(O_CLOEXEC);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
-	snprintf(fdname, sizeof(fdname), "%d", fd);
+	snprintf(fdname, sizeof(fdname), "%d", fd_prepare_fd(fd));
 
 	kvm = kvm_create_vm(type, fdname);
-	if (IS_ERR(kvm)) {
-		r = PTR_ERR(kvm);
-		goto put_fd;
-	}
+	if (IS_ERR(kvm))
+		return PTR_ERR(kvm);
 
 	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
 	if (IS_ERR(file)) {
@@ -5529,13 +5509,10 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 	 */
 	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
 
-	fd_install(fd, file);
-	return fd;
+	return fd_stage(fd, file);
 
 put_kvm:
 	kvm_put_kvm(kvm);
-put_fd:
-	put_unused_fd(fd);
 	return r;
 }
 

-- 
2.53.0


