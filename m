Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F11CC1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 08:15:39 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/28] pci: host: drop owner assignment from platform_drivers
Date: Sun, 21 Dec 2014 22:14:34 +0100
Message-Id: <1419196495-9626-14-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linuxppc-dev@lists.ozlabs.org,
 Minghuan Lian <minghuan.Lian@freescale.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 drivers/pci/host/pci-layerscape.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 6697b1a4d4fa..68c9e5e9b0a8 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -167,7 +167,6 @@ MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
 static struct platform_driver ls_pcie_driver = {
 	.driver = {
 		.name = "layerscape-pcie",
-		.owner = THIS_MODULE,
 		.of_match_table = ls_pcie_of_match,
 	},
 };
-- 
2.1.3
