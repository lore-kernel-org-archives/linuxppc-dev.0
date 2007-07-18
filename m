Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 623F2DEDA4
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:37 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1ZVe6027584
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:32 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZV4J001459
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:31 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1AoGa007905
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:10:50 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 785D8AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:30 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZUgR015354
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:30 -0500
Date: Tue, 17 Jul 2007 20:35:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 24/61] Change references from 82xx_ADS to 8272ADS.
Message-ID: <20070718013530.GV15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/platforms/82xx/mpc8272ads.c |   33 +++++++++++++++--------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc8272ads.c b/arch/powerpc/platforms/82xx/mpc8272ads.c
index 1945522..29c2932 100644
--- a/arch/powerpc/platforms/82xx/mpc8272ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272ads.c
@@ -1,5 +1,5 @@
 /*
- * MPC82xx_ads setup and early boot code plus other random bits.
+ * MPC8272ADS setup and early boot code plus other random bits.
  *
  * Author: Vitaly Bordug <vbordug@ru.mvista.com>
  * m82xx_restart fix by Wade Farnsworth <wfarnsworth@mvista.com>
@@ -65,7 +65,7 @@ static struct irq_host *pci_pic_host;
 static struct device_node *pci_pic_node;
 #endif
 
-static void __init mpc82xx_ads_pic_init(void)
+static void __init mpc8272ads_pic_init(void)
 {
 	struct device_node *np = of_find_compatible_node(NULL, "cpm-pic", "CPM2");
 	struct resource r;
@@ -282,7 +282,7 @@ void init_scc_ioports(struct fs_uart_platform_info *data)
 	}
 }
 
-void __init m82xx_board_setup(void)
+void __init mpc8272ads_board_setup(void)
 {
 	cpm2_map_t *immap = ioremap(get_immrbase(), sizeof(cpm2_map_t));
 	struct device_node *np;
@@ -562,19 +562,19 @@ static void __init mpc82xx_add_bridge(struct device_node *np)
 /*
  * Setup the architecture
  */
-static void __init mpc82xx_ads_setup_arch(void)
+static void __init mpc8272ads_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *np;
 #endif
 
 	if (ppc_md.progress)
-		ppc_md.progress("mpc82xx_ads_setup_arch()", 0);
+		ppc_md.progress("mpc8272ads_setup_arch()", 0);
 	cpm2_reset();
 
 	/* Map I/O region to a 256MB BAT */
 
-	m82xx_board_setup();
+	mpc8272ads_board_setup();
 
 #ifdef CONFIG_PCI
 	ppc_md.pci_exclude_device = m82xx_pci_exclude_device;
@@ -591,13 +591,13 @@ static void __init mpc82xx_ads_setup_arch(void)
 #endif
 
 	if (ppc_md.progress)
-		ppc_md.progress("mpc82xx_ads_setup_arch(), finish", 0);
+		ppc_md.progress("mpc8272ads_setup_arch(), finish", 0);
 }
 
 /*
  * Called very early, device-tree isn't unflattened
  */
-static int __init mpc82xx_ads_probe(void)
+static int __init mpc8272ads_probe(void)
 {
 	/* We always match for now, eventually we should look at
 	 * the flat dev tree to ensure this is the board we are
@@ -627,14 +627,15 @@ static void m82xx_halt(void)
 	while (1) ;
 }
 
-define_machine(mpc82xx_ads)
+define_machine(mpc8272ads)
 {
 	.name = "Freescale MPC8272ADS",
-	.probe = mpc82xx_ads_probe,
-	.setup_arch =    mpc82xx_ads_setup_arch,
-	.init_IRQ =    mpc82xx_ads_pic_init,
-	.show_cpuinfo =    m82xx_show_cpuinfo,
-	.get_irq =    cpm2_get_irq,
-	.calibrate_decr =    m82xx_calibrate_decr,
-	.restart = m82xx_restart,.halt = m82xx_halt,
+	.probe = mpc8272ads_probe,
+	.setup_arch = mpc8272ads_setup_arch,
+	.init_IRQ = mpc8272ads_pic_init,
+	.show_cpuinfo = m82xx_show_cpuinfo,
+	.get_irq = cpm2_get_irq,
+	.calibrate_decr = m82xx_calibrate_decr,
+	.restart = m82xx_restart,
+	.halt = m82xx_halt,
 };
-- 
1.5.0.3
