Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 64BBCDDE03
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 02:03:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Simple driver for Xilinx SPI controler.
Date: Wed, 6 Jun 2007 09:03:26 -0700
In-Reply-To: <4666BF47.8080103@ru.mvista.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>,
	<spi-devel-general@lists.sourceforge.net>
Message-Id: <20070606160329.A8A719E0060@mail81-sin.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


In order to anticipate future Microblaze support with most of these
drivers,
we've been moving towards having all of the Kconfig dependencies on
XILINX_EDK,
rather than XILINX_VIRTEX...

Steve Neuendorffer

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> =20
> [mailto:linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@oz
labs.org] On Behalf Of Andrei Konovalov
> Sent: Wednesday, June 06, 2007 7:06 AM
> To: spi-devel-general@lists.sourceforge.net
> Cc: linuxppc-embedded@ozlabs.org
> Subject: [PATCH] Simple driver for Xilinx SPI controler.
>=20
> +config SPI_XILINX
> +	tristate "Xilinx SPI controller"
> +	depends on SPI_MASTER && XILINX_VIRTEX && EXPERIMENTAL
> +	select SPI_BITBANG
> +	help
> +	  This enables using the SPI controller IP from Xilinx=20
> EDK in master
> +	  mode. See the DS464, "OPB Serial Peripheral Interface=20
> (SPI) (v1.00e)"
> +	  Product Specification document for the hardware details.
>   #
>   # Add new SPI master controllers in alphabetical order=20
> above this line
>   #
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile=20
> index 5788d86..a2412bd 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_SPI_MPC52xx_PSC)	=09
> +=3D mpc52xx_psc_spi.o
>   obj-$(CONFIG_SPI_MPC83xx)		+=3D spi_mpc83xx.o
>   obj-$(CONFIG_SPI_S3C24XX_GPIO)		+=3D spi_s3c24xx_gpio.o
>   obj-$(CONFIG_SPI_S3C24XX)		+=3D spi_s3c24xx.o
> +obj-$(CONFIG_SPI_XILINX)		+=3D xilinx_spi.o
>   # 	... add above this line ...
>=20
>   # SPI protocol drivers (device/link on bus) diff --git=20
> a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c new=20
> file mode 100644 index 0000000..e5f149f
> --- /dev/null
> +++ b/drivers/spi/xilinx_spi.c
> @@ -0,0 +1,447 @@
> +/*
> + * xilinx_spi.c
> + *
> + * Xilinx SPI controler driver (master mode only)
> + *
> + * Author: MontaVista Software, Inc.
> + *         source@mvista.com
> + *
> + * 2002-2007 (c) MontaVista Software, Inc.  This file is=20
> licensed under=20
> +the
> + * terms of the GNU General Public License version 2.  This=20
> program is=20
> +licensed
> + * "as is" without any warranty of any kind, whether express=20
> or implied.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi_bitbang.h>
> +
> +#include <asm/io.h>
> +#include <syslib/virtex_devices.h>
> +
> +#define XILINX_SPI_NAME "xspi"
> +
> +/* Register definitions as per "OPB Serial Peripheral=20
> Interface (SPI)=20
> +(v1.00e)
> + * Product Specification", DS464
> + */
> +#define XSPI_CR_OFFSET		0x62	/* 16-bit=20
> Control Register */
> +
> +#define XSPI_CR_ENABLE		0x02
> +#define XSPI_CR_MASTER_MODE	0x04
> +#define XSPI_CR_CPOL		0x08
> +#define XSPI_CR_CPHA		0x10
> +#define XSPI_CR_MODE_MASK	(XSPI_CR_CPHA | XSPI_CR_CPOL)
> +#define XSPI_CR_TXFIFO_RESET	0x20
> +#define XSPI_CR_RXFIFO_RESET	0x40
> +#define XSPI_CR_MANUAL_SSELECT	0x80
> +#define XSPI_CR_TRANS_INHIBIT	0x100
> +
> +#define XSPI_SR_OFFSET		0x67	/* 8-bit Status=20
> Register */
> +
> +#define XSPI_SR_RX_EMPTY_MASK	0x01	/* Receive FIFO=20
> is empty */
> +#define XSPI_SR_RX_FULL_MASK	0x02	/* Receive FIFO is full */
> +#define XSPI_SR_TX_EMPTY_MASK	0x04	/* Transmit=20
> FIFO is empty */
> +#define XSPI_SR_TX_FULL_MASK	0x08	/* Transmit FIFO is full */
> +#define XSPI_SR_MODE_FAULT_MASK	0x10	/* Mode fault error */
> +
> +#define XSPI_TXD_OFFSET		0x6b	/* 8-bit Data=20
> Transmit Register */
> +#define XSPI_RXD_OFFSET		0x6f	/* 8-bit Data=20
> Receive Register */
> +
> +#define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave=20
> Select Register */
> +
> +/* Register definitions as per "OPB IPIF (v3.01c) Product=20
> +Specification", DS414
> + * IPIF registers are 32 bit
> + */
> +#define XIPIF_V123B_DGIER_OFFSET	0x1c	/* IPIF global=20
> int enable reg */
> +#define XIPIF_V123B_GINTR_ENABLE	0x80000000
> +
> +#define XIPIF_V123B_IISR_OFFSET		0x20	/* IPIF=20
> interrupt status reg */
> +#define XIPIF_V123B_IIER_OFFSET		0x28	/* IPIF=20
> interrupt enable reg */
> +
> +#define XSPI_INTR_MODE_FAULT		0x01	/* Mode fault error */
> +#define XSPI_INTR_SLAVE_MODE_FAULT	0x02	/* Selected as=20
> slave while
> +                                                * disabled */
> +#define XSPI_INTR_TX_EMPTY		0x04	/* TxFIFO is empty */
> +#define XSPI_INTR_TX_UNDERRUN		0x08	/*=20
> TxFIFO was underrun */
> +#define XSPI_INTR_RX_FULL		0x10	/* RxFIFO is full */
> +#define XSPI_INTR_RX_OVERRUN		0x20	/* RxFIFO was overrun */
> +
> +#define XIPIF_V123B_RESETR_OFFSET	0x40	/* IPIF reset=20
> register */
> +#define XIPIF_V123B_RESET_MASK		0x0a	/* the=20
> value to write */
> +
> +/* Simple macros to get the code more readable */
> +#define xspi_in16(addr)		in_be16((u16 __iomem *)(addr))
> +#define xspi_in32(addr)		in_be32((u32 __iomem *)(addr))
> +#define xspi_out16(addr, value)	out_be16((u16 __iomem=20
> *)(addr), (value))
> +#define xspi_out32(addr, value)	out_be32((u32 __iomem=20
> *)(addr), (value))
> +
> +struct xilinx_spi {
> +	/* bitbang has to be first */
> +	struct spi_bitbang bitbang;
> +	struct completion done;
> +
> +	u32		regs_phys;	/* phys. address of the=20
> control registers */
> +	void __iomem	*regs;		/* virt. address of the=20
> control registers */
> +
> +	u32 irq;
> +
> +	u8 *rx_ptr;		/* pointer in the Tx buffer */
> +	const u8 *tx_ptr;	/* pointer in the Rx buffer */
> +	int remaining_bytes;	/* the number of bytes left to=20
> transfer */
> +};
> +
> +static void xspi_abort_transfer(u8 __iomem *regs_base) {
> +	/* Deselect the slave on the SPI bus */
> +	xspi_out32(regs_base + XSPI_SSR_OFFSET, 0xffff);
> +
> +	/* Terminate transmit in progress (if any) and Reset=20
> the FIFOs */
> +	xspi_out16(regs_base + XSPI_CR_OFFSET,
> +		   xspi_in16(regs_base + XSPI_CR_OFFSET)
> +		   | XSPI_CR_TRANS_INHIBIT | XSPI_CR_TXFIFO_RESET
> +		   | XSPI_CR_RXFIFO_RESET);
> +}
> +
> +static void xspi_init_hw(u8 __iomem *regs_base) {
> +	/* Reset the SPI device */
> +	xspi_out32(regs_base + XIPIF_V123B_RESETR_OFFSET,
> +		   XIPIF_V123B_RESET_MASK);
> +	/* Disable all the interrupts just in case */
> +	xspi_out32(regs_base + XIPIF_V123B_IIER_OFFSET, 0);
> +	/* Enable the global IPIF interrupt */
> +	xspi_out32(regs_base + XIPIF_V123B_DGIER_OFFSET,
> +		   XIPIF_V123B_GINTR_ENABLE);
> +	/* Deselect the slave on the SPI bus */
> +	xspi_out32(regs_base + XSPI_SSR_OFFSET, 0xffff);
> +	/* Disable the transmitter, enable Manual Slave Select=20
> Assertion,
> +	 * put SPI controller into master mode, and enable it */
> +	xspi_out16(regs_base + XSPI_CR_OFFSET,
> +		   XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT
> +		   | XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE); }
> +
> +static void xilinx_spi_chipselect(struct spi_device *spi,=20
> int is_on) {
> +	struct xilinx_spi *xspi;
> +	u8 __iomem *regs_base;
> +
> +	xspi =3D spi_master_get_devdata(spi->master);
> +	regs_base =3D xspi->regs;
> +
> +	if (is_on =3D=3D BITBANG_CS_INACTIVE) {
> +		/* Deselect the slave on the SPI bus */
> +		xspi_out32(regs_base + XSPI_SSR_OFFSET, 0xffff);
> +	} else if (is_on =3D=3D BITBANG_CS_ACTIVE) {
> +		/* Set the SPI clock phase and polarity */
> +		u16 cr =3D xspi_in16(regs_base + XSPI_CR_OFFSET)
> +			 & ~XSPI_CR_MODE_MASK;
> +		if (spi->mode & SPI_CPHA)
> +			cr |=3D XSPI_CR_CPHA;
> +		if (spi->mode & SPI_CPOL)
> +			cr |=3D XSPI_CR_CPOL;
> +		xspi_out16(regs_base + XSPI_CR_OFFSET, cr);
> +
> +		/* We do not check spi->max_speed_hz here as=20
> the SPI clock
> +		 * frequency is not software programmable (the=20
> IP block design
> +		 * parameter)
> +		 */
> +
> +		/* Activate the chip select */
> +		xspi_out32(regs_base + XSPI_SSR_OFFSET,
> +			   ~(0x0001 << spi->chip_select));
> +	}
> +}
> +
> +/* spi_bitbang requires custom setup_transfer() to be=20
> defined if there=20
> +is a
> + * custom txrx_bufs(). We have nothing to setup here as the SPI IP=20
> +block
> + * supports just 8 bits per word, and SPI clock can't be=20
> changed in software.
> + * Check for 8 bits per word; speed_hz checking could be=20
> added if the=20
> +SPI
> + * clock information is available. Chip select delay=20
> calculations could=20
> +be
> + * added here as soon as bitbang_work() can be made aware of=20
> the delay value.
> + */
> +static int xilinx_spi_setup_transfer(struct spi_device *spi,
> +				     struct spi_transfer *t)
> +{
> +	u8 bits_per_word;
> +
> +	bits_per_word =3D (t) ? t->bits_per_word : spi->bits_per_word;
> +	if (bits_per_word !=3D 8)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +
> +static int xilinx_spi_setup(struct spi_device *spi) {
> +	struct spi_bitbang *bitbang;
> +	struct xilinx_spi *xspi;
> +	int retval;
> +
> +	xspi =3D spi_master_get_devdata(spi->master);
> +	bitbang =3D &xspi->bitbang;
> +
> +	if (!spi->bits_per_word)
> +		spi->bits_per_word =3D 8;
> +
> +	retval =3D xilinx_spi_setup_transfer(spi, NULL);
> +	if (retval < 0)
> +		return retval;
> +
> +	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec/bit\n",
> +		__FUNCTION__, spi->mode & (SPI_CPOL | SPI_CPHA),
> +		spi->bits_per_word, 0);
> +
> +	return 0;
> +}
> +
> +static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct=20
> +spi_transfer *t) {
> +	struct xilinx_spi *xspi;
> +	u8 __iomem *regs_base;
> +	u32 ipif_ier;
> +	u16 cr;
> +	u8 sr;
> +
> +	/* We get here with transmitter inhibited */
> +
> +	xspi =3D spi_master_get_devdata(spi->master);
> +	regs_base =3D xspi->regs;
> +
> +	xspi->tx_ptr =3D t->tx_buf;
> +	xspi->rx_ptr =3D t->rx_buf;
> +	xspi->remaining_bytes =3D t->len;
> +	INIT_COMPLETION(xspi->done);
> +
> +	/* Fill the Tx FIFO with as many bytes as possible */
> +	sr =3D in_8(regs_base + XSPI_SR_OFFSET);
> +	while ((sr & XSPI_SR_TX_FULL_MASK) =3D=3D 0 &&=20
> xspi->remaining_bytes > 0) {
> +		if (xspi->tx_ptr) {
> +			out_8(regs_base + XSPI_TXD_OFFSET,=20
> *xspi->tx_ptr++);
> +		} else {
> +			out_8(regs_base + XSPI_TXD_OFFSET, 0);
> +		}
> +		xspi->remaining_bytes--;
> +		sr =3D in_8(regs_base + XSPI_SR_OFFSET);
> +	}
> +
> +	/* Enable the transmit empty interrupt, which we use to=20
> determine
> +	 * progress on the transmission.
> +	 */
> +	ipif_ier =3D xspi_in32(regs_base + XIPIF_V123B_IIER_OFFSET);
> +	xspi_out32(regs_base + XIPIF_V123B_IIER_OFFSET,
> +		   ipif_ier | XSPI_INTR_TX_EMPTY);
> +
> +	/* Start the transfer by not inhibiting the transmitter=20
> any longer */
> +	cr =3D xspi_in16(regs_base + XSPI_CR_OFFSET) &=20
> ~XSPI_CR_TRANS_INHIBIT;
> +	xspi_out16(regs_base + XSPI_CR_OFFSET, cr);
> +
> +	wait_for_completion(&xspi->done);
> +
> +	/* Disable the transmit empty interrupt */
> +	xspi_out32(regs_base + XIPIF_V123B_IIER_OFFSET, ipif_ier);
> +
> +	return t->len - xspi->remaining_bytes; }
> +
> +
> +/* This driver supports single master mode only. Hence Tx FIFO Empty
> + * is the only interrupt we care about.
> + * Receive FIFO Overrun, Transmit FIFO Underrun, Mode Fault,=20
> and Slave=20
> +Mode
> + * Fault are not to happen.
> + */
> +static irqreturn_t xilinx_spi_irq(int irq, void *dev_id) {
> +	struct xilinx_spi *xspi;
> +	u8 __iomem *regs_base;
> +	u32 ipif_isr;
> +
> +	xspi =3D (struct xilinx_spi *) dev_id;
> +	regs_base =3D xspi->regs;
> +
> +     	/* Get the IPIF inetrrupts, and clear them=20
> immediately */
> +	ipif_isr =3D xspi_in32(regs_base + XIPIF_V123B_IISR_OFFSET);
> +	xspi_out32(regs_base + XIPIF_V123B_IISR_OFFSET, ipif_isr);
> +
> +	if (ipif_isr & XSPI_INTR_TX_EMPTY) {	/* Transmission=20
> completed */
> +		u16 cr;
> +		u8 sr;
> +
> +		/* A transmit has just completed. Process=20
> received data and
> +		 * check for more data to transmit. Always inhibit the
> +		 * transmitter while the Isr refills the=20
> transmit register/FIFO,
> +		 * or make sure it is stopped if we're done.
> +	         */
> +		cr =3D xspi_in16(regs_base + XSPI_CR_OFFSET);
> +		xspi_out16(regs_base + XSPI_CR_OFFSET,
> +			   cr | XSPI_CR_TRANS_INHIBIT);
> +
> +		/* Read out all the data from the Rx FIFO */
> +		sr =3D in_8(regs_base + XSPI_SR_OFFSET);
> +		while ((sr & XSPI_SR_RX_EMPTY_MASK) =3D=3D 0) {
> +			u8 data;
> +
> +			data =3D in_8(regs_base + XSPI_RXD_OFFSET);
> +			if (xspi->rx_ptr) {
> +				*xspi->rx_ptr++ =3D data;
> +			}
> +			sr =3D in_8(regs_base + XSPI_SR_OFFSET);
> +		}
> +
> +	        /* See if there is more data to send */
> +		if (xspi->remaining_bytes > 0) {
> +			/* sr content is valid here; no need=20
> for io_8() */
> +			while ((sr & XSPI_SR_TX_FULL_MASK) =3D=3D 0
> +				&& xspi->remaining_bytes > 0) {
> +				if (xspi->tx_ptr) {
> +					out_8(regs_base +=20
> XSPI_TXD_OFFSET,
> +					      *xspi->tx_ptr++);
> +				} else {
> +					out_8(regs_base +=20
> XSPI_TXD_OFFSET, 0);
> +				}
> +				xspi->remaining_bytes--;
> +				sr =3D in_8(regs_base + XSPI_SR_OFFSET);
> +			}
> +			/* Start the transfer by not inhibiting the
> +			 * transmitter any longer
> +			 */
> +			xspi_out16(regs_base + XSPI_CR_OFFSET, cr);
> +		} else {
> +			/* No more data to send.
> +			 * Indicate the transfer is completed.
> +			 */
> +			complete(&xspi->done);
> +		}
> +	} else {
> +		/* spurious interrupt */
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init xilinx_spi_probe(struct platform_device *dev) {
> +	int ret =3D 0;
> +	struct spi_master *master;
> +	struct xilinx_spi *xspi;
> +	struct xspi_platform_data *pdata;
> +	struct resource *r;
> +
> +	/* Get resources(memory, IRQ) associated with the device */
> +	master =3D spi_alloc_master(&dev->dev, sizeof(struct xilinx_spi));
> +
> +	if (master =3D=3D NULL) {
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(dev, master);
> +	pdata =3D dev->dev.platform_data;
> +
> +	if (pdata =3D=3D NULL) {
> +		ret =3D -ENODEV;
> +		goto put_master;
> +	}
> +
> +	r =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (r =3D=3D NULL) {
> +		ret =3D -ENODEV;
> +		goto put_master;
> +	}
> +
> +	xspi =3D spi_master_get_devdata(master);
> +	xspi->bitbang.master =3D spi_master_get(master);
> +	xspi->bitbang.chipselect =3D xilinx_spi_chipselect;
> +	xspi->bitbang.setup_transfer =3D xilinx_spi_setup_transfer;
> +	xspi->bitbang.txrx_bufs =3D xilinx_spi_txrx_bufs;
> +	xspi->bitbang.master->setup =3D xilinx_spi_setup;
> +	init_completion(&xspi->done);
> +
> +	xspi->regs =3D ioremap(r->start, r->end - r->start + 1);
> +	if (xspi->regs =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto put_master;
> +	}
> +
> +	xspi->irq =3D platform_get_irq(dev, 0);
> +	if (xspi->irq < 0) {
> +		ret =3D -ENXIO;
> +		goto unmap_io;
> +	}
> +
> +	master->bus_num =3D pdata->bus_num;
> +	master->num_chipselect =3D pdata->num_chipselect;
> +
> +	/* SPI controller initializations */
> +	xspi_init_hw(xspi->regs);
> +
> +	/* Register for SPI Interrupt */
> +	ret =3D request_irq(xspi->irq, xilinx_spi_irq, 0,=20
> XILINX_SPI_NAME, xspi);
> +	if (ret !=3D 0)
> +		goto unmap_io;
> +
> +	ret =3D spi_bitbang_start(&xspi->bitbang);
> +	if (ret !=3D 0) {
> +		printk(KERN_ALERT "spi_btbang_start FAILED\n");
> +		goto free_irq;
> +	}
> +
> +	printk(KERN_INFO "%s: at 0x%08X mapped to 0x%08X, irq=3D%d\n",
> +	       dev->dev.bus_id, r->start, (u32)xspi->regs, xspi->irq);
> +
> +	return ret;
> +
> +free_irq:
> +        free_irq(xspi->irq, xspi);
> +unmap_io:
> +	iounmap(xspi->regs);
> +put_master:
> +        spi_master_put(master);
> +	return ret;
> +}
> +
> +static int __devexit xilinx_spi_remove(struct platform_device *dev) {
> +	struct xilinx_spi *xspi;
> +	struct spi_master *master;
> +
> +	master =3D platform_get_drvdata(dev);
> +	xspi =3D spi_master_get_devdata(master);
> +
> +	spi_bitbang_stop(&xspi->bitbang);
> +	xspi_abort_transfer(xspi->regs);
> +	free_irq(xspi->irq, xspi);
> +	iounmap(xspi->regs);
> +	platform_set_drvdata(dev, 0);
> +	spi_master_put(xspi->bitbang.master);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver xilinx_spi_driver =3D {
> +	.probe	=3D xilinx_spi_probe,
> +	.remove	=3D __devexit_p(xilinx_spi_remove),
> +	.driver =3D {
> +		   .name =3D XILINX_SPI_NAME,
> +		   .owner =3D THIS_MODULE,
> +	},
> +};
> +
> +static int __init xilinx_spi_init(void) {
> +	return platform_driver_register(&xilinx_spi_driver);
> +}
> +
> +static void __exit xilinx_spi_exit(void) {
> +	platform_driver_unregister(&xilinx_spi_driver);
> +}
> +
> +module_init(xilinx_spi_init);
> +module_exit(xilinx_spi_exit);
> +
> +MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");=20
> +MODULE_DESCRIPTION("Xilinx SPI driver"); MODULE_LICENSE("GPL");
> --
> 1.5.1.1
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
