Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Make request_ras_irqs() available to
	other pseries code
From: Michael Ellerman <michael@ellerman.id.au>
To: Mark Nelson <markn@au1.ibm.com>
In-Reply-To: <201005191635.43544.markn@au1.ibm.com>
References: <201005172233.01183.markn@au1.ibm.com>
	<1274186451.26143.8.camel@concordia>
	<201005191635.43544.markn@au1.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-rGBuZTYM+pui+DGChBAv"
Date: Wed, 19 May 2010 16:35:54 +1000
Message-ID: <1274250954.7574.1.camel@concordia>
Mime-Version: 1.0
Cc: Tseng-hui Lin <tsenglin@us.ibm.com>, engebret@us.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-rGBuZTYM+pui+DGChBAv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-05-19 at 16:35 +1000, Mark Nelson wrote:
> Hi Michael,
>=20
> Thanks for looking over these patches!
..
> >=20
> > Existing code I know, but the error handling in here is a little lax,
> > what's not going to work if we miss some or all of the interrupts?
>=20
> That's a good point. For the existing code, if we miss an EPOW event
> it just means that the event won't be logged (as that's all we do with
> those events at the moment, although there is a comment saying
> that it should be fixed to take appropriate action depending upon the
> type of power failure); but it's a bigger problem if we miss one of the
> RAS errors because then we could miss a fatal event that we should halt
> the machine on. And for the upcoming IO events it's even worse as we'd
> miss an interrupt from the device...

Yeah that's what I was thinking.

> I would do it in a follow-on patch rather than this one, but what would
> be a good course of action if we can't request the interrupt?

Yes a follow on patch is the way to do it.

There shouldn't be that many reasons the request fails, other than
ENOMEM, or broken device tree perhaps. It's definitely worth a
WARN_ON(), people notice those at least.

cheers

--=-rGBuZTYM+pui+DGChBAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvzhscACgkQdSjSd0sB4dKwfQCfULwphstcjszDJnBV04GNnKDQ
sAcAoIWxPXpWFvKWIteeZjLdeNkrTis3
=Wrlc
-----END PGP SIGNATURE-----

--=-rGBuZTYM+pui+DGChBAv--
