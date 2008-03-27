Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id CC1E4DE0A4
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 02:34:58 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Only reset PCIe PHY on 405EX systems when no
	link is detected
Date: Thu, 27 Mar 2008 16:34:50 +0100
Message-Id: <1206632090-1012-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since the arch/powerpc PCI subsystem now does a complete re-assignment of
the resources, we can move from the unconditional PCIe PHY reset to the
conditional version. Now the PHY is only reset, if no link is established yet.
An additional PHY reset (one is already done in U-Boot) leads to problems
with some Atheros PCIe boards and some HP FPGA PCIe designs.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 5abfcd1..9e633f8 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -830,17 +830,9 @@ static int ppc405ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 	 * PCIe boards don't show this problem.
 	 * This has to be re-tested and fixed in a later release!
 	 */
-#if 0 /* XXX FIXME: Not resetting the PHY will leave all resources
-       * configured as done previously by U-Boot. Then Linux will currently
-       * not reassign them. So the PHY reset is now done always. This will
-       * lead to problems with the Atheros PCIe board again.
-       */
 	val = mfdcri(SDR0, port->sdr_base + PESDRn_LOOP);
 	if (!(val & 0x00001000))
 		ppc405ex_pcie_phy_reset(port);
-#else
-	ppc405ex_pcie_phy_reset(port);
-#endif
 
 	dcr_write(port->dcrs, DCRO_PEGPL_CFG, 0x10000000);  /* guarded on */
 
-- 
1.5.4.4
