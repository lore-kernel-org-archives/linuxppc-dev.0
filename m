Return-Path: <tnt@246tNt.com>
Received: from outmx010.isp.belgacom.be (outmx010.isp.belgacom.be
	[195.238.5.233])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1DDD67A39
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Mar 2006 22:38:26 +1100 (EST)
Received: from outmx010.isp.belgacom.be (localhost [127.0.0.1])
	by outmx010.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k2QBcHpj010489
	for <linuxppc-embedded@ozlabs.org>; Sun, 26 Mar 2006 13:38:17 +0200
	(envelope-from <tnt@246tNt.com>)
Date: Sun, 26 Mar 2006 13:38:09 +0200
Message-ID: <3.20060326_133535_93e6_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Linux PPC embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 3/4] ppc32: Reorganize and complete MPC52xx initial cpu setup
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <0.20060326_133535_93e6_tnt@patchsend.246tNt.com>
References: <0.20060326_133535_93e6_tnt@patchsend.246tNt.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Reorganize and complete MPC52xx initial cpu setup

This patch splits up the CPU setup into a generic part and a
platform specific part. We also add a few missing init at the
same time.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
commit 67015426ff51ba857b7678a993f4ffd6def1941e
tree cca92c1916ede8f67fe8d16987a54303c76f31f8
parent 37ffaaccad4fb48c8416e610aab4d3bed41dfc80
author Sylvain Munaut <tnt@246tNt.com> 1143311892 +0100
committer Sylvain Munaut <tnt@246tNt.com> 1143311892 +0100

 arch/ppc/platforms/lite5200.c   |   38 ++++++++-----------------------
 arch/ppc/syslib/mpc52xx_setup.c |   48 ++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/mpc52xx.h       |    4 +++
 3 files changed, 62 insertions(+), 28 deletions(-)

---
67015426ff51ba857b7678a993f4ffd6def1941e
diff --git a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
index d91efe1..fecbe9a 100644
--- a/arch/ppc/platforms/lite5200.c
+++ b/arch/ppc/platforms/lite5200.c
@@ -36,8 +36,6 @@
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
 
-#include <syslib/mpc52xx_pci.h>
-
 
 extern int powersave_nap;
 
