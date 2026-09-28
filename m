Return-Path: <linuxppc-dev+bounces-28410-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792D9CA5FA2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 13:48:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htjLw01qBz2y2B;
	Mon, 28 Sep 2026 23:48:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790603303;
	cv=none; b=NrxiUn0zW5y+0hKI2aZwvuC2L7AbrsJB6hRIEOZgV9F0A/BU3U7A0/l/Y1iggwTgOZg2siNcbaG5EnRKjrJOqE2TO6c66fTV0oF4SDGxICDjsyWfI4SbETdc7y5WWfw48PmEwnq1JkuTnWcfH08dT6bT9wjentQTVLOnPdnI6uOIrrnmkpQ0f0lZoMx45BJdn4V0za/UvA/9fC0Gs1c6eDLIFe5hjbsUDf/X8EED67KXdTpRVPgnWNekJo3YFniCUtfzkfHYazOj5vz3GC5ZOzSH3o8HK7nSgzsRiqbhC54d4ynMT5i3PWrCPfFzG7b+9ACpPF4AsDLYwAqRGwZHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790603303; c=relaxed/relaxed;
	bh=pKJNhHU9/ufu6hDD6ncBtRaVdBf5TTfF+q6Ja87ZwEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oDvQlknM5xf9njUMhJC23TlLgTKt9vVakz3XnY8y8DYtgoLd1hupYWq1/L9CXPa9FF0n1EXzT3yEYZdtH9D8VS1TplaQ8aJjMC3SrmcGEKd24I1HaHs7ojD8AiAmNNVozAQR9pVY4jYl9IHQ5yOQausgHG5Ony++MwFADP8TYYpisBOMy6zNEjocRkvRm9gYxkIPBI8BqM/jPxpfg1BxYfB7FrGB5QT0yBQVJqF9Ym65/J+1IopLEjlrhC+hxnxBWYpp811OSl3hQnsh1OxphuK1sy7/u9PE3ASIhgB2EuPJs9DhwCMbnBYJCr7AEnPZNOMHvGsGH5v86PpiXQ+zHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=knBf0MIz; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=knBf0MIz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htjLv0TQMz2y25
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 23:48:23 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F0E91600D1;
	Mon, 28 Sep 2026 13:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AD6DC2BCB3;
	Mon, 28 Sep 2026 13:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790603299;
	bh=0T3U1aXBXMuP/XUFiuZsj0r9Vk56wjPuqVb7adaAvic=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=knBf0MIzn6sk7yr3oA3wKkTe2rroEzCAJZWyp52BmFNmOa1lqkQh1tyuWDAPyosnb
	 sRLsxsO0HxAR0+xWGkBn70bhL0cU66TYegfPjv1SFz1/UZM8TSzQcFuwnP8eoIr/mb
	 wDtz3DjKFTEybFFVb3yqT5JN45FI5LJRLeeczEi2YWm8LoA5lC64odJfDplJvpEpx3
	 dtyDkxANC/jT5L40zHzZEH469oGLN34eRu9Z8Hq+SxqwFLvOvksF31Imn05xYu6SD1
	 7j7ty5IvHBUP4DYHJGgBPE4pyb3QbjTZVQO6y7gynZrd+tbZNPAYrlXjKJmVdoSttS
	 CmLhK5PB2vTKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B0ECA5FA5;
	Mon, 28 Sep 2026 13:48:19 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Mon, 28 Sep 2026 15:48:09 +0200
Subject: [PATCH] PCI: layerscape: async probe by default
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
Message-Id: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
X-B4-Tracking: v=1; b=H4sIABhwumoC/x3NTQrCQAxA4auUrA3EwZ/Wq4iLmKYa0JkhUbGU3
 t3B5bd5b4FQNw04dQu4fiys5IbtpgO5c74p2tgMidKBhtTjVBzfNV6u/MQqhg+e1UO4KnLMWbB
 6uSpSvxPW/UgDHaHVqutk3//pfFnXH+yB0fl5AAAA
To: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Roy Zang <roy.zang@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790603298; l=1374;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=FiRn9OiNUjwkWfk6TfzHBQosBVCt2Ztr46nw5buAh4w=;
 b=61ATACnDyWjW6rV7RTXwL9RyAdZDzlU6eY1kSxfh9+/akDvP2PLaEXFhAq3GqnDqV6ZPd/ELZ
 2Cg7PafmqWID96UsYC+Ox031k8ImTNnycQ3by9yvKvgRkTiJ4assXMc
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

dw_pcie_wait_for_link() polls for up to
  PCIE_LINK_WAIT_MAX_RETRIES x PCIE_LINK_WAIT_SLEEP_MS (10 x 90 ms)
per controller.

The controllers are probed one after the other, so, it leads to slow
boot time.

On an LX2160A board with 4 enabled controllers and no link on any
of them, ls_pcie_driver_init took almost 4s.

Probing the 4 in parallel allows to have it down to 1s.

The controllers are independent, other DWC based drivers are already
using async probing such as qcom, imx6, s32g, rcar-gen4 or stm32.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 14d6ac4fc53f..7f37a0537159 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -419,6 +419,7 @@ static struct platform_driver ls_pcie_driver = {
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
 		.pm = &ls_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_platform_driver(ls_pcie_driver);

---
base-commit: 94e8d4e94266bb9737a5963810a3f9365cb2f39d
change-id: 20260928-for-upstream-pci-layerscape-async-probe-084cae5d0907

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>



