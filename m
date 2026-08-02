Return-Path: <linuxppc-dev+bounces-25200-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E10C55171
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2026 15:51:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCknn3pD0z2yhD;
	Mon, 03 Aug 2026 01:51:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785685917;
	cv=none; b=cOUPcq0LR1k08NUQ2ijABO8Lm2myYDdZxr0GFQEOboVyH1zzypltprS0gXIMmHvGu/SqPnNJ0tOVE0JVE/fCBTUw848tbQiZW3JHyP64qbyLJ223+g+q62+1YPfpmtRi5/gHBrt6OS/zyXY2C9xE7dNBgWTkGhzwUTmhLN22ABHctECQecPp9wHPTcLzMG8g6sCaJYo6oxabSWHk3B3Zmjgqg8ZI2cj6c7pxE26+9U2xBptfXAUt1O1FiqKKuWyO9GZcXZyGpnbf+m3lrfahdgGkhJR+wREjQe4exGqxVx7cQDHmCojF/Fwpgitad788xcA7UKw9q9f+2NukROkSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785685917; c=relaxed/relaxed;
	bh=/BWDPgX996U2b+6QuI/3Y/50exMDnFi4tfJWv7dUgbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kiqZqL8kUL9BbH9paIzepcMhNZa9FI4HAiq16yC3jFcTCrXFiq53Y4/YP0WjPdg1hgs6YkFnaX3v645voCeYiizB9h4qTGE337Fw7V3e12cvPn04WyBH8XRzqIeXLcKjYKSQE2Lc2zNbUUm0nnXTk277IwoUwE1wjNA19uXBJ/PTVYg8BMxq+8m7f3pItdyCTE8629+4mpi/9MJvKuQKLg1sbzUpsYBXzDY+PZq9FOtAEHJRf7kncg+YvRLcF9WFRgyKGExOSHA+I0slv9vQXa8FyotwBK8rkI/RJOGt9ORxg5W4gZD0xBH38sRxI5d7hLPz0BnXelzK6cPuzht8KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HT1TEx3L; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HT1TEx3L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCknm1fqmz2ygp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 01:51:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1A40543E8A;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF71EC2BCFC;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785685914;
	bh=m9qYyZFPWHD8u5pzGA5bglHhVct9JFkiPueOzfG68c4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HT1TEx3LzVMlFIPHrO539PJgrk6KZ2iqRWj6o78PyzST2LisTa+5MdZrZ4CaH8/Qr
	 BEXWXreFll8DwFqO7bapdJeEYpmyJI8huupkDo+iCGa3sz4F1cIdtIsZSMeqK0vZqB
	 YDVIAkN43twkbVDaJbOf44M3vQA6FnkHhfdUjciBQfdhD015mth6VheKo7/5sYz6M+
	 /sAQlT5LbOT6w75FVlq8yp7nOZTSqepPf6Y16Fm5/zNvK4zfCXCHNXSti9BwojEE2E
	 yrIYFINnpkBZTYyGWtvEwXFVdNCwUJGZNb6ItLs3pGGrJfrlqSH4p8cx4ZYdq9kF0v
	 MAciI8dZ1NQwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D0BC55175;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sun, 02 Aug 2026 23:51:40 +0800
Subject: [PATCH 2/6] powerpc/spufs: don't leak kernel stack via spu_run
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
Message-Id: <20260802-fixes-v1-2-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
In-Reply-To: <20260802-fixes-v1-0-7368423440f4@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Mackerras <paulus@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1557;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=JbhPcONN9PAPqWDS7IAW9bNoVq7Tog3058VmeC72cKQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPz06RI7tzly3IkWCtuj8vPhkaZmvtV/ug8FBss8e
 HNfaFNiXWVHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATOTyLob/QRPi7m7dHi72
 8PEzY7EU9eWi4novRY2vZ71cqXig1bj0EcN/f/XvderGXuX/vnytr1yyYlbW5zsPbLaw9t5d5K7
 5e20hOwBtQk9E
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

do_spu_run() hands the address of an uninitialized local to
spufs_run_spu() and then copies it out unconditionally:

	u32 npc, status;
	...
	ret = spufs_run_spu(i->i_ctx, &npc, &status);
	...
	if (ustatus && put_user(status, ustatus))
		ret = -EFAULT;

spufs_run_spu() writes through that pointer at exactly one place, the
"out:" label, and two of its exits never reach it: the interruptible
acquisition of ctx->run_mutex returns -ERESTARTSYS directly, and a
failed spu_acquire() jumps to "out_unlock", which sits just after the
assignment.

Initialize status to 0, which is what userspace would have observed had
the assignment been reached anyway: spufs_run_spu() resets
ctx->event_return to 0 on entry, and 0 is the "no events pending" value
for this word.

Fixes: 67207b9664a8 ("[PATCH] spufs: The SPU file system, base")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/platforms/cell/spufs/syscalls.c
index ea4ba1b6ce6a..549fcfbbc140 100644
--- a/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -37,7 +37,7 @@ static long do_spu_run(struct file *filp,
 {
 	long ret;
 	struct spufs_inode_info *i;
-	u32 npc, status;
+	u32 npc, status = 0;
 
 	ret = -EFAULT;
 	if (get_user(npc, unpc))

-- 
2.51.2



