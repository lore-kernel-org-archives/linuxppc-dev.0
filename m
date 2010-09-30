Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 8276CB70CE
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Oct 2010 07:41:36 +1000 (EST)
Received: by iwn37 with SMTP id 37so3366450iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 14:41:36 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1285833646-12006-7-git-send-email-Mingkai.hu@freescale.com>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-4-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-5-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-6-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-7-git-send-email-Mingkai.hu@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 1 Oct 2010 06:41:15 +0900
Message-ID: <AANLkTi=XNRotizwq1hiUstnXUgJ8HFJ43+VSOvDpa4PK@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by
	page
To: Mingkai Hu <Mingkai.hu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hmmm.... for some reason the previous replies didn't get picked up by
patchwork, so I'm replying with my comment again for the public
record.

In this case the eSPI controller driver is buggy and needs to be
fixed.  If the hardware can only support small transfers, then it is
the responsibilty of the driver to chain up smaller chunks into one
big transfer, and make sure that the CS line doesn't go low in the
middle of it.

g.

On Thu, Sep 30, 2010 at 5:00 PM, Mingkai Hu <Mingkai.hu@freescale.com> wrot=
e:
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
> ---
> v3:
> =A0- Add a quirks member for the SPI master to handle the contrains of th=
e
> =A0 SPI controller. I can't think of other method. :-(
>
> =A0drivers/mtd/devices/m25p80.c | =A0 78 ++++++++++++++++++++++++++++++++=
++++++++++
> =A0drivers/spi/spi_fsl_lib.c =A0 =A0| =A0 =A04 ++
> =A0include/linux/spi/spi.h =A0 =A0 =A0| =A0 =A05 +++
> =A03 files changed, 87 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 47d53c7..f65cca8 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -377,6 +377,81 @@ static int m25p80_read(struct mtd_info *mtd, loff_t =
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
> @@ -874,6 +949,9 @@ static int __devinit m25p_probe(struct spi_device *sp=
i)
> =A0 =A0 =A0 =A0flash->mtd.erase =3D m25p80_erase;
> =A0 =A0 =A0 =A0flash->mtd.read =3D m25p80_read;
>
> + =A0 =A0 =A0 if (spi->master->quirks & SPI_QUIRK_TRANS_LEN_LIMIT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash->mtd.read =3D m25p80_page_read;
> +
> =A0 =A0 =A0 =A0/* sst flash chips use AAI word program */
> =A0 =A0 =A0 =A0if (info->jedec_id >> 16 =3D=3D 0xbf)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flash->mtd.write =3D sst_write;
> diff --git a/drivers/spi/spi_fsl_lib.c b/drivers/spi/spi_fsl_lib.c
> index 5cd741f..c8d8c2d 100644
> --- a/drivers/spi/spi_fsl_lib.c
> +++ b/drivers/spi/spi_fsl_lib.c
> @@ -135,6 +135,10 @@ int mpc8xxx_spi_probe(struct device *dev, struct res=
ource *mem,
> =A0 =A0 =A0 =A0master->cleanup =3D mpc8xxx_spi_cleanup;
> =A0 =A0 =A0 =A0master->dev.of_node =3D dev->of_node;
>
> + =A0 =A0 =A0 if (of_get_property(dev->of_node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fsl,spi-qu=
irk-trans-len-limit", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 master->quirks |=3D SPI_QUIRK_TRANS_LEN_LIM=
IT;
> +
> =A0 =A0 =A0 =A0mpc8xxx_spi =3D spi_master_get_devdata(master);
> =A0 =A0 =A0 =A0mpc8xxx_spi->dev =3D dev;
> =A0 =A0 =A0 =A0mpc8xxx_spi->get_rx =3D mpc8xxx_spi_rx_buf_u8;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 92e52a1..4234dfd 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -304,6 +304,11 @@ struct spi_master {
>
> =A0 =A0 =A0 =A0/* called on release() to free memory provided by spi_mast=
er */
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*cleanup)(str=
uct spi_device *spi);
> +
> + =A0 =A0 =A0 /* some constraints of the controller */
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 quirks;
> +#define SPI_QUIRK_TRANS_LEN_LIMIT =A0 =A0 =A0BIT(0) =A0/* have trans len=
gth limit */
> +
> =A0};
>
> =A0static inline void *spi_master_get_devdata(struct spi_master *master)
> --
> 1.6.4
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
