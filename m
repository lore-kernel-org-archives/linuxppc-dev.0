Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 69A31DF142
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:27:06 +1000 (EST)
Date: Tue, 28 Aug 2007 15:19:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 7/9] mpc8272ads: Change references from 82xx_ADS to 8272_ADS.
Message-ID: <20070828201928.GG24329@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
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
index 64e8ca9..994a859 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -1,5 +1,5 @@
 /*
- * MPC82xx_ads setup and early boot code plus other random bits.
+ * MPC8272_ads setup and early boot code plus other random bits.
  *
  * Author: Vitaly Bordug <vbordug@ru.mvista.com>
  * m82xx_restart fix by Wade Farnsworth <wfarnsworth@mvista.com>
@@ -64,7 +64,7 @@ static struct irq_host *pci_pic_host;
 static struct device_node *pci_pic_node;
 #endif
 
-static void __init mpc82xx_ads_pic_init(void)
+static void __init mpc8272_ads_pic_init(void)
 {
 	struct device_node *np = of_find_compatible_node(NULL, "cpm-pic", "CPM2");
 	struct resource r;
@@ -562,14 +562,14 @@ static void __init mpc82xx_add_bridge(struct device_node *np)
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
@@ -591,13 +591,13 @@ static void __init mpc82xx_ads_setup_arch(void)
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
@@ -621,14 +621,14 @@ static void m82xx_restart(char *cmd)
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
1.5.0.3
