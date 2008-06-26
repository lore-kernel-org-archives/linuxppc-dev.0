Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 05/14] powerpc: Add new code patching routines
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <19A4D5AE-DB7A-4139-88CD-26F1221A5271@kernel.crashing.org>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<58cb99151247b693ccb4ffd6f624cd2efddeea0e.1214271072.git.michael@ellerman.id.au>
	<19A4D5AE-DB7A-4139-88CD-26F1221A5271@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-yD7zRuET1vNNF3FhGrek"
Date: Thu, 26 Jun 2008 13:54:39 +1000
Message-Id: <1214452479.32022.17.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-yD7zRuET1vNNF3FhGrek
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-06-24 at 08:48 -0500, Kumar Gala wrote:
> On Jun 23, 2008, at 8:32 PM, Michael Ellerman wrote:
>=20
> > This commit adds some new routines for patching code, they will be =20
> > used
> > in a following commit.
> >
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> > arch/powerpc/lib/code-patching.c    |  107 ++++++++++++++++++++++++++=20
> > +++++++++
> > include/asm-powerpc/code-patching.h |    8 +++
> > 2 files changed, 115 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/=20
> > code-patching.c
> > index 430f4c1..27957c4 100644
> > --- a/arch/powerpc/lib/code-patching.c
> > +++ b/arch/powerpc/lib/code-patching.c
> > @@ -41,3 +41,110 @@ unsigned int create_branch(const unsigned int =20
> > *addr,
> >
> > 	return instruction;
> > }
> > +
> > +unsigned int create_cond_branch(const unsigned int *addr,
> > +				unsigned long target, int flags)
> > +{
>=20
> it would be nice to have some idea what flags is suppose to be.

Yeah this routine is a bit of kludge, it's really only written for
translate_branch(). As it is, flags just takes any of the bits in a
conditional branch that aren't the opcode or target.

To fully synthesise a conditional branch by hand you'd probably want
another routine which constructs the BO & BI fields for you.

> > +unsigned int translate_branch(const unsigned int *dest, const =20
> > unsigned int *src)
> > +{
>=20
> I'm not sure I get what this function is trying to do.

It takes a relative branch at src and returns a new branch of the same
type that could be placed at dest, and would jump to the same target as
the original instruction. I guess I should add some doco :)

> > +	unsigned long target;
> > +
> > +	target =3D branch_target(src);
> > +
> > +	if (instr_is_branch_iform(*src))
> > +		return create_branch(dest, target, *src);
> > +	else if (instr_is_branch_bform(*src))
> > +		return create_cond_branch(dest, target, *src);
> > +
> > +	return 0;
> > +}

=EF=BB=BFcheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-yD7zRuET1vNNF3FhGrek
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIYxL/dSjSd0sB4dIRAu5mAKC7HSgI6XNtg5Ly6sV80kGg66gHQACeNdUS
w0hTior2PcUJw/D18Vlbfnk=
=U6lF
-----END PGP SIGNATURE-----

--=-yD7zRuET1vNNF3FhGrek--
