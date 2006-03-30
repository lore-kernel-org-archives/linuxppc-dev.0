Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F035367A3A
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 01:13:24 +1100 (EST)
Subject: Re: snd-aoa: new apple sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1143673907.32206.19.camel@localhost.localdomain>
References: <1143547826.13615.24.camel@localhost>
	<1143589234.2284.63.camel@localhost.localdomain>
	<1143637899.9481.28.camel@localhost>
	<1143673907.32206.19.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-iXAjOGPoHNYw3FtrioB7"
Date: Thu, 30 Mar 2006 16:13:15 +0200
Message-Id: <1143727995.20571.37.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>,
	Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-iXAjOGPoHNYw3FtrioB7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-30 at 10:11 +1100, Benjamin Herrenschmidt wrote:

> Yes, but we should probably still mute the amps... especially when using
> a separate analog codec (like tas3004 + topaz setups).

Hah ok, are those on the same i2s bus? Hrm. No actually, I don't think
we *have to* mute the amps since in that case, we really should be
turning off the tas3004 anyway so it doesn't even try to create analog
output from the digital 'noise' it's getting. That shouldn't be too hard
to add in that case. Though, the current framework can't do that.
Bugger. I'll have to think about how to export the correct capabilities
to userspace, onyx is currently playing some tricks to get it right :/

Ok, this isn't hard to handle. Right now, we intersect all possible
formats that are registered in all codecs on a soundbus device. This has
to change to intersect all transport_infos within a codec, and then
combine these over the codecs. Something like:

$$\mbox{allowed} =3D \bigcup_{c \in \mbox{codecs}} \, \bigcap_{t \in \{\mbo=
x{transfers of c}\}} t$$

(http://johannes.sipsolutions.net/snd-aoa-formula)

Then the codecs are notified whichever format userland chooses, and can
then disable themselves if necessary. That should work fine. Initially,
I assumed just doing a big intersection would be ok, but it can't work
across codecs. Within a codec, it is manageable, look into onyx :)

> I was thinking about an event based mecanism... snd-aoa has an array of
> all inputs & outputs, which codec handles them, and, if relevant,
> handles to connector detect GPIOs and amp mute GPIOs.

Yeah, sounds good. Except that the fabric needs the array.

> Clock refcounting will be done ... some other time :)

:)

> And you need to turn the clock off for that ? All the FCRs are useful
> for you is to turn the clock input on and off, you shouldn't need that
> except when switching to an external clock no ? And even then ... AFAIK,
> Darwin AppleOnBoardAudio isn't playing with those FCRs at all unless
> I've missed something, all it does is to call in PowerI2S via platform
> calls to AppleKeyLargo which is equivalent to the existing pmac feature
> call...

I need to turn off the clock to the cell, not the clock. Something that
I'm currently doing by calling the platform cell-enable function. I
think that's all that is needed to be able to change the data word sizes
and serial format registers. Will look a bit more in darwin, it's
commented in the legacy audio stuff I think.

> How so ? autoloading only works for devices on a bus type known by the
> autoloader.. like macio. Thus other modules won't autoload unless you
> have a bus type that supports the loading stuff for hotplug and
> appropriate scripts... macio has such things, I don't think it will
> handle your soundbus though without some changes, and the modules
> themselves must expose via tables what they match on. I'm not sure I
> fully understand what you are expecting there

Ah heh, I thought the userland would just try to load modules for *any*
device that shows up based on the modalias, i.e. "device shows up
in /sys/devices" =3D> "modprobe `cat /sys/device/<new>/modalias`"

> Maybe you aren;t getting the right addresses for it from OF :) I told
> you there are some dodgy things going on with the device-tree ... I
> think tx is at 0x8000 and rx at 0x8100 inside the MacIO ASIC (thus
> 0x8008000 and 0x8008100). Another possibility is that you are
> programming it wrong or haven't enabled something somewhere in the codec
> to actually emit data :) I'll have a look as soon as I manage to find
> some time. Maybe on the plane this week-end.

If the codec wasn't emitting data, then I should still record silence on
the i2s bus, no? Clocking is done by the i2s cell. But I'm not too sure
about this, I don't know where the problem is. I think the address is ok
though.

> > yeah. It's slightly more complicated unless we assume that the control
> > interface (i2c) is always available, because we'd also get power
> > management through the i2c device stuff.
>=20
> It is always available. Just ignore PM callbacks from i2c

Ok. But seeing that the soundbus stuff is generic enough, I may want to
still handle that kind of situation. Or maybe not. Haven't decided yet,
probably depends on how hard handling it really is.

johannes

--=-iXAjOGPoHNYw3FtrioB7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCvneaVg1VMiehFYAQKD/xAAnNm/zAZVGT5mQVouJXiQJ9FZxRF82S6G
CF+h9+2vU8bEW3PcfIOP9ru+IEGHrXMTj4qdpxk5xf4WV/uOcb8G5p+0nN7glntf
A1ykEjSHTREPQYHCc2QbquqHQB3YTaVnjIypvQcJKIFnINzS6pvguiD1qu5SIbQ7
0OmkkgOq7mIAfOayGcpGgXTthrmKz2Uyrz8oyFXPrdL/kNnVASVaF+BbSPntzKF7
0oGRdOhuZES5jACEmqLpotDjzyIaTOEVe4QwVs+zvBBBCr1t6t833lA1J65MrO5M
glZhiED2+7FBe7VSHQSiKdhBMAh7mIvyQYsvshBgncJWP6KMKDkQAynbsTMu5aK+
v8/o+DOyT5qCSf9fp4O9urAC0FP4OG/M0Kbbq8+C+FP7v20o4eA93cBTtlceMkWi
qlRmD65T23aj+jZRFkHQyV2reG7FL27r3qXxqfP6j9hBNFK5DgmRqwHSnWcCUULg
Cw7VG8rDHxcTHQGaDfxswONOgCf+mmLh6VXKH0ANOKrBix6ZQWvb9dfzAeVmPFnh
CQDsJw0dHl3AArbzljKTnlAT1JkczmjIlRG4PImiRJ595XIfveCffmTU9TAhMYHL
+r1AmLZS3UY9R4Uiq2pQljdsoSbe+apX39WLAedrwONOYscyZJrjK1tql+C5ukaB
3ac4fGs7R2U=
=7asB
-----END PGP SIGNATURE-----

--=-iXAjOGPoHNYw3FtrioB7--
