Return-Path: <emunson@mgebm.net>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C82021007DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 23:21:02 +1000 (EST)
Received: by qyk7 with SMTP id 7so993867qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 06:20:58 -0700 (PDT)
Date: Wed, 27 Apr 2011 09:20:54 -0400
From: Eric B Munson <emunson@mgebm.net>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH V4] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
Message-ID: <20110427132053.GD2936@mgebm.net>
References: <20110427130822.GC2936@mgebm.net>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AD06@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD06@saturn3.aculab.com>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, paulus@samba.org,
	anton@samba.org, acme@ghostprotocols.net, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Apr 2011, David Laight wrote:

> =20
> > prev and val are both 64 bit variables holding 32 bit numbers, we do
> not
> > accumulate in either, they are both replaced by values directly from
> the
> > registers.
> > So prev > val will not always be true.
>=20
> The code seems to be:
>     prev =3D local64_read(&event->hw.prev_count);
>     val =3D read_pmc(event->hw.idx);
>     delta =3D check_and_compute_delta(prev, val);
>     local64_add(delta, &event->count);
> Which looks very much like 'prev' being a 64bit counter generated
> from the 32bit pmc register.
>=20

Which implies that it will only ever be 32 bits wide, just stored in 64.

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJNuBg1AAoJEH65iIruGRnNzGYIAJIsoYp0R/dJvlfUncOh3B6e
FGoYP9TL6so1Wa//AYLYgWG7ERPn6XAfIOQx99XzqEhf4sQhJ066c+pz9jnNu6JY
9Gl7r8haQ81bxzkNNIPws45il40/wyTJNtBajWuAz/AH+Vh/BkEyjTtzLupawOeQ
AvOPZmVL2Rn+i/zc+3blf5yfeFwX90m2Nqzfj2qGLJcMQ+KN3tH3sLnoXyT+8dn1
JRcXFPo2AnoD7f43UBiuHq3WsIpnGlly1NN8HOR6zBxI8crrj+l57h/+F5fOzZIm
KcdqQlPkBXLowV24Zd48V0j/goEacK5ZoXQUWygFnpCq+l+T4wvE/jNwteHGi1o=
=QRrD
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
