Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id F1C82B70ED
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 17:00:40 +1000 (EST)
Received: by gwj15 with SMTP id 15so6428909gwj.15
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 00:00:39 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1280735524-17547-5-git-send-email-Mingkai.hu@freescale.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-5-git-send-email-Mingkai.hu@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 10 Aug 2010 01:00:19 -0600
Message-ID: <AANLkTikM5je7Ckt=7bP6fj7OKCaroSn_AqgcS4T+Bv5d@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mtd: m25p80: add a read function to read page by
	page
To: Mingkai Hu <Mingkai.hu@freescale.com>,
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[adding David Woodhouse]

(Btw, you should cc: David Woodhouse and the mtd list on the MTD patches).

On Mon, Aug 2, 2010 at 1:52 AM, Mingkai Hu <Mingkai.hu@freescale.com> wrote=
:
> For Freescale's eSPI controller, the max transaction length one time
> is limitted by the SPCOM[TRANSLEN] field which is 0xFFFF. When used
> mkfs.ext2 command to create ext2 filesystem on the flash, the read
> length will exceed the max value of the SPCOM[TRANSLEN] field, so
> change the read function to read page by page.
>
> For other SPI flash driver, also needed to supply the read function
> if used the eSPI controller.
>
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>

This one bothers me, but I can't put my finger on it.  The flag feels
like a controller specific hack.  David, can you take a look at this
patch?

g.

> ---
>
> v2:
> =A0- Add SPI_MASTER_TRANS_LIMIT flag to indicate the master's trans lengt=
h
> =A0 limitation, so the MTD driver can select the correct transfer behavio=
ur
> =A0 at driver probe time
>
> =A0drivers/mtd/devices/m25p80.c | =A0 78 ++++++++++++++++++++++++++++++++=
++++++++++
> =A0drivers/spi/spi_fsl_espi.c =A0 | =A0 =A01 +
> =A0include/linux/spi/spi.h =A0 =A0 =A0| =A0 =A01 +
> =A03 files changed, 80 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 5f00075..30e4568 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -376,6 +376,81 @@ static int m25p80_read(struct mtd_info *mtd, loff_t =
from, size_t len,
> =A0}
>
> =A0/*
> + * Read an address range from the flash chip page by page.
> + * Some controller has transaction length limitation such as the
> + * Freescale's eSPI controller can only trasmit 0xFFFF bytes one
> + * time, so we have to read page by page if the len is more than
> + * the limitation.
> + */
> +static int m25p80_page_read(struct mtd_info *mtd, loff_t from, size_t le=
n,
> + =A0 =A0 =A0 size_t *retlen, u_char *buf)
> +{
> + =A0 =A0 =A0 struct m25p *flash =3D mtd_to_m25p(mtd);
> + =A0 =A0 =A0 struct spi_transfer t[2];
> + =A0 =A0 =A0 struct spi_message m;
> + =A0 =A0 =A0 u32 i, page_size =3D 0;
> +
> + =A0 =A0 =A0 DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(&flash->spi->dev),=
 __func__, "from",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (u32)from, len);
