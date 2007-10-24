Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 743E9DDF17
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 04:24:35 +1000 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQF00CTWHSWYHD0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 24 Oct 2007 12:24:32 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQF00ARBHSVMA40@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 24 Oct 2007 12:24:32 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JQF001VPHSTJF20@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 24 Oct 2007 12:24:30 -0600 (MDT)
Date: Wed, 24 Oct 2007 12:24:31 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] mpc5200: psc-spi driver must not touch port_config or cdm
	registers
In-reply-to: <20071024182308.21194.69416.stgit@trillian.cg.shawcable.net>
To: domen.puncer@telargo.com, linuxppc-dev@ozlabs.org
Message-id: <20071024182431.21194.87764.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071024182308.21194.69416.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

port_config and the cdm are the responsibility of firmware; and if
firmware doesn't set it up correctly, it should be fixed up by
platform code on a per-board basis because it's a property of the
board.

Drivers should never touch these registers.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/spi/mpc52xx_psc_spi.c |   84 ++++-------------------------------------
 1 files changed, 8 insertions(+), 76 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 7051e6c..44d1110 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -328,77 +328,15 @@ static void mpc52xx_psc_spi_cleanup(struct spi_device *spi)
 	kfree(spi->controller_state);
 }
 
-static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
+static int mpc52xx_psc_spi_config(int psc_id, struct mpc52xx_psc_spi *mps)
 {
-	struct mpc52xx_cdm __iomem *cdm;
-	struct mpc52xx_gpio __iomem *gpio;
 	struct mpc52xx_psc __iomem *psc = mps->psc;
-	u32 ul;
-	u32 mclken_div;
-	int ret = 0;
+	int rc;
 
-#if defined(CONFIG_PPC_MERGE)
-	cdm = mpc52xx_find_and_map("mpc5200-cdm");
-	gpio = mpc52xx_find_and_map("mpc5200-gpio");
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
-	/* default sysclk is 512MHz */
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
+	/* Setup a desirable MCLK */
+	rc = mpc52xx_cdm_set_psc_clk(psc_id, MCLK);
+	if (rc)
+		return rc;
 
 	/* Reset the PSC into a known state */
 	out_8(&psc->command, MPC52xx_PSC_RST_RX);
@@ -422,13 +360,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 
 	mps->bits_per_word = 8;
 
-unmap_regs:
-	if (cdm)
-		iounmap(cdm);
-	if (gpio)
-		iounmap(gpio);
-
-	return ret;
+	return 0;
 }
 
 static irqreturn_t mpc52xx_psc_spi_isr(int irq, void *dev_id)
@@ -493,7 +425,7 @@ static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	if (ret)
 		goto free_master;
 
-	ret = mpc52xx_psc_spi_port_config(master->bus_num, mps);
+	ret = mpc52xx_psc_spi_config(master->bus_num-1, mps);
 	if (ret < 0)
 		goto free_irq;
 
