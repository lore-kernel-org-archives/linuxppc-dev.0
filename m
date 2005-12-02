Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B9F796884E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 20:12:07 +1100 (EST)
Date: Fri, 2 Dec 2005 01:12:05 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20051202091205.GB16031@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: remove "jumbo" member from ocp_func_emac_data
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch removes not needed anymore "jumbo" member from 
ocp_func_emac_data. Jumbo frame support is handled by PPC4xx EMAC 
driver internally now.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
---

 arch/ppc/platforms/4xx/ibm440gx.c |    2 --
 arch/ppc/platforms/4xx/ibm440sp.c |    1 -
 include/asm-ppc/ibm_ocp.h         |    1 -
 3 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/platforms/4xx/ibm440gx.c b/arch/ppc/platforms/4xx/ibm440gx.c
index 956f45e..d24c09e 100644
--- a/arch/ppc/platforms/4xx/ibm440gx.c
+++ b/arch/ppc/platforms/4xx/ibm440gx.c
@@ -58,7 +58,6 @@ static struct ocp_func_emac_data ibm440g
 	.wol_irq        = 65,  		/* WOL interrupt number */
 	.mdio_idx       = -1,           /* No shared MDIO */
 	.tah_idx	= 0,		/* TAH device index */
-	.jumbo		= 1,		/* Jumbo frames supported */
 };
 
 static struct ocp_func_emac_data ibm440gx_emac3_def = {
@@ -72,7 +71,6 @@ static struct ocp_func_emac_data ibm440g
 	.wol_irq        = 67,  		/* WOL interrupt number */
 	.mdio_idx       = -1,           /* No shared MDIO */
 	.tah_idx	= 1,		/* TAH device index */
-	.jumbo		= 1,		/* Jumbo frames supported */
 };
 OCP_SYSFS_EMAC_DATA()
 
diff --git a/arch/ppc/platforms/4xx/ibm440sp.c b/arch/ppc/platforms/4xx/ibm440sp.c
index feb17e4..71a0117 100644
--- a/arch/ppc/platforms/4xx/ibm440sp.c
+++ b/arch/ppc/platforms/4xx/ibm440sp.c
@@ -31,7 +31,6 @@ static struct ocp_func_emac_data ibm440s
 	.wol_irq        = 61,  		/* WOL interrupt number */
 	.mdio_idx       = -1,           /* No shared MDIO */
 	.tah_idx	= -1,		/* No TAH */
-	.jumbo		= 1,		/* Jumbo frames supported */
 };
 OCP_SYSFS_EMAC_DATA()
 
diff --git a/include/asm-ppc/ibm_ocp.h b/include/asm-ppc/ibm_ocp.h
index 9c21de1..ddce616 100644
--- a/include/asm-ppc/ibm_ocp.h
+++ b/include/asm-ppc/ibm_ocp.h
@@ -63,7 +63,6 @@ struct ocp_func_emac_data {
 	int	wol_irq;	/* WOL interrupt */
 	int	mdio_idx;	/* EMAC idx of MDIO master or -1 */
 	int	tah_idx;	/* TAH device index or -1 */
-	int	jumbo;		/* Jumbo frames capable flag */
 	int	phy_mode;	/* PHY type or configurable mode */
 	u8	mac_addr[6];	/* EMAC mac address */
 	u32	phy_map;	/* EMAC phy map */
