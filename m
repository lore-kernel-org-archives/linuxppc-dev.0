Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.15]) by ozlabs.org (Postfix) with ESMTP id 98A1EB7B7F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 01:29:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH v4] xilinx_spi: Splitted into generic,
	of and platform driver, added support for DS570
Date: Tue, 29 Sep 2009 09:14:24 -0600
In-Reply-To: <4AC1AA82.3040406@mocean-labs.com>
References: <4AC0C699.2070506@mocean-labs.com>
	<8741a4f8-b490-4754-a674-71ea2ee1385a@SG2EHSMHS011.ehs.local>
	<4AC1AA82.3040406@mocean-labs.com>
From: John Linn <John.Linn@xilinx.com>
To: =?iso-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Message-ID: <4cf6f2f7-fd9c-4993-b1a3-8dc286f6c43a@VA3EHSMHS023.ehs.local>
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
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
> Sent: Tuesday, September 29, 2009 12:35 AM
> To: John Linn
> Cc: spi-devel-general@lists.sourceforge.net; linuxppc-dev@ozlabs.org;
> dbrownell@users.sourceforge.net; Andrew Morton
> Subject: Re: [PATCH v4] xilinx_spi: Splitted into generic, of and platfor=
m driver, added support for
> DS570
> =

> On 9/28/09 5:41 PM, John Linn wrote:
> >> -----Original Message-----
> >> From: Richard R=F6jfors [mailto:richard.rojfors@mocean-labs.com]
> >> Sent: Monday, September 28, 2009 8:22 AM
> >> To: spi-devel-general@lists.sourceforge.net
> >> Cc: linuxppc-dev@ozlabs.org; dbrownell@users.sourceforge.net; Andrew M=
orton; John Linn
> >> Subject: [PATCH v4] xilinx_spi: Splitted into generic, of and platform=
 driver, added support for
