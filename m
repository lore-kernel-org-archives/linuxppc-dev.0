Return-Path: <linuxppc-dev+bounces-25759-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91296C5B567
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 05:48:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKcwn0ktQz3bwR;
	Wed, 12 Aug 2026 15:48:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786513705;
	cv=none; b=JpmtYlf0CYbOUq40z0ebBHqT53HjWHzQQ6yFvTnwAfLl4mjPS2rSHX1zNdiAyU1cF5/fZFnV8da1ykD4cNaIERTiQ7zqUnA/R5zasJ0JXPmZ24ampgqi59/0gVeS+PNVWOlTWpKzd1TRMYNPUy1MP/H81XsHWT9kdpuiBWxTNsAmWnicMCFEJaczZu+YGfdRqyli+qWj/ejze6qdoZXurQE/gYiTJ7SJ928DPm6BgSkNNtuChAFJWypqygCys0kDgZYGIEOe0VmTAqRabKd1uhvYp0waF5gfaKtgUpnZ+/LSJ0YApDxA/iR2rcuiNQ6UH/A4H1Am7hXGwgM+6hdP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786513705; c=relaxed/relaxed;
	bh=06Z2OKZmsIIAvthM9WvDifRM1P8E7uD5DtmCuvDEFDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iks0yVU7sZiuBULG4SXRi1tr4qX+gmUEK+HRgcNY0ZpAH9+BbxMvcQd2oY0nGbuigmqw5idqaT6eGDv3W05aF7ot72nBjcX6rSNLAQZKxCAKowFi5n1ga3q81oyAVp0Wicf8U+jEtzxnwZXh9jpWFOTWIFMjeR4j23BtjEqduevjWUlGMEVtW/BaII1QNvhlJ6g/D2GvoWPsmvDifQF9qPBwsJF+HB9hNUE0gEJvqQt3AyCLzjL+5VXwTmq8uxpzoWHDZvNnhZ/S9g3rqYc/e1qi4C5uHQOKBk61C3+oVrTNh+aj8tXRmn9WAEZIHQyigMn4vD3576pl8tf4MAhVnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VSct1ZPu; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VSct1ZPu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKcwk4b6mz3bsn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 15:48:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F0FA543EBD;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1A55C2BCF4;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786513696;
	bh=9w+nhi98huDt+ztbUJeNG8l8k55prmsDYEDE1dmUPBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VSct1ZPuUf1pjo6wxoJBm/Wp6cPJplgMzFxQttIRM0rV9/tyzZ3TcZPTIdKFxmWoQ
	 k8HvC8lpUKYSNZGMPdyr1mSjACZfMxvR8iVTTL4h5UQ7tDmpkFMZ0ONnrQvwWPnG1j
	 ZpiGIZScb0ZKiexf8Mv4D5DYUApGJe9amUpxpHn2QqjRwMUPC2h8Qjij9pdfIaFsWZ
	 n4t3dvNwrXm7MlvKW16Zx6zTptlLWEhu8QEVqEXvjmyHqF5xv/g13cgDLW0mnqU08F
	 DcDxfaistGkkUa1HODS/sgeXVS3Qic+3rdnK/eZ7AoKuIshR36rs9dBeduxlgFf5RC
	 q7CeFLPIxNaiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8C7C5B56A;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Wed, 12 Aug 2026 13:48:09 +0800
Subject: [PATCH 3/5] powerpc/spufs: take a reference on contexts pulled off
 the runqueue
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
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-spufs-fixes-v1-3-449e201d9f64@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3301;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=T5RasOG3hMtgArux2E1H2cOe81CngMYYogn8j0wG5LU=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBpOudSN4knvbG/uPLTXREmq+kr6q+N99XrLvJ5fF
 ElPP/1E+XNHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATCS4jeGvhEJDwv1fagpM
 j5g9w8TqbpzYmOFhyvu1OCayOmfNlagyhr+SF+6f/3pL81LH6ghF1oVpYl+Sar6e3Pxj1yPjH+e
 TFWtZAZhuTLk=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

grab_runnable_context() unlinks the chosen context with
__spu_del_from_rq() and returns it after dropping spu_prio->runq_lock.
The runqueue holds no reference of its own — __spu_add_to_rq() only does
a list_add_tail() and __spu_del_from_rq() only a list_del_init() — so the
caller is left with a bare pointer. Both callers dereference it after the
lock is gone: __spu_deactivate() and spusched_tick() call spu_schedule(),
which starts with mutex_lock(&ctx->state_mutex).

The only thing synchronizing the two sides is spu_run_fini() ->
spu_del_from_rq(), which takes runq_lock. Once grab_runnable_context()
has unlinked the context, that call finds ctx->rq already empty and
becomes a no-op, so the owner is free to leave spu_run() and close the
context directory; the resulting put_spu_context() can reach
destroy_spu_context() and kfree() while the scheduler still holds the
pointer. The window spans a full spu_unschedule() -> spu_unbind_context()
SPU context save, and the BUG_ON(!list_empty(&ctx->rq)) in
destroy_spu_context() cannot catch it because list_del_init() has already
emptied ctx->rq.

Fix by taking a reference in grab_runnable_context() while runq_lock is
still held, where a queued context is guaranteed to be alive, and
dropping it in both callers once they are done with it. This matches what
find_victim() already does around its state_mutex trylock.

Fixes: e65c2f6fcebb ("[POWERPC] spufs: decouple spu scheduler from spufs_spu_run (asynchronous scheduling)")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Found by inspection; I have no Cell/PS3 hardware, so this is
compile-tested only.
---
 arch/powerpc/platforms/cell/spufs/sched.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index c52af883e01c..1b50b28cab11 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -815,6 +815,9 @@ int spu_activate(struct spu_context *ctx, unsigned long flags)
  *
  * Remove the highest priority context on the runqueue and return it
  * to the caller.  Returns %NULL if no runnable context was found.
+ *
+ * The context is returned with a reference held on behalf of the caller,
+ * which has to drop it using put_spu_context() once it is done with it.
  */
 static struct spu_context *grab_runnable_context(int prio, int node)
 {
@@ -830,6 +833,7 @@ static struct spu_context *grab_runnable_context(int prio, int node)
 			/* XXX(hch): check for affinity here as well */
 			if (__node_allowed(ctx, node)) {
 				__spu_del_from_rq(ctx);
+				get_spu_context(ctx);
 				goto found;
 			}
 		}
@@ -860,6 +864,7 @@ static int __spu_deactivate(struct spu_context *ctx, int force, int max_prio)
 					   interruptible */
 					mutex_lock(&ctx->state_mutex);
 				}
+				put_spu_context(new);
 			}
 		}
 	}
@@ -933,8 +938,10 @@ static noinline void spusched_tick(struct spu_context *ctx)
 out:
 	spu_release(ctx);
 
-	if (new)
+	if (new) {
 		spu_schedule(spu, new);
+		put_spu_context(new);
+	}
 }
 
 /**

-- 
2.51.2



