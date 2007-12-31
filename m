Return-Path: <SRS0=QU/5=RW=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 33BBCDDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Dec 2007 16:41:18 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: PCIe: Increase max busses per port to 64
Date: Mon, 31 Dec 2007 06:41:15 +0100
Message-Id: <1199079675-17835-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Because of how big mapping the config space is (1M per bus), we limit how
many busses we support for now. In the long run, we could replace that
with something akin to kmap_atomic instead.

This patch changes the limit from currently 16 to 64.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 3c2c14c..5abfcd1 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -533,7 +533,7 @@ static void __init ppc4xx_probe_pcix_bridge(struct device_node *np)
  *
  */
 
-#define MAX_PCIE_BUS_MAPPED	0x10
+#define MAX_PCIE_BUS_MAPPED	0x40
 
 struct ppc4xx_pciex_port
 {
-- 
1.5.4.rc2
