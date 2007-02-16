Return-Path: <afleming@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A8C5CDDDE9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:44:48 +1100 (EST)
Date: Thu, 15 Feb 2007 20:44:04 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	jdl@jdl.com
Subject: [RFC 2/7] Unite all PCI-e on 85xx and 86xx under one codebase
Message-ID: <Pine.LNX.4.61.0702152043270.9034@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add 85xx PCI express memory map register.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Acked-by: Andy Fleming <afleming@freescale.com>
---
 include/asm-ppc/immap_85xx.h |   75 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/include/asm-ppc/immap_85xx.h b/include/asm-ppc/immap_85xx.h
index b35cd6a..adef8c7 100644
--- a/include/asm-ppc/immap_85xx.h
+++ b/include/asm-ppc/immap_85xx.h
@@ -87,6 +87,81 @@ typedef struct ccsr_pci {
 	char	res19[472];
 } ccsr_pci_t;
 
+/* PCI Express Registers */
+typedef struct ccsr_pex {
+	uint    pex_config_addr;        /* 0x.000 - PCI Express Configuration Address Register */
+	uint    pex_config_data;        /* 0x.004 - PCI Express Configuration Data Register */
+	char    res1[4];
+	uint    pex_otb_cpl_tor;        /* 0x.00c - PCI Express Outbound completion timeout register */
+	uint    pex_conf_tor;           /* 0x.010 - PCI Express configuration timeout register */
+	char    res2[12];
+	uint    pex_pme_mes_dr;         /* 0x.020 - PCI Express PME and message detect register */
+	uint    pex_pme_mes_disr;       /* 0x.024 - PCI Express PME and message disable register */
+	uint    pex_pme_mes_ier;        /* 0x.028 - PCI Express PME and message interrupt enable register */
+	uint    pex_pmcr;               /* 0x.02c - PCI Express power management command register */
+	char    res3[3024];
+	uint    pexotar0;               /* 0x.c00 - PCI Express outbound translation address register 0 */
+	uint    pexotear0;              /* 0x.c04 - PCI Express outbound translation extended address register 0*/
+	char    res4[8];
+	uint    pexowar0;               /* 0x.c10 - PCI Express outbound window attributes register 0*/
+	char    res5[12];
+	uint    pexotar1;               /* 0x.c20 - PCI Express outbound translation address register 1 */
+	uint    pexotear1;              /* 0x.c24 - PCI Express outbound translation extended address register 1*/
+	uint    pexowbar1;              /* 0x.c28 - PCI Express outbound window base address register 1*/
+	char    res6[4];
+	uint    pexowar1;               /* 0x.c30 - PCI Express outbound window attributes register 1*/
+	char    res7[12];
+	uint    pexotar2;               /* 0x.c40 - PCI Express outbound translation address register 2 */
+	uint    pexotear2;              /* 0x.c44 - PCI Express outbound translation extended address register 2*/
+	uint    pexowbar2;              /* 0x.c48 - PCI Express outbound window base address register 2*/
+	char    res8[4];
+	uint    pexowar2;               /* 0x.c50 - PCI Express outbound window attributes register 2*/
+	char    res9[12];
+	uint    pexotar3;               /* 0x.c60 - PCI Express outbound translation address register 3 */
+	uint    pexotear3;              /* 0x.c64 - PCI Express outbound translation extended address register 3*/
+	uint    pexowbar3;              /* 0x.c68 - PCI Express outbound window base address register 3*/
+	char    res10[4];
+	uint    pexowar3;               /* 0x.c70 - PCI Express outbound window attributes register 3*/
+	char    res11[12];
+	uint    pexotar4;               /* 0x.c80 - PCI Express outbound translation address register 4 */
+	uint    pexotear4;              /* 0x.c84 - PCI Express outbound translation extended address register 4*/
+	uint    pexowbar4;              /* 0x.c88 - PCI Express outbound window base address register 4*/
+	char    res12[4];
+	uint    pexowar4;               /* 0x.c90 - PCI Express outbound window attributes register 4*/
+	char    res13[12];
+	char    res14[256];
+	uint    pexitar3;               /* 0x.da0 - PCI Express inbound translation address register 3 */
+	char    res15[4];
+	uint    pexiwbar3;              /* 0x.da8 - PCI Express inbound window base address register 3 */
+	uint    pexiwbear3;             /* 0x.dac - PCI Express inbound window base extended address register 3 */
+	uint    pexiwar3;               /* 0x.db0 - PCI Express inbound window attributes register 3 */
+	char    res16[12];
+	uint    pexitar2;               /* 0x.dc0 - PCI Express inbound translation address register 2 */
+	char    res17[4];
+	uint    pexiwbar2;              /* 0x.dc8 - PCI Express inbound window base address register 2 */
+	uint    pexiwbear2;             /* 0x.dcc - PCI Express inbound window base extended address register 2 */
+	uint    pexiwar2;               /* 0x.dd0 - PCI Express inbound window attributes register 2 */
+	char    res18[12];
+	uint    pexitar1;               /* 0x.de0 - PCI Express inbound translation address register 2 */
+	char    res19[4];
+	uint    pexiwbar1;              /* 0x.de8 - PCI Express inbound window base address register 2 */
+	uint    pexiwbear1;             /* 0x.dec - PCI Express inbound window base extended address register 2 */
+	uint    pexiwar1;               /* 0x.df0 - PCI Express inbound window attributes register 2 */
+	char    res20[12];
+	uint    pex_err_dr;             /* 0x.e00 - PCI Express error detect register */
+	char    res21[4];
+	uint    pex_err_en;             /* 0x.e08 - PCI Express error interrupt enable register */
+	char    res22[4];
+	uint    pex_err_disr;           /* 0x.e10 - PCI Express error disable register */
+	char    res23[12];
+	uint    pex_err_cap_stat;       /* 0x.e20 - PCI Express error capture status register */
+	char    res24[4];
+	uint    pex_err_cap_r0;         /* 0x.e28 - PCI Express error capture register 0 */
+	uint    pex_err_cap_r1;         /* 0x.e2c - PCI Express error capture register 0 */
+	uint    pex_err_cap_r2;         /* 0x.e30 - PCI Express error capture register 0 */
+	uint    pex_err_cap_r3;         /* 0x.e34 - PCI Express error capture register 0 */
+} ccsr_pex_t;
+
 /* Global Utility Registers */
 typedef struct ccsr_guts {
 	uint	porpllsr;	/* 0x.0000 - POR PLL Ratio Status Register */
-- 
1.4.4
