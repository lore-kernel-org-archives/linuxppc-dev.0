Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 836E9DDE32
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 16:27:19 +1100 (EST)
Date: Wed, 7 Mar 2007 23:24:06 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git merge branch (2.6.21 fixes)
In-Reply-To: <Pine.LNX.4.64.0703072320040.2619@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0703072323300.2619@localhost.localdomain>
References: <Pine.LNX.4.64.0703072320040.2619@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for_paulus' branch of
master.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

 arch/powerpc/platforms/83xx/mpc834x_mds.c  |    8 ++++----
 arch/powerpc/platforms/85xx/Kconfig        |    1 +
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

Kumar Gala (1):
      [POWERPC] 85xx: Enable CONFIG_SERIAL_8250_SHARE_IRQ

Li Yang (1):
      [POWERPC] 83xx: Minor fixes for 834x_mds USB setup code

Segher Boessenkool (1):
      [POWERPC] Select u-image as default image for Linkstation

diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index e5d8191..8aa9a93 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -55,9 +55,9 @@ static int mpc834x_usb_cfg(void)
 	struct device_node *np = NULL;
 	int port0_is_dr = 0;

-	if ((np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) != NULL)
+	if ((np = of_find_compatible_node(NULL, "usb", "fsl-usb2-dr")) != NULL)
 		port0_is_dr = 1;
-	if ((np = of_find_compatible_node(np, "usb", "fsl-usb2-mph")) != NULL){
+	if ((np = of_find_compatible_node(NULL, "usb", "fsl-usb2-mph")) != NULL){
 		if (port0_is_dr) {
 			printk(KERN_WARNING
 				"There is only one USB port on PB board! \n");
@@ -103,8 +103,8 @@ static int mpc834x_usb_cfg(void)
 		return -1;

 	/*
-	 * if MDS board is plug into PIB board,
-	 * force to use the PHY on MDS board
+	 * if Processor Board is plugged into PIB board,
+	 * force to use the PHY on Processor Board
 	 */
 	bcsr5 = in_8(bcsr_regs + 5);
 	if (!(bcsr5 & BCSR5_INT_USB))
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index eb661cc..e764c0a 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -47,6 +47,7 @@ config MPC85xx
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
+	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
 	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS || MPC85xx_MDS

 config PPC_INDIRECT_PCI_BE
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 886c522..3410bcb 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -79,6 +79,7 @@ config LINKSTATION
 	select MPIC
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
+	select DEFAULT_UIMAGE
 	help
 	  Select LINKSTATION if configuring for one of PPC- (MPC8241)
 	  based NAS systems from Buffalo Technology. So far only
