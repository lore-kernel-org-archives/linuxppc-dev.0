Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 567CAB7B66
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 08:16:00 +1100 (EST)
Received: by yxe8 with SMTP id 8so1504011yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 13:15:59 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AFACCAC.10304@mocean-labs.com>
References: <4AFACCAC.10304@mocean-labs.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 Nov 2009 14:15:39 -0700
Message-ID: <fa686aa40911111315lef743d8q6f158370b73ecd8f@mail.gmail.com>
Subject: Re: [PATCH 3/4] xilinx_spi: add support for the DS570 IP.
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

On Wed, Nov 11, 2009 at 7:39 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> This patch adds in support for the DS570 IP.
>
> It's register compatible with the DS464, but adds support for 8/16/32 SPI=
.
>
> Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>

Needs some changes.  Comments below....

> ---
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 9667650..b956284 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -235,7 +235,7 @@ config SPI_TXX9
> =A0 =A0 =A0 =A0 =A0SPI driver for Toshiba TXx9 MIPS SoCs
>
> =A0config SPI_XILINX
> - =A0 =A0 =A0 tristate "Xilinx SPI controller"
> + =A0 =A0 =A0 tristate "Xilinx SPI controller common module"
> =A0 =A0 =A0 =A0depends on HAS_IOMEM && EXPERIMENTAL
> =A0 =A0 =A0 =A0select SPI_BITBANG
> =A0 =A0 =A0 =A0help
> @@ -244,6 +244,8 @@ config SPI_XILINX
> =A0 =A0 =A0 =A0 =A0See the "OPB Serial Peripheral Interface (SPI) (v1.00e=
)"
> =A0 =A0 =A0 =A0 =A0Product Specification document (DS464) for hardware de=
tails.
>
> + =A0 =A0 =A0 =A0 Or for the DS570, see "XPS Serial Peripheral Interface =
(SPI) (v2.00b)"
> +
> =A0config SPI_XILINX_OF
> =A0 =A0 =A0 =A0tristate "Xilinx SPI controller OF device"
> =A0 =A0 =A0 =A0depends on SPI_XILINX && (XILINX_VIRTEX || MICROBLAZE)
> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index b00dabc..ae744ba 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -24,7 +24,7 @@
> =A0/* Register definitions as per "OPB Serial Peripheral Interface (SPI) =
(v1.00e)
> =A0* Product Specification", DS464
> =A0*/
> -#define XSPI_CR_OFFSET =A0 =A0 =A0 =A0 0x60 =A0 =A0/* 16-bit Control Reg=
ister */
> +#define XSPI_CR_OFFSET =A0 =A0 =A0 =A0 0x60 =A0 =A0/* Control Register *=
/
>
> =A0#define XSPI_CR_ENABLE =A0 =A0 =A0 =A0 0x02
> =A0#define XSPI_CR_MASTER_MODE =A0 =A00x04
> @@ -35,8 +35,9 @@
> =A0#define XSPI_CR_RXFIFO_RESET =A0 0x40
> =A0#define XSPI_CR_MANUAL_SSELECT 0x80
> =A0#define XSPI_CR_TRANS_INHIBIT =A00x100
> +#define XSPI_CR_LSB_FIRST =A0 =A0 =A00x200
>
> -#define XSPI_SR_OFFSET =A0 =A0 =A0 =A0 0x64 =A0 =A0/* 8-bit Status Regis=
ter */
> +#define XSPI_SR_OFFSET =A0 =A0 =A0 =A0 0x64 =A0 =A0/* Status Register */
>
> =A0#define XSPI_SR_RX_EMPTY_MASK =A00x01 =A0 =A0/* Receive FIFO is empty =
*/
> =A0#define XSPI_SR_RX_FULL_MASK =A0 0x02 =A0 =A0/* Receive FIFO is full *=
/
> @@ -44,8 +45,8 @@
> =A0#define XSPI_SR_TX_FULL_MASK =A0 0x08 =A0 =A0/* Transmit FIFO is full =
*/
> =A0#define XSPI_SR_MODE_FAULT_MASK =A0 =A0 =A0 =A00x10 =A0 =A0/* Mode fau=
lt error */
>
> -#define XSPI_TXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x68 =A0 =A0/* 8-=
bit Data Transmit Register */
> -#define XSPI_RXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6c =A0 =A0/* 8-=
bit Data Receive Register */
> +#define XSPI_TXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x68 =A0 =A0/* Da=
ta Transmit Register */
> +#define XSPI_RXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6c =A0 =A0/* Da=
ta Receive Register */
>
> =A0#define XSPI_SSR_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x70 =A0 =A0/* =
32-bit Slave Select Register */
>
> @@ -65,6 +66,7 @@
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
> @@ -86,6 +88,7 @@ struct xilinx_spi {
> =A0 =A0 =A0 =A0bool big_endian; =A0 =A0 =A0 =A0/* The device could be acc=
essed big or little
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * endian
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 u8 bits_per_word;
> =A0};
>
> =A0/* to follow are some functions that does little of big endian read an=
d
> @@ -146,8 +149,9 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
> =A0 =A0 =A0 =A0/* Disable the transmitter, enable Manual Slave Select Ass=
ertion,
> =A0 =A0 =A0 =A0 * put SPI controller into master mode, and enable it */
> =A0 =A0 =A0 =A0xspi_write16(xspi, XSPI_CR_OFFSET,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_S=
SELECT
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSEL=
ECT |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE | XSPI=
_CR_TXFIFO_RESET |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XSPI_CR_RXFIFO_RESET);
> =A0}
>
> =A0static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
> @@ -179,17 +183,20 @@ static void xilinx_spi_chipselect(struct spi_device=
 *spi, int is_on)
