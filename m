Return-Path: <gsi@denx.de>
Date: Fri, 19 Jul 2013 11:41:43 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 16/24] net: can: mscan: make mpc512x code use common
 clock
Message-ID: <20130719094143.GQ7080@book.gsilab.sittig.org>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374178858-8683-2-git-send-email-gsi@denx.de>
 <51E8EC17.9060703@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51E8EC17.9060703@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>, David Woodhouse <dwmw2@infradead.org>,
 devicetree-discuss@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 19, 2013 at 09:34 +0200, Marc Kleine-Budde wrote:
> 
> On 07/18/2013 10:20 PM, Gerhard Sittig wrote:
> > extend the mscan(4) driver with alternative support for the COMMON_CLK
> > approach which is an option in the MPC512x platform, keep the existing
> > clock support implementation in place since the driver is shared with
> > other MPC5xxx SoCs which don't have common clock support
> > 
> > one byproduct of this change is that the CAN driver no longer needs to
> > access the SoC's clock control registers, which shall be the domain of
> > the platform's clock driver
> > 
> > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > ---
> >  drivers/net/can/mscan/mpc5xxx_can.c |  139 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 139 insertions(+)
> > 
> > diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
> > index bc422ba..dd26ab6 100644
> > --- a/drivers/net/can/mscan/mpc5xxx_can.c
> > +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> > @@ -108,6 +108,143 @@ static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
> >  #endif /* CONFIG_PPC_MPC52xx */
> >  
> >  #ifdef CONFIG_PPC_MPC512x
> > +
> > +#if IS_ENABLED(CONFIG_COMMON_CLK)
> > +
> > +static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
> > +				 const char *clock_source, int *mscan_clksrc)
> > +{
> > +	struct device_node *np;
> > +	u32 clockdiv;
> > +	enum {
> > +		CLK_FROM_AUTO,
> > +		CLK_FROM_IPS,
> > +		CLK_FROM_SYS,
> > +		CLK_FROM_REF,
> > +	} clk_from;
> > +	struct clk *clk_in, *clk_can;
> > +	unsigned long freq_calc;
> > +
> > +	/* the caller passed in the clock source spec that was read from
> > +	 * the device tree, get the optional clock divider as well
> > +	 */
> > +	np = ofdev->dev.of_node;
> > +	clockdiv = 1;
> > +	of_property_read_u32(np, "fsl,mscan-clock-divider", &clockdiv);
> > +	dev_dbg(&ofdev->dev, "device tree specs: clk src[%s] div[%d]\n",
> > +		clock_source ? clock_source : "<NULL>", clockdiv);
> > +
> > +	/* when clock-source is 'ip', the CANCTL1[CLKSRC] bit needs to
> > +	 * get set, and the 'ips' clock is the input to the MSCAN
> > +	 * component
> > +	 *
> > +	 * for clock-source values of 'ref' or 'sys' the CANCTL1[CLKSRC]
> > +	 * bit needs to get cleared, an optional clock-divider may have
> > +	 * been specified (the default value is 1), the appropriate
> > +	 * MSCAN related MCLK is the input to the MSCAN component
> > +	 *
> > +	 * in the absence of a clock-source spec, first an optimal clock
> > +	 * gets determined based on the 'sys' clock, if that fails the
> > +	 * 'ref' clock is used
> > +	 */
> > +	clk_from = CLK_FROM_AUTO;
> > +	if (clock_source) {
> > +		/* interpret the device tree's spec for the clock source */
> > +		if (!strcmp(clock_source, "ip"))
> > +			clk_from = CLK_FROM_IPS;
> > +		else if (!strcmp(clock_source, "sys"))
> > +			clk_from = CLK_FROM_SYS;
> > +		else if (!strcmp(clock_source, "ref"))
> > +			clk_from = CLK_FROM_REF;
> > +		else
> > +			goto err_invalid;
> > +		dev_dbg(&ofdev->dev, "got a clk source spec[%d]\n", clk_from);
> > +	}
> > +	if (clk_from == CLK_FROM_AUTO) {
> > +		/* no spec so far, try the 'sys' clock; round to the
> > +		 * next MHz and see if we can get a multiple of 16MHz
> > +		 */
> > +		dev_dbg(&ofdev->dev, "no clk source spec, trying SYS\n");
> > +		clk_in = clk_get(&ofdev->dev, "sys");
> > +		if (IS_ERR(clk_in))
> > +			goto err_notavail;
> > +		freq_calc = clk_get_rate(clk_in);
> > +		freq_calc +=  499999;
> > +		freq_calc /= 1000000;
> > +		freq_calc *= 1000000;
> > +		if ((freq_calc % 16000000) == 0) {
> > +			clk_from = CLK_FROM_SYS;
> > +			clockdiv = freq_calc / 16000000;
> > +			dev_dbg(&ofdev->dev,
> > +				"clk fit, sys[%lu] div[%d] freq[%lu]\n",
> > +				freq_calc, clockdiv, freq_calc / clockdiv);
> > +		}
> > +	}
> > +	if (clk_from == CLK_FROM_AUTO) {
> > +		/* no spec so far, use the 'ref' clock */
> > +		dev_dbg(&ofdev->dev, "no clk source spec, trying REF\n");
> > +		clk_in = clk_get(&ofdev->dev, "ref");
> > +		if (IS_ERR(clk_in))
> > +			goto err_notavail;
> > +		clk_from = CLK_FROM_REF;
> > +		freq_calc = clk_get_rate(clk_in);
> > +		dev_dbg(&ofdev->dev,
> > +			"clk fit, ref[%lu] (no div) freq[%lu]\n",
> > +			freq_calc, freq_calc);
> > +	}
> > +
> > +	/* select IPS or MCLK as the MSCAN input (returned to the caller),
> > +	 * setup the MCLK mux source and rate if applicable, apply the
> > +	 * optionally specified or derived above divider, and determine
> > +	 * the actual resulting clock rate to return to the caller
> > +	 */
> > +	switch (clk_from) {
> > +	case CLK_FROM_IPS:
> > +		clk_can = clk_get(&ofdev->dev, "ips");
> > +		if (IS_ERR(clk_can))
> > +			goto err_notavail;
> > +		clk_prepare_enable(clk_can);
> 
> Where is the corresponding clk_disable_unprepare()?a

It's missing, as I could not find the counterpart of the
.get_clock() callback where the get and prepare/enable was added
to.  And it appears that neither are enable errors checked for.
This patch clearly needs an update as well, but already should be
the last part of the series in a currently inacceptable state.

This .get_clock() routine is supposed to determine the clock
source, setup the desired rate and return the actual rate.  The
callback's API is rather limited in that it does communicate
clock rate values, but cannot access a location to store handles
to.

Are the introduction of a .put_clock() callback and passing the
'priv' handle to both get and put routines acceptable?  As this
would hook up clock handling to probe() and remove() just as
memory mapping gets approached.

Below is a patch on top of the CAN related patch in v2 of the
series.  If this approach is acceptable (maybe modulo how the
"unused" warnings get silenced), I'll fold it into the
introduction of common clock support in the mscan(4) driver.

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index cf5e4cfc..16ca712 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -39,7 +39,9 @@
 struct mpc5xxx_can_data {
 	unsigned int type;
 	u32 (*get_clock)(struct platform_device *ofdev, const char *clock_name,
-			 int *mscan_clksrc);
+			 int *mscan_clksrc, struct mscan_priv *priv);
+	void (*put_clock)(struct platform_device *ofdev,
+			  struct mscan_priv *priv);
 };
 
 #ifdef CONFIG_PPC_MPC52xx
@@ -49,7 +51,8 @@ static struct of_device_id mpc52xx_cdm_ids[] = {
 };
 
 static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
-				 const char *clock_name, int *mscan_clksrc)
+				 const char *clock_name, int *mscan_clksrc,
+				 struct mscan_priv *priv)
 {
 	unsigned int pvr;
 	struct mpc52xx_cdm  __iomem *cdm;
@@ -101,15 +104,24 @@ static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
 }
 #else /* !CONFIG_PPC_MPC52xx */
 static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
