Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BA5EB2C0725
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:48:08 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 28/31] powerpc/mpc512x: improve DIU related clock setup
Date: Tue,  6 Aug 2013 22:44:08 +0200
Message-Id: <1375821851-31609-29-git-send-email-gsi@denx.de>
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

adapt the DIU clock initialization to the COMMON_CLK approach:
device tree based clock lookup, prepare and unprepare for clocks,
work with frequencies not dividers, call the appropriate clk_*()
routines and don't access CCM registers, remove the pre-enable
workaround in the platform's clock driver

the "best clock" determination now completely relies on the
platform's clock driver to pick a frequency close to what the
caller requests, and merely checks whether the desired frequency
was met (is acceptable since it meets the tolerance of the monitor)

this approach shall succeed upon first try in the usual case,
will test a few less desirable yet acceptable frequencies in
edge cases, and will fallback to "best effort" if none of the
previously tried frequencies pass the test

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |    1 -
 arch/powerpc/platforms/512x/mpc512x_shared.c  |  165 +++++++++++++------------
 2 files changed, 88 insertions(+), 78 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index afbb01d..fa95814 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -668,7 +668,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	clk_prepare_enable(clks[MPC512x_CLK_LPC]);	/* boot media */
 	/* some are not yet acquired by their respective drivers */
 	clk_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console */
