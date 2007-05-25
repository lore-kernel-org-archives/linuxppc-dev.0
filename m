Return-Path: <domen@coderock.org>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id C63DDDDF5D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 18:47:52 +1000 (EST)
Date: Fri, 25 May 2007 10:47:50 +0200
From: Domen Puncer <domen@coderock.org>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: [RFC 3/3] Re: [PATCH] mpc52xx_psc_spi: fix it for CONFIG_PPC_MERGE
Message-ID: <20070525084750.GC23149@nd47.coderock.org>
References: <20070516073707.GD9667@nd47.coderock.org>
	<464ABE97.7090603@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <464ABE97.7090603@246tNt.com>
Cc: Dragos Carp <dragos.carp@toptica.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 16/05/07 10:19 +0200, Sylvain Munaut wrote:
> 
> Well, this comment is not about the patch but about the driver it self,
> I didn't see it before today.
> So here's a few things I see from a quick glance at the code :
> 
>  - Chaning port_config in the driver is just wrong ... you should _not_
> do that. That should have been setup by the bootloader or at worse in
> the platform setup code.
>  - You do read/write/modify operation on CDM shared register
> (clk_enables) from a driver, you should have added something in common
> 52xx code to do theses with proper locking.
>  - MPC52xx_PA(MPC52xx_PSCx_OFFSET(...)) ??? You should get that from the
> resource of the platform_device. This macro is just there for early
> console stuff.
>  - You can get f_system from the device tree instead of just assuming
> it's 512 MHz. It probably need to be done the same way it's done to find
> ipb_freq.
>  - Would have been nice to be able to somehow configure MCLK rather than
> #define it
>  - I hope to remove all arch/ppc stuff by 2.6.23 if I can make the
> cuimage stuff work in arch/powerpc so just including the platform code
> stuff for 1 kernel version ...
> 
> 
>     Sylvain

[ trimming spi-devel from cc: ]

For clk.h, it does seem quite some code, compared what's there currently.

Comments?


Use previous two patches (port_config, clk.h).


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 drivers/spi/mpc52xx_psc_spi.c |   49 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

Index: work-powerpc.git/drivers/spi/mpc52xx_psc_spi.c
===================================================================
--- work-powerpc.git.orig/drivers/spi/mpc52xx_psc_spi.c
+++ work-powerpc.git/drivers/spi/mpc52xx_psc_spi.c
@@ -18,6 +18,7 @@
 
 #if defined(CONFIG_PPC_MERGE)
 #include <asm/of_platform.h>
+#include <linux/clk.h>
 #else
 #include <linux/platform_device.h>
 #endif
@@ -106,13 +107,52 @@ static void mpc52xx_psc_spi_activate_cs(
 	/* Set clock frequency and bits per word
 	 * Because psc->ccr is defined as 16bit register instead of 32bit
 	 * just set the lower byte of BitClkDiv
+	 * Because BitClkDiv is 8-bit on mpc5200. Lets stay compatible.
 	 */
+#if defined(CONFIG_PPC_MERGE)
 	ccr = in_be16(&psc->ccr);
 	ccr &= 0xFF00;
+	{
+		u8 bitclkdiv = 2;	/* minimum bitclkdiv */
+		int speed = cs->speed_hz ? cs->speed_hz : 1000000;
+		char clk_name[10];
+		struct clk *clk;	// TODO into mps, clk_get, clk_put
+		int mclk;
+		int system;
+		/*
+		 * pscclk = mclk/(bitclkdiv+1))		bitclkdiv is 8-bit, >= 2
+		 * mclk = fsys/(mclkdiv+1)		mclkdiv is 9-bit, >= 1
+		 * as mclkdiv has higher precision, we want is as big as possible
+		 * => we get < 0.002*clock error
+		 */
+
+		snprintf(clk_name, 10, "psc%i_mclk", spi->master->bus_num);
+
+		clk = clk_get(&spi->dev, clk_name);
+		if (!clk)
+			dev_err(&spi->dev, "couldn't get %s clock\n", clk_name);
+
+		system = clk_get_rate(clk_get_parent(clk));	// TODO, checking, refcounting
+		mclk = speed * (bitclkdiv+1);
+		if (system/mclk > 512) { /* bigger than mclkdiv */
+			bitclkdiv = system/512/speed;
+			mclk = speed * (bitclkdiv+1);
+		}
+
+		if (clk_set_rate(clk, mclk))
+			dev_err(&spi->dev, "couldn't set %s's rate\n", clk_name);
+
+		dev_info(&spi->dev, "clock: wanted: %i, got: %li\n", speed,
+				clk_round_rate(clk, mclk) / (bitclkdiv+1));
+
+		ccr |= bitclkdiv;
+	}
+#else
 	if (cs->speed_hz)
 		ccr |= (MCLK / cs->speed_hz - 1) & 0xFF;
 	else /* by default SPI Clk 1MHz */
 		ccr |= (MCLK / 1000000 - 1) & 0xFF;
+#endif
 	out_be16(&psc->ccr, ccr);
 	mps->bits_per_word = cs->bits_per_word;
 
@@ -328,13 +368,9 @@ static int mpc52xx_psc_spi_port_config(i
 	u32 mclken_div;
 	int ret = 0;
 
-#if defined(CONFIG_PPC_MERGE)
-	cdm = mpc52xx_find_and_map("mpc5200-cdm");
-	gpio = mpc52xx_find_and_map("mpc5200-gpio");
-#else
+#if !defined(CONFIG_PPC_MERGE)
 	cdm = ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
 	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
-#endif
 	if (!cdm || !gpio) {
 		printk(KERN_ERR "Error mapping CDM/GPIO\n");
 		ret = -EFAULT;
@@ -390,6 +426,7 @@ static int mpc52xx_psc_spi_port_config(i
 		ret = -EINVAL;
 		goto unmap_regs;
 	}
+#endif
 
 	/* Reset the PSC into a known state */
 	out_8(&psc->command, MPC52xx_PSC_RST_RX);
@@ -413,11 +450,13 @@ static int mpc52xx_psc_spi_port_config(i
 
 	mps->bits_per_word = 8;
 
+#if !defined(CONFIG_PPC_MERGE)
 unmap_regs:
 	if (cdm)
 		iounmap(cdm);
 	if (gpio)
 		iounmap(gpio);
+#endif
 
 	return ret;
 }
