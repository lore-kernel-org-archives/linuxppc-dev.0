Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71D13679A6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 00:11:46 +1100 (EST)
Subject: Re: snd-aoa: new apple sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1143589234.2284.63.camel@localhost.localdomain>
References: <1143547826.13615.24.camel@localhost>
	<1143589234.2284.63.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-OMIINZ//dSUZLBacetpx"
Date: Wed, 29 Mar 2006 15:11:39 +0200
Message-Id: <1143637899.9481.28.camel@localhost>
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


--=-OMIINZ//dSUZLBacetpx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-29 at 10:40 +1100, Benjamin Herrenschmidt wrote:

> The GPIO stuff is a bit can-of-worms-ish ... we need at least 2
> different implementations for machines using "old style" direct GPIO
> access and machines using platform functions. So we may need a gpio
> "driver" with 2 instances there.

Yeah, was thinking like that too.

> I think we need to hook that with the input/output net... basically we
> just say things like mute/unmute(id) and the gpio "layer" sort of
> matches the input/output "id" with whatever gpios it has at hand. That's
> also why I think your input/output IDs should have separate entries for
> combo connectors vs. analog line out (at least you used not to, I
> haven't looked at the latest code).

Note sure what you mean here...

> Then, the core would get events from interrupts (or clock switches from
> the codecs) via a yet-to-be-defined call and would react by calling the
> various mute/unmutes accordingly for available inputs and outputs on the
> bus where the event occured.

Ah but you see, the codec actually "mutes" the digital output when it
isn't usable, and the codec also mutes the analog output when we
transfer compressed data. We don't amp-mute in that case, but just from
the codec, so no analog audio is even leaving the codec.

> For things like headphone/speaker automute, I think we need a kind of
> tristate.. either that, or we need a bit mask of mute conditions. When
> any of them is set, it's muted. That way, the "user" mute control sticks
> regardless of the automute action or temporary mute to analog outputs
> because, for example, the digital input lost its clock and we are
> switching (we need to mute to avoid "clics").

Yeah. I have to think a bit about an in-snd-aoa api for all this.

> Hrm... So my feature calls are doing too much at once... (they both do
> the clocks and the cell enable). I don't do clock refcounting like Apple
> does tho, thus the main clock sources are always enabled. So I think all
> you have to do is toggle the I2Sn_CLK_ENABLE bits ...

Hmm. How do I get at those bits? Clock refcounting would be nice too,
along with proper power save management...

> Can you verify if all machines that have digital inputs (thus all
> machines for which you may need to do that kind of clock switching) also
> have working platform functions for doing so ? If they do, then it's
> really just a matter of calling those. If not, then we can either
> ioremap the FCR's in the driver and play with them (evil solution +
> possibly locking problems) or add a feature call.

The former isn't feasible since I need to do clock switching even on
analog-only machines to support more sample rates than the 44.1 KHz that
the firmware sets for the boing sound :)

> In the later case, you add a feature call in pmac_feature.h and the
> appropriate entry in the table in feature.c and then you can toggle bits
> as you wish with appropriate locking (look at eixsting code in there). I
> can give you more details on irc if you need.

Ok. I definitely need more details I think.

> But it would be nice if it could all be done with platform functions
> instead.

Hardly possible though, see above.

> > Modalias situtation. I played some tricks: i2sbus depends on soundbus

> Yeah :) There might be some issue with the macio automatching from
> userland, not sure yet, could just be missing bits in hotplug scripts.

macio automatching is working, i2sbus loads, but the latter modules
don't. I guess there's a userland issue in that it doesn't pick up new
devices that are added to /sys while it is loading another module.

> > Recording. There's code to record sound, but it doesn't do anything on
> > my machine. I have no idea why.
>=20
> What machine ? The quad ? maybe you need some gpio manipulation or maybe
> you just didn't get something right in onyx ... I'll try later.=20

Yeah the quad. I was thinking that no matter what, I should at least be
recording silence, but my userland app (arecord) doesn't get *any* data
at all. It's like the dbdma controller isn't doing anything.

>  - macio_device gets the suspend resume event. That is, the i2s busses
> basically. That code should forward to all attaches sub-busses which
> then dispatch to codecs.

right.

>  - ordering of things should be: mute all, stop alsa, stop codecs
> (enable whatever internal power management mode they may have), stop
> clocks, disable i2s cells.

yeah. It's slightly more complicated unless we assume that the control
interface (i2c) is always available, because we'd also get power
management through the i2c device stuff.

> I'll play with adapting the whole stuff to older machines, I have plenty
> of those :) We also need to implement a davbus module, so make sure you
> don't have too much i2s-related assumptions in your core.. No timeframe
> for that though, I'm fairly busy with other things at the moment

I don't think there are any i2s assumptions. Well, except that on any
given soundbus_dev, you have at most one input and one output stream...=20

> It's also a complicated thing because of the need to deal with old
> machines and the need to coordinate properly & serialize... things like
> interrupts or events from the codec should, if possible, use alsa hidden
> controls or whatever other ways to properly serialize, if possible, be
> run at task level (from a work queue) and things like that (due to the
> need for delays etc...

Good points.

johannes

--=-OMIINZ//dSUZLBacetpx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCqHh6Vg1VMiehFYAQJ1tRAAs86WRC6zB46HOMYuc3CeJhgXtrf12e5K
lIr9p8nuLF3RQeTIIbyBAQBrK+jkmtWt1RL7ChCxKtsYUN8o1qlP5vkIZmRD641o
qboHPOYAulUFD+67H4MHDIES5IXr7vd9Tg6e87Dhd5BomzsHChXzggut4Mpdcpes
kkl+ByN8Rd0oHZYRtWE3hqP0piNWI4vgCS2235iqHkOdCPj6Gbvfn6TpJBHIkLw+
Ri2Chfk7Kt1CjJ6jgVgVHTwfxRbPPnYP7jpbq0n96RXlGqTQIhjif/MkeXR0iEoh
Mdi2+b2yqPpu0j63n/KnHnVfgThB+9JYoSkUAsjn4dgGiv7O9u6cCLcAGzUB01pp
cMlQEzFMoXD9bQI0YNbYXmphBntkpBPhPy+FPWmpPE8OBtfkYDZHAbfLdnQF7iE4
QSZY1DAlTbd6mEeJ8dYfM2YqrKAf+eegmL9BTEtC5rXsbwPyqi/TJwiF7dp63ssq
lzNJK7l2ea4KPtBJPe4ZwCLTg3ANR+k3deg2sTaI/CXUAFNOC5HHBLUDHjkxHLuh
5aS/EJ+Fk56e+gTmpcW1hrzhmdwkk0BitcmtoImFBKUvf8L1c6wrcs5x9h/OFV/F
OS7HLUkdaFWKZCzFlI4a7gKJne6yYHdk7oQCwM8J882vrw3rdKo/vFTGsCE/mkVG
r7w5l8vBN5Q=
=JqL6
-----END PGP SIGNATURE-----

--=-OMIINZ//dSUZLBacetpx--
