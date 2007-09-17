Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9E098DE128
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 02:58:59 +1000 (EST)
Date: Mon, 17 Sep 2007 11:58:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 26/28] mpc8272ads: Change references from 82xx_ADS to 8272_ADS.
Message-ID: <20070917165819.GZ6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165643.GA6545@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/82xx/mpc8272_ads.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index b251a55..97d8dc4 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -1,5 +1,5 @@
 /*
- * MPC82xx_ads setup and early boot code plus other random bits.
+ * MPC8272_ads setup and early boot code plus other random bits.
  *
  * Author: Vitaly Bordug <vbordug@ru.mvista.com>
  * m82xx_restart fix by Wade Farnsworth <wfarnsworth@mvista.com>
@@ -63,7 +63,7 @@ static unsigned long pci_int_base;
 static struct irq_host *pci_pic_host;
 #endif
 
-static void __init mpc82xx_ads_pic_init(void)
+static void __init mpc8272_ads_pic_init(void)
 {
 	struct device_node *np = of_find_compatible_node(NULL, "cpm-pic", "CPM2");
 	struct resource r;
@@ -553,14 +553,14 @@ static void __init mpc82xx_add_bridge(struct device_node *np)
 /*
  * Setup the architecture
  */
-static void __init mpc82xx_ads_setup_arch(void)
+static void __init mpc8272_ads_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *np;
 #endif
 
 	if (ppc_md.progress)
-		ppc_md.progress("mpc82xx_ads_setup_arch()", 0);
+		ppc_md.progress("mpc8272_ads_setup_arch()", 0);
 	cpm2_reset();
 
 	/* Map I/O region to a 256MB BAT */
@@ -582,13 +582,13 @@ static void __init mpc82xx_ads_setup_arch(void)
 #endif
 
 	if (ppc_md.progress)
-		ppc_md.progress("mpc82xx_ads_setup_arch(), finish", 0);
+		ppc_md.progress("mpc8272_ads_setup_arch(), finish", 0);
 }
 
 /*
  * Called very early, device-tree isn't unflattened
  */
-static int __init mpc82xx_ads_probe(void)
+static int __init mpc8272_ads_probe(void)
 {
 	/* We always match for now, eventually we should look at
 	 * the flat dev tree to ensure this is the board we are
@@ -612,14 +612,14 @@ static void m82xx_restart(char *cmd)
 	while (1) ;
 }
 
-define_machine(mpc82xx_ads)
+define_machine(mpc8272_ads)
 {
-	.name = "MPC82xx ADS",
-	.probe = mpc82xx_ads_probe,
-	.setup_arch =    mpc82xx_ads_setup_arch,
-	.init_IRQ =    mpc82xx_ads_pic_init,
-	.show_cpuinfo =    mpc82xx_ads_show_cpuinfo,
-	.get_irq =    cpm2_get_irq,
+	.name = "MPC8272 ADS",
+	.probe = mpc8272_ads_probe,
+	.setup_arch = mpc8272_ads_setup_arch,
+	.init_IRQ = mpc8272_ads_pic_init,
+	.show_cpuinfo = mpc8272_ads_show_cpuinfo,
+	.get_irq = cpm2_get_irq,
 	.calibrate_decr = generic_calibrate_decr,
 	.restart = m82xx_restart,
 };
-- 
1.5.3.1
