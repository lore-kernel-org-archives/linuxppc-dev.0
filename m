Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74A50DDFCA
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 12:14:15 +1000 (EST)
Subject: Re: + edac-cpc925-mc-platform-device-setup.patch added to -mm tree
From: Michael Ellerman <michael@ellerman.id.au>
To: qingtao.cao@windriver.com
In-Reply-To: <49E69098.6040903@windriver.com>
References: <200904152227.n3FMRmdm007192@imap1.linux-foundation.org>
	<98F905BD-B447-4FAA-A7FE-9FCD025A9079@kernel.crashing.org>
	<49E69098.6040903@windriver.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-IOh5kcnLTdwvwXHrDys5"
Date: Thu, 16 Apr 2009 12:14:14 +1000
Message-Id: <1239848054.6572.20.camel@localhost>
Mime-Version: 1.0
Cc: mm-commits@vger.kernel.org,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@gate.crashing.org>,
	Doug Thompson <norsk5@yahoo.com>, akpm@linux-foundation.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-IOh5kcnLTdwvwXHrDys5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-04-16 at 09:57 +0800, Harry Ciao wrote:
> Kumar Gala wrote:
> > On Apr 15, 2009, at 5:27 PM, akpm@linux-foundation.org wrote:
> >> arch/powerpc/kernel/prom_init.c      |   33 +++++++++++++
> >> arch/powerpc/platforms/maple/setup.c |   59 +++++++++++++++++++++++++
> >> 2 files changed, 92 insertions(+)
> >>
> >> diff -puN=20
> >> arch/powerpc/kernel/prom_init.c~edac-cpc925-mc-platform-device-setup=20
> >> arch/powerpc/kernel/prom_init.c
> >> ---=20
> >> a/arch/powerpc/kernel/prom_init.c~edac-cpc925-mc-platform-device-setup
> >> +++ a/arch/powerpc/kernel/prom_init.c
> >> @@ -1947,8 +1947,40 @@ static void __init fixup_device_tree_map
> >>     prom_setprop(isa, name, "ranges",
> >>             isa_ranges, sizeof(isa_ranges));
> >> }
> >> +
> >> +#define CPC925_MC_START        0xf8000000
> >> +#define CPC925_MC_LENGTH    0x1000000
> >> +/* The values for memory-controller don't have right number of cells =
*/
> >> +static void __init fixup_device_tree_maple_memory_controller(void)
> >> +{
> >
> > I don't see why this cant be part of the existing=20
> > fixup_device_tree_maple().
> >
> > I also find it odd we don't ensure we are running on a maple before we=20
> > apply this fixup.

> Hi Kumar,
>=20
> Thanks a lot for your concern.
>=20
> This newly added fixup for memory controller on Maple will be placed=20
> right after fixup_device_tree_maple(), both of them will be controlled=20
> by CONFIG_PPC_MAPLE, so there is no worry that it will be applied=20
> against anything other than Maple.

Hi Harry,

We regularly build a single kernel with multiple platforms enabled, so
just having it controlled by a CONFIG symbol is not sufficient. Someone
might build a kernel for MAPLE & PSERIES & ISERIES & CELL, so the maple
fixup needs to be careful it doesn't break the other platforms.

The existing maple fixup doesn't check if it's on a maple either, but it
is a bit more discerning about what it finds before it fixes things up.

Your code already checks that "reg" is 8 bytes long to start with, I
think if it also checks that #address-cells and #size-cells are =3D=3D 2,
then it's pretty safe. Because at that point we know we have a node with
the right name, the reg property has a known value, and reg is short WRT
#cells.

> Meanwhile, it aims at fixup bad cell numbers for the memory controller,=20
> whereas the original fixup_device_tree_maple() aiming at fixing up the=20
> ISA controller on HT channel, we'd better separate them in different=20
> function IMHO.

I think I agree it's better as a separate routine. We could have a
firmware that doesn't need the original maple fixup (and so exits from
that routine early) but does need this one.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-IOh5kcnLTdwvwXHrDys5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknmlHYACgkQdSjSd0sB4dIgDQCgrPdphnPBPtAzWl5TL5E76GfP
fDYAn2H26gwKK4LdIMSAf6XIthSQr4+8
=JAE/
-----END PGP SIGNATURE-----

--=-IOh5kcnLTdwvwXHrDys5--
