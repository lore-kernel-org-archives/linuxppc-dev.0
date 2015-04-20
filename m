Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41F781A2C26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 16:02:53 +1000 (AEST)
Date: Mon, 20 Apr 2015 12:51:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 21/31] powerpc/iommu: Split iommu_free_table
 into 2 helpers
Message-ID: <20150420025134.GG10218@voom>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-22-git-send-email-aik@ozlabs.ru>
 <20150416064637.GL3632@voom.redhat.com>
 <552FE363.2060604@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
In-Reply-To: <552FE363.2060604@ozlabs.ru>
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


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2015 at 02:29:23AM +1000, Alexey Kardashevskiy wrote:
> On 04/16/2015 04:46 PM, David Gibson wrote:
> >On Fri, Apr 10, 2015 at 04:31:03PM +1000, Alexey Kardashevskiy wrote:
> >>The iommu_free_table helper release memory it is using (the TCE table a=
nd
> >>@it_map) and release the iommu_table struct as well. We might not want
> >>the very last step as we store iommu_table in parent structures.
> >
> >Yeah, as I commented on the earlier patch, freeing the surrounding
> >group from a function taking just the individual table is wrong.
>=20
>=20
> This is iommu tables created by the old code which stores these iommu_tab=
le
> struct pointers in device nodes. I believe there is a plan to get rid of
> iommu tables there and when this is done, this workaround will be
> gone.

Um.. what?  The connection of where pointers are stored to an
obvious error with object lifetime handling is not at all obvious.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNGm2AAoJEGw4ysog2bOSgy0P+wTa+9uiYNniXuuyY3SGf4o5
aihcMph0Bhi/uAQUPaKGquTXhCWDbQGG01O2bUNmCk28D5O/TOHraBdedmBfkhfo
vxIVJa1Iv2HEG9VGjaKTDsmyrtILuGe0j67WdvFoTQL86lc6OF2m/aHImJq/i3gd
l7mEd0ufsYDOlWNHXada2H7A58SgBA6cRe++OE0f2uQAfiii9sx62NpdpZr3Lfaw
yg01gd/aQPXg+XuJnSUWmGNz75dZ8QOfWFTUIU5RGlNGyrKkTK5ZXWRg4RTK92Ot
gTml8fWCyEjrvQuS/pcJm6huw+leA0i7EsDhzq4VwXYcT7UzHmKpdiiOhbyDIIsz
eZOz/k2vnyU9B9OGvE823bRnrhwI1l4WWXRAai6dO5NJ0lqtOtEfbf82irvNabW4
NgxlYsCU0Edki5yRjVTmPMLJWSqq7sFPx9xT6myvsgJRLmy8C2ATOGfgKhZVlNJT
DH8sEX1WbKfAAAreTsGU2eKG7RK3MApBJNfwPHtJ6NbdXQTA1Kqr8pdIZ7ZTaYl+
dP56P5OsmY81ZYQ+wKhoOKwplQwa/lCjej5aE2QPrU/gFdxhKx3bVH+atFgSNPuu
To3wJEqb5OcYx0/AOCIhzo9DnxHR2eD0VbbCtH9iPcPhiTJ8heNrZd6IFKg95iRw
ZxA0Ix4ybtmGI0bE5fNl
=fW9N
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--
