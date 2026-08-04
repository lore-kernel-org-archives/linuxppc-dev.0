Return-Path: <linuxppc-dev+bounces-25344-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71953C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:51:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDnM91dVCz2yMl;
	Tue, 04 Aug 2026 18:51:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785833461;
	cv=none; b=GZhOyWcEmEeaDprce/YJE+h20+v4XFZ77aRSdtKwmmDVO6hj2SSp2LsB6XkJT/G9+qNYVOIw5KH2kAIK0e5Twf2NlOPAKslZiZ4UzHLCvYMfj4W0g9h6heI4sSKyf4PS/MUnR52V59C3WafjzPHeg7JtXmh1dsNC6JKzifvangTdal0LlJFbwAHp4886JrUNPohFHCu+9LXaxoSCnOkjEJT3lbgZpN3ocFcBqTKbeL7lQWgGQIkr64oJafsgIApXSAULqldrMzjbz0hs0xhj9RMygKLb1EyKmlxxL/1wh2gdfzVRxXc+bzT4pWS0ju/a7BrEvpWQk0Gggz3TmZ/NCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785833461; c=relaxed/relaxed;
	bh=wGv6yEfNov4UJDeC+LoWBSNb4qG+t5ZUPG1Jws0fRkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LiDXwceP7el0xIwE0hKXyFdgxhb1+MNqh8CjZJ72ASnlIyQWQoR8aewyeQIsiggSsuWXxZ+3omI+XAjcdVj6oXNADa7d4S40/ajoCrJxkF71QsWGBHkgWegzQSlkyJ+eSg6cCykG0cEu39Jjt1EZDsa3+v3Z09z120bkfybWXefvw378CUde4kWg58z/p8H7g8woE0WYdHbTp+pyfv24SWFVbTQbFrxShzIpND8FXU5Ve20kdyTjQHWuaRiLtXs9mUmcu9aiEODtTg3g//HUgDwprMcbO8UdGLyTaVZ8deH7C4uEJPIgnyUhZsxNJvFtoQsrwchNptd0C3pc6do29Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P19dTpF7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P19dTpF7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDnM80qLxz3bSw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 18:50:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0E6D64406C;
	Tue,  4 Aug 2026 08:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6633C4AF0B;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785833454;
	bh=ZtasH00Gtaye4COuWzJy5xkppQxUaxhZHuqL8IELU2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P19dTpF7mG9EBb0xjFnTTHMB2aaC+L7oaIAlFAN18QkFPqaCLB6hQQwBIuF7MJOEm
	 3Us7m/CEjeIUDLTTOSl7odszxI7wWiuJlLQLcZ9wEb9XEWgyKz9Crx+tXMxPHM7g4i
	 CfHaENDIYJtjmG9C6SIt0k8vea+anxq460I1FjW4zof49JnMIoAM7bNfsHJFjO5fG9
	 dIg75ZBzJl1pttY1aHxqy7h7GxNNMB9oqYJctO5idhaDGUItWvMxKeI7gJTHW6Q1PR
	 jOQ6vgvyM7uPgTc/FZY8kagR+cAYXdyln3Z7BfecdEG3Qp6SWg2z9zaElJ7KJS8mol
	 H9RR8TNc1SShA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46AFC5518F;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 04 Aug 2026 16:50:42 +0800
Subject: [PATCH v2 5/5] powerpc/spufs: don't hold state_mutex during user
 access
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
Message-Id: <20260804-fixes-v2-5-5bfd827297f9@outlook.com>
References: <20260804-fixes-v2-0-5bfd827297f9@outlook.com>
In-Reply-To: <20260804-fixes-v2-0-5bfd827297f9@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@ozlabs.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4105;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=KVNqgEF0+C48K+PWMOxfS0uXgoSuZZMWuvz93e4utzw=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMLlb6bXFGww1mD9ovLjdb0VZ+ON3WvjZ53b3SEpX
 W/vPO166beOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmMipRkaGk8dilnY+3yn6
 k3OurXqRd4RVwOqfksvaF2j82SdzU6CqlpFh7beF5s5RSafO/lj8pNOgNu+csZmB0eJv37WtD95
 PO2PGBgB+bE2s
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

