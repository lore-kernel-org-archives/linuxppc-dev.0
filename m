Return-Path: <linuxppc-dev+bounces-28412-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F74C9833F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 13:52:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htjRN47dzz2ySj;
	Mon, 28 Sep 2026 23:52:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790603536;
	cv=none; b=gHW2DjOFIjbaA/eqXPHEvzZI7PdPbV6Oaxo2WAy62P/ZbBHVask3v0J760sWDow2sSrm+mmKo7vKXnzJDNBqXVQqlYipzaf6vDvOaU0LiTRCfjTazDnvtgmNHp6OrTY73jICl0qj0xe23mes+Ul/Afw96/R5w3fb+m4eT09HmHIkFqAVGyL5GYCyizTKzsZJ2NyL5E9XmZ6cqEUcXZoskv0vSapn8eqBohy6L4cVb3oKOr5irD6f117R+Lg0dApgDLNqMuGygErlYzWdGGUfIluni5PRHMCvW2Ra38haGkoleo0ggyBiKyCcnWVmCjJviyodBPqseZx8U29oZaXcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790603536; c=relaxed/relaxed;
	bh=Z52OkaRAg07yjBmXAQobS8oBtxHY+dwSeYbzec7iQEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iot0oUR9L990ERwke7UTsfM5rt4txv8OTGHHl/ZTJjeOXygPbbdvuzlSSgShIRqRlJDzwvSuhO3XNN3WJvVH3fnyvj/xIR0AiJWYrZrIst9LEtl6sOBg7HcVFS+2Ot5ONgcRu/odtDXNduTWijAikRycczxK3k0bAs7YgtJKDzgHXGf7Og9/OuyMZXCiInZyLVODPsrBiiePxBJtXkBYfhjDR22pmZ1UNdhsx7y7jaByxKwonrsVIyE3OWiEQY5S722u7t6sngmmKQwbl93q6Wl70qoBzouKkDi/FPCob8zdekF5kTAoDDGzHa1LkHKdZQ7nk7+wPvB5MJ+hwOJE9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iqR41t8X; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iqR41t8X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htjRM546Mz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 23:52:15 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AE19F600CB;
	Mon, 28 Sep 2026 13:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58003C4AF0B;
	Mon, 28 Sep 2026 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790603533;
	bh=nsztS+SgTPSoQ/D1lsoAMNzlVg+6MEAWElX7J48YQgQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=iqR41t8X+UZJqymu3xI5mosI0EMV6OSpwz0emDBUfnGt6+FStmMAjSTd2JVWm6IkB
	 wYniSMWRRno+rNYRNyLgA10rOI3qZg5xm0/NBGURM7G8tGbO8s8sTW7Kj6l+giGybY
	 l4fCt4gLoqhoR26PCKK8oZljmIwmzRGwMI1XVZWs/6S7dfMkinDQ/EBg8n9riEJkHs
	 Uu2bKMVGGjHIcc8WhRqpKatXBGO6uk/eKuJZM8sy/zhaAeb7lklypDgj4ZlypDAni2
	 aX3frHq47AmWf6p6yQ71SQAHeoNmCbESKpg4nVkGeYSG7kmRAm1m/mtzz3PeBkbbf8
	 wErVA4o3EV0xQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F64CA5FA5;
	Mon, 28 Sep 2026 13:52:13 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Mon, 28 Sep 2026 15:52:07 +0200
Subject: [PATCH] bus: fsl-mc: drop the fwnode links of the dpmacs nodes
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
Message-Id: <20260928-for-upstream-fsl-mc-dpmac-fwnode-links-v1-1-b8976244b38b@free.fr>
X-B4-Tracking: v=1; b=H4sIAAZxumoC/x3NPQ7CMAxA4atUnrFUPFQpV0EMaeKARfMjmwJS1
 bsTMX7LezsYq7DBZdhB+S0mtXScTwOEhy93RondQCNN40wOU1Xcmr2UfcZkK+aAsWUfMH1KjYy
 rlKfhRLQ49nGZnYcea8pJvv/R9XYcPyxG4uV4AAAA
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790603532; l=2306;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=1JT8cCZAXY4kQa0R2Q4UFo1Xst/5Or/QNRjHLJIMOVA=;
 b=6Hz8SIymAGcIVfMH4oZSYHZ103fey0tK7MYzBai9ppIO2uluoOJzO6yewQfRpQBAyxrygqkgz
 TDNOlCcKT5rBaW58LEjaXZdheScWhs3KHGR6mXq1OB7YR9lXMDcdhCt
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

Signed-off-by: Vincent Jardin <vjardin@free.fr>
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



