Return-Path: <linuxppc-dev+bounces-27358-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031F6C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:35:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkg1j2gzkz3bY7;
	Tue, 15 Sep 2026 21:35:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472137;
	cv=none; b=EfBBx8MpFN2Oi+xLDP/x+XMPkbguU1pH6w0DS/UjjJIWB4PHpXeBNkvvlfAlQGgL/ooYHus7/c/R6nxjM8zx6NiToPpWGdH37gKk/FVC2E5oD5zBRGoVhoFXEmcVDy2L4+b7EJ3obcu8a2SrpwHTD14UlkqHVTeUheq5UZ2gdhFG4DW+nURkX52cZGMnhEpHFOHcLbTUBc0Cc4UkYfMT8Phszba/pkfg3cH4RkTs1UlxGg2MceWXRaW4qd5rO/uwJcRkam7ATAWGFa0pzePPHvp82ptCPH9EQsAgmzbZBQrLpBMS39kVzYubDp4A37YjLgS008N5OFwzey+tCy6zkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472137; c=relaxed/relaxed;
	bh=4cyWZY3NqovxpRDY6IE9b0iFSwFNHI0DbK45a85UipQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMQYRF7smI3FwMpXVhZLZZ0rc0KHWBnSAV+zjg59ZRVZLll3HZzJQZsJxoi7EWguJq7LAUDelxR5h9L+pTbMk5yDctJofuzxa0lWfiZ15rWeIaNc7W9VcfaNCFAR6GlZqveFV9767Dp1G1d93EOcPfHF2OHJeFHRcXhj/d8A8Gpqs4je+n6FuRhyz0WM0e9FFuzRMKRs3rv10PMFw/G2yyAcy7SX9/XtN2o/FOJRTy4WpSMWnzYgk4IVSXCjbfUQyGQbjnuhR+XdqBIJfzstpWhIjWU1zuBoGfq4xxYjU/t0HFk1QVseRiiXWuOf//UrmUY1159G61zu907qzpMCKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QShSpSCR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QShSpSCR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkg1h4155z3bX3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:35:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 194BC41253;
	Tue, 15 Sep 2026 11:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855EE1F000FF;
	Tue, 15 Sep 2026 11:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472135;
	bh=4cyWZY3NqovxpRDY6IE9b0iFSwFNHI0DbK45a85UipQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QShSpSCRD6Ol4MQvbWaGFCrC9D2hEvMMsqJVxbgperwaAzfDuHUwR651hhvjbuklD
	 V8TQMFUcMD9eSXSMuyAwgiWFzi0aqbkjT2ga+ukHQTd+ooSqbRR0w+8dklcQllx84s
	 J1vd1rrkg7W2xCcJFOtsGmjuUfysGb2g+4rZjFbqLWmyJ8Yf8Ww523QPYOM4gdlVYe
	 9qjw6VvRm1T5endGkraMKVYh3kIi8DvPoXM1B76VPl1ZetouR5ZWcWZs/UQmu4oEg/
	 QeIQWjAGAMnj1aiLn/FeAtI3+y0er7L+q8OA2u/+KtDir8seIk/RUJip7Wgf4oA2Ys
	 w5GYgWQdLMU4Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:19 +0200
Subject: [PATCH RFC POC 33/50] io_uring/zcrx: install the exported
 descriptor when the request returns
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-33-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g4cMNX/82jJQalDLSwX1Nity2yqjS0J0NiJHAB23CT0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk73H60xLL/uL9c1Ubz66I7n/6tuiXcUVn6/cZhl
 7opP+8pdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk/weG/3mbVB0z75nsf+2g
 kJwuHDdbwrosi1P7+cq1bOytTdFl1gz/Y3eZWfw1evMxy/980nMezqvh6nqrq+2qsnZHrDSbM9O
 WEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 io_uring/zcrx.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 1b3b11405dac..d458c614c765 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -795,8 +795,6 @@ static int zcrx_export(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 		       struct zcrx_ctrl *ctrl, void __user *arg)
 {
 	struct zcrx_ctrl_export *ce = &ctrl->zc_export;
-	struct file *file;
-	int fd;
 
 	if (!mem_is_zero(ce, sizeof(*ce)))
 		return -EINVAL;
@@ -804,27 +802,18 @@ static int zcrx_export(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 	refcount_inc(&ifq->refs);
 	refcount_inc(&ifq->user_refs);
 
-	file = anon_inode_create_getfile("[zcrx]", &zcrx_box_fops,
-					 ifq, O_CLOEXEC, NULL);
-	if (IS_ERR(file)) {
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_create_getfile("[zcrx]", &zcrx_box_fops, ifq,
+					     O_CLOEXEC, NULL));
+	if (IS_ERR(fdf)) {
 		zcrx_unregister(ifq, NULL);
-		return PTR_ERR(file);
-	}
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		fput(file);
-		return fd;
+		return PTR_ERR(fdf);
 	}
 
-	ce->zcrx_fd = fd;
-	if (copy_to_user(arg, ctrl, sizeof(*ctrl))) {
-		fput(file);
-		put_unused_fd(fd);
+	ce->zcrx_fd = fd_prepare_fd(fdf);
+	if (copy_to_user(arg, ctrl, sizeof(*ctrl)))
 		return -EFAULT;
-	}
 
-	fd_install(fd, file);
 	return 0;
 }
 

-- 
2.53.0


