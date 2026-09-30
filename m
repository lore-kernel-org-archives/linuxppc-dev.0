Return-Path: <linuxppc-dev+bounces-28615-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4217ACA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 20:15:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw5s92Mpwz2ygX;
	Thu, 01 Oct 2026 06:15:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790799357;
	cv=none; b=cKSuZUumYOILVU3rjpszE250l6M8dy1mum6TbZFzOijfZ/l+bZ/OiFj5xP/1aAnYTqbrVba+/uhJn+U+5AKct1ZGXMDyacBnIgEge5xC4+88Wj6taWu9X+1XdeDA06dYb0DgO/dXyBpLitBJibX/doA0UWo95KwO/Rrh5Ie934SExNMvI71vfvwkBUfFVyYQDC11prt0t/kYP1l9F2PcPbTocCN6GJj5TG66pAiDCUVHWFgMZ50CJgr/MCpqaFszqJOlPtYdcg9GDHq/kXh4O7cRxcVewOmRutUhylxRHW4qOtxlPWxpli/sS1padIGS9Tsu/ze1+toZO6dwWd9i7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790799357; c=relaxed/relaxed;
	bh=s+KXXJdmY3ko0gMKGF4RYmFKtidPeEYxoUxXdHgmVJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MUI3N3UMQXjEZllGUrgRxSwgeLYzaX1AF3+WRfMp9x1lRfk9SEB0cUvzCU/Tu/0rdtj8HDRT98WjaM80xYgk5ywSpdIlHrBAah7ISjzV3QdmwAZgYxURjfgY7HqxnbB9iU0n++huPdXg0QIVSVXJmxOhzNAY9Uznda7X+85/OOJZnEqmH5ZOzcZoF/SQbf0KxBAGms0cqkv/HaDY0CdcRkydHP7xZHXbNmiZ+2zMPCSat8IZLPhtSyDvEgRYaEo83K2hYuREdD3mXsdpAlsZyh5BsL1ZhyYIoEQDutEN5PfqG0cGl2Ok1kB2sbkpEJA5qFMj1ZUDYJ9GICGEHe7FtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eXEtoFW6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eXEtoFW6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw5s824wmz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 06:15:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4BE9B601F0;
	Wed, 30 Sep 2026 20:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED6FFC2BCB9;
	Wed, 30 Sep 2026 20:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790799353;
	bh=4kcMV2ayuSWtjNTLFAWlAtj1LSmyR3M6MFYIU6IRV+8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=eXEtoFW6DqypfdVBNXJ4+UdQRIV05YFPtHjiXZkaoGl+yCNWhKUomUxDCRIc+aTyK
	 xPHyGWkpeniX01ECLtevqWVYch+6RBS8l2FmhyVXKclxdVVJ/8HYYPrxoo6r0DxUoA
	 q/Mx4ds6wmFyZIplNhyjh42ZkokwRpcOnC0UvItTpSXJt1XyTdEuBQOw8eEyyos4qF
	 FTbY7tvHXjVvdsx1aX5yEW1+Z34khfI0eMfxc1XrvoZ8aSbpFvjzHvrZH36uUywB0B
	 K1IWwPjbzzA0kvIbro6Wdwp53Vy4SRG2mG6IH7baiXRpiNx/I6Bfm2r08fkR1MVPQj
	 bGPfHcvlH/vPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CC2CA5FC5;
	Wed, 30 Sep 2026 20:15:52 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Wed, 30 Sep 2026 22:15:48 +0200
Subject: [PATCH v2] bus: fsl-mc: drop the fwnode links of the dpmacs nodes
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
Message-Id: <20260930-for-upstream-fsl-mc-dpmac-fwnode-links-v2-1-13f7b6ef000f@free.fr>
X-B4-Tracking: v=1; b=H4sIAPNtvWoC/5XNQQ6CMBCF4auQrh0DI8HiynsYFi2dSiO0zRRRQ
 7i7lRu4/N/ifatIxI6SuBSrYFpccsHnwEMh+kH5O4EzuQWW2JQtSrCB4RnTzKQmsGmEqQcTJ9W
 DfflgCEbnHwkaRC1JGd1KJfJZZLLuvUO3Lvfg0hz4s7tL9Vv/JpYKKtCyPTdY1/ok9dUy0dGy6
 LZt+wJ+p8jc2gAAAA==
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790799351; l=3039;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=MLGDYZOw45UD6Di3KCAHNR0GWLFDDhooxe3jcyGjVtM=;
 b=MM/lP60BsIy9mdVuQDHAoaw5n5UB2wX0fYSiZT9X2/SO1doHHOsw8KBr4mk0W0WxUN/RwWgnt
 XPjF0wbsqdrCNK2c8DdY1ToyPJSotDqmJmdS1dxPNgjVIqJetBVrmD6
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

A DPMAC node under dpmacs/ is never the fwnode of any device:
  the fsl-mc bus creates dpmac.N objects without one,
  then dpaa2-mac finds its node in dpmacs/ at connect time.

fw_devlink therefore attaches the supplier links of those nodes (phys, ...)
to the nearest ancestor device, the fsl-mc bus, as SYNC_STATE_ONLY proxies.

device_link_add() refuses such a link once the consumer has probed, and
fw_devlink logs the refusal as an error.

On an LX2160A board with 4x25G DPMACs for which phys = <&serdes_1 N>,
the Serdes PHY binds after the bus and then at every boot it shows:

  fsl_mc_bus 80c000000.fsl-mc: Failed to create device link (0x180) with supplier 1ea0000.phy for /soc/fsl-mc@80c000000/dpmacs/ethernet@3

once per port!

To fix it, when the root MC bus probes, purge the fwnode links of every
child of its dpmacs node, so fw_devlink has no supplier link left to
proxy to the bus and no longer tries to create those device links.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com> # LX2160ARDB
---
The dpmacs node is the documented child of the
fsl-mc node: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
(and bindings/net/fsl,qoriq-mc-dpmac.yaml for its DPMAC subnodes).

Changes in v2:
- Improve commit log (Christophe)
- Collect Ioana's Reviewed-by and Tested-by
- Link to v1: https://lore.kernel.org/r/20260928-for-upstream-fsl-mc-dpmac-fwnode-links-v1-1-b8976244b38b@free.fr
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 5878eafd8d44..0c37b6780c84 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) "fsl-mc: " fmt
 
 #include <linux/module.h>
+#include <linux/fwnode.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/ioport.h>
@@ -1033,6 +1034,20 @@ static int fsl_mc_firmware_check(struct platform_device *pdev)
 	return 0;
 }
 
+static void fsl_mc_purge_dpmac_fwnode_links(struct device *dev)
+{
+	struct device_node *dpmacs, *child;
+
+	dpmacs = of_get_child_by_name(dev->of_node, "dpmacs");
+	if (!dpmacs)
+		return;
+
+	for_each_child_of_node(dpmacs, child)
+		fwnode_links_purge(of_fwnode_handle(child));
+
+	of_node_put(dpmacs);
+}
+
 /*
  * fsl_mc_bus_probe - callback invoked when the root MC bus is being
  * added
@@ -1134,6 +1149,8 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 						&mc->num_translation_ranges);
 		if (error < 0)
 			goto error_cleanup_mc_io;
+
+		fsl_mc_purge_dpmac_fwnode_links(&pdev->dev);
 	}
 
 	error = dprc_get_container_id(mc_io, 0, &container_id);

---
base-commit: 7b3b0598c00e67f2df85d0b4cd99eaa3be6c9bfd
change-id: 20260928-for-upstream-fsl-mc-dpmac-fwnode-links-622b8eadb98a

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>



