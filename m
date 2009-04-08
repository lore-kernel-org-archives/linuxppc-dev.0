Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C078DE007
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 03:42:43 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090408150249.5a62a56c@hyperion.delvare>
References: <20090408150249.5a62a56c@hyperion.delvare>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-5wTX1AmlbQOChFAn8uW4"
Date: Wed, 08 Apr 2009 17:51:39 +0200
Message-Id: <1239205899.16477.32.camel@johannes.local>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-5wTX1AmlbQOChFAn8uW4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi!

> Basically the idea is to move the I2C device instantiation from the
> codec drivers (onyx, tas) to the I2C adapter driver (i2c-powermac.)
> This follows the Linux device driver model, requires slightly less
> code, runs faster and and lets the required chip drivers be loaded by
> udev or similar automatically.

Sounds weird -- how do you handle codecs that could be on different
buses? This seems to imply that any probing may potentially need to be
duplicated across any bus driver they could possibly connected to. But
that's not really relevant to this patch.

> The last driver to convert, keywest, is a mystery to me. I have a hard
> time understanding how it interacts with tumbler and daca. I have the
> feeling that it is essentially a glue module to workaround the legacy
> i2c model limitations, so probably it could go away entirely now, but
> I'm not sure how to do that in practice. Maybe tumbler and daca would
> be made separate i2c drivers, I'm not sure.

Sorry, I'm not familiar with this code.

> One thing in particular which I find strange is that tumbler has
> references to the TAS3004 device, much like the tas codec driver. It is
> unclear to me whether tas is a replacement for tumbler, or if both
> drivers work together, or if they are for separate hardware. I would
> appreciate clarifications about this.

Well... tumbler also drives the very similar tas3001 codec.

However, I need to start with a little more background.

Apple machines can contain various codecs, for example the tas3004,
which has various outputs. Due to the way Apple wires up the codec, you
need platform fabric to identify which outputs are connected where, cf.
sound/aoa/fabrics/layout.c. Note all machines have line-in for instance.

The aoa driver, which I wrote, currently supports only i2s buses for
actually transferring data, but I think there are some other ways to get
data to the codec -- I'm not too familiar with the old machines.

Now, aoa will currently automatically load from the layout fabric
module, and then pull in the modules for the codecs it _knows_ to be
present on the bus. Therefore, it seems that your patch makes things
less efficient because you probe for all those codecs, and there's no
machine that has all of them. The aoa fabric only loads the modules for
those it knows to be present, and they then probe (and in reality the
probing never fails because they really are there).

Now, since aoa needs information on how the entire system is glued
together (the fabric I was talking about with the line-in example), it
has to infer that from platform data, in this case the device tree.
Because I do not have any older machines, am lazy and snd-powermac works
for the old machines, snd-powermac with its "tumbler" is a driver for
the same tas3004 codec, but on a different, older, fabric.

Once upon a time the plan was to get rid of snd-powermac entirely and
port all its functionality into subdrivers of aoa, but that clearly
never happened. No fairy-tale happy ending here, quite obviously.

Now, looking at your patch, I think it will break snd-powermac. See, if
snd_aoa_codec_tas is automatically loaded on a system with an _old_
fabric that aoa knows nothing about, snd-powermac can no longer be
loaded. (Incidentally, snd-powermac cannot be auto-loaded at all
currently, while aoa can via the fabric driver's device-tree binding)

Therefore, probing the codecs in i2c-powermac and automatically loading
the corresponding aoa module will break sound on old machines.

I would think that if you removed the MODULE_DEVICE_TABLE from your
patch, it may continue to work because the aoa fabric driver loads the
modules as before, and on old machines nothing loads automatically and
snd-powermac can be loaded manually.

However, it will still be less efficient because you will be probing
_all_ those codecs, notably the tas family, even on machines that are
known to not have it (machines that have onyx). Putting that mutual
exclusion information into i2c-powermac would be misplaced, imho.

Note also that there's one more codec (topaz) which isn't currently
supported.

In conclusion, I think that the old/existing/legacy i2c binding model
was much better suited to platform knowledge about the way machines are
put together, and the new code is, as far as I can tell, less efficient
-- contrary to your assertion.


Since I'm away from all machines I could test this with I have no data
on any that or the module device table thing I pointed out for now.

Anyway, some more technical comments on your patch:
 * I realise you just copied things around but it would be nice to clean
   up the coding style, especially comment style, a little while at it.
   (yeah, it's my fault)

 * aoa_codec_* is the module name, I see no reason to use that as the
   i2c name, that should be the codec's name instead (aka pcm3052 etc)

johannes

--=-5wTX1AmlbQOChFAn8uW4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ3MgJAAoJEKVg1VMiehFYpTwQAJFYeJzTJUSqC6tkZwi3eXGP
lxPVkS/TyW76BzrPCI9cBmERFjunL35RfIEt3O2T2NFBnn7qW0i1uWVhgWUUI6p8
e+U0IEg7HmMDnvAkP8ycGvQ65oCHpeIgMYaY1GI2x9p3IAfyePE5S6c5brVuteq1
SG1QP27c99ChY9GzvpD7Y2aCyVGLLmdCInbvVxSjlMirko9Ght5gik0ZvQvgwnrP
nj7WdIWuUNCIwgEYSKAA9+YVpFaw+5Bvx6jiqD4W0iRxSUe91GUqMv71vxmddLDR
G1TM2n0T5N4pMMR1hzV0phIBZaSs5kUrbMhF+NLWVIFL+TDT1SGFuW33QlQ6+Ey3
B6ouYWI5F0JyR+fSXtBREb7ogzZo5Qa6X/ptU2DRHdyF2yD/JGMMqP5J4rvOm86J
Y6khl2O1a6Dg2i9KddNgJi8PbWcU1iFtniAzVgi8nMORbkFRPpP6AVJoVrvN7+bM
IXVBEopkErWfPtUcHarwKHXUIhrhnUor5tusFHzwFrdFhYgjKrpi0Ihe4HH/yWPx
cje0WUtlEjdZRTkcxMmiUJa9GR67qsKj5UyzNj2daOa6Q5gzB6wPX+RT1yuuQsyg
qDzxzLook8uCHpxArWwPwtx0VsF36M3ZJb+R05WFFeao/ouJfoKTl6rwEjA+ZzJe
/BXr7cvguuxGyT3Nngw/
=hbQY
-----END PGP SIGNATURE-----

--=-5wTX1AmlbQOChFAn8uW4--
