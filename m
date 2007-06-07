Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
From: Michael Ellerman <michael@ellerman.id.au>
To: Jean-Christophe Dubois <jdubois@mc.com>
In-Reply-To: <200706050900.54022.jdubois@mc.com>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
	<200706050900.54022.jdubois@mc.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Umr/rBnaJMNMOZvUl9Fi"
Date: Thu, 07 Jun 2007 17:58:59 +1000
Message-Id: <1181203139.4166.26.camel@concordia.ozlabs.ibm.com>
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


--=-Umr/rBnaJMNMOZvUl9Fi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-06-05 at 09:00 +0200, Jean-Christophe Dubois wrote:
> On Monday 04 June 2007 15:00:05 Michael Ellerman wrote:
> > +       pr_debug("axon_msi: initialising ...\n");
> > +
> > +       for_each_compatible_node(node, NULL, "ibm,axon-msic") {
> > +               if (axon_msi_setup_one(of_node_get(node)) =3D=3D 0)
> > +                       found++;
> > +       }
> > +       of_node_put(node);
>=20
> 2 comments:
>=20
> 1) There is no "ibm,axon-msic" compatible property in the SLOF tree provi=
ded=20
> by IBM on the CAB (or other such platforms). Therefore this code will not=
=20
> work on these platforms.

It's not clear to me if MSIs will work on CAB, with Axon in end-point
mode. But it'd be good to try it at some point.

The compatible property is new, it's only just been added to SLOF
recently by Heiko, not sure when it will be in released firmware.

> 2) you should somehow check for the Axon version. Axon 1.1 (and prior) ar=
e=20
> know to be loosing MSI/MBX interrupts (but not the data part associated t=
o=20
> them). Therefore this should be enabled only on Axon 2.1 (or later).

Yep. It works some of the time on 1.1, but not enough to enable it.

I guess I'd say firmware that runs on 1.1 should just not export the msi
nodes, or not put the compatible property on them - rather than having
the kernel explicitly checking for the version.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Umr/rBnaJMNMOZvUl9Fi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGZ7rDdSjSd0sB4dIRAhlSAKCXJquXN6cusvL8slkIPl/bxDCvWQCgyRZl
aji4k1n4nFhQ/I0+1FwkbZM=
=iilH
-----END PGP SIGNATURE-----

--=-Umr/rBnaJMNMOZvUl9Fi--
