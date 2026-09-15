Return-Path: <linuxppc-dev+bounces-27357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CE9C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:35:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkg1Y2n6Gz30MY;
	Tue, 15 Sep 2026 21:35:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472129;
	cv=none; b=Ga4R4r2t127lx9MWO30zyWNh6R5PK3ngePrLWy2syRrOkhA+umMK6wyvbbEJcDEj+xYwatj3DlzJZHHLO11JUlneIntLDQg+NIbP3gcC/Q8VE3Wkom4bKKFHM4YqoVzGO7RXLscg8r5msm49xgD4lD/Fou5FpNgpiE1BXKz4BJSyuc7bnFNwB7YMu6+ViBREXDcGdFhliNizuWbh2uIs6cs0nrISjLeQOTOPyoqKkKorWRstiDMYO1ET7oaZWOFjf5FewTlw+Bs/sTo8gPpasIc9maG/IQpRuCLSeoKO7x+0BjvrAJDFHasqzv4ej04SHCh5pZuuK3hwVTtHs1QjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472129; c=relaxed/relaxed;
	bh=SiDQySP8IWTYUOdB117br7TNLcvsxWg+xpN5r3cQq6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jTubuPDyAZR8svb7HDFM6564MIhJ+lSjNJwrsx7UJN3Pj5zkr0u3ixsjqhUQ8Sf6E2QQn2zmEgBSBeWbt2wgbinKiZUDl8r05ppfHhyd0Nj3Rj80rDdIwUigs+cdC6AQ3mtnzUjB+lrWlBl/Rj6zN7EfYmSJh5qESAT/uj7ba8OpEtg2VpfaIqzQmHVEO7PFB0mFQD4/HHKUj5jnxxzCr3+ux7F7ETNCDyK7NU1x7V8vZWh4DHNfvhZnUD5daJF9F5WZ+vy/RUZFQOQeVexmeZvQAoCq8wIzKBDk3fCsP0WTcXTFfyVEIpJKcEtwzI8KqSiNS+7oap3yL4c1NpCiUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqYmNccj; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqYmNccj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkg1X4NQwz30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:35:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2303642E75;
	Tue, 15 Sep 2026 11:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863231F00893;
	Tue, 15 Sep 2026 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472127;
	bh=SiDQySP8IWTYUOdB117br7TNLcvsxWg+xpN5r3cQq6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XqYmNccjTCHTgLZfaFkSBqBDFVVBpN4V7uWmro0nlZYhYXdIOR3pUJm31rdV5qmY+
	 IvkQ+yJ07iMIJdVfTfCU/X+J1F85+bUe/IC+GzOLdoIsjHzzI0cRTRkin0A6HJ4e9A
	 wjbY7EF1qh+Lal3EYMMKlHTRwBv+A5nykmakJD+8D67Z72hDwiPvXhqDAFfL92TuNh
	 lR+9tIh+dTMh59L9wRnctKfZHIAF9NgyjZ0E3adVhwso4Hs5jlLy1+Oyk4a8gR0BJY
	 rzlOT3+qL2yuGXywSlb/k0KzE8CbI8Z7lw3SuGIaABfBF2TZ/OabNmu6rvP9iBmcEe
	 3ufAwvnh6Znbw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:18 +0200
Subject: [PATCH RFC POC 32/50] liveupdate: install the session descriptors
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-32-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3361; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B2yzY8WVH9I+iLi4OuPEJenUrd90D6GAB5zasGpbfEQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk7WTbjY/LDc6u2Nl9xvMO+7IG4y7ylT0vafyesW
 7+59X5BSUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEdFwZGQ4ll/MKLt9+yuPv
 Ls73Mh5H/nGs+LpMfK0El6Rj9O4LjyQZGY7rKSdd2rLmmIq27bPU4yUy5+NELr/9Lxu7/vCdBG/
 ZPH4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/liveupdate/luo_core.c    | 48 ++++++++++++-----------------------------
 kernel/liveupdate/luo_session.c | 24 ++++++---------------
 2 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 1b2bda22902d..3899bbf30b53 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -270,61 +270,41 @@ struct luo_device_state {
 static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
 {
 	struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
+	const struct fd_slot *fd;
 	struct file *file;
 	int err;
 
-	argp->fd = get_unused_fd_flags(O_CLOEXEC);
-	if (argp->fd < 0)
-		return argp->fd;
+	fd = fd_prepare(O_CLOEXEC);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	err = luo_session_create(argp->name, &file);
 	if (err)
-		goto err_put_fd;
-
-	err = luo_ucmd_respond(ucmd, sizeof(*argp));
-	if (err)
-		goto err_put_file;
-
-	fd_install(argp->fd, file);
-
-	return 0;
+		return err;
 
-err_put_file:
-	fput(file);
-err_put_fd:
-	put_unused_fd(argp->fd);
+	argp->fd = fd_stage(fd, file);
 
-	return err;
+	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
 static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
 {
 	struct liveupdate_ioctl_retrieve_session *argp = ucmd->cmd;
+	const struct fd_slot *fd;
 	struct file *file;
 	int err;
 
-	argp->fd = get_unused_fd_flags(O_CLOEXEC);
-	if (argp->fd < 0)
-		return argp->fd;
+	fd = fd_prepare(O_CLOEXEC);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	err = luo_session_retrieve(argp->name, &file);
 	if (err < 0)
-		goto err_put_fd;
-
-	err = luo_ucmd_respond(ucmd, sizeof(*argp));
-	if (err)
-		goto err_put_file;
-
-	fd_install(argp->fd, file);
-
-	return 0;
+		return err;
 
-err_put_file:
-	fput(file);
-err_put_fd:
-	put_unused_fd(argp->fd);
+	argp->fd = fd_stage(fd, file);
 
-	return err;
+	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
 static int luo_open(struct inode *inodep, struct file *filep)
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..7de35bad1ede 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -282,33 +282,23 @@ static int luo_session_retrieve_fd(struct luo_session *session,
 				   struct luo_ucmd *ucmd)
 {
 	struct liveupdate_session_retrieve_fd *argp = ucmd->cmd;
+	const struct fd_slot *fd;
 	struct file *file;
 	int err;
 
-	argp->fd = get_unused_fd_flags(O_CLOEXEC);
-	if (argp->fd < 0)
-		return argp->fd;
+	fd = fd_prepare(O_CLOEXEC);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	mutex_lock(&session->mutex);
 	err = luo_retrieve_file(&session->file_set, argp->token, &file);
 	mutex_unlock(&session->mutex);
 	if (err < 0)
-		goto err_put_fd;
-
-	err = luo_ucmd_respond(ucmd, sizeof(*argp));
-	if (err)
-		goto err_put_file;
-
-	fd_install(argp->fd, file);
-
-	return 0;
+		return err;
 
-err_put_file:
-	fput(file);
-err_put_fd:
-	put_unused_fd(argp->fd);
+	argp->fd = fd_stage(fd, file);
 
-	return err;
+	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
 static int luo_session_finish(struct luo_session *session,

-- 
2.53.0


