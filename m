Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 82D69DDDEF
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 16:51:00 +1100 (EST)
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JWQ00EYLAWYYBD0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 23 Feb 2008 22:50:58 -0700 (MST)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JWQ00NRLAWX4N10@pd2mr6so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sat, 23 Feb 2008 22:50:58 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JWQ00H8NAWXIY40@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 23 Feb 2008 22:50:57 -0700 (MST)
Date: Sat, 23 Feb 2008 22:49:55 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] mpc5200: fix build error on mpc52xx_psc_spi device
	driver
To: dbrownell@users.sourceforge.net, dragos.carp@toptica.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net
Message-id: <20080224054955.21886.79000.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Commit id 94f389485e27641348c1951ab8d65157122a8939 (Separate MPC52xx PSC
FIOF regsiters from the rest of PSC) split the PSC fifo registers away
from the core PSC regs.  Doing so broke the mpc52xx_psc_spi driver.

This patch teaches the mpc52xx_psc_spi driver about the new PSC fifo
register definitions.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

---
This is a build error bug fix which needs to go into .25
---

 drivers/spi/mpc52xx_psc_spi.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 253ed56..a86315a 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -42,6 +42,7 @@ struct mpc52xx_psc_spi {
 
 	/* driver internal data */
 	struct mpc52xx_psc __iomem *psc;
+	struct mpc52xx_psc_fifo __iomem *fifo;
 	unsigned int irq;
 	u8 bits_per_word;
 	u8 busy;
@@ -139,6 +140,7 @@ static int mpc52xx_psc_spi_transfer_rxtx(struct spi_device *spi,
 {
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(spi->master);
 	struct mpc52xx_psc __iomem *psc = mps->psc;
+	struct mpc52xx_psc_fifo __iomem *fifo = mps->fifo;
 	unsigned rb = 0;	/* number of bytes receieved */
 	unsigned sb = 0;	/* number of bytes sent */
 	unsigned char *rx_buf = (unsigned char *)t->rx_buf;
@@ -190,11 +192,11 @@ static int mpc52xx_psc_spi_transfer_rxtx(struct spi_device *spi,
 			out_8(&psc->mode, 0);
 		} else {
 			out_8(&psc->mode, MPC52xx_PSC_MODE_FFULL);
-			out_be16(&psc->rfalarm, rfalarm);
+			out_be16(&fifo->rfalarm, rfalarm);
 		}
 		out_be16(&psc->mpc52xx_psc_imr, MPC52xx_PSC_IMR_RXRDY);
 		wait_for_completion(&mps->done);
-		recv_at_once = in_be16(&psc->rfnum);
+		recv_at_once = in_be16(&fifo->rfnum);
 		dev_dbg(&spi->dev, "%d bytes received\n", recv_at_once);
 
 		send_at_once = recv_at_once;
@@ -331,6 +333,7 @@ static void mpc52xx_psc_spi_cleanup(struct spi_device *spi)
 static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 {
 	struct mpc52xx_psc __iomem *psc = mps->psc;
+	struct mpc52xx_psc_fifo __iomem *fifo = mps->fifo;
 	u32 mclken_div;
 	int ret = 0;
 
@@ -346,7 +349,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 	/* Disable interrupts, interrupts are based on alarm level */
 	out_be16(&psc->mpc52xx_psc_imr, 0);
 	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
-	out_8(&psc->rfcntl, 0);
+	out_8(&fifo->rfcntl, 0);
 	out_8(&psc->mode, MPC52xx_PSC_MODE_FFULL);
 
 	/* Configure 8bit codec mode as a SPI master and use EOF flags */
@@ -419,6 +422,8 @@ static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 		ret = -EFAULT;
 		goto free_master;
 	}
+	/* On the 5200, fifo regs are immediately ajacent to the psc regs */
+	mps->fifo = ((void __iomem *)mps->psc) + sizeof(struct mpc52xx_psc);
 
 	ret = request_irq(mps->irq, mpc52xx_psc_spi_isr, 0, "mpc52xx-psc-spi",
 				mps);
