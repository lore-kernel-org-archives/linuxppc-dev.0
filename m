Return-Path: <SRS0=99Ew=Q6=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 7A103DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 20:34:40 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] [POWERPC] 4xx: Set ibpre for 405EX in 4xx PCIe driver
Date: Fri,  7 Dec 2007 10:34:34 +0100
Message-Id: <1197020074-22146-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch sets the ibpre flag (Inbound Presence) for the 405EX
in the 4xx PCIe driver.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 29fa095..bd85a40 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -842,6 +842,8 @@ static int ppc405ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 
 	dcr_write(port->dcrs, DCRO_PEGPL_CFG, 0x10000000);  /* guarded on */
 
+	port->has_ibpre = 1;
+
 	return 0;
 }
 
-- 
1.5.3.7.949.g2221a6
