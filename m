Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/6] Move code patching code into
	arch/powerpc/lib/code-patching.c
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5A31B777-6591-4AE9-BDE5-3B624AED10A4@kernel.crashing.org>
References: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
	<5A31B777-6591-4AE9-BDE5-3B624AED10A4@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-plUDGOoTUkhFr8BXywHz"
Date: Thu, 19 Jun 2008 16:55:13 +1000
Message-Id: <1213858514.25483.1.camel@localhost>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-plUDGOoTUkhFr8BXywHz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-06-19 at 01:15 -0500, Kumar Gala wrote:
> On May 29, 2008, at 1:20 AM, Michael Ellerman wrote:
>=20
> > We currently have a few routines for patching code in asm/system.h, =20
> > because
> > they didn't fit anywhere else. I'd like to clean them up a little =20
> > and add
> > some more, so first move them into a dedicated C file - they don't =20
> > need to
> > be inlined.
> >
> > While we're moving the code, drop create_function_call(), it's =20
> > intended
> > caller never got merged and will be replaced in future with something
> > different.
> >
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> > arch/powerpc/kernel/crash_dump.c          |    1 +
> > arch/powerpc/lib/Makefile                 |    2 +
> > arch/powerpc/lib/code-patching.c          |   33 ++++++++++++++++++++
> > arch/powerpc/platforms/86xx/mpc86xx_smp.c |    1 +
> > arch/powerpc/platforms/powermac/smp.c     |    1 +
> > include/asm-powerpc/code-patching.h       |   25 +++++++++++++++
> > include/asm-powerpc/system.h              |   48 =20
> > -----------------------------
> > 7 files changed, 63 insertions(+), 48 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/crash_dum
>=20
> what's the state of these patches and getting them into powerpc-next?

I think what I posted is reasonably solid, I've added some more routines
for the stuff I'm working on. I'll repost today or tommorrow.

> I'm looking at some runtime fix ups that I was thinking of basing on =20
> this code.

What have you got in mind? I'm working on some runtime fixups too :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-plUDGOoTUkhFr8BXywHz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIWgLRdSjSd0sB4dIRAlGNAKC1E8fJretXGbg8Y/donve3+tT5wgCcC056
LKcFqmte0lyI/v209xzFkLg=
=lfsO
-----END PGP SIGNATURE-----

--=-plUDGOoTUkhFr8BXywHz--
