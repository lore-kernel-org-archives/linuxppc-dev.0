Return-Path: <linuxppc-dev+bounces-25191-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C64C5516F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 23:16:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBhm23MdGz2yYq;
	Sat, 01 Aug 2026 09:16:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785528845;
	cv=none; b=cQw6ZwT1strJPMjUCtIMTsaRpMzBoPA+aUbcP+nGyAedvMOiplpFTt7RPwlZ5SAuOwDEAcUyjCyD+xgYX3UCiMXKRztvhrRSpFjLXJiy050h0ehyM1wNREGFTvMcb5OlJbiA8VqNrz9VYqwbKr/NTvqVuzF26QOnmD/FQFa/7XbRwD9/sSEwc2f2SH7aeoRSxOXAL1ffiVOJz9KSwjYKjvCiLjfMRf19UAkJXf4Nkg/peiQRFD6vUFkkpFe7qzFAgsSQhStkIXbuHUKS46Jqw/8FJev0YpI2+QlrFIDwIF/7bfL3NNHQjXMZ5+A1ekq2PSqAzmNDJn91BwS117ZkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785528845; c=relaxed/relaxed;
	bh=1sbHQt2giy9giH/D0ck4wi8J+DFSjlKEAvlCHczunOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Uf9ZpZfUdePHBdshVc+4t62XvmQLRZWBisX+L17Sx/U+/Qxu8H6OoWl0B3aG10hFf6iaQAFoZF1Hc0O9AuT60BE33gr08+kN6PLbtze1KggFF24V3KyAjAsX+9t9sbHP8P6IZMGpTvSSTx8N6ByxH+Xke2K9lpJDRU/gb/jHN77fPMtswvwF8V2vnM6+rb14p4c2ruyjUDZRN2zYi05FJoQDAaOiou7WSBxA8Ua2J49JPOVUyo9F5JTjSDzd52C3lQtRR6nlCoVOBU9YP3ENFhjzMOyunLV7Y2DxNiTg8VfDs1Rjqjv76nguWw3/XaBY6eVF3u5dO3aT93EPOzrFiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RwlZkIjD; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RwlZkIjD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBcj80tS4z2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 06:14:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 83FA0600C3;
	Fri, 31 Jul 2026 20:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38200C2BCB9;
	Fri, 31 Jul 2026 20:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785528841;
	bh=wxx/N3oxa7B4p5E42tkwwfXlEfEpHy00SbKKxL563KM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=RwlZkIjDzyJK+HqVKtZCNhrQO6MKt2XFEKGBeFxwaov/PHBo0w8LvL9ngRMh5IixV
	 Lqvhj2PanMQL1bnU+NXio/Ywed7OGMzMNwcDqz5vBMBVxqTBmPoSU7qB8RSvOIjUwZ
	 z+6FDf3MAPzZLnsmuFY3iwNktlNWNq/X7DL04GiXMUxhxzdFwDS6+3vTRAVY4kNLoI
	 pidmvcloyEfMP73htDx6yaaos2BWopUbOOwIoL8vHmovJSqjS2n3+umUkV6HKVQ04H
	 vC2tNxhYbWEzXPblJFyRyahyJKZ9iUxgp5uK4JX56dmxJDVJCO0O+g5B6ZnVo2q//P
	 hu6rczgr5ccGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CBDC55174;
	Fri, 31 Jul 2026 20:14:01 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Fri, 31 Jul 2026 22:13:49 +0200
Subject: [PATCH v2] bus: fsl-mc: set dma_mask for the DPRC devices
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
Message-Id: <20260731-for-upstream-fsl-mc-dprc-dma-mask-v2-1-ea7058b90f06@free.fr>
X-B4-Tracking: v=1; b=H4sIAPwBbWoC/5WNQQ6CMBBFr0K6dgytgNWV9zAsJmVGGq2QGSQaw
 t2t3MDNT95fvLcYJYmk5lwsRmiOGodnBrcrTOjxeSOIXWbjSteUR1cBDwKvUSchTMD6gBSgGyV
 PQkiod0BrqQo1+jo0JntGIY7vrXFtM/dRp0E+W3K2v/cf+2zBQsOlR/b+YE/1hYVoz2LadV2/T
 aCMfdAAAAA=
To: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bogdan Purcareata <bogdan.purcareata@nxp.com>, 
 Stuart Yoder <stuyoder@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785528840; l=2029;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=/JgIuzk3o1PHWS1podI6fxXs27SOl31EINS/+13QNvo=;
 b=zRdg1GZ1k6eyCaLcZYjSK3rD0C+hdoDwi4Gzv+yyomtGy2KFjWOYAfnZ6R0vpkdgMMm5mEoGR
 1Rruc7+riHYDjqQ0xFNt1dwPRdvCD7vablyWHVgNu2i4NxNeqA2sI1C
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

On Layerscape platforms when SMMU is disabled by ATF, the root DPRC probes
with its dma_mask pointer unset which leads to a notification:
  "DMA mask not set"
so the device is left with a zero DMA mask instead of a sane default.

Let's seed the masks for all cases.

It was tested on LX2160A with no SMMU on the MC domain: the warning is gone
and the DPAA2 children probe unchanged.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
fsl_mc_device_add() already seeds a default dma_mask for non-DPRC
objects, but never for the DPRC devices themselves.

It was tested on LX2160A, SMMU disabled.
---
Changes in v2:
- seed the masks in the common path (Thanks Ioana)
- rewrite the commit log, drop Fixes: and Cc: stable
- Link to v1: https://lore.kernel.org/r/20260724-for-upstream-fsl-mc-dprc-dma-mask-v1-1-6f08af883195@free.fr
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 64d75eed0d34..35f480aa317b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -797,6 +797,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 	}
 	dev_set_name(&mc_dev->dev, "%s.%d", obj_desc->type, obj_desc->id);
 
+	mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
+	mc_dev->dev.dma_mask = &mc_dev->dma_mask;
+	mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
+
 	if (strcmp(obj_desc->type, "dprc") == 0) {
 		struct fsl_mc_io *mc_io2;
 
@@ -838,9 +842,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		 * parent's ICID.
 		 */
 		mc_dev->icid = parent_mc_dev->icid;
-		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
-		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
-		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
 	}
 
 	/*

---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260724-for-upstream-fsl-mc-dprc-dma-mask-a11e4c5a85c6

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>



