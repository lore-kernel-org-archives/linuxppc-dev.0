Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (sg2ehsobe005.messaging.microsoft.com
	[207.46.51.79]) by ozlabs.org (Postfix) with ESMTP id E41F5B7BBD
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Sep 2009 01:45:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH v4] xilinx_spi: Splitted into generic,
	of and platform driver, added support for DS570
Date: Mon, 28 Sep 2009 09:41:30 -0600
In-Reply-To: <4AC0C699.2070506@mocean-labs.com>
References: <4AC0C699.2070506@mocean-labs.com>
From: John Linn <John.Linn@xilinx.com>
To: =?iso-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>,
	<spi-devel-general@lists.sourceforge.net>
Message-ID: <8741a4f8-b490-4754-a674-71ea2ee1385a@SG2EHSMHS011.ehs.local>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Richard R=F6jfors [mailto:richard.rojfors@mocean-labs.com]
> Sent: Monday, September 28, 2009 8:22 AM
> To: spi-devel-general@lists.sourceforge.net
> Cc: linuxppc-dev@ozlabs.org; dbrownell@users.sourceforge.net; Andrew Mort=
on; John Linn
> Subject: [PATCH v4] xilinx_spi: Splitted into generic, of and platform dr=
iver, added support for
> DS570
> =

> This patch splits xilinx_spi into three parts, an OF and a platform
> driver and generic part.
> =

> The generic part now also works on X86, it supports accessing the IP
> booth big and little endian. There is also support for 16 and 32 bit
> SPI for the Xilinx SPI IP DS570
> =

> Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>
> ---
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 2c733c2..ecabc12 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -218,8 +218,8 @@ config SPI_TXX9
>  	  SPI driver for Toshiba TXx9 MIPS SoCs
> =


<snip>

> =

> -struct xilinx_spi {
> -	/* bitbang has to be first */
> -	struct spi_bitbang bitbang;
> -	struct completion done;
> +/* to follow are some functions that does little of big endian read and
> + * write depending on the config of the device.
> + */
> +static inline void xspi_write8(struct xilinx_spi *xspi, u32 offs, u8 val=
)
> +{
> +	iowrite8(val, xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
> +}
> =

> -	void __iomem	*regs;	/* virt. address of the control registers */
> +static inline void xspi_write16(struct xilinx_spi *xspi, u32 offs, u16 v=
al)
> +{
> +	if (xspi->big_endian)
> +		iowrite16be(val, xspi->regs + offs + 2);
> +	else
> +		iowrite16(val, xspi->regs + offs);
> +}


Hi Richard,

If you're worried about efficiency (the reason for 16 and 32 bit xfers), wh=
y wouldn't you do the big-endian vs little endian I/O decision at compile t=
ime rather than run time?

The big_endian variable is not a constant boolean, I don't know if that cou=
ld help so that the compiler optimizes this check away?  Or maybe it is alr=
eady and I'm just missing that?

> =

> -	u32		irq;
> +static inline void xspi_write32(struct xilinx_spi *xspi, u32 offs, u32 v=
al)
> +{
> +	if (xspi->big_endian)
> +		iowrite32be(val, xspi->regs + offs);
> +	else
> +		iowrite32(val, xspi->regs + offs);
> +}
> =

> -	u32		speed_hz; /* SCK has a fixed frequency of speed_hz Hz */
> +static inline u8 xspi_read8(struct xilinx_spi *xspi, u32 offs)
> +{
> +	return ioread8(xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
> +}
> =

> -	u8 *rx_ptr;		/* pointer in the Tx buffer */
> -	const u8 *tx_ptr;	/* pointer in the Rx buffer */
> -	int remaining_bytes;	/* the number of bytes left to transfer */
> -};

<snip>

> -
>  /* This driver supports single master mode only. Hence Tx FIFO Empty
>   * is the only interrupt we care about.
>   * Receive FIFO Overrun, Transmit FIFO Underrun, Mode Fault, and Slave M=
ode
> @@ -237,32 +298,50 @@ static irqreturn_t xilinx_spi_irq(int irq, void *de=
v_id)
>  	u32 ipif_isr;
> =

>  	/* Get the IPIF interrupts, and clear them immediately */
> -	ipif_isr =3D in_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET);
> -	out_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET, ipif_isr);
> +	ipif_isr =3D xspi_read32(xspi, XIPIF_V123B_IISR_OFFSET);
> +	xspi_write32(xspi, XIPIF_V123B_IISR_OFFSET, ipif_isr);
> =