@@ -99,34 +97,23 @@ lite5200_map_irq(struct pci_dev *dev, un
 static void __init
 lite5200_setup_cpu(void)
 {
-	struct mpc52xx_cdm  __iomem *cdm;
 	struct mpc52xx_gpio __iomem *gpio;
 	struct mpc52xx_intr __iomem *intr;
-	struct mpc52xx_xlb  __iomem *xlb;
 
 	u32 port_config;
 	u32 intr_ctrl;
 
 	/* Map zones */
-	cdm  = ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
 	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
-	xlb  = ioremap(MPC52xx_PA(MPC52xx_XLB_OFFSET), MPC52xx_XLB_SIZE);
 	intr = ioremap(MPC52xx_PA(MPC52xx_INTR_OFFSET), MPC52xx_INTR_SIZE);
 
-	if (!cdm || !gpio || !xlb || !intr) {
-		printk("lite5200.c: Error while mapping CDM/GPIO/XLB/INTR during"
-				"lite5200_setup_cpu\n");
+	if (!gpio || !intr) {
+		printk(KERN_ERR __FILE__ ": "
+			"Error while mapping GPIO/INTR during "
+			"lite5200_setup_cpu\n");
 		goto unmap_regs;
 	}
 
-	/* Use internal 48 Mhz */
-	out_8(&cdm->ext_48mhz_en, 0x00);
-	out_8(&cdm->fd_enable, 0x01);
-	if (in_be32(&cdm->rstcfg) & 0x40)	/* Assumes 33Mhz clock */
-		out_be16(&cdm->fd_counters, 0x0001);
-	else
-		out_be16(&cdm->fd_counters, 0x5555);
-
 	/* Get port mux config */
 	port_config = in_be32(&gpio->port_config);
 
@@ -137,17 +124,13 @@ lite5200_setup_cpu(void)
 	port_config &= ~0x00007000;	/* Differential mode - USB1 only */
 	port_config |=  0x00001000;
 
+	/* ATA CS is on csb_4/5 */
+	port_config &= ~0x03000000;
+	port_config |=  0x01000000;
+
 	/* Commit port config */
 	out_be32(&gpio->port_config, port_config);
 
-	/* Configure the XLB Arbiter */
-	out_be32(&xlb->master_pri_enable, 0xff);
-	out_be32(&xlb->master_priority, 0x11111111);
-
-	/* Enable ram snooping for 1GB window */
-	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_SNOOP);
-	out_be32(&xlb->snoop_window, MPC52xx_PCI_TARGET_MEM | 0x1d);
-
 	/* IRQ[0-3] setup */
 	intr_ctrl = in_be32(&intr->ctrl);
 	intr_ctrl &= ~0x00ff0000;
@@ -163,9 +146,7 @@ lite5200_setup_cpu(void)
 
 	/* Unmap reg zone */
 unmap_regs:
-	if (cdm)  iounmap(cdm);
 	if (gpio) iounmap(gpio);
-	if (xlb)  iounmap(xlb);
 	if (intr) iounmap(intr);
 }
 
@@ -173,7 +154,8 @@ static void __init
 lite5200_setup_arch(void)
 {
 	/* CPU & Port mux setup */
-	lite5200_setup_cpu();
+	mpc52xx_setup_cpu();	/* Generic */
+	lite5200_setup_cpu();	/* Platform specific */
 
 #ifdef CONFIG_PCI
 	/* PCI Bridge setup */
diff --git a/arch/ppc/syslib/mpc52xx_setup.c b/arch/ppc/syslib/mpc52xx_setup.c
index 2ee48ce..ee6379b 100644
--- a/arch/ppc/syslib/mpc52xx_setup.c
+++ b/arch/ppc/syslib/mpc52xx_setup.c
@@ -24,6 +24,8 @@
 #include <asm/pgtable.h>
 #include <asm/ppcboot.h>
 
+#include <syslib/mpc52xx_pci.h>
+
 extern bd_t __res;
 
 static int core_mult[] = {		/* CPU Frequency multiplier, taken    */
@@ -216,6 +218,52 @@ mpc52xx_calibrate_decr(void)
 	tb_to_us = mulhwu_scale_factor(xlbfreq / divisor, 1000000);
 }
 
+
+void __init
+mpc52xx_setup_cpu(void)
+{
+	struct mpc52xx_cdm  __iomem *cdm;
+	struct mpc52xx_xlb  __iomem *xlb;
+
+	/* Map zones */
+	cdm  = ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
+	xlb  = ioremap(MPC52xx_PA(MPC52xx_XLB_OFFSET), MPC52xx_XLB_SIZE);
+
+	if (!cdm || !xlb) {
+		printk(KERN_ERR __FILE__ ": "
+			"Error while mapping CDM/XLB during "
+			"mpc52xx_setup_cpu\n");
+		goto unmap_regs;
+	}
+
+	/* Use internal 48 Mhz */
+	out_8(&cdm->ext_48mhz_en, 0x00);
+	out_8(&cdm->fd_enable, 0x01);
+	if (in_be32(&cdm->rstcfg) & 0x40)	/* Assumes 33Mhz clock */
+		out_be16(&cdm->fd_counters, 0x0001);
+	else
+		out_be16(&cdm->fd_counters, 0x5555);
+
+	/* Configure the XLB Arbiter priorities */
+	out_be32(&xlb->master_pri_enable, 0xff);
+	out_be32(&xlb->master_priority, 0x11111111);
+
+	/* Enable ram snooping for 1GB window */
+	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_SNOOP);
+	out_be32(&xlb->snoop_window, MPC52xx_PCI_TARGET_MEM | 0x1d);
+
+	/* Disable XLB pipelining */
+	/* (cfr errate 292. We could do this only just before ATA PIO
+	    transaction and re-enable it after ...) */
+	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
+
+	/* Unmap reg zone */
+unmap_regs:
+	if (cdm)  iounmap(cdm);
+	if (xlb)  iounmap(xlb);
+}
+
+
 int mpc52xx_match_psc_function(int psc_idx, const char *func)
 {
 	struct mpc52xx_psc_func *cf = mpc52xx_psc_functions;
diff --git a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
index 6167f74..7e98428 100644
--- a/include/asm-ppc/mpc52xx.h
+++ b/include/asm-ppc/mpc52xx.h
@@ -355,6 +355,7 @@ struct mpc52xx_xlb {
 	u32	snoop_window;		/* XLB + 0x70 */
 };
 
+#define MPC52xx_XLB_CFG_PLDIS		(1 << 31)
 #define MPC52xx_XLB_CFG_SNOOP		(1 << 15)
 
 /* Clock Distribution control */
@@ -427,6 +428,9 @@ extern void mpc52xx_calibrate_decr(void)
 
 extern void mpc52xx_find_bridges(void);
 
+extern void mpc52xx_setup_cpu(void);
+
+
 
 	/* Matching of PSC function */
 struct mpc52xx_psc_func {
