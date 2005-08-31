Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4032168123
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 14:32:41 +1000 (EST)
Date: Tue, 30 Aug 2005 21:32:38 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050831043238.GB15639@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: add dcr_base field to ocp_func_mal_data
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add dcr_base field to ocp_func_mal_data. This is preparation step for 
the new EMAC driver.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
---

 arch/ppc/platforms/4xx/ibm405ep.c  |    1 +
 arch/ppc/platforms/4xx/ibm405gp.c  |    1 +
 arch/ppc/platforms/4xx/ibm405gpr.c |    1 +
 arch/ppc/platforms/4xx/ibm440ep.c  |    1 +
 arch/ppc/platforms/4xx/ibm440gp.c  |    1 +
 arch/ppc/platforms/4xx/ibm440gx.c  |    1 +
 arch/ppc/platforms/4xx/ibm440sp.c  |    1 +
 arch/ppc/platforms/4xx/ibmnp405h.c |    1 +
 include/asm-ppc/ibm_ocp.h          |    3 +++
 9 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/4xx/ibm405ep.c b/arch/ppc/platforms/4xx/ibm405ep.c
--- a/arch/ppc/platforms/4xx/ibm405ep.c
+++ b/arch/ppc/platforms/4xx/ibm405ep.c
@@ -33,6 +33,7 @@ static struct ocp_func_mal_data ibm405ep
 	.txde_irq	= 13,		/* TX Descriptor Error IRQ */
 	.rxde_irq	= 14,		/* RX Descriptor Error IRQ */
 	.serr_irq	= 10,		/* MAL System Error IRQ    */
+	.dcr_base	= DCRN_MAL_BASE /* MAL0_CFG DCR number */
 };
 OCP_SYSFS_MAL_DATA()
 
diff --git a/arch/ppc/platforms/4xx/ibm405gp.c b/arch/ppc/platforms/4xx/ibm405gp.c
--- a/arch/ppc/platforms/4xx/ibm405gp.c
+++ b/arch/ppc/platforms/4xx/ibm405gp.c
@@ -46,6 +46,7 @@ static struct ocp_func_mal_data ibm405gp
 	.txde_irq	= 13,		/* TX Descriptor Error IRQ */
 	.rxde_irq	= 14,		/* RX Descriptor Error IRQ */
 	.serr_irq	= 10,		/* MAL System Error IRQ    */
+	.dcr_base	= DCRN_MAL_BASE /* MAL0_CFG DCR number */
 };
 OCP_SYSFS_MAL_DATA()
 
diff --git a/arch/ppc/platforms/4xx/ibm405gpr.c b/arch/ppc/platforms/4xx/ibm405gpr.c
--- a/arch/ppc/platforms/4xx/ibm405gpr.c
+++ b/arch/ppc/platforms/4xx/ibm405gpr.c
@@ -42,6 +42,7 @@ static struct ocp_func_mal_data ibm405gp
 	.txde_irq	= 13,		/* TX Descriptor Error IRQ */
 	.rxde_irq	= 14,		/* RX Descriptor Error IRQ */
 	.serr_irq	= 10,		/* MAL System Error IRQ    */
+	.dcr_base	= DCRN_MAL_BASE /* MAL0_CFG DCR number */
 };
 OCP_SYSFS_MAL_DATA()
 
diff --git a/arch/ppc/platforms/4xx/ibm440ep.c b/arch/ppc/platforms/4xx/ibm440ep.c
--- a/arch/ppc/platforms/4xx/ibm440ep.c
+++ b/arch/ppc/platforms/4xx/ibm440ep.c
@@ -53,6 +53,7 @@ static struct ocp_func_mal_data ibm440ep
 	.txde_irq	= 33,		/* TX Descriptor Error IRQ */
 	.rxde_irq	= 34,		/* RX Descriptor Error IRQ */
 	.serr_irq	= 32,		/* MAL System Error IRQ    */
+	.dcr_base	= DCRN_MAL_BASE /* MAL0_CFG DCR number */
 };
 OCP_SYSFS_MAL_DATA()
 
diff --git a/arch/ppc/platforms/4xx/ibm440gp.c b/arch/ppc/platforms/4xx/ibm440gp.c
--- a/arch/ppc/platforms/4xx/ibm440gp.c
+++ b/arch/ppc/platforms/4xx/ibm440gp.c
@@ -56,6 +56,7 @@ static struct ocp_func_mal_data ibm440gp
 	.txde_irq	= 33,		/* TX Descriptor Error IRQ */
 	.rxde_irq	= 34,		/* RX Descriptor Error IRQ */
 	.serr_irq	= 32,		/* MAL System Error IRQ    */
