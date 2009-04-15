Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C311DDDF95
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 22:52:56 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c    
	drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090415141530.0d5e47fc@hyperion.delvare>
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
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-agO/F7mN9t5HbyAf2kWa"
Date: Wed, 15 Apr 2009 14:52:14 +0200
Message-Id: <1239799934.9071.4.camel@johannes.local>
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


--=-agO/F7mN9t5HbyAf2kWa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> > Because the device-tree is broken -- there are two nodes for the same
> > device, and only one of them can be used. Then the fabric rejects the
> > first instantiation from the broken node. Here's how it looks normally:
> >=20
> > ...
> > [   10.398296] snd-aoa-codec-onyx: found pcm3052
> > [   10.398472] PM: Adding info for i2c:2-0046
> > [   10.412189] snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't m=
atch!
> > [   10.462593] snd-aoa: fabric didn't like codec onyx
> > [   10.468030] PM: Removing info for i2c:2-0046
> > [   10.473892] snd-aoa-codec-onyx: found pcm3052
> > [   10.479317] PM: Adding info for i2c:3-0046
> > [   10.485631] snd-aoa-fabric-layout: can use this codec
> > ...
>=20
> OK, I understand better what is going on now. I do not understand the
> crash at the end though, but I suspect it isn't a bug in my code but
> simply a faulty error path which had never been taken before.

That would be weird -- the error path _has_ to be taken always in onyx.
Unless you're talking about something in the i2c core or whatever?

> Now, the fact that there are two nodes, one right and one wrong, is
> quite a problem. My code expected the device tree to be trustworthy.

No such luck.

> The new i2c binding model cleanly separates the instantiation of
> devices and their binding to a driver. The codec check which fails,
> will cause the i2c device to not bind to its driver, but it will still
> be present, while there is no underlying physical I2C device if I
> understand properly. In the new i2c model, you have to ensure that an
> i2c device exists _before_ you instantiate it.

Oh, no, there _is_ an underlying i2c device, the same one. The DT
accidentally has two almost identical nodes for the same chip, but we
can only use the one with the correct reference.

> Well, there is a dirty workaround, which I will apply for now, but...
> ideally the layout factory should be revisited so that the codec check
> happens earlier. Is this something you could help with?

That's not really possible unless the factory post-processes the entire
device-tree -- very ugly.

> That's something which isn't too clear to me: is there a physical
> device at 2-0046 and 3-0046? The onyx codec is accepted for the latter,
> however it seems that the test of a device presence at 2-0046 succeeds
> as well...

It's the _same_ physical device.

johannes

--=-agO/F7mN9t5HbyAf2kWa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5dh7AAoJEKVg1VMiehFYA8AP/jNTnIG42uoARmzw3UbmGQh6
T2xG8UREcnUJgYmT/P6jgoSoSHGRK6Ew3KkIzRw7x4biObnIc5S0OVoNpA+i0bt/
6i1KyRyIfZo8WrGT1vbpEcO9XEb5EQj9PLRKPdKTpK5F3rvxeaMWV/Zc61f15Lpt
KQPhYE6WfZr6tHHoBaejdCa26e64YtIx/SF4roE3YYRHDw4oJfjs7ifCocMyEKvT
ewFOxB4kRWeW9lDXf2cJ9vaYSQaj1JHBvNPAbN/Q6GJK4ZjmxdflXhMQJiM67Q91
nd9JP/Q6c+D7Qwoh4BNWV+BHU7eUZ5H9lEdRqZAdYwF/nIdK/uoJHPf1S6zEp5jo
OSP+Eq6Fa4/g++XBhPkzmxxQThoO4fgLATsHPhG3ycy1s+hx17yoVmR5g251h7AS
NtxfJ5yf6fpcWtXaOoQNljoy7Q8vporoKsENbpjYBbD4uKhIu/8fC4Bgoi8AsOQS
aaC3+lHS9maYAvA3iySjKE5gXVCNMfgR9IL24EsLVB+Q4eYtdvyAqsxfflhvX93n
jyaaobMFdd6xoNYQqKpl9zBWJJbz177lmLTvzxHlOkSte+Ant8GZwuoslYiAhwRW
B+HK2snA3/Fo7W5vobcTDMQhVgjxxVY6QgpL/jj3gzWgCuNj1e8lEDfnGlMHs63z
K52cuEep1HgpEbZrt9oh
=1CSo
-----END PGP SIGNATURE-----

--=-agO/F7mN9t5HbyAf2kWa--