-	clk_prepare_enable(clks[MPC512x_CLK_DIU]);	/* display */
 }
 
 /*
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index a82a41b..3381eea 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -12,6 +12,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -70,98 +71,108 @@ struct fsl_diu_shared_fb {
 	bool		in_use;
 };
 
-#define DIU_DIV_MASK	0x000000ff
+/* receives a pixel clock spec in pico seconds, adjusts the DIU clock rate */
 void mpc512x_set_pixel_clock(unsigned int pixclock)
 {
-	unsigned long bestval, bestfreq, speed, busfreq;
-	unsigned long minpixclock, maxpixclock, pixval;
-	struct mpc512x_ccm __iomem *ccm;
 	struct device_node *np;
-	u32 temp;
-	long err;
-	int i;
+	struct clk *clk_diu;
+	unsigned long epsilon, minpixclock, maxpixclock;
+	unsigned long offset, want, got, delta;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-clock");
+	/* lookup and enable the DIU clock */
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-diu");
 	if (!np) {
-		pr_err("Can't find clock control module.\n");
+		pr_err("Could not find DIU device tree node.\n");
 		return;
 	}
-
-	ccm = of_iomap(np, 0);
+	clk_diu = of_clk_get_by_name(np, "per");
 	of_node_put(np);
-	if (!ccm) {
-		pr_err("Can't map clock control module reg.\n");
+	if (IS_ERR(clk_diu)) {
+		pr_err("Could not lookup DIU clock.\n");
 		return;
 	}
-
-	np = of_find_node_by_type(NULL, "cpu");
-	if (np) {
-		const unsigned int *prop =
-			of_get_property(np, "bus-frequency", NULL);
-
-		of_node_put(np);
-		if (prop) {
-			busfreq = *prop;
-		} else {
-			pr_err("Can't get bus-frequency property\n");
-			return;
-		}
-	} else {
-		pr_err("Can't find 'cpu' node.\n");
+	if (clk_prepare_enable(clk_diu)) {
+		pr_err("Could not enable DIU clock.\n");
 		return;
 	}
 
-	/* Pixel Clock configuration */
-	pr_debug("DIU: Bus Frequency = %lu\n", busfreq);
-	speed = busfreq * 4; /* DIU_DIV ratio is 4 * CSB_CLK / DIU_CLK */
-
-	/* Calculate the pixel clock with the smallest error */
-	/* calculate the following in steps to avoid overflow */
-	pr_debug("DIU pixclock in ps - %d\n", pixclock);
-	temp = (1000000000 / pixclock) * 1000;
-	pixclock = temp;
-	pr_debug("DIU pixclock freq - %u\n", pixclock);
-
-	temp = temp / 20; /* pixclock * 0.05 */
-	pr_debug("deviation = %d\n", temp);
-	minpixclock = pixclock - temp;
-	maxpixclock = pixclock + temp;
-	pr_debug("DIU minpixclock - %lu\n", minpixclock);
-	pr_debug("DIU maxpixclock - %lu\n", maxpixclock);
-	pixval = speed/pixclock;
-	pr_debug("DIU pixval = %lu\n", pixval);
-
-	err = LONG_MAX;
-	bestval = pixval;
-	pr_debug("DIU bestval = %lu\n", bestval);
-
-	bestfreq = 0;
-	for (i = -1; i <= 1; i++) {
-		temp = speed / (pixval+i);
-		pr_debug("DIU test pixval i=%d, pixval=%lu, temp freq. = %u\n",
-			i, pixval, temp);
-		if ((temp < minpixclock) || (temp > maxpixclock))
-			pr_debug("DIU exceeds monitor range (%lu to %lu)\n",
-				minpixclock, maxpixclock);
-		else if (abs(temp - pixclock) < err) {
-			pr_debug("Entered the else if block %d\n", i);
-			err = abs(temp - pixclock);
-			bestval = pixval + i;
-			bestfreq = temp;
-		}
+	/*
+	 * convert the picoseconds spec into the desired clock rate,
+	 * determine the acceptable clock range for the monitor (+/- 5%),
+	 * do the calculation in steps to avoid integer overflow
+	 */
+	pr_debug("DIU pixclock in ps - %u\n", pixclock);
+	pixclock = (1000000000 / pixclock) * 1000;
+	pr_debug("DIU pixclock freq  - %u\n", pixclock);
+	epsilon = pixclock / 20; /* pixclock * 0.05 */
+	pr_debug("DIU deviation      - %lu\n", epsilon);
+	minpixclock = pixclock - epsilon;
+	maxpixclock = pixclock + epsilon;
+	pr_debug("DIU minpixclock    - %lu\n", minpixclock);
+	pr_debug("DIU maxpixclock    - %lu\n", maxpixclock);
+
+	/*
+	 * check whether the DIU supports the desired pixel clock
+	 *
+	 * - simply request the desired clock and see what the
+	 *   platform's clock driver will make of it, assuming that it
+	 *   will setup the best approximation of the requested value
+	 * - try other candidate frequencies in the order of decreasing
+	 *   preference (i.e. with increasing distance from the desired
+	 *   pixel clock, and checking the lower frequency before the
+	 *   higher frequency to not overload the hardware) until the
+	 *   first match is found -- any potential subsequent match
+	 *   would only be as good as the former match or typically
+	 *   would be less preferrable
+	 *
+	 * the offset increment of pixelclock divided by 64 is an
+	 * arbitrary choice -- it's simple to calculate, in the typical
+	 * case we expect the first check to succeed already, in the
+	 * worst case seven frequencies get tested (the exact center and
+	 * three more values each to the left and to the right) before
+	 * the 5% tolerance window is exceeded, resulting in fast enough
+	 * execution yet high enough probability of finding a suitable
+	 * value, while the error rate will be in the order of single
+	 * percents
+	 */
+	for (offset = 0; offset <= epsilon; offset += pixclock / 64) {
+		want = pixclock - offset;
+		pr_debug("DIU checking clock - %lu\n", want);
+		clk_set_rate(clk_diu, want);
+		got = clk_get_rate(clk_diu);
+		delta = abs(pixclock - got);
+		if (delta < epsilon)
+			break;
+		if (!offset)
+			continue;
+		want = pixclock + offset;
+		pr_debug("DIU checking clock - %lu\n", want);
+		clk_set_rate(clk_diu, want);
+		got = clk_get_rate(clk_diu);
+		delta = abs(pixclock - got);
+		if (delta < epsilon)
+			break;
 	}
+	if (offset <= epsilon) {
+		pr_debug("DIU clock accepted - %lu\n", want);
+		pr_debug("DIU pixclock want %u, got %lu, delta %lu, eps %lu\n",
+			 pixclock, got, delta, epsilon);
+		return;
+	}
+	pr_warn("DIU pixclock auto search unsuccessful\n");
 
-	pr_debug("DIU chose = %lx\n", bestval);
-	pr_debug("DIU error = %ld\n NomPixClk ", err);
-	pr_debug("DIU: Best Freq = %lx\n", bestfreq);
-	/* Modify DIU_DIV in CCM SCFR1 */
-	temp = in_be32(&ccm->scfr1);
-	pr_debug("DIU: Current value of SCFR1: 0x%08x\n", temp);
-	temp &= ~DIU_DIV_MASK;
-	temp |= (bestval & DIU_DIV_MASK);
-	out_be32(&ccm->scfr1, temp);
-	pr_debug("DIU: Modified value of SCFR1: 0x%08x\n", temp);
-	iounmap(ccm);
+	/*
+	 * what is the most appropriate action to take when the search
+	 * for an available pixel clock which is acceptable to the
+	 * monitor has failed?  disable the DIU (clock) or just provide
+	 * a "best effort"?  we go with the latter
+	 */
+	pr_warn("DIU pixclock best effort fallback (backend's choice)\n");
+	clk_set_rate(clk_diu, pixclock);
+	got = clk_get_rate(clk_diu);
+	delta = abs(pixclock - got);
+	pr_debug("DIU pixclock want %u, got %lu, delta %lu, eps %lu\n",
+		 pixclock, got, delta, epsilon);
 }
 
 enum fsl_diu_monitor_port
-- 
1.7.10.4
