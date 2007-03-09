Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id AF626DDE2C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 18:50:40 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l297oZos014544
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 00:50:36 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l297oYSe020930
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 01:50:35 -0600 (CST)
Subject: [patch]: Unify PCI Express memory map registers structure define
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1173161436.9465.91.camel@localhost.localdomain>
References: <1173161436.9465.91.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1173418047.20626.5.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 09 Mar 2007 13:27:28 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Unify PCI Express memory map registers structure define
to arch/pwoerpc/sysdev/fsl_pcie.h for Freescale 85xx/86xx 
processor family.
arch/ppc will not support PCI Express for 85xx/86xx.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---

 arch/powerpc/platforms/86xx/pci.c |    2 -
 arch/powerpc/sysdev/fsl_pcie.h    |   94 +++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/immap_86xx.h  |   75 ------------------------------
 3 files changed, 95 insertions(+), 76 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 481e18e..ba86c48 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -22,9 +22,9 @@ #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/io.h>
 #include <asm/prom.h>
-#include <asm/immap_86xx.h>
 #include <asm/pci-bridge.h>
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pcie.h>
 
 #include "mpc86xx.h"
 
diff --git a/arch/powerpc/sysdev/fsl_pcie.h b/arch/powerpc/sysdev/fsl_pcie.h
new file mode 100644
index 0000000..8d9779c
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_pcie.h
@@ -0,0 +1,94 @@
+/*
+ * MPC85xx/86xx PCI Express structure define
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __POWERPC_FSL_PCIE_H
+#define __POWERPC_FSL_PCIE_H
+
+/* PCIE Express IO block registers in 85xx/86xx */
+
+struct ccsr_pex {
+	__be32 __iomem    pex_config_addr;	/* 0x.000 - PCI Express Configuration Address Register */
+	__be32 __iomem    pex_config_data;	/* 0x.004 - PCI Express Configuration Data Register */
+	u8 __iomem    res1[4];
+	__be32 __iomem    pex_otb_cpl_tor;	/* 0x.00c - PCI Express Outbound completion timeout register */
+	__be32 __iomem    pex_conf_tor;		/* 0x.010 - PCI Express configuration timeout register */
+	u8 __iomem    res2[12];
+	__be32 __iomem    pex_pme_mes_dr;	/* 0x.020 - PCI Express PME and message detect register */
+	__be32 __iomem    pex_pme_mes_disr;	/* 0x.024 - PCI Express PME and message disable register */
+	__be32 __iomem    pex_pme_mes_ier;	/* 0x.028 - PCI Express PME and message interrupt enable register */
+	__be32 __iomem    pex_pmcr;		/* 0x.02c - PCI Express power management command register */
+	u8 __iomem    res3[3024];
+	__be32 __iomem    pexotar0;		/* 0x.c00 - PCI Express outbound translation address register 0 */
+	__be32 __iomem    pexotear0;		/* 0x.c04 - PCI Express outbound translation extended address register 0*/
+	u8 __iomem    res4[8];
+	__be32 __iomem    pexowar0;		/* 0x.c10 - PCI Express outbound window attributes register 0*/
+	u8 __iomem    res5[12];
+	__be32 __iomem    pexotar1;		/* 0x.c20 - PCI Express outbound translation address register 1 */
+	__be32 __iomem    pexotear1;		/* 0x.c24 - PCI Express outbound translation extended address register 1*/
+	__be32 __iomem    pexowbar1;		/* 0x.c28 - PCI Express outbound window base address register 1*/
+	u8 __iomem    res6[4];
+	__be32 __iomem    pexowar1;		/* 0x.c30 - PCI Express outbound window attributes register 1*/
+	u8 __iomem    res7[12];
+	__be32 __iomem    pexotar2;		/* 0x.c40 - PCI Express outbound translation address register 2 */
+	__be32 __iomem    pexotear2;		/* 0x.c44 - PCI Express outbound translation extended address register 2*/
+	__be32 __iomem    pexowbar2;		/* 0x.c48 - PCI Express outbound window base address register 2*/
+	u8 __iomem    res8[4];
+	__be32 __iomem    pexowar2;		/* 0x.c50 - PCI Express outbound window attributes register 2*/
+	u8 __iomem    res9[12];
+	__be32 __iomem    pexotar3;		/* 0x.c60 - PCI Express outbound translation address register 3 */
+	__be32 __iomem    pexotear3;		/* 0x.c64 - PCI Express outbound translation extended address register 3*/
+	__be32 __iomem    pexowbar3;		/* 0x.c68 - PCI Express outbound window base address register 3*/
+	u8 __iomem    res10[4];
+	__be32 __iomem    pexowar3;		/* 0x.c70 - PCI Express outbound window attributes register 3*/
+	u8 __iomem    res11[12];
+	__be32 __iomem    pexotar4;		/* 0x.c80 - PCI Express outbound translation address register 4 */
+	__be32 __iomem    pexotear4;		/* 0x.c84 - PCI Express outbound translation extended address register 4*/
+	__be32 __iomem    pexowbar4;		/* 0x.c88 - PCI Express outbound window base address register 4*/
+	u8 __iomem    res12[4];
+	__be32 __iomem    pexowar4;		/* 0x.c90 - PCI Express outbound window attributes register 4*/
+	u8 __iomem    res13[12];
+	u8 __iomem    res14[256];
+	__be32 __iomem    pexitar3;		/* 0x.da0 - PCI Express inbound translation address register 3 */
+	u8 __iomem    res15[4];
+	__be32 __iomem    pexiwbar3;		/* 0x.da8 - PCI Express inbound window base address register 3 */
+	__be32 __iomem    pexiwbear3;		/* 0x.dac - PCI Express inbound window base extended address register 3 */
+	__be32 __iomem    pexiwar3;		/* 0x.db0 - PCI Express inbound window attributes register 3 */
+	u8 __iomem    res16[12];
+	__be32 __iomem    pexitar2;		/* 0x.dc0 - PCI Express inbound translation address register 2 */
+	u8 __iomem    res17[4];
+	__be32 __iomem    pexiwbar2;		/* 0x.dc8 - PCI Express inbound window base address register 2 */
+	__be32 __iomem    pexiwbear2;		/* 0x.dcc - PCI Express inbound window base extended address register 2 */
+	__be32 __iomem    pexiwar2;		/* 0x.dd0 - PCI Express inbound window attributes register 2 */
+	u8 __iomem    res18[12];
+	__be32 __iomem    pexitar1;		/* 0x.de0 - PCI Express inbound translation address register 2 */
+	u8 __iomem    res19[4];
+	__be32 __iomem    pexiwbar1;		/* 0x.de8 - PCI Express inbound window base address register 2 */
+	__be32 __iomem    pexiwbear1;		/* 0x.dec - PCI Express inbound window base extended address register 2 */
+	__be32 __iomem    pexiwar1;		/* 0x.df0 - PCI Express inbound window attributes register 2 */
+	u8 __iomem    res20[12];
+	__be32 __iomem    pex_err_dr;		/* 0x.e00 - PCI Express error detect register */
+	u8 __iomem    res21[4];
+	__be32 __iomem    pex_err_en;		/* 0x.e08 - PCI Express error interrupt enable register */
+	u8 __iomem    res22[4];
+	__be32 __iomem    pex_err_disr;		/* 0x.e10 - PCI Express error disable register */
+	u8 __iomem    res23[12];
+	__be32 __iomem    pex_err_cap_stat;	/* 0x.e20 - PCI Express error capture status register */
+	u8 __iomem    res24[4];
+	__be32 __iomem    pex_err_cap_r0;	/* 0x.e28 - PCI Express error capture register 0 */
+	__be32 __iomem    pex_err_cap_r1;	/* 0x.e2c - PCI Express error capture register 0 */
+	__be32 __iomem    pex_err_cap_r2;	/* 0x.e30 - PCI Express error capture register 0 */
+	__be32 __iomem    pex_err_cap_r3;	/* 0x.e34 - PCI Express error capture register 0 */
+};
+
+#endif /* __POWERPC_FSL_PCIE_H */
+#endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/immap_86xx.h b/include/asm-powerpc/immap_86xx.h
index d905b66..59b9e07 100644
--- a/include/asm-powerpc/immap_86xx.h
+++ b/include/asm-powerpc/immap_86xx.h
@@ -85,81 +85,6 @@ typedef struct ccsr_pci {
 	char	res19[472];
 } ccsr_pci_t;
 
