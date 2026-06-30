Return-Path: <linuxppc-dev+bounces-23212-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A72C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:55:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqR4b0VVjz30WR;
	Wed, 01 Jul 2026 00:54:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::ba"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831263;
	cv=none; b=bB5zNnZtRmenlw0Iar1kbYItgjeBAxSQhWWQ29z3Rntq8IqW8aFY/6QPFmFuSch7BKDJSlWcHt4eXUkO9YbgK35ePn7wqtMeytGm+8SDVujbU02BJtm6E7u7R5zxoXPnExITSipZZFBYvPQ415KdyE6o39T2N9f0YLM6qaH4LsIFdW6RiBDEFOKTtOfh7s5ZaJ4+X1z/UekzNgeTU2Jk4BTsHZIt/ZtCKG+rjVAQi2is4xrW7os+iT/dMyWxtt7XUGowBEd278s85NaagB0FINvha4HL39uWOqADBFKOFxueBpogfV6mnPgBCpc+2RkowiKSkDOdwTojWUnYXt55RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831263; c=relaxed/relaxed;
	bh=fXgJ6ncg7/LRAI10/ReLeI9PIKurpP1ikYGBLufKO44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qc5WpCq1bWlr0pPEIXmD9EDFI3XqyfVa4grbyyvZFkFq77i/9gxEFoISmaIHPV58pSkyyAlGXB15DHIp1F2QtOCaeEwETE6I4MOOFq/SCFGoD1uj5PWGFrMruuQQ2iSZzuZ6Ic+AiXqkDDQYRn7k4Tl06ecP9oYceNzqd+EjGhmSzmU+WQ1h9fodV2a+aKi9vJIbAr8uM1uLiQhuTtuZ/JA/NoNwPROexuqeKu8HN9VXh3RJECaK0/zS+aer9PxIJpfb+BOvjhHIQfcvEJbCv9P3HB5rNLTOuvK0rF36cLplr58C/M5V4ejbc2eo8eXizV7EkNiFesk0CICsq8Aplg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FscsKqn7; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::ba; helo=out-186.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FscsKqn7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::ba; helo=out-186.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [IPv6:2001:41d0:203:375::ba])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqR4X29ZYz30Kg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:54:19 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782831238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fXgJ6ncg7/LRAI10/ReLeI9PIKurpP1ikYGBLufKO44=;
	b=FscsKqn7irl88wGVa9gdOOxwcOgW+qbbBsVVGtnEZKHII841uOp3TGq+k/68WD8Alfzm8V
	lDFwYdb5cc6OyZOpyXErD2HHZ5nvHEiQALy9PbdwgmIR/C6QanxT7J35l1+BGBikEaH5qA
	2KQkDrELo/lZVFSzUzs5loqeLKMFWKc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: fsl_rio: Use snprintf() in fsl_rio_setup()
Date: Tue, 30 Jun 2026 16:49:50 +0200
Message-ID: <20260630144951.692473-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=thorsten.blum@linux.dev; h=from:subject; bh=t07oB5yLhZyHga9z8cC/7C8bbPb64QTclkxfg9I/0aM=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnO1/vbN3vvOJzz/2mRcv/ipp0a8keiBcXrljOX9BiuC HnzQbmmo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACbyWIXhn9WT13tayt1zqps0 tJdKqlToCYeHLuPOVG/WzOs9Mv1VASPDjTk9tTXbznctvBXxpcPwnOVsm53aWy0in8j9af37/q0 mDwA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

While the current code works correctly, replace the unbounded sprintf()
with the safer snprintf() in fsl_rio_setup() to follow secure coding
best practices.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/sysdev/fsl_rio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index eb55dabb4748..077c03cd93e4 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -612,7 +612,7 @@ static int fsl_rio_setup(struct platform_device *dev)
 				kfree(port);
 				continue;
 		}
-		sprintf(port->name, "RIO mport %d", i);
+		snprintf(port->name, sizeof(port->name), "RIO mport %d", i);
 
 		priv->dev = &dev->dev;
 		port->dev.parent = &dev->dev;

