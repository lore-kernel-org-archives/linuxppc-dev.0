Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 755F6DDDE0
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 01:54:55 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so30437qwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 07:54:53 -0700 (PDT)
Date: Wed, 29 Oct 2008 10:53:05 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v3] spi: Add PPC4xx SPI driver
Message-ID: <20081029145305.GA3676@yoda.jdub.homelinux.org>
References: <1225000124-29366-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1225000124-29366-1-git-send-email-sr@denx.de>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, weo@reccoware.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 26, 2008 at 06:48:44AM +0100, Stefan Roese wrote:
>This adds a SPI driver for the SPI controller found in the IBM/AMCC
>4xx PowerPC's.
>
>Signed-off-by: Stefan Roese <sr@denx.de>
>Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
>---
>Changes in v3:
>- When the device is removed the GPIOs are released. The memory
>  for the GPIO array is freed.
>
>Changes in v2:
>- Now the gpios property is correctly decoded and the
>  resulting gpio numbers are used as the devices chip
>  selects.
>
>  So we can describe the SPI node like this:
>
>        SPI0: spi@ef600900 {
>                #address-cells = <1>;
>                #size-cells = <0>;
>                ...
>
>                /* two GPIOs, representing two chip selects: 0 and 1 */
>                gpios = <&GPIO0 5 0 &GPIO1 16 0>;
>
>                mmc-slot@0 {
>                        reg = <0>;
>                        ...
>                };
>
>                touchscreen@1 {
>                        reg = <1>;
>                        ...
>                };
>        }
>
>Special thanks to Wolfgang Ocker and Anton Vorontsov for their input.

Looks pretty good.  Just a few minor comments/questions below.

Also, do you have a patch for a DTS file that gives an example of how to
instantiate the SPI stuff in the device tree?

>diff --git a/drivers/spi/spi_ppc4xx.c b/drivers/spi/spi_ppc4xx.c
>new file mode 100644
>index 0000000..6f94acc
>--- /dev/null
>+++ b/drivers/spi/spi_ppc4xx.c
>+#include <linux/module.h>
>+#include <linux/init.h>
>+#include <linux/sched.h>
>+#include <linux/errno.h>
>+#include <linux/wait.h>
>+#include <linux/of_platform.h>
>+#include <linux/of_spi.h>
>+#include <linux/of_gpio.h>
>+#include <linux/interrupt.h>
>+#include <linux/delay.h>
>+
>+#include <linux/gpio.h>
>+#include <linux/spi/spi.h>
>+#include <linux/spi/spi_bitbang.h>
>+
>+#include <asm/io.h>
>+#include <asm/dcr-native.h>

Should maybe just be <asm/dcr.h>

>+#include <asm/dcr-regs.h>
>+

<snip>

>+/* SPI Controller driver's private data. */
>+struct ppc4xx_spi {
>+	/* bitbang has to be first */
>+	struct spi_bitbang bitbang;
>+	struct completion done;
>+
>+	u64 mapbase;
>+	u64 mapsize;
>+	int irqnum;
>+	/* need this to set the SPI clock */
>+	unsigned int opb_freq;
>+
>+	/* for transfers */
>+	int len;
>+	int count;
>+	/* data buffers */
>+	const unsigned char *tx;
>+	unsigned char *rx;
>+
>+	int *gpios;
>+	unsigned int num_gpios;
>+
>+	volatile struct spi_ppc4xx_regs __iomem *regs; /* pointer to the registers */

volatile?

>+	struct spi_master *master;
>+	struct device *dev;
>+};

<snip>

>+static int spi_ppc4xx_txrx(struct spi_device *spi, struct spi_transfer *t)
>+{
>+	struct ppc4xx_spi *hw;
>+	u8 data;
>+
>+	dev_dbg(&spi->dev, "txrx: tx %p, rx %p, len %d\n",
>+		t->tx_buf, t->rx_buf, t->len);
>+
>+	hw = spi_master_get_devdata(spi->master);
>+
>+	hw->tx = t->tx_buf;
>+	hw->rx = t->rx_buf;
>+	hw->len = t->len;
>+	hw->count = 0;
>+
>+	/* send the first byte */
>+	data = hw->tx ? hw->tx[0] : 0;
>+	out_8(&hw->regs->txd, data);
>+	out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);

Maybe iowrite8?  Same comment elsewhere.

>+	wait_for_completion(&hw->done);
>+
>+	return hw->count;
>+}
>+

<snip>

>+static struct of_device_id spi_ppc4xx_of_match[] = {
>+	{ .compatible = "ibm,spi", },
>+	{},
>+};

I'm wondering if that is too generic of a match.  In theory,
IBM could have another SPI controller that isn't for 4xx.
Maybe "ibm,spi-4xx" ?

josh
