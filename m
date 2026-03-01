Return-Path: <linuxppc-dev+bounces-17458-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93CCFD0049
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 01:24:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNkr66flbz2yFK;
	Sun, 01 Mar 2026 12:24:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772328278;
	cv=none; b=fA21jRmDkEsDSyn8WQn4N3XWDtlKuOW7g5bYzk4U8gFynGspacBmzv/jCfMNLYuTPrQM4Y4wOHzRSfq/yhR4OwM1BLTHYhncvsy9mPq0D0IrG+QlyMGfwueQBkBJO6u/fwp+FnamX6oq9j77afxppvAIzsk1pqlqKdU0sZMG5XV36gUiPNnNXPzPakC4JcdRBFDTPcLoPzPNIYum17fPxxrSz4Mz3WiOROpNQ0xtzdqtJRT9tCbWwhooIbOLu3vC5All63qwHMSc1XgztDfV/tnG3VhWIueFctuC+iBkYLoHbsFJ0uTS2NDp3ULJse7elV6QNDsThstG0eHwRFPktg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772328278; c=relaxed/relaxed;
	bh=It9wz2doIo8fQVXpEE4VEhyC1IZRuI4HBxneVCG4lbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQUADGBG2t0I1YrklbltmgwgRJTv0JVPKABZioKOW3NcDCTkktaqACDL17ueNdWce4RP2KqaTrO7QIYzR0RfclpzXB2ifU86iZOIDL1TwKB53VyFl0oDaZohXMmysbBdkjBKtaqaCLf0q1RddH5/ZvTzshExSbaKZ4M3oxAgSbosOfuWg8MTFIQIZxrtxPYQ+7YD+AnSKZCVWI+3w7lQbR0Ii5DnmqHJ17dscRiZ01si5Mt2OEU2zyXLU2qHNpk5MinceAIJH3naRj2vflCeGLo5vTYoMNVPDye7bGS0+Z5bwjP4ekrlgKkJErrNubJ3Pmp+A1gB2FQZPR8x1PpQIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YBs49Hzp; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YBs49Hzp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNkr56dqjz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 12:24:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C59BE4086F;
	Sun,  1 Mar 2026 01:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA736C19421;
	Sun,  1 Mar 2026 01:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328275;
	bh=WZYvYsbaDrkbZfvWiKNS3s0peY5M15DSV9k5w42HmV4=;
	h=From:To:Cc:Subject:Date:From;
	b=YBs49HzpxEkVq8XjRg6tNv2rDP6u/A/Zw+izruFxagBlHGThkKXeoZPfjd3jTnk8a
	 X9O/W3gyJw4vQJQCzYyALB/AIv7Ll3KnfavjcyKnGaRY14CJAPo9MOBJZYnvTfxso0
	 iqb3CSy5DfGhzX/SlUF/uX6/1nw7uzCaODS7GDVeoVMbVgn7DVXJD8eW97AkAo50nb
	 TMB5kMOTUBIUPem1xBHDo1WDeyncM2VNbUJHjEz18qhZhM+0B5ItePQ5sAzA1atrCv
	 5/WpnWutqXtXEVtNFG8pohsHb0X96K/6GqHEkSl8nnTdg3Ah/kUb/T+xlOHYZDMm0F
	 9A6Va1dH0FYxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Su Hui <suhui@nfschina.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "bus: fsl-mc: fix an error handling in fsl_mc_device_add()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:24:33 -0500
Message-ID: <20260301012433.1681444-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
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
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 52f527d0916bcdd7621a0c9e7e599b133294d495 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Date: Sat, 24 Jan 2026 18:20:54 +0800
Subject: [PATCH] bus: fsl-mc: fix an error handling in fsl_mc_device_add()

In fsl_mc_device_add(), device_initialize() is called first.
put_device() should be called to drop the reference if error
occurs. And other resources would be released via put_device
-> fsl_mc_device_release. So remove redundant kfree() in
error handling path.

Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/b767348e-d89c-416e-acea-1ebbff3bea20@stanley.mountain/
Signed-off-by: Su Hui <suhui@nfschina.com>
Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 08b99b0b342f3..007223549887d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -896,11 +896,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 	return 0;
 
 error_cleanup_dev:
-	kfree(mc_dev->regions);
-	if (mc_bus)
-		kfree(mc_bus);
-	else
-		kfree(mc_dev);
+	put_device(&mc_dev->dev);
 
 	return error;
 }
-- 
2.51.0





