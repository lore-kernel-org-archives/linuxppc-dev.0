Return-Path: <david-b@pacbell.net>
Received: from smtp102.sbc.mail.mud.yahoo.com (smtp102.sbc.mail.mud.yahoo.com
	[68.142.198.201]) by ozlabs.org (Postfix) with SMTP id D542BDDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 15:09:14 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: [spi-devel-general] [PATCH] Simple driver for Xilinx SPI
	controler.
Date: Wed, 6 Jun 2007 22:09:09 -0700
References: <4666BF47.8080103@ru.mvista.com>
In-Reply-To: <4666BF47.8080103@ru.mvista.com>
MIME-Version: 1.0
Message-Id: <200706062209.09731.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 06 June 2007, Andrei Konovalov wrote:
> 
> Would be nice to get this driver into mainline.
> Reviews and comments are welcome.

I'll ignore the Kconfig flamage ... ;)


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
> + * 2002-2007 (c) MontaVista Software, Inc.  This file is licensed under the
> + * terms of the GNU General Public License version 2.  This program is licensed
> + * "as is" without any warranty of any kind, whether express or implied.
> + */
> +
> +
> +/* Simple macros to get the code more readable */
> +#define xspi_in16(addr)		in_be16((u16 __iomem *)(addr))
> +#define xspi_in32(addr)		in_be32((u32 __iomem *)(addr))
> +#define xspi_out16(addr, value)	out_be16((u16 __iomem *)(addr), (value))
> +#define xspi_out32(addr, value)	out_be32((u32 __iomem *)(addr), (value))

I'm rather used to seeing I/O addressses passed around as "void __iomem *"
so those sorts of cast are not needed...  :)