>
> =A0/* spi_bitbang requires custom setup_transfer() to be defined if there=
 is a
> =A0* custom txrx_bufs(). We have nothing to setup here as the SPI IP bloc=
k
> - * supports just 8 bits per word, and SPI clock can't be changed in soft=
ware.
> - * Check for 8 bits per word. Chip select delay calculations could be
> + * supports 8 or 16 bits per word, which can not be changed in software.
> + * SPI clock can't be changed in software.
> + * Check for correct bits per word. Chip select delay calculations could=
 be
> =A0* added here as soon as bitbang_work() can be made aware of the delay =
value.
> =A0*/
> =A0static int xilinx_spi_setup_transfer(struct spi_device *spi,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_transfer *t)
> + =A0 =A0 =A0 struct spi_transfer *t)
> =A0{
> =A0 =A0 =A0 =A0u8 bits_per_word;
> + =A0 =A0 =A0 struct xilinx_spi *xspi =3D spi_master_get_devdata(spi->mas=
ter);
>
> - =A0 =A0 =A0 bits_per_word =3D (t) ? t->bits_per_word : spi->bits_per_wo=
rd;
> - =A0 =A0 =A0 if (bits_per_word !=3D 8) {
> + =A0 =A0 =A0 bits_per_word =3D (t->bits_per_word) ? t->bits_per_word :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->bits_per_word;
> + =A0 =A0 =A0 if (bits_per_word !=3D xspi->bits_per_word) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&spi->dev, "%s, unsupported bits_p=
er_word=3D%d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, bits_per_word);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -200,33 +207,49 @@ static int xilinx_spi_setup_transfer(struct spi_dev=
ice *spi,
>
> =A0static int xilinx_spi_setup(struct spi_device *spi)
> =A0{
> - =A0 =A0 =A0 struct spi_bitbang *bitbang;
> - =A0 =A0 =A0 struct xilinx_spi *xspi;
> - =A0 =A0 =A0 int retval;
> -
> - =A0 =A0 =A0 xspi =3D spi_master_get_devdata(spi->master);
> - =A0 =A0 =A0 bitbang =3D &xspi->bitbang;
> -
> - =A0 =A0 =A0 retval =3D xilinx_spi_setup_transfer(spi, NULL);
> - =A0 =A0 =A0 if (retval < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> -
> + =A0 =A0 =A0 /* always return 0, we can not check the number of bits.
> + =A0 =A0 =A0 =A0* There are cases when SPI setup is called before any dr=
iver is
> + =A0 =A0 =A0 =A0* there, in that case the SPI core defaults to 8 bits, w=
hich we
> + =A0 =A0 =A0 =A0* do not support in some cases. But if we return an erro=
r, the
> + =A0 =A0 =A0 =A0* SPI device would not be registered and no driver can g=
et hold of it
> + =A0 =A0 =A0 =A0* When the driver is there, it will call SPI setup again=
 with the
> + =A0 =A0 =A0 =A0* correct number of bits per transfer.
> + =A0 =A0 =A0 =A0* If a driver setups with the wrong bit number, it will =
fail when
> + =A0 =A0 =A0 =A0* it tries to do a transfer
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi)
> =A0{
> =A0 =A0 =A0 =A0u8 sr;
> + =A0 =A0 =A0 u8 wsize;
> + =A0 =A0 =A0 if (xspi->bits_per_word =3D=3D 8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wsize =3D 1;
> + =A0 =A0 =A0 else if (xspi->bits_per_word =3D=3D 16)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wsize =3D 2;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wsize =3D 4;

wsize =3D xspi->bits_per_word / 8 perhaps?

>
> =A0 =A0 =A0 =A0/* Fill the Tx FIFO with as many bytes as possible */
> =A0 =A0 =A0 =A0sr =3D xspi_read8(xspi, XSPI_SR_OFFSET);
> - =A0 =A0 =A0 while ((sr & XSPI_SR_TX_FULL_MASK) =3D=3D 0 && xspi->remain=
ing_bytes > 0) {
> + =A0 =A0 =A0 while ((sr & XSPI_SR_TX_FULL_MASK) =3D=3D 0 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->remaining_bytes > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (xspi->tx_ptr) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi_write8(xspi, XSPI_TXD_=
OFFSET, *xspi->tx_ptr++);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wsize =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi_write8=
(xspi, XSPI_TXD_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 *xspi->tx_ptr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (wsize =3D=3D 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi_write1=
6(xspi, XSPI_TXD_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 *(u16 *)(xspi->tx_ptr));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (wsize =3D=3D 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi_write3=
2(xspi, XSPI_TXD_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 *(u32 *)(xspi->tx_ptr));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->tx_ptr +=3D wsize;

This would go better as a callback instead of performing the same test
*every time* through the loop.  Make for simpler code too.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xspi_write8(xspi, XSPI_TXD=
_OFFSET, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->remaining_bytes--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->remaining_bytes -=3D wsize;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sr =3D xspi_read8(xspi, XSPI_SR_OFFSET);
> =A0 =A0 =A0 =A0}
> =A0}
> @@ -283,6 +306,13 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev=
_id)
> =A0 =A0 =A0 =A0if (ipif_isr & XSPI_INTR_TX_EMPTY) { =A0 =A0/* Transmissio=
n completed */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u16 cr;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 sr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 rsize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (xspi->bits_per_word =3D=3D 8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rsize =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (xspi->bits_per_word =3D=3D 16)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rsize =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rsize =3D 4;

Ditto.

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* A transmit has just completed. Process =
received data and
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * check for more data to transmit. Always=
 inhibit the
> @@ -295,11 +325,22 @@ static irqreturn_t xilinx_spi_irq(int irq, void *de=
v_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Read out all the data from the Rx FIFO =
*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sr =3D xspi_read8(xspi, XSPI_SR_OFFSET);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while ((sr & XSPI_SR_RX_EMPTY_MASK) =3D=3D=
 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rsize =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D xs=
pi_read8(xspi, XSPI_RXD_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (rsize =3D=3D 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D xs=
pi_read16(xspi, XSPI_RXD_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D xs=
pi_read32(xspi, XSPI_RXD_OFFSET);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D xspi_read8(xspi, X=
SPI_RXD_OFFSET);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (xspi->rx_ptr) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *xspi->rx_p=
tr++ =3D data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rsize =
=3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 *xspi->rx_ptr =3D data & 0xff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (rs=
ize =3D=3D 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 *(u16 *)(xspi->rx_ptr) =3D data & 0xffff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 *((u32 *)(xspi->rx_ptr)) =3D data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->rx_pt=
r +=3D rsize;

ditto

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sr =3D xspi_read8(xspi, XS=
PI_SR_OFFSET);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -323,7 +364,8 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_=
id)
> =A0}
>
> =A0struct spi_master *xilinx_spi_init(struct device *dev, struct resource=
 *mem,
> - =A0 =A0 =A0 u32 irq, s16 bus_num, u16 num_chipselect, bool big_endian)
> + =A0 =A0 =A0 u32 irq, s16 bus_num, u16 num_chipselect, bool big_endian,
> + =A0 =A0 =A0 u8 bits_per_word)

As mentioned in my comments in patch 1/4; the increase to the
parameters to _init() would not be needed if the of_driver stowed
everything into a pdata structure.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