> >> DS570
> >>
> >> This patch splits xilinx_spi into three parts, an OF and a platform
> >> driver and generic part.
> >>
> >> The generic part now also works on X86, it supports accessing the IP
> >> booth big and little endian. There is also support for 16 and 32 bit
> >> SPI for the Xilinx SPI IP DS570
> >>
> >> Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>
> >> ---
> >> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> >> index 2c733c2..ecabc12 100644
> >> --- a/drivers/spi/Kconfig
> >> +++ b/drivers/spi/Kconfig
> >> @@ -218,8 +218,8 @@ config SPI_TXX9
> >>  	  SPI driver for Toshiba TXx9 MIPS SoCs
> >>
> >
> > <snip>
> >
> >>
> >> -struct xilinx_spi {
> >> -	/* bitbang has to be first */
> >> -	struct spi_bitbang bitbang;
> >> -	struct completion done;
> >> +/* to follow are some functions that does little of big endian read a=
nd
> >> + * write depending on the config of the device.
> >> + */
> >> +static inline void xspi_write8(struct xilinx_spi *xspi, u32 offs, u8 =
val)
> >> +{
> >> +	iowrite8(val, xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
> >> +}
> >>
> >> -	void __iomem	*regs;	/* virt. address of the control registers */
> >> +static inline void xspi_write16(struct xilinx_spi *xspi, u32 offs, u1=
6 val)
> >> +{
> >> +	if (xspi->big_endian)
> >> +		iowrite16be(val, xspi->regs + offs + 2);
> >> +	else
> >> +		iowrite16(val, xspi->regs + offs);
> >> +}
> >
> >
> > Hi Richard,
> =

> Hi John,
> =

> Thanks for the quick feedback.

No problem. I thought at 1st that the point of the new code was performance=
, but it sounds like you're trying to make sure the driver will work with a=
 system that can be built in many different permutations.

> =

> > If you're worried about efficiency (the reason for 16 and 32 bit xfers)=
, why wouldn't you do the
> big-endian vs little endian I/O decision at compile time rather than run =
time?
> =

> I'm afraid we can't do it compile time, if we want to be flexible. As
> example;
> The IP is big endian, in our case the PCI interface flips the byte
> order. But the PCI interface might be setup differently ->would be
> accessed big endian even on a little endian machine.
> =


Ok I see the flexibility requirements.

> We could use callbacks set up during probe, instead of having the
> if-sentence. But I don't think the callback solution could be slower (if
> talking performance), since the compiler can't inline them, the current
> functions could be inlined if the compiler feels like it.
> =

> =

> > The big_endian variable is not a constant boolean, I don't know if that=
 could help so that the
> compiler optimizes this check away?  Or maybe it is already and I'm just =
missing that?
> >
> >>
> >> -	u32		irq;
> >> +static inline void xspi_write32(struct xilinx_spi *xspi, u32 offs, u3=
2 val)
> >> +{
> >> +	if (xspi->big_endian)
> >> +		iowrite32be(val, xspi->regs + offs);
> >> +	else
> >> +		iowrite32(val, xspi->regs + offs);
> >> +}
> >>
> >> -	u32		speed_hz; /* SCK has a fixed frequency of speed_hz Hz */
> >> +static inline u8 xspi_read8(struct xilinx_spi *xspi, u32 offs)
> >> +{
> >> +	return ioread8(xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
> >> +}
> >>
> >> -	u8 *rx_ptr;		/* pointer in the Tx buffer */
> >> -	const u8 *tx_ptr;	/* pointer in the Rx buffer */
> >> -	int remaining_bytes;	/* the number of bytes left to transfer */
> >> -};
> >
> > <snip>
> >
> >> -
> >>  /* This driver supports single master mode only. Hence Tx FIFO Empty
> >>   * is the only interrupt we care about.
> >>   * Receive FIFO Overrun, Transmit FIFO Underrun, Mode Fault, and Slav=
e Mode
> >> @@ -237,32 +298,50 @@ static irqreturn_t xilinx_spi_irq(int irq, void =
*dev_id)
> >>  	u32 ipif_isr;
> >>
> >>  	/* Get the IPIF interrupts, and clear them immediately */
> >> -	ipif_isr =3D in_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET);
> >> -	out_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET, ipif_isr);
> >> +	ipif_isr =3D xspi_read32(xspi, XIPIF_V123B_IISR_OFFSET);
> >> +	xspi_write32(xspi, XIPIF_V123B_IISR_OFFSET, ipif_isr);
> >>
> >>  	if (ipif_isr & XSPI_INTR_TX_EMPTY) {	/* Transmission completed */
> >>  		u16 cr;
> >>  		u8 sr;
> >> +		u8 rsize;
> >> +		if (xspi->bits_per_word =3D=3D 8)
> >> +			rsize =3D 1;
> >> +		else if (xspi->bits_per_word =3D=3D 16)
> >> +			rsize =3D 2;
> >> +		else
> >> +			rsize =3D 4;
> >>
> >>  		/* A transmit has just completed. Process received data and
> >>  		 * check for more data to transmit. Always inhibit the
> >>  		 * transmitter while the Isr refills the transmit register/FIFO,
> >>  		 * or make sure it is stopped if we're done.
> >>  		 */
> >> -		cr =3D in_be16(xspi->regs + XSPI_CR_OFFSET);
> >> -		out_be16(xspi->regs + XSPI_CR_OFFSET,
> >> -			 cr | XSPI_CR_TRANS_INHIBIT);
> >> +		cr =3D xspi_read16(xspi, XSPI_CR_OFFSET);
> >> +		xspi_write16(xspi, XSPI_CR_OFFSET, cr | XSPI_CR_TRANS_INHIBIT);
> >>
> >>  		/* Read out all the data from the Rx FIFO */
> >> -		sr =3D in_8(xspi->regs + XSPI_SR_OFFSET);
> >> +		sr =3D xspi_read8(xspi, XSPI_SR_OFFSET);
> >>  		while ((sr & XSPI_SR_RX_EMPTY_MASK) =3D=3D 0) {
> >> -			u8 data;
> >> +			u32 data;
> >> +			if (rsize =3D=3D 1)
> >> +				data =3D xspi_read8(xspi, XSPI_RXD_OFFSET);
> >> +			else if (rsize =3D=3D 2)
> >> +				data =3D xspi_read16(xspi, XSPI_RXD_OFFSET);
> >> +			else
> >> +				data =3D xspi_read32(xspi, XSPI_RXD_OFFSET);
> >>
> >> -			data =3D in_8(xspi->regs + XSPI_RXD_OFFSET);
> >>  			if (xspi->rx_ptr) {
> >> -				*xspi->rx_ptr++ =3D data;
> >> +				if (rsize =3D=3D 1)
> >> +					*xspi->rx_ptr =3D data & 0xff;
> >> +				else if (rsize =3D=3D 2)
> >> +					*(u16 *)(xspi->rx_ptr) =3D data & 0xffff;
> >> +				else
> >> +					*((u32 *)(xspi->rx_ptr)) =3D data;
> >> +				xspi->rx_ptr +=3D rsize;
> >
> > Maybe I'm out of line here...
> >
> > I'm wondering if this is going to be any more efficient that just using=
 8 bit accesses
> =

> We can not do 8 bit accesses if the IP is set up to do 16/32bit SPI,
> then the TX/RX registers are as wide as the bit setup.
> =

> We could do 32 bit reads from the registers, then we waste some cycles
> on the PLB bus, but have slightly simpler code.

Looking at the IP spec, it looks like 32 bit operations to registers should=
 work and that sounds like the right direction to go (32 bit only).

Doing 32 bit operations on the PLB, rather than 8 bit operations, won't was=
te any cycles on the bus as you're on the bus either way so it can't be use=
d by any other device, it's just how many byte lanes are being used on the =
bus.

> =

> > as it seems like the amount of run-time decisions being made is quite a=
 few.  I guess it depends on
> how many bytes are being transferred as with big transfers maybe it will =
pay off.
> >
> > In my opinion, which isn't worth much many times :), sometimes the flex=
ibility with soft logic,
> like this is a pain for testability and increases complexity. If there's =
reasonable performance gains
> then maybe it's a good tradeoff.
> >
> > Do you know how much performance gain there is or is expected as maybe =
you've seen the pay off
> already?
> =

> I haven't done any measurements, and we are basically only controlling
> GPIO so performance is not an issue for us. I just didn't want do make
> it slower. I think you have more experience here. Do you think it's
> better to just do 32bit reads to make the code simple? If so I will
> update the code.

Yes, 32 ops.

If you get a new driver that's ready, I can hopefully find some time to tes=
t it in our automated test with the SPI EEPROM.

> =

> Thanks
> --Richard


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
