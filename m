Return-Path: <linuxppc-dev+bounces-25206-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5B6C55162
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2026 15:52:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCknv662Jz3brM;
	Mon, 03 Aug 2026 01:52:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785685923;
	cv=none; b=DIwBwvYbrtZbqM/OHgxcw1ngqMAUONj2+CUInM7QSvnVXCRs1GijvybGpOMLZJ7MKyqAU3HV6HN8eX3dMm1Cf3fuAHKoSvOtW0te/GJQurW/E4eyTZFH3IV5ZdeeGR8NNMLgMURqei0UEPO6t/FsRWz+qcG1P0zt6VwpPHupqbSfKKw/MRuWldhMEQlp6/lmHmSuLgGIFUFXonGZtwD3fUL8e4Ex1K5slcmBAgxAORTCGj4h1Mosl0H2m08IL8TBi8e63msiDIVP1h+Ava8zBQebnZffsBBieJpmx0SwJBcAZcsg0yCoWniI1yCb1yDFCfeofBB8sb50QG0q53WQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785685923; c=relaxed/relaxed;
	bh=HMLoIxAihBH/kHGm/jdSueBUz0XOhEvtD8XYKhgME2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l6O83UpxOCGtC+ulP2OVPw54Ch/HkuRQZ//M/QZjUv7/8JLMnEXaZCb3ZDcb8QjTKsk1zECeBPgm/IuOtoJqvjjP4W6oNoG5Mng7W6pDu4M1H+rqMe2dCQFKthUiB5ZH6PStTEsKvBBb76BKrU0S3R0ScnGp9NI+WLgh17Dyppk5sAAnMuCtpj2j4MZHMafr68TwG8KCF7hwNRTL7wjyc0/un0mhBcvHFZwz7F/dSDTEovRd5KFEHdoTJTYIuCpO46Ue47wFHzP+MLIisBIMYgbz55EBLhQJzrz6ROqVC32ft1M7FEt+ProC2PrKxCI8YEespuKB+vwIllD4fEuzoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JmAZZbrD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JmAZZbrD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCknt2xBBz3bNr
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 01:52:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 651D460DED;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1831DC32781;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785685914;
	bh=0/POHxMnwRqE3ITFA8w+z2Q7B0vIwOI/AChWEwTMH/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JmAZZbrDzPqllK5jsnd1bZx7CNxz2eVk+40V671JTD+jeUiJyrXhrlFs16+P/9Zu9
	 1NGHnGCNXkzVu5C6H0/OtlXEsTsfZpOpzDtitpU7NIbgKW2olOG/zZ8ALe3wwP9+FK
	 5k/YGWSjNAd6t2zpCjgpFI+scso/dHW6e0DEppIXYzI3xxQRoudgBQTgCo1RBQjRhm
	 mkZ0KnYazqRt0taCQ+wr6YtMwnGlN1p8y5gOtIbslDdhD7WLAr/a7AbEwzNimG7g10
	 9FLJ26QdsdYzH5k1dCCVV0hWcqS6tXHlDedYRphpPkgmHLBcM1yLG6n5lePlzEUhig
	 4NCdLSaa5LC3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01453C55162;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sun, 02 Aug 2026 23:51:44 +0800
Subject: [PATCH 6/6] powerpc/spufs: don't hold state_mutex during user
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
Message-Id: <20260802-fixes-v1-6-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
In-Reply-To: <20260802-fixes-v1-0-7368423440f4@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Mackerras <paulus@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4070;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=NzneP8KvCjHXivWs94zRxQBae+0khgOio5T2NiN1ITc=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPz0GVPY35VtNGF5GLi7mJXjXtr053r18pZCaac/T
 AqX95VZ8aujlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJmJ/nJHhVtznD0tjUoRM
 7BfG7bgsvTrR/0rEgo7AhCnbt3w13GSpzcjQPmVuqmqexcbzslnXIhUdl+pfXfjKU3txDWOSztI
 FLB7MANWBR3s=
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



