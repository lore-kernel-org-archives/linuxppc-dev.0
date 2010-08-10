Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id 0709FB70E7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 16:56:32 +1000 (EST)
Received: by gxk25 with SMTP id 25so6484445gxk.15
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Aug 2010 23:56:30 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 10 Aug 2010 00:56:10 -0600
Message-ID: <AANLkTik9cy+at2n28U+Mut4RD6_cJ9uRZzjf+H86d-rp@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] mtd: m25p80: add support to parse the SPI flash's
	partitions
To: Mingkai Hu <Mingkai.hu@freescale.com>
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

On Mon, Aug 2, 2010 at 1:52 AM, Mingkai Hu <Mingkai.hu@freescale.com> wrote=
:
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> ---
>
> v2:
> =A0- Move the flash partition function from of_spi.c to MTD driver
>
> =A0drivers/mtd/devices/m25p80.c | =A0 29 +++++++++++++++++++++++++++++
> =A01 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 81e49a9..5f00075 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -752,6 +752,31 @@ static const struct spi_device_id *__devinit jedec_p=
robe(struct spi_device *spi)
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> +/*
> + * parse_flash_partition - Parse the flash partition on the SPI bus
> + * @spi: Pointer to spi_device device
> + */
> +void parse_flash_partition(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct mtd_partition *parts;
> + =A0 =A0 =A0 struct flash_platform_data *pdata;
> + =A0 =A0 =A0 int nr_parts =3D 0;
> + =A0 =A0 =A0 struct device_node *np =3D spi->dev.of_node;
> +
> + =A0 =A0 =A0 nr_parts =3D of_mtd_parse_partitions(&spi->dev, np, &parts)=
;
> + =A0 =A0 =A0 if (!nr_parts)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> + =A0 =A0 =A0 if (!pdata)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 pdata->parts =3D parts;
> + =A0 =A0 =A0 pdata->nr_parts =3D nr_parts;
> + =A0 =A0 =A0 spi->dev.platform_data =3D pdata;

The driver is not allowed to write to the platform_data pointer in the
device structure because it leaves an absolute mess in trying to
figure out who owns the pdata pointer.  Should it be freed when the
driver is unbound?  Is it statically allocated? etc.  There is a safer
way to get the data (see below).

> +
> + =A0 =A0 =A0 return;
> +}
>
> =A0/*
> =A0* board specific setup should have ensured the SPI clock used here
> @@ -771,6 +796,10 @@ static int __devinit m25p_probe(struct spi_device *s=
pi)
> =A0 =A0 =A0 =A0 * a chip ID, try the JEDEC id commands; they'll work for =
most
> =A0 =A0 =A0 =A0 * newer chips, even if we don't recognize the particular =
chip.
> =A0 =A0 =A0 =A0 */
> +
> + =A0 =A0 =A0 /* Parse the flash partition */
> + =A0 =A0 =A0 parse_flash_partition(spi);
> +

Doing this unconditionally is dangerous, and if a platform_data
structure is provided, then it must alwasy take precedence over the
device tree data (because the platform code has gone to extra lengths
to add a pdata structure; that must mean it is important!)  :-)

Instead what can be done is to call of_mtd_parse_partitions() directly
from the probe routine after checking to see if the pdata structure
exists and has partition information.  If it doesn't, then call
of_mtd_parse_partitions() to get values for parts and nr_parts.  Doing
it that way completely eliminates the uncertainty over pdata pointer
ownership, and eliminates having an anonymous pointer buried in the
driver.

Cheers,
g.