> +
> + =A0 =A0 =A0 /* sanity checks */
> + =A0 =A0 =A0 if (!len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (from + len > flash->mtd.size)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 spi_message_init(&m);
> + =A0 =A0 =A0 memset(t, 0, (sizeof t));
> +
> + =A0 =A0 =A0 /* NOTE:
> + =A0 =A0 =A0 =A0* OPCODE_FAST_READ (if available) is faster.
> + =A0 =A0 =A0 =A0* Should add 1 byte DUMMY_BYTE.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 t[0].tx_buf =3D flash->command;
> + =A0 =A0 =A0 t[0].len =3D m25p_cmdsz(flash) + FAST_READ_DUMMY_BYTE;
> + =A0 =A0 =A0 spi_message_add_tail(&t[0], &m);
> +
> + =A0 =A0 =A0 t[1].rx_buf =3D buf;
> + =A0 =A0 =A0 spi_message_add_tail(&t[1], &m);
> +
> + =A0 =A0 =A0 /* Byte count starts at zero. */
> + =A0 =A0 =A0 if (retlen)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *retlen =3D 0;
> +
> + =A0 =A0 =A0 mutex_lock(&flash->lock);
> +
> + =A0 =A0 =A0 /* Wait till previous write/erase is done. */
> + =A0 =A0 =A0 if (wait_till_ready(flash)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* REVISIT status return?? */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&flash->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set up the write data buffer. */
> + =A0 =A0 =A0 flash->command[0] =3D OPCODE_READ;
> +
> + =A0 =A0 =A0 for (i =3D page_size; i < len; i +=3D page_size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 page_size =3D len - i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (page_size > flash->page_size)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 page_size =3D flash->page_s=
ize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 m25p_addr2cmd(flash, from + i, flash->comma=
nd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t[1].len =3D page_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t[1].rx_buf =3D buf + i;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_sync(flash->spi, &m);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *retlen +=3D m.actual_length - m25p_cmdsz(f=
lash)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 - FAST_READ_DUMMY_BYTE;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_unlock(&flash->lock);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> =A0* Write an address range to the flash chip. =A0Data must be written in
> =A0* FLASH_PAGESIZE chunks. =A0The address range may be any size provided
> =A0* it is within the physical boundaries.
> @@ -877,6 +952,9 @@ static int __devinit m25p_probe(struct spi_device *sp=
i)
> =A0 =A0 =A0 =A0flash->mtd.erase =3D m25p80_erase;
> =A0 =A0 =A0 =A0flash->mtd.read =3D m25p80_read;
>
> + =A0 =A0 =A0 if (spi->master->flags & SPI_MASTER_TRANS_LIMIT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash->mtd.read =3D m25p80_page_read;
> +
> =A0 =A0 =A0 =A0/* sst flash chips use AAI word program */
> =A0 =A0 =A0 =A0if (info->jedec_id >> 16 =3D=3D 0xbf)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flash->mtd.write =3D sst_write;
> diff --git a/drivers/spi/spi_fsl_espi.c b/drivers/spi/spi_fsl_espi.c
> index 61987cf..e15b7dc 100644
> --- a/drivers/spi/spi_fsl_espi.c
> +++ b/drivers/spi/spi_fsl_espi.c
> @@ -470,6 +470,7 @@ static struct spi_master * __devinit fsl_espi_probe(s=
truct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_probe;
>
> =A0 =A0 =A0 =A0master->setup =3D fsl_espi_setup;
> + =A0 =A0 =A0 master->flags =3D SPI_MASTER_TRANS_LIMIT;
>
> =A0 =A0 =A0 =A0mpc8xxx_spi =3D spi_master_get_devdata(master);
> =A0 =A0 =A0 =A0mpc8xxx_spi->spi_do_one_msg =3D fsl_espi_do_one_msg;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index af56071..0729cbd 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -261,6 +261,7 @@ struct spi_master {
> =A0#define SPI_MASTER_HALF_DUPLEX BIT(0) =A0 =A0 =A0 =A0 =A0/* can't do f=
ull duplex */
> =A0#define SPI_MASTER_NO_RX =A0 =A0 =A0 BIT(1) =A0 =A0 =A0 =A0 =A0/* can'=
t do buffer read */
> =A0#define SPI_MASTER_NO_TX =A0 =A0 =A0 BIT(2) =A0 =A0 =A0 =A0 =A0/* can'=
t do buffer write */
> +#define SPI_MASTER_TRANS_LIMIT BIT(3) =A0 =A0 =A0 =A0 =A0/* have trans l=
ength limit */
>
> =A0 =A0 =A0 =A0/* Setup mode and clock, etc (spi driver may call many tim=
es).
> =A0 =A0 =A0 =A0 *
> --
> 1.6.4
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
