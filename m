Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 32CD8DE0F4
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 00:45:35 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Fix PESDRn_UTLSET1 register setup on 460EX/GT
Date: Tue,  1 Apr 2008 15:45:00 +0200
Message-Id: <1207057500-18553-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch fixes a bug, where the PESDRn_UTLSET1 register was setup
wrongly resulting in a non working PCIe port 1. With this fix both
PCIe ports work fine again.

Signed-off-by: Stefan Roese <sr@denx.de>
---
Based upon linux-next repo from 2008-03-31

 arch/powerpc/sysdev/ppc4xx_pci.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 6c925b7..efaf4c4 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -785,19 +785,17 @@ static int ppc460ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 	u32 val;
 	u32 utlset1;
 
-	if (port->endpoint) {
+	if (port->endpoint)
 		val = PTYPE_LEGACY_ENDPOINT << 20;
-		utlset1 = 0x20222222;
-	} else {
+	else
 		val = PTYPE_ROOT_PORT << 20;
-		utlset1 = 0x21222222;
-	}
 
 	if (port->index == 0) {
 		val |= LNKW_X1 << 12;
+		utlset1 = 0x20000000;
 	} else {
 		val |= LNKW_X4 << 12;
-		utlset1 |= 0x00101101;
+		utlset1 = 0x20101101;
 	}
 
 	mtdcri(SDR0, port->sdr_base + PESDRn_DLPSET, val);
-- 
1.5.4.5