>  	if (ipif_isr & XSPI_INTR_TX_EMPTY) {	/* Transmission completed */
>  		u16 cr;
>  		u8 sr;
> +		u8 rsize;
> +		if (xspi->bits_per_word =3D=3D 8)
> +			rsize =3D 1;
> +		else if (xspi->bits_per_word =3D=3D 16)
> +			rsize =3D 2;
> +		else
> +			rsize =3D 4;
> =

>  		/* A transmit has just completed. Process received data and
>  		 * check for more data to transmit. Always inhibit the
>  		 * transmitter while the Isr refills the transmit register/FIFO,
>  		 * or make sure it is stopped if we're done.
>  		 */
> -		cr =3D in_be16(xspi->regs + XSPI_CR_OFFSET);
> -		out_be16(xspi->regs + XSPI_CR_OFFSET,
> -			 cr | XSPI_CR_TRANS_INHIBIT);
> +		cr =3D xspi_read16(xspi, XSPI_CR_OFFSET);
> +		xspi_write16(xspi, XSPI_CR_OFFSET, cr | XSPI_CR_TRANS_INHIBIT);
> =

>  		/* Read out all the data from the Rx FIFO */
> -		sr =3D in_8(xspi->regs + XSPI_SR_OFFSET);
> +		sr =3D xspi_read8(xspi, XSPI_SR_OFFSET);
>  		while ((sr & XSPI_SR_RX_EMPTY_MASK) =3D=3D 0) {
> -			u8 data;
> +			u32 data;
> +			if (rsize =3D=3D 1)
> +				data =3D xspi_read8(xspi, XSPI_RXD_OFFSET);
> +			else if (rsize =3D=3D 2)
> +				data =3D xspi_read16(xspi, XSPI_RXD_OFFSET);
> +			else
> +				data =3D xspi_read32(xspi, XSPI_RXD_OFFSET);
> =

> -			data =3D in_8(xspi->regs + XSPI_RXD_OFFSET);
>  			if (xspi->rx_ptr) {
> -				*xspi->rx_ptr++ =3D data;
> +				if (rsize =3D=3D 1)
> +					*xspi->rx_ptr =3D data & 0xff;
> +				else if (rsize =3D=3D 2)
> +					*(u16 *)(xspi->rx_ptr) =3D data & 0xffff;
> +				else
> +					*((u32 *)(xspi->rx_ptr)) =3D data;
> +				xspi->rx_ptr +=3D rsize;

Maybe I'm out of line here...

I'm wondering if this is going to be any more efficient that just using 8 b=
it accesses as it seems like the amount of run-time decisions being made is=
 quite a few.  I guess it depends on how many bytes are being transferred a=
s with big transfers maybe it will pay off.

In my opinion, which isn't worth much many times :), sometimes the flexibil=
ity with soft logic, like this is a pain for testability and increases comp=
lexity. If there's reasonable performance gains then maybe it's a good trad=
eoff.  =


Do you know how much performance gain there is or is expected as maybe you'=
ve seen the pay off already?

Thanks,
John

>  			}
> -			sr =3D in_8(xspi->regs + XSPI_SR_OFFSET);
> +
> +			sr =3D xspi_read8(xspi, XSPI_SR_OFFSET);
>  		}
> =

>  		/* See if there is more data to send */
> @@ -271,7 +350,7 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_=
id)
>  			/* Start the transfer by not inhibiting the
>  			 * transmitter any longer
>  			 */
> -			out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
> +			xspi_write16(xspi, XSPI_CR_OFFSET, cr);
>  		} else {
>  			/* No more data to send.
>  			 * Indicate the transfer is completed.
> @@ -279,44 +358,21 @@ static irqreturn_t xilinx_spi_irq(int irq, void *de=
v_id)
>  			complete(&xspi->done);
>  		}
>  	}
> -
>  	return IRQ_HANDLED;
>  }
> =


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
