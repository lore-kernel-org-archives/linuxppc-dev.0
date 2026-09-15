Return-Path: <linuxppc-dev+bounces-27356-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71074C88E7F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:35:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkg1P4XBdz3bV5;
	Tue, 15 Sep 2026 21:35:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472121;
	cv=none; b=DRwOI78o7osrDSDClkXKo4ryViyDGAospibo20W01F3ADUEu8HtBatLEief0F21x+FjrUXSWrou0TFw+moS6/gvGodAJCn7pz+7+Q+1cJ8kE9Ojvv2xO9aK+mFH7gBU1BXa34JfFj+NRohG7I+7MSgPGKAVldiruCJdUeYX8Jn7WANjDZ88h2uXk/n82KRoq5pUM5p5HnXezjnk8JaYEbu8eiHRdWzbIoMhonPTmSnA++6kBgDR92NT6WU9emotrUbpndlY4Rh/HztGfGAtPWGww4F0Y4CcNBiUXEeFOkGwV9TuUeYl4tihqhl/4XMO79cYCok+D35EhST7YefsULg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472121; c=relaxed/relaxed;
	bh=vu/oKxz+arn92APs3M7qiv06zwHfUu2cH5sFUjT3DBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMwyEJ1jNnwmel5jX9V7ag+XH2kd2PJOGvPg7QSL1qjMBIKRp9kLOoJueEXFUiypvXzWXVYfppP4wQ/Z5+R1BOACJ4DfhnBqPYn8bB98VLUBpStok8dC/kUqfcvq259VQ7bYogW4N0zzRgGciyrs34t0eYAAAqcetmiGR4cmdPnt29Qilsb9gu64HJaoD0pthZTcPZyn5fRJn+wVDwGzW/IHFklrFgfYiAHehnKmteJKe0X2XouXywYvp15eatONmnowlo7Y4LXPzulIWEP13ufdFrEbp2Tf0K0DQI3qeQ9+yhkO8tVKpvfm6Wjp3S0CWbqvo8/yrwUQpR/Y/KG7XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrkMpIvO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrkMpIvO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkg1N5dQFz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:35:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2F5DC415D0;
	Tue, 15 Sep 2026 11:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A641F0089B;
	Tue, 15 Sep 2026 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472119;
	bh=vu/oKxz+arn92APs3M7qiv06zwHfUu2cH5sFUjT3DBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HrkMpIvO7iGYskIOyxgrnhbmY51Jc8Ub7q4Why0AOMW3f+ydbKbSBCxy95zXyqe1p
	 ZoAv51UkkYKpcZYTAAisBxBl4hf6Uv+KmnEvtmEszCrFQ4UCX6prXJTwvfuh+VBg0H
	 KsE2Brv2yI+jIip82JC/Ngr+3NzDrIw2sFwoF22lMvLiCLY/9/fGutyOhJmWBoHQ0r
	 N5tgRdT+HEy2DU7RimgNlnfIOmMDcup/G0VPUdWrNxwZPN/IikW4sEG5zmO1gaEX/J
	 VgppH76C/4vJ+axoPp1uwZD0v634hBDcqupR0UFuTNRHu80xxaX7JAyL6dF7YCetWD
	 6h8T6BgsJ0X2A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:17 +0200
Subject: [PATCH RFC POC 31/50] vfio: install the migration data descriptor
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-31-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZuarGRo5ZqIHA3hh6zA1izPVcZ2LCwhC5SlPF3ZepH0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kkzvf951a0G+ZqpXSZ3J2/arrxG/8r9+aez1z9K9
 bjIVK2r1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRLQaMDBeN9d/bKs4OXXDx
 gkR+xafcmPCqbumzYcILTbl2Jzp0VTP8YspvytbQP3uhP99bqOslw97nz5UieFd43hf6lsB++8w
 DdgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/vfio/vfio_main.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 423ead48aafe..93d9d21f4074 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -903,28 +903,17 @@ EXPORT_SYMBOL_GPL(vfio_mig_get_next_state);
 static int vfio_ioct_mig_return_fd(struct file *filp, void __user *arg,
 				   struct vfio_device_feature_mig_state *mig)
 {
-	int ret;
-	int fd;
+	FD_PREPARE(fdf, O_CLOEXEC, filp);
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
-		goto out_fput;
+	if (IS_ERR(fdf)) {
+		fput(filp);
+		return PTR_ERR(fdf);
 	}
 
-	mig->data_fd = fd;
-	if (copy_to_user(arg, mig, sizeof(*mig))) {
-		ret = -EFAULT;
-		goto out_put_unused;
-	}
-	fd_install(fd, filp);
+	mig->data_fd = fd_prepare_fd(fdf);
+	if (copy_to_user(arg, mig, sizeof(*mig)))
+		return -EFAULT;
 	return 0;
-
-out_put_unused:
-	put_unused_fd(fd);
-out_fput:
-	fput(filp);
-	return ret;
 }
 
 static int

-- 
2.53.0


