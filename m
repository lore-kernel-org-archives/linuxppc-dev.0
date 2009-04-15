Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D8A2DE178
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 23:18:50 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090415150632.0b2fe6bb@hyperion.delvare>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
	<1239724227.24771.9.camel@johannes.local>
	<1239730915.24771.12.camel@johannes.local>
	<20090414214949.736597d9@hyperion.delvare>
	<1239746399.4205.21.camel@johannes.local>
	<20090415141530.0d5e47fc@hyperion.delvare>
	<1239799934.9071.4.camel@johannes.local>
	<20090415150632.0b2fe6bb@hyperion.delvare>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-KgCUxwmcyDfiPbhHiSjO"
Date: Wed, 15 Apr 2009 15:18:10 +0200
Message-Id: <1239801490.9071.11.camel@johannes.local>
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


--=-KgCUxwmcyDfiPbhHiSjO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-15 at 15:06 +0200, Jean Delvare wrote:

> > That would be weird -- the error path _has_ to be taken always in onyx.
> > Unless you're talking about something in the i2c core or whatever?
>=20
> Yes, i2c core or even driver core. I'll see if I can reproduce it.

Alright.

> > > (...)
> > > Well, there is a dirty workaround, which I will apply for now, but...
> > > ideally the layout factory should be revisited so that the codec chec=
k
> > > happens earlier. Is this something you could help with?
> >=20
> > That's not really possible unless the factory post-processes the entire
> > device-tree -- very ugly.
>=20
> What I had in mind was not so complex. Simply, we could move the
> i2c_new_device() calls into layout_found_codec(). That way we can
> decide to instantiate the I2C device if and only if check_codec() is
> successful. This is more efficient that creating the device, letting
> the driver attach to it, with probing eventually failing, and then
> removing the device if it wasn't the right one.
>=20
> That is, the i2c client would be a mere helper on top of struct
> aoa_codec, rather than the other way around.

Ah. That would probably work, but right now I have little motivation to
work on it -- I hardly use the G5 desktop machine any more.

> > > That's something which isn't too clear to me: is there a physical
> > > device at 2-0046 and 3-0046? The onyx codec is accepted for the latte=
r,
> > > however it seems that the test of a device presence at 2-0046 succeed=
s
> > > as well...
> >=20
> > It's the _same_ physical device.
>=20
> Wow. One I2C device which can be reached through 2 different I2C buses?
> First time I hear about something like this. Very odd. I can't see the
> point of doing this.

Hmm. How do you know it's on different buses? I don't really know
anything -- all I know is that the DT is buggered and lists the codec
twice. Since we can talk to both, then I'm sure it's just one chip, they
wouldn't put the chip in twice when you can use only one of them :)

johannes

--=-KgCUxwmcyDfiPbhHiSjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5d6MAAoJEKVg1VMiehFYd+0P/Ap+2i9Tf3fanlXX7m2Eb0of
XPtjiEcrxen+ikxHr3jv2sGDRNrQXiXVKA49alAMjykNeSQTeg0pOCGcHycIiCZW
JRO1YoLqYPSSx+O4v1Uy3/eG6WVCE7yvGkVVgXL9V2ba+MtlntB/4IGkMdeuYiMe
agmLEnzZwT0QjeN+rOhTarTeCr6MyhB4SRWRuF9G6vU+2xUx2y+IXlOi0tEEt1ya
YjjFo5FeDpjN/N1Zt5ZWdwPrtyRk1PxNNgbsssrP408yRyVjnRoXoi41ZjE1G36k
jFVORFnr/zYkTFIz2UhJfD83EqU6umvdZAp6rY8gpS6U2Ba7ARWpaawnk0c+NBRn
8Kai0heHUfSG0GVx64ShQKuN/cCsKJXvoJertjOTiWFyoJfeVOLwLpOgPYuvKyAo
qlnvavd2ztA+DjKmBo4qV710VQh72+yUtK11tRt9zCos8IhrkVf67NwPu1kAAftI
hg5iRo7+21vWdBGir1g8aOHUgKnpBrXgXOii08j2G8gFlIf/IQOrqE7l9tRlGC/l
6IR/Zn3UZtLL8Knc5Mtns/FnPgjd2NkiEW3hicf73sxeH7T92D6Jb3vzGwBT0qn0
Rv4uD/ReOvgmxgdbsPQ4zQQ9oLYH7Ljl4wu/wbiAnbGba4fr7DyxZ4L2h9wfJxMy
V8v7PPnh02GKcDuhgSYe
=82Z2
-----END PGP SIGNATURE-----

--=-KgCUxwmcyDfiPbhHiSjO--
