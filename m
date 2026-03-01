Return-Path: <linuxppc-dev+bounces-17467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD62FD0045
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 01:52:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNlSP5VHGz2yFK;
	Sun, 01 Mar 2026 12:52:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772329957;
	cv=none; b=epG/sGFvOdDwYaTVJv6570BdXix8RVvJdYcIS2CuT49raivrOTX1xkn5DztWSdx/uAjjL5MjsSDEA9JTK2hN3vN29yBDuTFctX8kXfK8vRzysooRS552Abq2cHQTCUsHmtzpW/PfXgBsWbQJdWJdWqFbih9MatKZ7oQQXWS3vZ/Y6Etpb+Eb+twTi6BMXN4Ft4+pWjjo3qPOW6lLnQiPtkj6XwhahQmARJALZIHpTIqNl4ZR2L81SaDX+vklNZxDAJ0g3uFiSsV3AFmIuK2XYaSkYof6VpXrVSKF3vXMedfIpjDw3PZA9LV95JJVhH/UBh+F9qwo300eKEm4Aj7uSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772329957; c=relaxed/relaxed;
	bh=Mqwlrf97d6JlqRc5YUKwWzrUcjT4lTLZSA+ZlidE1YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2CeBouFjDkbjr+ikO5xyuH5kV/VRLzXFmgex7z0eV4HI4UW9J7X7LkKwYzttcDI7C7UjcVEx9/+1k7U7wAQaW7ZO+0jVRn+h0UMZlfboiOrw4piOWv3bnJWWzdB3RWRToPrGkLrPFrbgohMkqxkHTaAq9EV3iMj74SdOZndGQeYpYsQ9gHHv1kgCr/ZYZau6zBxAEqCPC8Gb12JyT6VMYumFmmLmC3Iaj+gk/bBq2F/Hsi5s6nl/YE1B9Dk7N/3XZRnWDbUSqkBP2ddmhc7AZWzCiPMtIOQPcgtwOrNNHPaH9aKyP8mbJeX15WIdIpC6XyEk6qHXXun/piHXrXzTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pNVvYOUF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pNVvYOUF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNlSP0vDhz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 12:52:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ADDC36012A;
	Sun,  1 Mar 2026 01:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643BFC19424;
	Sun,  1 Mar 2026 01:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329954;
	bh=VMnN+Os703lIqCDY1dYJp2pKh+k6GIkVTnVEH6yGBoI=;
	h=From:To:Cc:Subject:Date:From;
	b=pNVvYOUFbF4LOdf7Fn3YDMejfR0vv0lJHA0/TF1B0SCus4Ot7Dh07A4fmzC9PWPTW
	 HVf4ZpNpxg/PDCZSK2doB/Q6KJhfnLJb8dXErtRody8DmraYfGfFWJUFgLo6Jv3MoJ
	 AwOphem3HUp789ejH+vzS+xSgqQXlEXthpN24MJPrWM7ngEjOApPtxHnOOTaszc6OY
	 XiaUUMLfegQyr188U4Y8Y7f7qO3yGEoO2NipK6lXfqI4KMjAi98Y0ttrLUDDFZnisS
	 r+0FffTAi3hgvMZnS5a+VUartk4Cimh7SJ7fngJV2Q4/3xzDpaTeHvVRg4E9GSsula
	 C2YSYcGQQvbew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Su Hui <suhui@nfschina.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "bus: fsl-mc: fix an error handling in fsl_mc_device_add()" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:52:31 -0500
Message-ID: <20260301015232.1719081-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
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





