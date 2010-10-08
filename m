Return-Path: <B21284@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F977B70CB
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 13:42:13 +1100 (EST)
Received: from mail51-db3 (localhost.localdomain [127.0.0.1])	by
	mail51-db3-R.bigfish.com (Postfix) with ESMTP id F096E15D8708	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 02:42:08 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.241])	by
	mail51-db3.bigfish.com (Postfix) with ESMTP id 73082758051	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 02:42:07 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o982g2ER015944	for <linuxppc-dev@ozlabs.org>;
	Thu, 7 Oct 2010 19:42:02 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o982g0Vb011008	for <linuxppc-dev@ozlabs.org>;
	Thu, 7 Oct 2010 21:42:01 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH v3 5/7] mtd: m25p80: add support to parse the SPI flash's
	partitions
Date: Fri, 8 Oct 2010 10:42:10 +0800
Message-ID: <73839B4A0818E747864426270AC332C3057F616A@zmy16exm20.fsl.freescale.net>
In-Reply-To: <AANLkTi=eBA+i7kCOrEPao1AXofKUjBQokWLXFpgx3WND@mail.gmail.com>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-4-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-5-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-6-git-send-email-Mingkai.hu@freescale.com>
	<AANLkTi=eBA+i7kCOrEPao1AXofKUjBQokWLXFpgx3WND@mail.gmail.com>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <B11780@freescale.com>,
	linux-mtd@lists.infradead.org, Zang Roy-R61911 <R61911@freescale.com>,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of =
Grant
> Likely
> Sent: Friday, October 01, 2010 5:35 AM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; spi-devel-general@lists.sourceforge.net; =
linux-
> mtd@lists.infradead.org; Gala Kumar-B11780; Zang Roy-R61911
> Subject: Re: [PATCH v3 5/7] mtd: m25p80: add support to parse the SPI =
flash's
> partitions
>=20
> On Thu, Sep 30, 2010 at 5:00 PM, Mingkai Hu <Mingkai.hu@freescale.com> =
wrote:
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > ---
> > v3:
> > =A0- Move the SPI flash partition code to the probe function.
> >
> > =A0drivers/mtd/devices/m25p80.c | =A0 39 =
+++++++++++++++++++++++++++------------
> > =A01 files changed, 27 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/mtd/devices/m25p80.c =
b/drivers/mtd/devices/m25p80.c
> > index 6f512b5..47d53c7 100644
> > --- a/drivers/mtd/devices/m25p80.c
> > +++ b/drivers/mtd/devices/m25p80.c
> > @@ -772,7 +772,7 @@ static const struct spi_device_id *__devinit
> jedec_probe(struct spi_device *spi)
> > =A0static int __devinit m25p_probe(struct spi_device *spi)
> > =A0{
> > =A0 =A0 =A0 =A0const struct spi_device_id =A0 =A0 =A0*id =3D =
spi_get_device_id(spi);
> > - =A0 =A0 =A0 struct flash_platform_data =A0 =A0 =A0*data;
> > + =A0 =A0 =A0 struct flash_platform_data =A0 =A0 =A0data, *pdata;
> > =A0 =A0 =A0 =A0struct m25p =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
*flash;
> > =A0 =A0 =A0 =A0struct flash_info =A0 =A0 =A0 =A0 =A0 =A0 =A0 *info;
> > =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0i;
> > @@ -782,13 +782,27 @@ static int __devinit m25p_probe(struct =
spi_device *spi)
> > =A0 =A0 =A0 =A0 * a chip ID, try the JEDEC id commands; they'll work =
for most
> > =A0 =A0 =A0 =A0 * newer chips, even if we don't recognize the =
particular chip.
> > =A0 =A0 =A0 =A0 */
> > - =A0 =A0 =A0 data =3D spi->dev.platform_data;
> > - =A0 =A0 =A0 if (data && data->type) {
> > + =A0 =A0 =A0 pdata =3D spi->dev.platform_data;
> > + =A0 =A0 =A0 if (!pdata && spi->dev.of_node) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int nr_parts;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mtd_partition *parts;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *np =3D =
spi->dev.of_node;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_parts =3D =
of_mtd_parse_partitions(&spi->dev, np, &parts);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nr_parts) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D &data;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(pdata, 0, =
sizeof(*pdata));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->parts =3D =
parts;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->nr_parts =3D =
nr_parts;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
>=20
> Yes, this is the correct way to go about adding the partitions.
> However, this patch can be made simpler by not renaming 'data' to
> 'pdata' and by moving the above code down to just before the partition
> information is actually used.  in the OF case, only the parts and the
> nr_parts values written into data, and those values aren't used until
> the last part of the probe function.
>=20
> Regardless, in principle this patch is correct:
>=20
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>=20
> > +
> > + =A0 =A0 =A0 if (pdata && pdata->type) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct spi_device_id *plat_id;
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < =
ARRAY_SIZE(m25p_ids) - 1; i++) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0plat_id =3D =
&m25p_ids[i];
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(data->type, =
plat_id->name))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =
(strcmp(pdata->type, plat_id->name))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0continue;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > @@ -796,7 +810,8 @@ static int __devinit m25p_probe(struct =
spi_device *spi)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i < ARRAY_SIZE(m25p_ids) - 1)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0id =3D plat_id;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&spi->dev, =
"unrecognized id %s\n", data-
> >type);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&spi->dev, =
"unrecognized id %s\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 pdata->type);
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0info =3D (void *)id->driver_data;
> > @@ -847,8 +862,8 @@ static int __devinit m25p_probe(struct =
spi_device *spi)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_sr(flash, 0);
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 if (data && data->name)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash->mtd.name =3D data->name;
> > + =A0 =A0 =A0 if (pdata && pdata->name)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash->mtd.name =3D pdata->name;
> > =A0 =A0 =A0 =A0else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flash->mtd.name =3D =
dev_name(&spi->dev);
> >
> > @@ -919,9 +934,9 @@ static int __devinit m25p_probe(struct =
spi_device *spi)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0part_probes, &parts, 0);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nr_parts <=3D 0 && data && =
data->parts) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parts =3D data->parts;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_parts =3D =
data->nr_parts;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nr_parts <=3D 0 && pdata && =
pdata->parts) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parts =3D =
pdata->parts;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_parts =3D =
pdata->nr_parts;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>=20
> As per my comment earlier; since parts and nr_parts isn't needed
> before this point, this block could simply be:
>=20
> if (nr_parts <=3D 0 && data && data->parts) {
>         parts =3D data->parts;
>         nr_parts =3D data->nr_parts;
> }
> if (nr_parts <=3D 0 && spi->dev.of_node)
>   =A0 =A0 =A0 nr_parts =3D of_mtd_parse_partitions(&spi->dev, np, =
&parts);
>=20
> And most of the other changes to this file goes away.  Simpler, yes?
>=20

Yes, you're right, I'll fix it. Also thanks for your suggestion and ACK.

Thanks,
Mingkai
