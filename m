Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Don't build arch/powerpc/sysdev/dcr.c for ARCH=ppc kernels
From: Michael Ellerman <michael@ellerman.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1191495405.3647.3.camel@localhost.localdomain>
References: <20071004044911.30154.23109.stgit@trillian.cg.shawcable.net>
	<1191495405.3647.3.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FRW9gtfMu6xgIDiUXmaQ"
Date: Fri, 05 Oct 2007 00:34:45 +1000
Message-Id: <1191508485.7014.7.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-FRW9gtfMu6xgIDiUXmaQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-10-04 at 05:56 -0500, Josh Boyer wrote:
> On Wed, 2007-10-03 at 22:50 -0600, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >=20
> > dcr.c is an arch/powerpc only thing.
> >=20
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >=20
> > Ben/Paulus,
> >=20
> > As far as I can tell this is correct.  Having sysdev/dcr.c in the arch/=
ppc
> > build spits out warnings.  Grep doesn't show anything in arch/ppc that
> > is using it.
>=20
> Sorry, no.  The ibm_emac driver uses it, which is arch/ppc.  (Yes, the
> old one.)
>=20
> If there are warnings, let's fix those up.  Perhaps Michael's recent
> patches in that area introduced something.

Hmm, I picked a good time to be away :)

I think it's OK. ibm_emac uses dcr_write() but it should always be using
the native one from dcr-native.h. So I think this patch is good.

Just another reason to get rid of arch/ppc :D

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-FRW9gtfMu6xgIDiUXmaQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBPoFdSjSd0sB4dIRAiydAJwLaHELKaBW5c5fwh0lb0IAwu0CugCfRhBX
3DSvdJ15Q10mwHLJvIPhEtE=
=yocq
-----END PGP SIGNATURE-----

--=-FRW9gtfMu6xgIDiUXmaQ--