> +
> +static void xspi_abort_transfer(u8 __iomem *regs_base)
> +{

You should not need an abort primitive.  This is called only
in the remove-controller path.  By the time it's called,
every child spi_device on this bus segment should have been
removed ... which means any spi_driver attached to that
device has already returned from its remove() method, which
in turn means that there will be no spi_message objects in
flight from any of those drivers.


> +static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
> +{
> +	struct xilinx_spi *xspi;
> +	u8 __iomem *regs_base;
> +
> +	xspi = spi_master_get_devdata(spi->master);
> +	regs_base = xspi->regs;
> +
> +	if (is_on == BITBANG_CS_INACTIVE) {
> +		/* Deselect the slave on the SPI bus */
> +		xspi_out32(regs_base + XSPI_SSR_OFFSET, 0xffff);

I take it you can't support SPI_CS_HIGH??


> +/* spi_bitbang requires custom setup_transfer() to be defined if there is a
> + * custom txrx_bufs(). We have nothing to setup here as the SPI IP block
> + * supports just 8 bits per word, and SPI clock can't be changed in software.
> + * Check for 8 bits per word; speed_hz checking could be added if the SPI
> + * clock information is available. Chip select delay calculations could be
> + * added here as soon as bitbang_work() can be made aware of the delay value.
> + */
> +static int xilinx_spi_setup_transfer(struct spi_device *spi,
> +				     struct spi_transfer *t)
> +{
> +	u8 bits_per_word;
> +
> +	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
> +	if (bits_per_word != 8)
> +		return -EINVAL;

Speed checking *SHOULD* be added; the clock info can be platform data.

It would make trouble if a driver needed to turn the clock down to,
say, 400 KHz for some operation, and the controller said "yes" but
kept it at 25 MHz or whatever.  It's OK if the driver is told that
400 KHz can't happen though -- it's possible to recover from that.

(Although in practice it's best to have the transfer method do
the error checking, so that messages that will fail do so before
they are allowed to enter the I/O queue.)

ISTR you may need to delegate to the default method here too, but
it's been a while since I poked at that level and the issue might
not apply to this particular driver config.



> +
> +	return 0;
> +}
> +
> +
> +static int xilinx_spi_setup(struct spi_device *spi)
> +{
> +	struct spi_bitbang *bitbang;
> +	struct xilinx_spi *xspi;
> +	int retval;
> +
> +	xspi = spi_master_get_devdata(spi->master);
> +	bitbang = &xspi->bitbang;

You need to verify ALL the input parameters.  In particular,
mask spi->mode against all the values this driver recognizes
and supports.  If you don't support SPI_LSB_FIRST it's a bug
if setup() succeeds after setting that.  Same thing with all
other bits defined today (SPI_3WIRE, SPI_CS_HIGH) and in the
future... 

For an example, see the atmel_spi.c driver and MODEBITS.
There's a patch in MM that makes all the SPI controller
drivers have analagous tests ... and for bitbang there's
a patch adding spi_bitbang.mode flags to declare any
extra spi->mode flags that should be accepted.


> +	...
> +	
> +static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
> +{
> +	struct xilinx_spi *xspi;
> +	u8 __iomem *regs_base;
> +	u32 ipif_isr;
> +
> +	xspi = (struct xilinx_spi *) dev_id;
> +	regs_base = xspi->regs;
> +
> +     	/* Get the IPIF inetrrupts, and clear them immediately */

Spell checkers will tell you this is "interrupts" ... ;)


> +	ipif_isr = xspi_in32(regs_base + XIPIF_V123B_IISR_OFFSET);
> +	xspi_out32(regs_base + XIPIF_V123B_IISR_OFFSET, ipif_isr);
> +
> +	if (ipif_isr & XSPI_INTR_TX_EMPTY) {	/* Transmission completed */
> +		u16 cr;
> +		u8 sr;
> +
> +		/* A transmit has just completed. Process received data and
> +		 * check for more data to transmit. Always inhibit the
> +		 * transmitter while the Isr refills the transmit register/FIFO,
> +		 * or make sure it is stopped if we're done.
> +	         */
> +		cr = xspi_in16(regs_base + XSPI_CR_OFFSET);
> +		xspi_out16(regs_base + XSPI_CR_OFFSET,
> +			   cr | XSPI_CR_TRANS_INHIBIT);
> +
> +		/* Read out all the data from the Rx FIFO */
> +		sr = in_8(regs_base + XSPI_SR_OFFSET);
> +		while ((sr & XSPI_SR_RX_EMPTY_MASK) == 0) {
> +			u8 data;
> +
> +			data = in_8(regs_base + XSPI_RXD_OFFSET);
> +			if (xspi->rx_ptr) {
> +				*xspi->rx_ptr++ = data;
> +			}
> +			sr = in_8(regs_base + XSPI_SR_OFFSET);
> +		}
> +
> +	        /* See if there is more data to send */
> +		if (xspi->remaining_bytes > 0) {
> +			/* sr content is valid here; no need for io_8() */
> +			while ((sr & XSPI_SR_TX_FULL_MASK) == 0
> +				&& xspi->remaining_bytes > 0) {
> +				if (xspi->tx_ptr) {
> +					out_8(regs_base + XSPI_TXD_OFFSET,
> +					      *xspi->tx_ptr++);
> +				} else {
> +					out_8(regs_base + XSPI_TXD_OFFSET, 0);
> +				}

This duplicates the loop in txrx_bufs(); that's bad style.
Have one routine holding the shared code.


> +static int __init xilinx_spi_probe(struct platform_device *dev)
> +{
> +	int ret = 0;
> +	struct spi_master *master;
> +	struct xilinx_spi *xspi;
> +	struct xspi_platform_data *pdata;
> +	struct resource *r;
> +
> +	/* Get resources(memory, IRQ) associated with the device */
> +	master = spi_alloc_master(&dev->dev, sizeof(struct xilinx_spi));
> +
> +	if (master == NULL) {
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(dev, master);
> +	pdata = dev->dev.platform_data;
> +
> +	if (pdata == NULL) {
> +		ret = -ENODEV;
> +		goto put_master;
> +	}
> +
> +	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (r == NULL) {
> +		ret = -ENODEV;
> +		goto put_master;
> +	}
> +
> +	xspi = spi_master_get_devdata(master);
> +	xspi->bitbang.master = spi_master_get(master);
> +	xspi->bitbang.chipselect = xilinx_spi_chipselect;
> +	xspi->bitbang.setup_transfer = xilinx_spi_setup_transfer;
> +	xspi->bitbang.txrx_bufs = xilinx_spi_txrx_bufs;
> +	xspi->bitbang.master->setup = xilinx_spi_setup;
> +	init_completion(&xspi->done);
> +
> +	xspi->regs = ioremap(r->start, r->end - r->start + 1);

Strictly speaking a request_region() should precede the ioremap,
but a lot of folk don't bother.  However, lacking that I'd put
the request_irq() earlier, since that will be the only resource
providing any guard against another driver sharing the hardware.
