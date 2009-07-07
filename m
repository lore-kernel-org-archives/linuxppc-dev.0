Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E475EB7083
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 10:32:33 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2A80DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 10:32:33 +1000 (EST)
Subject: Re: [PATCH] powerpc/mpic: Fix MPIC_BROKEN_REGREAD on non broken MPICs
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20090706135926.GA16205@lixom.net>
References: <6c9c0889feaceeea55bd2b6fef0c19e408425ef5.1246846125.git.michael@ellerman.id.au>
	<20090706135926.GA16205@lixom.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-oQk9mFOq47kHW9OIMS8h"
Date: Tue, 07 Jul 2009 10:32:33 +1000
Message-Id: <1246926753.4449.1.camel@concordia>
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


--=-oQk9mFOq47kHW9OIMS8h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-07-06 at 08:59 -0500, Olof Johansson wrote:
> On Mon, Jul 06, 2009 at 12:08:52PM +1000, Michael Ellerman wrote:
> > The workaround enabled by CONFIG_MPIC_BROKEN_REGREAD does not work
> > on non-broken MPICs. The symptom is no interrupts being received.
> >=20
> > The fix is twofold. Firstly the code was broken for multiple isus,
> > we need to index into the shadow array with the src_no, not the idx.
> > Secondly, we always do the read, but only use the VECPRI_MASK and
> > VECPRI_ACTIVITY bits from the hardware, the rest of "val" comes
> > from the shadow.
>=20
> I'm travelling without remote access to a machine to test this on. Given
> that it changes the errata workaround (subtly), I'd appreciate the chance
> to give it a go before it gets merged.

Sure.

I was also wondering, was this workaround ever required in a released
chip - or was it just dev samples? If it's the latter, do we still need
to carry it at all?

cheers

--=-oQk9mFOq47kHW9OIMS8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpSl5cACgkQdSjSd0sB4dIwFgCeP3wf3+EYzsZ20XukohT663fH
yJgAniHau7T+++o1ZRaWdQ2PS7VKBC9w
=lJmT
-----END PGP SIGNATURE-----

--=-oQk9mFOq47kHW9OIMS8h--