+	.dcr_base	= DCRN_MAL_BASE /* MAL0_CFG DCR number */
 };
 OCP_SYSFS_MAL_DATA()
 
diff --git a/arch/ppc/platforms/4xx/ibm440gx.c b/arch/ppc/platforms/4xx/ibm440gx.c
--- a/arch/ppc/platforms/4xx/ibm440gx.c
+++ b/arch/ppc/platforms/4xx/ibm440gx.c
@@ -84,6 +84,7 @@ static struct ocp_func_mal_data ibm440gx
 	.txde_irq	= 33,		/* TX Descriptor Error IRQ */
 	.rxde_irq	= 34,		/* RX Descriptor Error IRQ */
 	.serr_irq	= 32,		/* MAL System Error IRQ    */
+	.dcr_base	= DCRN_MAL_BASE /* MAL0_CFG DCR number */
 };
 OCP_SYSFS_MAL_DATA()
 
diff --git a/arch/ppc/platforms/4xx/ibm440sp.c b/arch/ppc/platforms/4xx/ibm440sp.c
--- a/arch/ppc/platforms/4xx/ibm440sp.c
+++ b/arch/ppc/platforms/4xx/ibm440sp.c
@@ -43,6 +43,7 @@ static struct ocp_func_mal_data ibm440sp
 	.txde_irq	= 34,		/* TX Descriptor Error IRQ */
 	.rxde_irq	= 35,		/* RX Descriptor Error IRQ */
 	.serr_irq	= 33,		/* MAL System Error IRQ    */
+	.dcr_base	= DCRN_MAL_BASE /* MAL0_CFG DCR number */
 };
 OCP_SYSFS_MAL_DATA()
 
diff --git a/arch/ppc/platforms/4xx/ibmnp405h.c b/arch/ppc/platforms/4xx/ibmnp405h.c
--- a/arch/ppc/platforms/4xx/ibmnp405h.c
+++ b/arch/ppc/platforms/4xx/ibmnp405h.c
@@ -73,6 +73,7 @@ static struct ocp_func_mal_data ibmnp405
 	.txde_irq	= 46,		/* TX Descriptor Error IRQ */
 	.rxde_irq	= 47,		/* RX Descriptor Error IRQ */
 	.serr_irq	= 45,		/* MAL System Error IRQ    */
+	.dcr_base	= DCRN_MAL_BASE /* MAL0_CFG DCR number */
 };
 OCP_SYSFS_MAL_DATA()
 
diff --git a/include/asm-ppc/ibm_ocp.h b/include/asm-ppc/ibm_ocp.h
--- a/include/asm-ppc/ibm_ocp.h
+++ b/include/asm-ppc/ibm_ocp.h
@@ -146,6 +146,7 @@ struct ocp_func_mal_data {
 	int	txde_irq;	/* TX Descriptor Error IRQ */
 	int	rxde_irq;	/* RX Descriptor Error IRQ */
 	int	serr_irq;	/* MAL System Error IRQ    */
+	int	dcr_base;	/* MALx_CFG DCR number   */
 };
 
 #define OCP_SYSFS_MAL_DATA()						\
@@ -156,6 +157,7 @@ OCP_SYSFS_ADDTL(struct ocp_func_mal_data
 OCP_SYSFS_ADDTL(struct ocp_func_mal_data, "%d\n", mal, txde_irq)	\
 OCP_SYSFS_ADDTL(struct ocp_func_mal_data, "%d\n", mal, rxde_irq)	\
 OCP_SYSFS_ADDTL(struct ocp_func_mal_data, "%d\n", mal, serr_irq)	\
+OCP_SYSFS_ADDTL(struct ocp_func_mal_data, "%d\n", mal, dcr_base)	\
 									\
 void ocp_show_mal_data(struct device *dev)				\
 {									\
@@ -166,6 +168,7 @@ void ocp_show_mal_data(struct device *de
 	device_create_file(dev, &dev_attr_mal_txde_irq);		\
 	device_create_file(dev, &dev_attr_mal_rxde_irq);		\
 	device_create_file(dev, &dev_attr_mal_serr_irq);		\
+	device_create_file(dev, &dev_attr_mal_dcr_base);		\
 }
 
 /*
