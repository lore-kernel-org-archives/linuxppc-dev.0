Return-Path: <linuxppc-dev+bounces-25757-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D814C5B567
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 05:48:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKcwk0P52z3bsL;
	Wed, 12 Aug 2026 15:48:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786513701;
	cv=none; b=oi06y4I4q4GeIXg7o0sHHPGWCDDVYudLH4hYF5wmlWlqglhLeWSVOiW+KPQ6Du+BYwPCHgGT3qWjQQpOqU+h2CQm3QuS/I6RoCBSiRbIJ2Ak3055CXKuHlPn8MoKZX1ysuLTAA2wmKn6O2gXYVqIq7Hcaw+IJUzzizj1J7amgkfuEtimsd7cUCkPul2hZ6y1x3X3DgM957tFwncPwS48p4F6w4zduPWy5CE+eClrT+IGVfbnN+TJxEICITCt9L5PExwJQaEMhZm5n6cSgD0jRzzrt7MLoQz0dsFWOnjH0110ckQATZd0S+cemEX4K5T8ZIVOHQruKxMFaeMswSTYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786513701; c=relaxed/relaxed;
	bh=jeaV8tcZEDkGC+UlLSGJRixfZxV0AhxtW5LCPqH5YEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MWXkXyEb80PpKvJ4QE4Ru7SkAxWid+cPBGbL/7kwFL0YuTxq9H0xk8I/iujYpYDWKwHbvCOU94dvbWFqdoDKHVNqZgs28OIPDfloT+4AQAz+pZLMvRfI6T6mnX8z961EKWpHwOI0CitX5fgnIcGORdRIvlC6mKBejTOEtGNvqBDgGYKkzYkCJqTJmERl82P9Oh9sf5k56x/uVODsUIjnpbjPrCzN56H8qCwvn8pbeyf+1oX3Kh96cJA4tzZGXGVHjXFY2vqjTEKG5MhOHiLGng/3By4lrKZOQWt3vuZc4jEwDs2sGcmoLeFulYmXmMww4N0O2TFFsoIjJG2LFDTQvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DC+moI7u; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DC+moI7u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKcwh4z7rz3br7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 15:48:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3DA3D601E0;
	Wed, 12 Aug 2026 05:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E539BC2BCFB;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786513696;
	bh=FI33eKJuUW2cCOF3A+HkOrbGmEWWRPVJc9faC52wrQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DC+moI7uE1Qes4/Z0vDoanEAhVEiZ7vioNGmW17MLp/MIQy6wCuP2Y6PaGQFabn6m
	 vG/twMaIKURhWOKFeEsBHzxJ+ASAR6BQcWn/UeY8UkY+r22cEjC5ijjW/u/7OwcF+A
	 o7zKRv+yG0tSwdhtYaf3ljyAw3stkJWEUvhNX3rIZmN8EAFCvpzbrk3T0dJxQJlNFj
	 7VUh4okBaeWL9qUJor+awLs4au+7dtIm7tZRZ+3ihpgKk9jxB6My6OC9ytKn5o+Sgn
	 DcVd14XYgNzSeCVQ25lXy0OrFiP2BsGoOQZNJfkIOijaQnS/jbOjr6tHb8Ylbhzk4n
	 6Z48ET+9NTMVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2349C5B567;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Wed, 12 Aug 2026 13:48:10 +0800
Subject: [PATCH 4/5] powerpc/spufs: fix context state race in
 spu_acquire_saved()
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
Message-Id: <20260812-spufs-fixes-v1-4-449e201d9f64@outlook.com>
References: <20260812-spufs-fixes-v1-0-449e201d9f64@outlook.com>
In-Reply-To: <20260812-spufs-fixes-v1-0-449e201d9f64@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Paul Mackerras <paulus@ozlabs.org>, 
 Luke Browning <lukebr@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2492;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=LOgiV6k5pQqtCquvEoYhVH8oPI1aXbE98cx2n5Jk4Uw=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBpOOYGw9Usyiu18nAvvC4tk+pYuNA/y3Kxw4tCR0
 3fYQsOdZ3eUsjCIcTHIiimyHC+49M3Cd4vuFp8tyTBzWJlAhjBwcQrARD7NYPhnL7HT8n2xe+RW
 wdSNS6tr+3c/U0qeJrJOymRpoub7Kq7ZjAz/hNmsXp2Jddq/pHbOl3+Prn3cN5+17URqQvtmlsr
 kuGomAPzFSKY=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

spu_acquire_saved() returns with ctx->state_mutex held and the context
in SPU_STATE_SAVED.  It tests ctx->state once and, if the context is
still running, sets SPU_SCHED_WAS_ACTIVE and calls spu_deactivate().
That path reaches __spu_deactivate(ctx, 1, MAX_PRIO), which drops
state_mutex around spu_schedule() once spu_unschedule() has unbound the
context, so the test result is stale by the time the function returns.

A second thread reading any saved-state file of the same context can
take state_mutex in that window, observe SPU_STATE_SAVED and skip its
own deactivate.  SPU_SCHED_WAS_ACTIVE is a single bit in
ctx->sched_flags rather than a per-acquirer token, so that thread's
spu_release_saved() consumes the bit and calls spu_activate(), binding
the context back onto an SPU.  The first thread then returns from
spu_acquire_saved() with the context RUNNABLE, reads a save image the
SPU is concurrently writing, and trips the
BUG_ON(ctx->state != SPU_STATE_SAVED) in its own spu_release_saved(),
leaving state_mutex held.

Fix by retesting the state after spu_deactivate() returns, which also
re-sets SPU_SCHED_WAS_ACTIVE so the acquirer keeps its own reactivation
token.

Fixes: e65c2f6fcebb ("[POWERPC] spufs: decouple spu scheduler from spufs_spu_run (asynchronous scheduling)")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Found by inspection; I have no Cell/PS3 hardware, so this is
compile-tested only.
---
 arch/powerpc/platforms/cell/spufs/context.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/context.c b/arch/powerpc/platforms/cell/spufs/context.c
index 44377dfff1f8..2414ad9be0ae 100644
--- a/arch/powerpc/platforms/cell/spufs/context.c
+++ b/arch/powerpc/platforms/cell/spufs/context.c
@@ -107,7 +107,7 @@ void spu_forget(struct spu_context *ctx)
 	 * want this context to be rescheduled on release.
 	 */
 	mutex_lock(&ctx->state_mutex);
-	if (ctx->state != SPU_STATE_SAVED)
+	while (ctx->state != SPU_STATE_SAVED)
 		spu_deactivate(ctx);
 
 	mm = ctx->owner;
@@ -150,7 +150,7 @@ int spu_acquire_saved(struct spu_context *ctx)
 	if (ret)
 		return ret;
 
-	if (ctx->state != SPU_STATE_SAVED) {
+	while (ctx->state != SPU_STATE_SAVED) {
 		set_bit(SPU_SCHED_WAS_ACTIVE, &ctx->sched_flags);
 		spu_deactivate(ctx);
 	}

-- 
2.51.2



