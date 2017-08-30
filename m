Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xjCWY5wpZzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 03:42:32 +1000 (AEST)
Date: Wed, 30 Aug 2017 19:42:28 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Florian Larysch <fl@n621.de>,
 David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Michal Simek <michal.simek@xilinx.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will.deacon@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sekhar Nori <nsekhar@ti.com>, Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joachim Eastwood <manabian@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Magnus Damm <magnus.damm@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
 Linux I2C <linux-i2c@vger.kernel.org>
Subject: Re: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
Message-ID: <20170830174228.sx5jgtxxy56zq47t@ninjato>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
 <20170828160121.gu4wf7jqu4ditksc@ninjato>
 <CABxcv=kSiqDN1=9fSfLkyW=uuXQZAoW4dhw=fco9RyOdDuPAdA@mail.gmail.com>
 <20170829084831.hsdok3ksi7anxzuc@ninjato>
 <CABxcv=nqbNsTs7D57VOt1-Tav_3i9U=XKn=BV=hPr1tG68eE2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ytpb2jjbrb4v5ate"
In-Reply-To: <CABxcv=nqbNsTs7D57VOt1-Tav_3i9U=XKn=BV=hPr1tG68eE2g@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ytpb2jjbrb4v5ate
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2017 at 06:19:02PM +0200, Javier Martinez Canillas wrote:
> Hello Wolfram,
>=20
> On Tue, Aug 29, 2017 at 10:48 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >> I don't have a DT based system at hand now, but I'll test it again and
> >> let you know probably tomorrow.
> >
> > I will try again today, too. Thanks!
> >
>=20
> Ok, I had some time to do some tests again. I used an ARM Chromebook
> (Exynos Peach Pi) that has an I2C touchpad (Atmel maXTouch).

I tried again as well and it still fails for me.

> Tested the following cases:

I think we should talk about the same case: Let me repeat what I did:

1) I added your patch "eeprom: at24: Add OF device ID table"
2) I added an EEPROM node to an I2C

+       eeprom@50 {
+               compatible =3D "renesas,24c01";
+               reg =3D <0x50>;
+       };

-> no at24 binding to the device

3) I revert your patch

-> at24 binding to the device

I think you should be able to test this DTS snipplet even without a real
eeprom. Especially after applying this to the at24 driver.

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 79c5c39be29cac..f9f547680c53db 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -805,11 +805,6 @@ static int at24_probe(struct i2c_client *client, const=
 struct i2c_device_id *id)
 	 * Perform a one-byte test read to verify that the
 	 * chip is functional.
 	 */
-	err =3D at24_read(at24, 0, &test_byte, 1);
-	if (err) {
-		err =3D -ENODEV;
-		goto err_clients;
-	}
=20
 	at24->nvmem_config.name =3D dev_name(&client->dev);
 	at24->nvmem_config.dev =3D &client->dev;


Can you check this?

Thanks,

   Wolfram


--ytpb2jjbrb4v5ate
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmm+QAACgkQFA3kzBSg
KbaE2Q//Ztb57N4sjqcTqycN0sZpXbdacPZDeXtEK8KJP8FVq2qJiry5i/Y3IueQ
8eehX6yk7ZPuXV9A3oMCi9IMRB5pPaAN0iiyMeaprfjCjrZnohY8dV0Arxjdee0y
IIfgcj/R8FrO5wco/VCNeNFn2Hkd5i+tlbHxi2CoDJ6jTuxj+5VHEnTNPthJDdiA
L0Nu4jQPuL1tywQfCwHbx4p9fnUdcobnCZl7nRXB4SFCdU/714R1XuYDbF2ZNN7u
Uy+xyEl7Ui5tvQMVMT2tUlrs3TTn4x9dX5pX0oQg4YYQieL+P20Yn4BkDbntzOWh
Ja9V1uzyL03PHZbTXie6dfnQzDHifVZpfeSrn0ayNVbAnG6svBQ8KXIcpMlmZSaA
biFOzjQlixCtp++uffxERZd9MWyZk1vQ2uL6OQBQMIm0RKUfzApb1jSADwHzM4Jn
PgOb9mN8vD6LrFgGOz9AtDQZ2gzCEpd8OEyUPlI+WfRaNsJDyLEIitl0ZDdaehIT
AfjhhXIVOB0mPdPsw4Z7IXkXhQn4LqQmVWS5wiLXBwgrk3nPePCVyTjGupZMvgoL
g9lntxWx+wfQgIFpFVp/zBxjW85nzq2aB9Gi2tbIPaCo5nIII1LZRlQwqTEvQVwF
hftPQqukT556jgHLoKu3tsDkEJqi4MpckAvU020qHEKcqyR4YrY=
=aBjO
-----END PGP SIGNATURE-----

--ytpb2jjbrb4v5ate--
