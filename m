Return-Path: <B21284@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 42A09B6EEE
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 17:33:28 +1000 (EST)
Received: from mail36-tx2 (localhost.localdomain [127.0.0.1])	by
	mail36-tx2-R.bigfish.com (Postfix) with ESMTP id 33F6DD681EC	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:33:25 +0000 (UTC)
Received: from TX2EHSMHS017.bigfish.com (unknown [10.9.14.236])	by
	mail36-tx2.bigfish.com (Postfix) with ESMTP id 8BBDD1B5004E	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:33:23 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6Q7XLbL002361	for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Jul 2010 00:33:21 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6Q7iOGb029534	for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Jul 2010 02:44:24 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 4/6] mtd: m25p80: change the read function to read page by
	page
Date: Mon, 26 Jul 2010 15:33:19 +0800
Message-ID: <73839B4A0818E747864426270AC332C305400642@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20100726003028.GC25419@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-5-git-send-email-Mingkai.hu@freescale.com>
	<20100726003028.GC25419@angua.secretlab.ca>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Zang Roy-R61911 <R61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of=20
> Grant Likely
> Sent: Monday, July 26, 2010 8:30 AM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang=20
> Roy-R61911
> Subject: Re: [PATCH 4/6] mtd: m25p80: change the read=20
> function to read page by page
>=20
> On Tue, Jul 20, 2010 at 10:08:23AM +0800, Mingkai Hu wrote:
> > For Freescale's eSPI controller, the max transaction length=20
> one time=20
> > is limitted by the SPCOM[TRANSLEN] field which is 0x10000. When used
> > mkfs.ext2 command to create ext2 filesystem on the flash, the read=20
> > length will exceed the max value of the SPCOM[TRANSLEN] field, so=20
> > change the read function to read page by page.
> >=20
> > For other SPI flash driver, also needed to change the read=20
> function if=20
> > used the eSPI controller.
> >=20
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > ---
> >  drivers/mtd/devices/m25p80.c |   18 ++++++++++++++----
> >  1 files changed, 14 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/mtd/devices/m25p80.c=20
> > b/drivers/mtd/devices/m25p80.c index 81e49a9..6cbe6b1 100644
> > --- a/drivers/mtd/devices/m25p80.c
> > +++ b/drivers/mtd/devices/m25p80.c
> > @@ -317,6 +317,7 @@ static int m25p80_read(struct mtd_info=20
> *mtd, loff_t from, size_t len,
> >  	struct m25p *flash =3D mtd_to_m25p(mtd);
> >  	struct spi_transfer t[2];
> >  	struct spi_message m;
> > +	u32 i, page_size =3D 0;
> > =20
> >  	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
> >  			dev_name(&flash->spi->dev), __func__,=20
> "from", @@ -341,7 +342,6 @@=20
> > static int m25p80_read(struct mtd_info *mtd, loff_t from,=20
> size_t len,
> >  	spi_message_add_tail(&t[0], &m);
> > =20
> >  	t[1].rx_buf =3D buf;
> > -	t[1].len =3D len;
> >  	spi_message_add_tail(&t[1], &m);
> > =20
> >  	/* Byte count starts at zero. */
> > @@ -364,11 +364,21 @@ static int m25p80_read(struct mtd_info *mtd,=20
> > loff_t from, size_t len,
> > =20
> >  	/* Set up the write data buffer. */
> >  	flash->command[0] =3D OPCODE_READ;
> > -	m25p_addr2cmd(flash, from, flash->command);
> > =20
> > -	spi_sync(flash->spi, &m);
> > +	for (i =3D page_size; i < len; i +=3D page_size) {
> > +		page_size =3D len - i;
> > +		if (page_size > flash->page_size)
> > +			page_size =3D flash->page_size;
> > =20
> > -	*retlen =3D m.actual_length - m25p_cmdsz(flash) -=20
> FAST_READ_DUMMY_BYTE;
> > +		m25p_addr2cmd(flash, from + i, flash->command);
> > +		t[1].len =3D page_size;
> > +		t[1].rx_buf =3D buf + i;
> > +
> > +		spi_sync(flash->spi, &m);
> > +
> > +		*retlen +=3D m.actual_length - m25p_cmdsz(flash)
> > +			- FAST_READ_DUMMY_BYTE;
> > +	}
>=20
> This patch seems to cripple all users just because eSPI=20
> cannot handle it.  Am I reading it wrong?
>=20

You're right, this will cripple all users.

At first, I want to contain this specific code with CONFIG_SPI_FSL_ESPI
option,
or register a specific read function like:

#ifdef CONFIG_SPI_FSL_ESPI
        flash->mtd.read =3D m25p80_read_espi;
#endif

but this will make the code looks arguly, are there other ways?

Thanks,
Mingkai
