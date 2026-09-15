Return-Path: <linuxppc-dev+bounces-27369-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A74C982C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkg3N5Vrtz30Sx;
	Tue, 15 Sep 2026 21:37:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472224;
	cv=none; b=glAnkSrjb8FKNoi5gzFivgc6PINhLGgS0PwdQJL3pajh545bFTNxXYUKVHblKaIY7coJakCtmbHWtvt2CQ2iRMV9BxtCQj0KewX1q3GSy1ePq3px9VpR1Vwnd1xLXC/qsQx/g21Nr+BfEohbUoBlHUyvoPqKI0JTvO7PhJEovQfIGn0F+Z7Be38XJkeXTfN1qY8a4xJVQMnk1Xcz8LMXtd6J4a0cOfw3mbUiu0gwsczB3ksFWd/NVMP/D/5dA+zkTSkK5Fb1PCopMrdVWASGhW2NIzSmuAARIyJ1xN0+wWQZKXtSc+t0qdWbjrey3N7LUco9bx5bSury9I30jsktkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472224; c=relaxed/relaxed;
	bh=vNAyMtfXPrvlDMBwu/W4OdplmCeF+Bx8YXtsYm6LQAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2O82qtSTfAUjTetTu2nqUE8WGEDFql9infEWCZWwo5YUx07A2+9+XZM2LJ/kWVH6OLwC433XsO+9NiU96plepFNozrTnQgL4XhaDryTD3tEs9OBsuVUHbDBsJqDzg1bETpaUGEIl63/oHbK2ot9GMC/YUFQyO/D/LE5XiB649Q0OCaUr+5PjHmB2GyEqS3vrFhBgBeG45TGcIeuxcKrLBxpKQ1wDTBeFwZKYaBilCqkogcY+3iW+q2uB4TsAn39rC57znhvik1d+Q8UuUNanRCAGmxLHvK5Fp/GzAcmESDAIhaa/X2/Zu0vYouLrXPwWp4zOR+/J15zuRNXfnrzrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJcbb+ve; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJcbb+ve;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkg3M5tljz30RT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:37:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EE8EE600D1;
	Tue, 15 Sep 2026 11:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C811F00893;
	Tue, 15 Sep 2026 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472221;
	bh=vNAyMtfXPrvlDMBwu/W4OdplmCeF+Bx8YXtsYm6LQAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hJcbb+ve+d0nQ+lyOtzlz+UYbr/gC7seiGRVtM9hr3qhRy0SP4rtTxf+61fJV6HZZ
	 LW8RS1sK7opxRgNB4vdONobXBpXD+8GA3HqD2ByRAw16fqkTwu9j8tnAJddGmb7PLP
	 uAm06SirtIHb9CCSMDYGUJRVhcFsQ8v4/IdM2Y5J83ZMffAgWUfRu60wVT+I3rLxob
	 Mi3XVumaSCaqqvXwhpB/3c9gXctwqH2urcLOWEF/YPHWIZ1DoeXtnc71XLjr6mUjdh
	 GfPZGsugN7/T7eQDGipHgpsCZ2aT0QgMaxK1TaXJWBPrJ+seh1rFblIFb7+Y//Ecs/
	 SAX3DixdA32jQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:30 +0200
Subject: [PATCH RFC POC 44/50] drm/etnaviv: install the out-fence
 descriptor when the ioctl returns
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-44-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WG8U461FL48WyesDf7+OQN8njA3nXiC/HvwYW8sZuPs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Km/q3LcYfWGcx8fpJwoLZDaNd0oa+00ldguK1cb6
 asTWTUPdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEn5Hhf8CmHl/lhwWpt/aY
 /5Pr3xCoq1J+5FT33kNKDsks7ZtPZjMy7JT6oyr93P+B4L/VWRcU9j8zmrNg9ut3r3TNptlZWIi
 5MgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index 1a77a09b3377..174f1d66d9ad 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -420,7 +420,7 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct etnaviv_gpu *gpu;
 	struct sync_file *sync_file = NULL;
 	struct ww_acquire_ctx ticket;
-	int out_fence_fd = -1;
+	const struct fd_slot *out_fence_fd = NULL;
 	struct pid *pid = get_pid(task_pid(current));
 	void *stream;
 	int ret;
@@ -504,9 +504,9 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 	}
 
 	if (args->flags & ETNA_SUBMIT_FENCE_FD_OUT) {
-		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
-		if (out_fence_fd < 0) {
-			ret = out_fence_fd;
+		out_fence_fd = fd_prepare(O_CLOEXEC);
+		if (IS_ERR(out_fence_fd)) {
+			ret = PTR_ERR(out_fence_fd);
 			goto err_submit_cmds;
 		}
 	}
@@ -607,10 +607,10 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 			 */
 			goto err_submit_put;
 		}
-		fd_install(out_fence_fd, sync_file->file);
+		fd_stage(out_fence_fd, sync_file->file);
 	}
 
-	args->fence_fd = out_fence_fd;
+	args->fence_fd = out_fence_fd ? fd_prepare_fd(out_fence_fd) : -1;
 	args->fence = submit->out_fence_id;
 
 err_submit_job:
@@ -623,8 +623,6 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 	ww_acquire_fini(&ticket);
 
 err_submit_cmds:
-	if (ret && (out_fence_fd >= 0))
-		put_unused_fd(out_fence_fd);
 	kvfree(stream);
 	kvfree(bos);
 	kvfree(relocs);

-- 
2.53.0


