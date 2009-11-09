Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id 52CA7B7B69
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 11:38:03 +1100 (EST)
Received: by iwn12 with SMTP id 12so2708027iwn.15
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Nov 2009 16:38:02 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AC0C699.2070506@mocean-labs.com>
References: <4AC0C699.2070506@mocean-labs.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 9 Nov 2009 14:21:42 -0700
Message-ID: <fa686aa40911091321w187fe85fl4e6d9f36f5966f34@mail.gmail.com>
Subject: Re: [spi-devel-general] [PATCH v4] xilinx_spi: Splitted into generic,
	of and platform driver, added support for DS570
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, dbrownell@users.sourceforge.net,
	John Linn <John.Linn@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oops, I replied to the original version, but missed the subsequent
versions.  Looks like some of my comments still apply though.
Overall, the patch changes too many things all at once.  You should
look at splitting it up.  At the very least the io accessor changes
should be done in a separate patch.

On Mon, Sep 28, 2009 at 7:22 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> @@ -227,6 +227,21 @@ config SPI_XILINX
> =A0 =A0 =A0 =A0 =A0See the "OPB Serial Peripheral Interface (SPI) (v1.00e=
)"
> =A0 =A0 =A0 =A0 =A0Product Specification document (DS464) for hardware de=
tails.
>
> + =A0 =A0 =A0 =A0 Or for the DS570, see "XPS Serial Peripheral Interface =
(SPI) (v2.00b)"
> +
> +config SPI_XILINX_OF
> + =A0 =A0 =A0 tristate "Xilinx SPI controller OF device"
> + =A0 =A0 =A0 depends on SPI_XILINX && XILINX_VIRTEX
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This is the OF driver for the SPI controller IP from th=
e Xilinx EDK.
> +
> +config SPI_XILINX_PLTFM
> + =A0 =A0 =A0 tristate "Xilinx SPI controller platform device"
> + =A0 =A0 =A0 depends on SPI_XILINX
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This is the platform driver for the SPI controller IP
> + =A0 =A0 =A0 =A0 from the Xilinx EDK.
> +

Personally, I don't think it is necessary to present these options to
the user.  I think they can be auto-selected depending on CONFIG_OF
and CONFIG_PLATFORM.

