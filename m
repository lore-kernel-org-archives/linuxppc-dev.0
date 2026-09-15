Return-Path: <linuxppc-dev+bounces-27345-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14CFC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:34:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkfzp4fLSz30Vs;
	Tue, 15 Sep 2026 21:33:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472038;
	cv=none; b=IrIvCacNnrGZ2Kt2IxlcKzAfAD1abG8iU/aW6Dt9zjhO0VTbXNOi9H7Xk9MfLpYIG7fvJp1CuvBLgZ0b0fUMXiNe6CTg8HP8Wp9k2H/vufc/ik39ZeZ1uvrUoZElU0vHqqjiwPatC34srSOck2wdcIZ3Suvl9t5srZrCFF4GiNgRKPIG9vk6SF2WuotYQch9EpiW82yMUArCrpET2YpvvjxP10zHffMNS3ozNCP2/OaNDMy83J4DX3i2cJNRMa/N0szG2bNuYEkcrsQTl1WBU5G0xazDwxNCqMeBwPYqxAda0yvtnoPku9sqW5MQeU260p6cPe9e4B+q5I2AO11BBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472038; c=relaxed/relaxed;
	bh=mbTaUTx0F+8Yd8wvmtUsGd49oHWKxWwv7CwFTyLjhec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRixjpEL0eBW3zJymGVs2gRfyjvMVQMirL9DffnQX4HfiVzOIouEZG4iqrqVDlERnRljiJYiowzZnp7aqATsGNmzrVz9BlWriiSn16W7RD7Mr2sUAvi+mKmHfJ2OuzS5U3dvloXjPQymDKOHI5bHlUpo8ZUL4EAZCxfwi0MhIk5PI1/iLMxlo19qYt4HRqOctJpEqwCeXaynM9AR0jNdD0NZ+d0SN9RPFdOoT/tG+frIT2DQ/SMNk4ttq0jebqnwnVCe1l/uwq34yimwUbTUUBrngxLKYOcoN5+o+FKgspeSL4OK1/mRr62vC7o85oucgyY2f+WaPw19vx2rJYCRrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlpWXuFj; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlpWXuFj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkfzn2Sj2z2yqd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:33:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 579D2600D1;
	Tue, 15 Sep 2026 11:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01081F000FF;
	Tue, 15 Sep 2026 11:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472034;
	bh=mbTaUTx0F+8Yd8wvmtUsGd49oHWKxWwv7CwFTyLjhec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KlpWXuFj0+jdehVdQRW9dTm9BsasJoCQHq4y714jucc2LKezn+Raj3o0ioX232wqM
	 jhHvMuhWUpiDNoQEY8ZOItiHHjXIh3EJ4lYCmA5rI9RGISwFKPW38moaoO3+dsZ0aK
	 HShijMbdV4vAKfbEdZN7JwWHJCH9KbWrPxcDpTVAS0WUv3FhYQrUmcvC9ARRSnSa7u
	 Ca768uVHlWEAIo6sTG8e8Q1xpvU8CLuiq6NSrBvgzzER0wYqMt62L865asuebsmyIW
	 I7PEM9/+fxn9Mvp/KBLnfVW338UGGCg59dyrovq5duqMA/k5+J43h20hfjg0v7DEBj
	 Nim9gww77JPsw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:06 +0200
Subject: [PATCH RFC POC 20/50] file: warn when the descriptor table is
 unshared with slots
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-20-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=brauner@kernel.org;
 h=from:subject:message-id; bh=G9FG2jHFipdUrRTGsnorEbb5m5RZUr4ZNfIJ8EYrZNY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Klt0PSve+Zwt2WPgtbjy2r2c+q+Ga6c6JRtXJz8V
 7d7s9uBjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkk9TEybK8Ujbgr9+l9SPar
 Xzk+r7k8K/PX8z83lr3l0RmsOXPvPIb/xe7Pwk1X1l5rbbs/0/NrxfS1XTYnq53m69hY7lW8vLu
 CBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

If the fdtable is unshared or the task exits we can't install
reservations. The reserved fd isn't reserved anymore. execve() would
leak the reservation into the child.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c     | 3 +++
 kernel/fork.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 745f6eb5279e..1aa0f7b99fc3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1159,6 +1159,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	io_uring_task_cancel();
 
+	/* A prepared descriptor would be installed into the new program. */
+	VFS_WARN_ON_ONCE(me->fd_slots.nr);
+
 	/* Ensure the files table is not shared. */
 	retval = unshare_files();
 	if (retval)
diff --git a/kernel/fork.c b/kernel/fork.c
index 59c5cfa3e482..bd0e1e85abb0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3217,6 +3217,8 @@ static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp
 
 	if ((unshare_flags & CLONE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
+		/* Prepared descriptors live in the table we are about to leave. */
+		VFS_WARN_ON_ONCE(current->fd_slots.nr);
 		fd = dup_fd(fd, NULL);
 		if (IS_ERR(fd))
 			return PTR_ERR(fd);

-- 
2.53.0


