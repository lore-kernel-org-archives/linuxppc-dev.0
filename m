Return-Path: <linuxppc-dev+bounces-25202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68FCC55171
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2026 15:52:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCknr6ctfz308j;
	Mon, 03 Aug 2026 01:52:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785685920;
	cv=none; b=WAWjCZFDzJyWJLBxGwRZUWlvxfk69sPOEE+9K9Eg78wChM0w1IVUELyY4TxetDkUliGuB46DxtzRo97TFA5F/mjJSdIu6gRcbgbwrZtOEcRy3EzLdehd+n53peT5zCx1avqYiV/M9ptsBaUI8lUFZmKwZUnoOvzXelf9lAcQgsdvq4KB3OrnjlP5HNk857okjwYeISGA+ercQK4WArhC6Rfh8d+YbMD2sPpWsTNgX1aWpoZCLjoQDi3/bUzgH/gRrbl/ZJFnPUwRc13ZaSGJQ9an/Spbt2T8BDGLENRMBPmi2O8ZrfZTlYJP4nKwwh6syt/cZR2CkrVxdJabqWz2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785685920; c=relaxed/relaxed;
	bh=fUrVPUTMcAWz9q1iQxL59K06UR4h/lc0U1t1wkwfh/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYH+62vn+AC4RKihrE2eH+UNu3o31OfEFwGM7j7ZYC7hVyh2c3/Hr3H1LP9XyaHQnt5KOIB36wOCeiuCfUnvDQqJpYOhGAlPBlB4KCdICrj8kGIxfC+84Xrajg7brvqzOurBqiGmZ+6Ez1dgRS4F/hPT+Crmx/Bzly55TdJlDxodq2Kkgug8iSO7taBqaaCqvyi2Y4a4jkhaAx2rf6V7egxOutj2vxEXIR+ZyXuItxVVnn6SxSxotzZKUEIgVk0gxDC66GnAN5pOdPbHIEtlO3ZbF0mUSrPBu0fA6vLcHzQnq2mD9kt5BdngTDJpO//hdOh2CYAS7eGJOM+v3P9m3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IGrZEyBu; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IGrZEyBu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCknq3gb2z2ygp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 01:51:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1383743976;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA685C2BCFD;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785685914;
	bh=96mlfMUaIDgRh0Y8+8e2rqme1oeFIIMr4fN0Dk5+hRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IGrZEyBu5ZVT81FcE3gE99cThUtlb2qi+9YwS2LJuCLDZ3VPzmCWibGMGbrThwrm0
	 1GFKPR1k9gKZ/CryGovWbMNs2tTbKANCsUHZ67qBtb+DvYNnROPvO3CSJQfnt+CiII
	 wIyoggr5ZOEErgtDB1/JVqmmk4EVX8Hbom2lKb9tVCbz9ty5HuBSZhAio/yrkuCnEY
	 LPBpgwhIrxnsgvo9Hocs83mIkii1l6gk1F41uWzivjpWTDVCJFNh5cyboNRnoYJgZa
	 CHHJkpk0HtueQ6QzsrAtyQO4JVG2gvXuoCz8mGSSYPZamRS0indF/Wt7LVAz9/V1Za
	 cV5F7A9Re4XaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA2C55180;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sun, 02 Aug 2026 23:51:41 +0800
Subject: [PATCH 3/6] powerpc/spufs: bound NPC against local store size
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
Message-Id: <20260802-fixes-v1-3-7368423440f4@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=zn0rin21Vmi2aZsnEd8aIQAuyKtzsUFBfqpkfQqnfiw=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPz06QKOEseezU055Jt+YN7t0MAV9xRPVU8XrJ79l
 bnPia2Ft66jlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJiJpxMjwJSQhxPQeT+qa
 PmbB6w9T6zI+rX7FWf/mhWuTqt3DpYa/GBlmNs5n5JmYLSKaY2Iy48Gc5OVfS57f8ZVbUK/Pf/7
 utBR2AOnlSKw=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

spu_process_callback() masks the low bits of the NPC register and uses
the result as an offset into the SPU local store: `ls_pointer = in_be32(ls
+ npc)`. The following guard validates ls_pointer against LS_SIZE, but npc
itself is never bounds-checked.

Fix by rejecting npc greater than LS_SIZE - sizeof(ls_pointer) before the
read, mirroring the adjacent ls_pointer guard and returning the same
-EFAULT.

Fixes: 2dd14934c913 ("[PATCH] spufs: allow SPU code to do syscalls")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/run.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/run.c b/arch/powerpc/platforms/cell/spufs/run.c
index ce52b87496d2..87497316d128 100644
--- a/arch/powerpc/platforms/cell/spufs/run.c
+++ b/arch/powerpc/platforms/cell/spufs/run.c
@@ -317,6 +317,8 @@ static int spu_process_callback(struct spu_context *ctx)
 	/* get syscall block from local store */
 	npc = ctx->ops->npc_read(ctx) & ~3;
 	ls = (void __iomem *)ctx->ops->get_ls(ctx);
+	if (npc > (LS_SIZE - sizeof(ls_pointer)))
+		return -EFAULT;
 	ls_pointer = in_be32(ls + npc);
 	if (ls_pointer > (LS_SIZE - sizeof(s)))
 		return -EFAULT;

-- 
2.51.2