-				 const char *clock_name, int *mscan_clksrc)
+				 const char *clock_name, int *mscan_clksrc,
+				 struct mscan_priv *priv)
 {
 	return 0;
 }
 #endif /* CONFIG_PPC_MPC52xx */
+static void mpc52xx_can_put_clock(struct platform_device *ofdev,
+				  struct mscan_priv *priv)
+{
+	/* EMPTY */
+	(void)ofdev;
+	(void)priv;
+}
 
 #ifdef CONFIG_PPC_MPC512x
 static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
-				 const char *clock_source, int *mscan_clksrc)
+				 const char *clock_source, int *mscan_clksrc,
+				 struct mscan_priv *priv)
 {
 	struct device_node *np;
 	u32 clockdiv;
@@ -200,7 +212,9 @@ static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
 		clk_can = clk_get(&ofdev->dev, "ips");
 		if (IS_ERR(clk_can))
 			goto err_notavail;
-		clk_prepare_enable(clk_can);
+		if (clk_prepare_enable(clk_can))
+			goto err_notavail;
+		priv->clk_can = clk_can;
 		freq_calc = clk_get_rate(clk_can);
 		*mscan_clksrc = MSCAN_CLKSRC_IPS;
 		dev_dbg(&ofdev->dev, "clk from IPS, clksrc[%d] freq[%lu]\n",
@@ -211,7 +225,9 @@ static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
 		clk_can = clk_get(&ofdev->dev, "mclk");
 		if (IS_ERR(clk_can))
 			goto err_notavail;
-		clk_prepare_enable(clk_can);
+		if (clk_prepare_enable(clk_can))
+			goto err_notavail;
+		priv->clk_can = clk_can;
 		if (clk_from == CLK_FROM_SYS)
 			clk_in = clk_get(&ofdev->dev, "sys");
 		if (clk_from == CLK_FROM_REF)
@@ -241,12 +257,31 @@ err_notavail:
 	dev_err(&ofdev->dev, "cannot acquire or setup clock source\n");
 	return 0;
 }
+
+static void mpc512x_can_put_clock(struct platform_device *ofdev,
+				  struct mscan_priv *priv)
+{
+	(void)ofdev;
+	if (priv->clk_can) {
+		clk_disable_unprepare(priv->clk_can);
+		clk_put(priv->clk_can);
+	}
+}
 #else /* !CONFIG_PPC_MPC512x */
 static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
-				 const char *clock_name, int *mscan_clksrc)
+				 const char *clock_name, int *mscan_clksrc,
+				 struct mscan_priv *priv)
 {
 	return 0;
 }
