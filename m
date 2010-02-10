Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE1A6B7D15
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 20:08:38 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: Fix L2-cache support for 460GT
Date: Wed, 10 Feb 2010 10:08:17 +0100
Message-Id: <1265792897-26266-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also set L2C_CFG_RDBW on 460GT platforms and not only on 460EX.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/sysdev/ppc4xx_soc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_soc.c b/arch/powerpc/sysdev/ppc4xx_soc.c
index 5b32adc..5c01435 100644
--- a/arch/powerpc/sysdev/ppc4xx_soc.c
+++ b/arch/powerpc/sysdev/ppc4xx_soc.c
@@ -174,7 +174,8 @@ static int __init ppc4xx_l2c_probe(void)
 		| L2C_CFG_CPIM | L2C_CFG_TPIM | L2C_CFG_LIM | L2C_CFG_SMCM;
 
 	/* Check for 460EX/GT special handling */
-	if (of_device_is_compatible(np, "ibm,l2-cache-460ex"))
+	if (of_device_is_compatible(np, "ibm,l2-cache-460ex") ||
+	    of_device_is_compatible(np, "ibm,l2-cache-460gt"))
 		r |= L2C_CFG_RDBW;
 
 	mtdcr(dcrbase_l2c + DCRN_L2C0_CFG, r);
-- 
1.6.6.1
