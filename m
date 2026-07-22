Return-Path: <linuxppc-dev+bounces-24660-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71201C4453C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 16:29:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h50815hR6z2yfS;
	Thu, 23 Jul 2026 02:29:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b6"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784737761;
	cv=none; b=nustrzd8z+VzX6R/iMTMpW5JnycvgYTvKboIU/PcWyLRSM1rK3pScXmwHkkbd7UKoscM+9RRp/6DS7QY7t4b6Yko4VtPDS90q8y1VYUFd7CEQwfQ6loNq82uFFwALzEjC+X2TmPrwuQjo7eizcNtOp2Lje8RcV/pu4ZgqS5I3on0esZr68F/fI3uXP2RygKmaKmRz+HBMMWQgokjXI5f9+/wmbpJ5RgsQTtuUVu66uUxH3q08mX7u6It0n8xwO8mvF7MsCXGvng1XQKkciyMUl6MWl/S+SqUUoEhfXmdvfwncaJ6i1o70swuJB0unlVz6DUwEfCl0t62NVxuTXMCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784737761; c=relaxed/relaxed;
	bh=AU/A+E28G3/lCyzXjRK9aFe90VdJO0cODy25bOQA+TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPwMVPneSLBi/oesmmBJC8NPi8T48bKnG6Dx4oxgXWumU4iggo4hIelX6YPIRqrf5mQPU2sQHaDdlk8FIv5JVdP5T5U59ehmsyRY83hYdWTWVB3sQUUwO/dkiy+RIZC4w+zZhU17torT/ODFXKf+ITgkmev40Usl70u7TOs+YDOC89W4i4Qpr7MxJTpZ8aluiPMvztGpNRJgQvLYw2ZmH26c105vxGFxVpSEvRqlvEZ6VYLnErtj2wE479q0YjtV/wZfqGAoG84JEzfNcCqRVWaSXghLg8acECaDnknRbrId8X/RcaccVf8DOZQEqpcjNpwuxgH9O0zmov+UmkxGkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=epQAmjMa; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b6; helo=out-182.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=epQAmjMa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b6; helo=out-182.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h507y5t4Bz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 02:29:17 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784737735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AU/A+E28G3/lCyzXjRK9aFe90VdJO0cODy25bOQA+TE=;
	b=epQAmjMaWK6VpgCNIbPyX34/mgITmgbAZpr64kRhJU7TgbLtwywUA+8oR6YYf+ZrWhnz4x
	opF+KK1KVU8ywFg7Q8rseiEK1hxxJswU/1s3LzJhmsfopgyISGytxI+bnQOvr8Aaiow8rR
	UdTTzNHWWzovJemSpXlkSgYZUBA0zfU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/rtas_flash: Use scnprintf() in rtas_flash_read_num()
Date: Wed, 22 Jul 2026 18:28:17 +0200
Message-ID: <20260722162816.156697-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=thorsten.blum@linux.dev; h=from:subject; bh=r613kEmjpbBze0gbN9Six+06zQmJjNLzVxD7jXwVnbE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkJ7xd8kX5rnWG7rOu7z7Vfz+5L/vrwSu16em7N+lSXV P3qTXJPOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiLnaMDItbfvzUbm87WLCO KeuzS+OLYF7Nw4tUOtqfLTl64+GWHkdGhq2BNYb7tmxnvxb71+z/ooMPXKXuJbktZ7SbfI43aem v21wA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use scnprintf() and its return value to avoid a separate strlen() call.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kernel/rtas_flash.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 583dc16e9d3c..aff8a67e274f 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -291,6 +291,7 @@ static ssize_t rtas_flash_read_num(struct file *file, char __user *buf,
 {
 	struct rtas_update_flash_t *const uf = &rtas_update_flash_data;
 	char msg[RTAS_MSG_MAXLEN];
+	size_t len;
 	int status;
 
 	mutex_lock(&rtas_update_flash_mutex);
@@ -298,8 +299,8 @@ static ssize_t rtas_flash_read_num(struct file *file, char __user *buf,
 	mutex_unlock(&rtas_update_flash_mutex);
 
 	/* Read as number */
-	sprintf(msg, "%d\n", status);
-	return simple_read_from_buffer(buf, count, ppos, msg, strlen(msg));
+	len = scnprintf(msg, sizeof(msg), "%d\n", status);
+	return simple_read_from_buffer(buf, count, ppos, msg, len);
 }
 
 /* We could be much more efficient here.  But to keep this function