spufs_mbox_read(), spufs_ibox_read() and spufs_wbox_write() take the
context state_mutex with spu_acquire() and only drop it once their
transfer loop has finished, so every put_user()/get_user() in those
loops runs with the mutex held. The faulting address comes from
userspace, so the fault can be made to take arbitrarily long via
userfaultfd region or a FUSE-backed mapping.

Drop the mutex around the user accesses: acquire it per mailbox element,
just long enough for the ctx->ops mailbox operation, and release it
before touching the user buffer.

spufs_switch_log_read() has the same problem but its loop needs the lock
for more than just the copy.

Fixes: cdcc89bb1c6e ("[POWERPC] spufs: make mailbox functions handle multiple elements")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/file.c | 52 ++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index de7494748fec..c8c3b6e8affb 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -602,13 +602,17 @@ static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 	if (len < 4)
 		return -EINVAL;
 
-	count = spu_acquire(ctx);
-	if (count)
-		return count;
-
 	for (count = 0; (count + 4) <= len; count += 4, udata++) {
 		int ret;
+
+		ret = spu_acquire(ctx);
+		if (ret) {
+			if (!count)
+				count = ret;
+			break;
+		}
 		ret = ctx->ops->mbox_read(ctx, &mbox_data);
+		spu_release(ctx);
 		if (ret == 0)
 			break;
 
@@ -624,7 +628,6 @@ static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 			break;
 		}
 	}
-	spu_release(ctx);
 
 	if (!count)
 		count = -EAGAIN;
@@ -705,29 +708,34 @@ static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 
 	count = spu_acquire(ctx);
 	if (count)
-		goto out;
+		return count;
 
 	/* wait only for the first element */
-	count = 0;
 	if (file->f_flags & O_NONBLOCK) {
 		if (!spu_ibox_read(ctx, &ibox_data)) {
-			count = -EAGAIN;
-			goto out_unlock;
+			spu_release(ctx);
+			return -EAGAIN;
 		}
 	} else {
 		count = spufs_wait(ctx->ibox_wq, spu_ibox_read(ctx, &ibox_data));
 		if (count)
-			goto out;
+			return count;
 	}
+	spu_release(ctx);
 
 	/* if we can't write at all, return -EFAULT */
 	count = put_user(ibox_data, udata);
 	if (count)
-		goto out_unlock;
+		return count;
 
 	for (count = 4, udata++; (count + 4) <= len; count += 4, udata++) {
 		int ret;
+
+		ret = spu_acquire(ctx);
+		if (ret)
+			break;
 		ret = ctx->ops->ibox_read(ctx, &ibox_data);
+		spu_release(ctx);
 		if (ret == 0)
 			break;
 		/*
@@ -740,9 +748,6 @@ static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 			break;
 	}
 
-out_unlock:
-	spu_release(ctx);
-out:
 	return count;
 }
 
@@ -839,40 +844,41 @@ static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 
 	count = spu_acquire(ctx);
 	if (count)
-		goto out;
+		return count;
 
 	/*
 	 * make sure we can at least write one element, by waiting
 	 * in case of !O_NONBLOCK
 	 */
-	count = 0;
 	if (file->f_flags & O_NONBLOCK) {
 		if (!spu_wbox_write(ctx, wbox_data)) {
-			count = -EAGAIN;
-			goto out_unlock;
+			spu_release(ctx);
+			return -EAGAIN;
 		}
 	} else {
 		count = spufs_wait(ctx->wbox_wq, spu_wbox_write(ctx, wbox_data));
 		if (count)
-			goto out;
+			return count;
 	}
-
+	spu_release(ctx);
 
 	/* write as much as possible */
 	for (count = 4, udata++; (count + 4) <= len; count += 4, udata++) {
 		int ret;
+
 		ret = get_user(wbox_data, udata);
 		if (ret)
 			break;
 
+		ret = spu_acquire(ctx);
+		if (ret)
+			break;
 		ret = spu_wbox_write(ctx, wbox_data);
+		spu_release(ctx);
 		if (ret == 0)
 			break;
 	}
 
-out_unlock:
-	spu_release(ctx);
-out:
 	return count;
 }
 

-- 
2.51.2



