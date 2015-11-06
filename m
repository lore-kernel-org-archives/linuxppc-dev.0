Return-Path: <danielwa@cisco.com>
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55A851A0D5F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 11:31:25 +1100 (AEDT)
From: Daniel Walker <danielwa@cisco.com>
To: Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Cc: xe-kernel@external.cisco.com, dbeazley@cisco.com, dwalker@fifo99.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: platform: 85xx: mpc85xx ADS: remove pci exclude
Date: Thu,  5 Nov 2015 16:31:21 -0800
Message-Id: <1446769881-17946-1-git-send-email-danielwa@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code was reworked in commit,

905e75c46dba5f3061049277e4eb7110beedba43

This change removed the fsl_add_bridge() which originally was above
the addition of the pci_exclude_device function. I think the assumption was that
the pci_exclude_device would prevent changes to the bridge PCI config after
it's been added. It seems it wasn't fully tested on MPC85xx ADS because
if you move the fsl_add_bridge() the pci_exclude_device is set in the machine
description then you can never update the PCI Config since the exclude
prevents it. This disrupts things like DMA.

This issue was extensively debugged by David Beazley.

Cc: xe-kernel@external.cisco.com
Cc: dbeazley@cisco.com
Cc: dwalker@fifo99.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_ads.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 7d12a19..de72a5f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -36,17 +36,6 @@
 
 #include "mpc85xx.h"
 
-#ifdef CONFIG_PCI
-static int mpc85xx_exclude_device(struct pci_controller *hose,
-				   u_char bus, u_char devfn)
-{
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	else
-		return PCIBIOS_SUCCESSFUL;
-}
-#endif /* CONFIG_PCI */
-
 static void __init mpc85xx_ads_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN,
@@ -145,10 +134,6 @@ static void __init mpc85xx_ads_setup_arch(void)
 	init_ioports();
 #endif
 
-#ifdef CONFIG_PCI
-	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
-#endif
-
 	fsl_pci_assign_primary();
 }
 
-- 
2.1.4
