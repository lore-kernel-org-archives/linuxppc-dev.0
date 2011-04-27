Return-Path: <emunson@mgebm.net>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F90EB6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 23:08:30 +1000 (EST)
Received: by qwf7 with SMTP id 7so852707qwf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 06:08:27 -0700 (PDT)
Date: Wed, 27 Apr 2011 09:08:22 -0400
From: Eric B Munson <emunson@mgebm.net>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH V4] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
Message-ID: <20110427130822.GC2936@mgebm.net>
References: <20110427121902.GA2936@mgebm.net>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AD04@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD04@saturn3.aculab.com>
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


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Apr 2011, David Laight wrote:

> =20
> > +	if (prev > val && (prev - val) < 256)
> > +		delta =3D 0;
> > +
> > +	return delta;
>=20
> Also, 'prev' is a true 64bit value, but 'val' is only ever 32bits.
> So once the 64bit 'prev' exceeds 2^32+256 both 'prev > val'
> and 'prev - val' are true regardless of the value of 'val'.
> This will lead to jumps in the value ....

prev and val are both 64 bit variables holding 32 bit numbers, we do not
accumulate in either, they are both replaced by values directly from the
registers.  So prev > val will not always be true.

Eric

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJNuBVGAAoJEH65iIruGRnNuqYH/ibWoBdbN/59Q0KgkLPb2M1k
/9WNZIuerrVdLB/wwhFBT82fiqCLeWXLJ+MLaH38pKKVvdCCYTgvvzj2KhQyymhC
wPkf/aBlyl3dhtz8xl4c9ZmeZN34xTr/LQSbafRXTu3d++sn2T3uHGXWpUDCJzKo
s0uYPl8ByMgk0yIKqKGp94FZ2p1W6RpiEEV5lUwt1VKA7Q4WG98SY2umWZBqvnJP
nmuouW3CS2GaVKF9wfOk1erZbKZ3FbgOjxPpnuDyXCbBtPF+UZQXstNhgnM1fpoP
2joy+fIhcelDJ9tHMDNMsBI08mZHLFeayfDnKEHUU1/GFgZaHY9bVgYeXIv64X8=
=YjqT
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
