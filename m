Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 5E181DE1A3
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 00:22:42 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: PCIe driver now detects if a port is disabled
	via the dev-tree
Date: Thu,  5 Jun 2008 16:22:29 +0200
Message-Id: <1212675749-29861-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch add a check to the PPC4xx PCIe driver to detect if the port
is disabled via the device-tree. This is needed for the AMCC Canyonlands
board which has an option to either select 2 PCIe ports or 1 PCIe port
and one SATA port. The SATA port and the 1st PCIe port pins are multiplexed
so we can't start both drivers.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index b4a54c5..76886cf 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1634,6 +1634,15 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
 	}
 	port = &ppc4xx_pciex_ports[portno];
 	port->index = portno;
+
+	/*
+	 * Check if device is enabled
+	 */
+	if (!of_device_is_available(np)) {
+		printk(KERN_INFO "PCIE%d: Port disabled via device-tree\n", port->index);
+		return;
+	}
+
 	port->node = of_node_get(np);
 	pval = of_get_property(np, "sdr-base", NULL);
 	if (pval == NULL) {
-- 
1.5.5.3
