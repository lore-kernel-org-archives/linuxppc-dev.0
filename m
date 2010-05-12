Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc,kexec: Speedup kexec hpte tear down
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <9537.1273626418@neuling.org>
References: <20100511062826.E1C49D3340@localhost.localdomain>
	<1273561463.9209.138.camel@concordia> <30983.1273620594@neuling.org>
	<1273624565.5738.8.camel@concordia> <7247.1273624988@neuling.org>
	<20100512010003.GB3548@drongo>  <9537.1273626418@neuling.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-bu56UQMJhGcW/DJfYuf8"
Date: Wed, 12 May 2010 11:36:11 +1000
Message-ID: <1273628171.5738.36.camel@concordia>
Mime-Version: 1.0
Cc: kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-bu56UQMJhGcW/DJfYuf8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-05-12 at 11:06 +1000, Michael Neuling wrote:
> > > We probably only do the remove on < 1% of the hptes now.  So I doubt =
we
> > > would get a speedup since most of the time we aren't do the remove
> > > anymore.
> >=20
> > It would be nice to have some actual numbers.  Could you add some
> > counters and print the results at the end?  (Or don't you have any
> > way to print things at that stage?)
>=20
> Printing is hard at that point but I think we can do it.  I'll try to
> when I get some time.

A version of udbg_putcLP() that uses a raw hcall should work, or there
was code added to purgatory recently to print to the HV console which
you could nick.

> A heavily loaded system which kdumps will need a lot more hptes removes
> than kexec, so stats for both these cases might be useful also.

Yeah, or even a system that is kexec'ed while lots of stuff is still
running.

cheers



--=-bu56UQMJhGcW/DJfYuf8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvqBgsACgkQdSjSd0sB4dKSBgCfZD3RoXWXft7f8agnCUQbU/Qq
7/YAn3f/X+Vghs1inbGC4/U57qS/IbaS
=34Ff
-----END PGP SIGNATURE-----

--=-bu56UQMJhGcW/DJfYuf8--
