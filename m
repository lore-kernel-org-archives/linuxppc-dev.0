Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 7ADC4B7B91
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 02:00:17 +1100 (EST)
Received: by yxe8 with SMTP id 8so2195921yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 07:00:15 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AFC1B2D.2070809@mocean-labs.com>
References: <4AFC1B2D.2070809@mocean-labs.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 12 Nov 2009 07:59:52 -0700
Message-ID: <fa686aa40911120659p5a2fa642qc414f83471e8f463@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] xilinx_spi: Switch to iomem functions and support
	little endian.
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

On Thu, Nov 12, 2009 at 7:26 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> This patch changes the out_(be)(8|16|32) and in_(be)(8|16|32) calls to 32=
 bits ioread/iowrite.
>
> The read and write function are attached to the internal struct as callba=
cks, callback
> is selected depending on endianess.
>
> This will also build on platforms not supporting the in/out calls for ins=
tance x86.
>
> Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>

On brief review looks good to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index e60b264..9667650 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -236,7 +236,7 @@ config SPI_TXX9
>
> =A0config SPI_XILINX
> =A0 =A0 =A0 =A0tristate "Xilinx SPI controller"
> - =A0 =A0 =A0 depends on EXPERIMENTAL
> + =A0 =A0 =A0 depends on HAS_IOMEM && EXPERIMENTAL
> =A0 =A0 =A0 =A0select SPI_BITBANG
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This exposes the SPI controller IP from the Xilinx EDK=
.
> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index 5761a4c..d0ca13a 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -27,7 +27,7 @@
> =A0/* Register definitions as per "OPB Serial Peripheral Interface (SPI) =
(v1.00e)
> =A0* Product Specification", DS464
> =A0*/
> -#define XSPI_CR_OFFSET =A0 =A0 =A0 =A0 0x62 =A0 =A0/* 16-bit Control Reg=
ister */
> +#define XSPI_CR_OFFSET =A0 =A0 =A0 =A0 0x60 =A0 =A0/* 16-bit Control Reg=
ister */
>
> =A0#define XSPI_CR_ENABLE =A0 =A0 =A0 =A0 0x02
> =A0#define XSPI_CR_MASTER_MODE =A0 =A00x04
> @@ -39,7 +39,7 @@
> =A0#define XSPI_CR_MANUAL_SSELECT 0x80
> =A0#define XSPI_CR_TRANS_INHIBIT =A00x100
>
> -#define XSPI_SR_OFFSET =A0 =A0 =A0 =A0 0x67 =A0 =A0/* 8-bit Status Regis=
ter */
> +#define XSPI_SR_OFFSET =A0 =A0 =A0 =A0 0x64 =A0 =A0/* 8-bit Status Regis=
ter */
>
> =A0#define XSPI_SR_RX_EMPTY_MASK =A00x01 =A0 =A0/* Receive FIFO is empty =
*/
> =A0#define XSPI_SR_RX_FULL_MASK =A0 0x02 =A0 =A0/* Receive FIFO is full *=
/
> @@ -47,8 +47,8 @@
> =A0#define XSPI_SR_TX_FULL_MASK =A0 0x08 =A0 =A0/* Transmit FIFO is full =
*/
> =A0#define XSPI_SR_MODE_FAULT_MASK =A0 =A0 =A0 =A00x10 =A0 =A0/* Mode fau=
lt error */
>
> -#define XSPI_TXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6b =A0 =A0/* 8-=
bit Data Transmit Register */
> -#define XSPI_RXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6f =A0 =A0/* 8-=
bit Data Receive Register */
> +#define XSPI_TXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x68 =A0 =A0/* 8-=
bit Data Transmit Register */
> +#define XSPI_RXD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6c =A0 =A0/* 8-=
bit Data Receive Register */
>
> =A0#define XSPI_SSR_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x70 =A0 =A0/* =
32-bit Slave Select Register */
>
> @@ -86,25 +86,29 @@ struct xilinx_spi {
> =A0 =A0 =A0 =A0u8 *rx_ptr; =A0 =A0 =A0 =A0 =A0 =A0 /* pointer in the Tx b=
uffer */
> =A0 =A0 =A0 =A0const u8 *tx_ptr; =A0 =A0 =A0 /* pointer in the Rx buffer =
*/
> =A0 =A0 =A0 =A0int remaining_bytes; =A0 =A0/* the number of bytes left to=
 transfer */
> + =A0 =A0 =A0 unsigned int (*read_fn) (void __iomem *);
> + =A0 =A0 =A0 void (*write_fn) (u32, void __iomem *);
> =A0};
>
> -static void xspi_init_hw(void __iomem *regs_base)
> +static void xspi_init_hw(struct xilinx_spi *xspi)
> =A0{
> + =A0 =A0 =A0 void __iomem *regs_base =3D xspi->regs;
> +
> =A0 =A0 =A0 =A0/* Reset the SPI device */
> - =A0 =A0 =A0 out_be32(regs_base + XIPIF_V123B_RESETR_OFFSET,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0XIPIF_V123B_RESET_MASK);
> + =A0 =A0 =A0 xspi->write_fn(XIPIF_V123B_RESET_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regs_base + XIPIF_V123B_RESETR_OFFSET);
> =A0 =A0 =A0 =A0/* Disable all the interrupts just in case */
> - =A0 =A0 =A0 out_be32(regs_base + XIPIF_V123B_IIER_OFFSET, 0);
> + =A0 =A0 =A0 xspi->write_fn(0, regs_base + XIPIF_V123B_IIER_OFFSET);
> =A0 =A0 =A0 =A0/* Enable the global IPIF interrupt */
> - =A0 =A0 =A0 out_be32(regs_base + XIPIF_V123B_DGIER_OFFSET,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0XIPIF_V123B_GINTR_ENABLE);
> + =A0 =A0 =A0 xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regs_base + XIPIF_V123B_DGIER_OFFSET);
> =A0 =A0 =A0 =A0/* Deselect the slave on the SPI bus */
> - =A0 =A0 =A0 out_be32(regs_base + XSPI_SSR_OFFSET, 0xffff);
> + =A0 =A0 =A0 xspi->write_fn(0xffff, regs_base + XSPI_SSR_OFFSET);
> =A0 =A0 =A0 =A0/* Disable the transmitter, enable Manual Slave Select Ass=
ertion,
> =A0 =A0 =A0 =A0 * put SPI controller into master mode, and enable it */
> - =A0 =A0 =A0 out_be16(regs_base + XSPI_CR_OFFSET,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_S=
SELECT
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE);
> + =A0 =A0 =A0 xspi->write_fn(XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELE=
CT |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regs_base + XSPI_CR_OFFSET);
> =A0}
>
> =A0static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
> @@ -113,16 +117,16 @@ static void xilinx_spi_chipselect(struct spi_device=
 *spi, int is_on)
