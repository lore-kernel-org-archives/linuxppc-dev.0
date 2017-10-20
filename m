Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJ7Hc4JjczDqBc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 12:19:24 +1100 (AEDT)
Date: Fri, 20 Oct 2017 12:06:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Doug Ledford <dledford@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh@kernel.org>,
 Sahil Mehta <sahilmehta17@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] powerpc-pseries: Delete an unnecessary variable
 initialisation in iommu_pseries_alloc_group()
Message-ID: <20171020010624.GE13245@umbus>
References: <0d221be4-1402-0499-d95e-afa4a30e1f33@users.sourceforge.net>
 <9c71e3e0-8998-fd02-e3a3-ef219d82ee32@users.sourceforge.net>
 <20171019133718.5bdab33c@kitsune.suse.cz>
 <20171019125558.itidc4ejr6goadci@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
In-Reply-To: <20171019125558.itidc4ejr6goadci@mwanda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2017 at 03:55:59PM +0300, Dan Carpenter wrote:
> On Thu, Oct 19, 2017 at 01:37:18PM +0200, Michal Such=E1nek wrote:
> > Hello,
> >=20
> > On Wed, 18 Oct 2017 21:24:25 +0200
> > SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> >=20
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Wed, 18 Oct 2017 19:14:39 +0200
> > >=20
> > > The variable "table_group" will be set to an appropriate pointer.
> > > Thus omit the explicit initialisation at the beginning.
> > >=20
> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > ---
> > >  arch/powerpc/platforms/pseries/iommu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/powerpc/platforms/pseries/iommu.c
> > > b/arch/powerpc/platforms/pseries/iommu.c index
> > > b37d4fb20d1c..b6c12b8e3ace 100644 ---
> > > a/arch/powerpc/platforms/pseries/iommu.c +++
> > > b/arch/powerpc/platforms/pseries/iommu.c @@ -55,7 +55,7 @@
> > > =20
> > >  static struct iommu_table_group *iommu_pseries_alloc_group(int node)
> > >  {
> > > -	struct iommu_table_group *table_group =3D NULL;
> > > +	struct iommu_table_group *table_group;
> > >  	struct iommu_table *tbl =3D NULL;
> > >  	struct iommu_table_group_link *tgl =3D NULL;
> > > =20
> >=20
> > I think initializing pointers to NULL is generally a good idea.
> >=20
> > If there is no use of the variable before it is reinitialized by
> > allocation gcc is free to optimize out the variable and its initial
> > value.
> >=20
> > On the other hand, if the code is changed later and use of the variable
> > becomes possible you may crash (and get a gcc warning, too).
>=20
> No, it's the opposite. GCC doesn't warn about potential NULL
> dereferences, it warns about uninitialized variables.  By initializing
> it to a bogus value, you're deliberately disabling static analysis.
> We do see bugs where, if only people didn't initialize stuff to bogus
> values, then the bug would have been caught before it was merged.

Seconded, I've seen this a number of times.  I think this alone is a
reason not to initiaize locals if they don't require it.
=20
> You might imagine that static analysis tools would catch NULL
> dereferences but it's actually really really hard.  We used to have
> an __uninitialized_var() macro which was used to silence GCC false
> positives, but now we initialize the pointers to NULL instead.  So
> most of the code that you're dealing with is stuff that was marked as
> too hard for GCC to understand.  It's tricky.
>=20
> regards,
> dan carpenter
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnpTA4ACgkQbDjKyiDZ
s5IUBhAAre2LJMFXQcsT1gnSsguI/XIKrQbNdjeb32QNy/bcC0Nw3Dd9/zh3ShEA
e1jso2QWhzx0wqoU5NlxiAirmWn/LhnnlVbe6xqSKpvz3uaXj1M0zYP66Vf56dW0
/cTcdPKgeMdysYjIphE7Rd3RcgTe0kVN8f/MuUQcGU2w/5Hyh4jNVH7QgJ0Kbrky
58t7s2kB4C/N09uw2qpzNSdAcApaAbahz+v4nkg2rrRMoSrn6ceA0efKhYeQrHV8
F6IiSd6m8XUtl1CeEFzo2NIgIzLKRnzusixw0BcrtAWI9uinvRvtGDrvrXDJGrjb
prdlrPGM5yEHuiLrVz7gUMYjsFDmOu6hXndaVn5PuIekmDLBYRBmSKvCYYTwLfr0
khgQeOJ6Qw0jK1P6rWpNr+5Uai9QLgu0NPlP/srFpc0JYDqtvZTVDk/WBkjaAdtu
yX3LFgEMZC80xQuNxs4yqbSsafW5gWguuMCb0AFy6r8lyZ+sDsZFXsSL/94XBCfO
34xWO1zcCw3TIxccBgq3pLbldTFhtsUs9khwimVCgYdJWlbzIB+aIusncHIwR3SP
N+wvqIxdSWfcD7OVEVfsb9ZGjbVQcAf2gisjfs9WlZd9uGejLaJkKroQ0oSHzU/z
8btWf71fTM097ZB/mV7+TkGlyny5kDU86YnmX+VuyueAsy12iHA=
=WgZp
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
