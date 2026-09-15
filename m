Return-Path: <linuxppc-dev+bounces-27362-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D736CC88E7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:36:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkg2J6TFbz3bbW;
	Tue, 15 Sep 2026 21:36:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472168;
	cv=none; b=GmMPTWN4pHTczrcc+g4wyFwUKg9N4m8CyKvmvQyUnR/KieI5yVJoCsnN6J3iL0OV36sgl1ohwi9li9HxNw7zHDVHgBgWdNwr34df/J7nJ7yilsL68BYFEKJWDv40bmsrAOYTq1cg9VxLnmUAuHsPiMiSv2yhvfGEhD/xPeRwFjO35CaBfq9woU5pI8IoDm68DBIAmrBGwPszPvJOtCD2d0ObFvc/oQlgWXdEFDhCumpcgbLcnwPXABGgfIi3gxGp4FLDpQMj0Vyy7lXqVMoApvnh4H9Sw+4YTB5clJKhONwd3/gQgR26pGZEw6amfsBu3VgyQ2wm9ykvKMLxPXDSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472168; c=relaxed/relaxed;
	bh=o2lQ5Ka+5N2KnUU5FmxbFpjzBp5OWSe8vXNiFGVP9wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EEC7uyMxuCYLviadRRWUV9JxUjaxZiP1LMOIxsz2OnWQczjSX+Z/bzVxgqOpqcRj9uL6ZDFg9wj1xMs17dY0Jiw4qiFSJkVmpG75720szqp46LUkAac3K5d4VGwf0h64Dc1GDd3TUkA3v/TY+P4X4I0orFejmYLhTINd4JBMQzdx7eBOxRmn180Z0w82p7a7LuxrDIj2icssNbAYfznVikP+QWt2A3F+7YkDicQrXo7hK5Ir8XnYeswtRacHGcmtVSut54imeVlS90YmHiKTdt/8UVNr7qG7miaB2XLvJ279037MPIVKeGtrkEg/RDD3EfoJKqTpxqhQLhv9LXca3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMJ+b7mB; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMJ+b7mB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkg2J07T2z30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:36:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 807664078B;
	Tue, 15 Sep 2026 11:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA1E1F00898;
	Tue, 15 Sep 2026 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472166;
	bh=o2lQ5Ka+5N2KnUU5FmxbFpjzBp5OWSe8vXNiFGVP9wo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OMJ+b7mBI0Q8O65xdljhCPY3wAhJtYK6vRviUYwoOTOfvpAhVhrNZ1kCsXQAqmv7v
	 3GuPhfOQ15Waw0FL/v7cPGU1CKFB0vIzNSBGpVjd2qBgP1hQ3swVBB0qsd708/I1v5
	 vg/o9z55oXEAHcBz+9R03GejIoqfhheuysEBDKH6SjqNuu/M7QucGgMkPeQdb5GX9n
	 uQNmyO/vVkhVONQwgr/tUv50HwF7x4nXtsyG+xs9H48A8Y+g/iDSD50VrmcEX/KGAo
	 6x7qUbImLs8LGWOMAtx7W/94RYq1+vZrklFF1JGznEjJF5X02jojdwcWqWCWnxH6Bc
	 DQcVPuaGmWDvQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:23 +0200
Subject: [PATCH RFC POC 37/50] tpm: vtpm_proxy: install the server
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-37-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WL6iBvGKSQMcLT8fyxBve2m38vKajd88XKUitLJDfoo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KkLDfGbfS6nzTDW3+CR3ZeWem2mM3pd9c9eC2/x8
 KvW8xPoKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMhPNYb/Ude3PmqXNzFcrfTk
 c5TA/YXTT8zPT3uZ3v9yqU5S93XBRYwM/34c1tN5sX7LjoD5b9gnnuLVilnzKtv7cqb0mf/eLA+
 5+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/char/tpm/tpm_vtpm_proxy.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index b81fd2a537df..8eb87044596a 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -531,8 +531,8 @@ static struct file *vtpm_proxy_create_device(
 				 struct vtpm_proxy_new_dev *vtpm_new_dev)
 {
 	struct proxy_dev *proxy_dev;
-	int rc, fd;
 	struct file *file;
+	int rc;
 
 	if (vtpm_new_dev->flags & ~VTPM_PROXY_FLAGS_ALL)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -544,20 +544,15 @@ static struct file *vtpm_proxy_create_device(
 	proxy_dev->flags = vtpm_new_dev->flags;
 
 	/* setup an anonymous file for the server-side */
-	fd = get_unused_fd_flags(O_RDWR);
-	if (fd < 0) {
-		rc = fd;
+	FD_PREPARE(fdf, O_RDWR,
+		   anon_inode_getfile("[vtpms]", &vtpm_proxy_fops, proxy_dev,
+				      O_RDWR));
+	if (IS_ERR(fdf)) {
+		rc = PTR_ERR(fdf);
 		goto err_delete_proxy_dev;
 	}
+	file = fd_prepare_file(fdf);
 
-	file = anon_inode_getfile("[vtpms]", &vtpm_proxy_fops, proxy_dev,
-				  O_RDWR);
-	if (IS_ERR(file)) {
-		rc = PTR_ERR(file);
-		goto err_put_unused_fd;
-	}
-
-	/* from now on we can unwind with put_unused_fd() + fput() */
 	/* simulate an open() on the server side */
 	vtpm_proxy_fops_open(file);
 
@@ -566,16 +561,13 @@ static struct file *vtpm_proxy_create_device(
 
 	vtpm_proxy_work_start(proxy_dev);
 
-	vtpm_new_dev->fd = fd;
+	vtpm_new_dev->fd = fd_prepare_fd(fdf);
 	vtpm_new_dev->major = MAJOR(proxy_dev->chip->dev.devt);
 	vtpm_new_dev->minor = MINOR(proxy_dev->chip->dev.devt);
 	vtpm_new_dev->tpm_num = proxy_dev->chip->dev_num;
 
 	return file;
 
-err_put_unused_fd:
-	put_unused_fd(fd);
-
 err_delete_proxy_dev:
 	vtpm_proxy_delete_proxy_dev(proxy_dev);
 
@@ -640,13 +632,9 @@ static long vtpmx_ioc_new_dev(struct file *file, unsigned int ioctl,
 		return PTR_ERR(vtpm_file);
 
 	if (copy_to_user(vtpm_new_dev_p, &vtpm_new_dev,
-			 sizeof(vtpm_new_dev))) {
-		put_unused_fd(vtpm_new_dev.fd);
-		fput(vtpm_file);
+			 sizeof(vtpm_new_dev)))
 		return -EFAULT;
-	}
 
-	fd_install(vtpm_new_dev.fd, vtpm_file);
 	return 0;
 }
 

-- 
2.53.0


