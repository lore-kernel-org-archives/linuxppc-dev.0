Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 297C9B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 12:03:31 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 187C9DDD1B
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2009 12:03:31 +1000 (EST)
Subject: Re: [PATCH 3/20] powerpc/mm: Add HW threads support to no_hash TLB
	management
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1249079342.1509.99.camel@pasglop>
References: <20090724091523.8AD8CDDD1B@ozlabs.org>
	<2E027F3C-8FAA-42EC-99B2-9B7EC470094E@kernel.crashing.org>
	<6FD94305-B60D-4DAF-8296-88345D11187F@kernel.crashing.org>
	<1249079342.1509.99.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-xqGm679u6XmLmgpMHrfp"
Date: Mon, 03 Aug 2009 12:03:30 +1000
Message-Id: <1249265010.5516.31.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-xqGm679u6XmLmgpMHrfp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2009-08-01 at 08:29 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2009-07-30 at 22:35 -0500, Kumar Gala wrote:
> > >               /* XXX This clear should ultimately be part of
> > local_flush_tlb_mm */
> > > -             __clear_bit(id, stale_map[cpu]);
> > > +             for (cpu =3D cpu_first_thread_in_core(cpu);
> > > +                  cpu <=3D cpu_last_thread_in_core(cpu); cpu++)
> > > +                     __clear_bit(id, stale_map[cpu]);
> > >       }
> >=20
> > This looks a bit dodgy.  using 'cpu' as both the loop variable and =20
> > what you are computing to determine loop start/end..
> >=20
> Hrm... I would have thought that it was still correct... do you see any
> reason why the above code is wrong ? because if not we may be hitting a
> gcc issue...
>=20
> IE. At loop init, cpu gets clamped down to the first thread in the core,
> which should be fine. Then, we compare CPU to the last thread in core
> for the current CPU which should always return the same value.
>=20
> So I'm very interested to know what is actually wrong, ie, either I'm
> just missing something obvious, or you are just pushing a bug under the
> carpet which could come back and bit us later :-)

for (cpu =3D cpu_first_thread_in_core(cpu);
     cpu <=3D cpu_last_thread_in_core(cpu); cpu++)
        __clear_bit(id, stale_map[cpu]);

=3D=3D

cpu =3D cpu_first_thread_in_core(cpu);
while (cpu <=3D cpu_last_thread_in_core(cpu)) {
	__clear_bit(id, stale_map[cpu]);
	cpu++;
}

cpu =3D 0
cpu <=3D 1
cpu++ (1)
cpu <=3D 1
cpu++ (2)
cpu <=3D 3
...

:)

cheers

--=-xqGm679u6XmLmgpMHrfp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp2RXIACgkQdSjSd0sB4dIAkgCgyV+3z9PGQpSusUykDZC8ONNg
kK8AoJ0J5uN/JAEj6kH9UXHis7n6K8z3
=Wjlp
-----END PGP SIGNATURE-----

--=-xqGm679u6XmLmgpMHrfp--
