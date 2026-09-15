Return-Path: <linuxppc-dev+bounces-27353-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086F6C88E7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:35:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkg0y2gtyz30hg;
	Tue, 15 Sep 2026 21:34:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472098;
	cv=none; b=NeIqSZC0J1sL/u19rx/s1Lizl7Wxt4J+eTfrezxnEshXqFIkM/oVi30VGAOOQpXQPk4FjF3nD4aQ+nrnZ5upTXl72hbxADyfcUCTzm3iltD9bcOB+4YWp+Mt4+M7z3hI8iF7zVimWyC7Xzkvq3ia3FDEg8RY8ev/dK8/rq25U8KKEChj53460fkHdgL/1VH13KUPPYf7Qg/fhVfKelqtJRgIeT8UTGoHgzO2MFsPGUWBgdJ2XdorOWzPQ1qhzUZrInlBv+uynFQRqeToC54oo9E/tPD2JjSaKBOIZDqCmYy5RyU8y4jkQgtZdpJ5LmDxT5nCnsnr3e3R+9kWGZ3ewg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472098; c=relaxed/relaxed;
	bh=Cxkt5ZZmGkjFd539Cl9RA+9e8VT0n+2aqKlnDvtva3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cr/KnHu1ske7szWzCblgdaGUhEeqaYO774nFkBna3qtDhwN00ptElFF2fZrdSHW+O2swMbzqILCdshYFPnoyHebMz6KCxRxIThaeFaYax43RL9wEOMVwGsUF8R9o4eo4g6opuRJNF0umefiU+sOAwdNCx0mXK3G06HNh1OyIIz+46D/zxDSiacwv+mHRv3e7bt7tvUy7NWNRafJG6iuG9Afyh82jd9aeZLXmNePXK/gFJc4MyqXCopzJW6j4kV94tpJxL/YK7bdovwpBULxSKEFPd8qvkG3dpe2yztyKHY77Mcj44WPkqbhD3LrGHwV/3r6IquTtpNDKghVo4YGlvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dILdN8rE; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dILdN8rE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkg0x3ZT6z2yqw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:34:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 97AD0600D1;
	Tue, 15 Sep 2026 11:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047041F00893;
	Tue, 15 Sep 2026 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472095;
	bh=Cxkt5ZZmGkjFd539Cl9RA+9e8VT0n+2aqKlnDvtva3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dILdN8rEl6D0AvNs+ADrv4qyz7XFz7x4boFlXmBNHuzp8dsfrNxC3GxAas+GJFMv+
	 KJnK0aX5JPblFXsMNwsHCIlkZII+0cYJLUL4usXBn+tv30sxD+kVeBTY5hcwuU5iTw
	 MXYhBhYyk8HliVAWPS90CFPCshSX6kinnV9G6S3iAxfflAZBj+c9/TE3CiaFW3hDG7
	 dRdxg6OcMTB4GCjwlFFQl9XbyBURQfFnRT9yVIi6yc8yWO4+AzWpSl0LOZwVL0qtIE
	 Rv5L8GTAkHFUQiQIsfVM5d6ZEM2JM2QT8a+Fnw1EggkywbFsnu2tEM8H3ZlrtZibQk
	 qheZhWDLwLoTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:14 +0200
Subject: [PATCH RFC POC 28/50] drm/msm: install the out-fence descriptor
 when the ioctl returns
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-28-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3900; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0aF43DhxqkdJzKcsExOwjxx4MBfkynUOKohe+cP6pHo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KkrWhO2ocr+XsOZ92nMd0VvHVZ7Ky7587iN4qmUy
 EPVDqtUOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZixcnwT519/+ba76oz/vy5
 vmjf+l1Wu2z2blt9XNlWNjDylNSVxs0Mf2WKlse//zVlb82qCaECXSHqTPxv9vQ9tHvbvedgQGZ
 ROgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 22 +++++++++-------------
 drivers/gpu/drm/msm/msm_gem_vma.c    | 22 +++++++++-------------
 2 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 5862db05297a..4ddfd07c1480 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -558,7 +558,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct drm_syncobj **syncobjs_to_reset = NULL;
 	struct sync_file *sync_file = NULL;
 	unsigned cmds_to_parse;
-	int out_fence_fd = -1;
+	const struct fd_slot *out_fence_fd = NULL;
 	unsigned i;
 	int ret;
 
@@ -601,9 +601,9 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	ring = gpu->rb[queue->ring_nr];
 
 	if (args->flags & MSM_SUBMIT_FENCE_FD_OUT) {
-		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
-		if (out_fence_fd < 0) {
-			ret = out_fence_fd;
+		out_fence_fd = fd_prepare(O_CLOEXEC);
+		if (IS_ERR(out_fence_fd)) {
+			ret = PTR_ERR(out_fence_fd);
 			goto out_post_unlock;
 		}
 	}
@@ -777,6 +777,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		sync_file = sync_file_create(submit->user_fence);
 		if (!sync_file)
 			ret = -ENOMEM;
+		else
+			fd_stage(out_fence_fd, sync_file->file);
 	}
 
 	if (ret)
@@ -814,15 +816,9 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 out_unlock:
 	mutex_unlock(&queue->lock);
 out_post_unlock:
-	if (ret) {
-		if (out_fence_fd >= 0)
-			put_unused_fd(out_fence_fd);
-		if (sync_file)
-			fput(sync_file->file);
-	} else if (sync_file) {
-		fd_install(out_fence_fd, sync_file->file);
-		args->fence_fd = out_fence_fd;
-	}
+	/* A staged sync file and its descriptor are dropped on return. */
+	if (!ret && sync_file)
+		args->fence_fd = fd_prepare_fd(out_fence_fd);
 
 	if (!IS_ERR_OR_NULL(submit)) {
 		msm_gem_submit_put(submit);
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index c11d021581e0..77d365566732 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1441,7 +1441,7 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	struct drm_syncobj **syncobjs_to_reset = NULL;
 	struct sync_file *sync_file = NULL;
 	struct dma_fence *fence;
-	int out_fence_fd = -1;
+	const struct fd_slot *out_fence_fd = NULL;
 	int ret, nr_bos = 0;
 	unsigned i;
 
@@ -1479,9 +1479,9 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	}
 
 	if (args->flags & MSM_VM_BIND_FENCE_FD_OUT) {
-		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
-		if (out_fence_fd < 0) {
-			ret = out_fence_fd;
+		out_fence_fd = fd_prepare(O_CLOEXEC);
+		if (IS_ERR(out_fence_fd)) {
+			ret = PTR_ERR(out_fence_fd);
 			goto out_post_unlock;
 		}
 	}
@@ -1565,6 +1565,8 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 		sync_file = sync_file_create(job->fence);
 		if (!sync_file)
 			ret = -ENOMEM;
+		else
+			fd_stage(out_fence_fd, sync_file->file);
 	}
 
 	if (ret)
@@ -1593,15 +1595,9 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 out_unlock:
 	mutex_unlock(&queue->lock);
 out_post_unlock:
-	if (ret) {
-		if (out_fence_fd >= 0)
-			put_unused_fd(out_fence_fd);
-		if (sync_file)
-			fput(sync_file->file);
-	} else if (sync_file) {
-		fd_install(out_fence_fd, sync_file->file);
-		args->fence_fd = out_fence_fd;
-	}
+	/* A staged sync file and its descriptor are dropped on return. */
+	if (!ret && sync_file)
+		args->fence_fd = fd_prepare_fd(out_fence_fd);
 
 	if (!IS_ERR_OR_NULL(job)) {
 		if (ret)

-- 
2.53.0


