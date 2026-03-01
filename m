Return-Path: <linuxppc-dev+bounces-17471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9143BFD0048
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:02:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNlgw3p6Dz2yFK;
	Sun, 01 Mar 2026 13:02:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772330556;
	cv=none; b=FbFgY98KNEuQ+R3pj76RAyU+OgGEUuR7Nt2yraHrT4n0DWnSbSo/Q2VmjsoZWUeGhWUsMlKd8uNeBW+T5D6cXqNB/+Dc0FiBry8EciOjTBGIoHcqgbITUsRZpkuQzSjlMucBOZ6FXGkve6jPTGeLnNXo58O9cQUrH7pYvY1JQxJLFP/70MRjEsYaE9Ttoh5gM/bNu4SmoV28GUHEWI2lYsyewuOVE2uDlmafYxwXb/cLeE+ckhKYt/r5SO1/MdQZiJXBvWJBnSndaPDimQZ8ABFuFwKOAQw7dItkIW2PUtnELzBwzQ97CBqBllFpLeTAdmqYUhBVJPi9u8oJippWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772330556; c=relaxed/relaxed;
	bh=OydonK2ioZuJF5JjRA4PaGbuxAtUYmvcwrcupaorHuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlF5CUo6Bcyx8E9JHeVc/t1FggtQ4oJ/EJlRqFltJ2FdhhFE1mI6obJzEuO5ReSRH9fGgGurYUJIgJFjcdRjbOb/dv82VZO49dR4f1R5DQ3N1bIU0baiupkeGpWr7gqvlo1V4XwJAeyqiL4ZOVO2Ib6B039W7VFZYLG03RpLNTNZXj3Lg8s2ybdfhEkDWykAAZ/VAXM2V9h5f2Rf7u5I8tLDkoDZgfFmyum+zcP0UyeWwaz1RGUKi0A5Ck8Zn3dX+fpziuSOVBDBjl7vCmtKOmgjk+z5N+Qu8VnwDYwxfyCbOIC5yhB8dWxDHRo4G9kouQrpDsXvHJHXbqQJS1NmoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QFFZv+Wd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QFFZv+Wd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNlgv5M3kz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 13:02:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CB9C360123;
	Sun,  1 Mar 2026 02:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8F5C19421;
	Sun,  1 Mar 2026 02:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330553;
	bh=R4wgXi7m9MAehuW90Ukk0wrh5/GcAEwQj4ow3aXRmtU=;
	h=From:To:Cc:Subject:Date:From;
	b=QFFZv+WdA0VA7eUl40NBJ88vQAWA0cFiuIO+NktVQZAU0t+Yu5cN+CBQEqxJi0Wme
	 1q2wlxnNiHsWjbTh/9TnAM2hm8F+clGd/I8fEy2JrjEYlpkeQ8K8saAb0b/B3dw8Nj
	 mATGmv29UDSSP3ASobMvv4yCI5W5ORkPpQJ+Fx7cmWNDwl6dM2oisDV1XMxOgoZmuD
	 JqqrT8Rm/nlw/16szdZY6l9r+Nx4dv+gIVc+5DsLgiyZq9Zf2yC8ZjrC5XJWTCjxqs
	 s7PBD0LEncFkkUCyTxC+Rl7QGwJzvDN5aSnQUmRSvfnXkMl5ICOW0WS2t+Vg4OIuZR
	 0gd1Ekar/td5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Su Hui <suhui@nfschina.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "bus: fsl-mc: fix an error handling in fsl_mc_device_add()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:02:30 -0500
Message-ID: <20260301020231.1730299-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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





