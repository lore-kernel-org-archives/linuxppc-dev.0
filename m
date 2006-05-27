Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 869B4679E1
	for <linuxppc-dev@ozlabs.org>; Sun, 28 May 2006 06:42:00 +1000 (EST)
Subject: Re: [RFC] snd-aoa and interrupts (headphone detection etc)
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1148679918.8089.166.camel@localhost.localdomain>
References: <1148055359.6228.20.camel@johannes.berg>
	<1148679918.8089.166.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9FBFTugk1yZthEX1Oc5z"
Date: Sat, 27 May 2006 22:41:47 +0200
Message-Id: <1148762507.16989.64.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9FBFTugk1yZthEX1Oc5z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-05-27 at 07:45 +1000, Benjamin Herrenschmidt wrote:
> > The problematic part is things that the codec must control. Say we want
> > line-in detection to automatically switch to line-in if microphone is
> > selected (does anyone ever want this?). Then the problem is that the
> > interrupt arrives at the GPIO layer, and I can easily make it seen in
> > the fabric too. However, then propagating it to the codec is a bit
> > harder. Or we don't have it in the fabric but have the codec register
> > for that interrupt (through our GPIO layer). This is the first option.
>=20
> No. I don't think the codecs should mess with the GPIOs directly. The
> policy should be implemented in the fabric. If in some case you need to
> change some codec settings, then the codec shall provide an accessor for
> doing so.

Yeah. That was my second option mostly.

> > The second option is changing the whole in-/output control code that we
> > have and moving it from the codec to the fabric layer. The fabric
> > already knows what in- and outputs a codec has (in order to know what i=
s
> > connected), hence if we added a codec driver function to turn on/off an=
y
> > in- or output we could have the fabric control this. But then we'd also
> > have to make known to the codec which of those are mutually exclusive,
> > and generally make it more complicated.
>=20
> We don't have to make known to the codec, we just turn on/off the right
> ones.

Hmm, ok, good point, then we don't even need the complication of telling
the codec what is connected to it. Maybe that simplifies the code in
total... But the codecs will still need hardcoded numbers for the
various in- and outputs that the fabric needs to know.

I'll think about this a bit more, maybe experiment with the code a
bit :)

johannes

--=-9FBFTugk1yZthEX1Oc5z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHi5iaVg1VMiehFYAQKa3w/8Cn5nJRD2IltKzIWLpzCMGv3tO+NSio0w
+P7ciww0wwqWM5C+pG+PA1Zez66vn2gN+WP8XjEfHCK9/yjos+iEsDWwVBKSS2ho
qXCwRgQxMMif3kCbf65K/PIA7tC/bzv3efc7VeqRaOKk9a5VUK/2cWpQ2NJM59FS
y8x2R0RbWPEdO0V+gi9w70bkcLVXQmpVUUxi6Gp3YSgrmeKCWxjbRPaRyqGLVFNt
ZztuP088CNU2IY9qQ7ZCL3ZiDkx2QEcu5W36X/v0y1Akaytm4KcLsnmU6WjutMCI
j/Or81xOIQwSnO1GCMdkIJXImMxczjwohcDfOqv8F9GmF+qpl6QTIGz1596/aWMU
641Vc3z07+jc93GXBTtIvIIX6f3kJIyXjWiwf/OUdZnytHcxfy9ffqxbWvou/Nm+
h792WoOxShinHkgEsvNSIp1yIoM/rvVTpNEgKp0TFLYKDzxFnPLcqE6yJXb5HzmC
RvR3T3PRIowI4Kh7E7Cok+xc8ZDlZ+4VmpcifAzw+cSCUzEdFW2Npd9mVC2z9s/Y
TUYF3oylyqUoQtafhDIwHwrNqh22JrCEkGTjkVfBD+uuROhikzKuUsVlKSUzOBEg
2f+7rULt+PjSpcbM/WUdRE1ORQf8d3OAQNyXDHy61eSi1QCIF66UV6ZXrgrWG0Yl
SDoYcHPjqh4=
=kqFB
-----END PGP SIGNATURE-----

--=-9FBFTugk1yZthEX1Oc5z--
