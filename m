Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Use of_get_next_child() in k2_sata_proc_info()
From: Michael Ellerman <michael@ellerman.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <471EE082.3090204@pobox.com>
References: <2576ec47fb43bd1f4464beb8b78adfa70bdde418.1193199877.git.michael@ellerman.id.au>
	<1193202117.2085.45.camel@pasglop>  <471EE082.3090204@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rYa/SfzmZeZtmKiGN+VT"
Date: Wed, 24 Oct 2007 16:23:29 +1000
Message-Id: <1193207009.8788.9.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-rYa/SfzmZeZtmKiGN+VT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 02:04 -0400, Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
> > On Wed, 2007-10-24 at 14:25 +1000, Michael Ellerman wrote:
> >> k2_sata_proc_info() uses its own hand-rolled loop to check a nodes
> >> children for a property, this is not safe WRT refcounting, so fix it
> >> to use of_get_next_child().
> >>
> >> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> >=20
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >=20
> > (Pending you test boot it on one of our G5s first !)
> >=20
> >> ---
> >>  drivers/ata/sata_svw.c |    5 ++++-
> >>  1 files changed, 4 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
> >> index 12d613c..64c3812 100644
> >> --- a/drivers/ata/sata_svw.c
> >> +++ b/drivers/ata/sata_svw.c
> >> @@ -289,7 +289,10 @@ static int k2_sata_proc_info(struct Scsi_Host *sh=
ost, char *page, char **start,
> >> =20
> >>  	/* Match it to a port node */
> >>  	index =3D (ap =3D=3D ap->host->ports[0]) ? 0 : 1;
> >> -	for (np =3D np->child; np !=3D NULL; np =3D np->sibling) {
> >> +
> >> +	for (np =3D of_get_next_child(np, NULL);
> >> +	     np !=3D NULL;
> >> +	     np =3D of_get_next_child(np, np)) {
> >>  		const u32 *reg =3D of_get_property(np, "reg", NULL);
>=20
> This sort of thing I would prefer to ACK (ACK!), and let it go upstream=20
> via the powerpc tree.

Sure thing, just ACK (ACK!) (ACK?) it, and I'll pester paulus to merge
it via his tree.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-rYa/SfzmZeZtmKiGN+VT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHHuThdSjSd0sB4dIRArsqAJsExrvztJg6m2CkkVFs4XbWGSkqGQCgizpn
Mu73jJuvFZIghSXfYq/jA9o=
=F4vC
-----END PGP SIGNATURE-----

--=-rYa/SfzmZeZtmKiGN+VT--