+
+static void mpc512x_can_put_clock(struct platform_device *ofdev,
+				  struct mscan_priv *priv)
+{
+	(void)ofdev;
+	(void)priv;
+	/* EMPTY */
+}
 #endif /* CONFIG_PPC_MPC512x */
 
 static const struct of_device_id mpc5xxx_can_table[];
@@ -293,7 +328,7 @@ static int mpc5xxx_can_probe(struct platform_device *ofdev)
 	BUG_ON(!data);
 	priv->type = data->type;
 	priv->can.clock.freq = data->get_clock(ofdev, clock_name,
-					       &mscan_clksrc);
+					       &mscan_clksrc, priv);
 	if (!priv->can.clock.freq) {
 		dev_err(&ofdev->dev, "couldn't get MSCAN clock properties\n");
 		goto exit_free_mscan;
@@ -327,10 +362,17 @@ exit_unmap_mem:
 
 static int mpc5xxx_can_remove(struct platform_device *ofdev)
 {
+	const struct of_device_id *match;
+	const struct mpc5xxx_can_data *data;
 	struct net_device *dev = platform_get_drvdata(ofdev);
 	struct mscan_priv *priv = netdev_priv(dev);
 
+	match = of_match_device(mpc5xxx_can_table, &ofdev->dev);
+	data = match ? match->data : NULL;
+
 	unregister_mscandev(dev);
+	if (data)
+		data->put_clock(ofdev, priv);
 	iounmap(priv->reg_base);
 	irq_dispose_mapping(dev->irq);
 	free_candev(dev);
@@ -383,11 +425,13 @@ static int mpc5xxx_can_resume(struct platform_device *ofdev)
 static const struct mpc5xxx_can_data mpc5200_can_data = {
 	.type = MSCAN_TYPE_MPC5200,
 	.get_clock = mpc52xx_can_get_clock,
+	.put_clock = mpc52xx_can_put_clock,
 };
 
 static const struct mpc5xxx_can_data mpc5121_can_data = {
 	.type = MSCAN_TYPE_MPC5121,
 	.get_clock = mpc512x_can_get_clock,
+	.put_clock = mpc512x_can_put_clock,
 };
 
 static const struct of_device_id mpc5xxx_can_table[] = {
diff --git a/drivers/net/can/mscan/mscan.h b/drivers/net/can/mscan/mscan.h
index af2ed8b..f32e190 100644
--- a/drivers/net/can/mscan/mscan.h
+++ b/drivers/net/can/mscan/mscan.h
@@ -21,6 +21,7 @@
 #ifndef __MSCAN_H__
 #define __MSCAN_H__
 
+#include <linux/clk.h>
 #include <linux/types.h>
 
 /* MSCAN control register 0 (CANCTL0) bits */
@@ -283,6 +284,7 @@ struct mscan_priv {
 	unsigned int type; 	/* MSCAN type variants */
 	unsigned long flags;
 	void __iomem *reg_base;	/* ioremap'ed address to registers */
+	struct clk *clk_can;	/* clock for registers or bitrates */
 	u8 shadow_statflg;
 	u8 shadow_canrier;
 	u8 cur_pri;

> > +		freq_calc = clk_get_rate(clk_can);
> > +		*mscan_clksrc = MSCAN_CLKSRC_IPS;
> > +		dev_dbg(&ofdev->dev, "clk from IPS, clksrc[%d] freq[%lu]\n",
> > +			*mscan_clksrc, freq_calc);
> > +		break;
> > +	case CLK_FROM_SYS:
> > +	case CLK_FROM_REF:
> > +		clk_can = clk_get(&ofdev->dev, "mclk");
> > +		if (IS_ERR(clk_can))
> > +			goto err_notavail;
> > +		clk_prepare_enable(clk_can);
> 
> dito

yes, both problems of not checking for errors and dropping the
reference, will address this as well


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
