Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 37C8CDDFFE
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 08:25:29 +1000 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPM00AQ36AGO970@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 16:25:28 -0600 (MDT)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPM00CBG6AEM620@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 08 Oct 2007 16:25:28 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.133.150])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPM00F4H6ACEZN0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 16:25:24 -0600 (MDT)
Date: Mon, 08 Oct 2007 16:25:25 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 6/6] MPC5200: Don't make firmware fixups into common code
In-reply-to: <20071008222445.25840.6561.stgit@trillian.cg.shawcable.net>
To: galak@kernel.crashing.org, paulus@samba.org, arnd@arndb.de,
	linuxppc-dev@ozlabs.org
Message-id: <20071008222523.25840.926.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071008222445.25840.6561.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The Lite5200 u-boot image doesn't entirely configure the processor
correctly and so Linux needs to fixup the cpu setup in setup_arch.  Fixing
the CPU setup is good, but making it into common code is not a good idea.

New board ports should be encouraged not to take the lead of the lite5200
and instead get their firmware to setup the CPU the right way.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/lite5200.c       |   85 ++++++++++++++++++++++++--
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   40 ------------
 2 files changed, 78 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index c1aca5e..3956769 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -29,19 +29,90 @@
  *
  */
 
+/*
+ * Fix clock configuration.
+ *
+ * Firmware is supposed to be responsible for this.  If you are creating a
+ * new board port, do *NOT* duplicate this code.  Fix your boot firmware
+ * to set it correctly in the first place
+ */
+void __init
+lite5200_fix_clock_config(void)
+{
+	struct mpc52xx_cdm  __iomem *cdm;
+
+	/* Map zones */
+	cdm = mpc52xx_find_and_map("mpc5200-cdm");
+	if (!cdm) {
+		printk(KERN_ERR "Could not adjust CDM config; "
+		       "Expect abnormal behaviour\n");
+		return;
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
+	/* Unmap the regs */
+	iounmap(cdm);
+}
+
+/*
+ * Fix XLB configuration.
+ *
+ * Firmware is supposed to be responsible for this.  If you are creating a
+ * new board port, do *NOT* duplicate this code.  Fix your boot firmware
+ * to set it correctly in the first place
+ */
+void __init
+lite5200_fix_xlb_config(void)
+{
+	struct mpc52xx_xlb  __iomem *xlb;
+
+	xlb = mpc52xx_find_and_map("mpc5200-xlb");
+	if (!xlb) {
+		printk(KERN_ERR "Could not adjust XLB config; "
+		       "Expect abnormal behaviour\n");
+		return;
+	}
+
+	/* Configure the XLB Arbiter priorities */
+	out_be32(&xlb->master_pri_enable, 0xff);
+	out_be32(&xlb->master_priority, 0x11111111);
+
+	/* Disable XLB pipelining
+	 * (cfr errate 292. We could do this only just before ATA PIO
+	 * transaction and re-enable it afterwards ...)
+	 */
+	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
+
+	/* Unmap the regs */
+	iounmap(xlb);
+}
+
+/*
+ * Fix setting of port_config register.
+ *
+ * Firmware is supposed to be responsible for this.  If you are creating a
+ * new board port, do *NOT* duplicate this code.  Fix your boot firmware
+ * to set it correctly in the first place
+ */
 static void __init
-lite5200_setup_cpu(void)
+lite5200_fix_port_config(void)
 {
 	struct mpc52xx_gpio __iomem *gpio;
 	u32 port_config;
 
-	/* Map zones */
 	gpio = mpc52xx_find_and_map("mpc5200-gpio");
 	if (!gpio) {
 		printk(KERN_ERR __FILE__ ": "
 			"Error while mapping GPIO register for port config. "
 			"Expect some abnormal behavior\n");
-		goto error;
+		return;
 	}
 
 	/* Set port config */
@@ -60,7 +131,6 @@ lite5200_setup_cpu(void)
 	out_be32(&gpio->port_config, port_config);
 
 	/* Unmap zone */
-error:
 	iounmap(gpio);
 }
 
@@ -99,9 +169,10 @@ static void __init lite5200_setup_arch(void)
 	if (ppc_md.progress)
 		ppc_md.progress("lite5200_setup_arch()", 0);
 
-	/* CPU & Port mux setup */
-	mpc52xx_setup_cpu();	/* Generic */
-	lite5200_setup_cpu();	/* Platorm specific */
+	/* Fix things that firmware should have done. */
+	lite5200_fix_clock_config();
+	lite5200_fix_xlb_config();
+	lite5200_fix_port_config();
 
 #ifdef CONFIG_PM
 	mpc52xx_suspend.board_suspend_prepare = lite5200_suspend_prepare;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 93e7869..36e7a04 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -75,46 +75,6 @@ EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
 
 
 void __init
-mpc52xx_setup_cpu(void)
-{
-	struct mpc52xx_cdm  __iomem *cdm;
-	struct mpc52xx_xlb  __iomem *xlb;
-
-	/* Map zones */
-	cdm = mpc52xx_find_and_map("mpc5200-cdm");
-	xlb = mpc52xx_find_and_map("mpc5200-xlb");
-
-	if (!cdm || !xlb) {
-		printk(KERN_ERR __FILE__ ": "
-			"Error while mapping CDM/XLB during mpc52xx_setup_cpu. "
-			"Expect some abnormal behavior\n");
-		goto unmap_regs;
-	}
-
-	/* Use internal 48 Mhz */
-	out_8(&cdm->ext_48mhz_en, 0x00);
-	out_8(&cdm->fd_enable, 0x01);
-	if (in_be32(&cdm->rstcfg) & 0x40)	/* Assumes 33Mhz clock */
-		out_be16(&cdm->fd_counters, 0x0001);
-	else
-		out_be16(&cdm->fd_counters, 0x5555);
-
-	/* Configure the XLB Arbiter priorities */
-	out_be32(&xlb->master_pri_enable, 0xff);
-	out_be32(&xlb->master_priority, 0x11111111);
-
-	/* Disable XLB pipelining */
-	/* (cfr errate 292. We could do this only just before ATA PIO
-	    transaction and re-enable it afterwards ...) */
-	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
-
-	/* Unmap zones */
-unmap_regs:
-	if (cdm) iounmap(cdm);
-	if (xlb) iounmap(xlb);
-}
-
-void __init
 mpc52xx_declare_of_platform_devices(void)
 {
 	/* Find every child of the SOC node and add it to of_platform */
