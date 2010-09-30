Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 6BEEDB70A6
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Oct 2010 07:35:13 +1000 (EST)
Received: by iwn37 with SMTP id 37so3359308iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 14:35:12 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1285833646-12006-6-git-send-email-Mingkai.hu@freescale.com>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-4-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-5-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-6-git-send-email-Mingkai.hu@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 1 Oct 2010 06:34:51 +0900
Message-ID: <AANLkTi=eBA+i7kCOrEPao1AXofKUjBQokWLXFpgx3WND@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] mtd: m25p80: add support to parse the SPI flash's
	partitions
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

On Thu, Sep 30, 2010 at 5:00 PM, Mingkai Hu <Mingkai.hu@freescale.com> wrot=
e:
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> ---
> v3:
> =A0- Move the SPI flash partition code to the probe function.
>
> =A0drivers/mtd/devices/m25p80.c | =A0 39 +++++++++++++++++++++++++++-----=
-------
> =A01 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 6f512b5..47d53c7 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -772,7 +772,7 @@ static const struct spi_device_id *__devinit jedec_pr=
obe(struct spi_device *spi)
> =A0static int __devinit m25p_probe(struct spi_device *spi)
> =A0{
> =A0 =A0 =A0 =A0const struct spi_device_id =A0 =A0 =A0*id =3D spi_get_devi=
ce_id(spi);
> - =A0 =A0 =A0 struct flash_platform_data =A0 =A0 =A0*data;
> + =A0 =A0 =A0 struct flash_platform_data =A0 =A0 =A0data, *pdata;
> =A0 =A0 =A0 =A0struct m25p =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *flash=
;
> =A0 =A0 =A0 =A0struct flash_info =A0 =A0 =A0 =A0 =A0 =A0 =A0 *info;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i;
> @@ -782,13 +782,27 @@ static int __devinit m25p_probe(struct spi_device *=
spi)
> =A0 =A0 =A0 =A0 * a chip ID, try the JEDEC id commands; they'll work for =
most
> =A0 =A0 =A0 =A0 * newer chips, even if we don't recognize the particular =
chip.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 data =3D spi->dev.platform_data;
> - =A0 =A0 =A0 if (data && data->type) {
> + =A0 =A0 =A0 pdata =3D spi->dev.platform_data;
> + =A0 =A0 =A0 if (!pdata && spi->dev.of_node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int nr_parts;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mtd_partition *parts;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *np =3D spi->dev.of_node=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_parts =3D of_mtd_parse_partitions(&spi->=
dev, np, &parts);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nr_parts) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D &data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(pdata, 0, sizeof(*pd=
ata));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->parts =3D parts;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->nr_parts =3D nr_part=
s;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }

Yes, this is the correct way to go about adding the partitions.
However, this patch can be made simpler by not renaming 'data' to
'pdata' and by moving the above code down to just before the partition
information is actually used.  in the OF case, only the parts and the
nr_parts values written into data, and those values aren't used until
the last part of the probe function.

Regardless, in principle this patch is correct:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> +
> + =A0 =A0 =A0 if (pdata && pdata->type) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct spi_device_id *plat_id;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < ARRAY_SIZE(m25p_ids) - 1=
; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0plat_id =3D &m25p_ids[i];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(data->type, plat=
_id->name))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(pdata->type, pla=
t_id->name))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -796,7 +810,8 @@ static int __devinit m25p_probe(struct spi_device *sp=
i)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i < ARRAY_SIZE(m25p_ids) - 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0id =3D plat_id;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&spi->dev, "unreco=
gnized id %s\n", data->type);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&spi->dev, "unreco=
gnized id %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pdata->type);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0info =3D (void *)id->driver_data;
> @@ -847,8 +862,8 @@ static int __devinit m25p_probe(struct spi_device *sp=
i)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_sr(flash, 0);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (data && data->name)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash->mtd.name =3D data->name;
> + =A0 =A0 =A0 if (pdata && pdata->name)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash->mtd.name =3D pdata->name;
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flash->mtd.name =3D dev_name(&spi->dev);
>
> @@ -919,9 +934,9 @@ static int __devinit m25p_probe(struct spi_device *sp=
i)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0part_probes, &parts, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nr_parts <=3D 0 && data && data->parts)=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parts =3D data->parts;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_parts =3D data->nr_parts=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nr_parts <=3D 0 && pdata && pdata->part=
s) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parts =3D pdata->parts;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_parts =3D pdata->nr_part=
s;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}

As per my comment earlier; since parts and nr_parts isn't needed
before this point, this block could simply be:

if (nr_parts <=3D 0 && data && data->parts) {
        parts =3D data->parts;
        nr_parts =3D data->nr_parts;
}
if (nr_parts <=3D 0 && spi->dev.of_node)
  =A0 =A0 =A0 nr_parts =3D of_mtd_parse_partitions(&spi->dev, np, &parts);

And most of the other changes to this file goes away.  Simpler, yes?

g.
