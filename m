Return-Path: <Barry.Song@analog.com>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by ozlabs.org (Postfix) with ESMTP id 82154B7D5C
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jun 2010 12:52:37 +1000 (EST)
From: "Song, Barry" <Barry.Song@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [Uclinux-dist-devel] [PATCH 1/2] mtd: m25p80: Reworkprobing/JEDEC
	code
Date: Mon, 21 Jun 2010 10:42:21 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA065551D8@chinexm1.ad.analog.com>
In-Reply-To: <20100618133212.GA5276@oksana.dev.rtsoft.ru>
References: <20090818214449.GA12848@oksana.dev.rtsoft.ru><20090818214622.GA22651@oksana.dev.rtsoft.ru><AANLkTikg60s6ZRSEDCq9PQK1z7hJtBDk6t4VE1lYDv8u@mail.gmail.com>
	<20100618133212.GA5276@oksana.dev.rtsoft.ru>
To: "Anton Vorontsov" <cbouatmailru@gmail.com>,
	"Barry Song" <21cnbao@gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

>-----Original Message-----
>From: uclinux-dist-devel-bounces@blackfin.uclinux.org=20
>[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On=20
>Behalf Of Anton Vorontsov
>Sent: Friday, June 18, 2010 9:32 PM
>To: Barry Song
>Cc: David Brownell; Artem Bityutskiy;=20
>linux-kernel@vger.kernel.org; linuxppc-dev@ozlabs.org;=20
>linux-mtd@lists.infradead.org;=20
>uclinux-dist-devel@blackfin.uclinux.org; Andrew Morton
>Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] mtd: m25p80:=20
>Reworkprobing/JEDEC code
>
>On Sat, Jun 12, 2010 at 02:27:12PM +0800, Barry Song wrote:
>> On Wed, Aug 19, 2009 at 5:46 AM, Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>> >
>> > Previosly the driver always tried JEDEC probing, assuming=20
>that non-JEDEC
>> > chips will return '0'. But truly non-JEDEC chips (like=20
>CAT25) won't do
>> > that, their behaviour on RDID command is undefined, so the=20
>driver should
>> > not call jedec_probe() for these chips.
>> >
>> > Also, be less strict on error conditions, don't fail to=20
>probe if JEDEC
>> > found a chip that is different from what platform code=20
>told, instead
>> > just print some warnings and use an information obtained=20
>via JEDEC. In
>> This patch caused a problem:
>> even though the external flash doesn't exist, it will still pass the
>> probe() and be registerred into kernel and given the partition table.
>> You may refer to this bug report:
>>=20
>http://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?ac
>tion=3DTrackerItemEdit&tracker_item_id=3D5975&start=3D0
>
>Thanks for the report.
>
>There's little we can do about it. Platform code asked us
>to register the device, and JEDEC probing of M25Pxx chips isn't
>reliable (thanks to various vendors that make these JEDEC and
>non-JEDEC variants), so the best thing we can do is to register
>the chip anyway.
>
>OTOH, if the board pulls MISO line up, then the following patch
>should help.
Make sense with pullup to keep the value high while external device
doesn't exist.
>
>If this won't work, we'll have to add some flag to the platform
>data, i.e. to force JEDEC probing, and not trust platform data.

How about we add a non_jedec flag in platform_data, if the flag is 1, we
let the detection pass even though the ID is 0? Otherwise, we need a
valid ID?

>
>Not-yet-Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
>---
>
>diff --git a/drivers/mtd/devices/m25p80.c=20
>b/drivers/mtd/devices/m25p80.c
>index 81e49a9..a307929 100644
>--- a/drivers/mtd/devices/m25p80.c
>+++ b/drivers/mtd/devices/m25p80.c
>@@ -16,6 +16,7 @@
>  */
>=20
> #include <linux/init.h>
>+#include <linux/errno.h>
> #include <linux/module.h>
> #include <linux/device.h>
> #include <linux/interrupt.h>
>@@ -723,7 +724,7 @@ static const struct spi_device_id=20
>*__devinit jedec_probe(struct spi_device *spi)
> 	if (tmp < 0) {
> 		DEBUG(MTD_DEBUG_LEVEL0, "%s: error %d reading=20
>JEDEC ID\n",
> 			dev_name(&spi->dev), tmp);
>-		return NULL;
>+		return ERR_PTR(tmp);
> 	}
> 	jedec =3D id[0];
> 	jedec =3D jedec << 8;
>@@ -737,7 +738,7 @@ static const struct spi_device_id=20
>*__devinit jedec_probe(struct spi_device *spi)
> 	 * exist for non-JEDEC chips, but for compatibility=20
>they return ID 0.
> 	 */
> 	if (jedec =3D=3D 0)
>-		return NULL;
>+		return ERR_PTR(-EEXIST);
>=20
> 	ext_jedec =3D id[3] << 8 | id[4];
>=20
>@@ -749,7 +750,7 @@ static const struct spi_device_id=20
>*__devinit jedec_probe(struct spi_device *spi)
> 			return &m25p_ids[tmp];
> 		}
> 	}
>-	return NULL;
>+	return ERR_PTR(-ENODEV);
> }
>=20
>=20
>@@ -794,9 +795,11 @@ static int __devinit m25p_probe(struct=20
>spi_device *spi)
> 		const struct spi_device_id *jid;
>=20
> 		jid =3D jedec_probe(spi);
>-		if (!jid) {
>+		if (IS_ERR(jid) && PTR_ERR(jid) =3D=3D -EEXIST) {
> 			dev_info(&spi->dev, "non-JEDEC variant of %s\n",
> 				 id->name);
>+		} else if (IS_ERR(jid)) {
>+			return PTR_ERR(jid);
> 		} else if (jid !=3D id) {
> 			/*
> 			 * JEDEC knows better, so overwrite=20
>platform ID. We
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel@blackfin.uclinux.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
