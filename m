Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) by ozlabs.org (Postfix) with ESMTP id 1EFBAB70B5
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 17:55:29 +1000 (EST)
Received: by ywi6 with SMTP id 6so492160ywi.15
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 00:55:28 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <73839B4A0818E747864426270AC332C305400642@zmy16exm20.fsl.freescale.net>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-5-git-send-email-Mingkai.hu@freescale.com>
	<20100726003028.GC25419@angua.secretlab.ca>
	<73839B4A0818E747864426270AC332C305400642@zmy16exm20.fsl.freescale.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 01:55:08 -0600
Message-ID: <AANLkTi=ehyX-u=5OwpY1AxMjDCc2LZaAfdSdLtuO3hYM@mail.gmail.com>
Subject: Re: [PATCH 4/6] mtd: m25p80: change the read function to read page by
	page
To: Hu Mingkai-B21284 <B21284@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Zang Roy-R61911 <R61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 26, 2010 at 1:33 AM, Hu Mingkai-B21284 <B21284@freescale.com> w=
rote:
>
>
>> -----Original Message-----
>> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of
>> Grant Likely
>> Sent: Monday, July 26, 2010 8:30 AM
>> To: Hu Mingkai-B21284
>> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang
>> Roy-R61911
>> Subject: Re: [PATCH 4/6] mtd: m25p80: change the read
>> function to read page by page
>>
>> On Tue, Jul 20, 2010 at 10:08:23AM +0800, Mingkai Hu wrote:
>> > For Freescale's eSPI controller, the max transaction length
>> one time
>> > is limitted by the SPCOM[TRANSLEN] field which is 0x10000. When used
>> > mkfs.ext2 command to create ext2 filesystem on the flash, the read
>> > length will exceed the max value of the SPCOM[TRANSLEN] field, so
>> > change the read function to read page by page.
>> >
>> > For other SPI flash driver, also needed to change the read
>> function if
>> > used the eSPI controller.
>> >
>> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
>> > ---
>> > =A0drivers/mtd/devices/m25p80.c | =A0 18 ++++++++++++++----
>> > =A01 files changed, 14 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/mtd/devices/m25p80.c
>> > b/drivers/mtd/devices/m25p80.c index 81e49a9..6cbe6b1 100644
>> > --- a/drivers/mtd/devices/m25p80.c
>> > +++ b/drivers/mtd/devices/m25p80.c
>> > @@ -317,6 +317,7 @@ static int m25p80_read(struct mtd_info
>> *mtd, loff_t from, size_t len,
>> > =A0 =A0 struct m25p *flash =3D mtd_to_m25p(mtd);
>> > =A0 =A0 struct spi_transfer t[2];
>> > =A0 =A0 struct spi_message m;
>> > + =A0 u32 i, page_size =3D 0;
>> >
>> > =A0 =A0 DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(&flash->spi->dev), __=
func__,
>> "from", @@ -341,7 +342,6 @@
>> > static int m25p80_read(struct mtd_info *mtd, loff_t from,
>> size_t len,
>> > =A0 =A0 spi_message_add_tail(&t[0], &m);
>> >
>> > =A0 =A0 t[1].rx_buf =3D buf;
>> > - =A0 t[1].len =3D len;
>> > =A0 =A0 spi_message_add_tail(&t[1], &m);
>> >
>> > =A0 =A0 /* Byte count starts at zero. */
>> > @@ -364,11 +364,21 @@ static int m25p80_read(struct mtd_info *mtd,
>> > loff_t from, size_t len,
>> >
>> > =A0 =A0 /* Set up the write data buffer. */
>> > =A0 =A0 flash->command[0] =3D OPCODE_READ;
>> > - =A0 m25p_addr2cmd(flash, from, flash->command);
>> >
>> > - =A0 spi_sync(flash->spi, &m);
>> > + =A0 for (i =3D page_size; i < len; i +=3D page_size) {
>> > + =A0 =A0 =A0 =A0 =A0 page_size =3D len - i;
>> > + =A0 =A0 =A0 =A0 =A0 if (page_size > flash->page_size)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 page_size =3D flash->page_size;
>> >
>> > - =A0 *retlen =3D m.actual_length - m25p_cmdsz(flash) -
>> FAST_READ_DUMMY_BYTE;
>> > + =A0 =A0 =A0 =A0 =A0 m25p_addr2cmd(flash, from + i, flash->command);
>> > + =A0 =A0 =A0 =A0 =A0 t[1].len =3D page_size;
>> > + =A0 =A0 =A0 =A0 =A0 t[1].rx_buf =3D buf + i;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 spi_sync(flash->spi, &m);
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 *retlen +=3D m.actual_length - m25p_cmdsz(flash)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 - FAST_READ_DUMMY_BYTE;
>> > + =A0 }
>>
>> This patch seems to cripple all users just because eSPI
>> cannot handle it. =A0Am I reading it wrong?
>>
>
> You're right, this will cripple all users.
>
> At first, I want to contain this specific code with CONFIG_SPI_FSL_ESPI
> option,
> or register a specific read function like:
>
> #ifdef CONFIG_SPI_FSL_ESPI
> =A0 =A0 =A0 =A0flash->mtd.read =3D m25p80_read_espi;
> #endif
>
> but this will make the code looks arguly,

And it is multiplatform-unfriendly.

> are there other ways?

You need to select the correct transfer behaviour at driver probe
time.  You'll need a way to indicate that the spi_master isn't able to
handle your transfer request.  I'd need to think about it more to come
up with a concrete suggestion.

g.
