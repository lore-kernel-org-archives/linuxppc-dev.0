Return-Path: <highguy@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20101120124226.GB11936@pengutronix.de>
References: <1289995250-17927-1-git-send-email-w.sang@pengutronix.de>
	<1289995250-17927-2-git-send-email-w.sang@pengutronix.de>
	<5F1D4949966C4C509360407B0F948EFE@HIGHGuY>
	<20101120124226.GB11936@pengutronix.de>
Date: Sat, 20 Nov 2010 15:07:25 +0100
Message-ID: <AANLkTi=aTz2Y=gPZd49iTxhyNeVVRPJA-qgkM9JsQNC5@mail.gmail.com>
Subject: Re: [PATCH 1/3] misc: at24: parse OF-data, too
From: Stijn Devriendt <highguy@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 20, 2010 at 1:42 PM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> Hi,
>
>> As far as I could tell, using compatible =3D <24c64>; didn't load the ri=
ght
>> module (module name is at24) and using at24 caused a device id mismatch
>> because at24 is not a known device ID. I could be wrong here and if so, =
I'd
>> very =A0much like a source code hint as to why...
>
> Have you tried "<vendor>, 24c64"? All I can say is that it works for me. =
Plain
> at24 worked for years with pcm030.dts and pcm032.dts, so I don't know whi=
ch
> issue you are facing. This patch is just about extending the support.

According to of_modalias_node, the prefix is stripped anyway, so that
wouldn't help.
The code probably worked using the buggy probing...
>
>> My patch worked by changing drivers/of/of_i2c.c to allow a generic
>> kind =3D " " statement that was filled in as i2c_board_info.type, to all=
ow
>> the module name and the device id to be different.
>> This makes the at24 driver no longer rely on probing (which it claims
>> is buggy anyway) and also benefits other drivers that support multiple
>> devices, but where probing is difficult (e.g. lm90 driver).
>>
>> I'm in the process of getting employer approval to get these patches
>> upstream.
>

It'll get approved ;) It's the first time I'm taking these steps, but
the procedures
are there, so at most it'll take some extra time.

> I hope you will get it approved, it is a lot easier to talk about code :)
>
> Best regards,
>
> =A0 Wolfram
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Wo=
lfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkznwjIACgkQD27XaX1/VRssnwCgg55UCwZFLcMI8kJI3mhCJQxL
> N7kAoJHpLn5BJpNjET+ngaQFrGxUBQm1
> =3DtyTb
> -----END PGP SIGNATURE-----
>
>