> +struct xilinx_spi {
> + =A0 =A0 =A0 /* bitbang has to be first */
> + =A0 =A0 =A0 struct spi_bitbang bitbang;
> + =A0 =A0 =A0 struct completion done;
> + =A0 =A0 =A0 struct resource mem; /* phys mem */
> + =A0 =A0 =A0 void __iomem =A0 =A0*regs; =A0/* virt. address of the contr=
ol registers */
> + =A0 =A0 =A0 u32 irq;
> + =A0 =A0 =A0 u8 *rx_ptr; =A0 =A0 =A0 =A0 =A0 =A0 /* pointer in the Tx bu=
ffer */
> + =A0 =A0 =A0 const u8 *tx_ptr; =A0 =A0 =A0 /* pointer in the Rx buffer *=
/
> + =A0 =A0 =A0 int remaining_bytes; =A0 =A0/* the number of bytes left to =
transfer */
> + =A0 =A0 =A0 /* offset to the XSPI regs, these might vary... */
> + =A0 =A0 =A0 u8 bits_per_word;
> + =A0 =A0 =A0 bool big_endian; =A0 =A0 =A0 =A0/* The device could be acce=
ssed big or little
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* endian
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +};
> +

Why is the definition of xilinx_spi moved?

> =A0/* Register definitions as per "OPB Serial Peripheral Interface (SPI) =
(v1.00e)
> =A0* Product Specification", DS464
> =A0*/
> -#define XSPI_CR_OFFSET =A0 =A0 =A0 =A0 0x62 =A0 =A0/* 16-bit Control Reg=
ister */
> +#define XSPI_CR_OFFSET =A0 =A0 =A0 =A0 0x60 =A0 =A0/* Control Register *=
/
>
> =A0#define XSPI_CR_ENABLE =A0 =A0 =A0 =A0 0x02
> =A0#define XSPI_CR_MASTER_MODE =A0 =A00x04
> @@ -40,8 +53,9 @@
> =A0#define XSPI_CR_RXFIFO_RESET =A0 0x40
> =A0#define XSPI_CR_MANUAL_SSELECT 0x80
> =A0#define XSPI_CR_TRANS_INHIBIT =A00x100
> +#define XSPI_CR_LSB_FIRST =A0 =A0 =A00x200
>
> -#define XSPI_SR_OFFSET =A0 =A0 =A0 =A0 0x67 =A0 =A0/* 8-bit Status Regis=
ter */
> +#define XSPI_SR_OFFSET =A0 =A0 =A0 =A0 0x64 =A0 =A0/* Status Register */
>
> =A0#define XSPI_SR_RX_EMPTY_MASK =A00x01 =A0 =A0/* Receive FIFO is empty =
*/
> =A0#define XSPI_SR_RX_FULL_MASK =A0 0x02 =A0 =A0/* Receive FIFO is full *=
/
> @@ -49,8 +63,8 @@
> =A0#define XSPI_SR_TX_FULL_MASK =A0 0x08 =A0 =A0/* Transmit FIFO is full =
*/
> =A0#define XSPI_SR_MODE_FAULT_MASK =A0 =A0 =A0 =A00x10 =A0 =A0/* Mode fau=
lt error */
>
> -#define XSPI_TXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6b =A0 =A0/* 8-=
bit Data Transmit Register */
> -#define XSPI_RXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6f =A0 =A0/* 8-=
bit Data Receive Register */
> +#define XSPI_TXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x68 =A0 =A0/* Da=
ta Transmit Register */
> +#define XSPI_RXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6C =A0 =A0/* Da=
ta Receive Register */
>
> =A0#define XSPI_SSR_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x70 =A0 =A0/* =
32-bit Slave Select Register */
>
> @@ -70,43 +84,72 @@
> =A0#define XSPI_INTR_TX_UNDERRUN =A0 =A0 =A0 =A0 =A00x08 =A0 =A0/* TxFIFO=
 was underrun */
> =A0#define XSPI_INTR_RX_FULL =A0 =A0 =A0 =A0 =A0 =A0 =A00x10 =A0 =A0/* Rx=
FIFO is full */
> =A0#define XSPI_INTR_RX_OVERRUN =A0 =A0 =A0 =A0 =A0 0x20 =A0 =A0/* RxFIFO=
 was overrun */
> +#define XSPI_INTR_TX_HALF_EMPTY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x40 =A0 =
=A0/* TxFIFO is half empty */
>
> =A0#define XIPIF_V123B_RESETR_OFFSET =A0 =A0 =A00x40 =A0 =A0/* IPIF reset=
 register */
> =A0#define XIPIF_V123B_RESET_MASK =A0 =A0 =A0 =A0 0x0a =A0 =A0/* the valu=
e to write */
>
> -struct xilinx_spi {
> - =A0 =A0 =A0 /* bitbang has to be first */
> - =A0 =A0 =A0 struct spi_bitbang bitbang;
> - =A0 =A0 =A0 struct completion done;
> +/* to follow are some functions that does little of big endian read and
> + * write depending on the config of the device.
> + */
> +static inline void xspi_write8(struct xilinx_spi *xspi, u32 offs, u8 val=
)
> +{
> + =A0 =A0 =A0 iowrite8(val, xspi->regs + offs + ((xspi->big_endian) ? 3 :=
 0));
> +}
>
> - =A0 =A0 =A0 void __iomem =A0 =A0*regs; =A0/* virt. address of the contr=
ol registers */
> +static inline void xspi_write16(struct xilinx_spi *xspi, u32 offs, u16 v=
al)
> +{
> + =A0 =A0 =A0 if (xspi->big_endian)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite16be(val, xspi->regs + offs + 2);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite16(val, xspi->regs + offs);
> +}
>
> - =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> +static inline void xspi_write32(struct xilinx_spi *xspi, u32 offs, u32 v=
al)
> +{
> + =A0 =A0 =A0 if (xspi->big_endian)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32be(val, xspi->regs + offs);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(val, xspi->regs + offs);
> +}
>
> - =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 speed_hz; /* SCK has a fixed fr=
equency of speed_hz Hz */
> +static inline u8 xspi_read8(struct xilinx_spi *xspi, u32 offs)
> +{
> + =A0 =A0 =A0 return ioread8(xspi->regs + offs + ((xspi->big_endian) ? 3 =
: 0));
> +}
>
> - =A0 =A0 =A0 u8 *rx_ptr; =A0 =A0 =A0 =A0 =A0 =A0 /* pointer in the Tx bu=
ffer */
> - =A0 =A0 =A0 const u8 *tx_ptr; =A0 =A0 =A0 /* pointer in the Rx buffer *=
/
> - =A0 =A0 =A0 int remaining_bytes; =A0 =A0/* the number of bytes left to =
transfer */
> -};
> +static inline u16 xspi_read16(struct xilinx_spi *xspi, u32 offs)
> +{
> + =A0 =A0 =A0 if (xspi->big_endian)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ioread16be(xspi->regs + offs + 2);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ioread16(xspi->regs + offs);
> +}
> +
> +static inline u32 xspi_read32(struct xilinx_spi *xspi, u32 offs)
> +{
> + =A0 =A0 =A0 if (xspi->big_endian)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ioread32be(xspi->regs + offs);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ioread32(xspi->regs + offs);
> +}

Ah, you changed these to functions instead of macros.  I like.
However, as you suggested elsewhere in this thread, you could change
these to callbacks and then eliminate the if/else statements.  I think
that is the approach you should use.  I don't think you need to worry
about it being slower.  Any extra cycles for jumping to a callback
will be far dwarfed by the number of cycles it takes to complete an
SPI transfer.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
