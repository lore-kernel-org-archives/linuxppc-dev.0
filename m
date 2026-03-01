Return-Path: <linuxppc-dev+bounces-17464-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BBFFD0045
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 01:44:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNlGs2cYqz2yFK;
	Sun, 01 Mar 2026 12:44:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772329461;
	cv=none; b=JVAyHQo6eYrNWqZeVqoFpOfuNACmwAoD8tE+8fEjEBaRCsLWnFbHOYZiA5yRGjOXuwgwhszRQbPEtcltOvhfzpTyt5QZlhcqku/y6qD2TVtvng5/0JphQywlwKkRUcKdY9c8ck0RqdEn1ezbyc7nNHXCkNdaXmyhkXOIlkAOLvbK6T25nPWeZqR5gHyqL5pEnI4n8ocG4Td/Mnqk8e2tMmdrZ0py4j9GgQXkUqvzTqrodOxrI6Mk+2f4vhmsUeKVYx+fhB75h47hyQseGLBjCxeivKQx+HWx2zB0+qdVefRH8ClMbNuNM4/AdHPMN7chD/OA+GijNcuL6y/nxQC4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772329461; c=relaxed/relaxed;
	bh=UFiA1ncJQx0HdZYr+0640aGvh5N6tC54o9rMgiky+KY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpTUe4JT34ER/ykldTIRv8fkziPFzE8e8gh2qUeyuFsSBKbd+HFOHTF8Er5cU2Xr/5j1UhUHMjkUy72Ep6OBWDIK1IUKgYJuB6bhyu/jtpdYu0z2pjRSVjcimuGRsxwU9iHF4/Qnw6TXr3rtAcszwFM+4zBvohQMizFQ7NncwGcWdYr8BNm4yBOrTIocwPyv23+KR4xGYRmLLlEzY1cuFxhpmUiSSnkgvioM0oeo0HFXYosqkZu6pt6oZIFHcR5yDUxjZUY35JYeePxU5llUrfnbysTIY4M8+QeNLsyay6r0UMXk5psCnPqiu1C+XktK2ao2moU8IpyceVeUmWz8Cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WLZb+8D1; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WLZb+8D1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNlGr2X4Nz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 12:44:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5F9FD60123;
	Sun,  1 Mar 2026 01:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF2FC19421;
	Sun,  1 Mar 2026 01:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329458;
	bh=otV3GEF3kHHJLDBVkRwo4eK4sT5qA0o7sYunVZWFT2g=;
	h=From:To:Cc:Subject:Date:From;
	b=WLZb+8D1C7RZ+2RHRqjenZdJ9GILccfoWew9FGRYxjpZZBPUKn3bsXz6sQABD4y07
	 H1jaYTEfXfCTesaeu6AYrMF/T3qgS4JPMH5Y6QyhFlfEXTGti1xLhOGFIpRNxTVoya
	 52zrgn4Hak2dhPht8EoWL9P1BA4gjtjxVlv2M6y0DR2gV8efmQ0WkoPwQv11AxrUy1
	 d9Bd9zeh+byIobFP61Z76qKBjT9iZpLGYO58edtBmArVLEEzTuUt0O9/AjJfPPVXxo
	 Zs44lY+Y9BgGv0RJ8wyIe2OA1kISjUbMMzWhFO4mh1pU0hEJHxWmE0S1bt0NA+eBIi
	 9SCOEeBUoT0WQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Su Hui <suhui@nfschina.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "bus: fsl-mc: fix an error handling in fsl_mc_device_add()" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:44:15 -0500
Message-ID: <20260301014416.1706482-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
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





