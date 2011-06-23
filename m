Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3E09DB6F99
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 02:20:45 +1000 (EST)
Received: from mail158-va3 (localhost.localdomain [127.0.0.1])	by
	mail158-va3-R.bigfish.com (Postfix) with ESMTP id 7175519B81EA	for
	<linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 16:20:40 +0000 (UTC)
Received: from VA3EHSMHS029.bigfish.com (unknown [10.7.14.248])	by
	mail158-va3.bigfish.com (Postfix) with ESMTP id 50986163007D	for
	<linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 16:16:54 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/86xx: improve calculation of DIU pixel clock on
	the MPC8610 HPCD
Date: Thu, 23 Jun 2011 11:16:48 -0500
Message-ID: <1308845808-11392-2-git-send-email-timur@freescale.com>
In-Reply-To: <1308845808-11392-1-git-send-email-timur@freescale.com>
References: <1308845808-11392-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc8610hpcd_set_pixel_clock() calculates the correct value of the PXCLK
bits in the CLKDVDR register for a given pixel clock rate.  The code which
performs this calculation is overly complicated and includes an error
estimation routine that doesn't work most of the time anyway.  Replace the
code with the simpler routine that's currently used on the P1022DS.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |  107 ++++++++++++---------------
 1 files changed, 48 insertions(+), 59 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index a896511..74e018e 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -39,12 +39,19 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/simple_gpio.h>
+#include <asm/fsl_guts.h>
 
 #include "mpc86xx.h"
 
 static struct device_node *pixis_node;
 static unsigned char *pixis_bdcfg0, *pixis_arch;
 
+/* DIU Pixel Clock bits of the CLKDVDR Global Utilities register */
+#define CLKDVDR_PXCKEN		0x80000000
+#define CLKDVDR_PXCKINV		0x10000000
+#define CLKDVDR_PXCKDLY		0x06000000
+#define CLKDVDR_PXCLK_MASK	0x001F0000
+
 #ifdef CONFIG_SUSPEND
 static irqreturn_t mpc8610_sw9_irq(int irq, void *data)
 {
@@ -205,72 +212,54 @@ void mpc8610hpcd_set_monitor_port(int monitor_port)
 			     bdcfg[monitor_port]);
 }
 
+/**
+ * mpc8610hpcd_set_pixel_clock: program the DIU's clock
+ *
+ * @pixclock: the wavelength, in picoseconds, of the clock
+ */
 void mpc8610hpcd_set_pixel_clock(unsigned int pixclock)
 {
-	u32 __iomem *clkdvdr;
-	u32 temp;
-	/* variables for pixel clock calcs */
-	ulong  bestval, bestfreq, speed_ccb, minpixclock, maxpixclock;
-	ulong pixval;
-	long err;
-	int i;
-
-	clkdvdr = ioremap(get_immrbase() + 0xe0800, sizeof(u32));
-	if (!clkdvdr) {
-		printk(KERN_ERR "Err: can't map clock divider register!\n");
+	struct device_node *guts_np = NULL;
+	struct ccsr_guts_86xx __iomem *guts;
+	unsigned long freq;
+	u64 temp;
+	u32 pxclk;
+
+	/* Map the global utilities registers. */
+	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
+	if (!guts_np) {
+		pr_err("mpc8610hpcd: missing global utilties device node\n");
 		return;
 	}
 
-	/* Pixel Clock configuration */
-	speed_ccb = fsl_get_sys_freq();
-
-	/* Calculate the pixel clock with the smallest error */
-	/* calculate the following in steps to avoid overflow */
-	pr_debug("DIU pixclock in ps - %d\n", pixclock);
-	temp = 1000000000/pixclock;
-	temp *= 1000;
-	pixclock = temp;
-	pr_debug("DIU pixclock freq - %u\n", pixclock);
-
-	temp = pixclock * 5 / 100;
-	pr_debug("deviation = %d\n", temp);
-	minpixclock = pixclock - temp;
-	maxpixclock = pixclock + temp;
-	pr_debug("DIU minpixclock - %lu\n", minpixclock);
-	pr_debug("DIU maxpixclock - %lu\n", maxpixclock);
-	pixval = speed_ccb/pixclock;
-	pr_debug("DIU pixval = %lu\n", pixval);
-
-	err = 100000000;
-	bestval = pixval;
-	pr_debug("DIU bestval = %lu\n", bestval);
-
-	bestfreq = 0;
-	for (i = -1; i <= 1; i++) {
-		temp = speed_ccb / ((pixval+i) + 1);
-		pr_debug("DIU test pixval i= %d, pixval=%lu, temp freq. = %u\n",
-							i, pixval, temp);
-		if ((temp < minpixclock) || (temp > maxpixclock))
-			pr_debug("DIU exceeds monitor range (%lu to %lu)\n",
-				minpixclock, maxpixclock);
-		else if (abs(temp - pixclock) < err) {
-		  pr_debug("Entered the else if block %d\n", i);
-			err = abs(temp - pixclock);
-			bestval = pixval+i;
-			bestfreq = temp;
-		}
+	guts = of_iomap(guts_np, 0);
+	of_node_put(guts_np);
+	if (!guts) {
+		pr_err("mpc8610hpcd: could not map global utilties device\n");
+		return;
 	}
 
-	pr_debug("DIU chose = %lx\n", bestval);
-	pr_debug("DIU error = %ld\n NomPixClk ", err);
-	pr_debug("DIU: Best Freq = %lx\n", bestfreq);
-	/* Modify PXCLK in GUTS CLKDVDR */
-	pr_debug("DIU: Current value of CLKDVDR = 0x%08x\n", (*clkdvdr));
-	temp = (*clkdvdr) & 0x2000FFFF;
-	*clkdvdr = temp;		/* turn off clock */
-	*clkdvdr = temp | 0x80000000 | (((bestval) & 0x1F) << 16);
-	pr_debug("DIU: Modified value of CLKDVDR = 0x%08x\n", (*clkdvdr));
-	iounmap(clkdvdr);
+	/* Convert pixclock from a wavelength to a frequency */
+	temp = 1000000000000ULL;
+	do_div(temp, pixclock);
+	freq = temp;
+
+	/*
+	 * 'pxclk' is the ratio of the platform clock to the pixel clock.
+	 * On the MPC8610, the value programmed into CLKDVDR is the ratio
+	 * minus one.  The valid range of values is 2-31.
+	 */
+	pxclk = DIV_ROUND_CLOSEST(fsl_get_sys_freq(), freq) - 1;
+	pxclk = clamp_t(u32, pxclk, 2, 31);
+
+	/* Disable the pixel clock, and set it to non-inverted and no delay */
+	clrbits32(&guts->clkdvdr,
+		  CLKDVDR_PXCKEN | CLKDVDR_PXCKDLY | CLKDVDR_PXCLK_MASK);
+
+	/* Enable the clock and set the pxclk */
+	setbits32(&guts->clkdvdr, CLKDVDR_PXCKEN | (pxclk << 16));
+
+	iounmap(guts);
 }
 
 ssize_t mpc8610hpcd_show_monitor_port(int monitor_port, char *buf)
-- 
1.7.3.4