>
> =A0 =A0 =A0 =A0if (is_on =3D=3D BITBANG_CS_INACTIVE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Deselect the slave on the SPI bus */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(xspi->regs + XSPI_SSR_OFFSET, 0xff=
ff);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->write_fn(0xffff, xspi->regs + XSPI_SS=
R_OFFSET);
> =A0 =A0 =A0 =A0} else if (is_on =3D=3D BITBANG_CS_ACTIVE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Set the SPI clock phase and polarity */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 cr =3D in_be16(xspi->regs + XSPI_CR_OFF=
SET)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 cr =3D xspi->read_fn(xspi->regs + XSPI_=
CR_OFFSET)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & ~XSPI_CR_MODE_MASK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (spi->mode & SPI_CPHA)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cr |=3D XSPI_CR_CPHA;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (spi->mode & SPI_CPOL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cr |=3D XSPI_CR_CPOL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->write_fn(cr, xspi->regs + XSPI_CR_OFF=
SET);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* We do not check spi->max_speed_hz here =
as the SPI clock
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * frequency is not software programmable =
(the IP block design
> @@ -130,8 +134,8 @@ static void xilinx_spi_chipselect(struct spi_device *=
spi, int is_on)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Activate the chip select */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(xspi->regs + XSPI_SSR_OFFSET,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0~(0x0001 << spi->chip_se=
lect));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->write_fn(~(0x0001 << spi->chip_select=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->regs + XSPI_SSR_OFFSE=
T);
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -177,15 +181,15 @@ static void xilinx_spi_fill_tx_fifo(struct xilinx_s=
pi *xspi)
> =A0 =A0 =A0 =A0u8 sr;
>
> =A0 =A0 =A0 =A0/* Fill the Tx FIFO with as many bytes as possible */
> - =A0 =A0 =A0 sr =3D in_8(xspi->regs + XSPI_SR_OFFSET);
> + =A0 =A0 =A0 sr =3D xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
> =A0 =A0 =A0 =A0while ((sr & XSPI_SR_TX_FULL_MASK) =3D=3D 0 && xspi->remai=
ning_bytes > 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (xspi->tx_ptr) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(xspi->regs + XSPI_TXD=
_OFFSET, *xspi->tx_ptr++);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(xspi->regs + XSPI_TXD=
_OFFSET, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (xspi->tx_ptr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->write_fn(*xspi->tx_pt=
r++,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->regs =
+ XSPI_TXD_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->write_fn(0, xspi->reg=
s + XSPI_TXD_OFFSET);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xspi->remaining_bytes--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr =3D in_8(xspi->regs + XSPI_SR_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr =3D xspi->read_fn(xspi->regs + XSPI_SR_O=
FFSET);
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -207,18 +211,19 @@ static int xilinx_spi_txrx_bufs(struct spi_device *=
spi, struct spi_transfer *t)
> =A0 =A0 =A0 =A0/* Enable the transmit empty interrupt, which we use to de=
termine
> =A0 =A0 =A0 =A0 * progress on the transmission.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 ipif_ier =3D in_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET);
> - =A0 =A0 =A0 out_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ipif_ier | XSPI_INTR_TX_EMPTY);
> + =A0 =A0 =A0 ipif_ier =3D xspi->read_fn(xspi->regs + XIPIF_V123B_IIER_OF=
FSET);
> + =A0 =A0 =A0 xspi->write_fn(ipif_ier | XSPI_INTR_TX_EMPTY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->regs + XIPIF_V123B_IIER_OFFSET);
>
> =A0 =A0 =A0 =A0/* Start the transfer by not inhibiting the transmitter an=
y longer */
> - =A0 =A0 =A0 cr =3D in_be16(xspi->regs + XSPI_CR_OFFSET) & ~XSPI_CR_TRAN=
S_INHIBIT;
> - =A0 =A0 =A0 out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
> + =A0 =A0 =A0 cr =3D xspi->read_fn(xspi->regs + XSPI_CR_OFFSET) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~XSPI_CR_TRANS_INHIBIT;
> + =A0 =A0 =A0 xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
>
> =A0 =A0 =A0 =A0wait_for_completion(&xspi->done);
>
> =A0 =A0 =A0 =A0/* Disable the transmit empty interrupt */
> - =A0 =A0 =A0 out_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET, ipif_ier);
> + =A0 =A0 =A0 xspi->write_fn(ipif_ier, xspi->regs + XIPIF_V123B_IIER_OFFS=
ET);
>
> =A0 =A0 =A0 =A0return t->len - xspi->remaining_bytes;
> =A0}
> @@ -235,8 +240,8 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_=
id)
> =A0 =A0 =A0 =A0u32 ipif_isr;
>
> =A0 =A0 =A0 =A0/* Get the IPIF interrupts, and clear them immediately */
> - =A0 =A0 =A0 ipif_isr =3D in_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET);
> - =A0 =A0 =A0 out_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET, ipif_isr);
> + =A0 =A0 =A0 ipif_isr =3D xspi->read_fn(xspi->regs + XIPIF_V123B_IISR_OF=
FSET);
> + =A0 =A0 =A0 xspi->write_fn(ipif_isr, xspi->regs + XIPIF_V123B_IISR_OFFS=
ET);
>
> =A0 =A0 =A0 =A0if (ipif_isr & XSPI_INTR_TX_EMPTY) { =A0 =A0/* Transmissio=
n completed */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u16 cr;
> @@ -247,20 +252,20 @@ static irqreturn_t xilinx_spi_irq(int irq, void *de=
v_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * transmitter while the Isr refills the t=
ransmit register/FIFO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * or make sure it is stopped if we're don=
e.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cr =3D in_be16(xspi->regs + XSPI_CR_OFFSET)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be16(xspi->regs + XSPI_CR_OFFSET,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cr | XSPI_CR_TRANS_INHIB=
IT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cr =3D xspi->read_fn(xspi->regs + XSPI_CR_O=
FFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->regs + XSPI_CR_OFFSET=
);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Read out all the data from the Rx FIFO =
*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr =3D in_8(xspi->regs + XSPI_SR_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr =3D xspi->read_fn(xspi->regs + XSPI_SR_O=
FFSET);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while ((sr & XSPI_SR_RX_EMPTY_MASK) =3D=3D=
 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 data;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D in_8(xspi->regs + =
XSPI_RXD_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D xspi->read_fn(xspi=
->regs + XSPI_RXD_OFFSET);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (xspi->rx_ptr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*xspi->rx_=
ptr++ =3D data;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr =3D in_8(xspi->regs + XS=
PI_SR_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr =3D xspi->read_fn(xspi->=
regs + XSPI_SR_OFFSET);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* See if there is more data to send */
> @@ -269,7 +274,7 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_=
id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Start the transfer by n=
ot inhibiting the
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * transmitter any longer
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be16(xspi->regs + XSPI_=
CR_OFFSET, cr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->write_fn(cr, xspi->re=
gs + XSPI_CR_OFFSET);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* No more data to send.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Indicate the transfer i=
s completed.
> @@ -324,9 +329,16 @@ struct spi_master *xilinx_spi_init(struct device *de=
v, struct resource *mem,
>
> =A0 =A0 =A0 =A0xspi->mem =3D *mem;
> =A0 =A0 =A0 =A0xspi->irq =3D irq;
> + =A0 =A0 =A0 if (pdata->little_endian) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->read_fn =3D ioread32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->write_fn =3D iowrite32;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->read_fn =3D ioread32be;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xspi->write_fn =3D iowrite32be;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* SPI controller initializations */
> - =A0 =A0 =A0 xspi_init_hw(xspi->regs);
> + =A0 =A0 =A0 xspi_init_hw(xspi);
>
> =A0 =A0 =A0 =A0/* Register for SPI Interrupt */
> =A0 =A0 =A0 =A0ret =3D request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_S=
PI_NAME, xspi);
> diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_sp=
i.h
> index 06df0ab..a705ad8 100644
> --- a/include/linux/spi/xilinx_spi.h
> +++ b/include/linux/spi/xilinx_spi.h
> @@ -4,11 +4,13 @@
> =A0/**
> =A0* struct xspi_platform_data - Platform data of the Xilinx SPI driver
> =A0* @num_chipselect: =A0 =A0Number of chip select by the IP
> + * @little_endian =A0 =A0 =A0If registers should be accessed little endi=
an or not
> =A0* @devices: =A0 =A0 =A0 =A0 =A0 Devices to add when the driver is prob=
ed.
> =A0* @num_devices: =A0 =A0 =A0 Number of devices in the devices array.
> =A0*/
> =A0struct xspi_platform_data {
> =A0 =A0 =A0 =A0u16 num_chipselect;
> + =A0 =A0 =A0 bool little_endian;
> =A0 =A0 =A0 =A0struct spi_board_info *devices;
> =A0 =A0 =A0 =A0u8 num_devices;
> =A0};
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