-/* PCI Express Registers */
-typedef struct ccsr_pex {
-	uint    pex_config_addr;        /* 0x.000 - PCI Express Configuration Address Register */
-	uint    pex_config_data;        /* 0x.004 - PCI Express Configuration Data Register */
-	char    res1[4];
-	uint    pex_otb_cpl_tor;        /* 0x.00c - PCI Express Outbound completion timeout register */
-	uint    pex_conf_tor;           /* 0x.010 - PCI Express configuration timeout register */
-	char    res2[12];
-	uint    pex_pme_mes_dr;         /* 0x.020 - PCI Express PME and message detect register */
-	uint    pex_pme_mes_disr;       /* 0x.024 - PCI Express PME and message disable register */
-	uint    pex_pme_mes_ier;        /* 0x.028 - PCI Express PME and message interrupt enable register */
-	uint    pex_pmcr;               /* 0x.02c - PCI Express power management command register */
-	char    res3[3024];
-	uint    pexotar0;               /* 0x.c00 - PCI Express outbound translation address register 0 */
-	uint    pexotear0;              /* 0x.c04 - PCI Express outbound translation extended address register 0*/
-	char    res4[8];
-	uint    pexowar0;               /* 0x.c10 - PCI Express outbound window attributes register 0*/
-	char    res5[12];
-	uint    pexotar1;               /* 0x.c20 - PCI Express outbound translation address register 1 */
-	uint    pexotear1;              /* 0x.c24 - PCI Express outbound translation extended address register 1*/
-	uint    pexowbar1;              /* 0x.c28 - PCI Express outbound window base address register 1*/
-	char    res6[4];
-	uint    pexowar1;               /* 0x.c30 - PCI Express outbound window attributes register 1*/
-	char    res7[12];
-	uint    pexotar2;               /* 0x.c40 - PCI Express outbound translation address register 2 */
-	uint    pexotear2;              /* 0x.c44 - PCI Express outbound translation extended address register 2*/
-	uint    pexowbar2;              /* 0x.c48 - PCI Express outbound window base address register 2*/
-	char    res8[4];
-	uint    pexowar2;               /* 0x.c50 - PCI Express outbound window attributes register 2*/
-	char    res9[12];
-	uint    pexotar3;               /* 0x.c60 - PCI Express outbound translation address register 3 */
-	uint    pexotear3;              /* 0x.c64 - PCI Express outbound translation extended address register 3*/
-	uint    pexowbar3;              /* 0x.c68 - PCI Express outbound window base address register 3*/
-	char    res10[4];
-	uint    pexowar3;               /* 0x.c70 - PCI Express outbound window attributes register 3*/
-	char    res11[12];
-	uint    pexotar4;               /* 0x.c80 - PCI Express outbound translation address register 4 */
-	uint    pexotear4;              /* 0x.c84 - PCI Express outbound translation extended address register 4*/
-	uint    pexowbar4;              /* 0x.c88 - PCI Express outbound window base address register 4*/
-	char    res12[4];
-	uint    pexowar4;               /* 0x.c90 - PCI Express outbound window attributes register 4*/
-	char    res13[12];
-	char    res14[256];
-	uint    pexitar3;               /* 0x.da0 - PCI Express inbound translation address register 3 */
-	char    res15[4];
-	uint    pexiwbar3;              /* 0x.da8 - PCI Express inbound window base address register 3 */
-	uint    pexiwbear3;             /* 0x.dac - PCI Express inbound window base extended address register 3 */
-	uint    pexiwar3;               /* 0x.db0 - PCI Express inbound window attributes register 3 */
-	char    res16[12];
-	uint    pexitar2;               /* 0x.dc0 - PCI Express inbound translation address register 2 */
-	char    res17[4];
-	uint    pexiwbar2;              /* 0x.dc8 - PCI Express inbound window base address register 2 */
-	uint    pexiwbear2;             /* 0x.dcc - PCI Express inbound window base extended address register 2 */
-	uint    pexiwar2;               /* 0x.dd0 - PCI Express inbound window attributes register 2 */
-	char    res18[12];
-	uint    pexitar1;               /* 0x.de0 - PCI Express inbound translation address register 2 */
-	char    res19[4];
-	uint    pexiwbar1;              /* 0x.de8 - PCI Express inbound window base address register 2 */
-	uint    pexiwbear1;             /* 0x.dec - PCI Express inbound window base extended address register 2 */
-	uint    pexiwar1;               /* 0x.df0 - PCI Express inbound window attributes register 2 */
-	char    res20[12];
-	uint    pex_err_dr;             /* 0x.e00 - PCI Express error detect register */
-	char    res21[4];
-	uint    pex_err_en;             /* 0x.e08 - PCI Express error interrupt enable register */
-	char    res22[4];
-	uint    pex_err_disr;           /* 0x.e10 - PCI Express error disable register */
-	char    res23[12];
-	uint    pex_err_cap_stat;       /* 0x.e20 - PCI Express error capture status register */
-	char    res24[4];
-	uint    pex_err_cap_r0;         /* 0x.e28 - PCI Express error capture register 0 */
-	uint    pex_err_cap_r1;         /* 0x.e2c - PCI Express error capture register 0 */
-	uint    pex_err_cap_r2;         /* 0x.e30 - PCI Express error capture register 0 */
-	uint    pex_err_cap_r3;         /* 0x.e34 - PCI Express error capture register 0 */
-} ccsr_pex_t;
-
 /* Global Utility Registers */
 typedef struct ccsr_guts {
 	uint	porpllsr;	/* 0x.0000 - POR PLL Ratio Status Register */
-- 
1.4.0
