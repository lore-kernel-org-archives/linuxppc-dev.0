Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 031C6DDE19
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 06:10:21 +1100 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JUA001T6FV51BB0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 07 Jan 2008 12:09:05 -0700 (MST)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JUA008QOFRT4910@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 07 Jan 2008 12:07:09 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JUA008DJFRSJJ00@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 07 Jan 2008 12:07:04 -0700 (MST)
Date: Mon, 07 Jan 2008 12:07:00 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC 2/2] mpc52xx_psc_spi device driver must not touch port_config	and
	cdm
In-reply-to: <20080107185849.13535.38262.stgit@trillian.secretlab.ca>
To: dragos.carp@toptica.com, linuxppc-dev@ozlabs.org
Message-id: <20080107190404.13535.65688.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080107185849.13535.38262.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

It is dangerous for an mpc52xx device driver to modify the port_config
register.  If the driver is probed incorrectly, it will change the pin
IO configuration in ways which may not be compatible with the board.
port_config should be set up by the bootloader, or failing that, in
the platform setup code in arch/powerpc/platforms/52xx.

Also, modifying CDM registers directly can cause a race condition with
other drivers.  Instead call a common routine to modify CDM settings.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/spi/mpc52xx_psc_spi.c |   77 +----------------------------------------
 1 files changed, 2 insertions(+), 75 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index a3ebc63..253ed56 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -330,80 +330,13 @@ static void mpc52xx_psc_spi_cleanup(struct spi_device *spi)
 
 static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 {
-	struct device_node *np;
-	struct mpc52xx_cdm __iomem *cdm;
-	struct mpc52xx_gpio __iomem *gpio;
 	struct mpc52xx_psc __iomem *psc = mps->psc;
-	u32 ul;
 	u32 mclken_div;
 	int ret = 0;
 
-#if defined(CONFIG_PPC_MERGE)
-	np = of_find_compatible_node(NULL, NULL, "mpc5200-cdm");
-	cdm = of_iomap(np, 0);
-	of_node_put(np);
-	np = of_find_compatible_node(NULL, NULL, "mpc5200-gpio");
-	gpio = of_iomap(np, 0);
-	of_node_put(np);
-#else
-	cdm = ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
-	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
-#endif
-	if (!cdm || !gpio) {
-		printk(KERN_ERR "Error mapping CDM/GPIO\n");
-		ret = -EFAULT;
-		goto unmap_regs;
-	}
-
 	/* default sysclk is 512MHz */
-	mclken_div = 0x8000 |
-		(((mps->sysclk ? mps->sysclk : 512000000) / MCLK) & 0x1FF);
-
-	switch (psc_id) {
-	case 1:
-		ul = in_be32(&gpio->port_config);
-		ul &= 0xFFFFFFF8;
-		ul |= 0x00000006;
-		out_be32(&gpio->port_config, ul);
-		out_be16(&cdm->mclken_div_psc1, mclken_div);
-		ul = in_be32(&cdm->clk_enables);
-		ul |= 0x00000020;
-		out_be32(&cdm->clk_enables, ul);
-		break;
-	case 2:
-		ul = in_be32(&gpio->port_config);
-		ul &= 0xFFFFFF8F;
-		ul |= 0x00000060;
-		out_be32(&gpio->port_config, ul);
-		out_be16(&cdm->mclken_div_psc2, mclken_div);
-		ul = in_be32(&cdm->clk_enables);
-		ul |= 0x00000040;
-		out_be32(&cdm->clk_enables, ul);
-		break;
-	case 3:
-		ul = in_be32(&gpio->port_config);
-		ul &= 0xFFFFF0FF;
-		ul |= 0x00000600;
-		out_be32(&gpio->port_config, ul);
-		out_be16(&cdm->mclken_div_psc3, mclken_div);
-		ul = in_be32(&cdm->clk_enables);
-		ul |= 0x00000080;
-		out_be32(&cdm->clk_enables, ul);
-		break;
-	case 6:
-		ul = in_be32(&gpio->port_config);
-		ul &= 0xFF8FFFFF;
-		ul |= 0x00700000;
-		out_be32(&gpio->port_config, ul);
-		out_be16(&cdm->mclken_div_psc6, mclken_div);
-		ul = in_be32(&cdm->clk_enables);
-		ul |= 0x00000010;
-		out_be32(&cdm->clk_enables, ul);
-		break;
-	default:
-		ret = -EINVAL;
-		goto unmap_regs;
-	}
+	mclken_div = (mps->sysclk ? mps->sysclk : 512000000) / MCLK;
+	mpc52xx_set_psc_clkdiv(psc_id, mclken_div);
 
 	/* Reset the PSC into a known state */
 	out_8(&psc->command, MPC52xx_PSC_RST_RX);
@@ -427,12 +360,6 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 
 	mps->bits_per_word = 8;
 
-unmap_regs:
-	if (cdm)
-		iounmap(cdm);
-	if (gpio)
-		iounmap(gpio);
-
 	return ret;
 }
 
