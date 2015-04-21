Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED4061A0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 17:28:55 +1000 (AEST)
Date: Tue, 21 Apr 2015 17:12:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 15/31] powerpc/iommu: Fix IOMMU ownership
 control functions
Message-ID: <20150421071233.GF31815@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-16-git-send-email-aik@ozlabs.ru>
 <20150416061049.GF3632@voom.redhat.com>
 <5530DD6D.8000001@ozlabs.ru> <20150420024638.GE10218@voom>
 <55349DF0.6090301@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
In-Reply-To: <55349DF0.6090301@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2015 at 04:34:24PM +1000, Alexey Kardashevskiy wrote:
> On 04/20/2015 12:46 PM, David Gibson wrote:
> >On Fri, Apr 17, 2015 at 08:16:13PM +1000, Alexey Kardashevskiy wrote:
> >>On 04/16/2015 04:10 PM, David Gibson wrote:
> >>>On Fri, Apr 10, 2015 at 04:30:57PM +1000, Alexey Kardashevskiy wrote:
> >>>>This adds missing locks in iommu_take_ownership()/
> >>>>iommu_release_ownership().
> >>>>
> >>>>This marks all pages busy in iommu_table::it_map in order to catch
> >>>>errors if there is an attempt to use this table while ownership over =
it
> >>>>is taken.
> >>>>
> >>>>This only clears TCE content if there is no page marked busy in it_ma=
p.
> >>>>Clearing must be done outside of the table locks as iommu_clear_tce()
> >>>>called from iommu_clear_tces_and_put_pages() does this.
> >>>>
> >>>>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>---
> >>>>Changes:
> >>>>v5:
> >>>>* do not store bit#0 value, it has to be set for zero-based table
> >>>>anyway
> >>>>* removed test_and_clear_bit
> >>>>---
> >>>>  arch/powerpc/kernel/iommu.c | 26 ++++++++++++++++++++++----
> >>>>  1 file changed, 22 insertions(+), 4 deletions(-)
> >>>>
> >>>>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> >>>>index 7d6089b..068fe4ff 100644
> >>>>--- a/arch/powerpc/kernel/iommu.c
> >>>>+++ b/arch/powerpc/kernel/iommu.c
> >>>>@@ -1052,17 +1052,28 @@ EXPORT_SYMBOL_GPL(iommu_tce_build);
> >>>>
> >>>>  static int iommu_table_take_ownership(struct iommu_table *tbl)
> >>>>  {
> >>>>-	unsigned long sz =3D (tbl->it_size + 7) >> 3;
> >>>>+	unsigned long flags, i, sz =3D (tbl->it_size + 7) >> 3;
> >>>>+	int ret =3D 0;
> >>>>+
> >>>>+	spin_lock_irqsave(&tbl->large_pool.lock, flags);
> >>>>+	for (i =3D 0; i < tbl->nr_pools; i++)
> >>>>+		spin_lock(&tbl->pools[i].lock);
> >>>>
> >>>>  	if (tbl->it_offset =3D=3D 0)
> >>>>  		clear_bit(0, tbl->it_map);
> >>>>
> >>>>  	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
> >>>>  		pr_err("iommu_tce: it_map is not empty");
> >>>>-		return -EBUSY;
> >>>>+		ret =3D -EBUSY;
> >>>>+		if (tbl->it_offset =3D=3D 0)
> >>>>+			set_bit(0, tbl->it_map);
> >>>
> >>>This really needs a comment.  Why on earth are you changing the it_map
> >>>on a failure case?
> >>
> >>
> >>Does this explain?
> >>
> >>/*
> >>  * The platform code reserves zero address in iommu_init_table().
> >>  * As we cleared busy bit for page @0 before using bitmap_empty(),
> >>  * we are restoring it now.
> >>  */
> >
> >Only partly.  What's it reserved for, and why do you know it was
> >always set on entry?
>=20
>=20
> Because it is only handled in this file and I can see it in the code. Or I
> did not understand the question here...

Sure, you can see it in the code, but you've been looking at this code
for months and years.  For anyone looking at this function who's not
familiar with the rest of the IOMMU code, a pointer to what's going on
here would be really helpful.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNfhhAAoJEGw4ysog2bOS0yYQAIJzLtMYffwoZS9Fafr8/61k
DEJ2uNXLXoFUxF5VS95EQpx/i11LqqjqtphbNQMcOFkUdQDiOj6LhoIcvqoLpcCJ
QZTv+x/Zft+Uja7V0/n6DEWfaJVMZpEHVLNVfBxDMUbnHuIQjGO0hD7og5HvBmA0
JK9KMQ9xEPdMbneBbS79WPfl3m8rLZTO/l0S7y5gXWyoojYv72nzKPcx4W3jT88O
TlSadMC5z/lSnnel8Js0fubqTS+Zl1B1/P4tGasWGOzcvfq3p5+3BSuw4JIVOR0S
04hHB8BRb+Hjt85L6ProIyBYcIp7W8bUnkPi0FzeJGtn/p8zt8YOOz88tjzVxoeU
KsF6Bn3aRihYvaRNIVMdbeqMZ0EPVaxc1du9rd0yMXVhmCTEcY5IOZO6otWV3b8s
pUN42P6Men0zvBtyo6bch9GgkunCuSSRkYksJ6vgfg/okTSQrQvtsGX5bcm2mg3W
li09uakOcHayMmV+VArmtxeWOzNtO3NXI9FLpqWLGRifq32pQO05Ja29vYOPKRxS
96c8lu0d01Cl5CyiMHTbVHy4Id0YBfy7ZXBktzY/2vJ7jASpqd4RTyOtsq6+sjt3
9SKellO7CxXQuQvkOK587FEAdaDR7Ncpp/b+Z3GY1htTkoDq6PUcAtA5Ca9N+Pvb
qtomuJ6BHS4capTg6vxv
=jdv/
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
