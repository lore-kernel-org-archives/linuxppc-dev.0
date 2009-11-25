Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC PATCH 14/19] powerpc: allow ioremap within reserved fake
	ram 	regions
From: Michael Ellerman <michael@ellerman.id.au>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B0C1337.6070309@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221536pf558b1fte36dc88bdf58e883@mail.gmail.com>
	<4B0AED90.6050600@yahoo.es> <1259019909.31172.63.camel@concordia>
	<4B0C1337.6070309@yahoo.es>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-KYAPW1mjtSMvLkBUWoWu"
Date: Wed, 25 Nov 2009 11:38:39 +1100
Message-ID: <1259109519.4017.8.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-KYAPW1mjtSMvLkBUWoWu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-11-24 at 18:09 +0100, Albert Herranz wrote:
> Michael Ellerman wrote:
> >> Would it be acceptable to create a global var __allow_ioremap_normal_r=
am that by default would have a value of 0 and would be set _only_ for thos=
e platforms needing it?
> >>
> >> The other solutions I see is:
> >> - add support for discontiguous memory to powerpc 32-bits (which is no=
t something that I can look into now)
> >> - don't use the precious second 64MB area (which is a waste)
> >=20
> > - Implement your own ppc_md.ioremap(), see iseries & cell for example.
> >=20
> > Currently that's only called on 64-bit, but you could change that.
> >=20
> > If I'm reading your patch right, you should be able to do that check in
> > your platform's ioremap() and then call the generic implementation to d=
o
> > the actual work.
> >=20
> > cheers
>=20
> I could use ppc_md.ioremap to duplicate ioremap except for the ioremap ra=
m check.
> But calling the stock ioremap without modifying it is not possible
> because it checks and bails out when ioremapping a region marked as
> ram (even if it's not real ram and it's memreserved).

OK, that wasn't clear in your patch. It looks like you're adding a check
(!__map_without_bats) - but whatever.

> Is the list of memreserved areas preserved once the kernel is running?
> If it is preserved another option would be to unban ioremapping ram if me=
mreserved.

Yeah it is, so that might work, though it's still a bit of a hack :)
But if that's just a stop-gap until sparse mem gets going on 32-bit
maybe that's OK.

cheers

--=-KYAPW1mjtSMvLkBUWoWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksMfI8ACgkQdSjSd0sB4dJhEACgq50Du0+QimGHuA1quzuWeBZ8
qFQAoLVbYW6uGIjMEqnKh9mCvT3ABQcV
=HxuL
-----END PGP SIGNATURE-----

--=-KYAPW1mjtSMvLkBUWoWu--
