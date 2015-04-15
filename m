Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B05801A0B8E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 16:10:09 +1000 (AEST)
Date: Wed, 15 Apr 2015 13:56:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 01/31] vfio: powerpc/spapr: Move page pinning
 from arch code to VFIO IOMMU driver
Message-ID: <20150415035625.GC25040@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
In-Reply-To: <1428647473-11738-2-git-send-email-aik@ozlabs.ru>
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


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:43PM +1000, Alexey Kardashevskiy wrote:
> This moves page pinning (get_user_pages_fast()/put_page()) code out of
> the platform IOMMU code and puts it to VFIO IOMMU driver where it belongs
> to as the platform code does not deal with page pinning.
>=20
> This makes iommu_take_ownership()/iommu_release_ownership() deal with
> the IOMMU table bitmap only.
>=20
> This removes page unpinning from iommu_take_ownership() as the actual
> TCE table might contain garbage and doing put_page() on it is undefined
> behaviour.
>=20
> Besides the last part, the rest of the patch is mechanical.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLeFpAAoJEGw4ysog2bOS3qoQANL8sRRY6PrThqDs1zQS0QRb
YRt+4bR1w0WWVG2dLMymNKE5twedOB5IFmhlHzZd3ptx8c0epkdLDQyd+V+ReFuB
DeZCyx67vkrMkGNxouXkvN8L7J52ILJhmTIYodpaDrFzDzUEiMLMyalQxElsN4QH
E/a4Q5ACPkBYaAWequGAGDnzC6USyT2CesyxkEwQXXenpvHg9xXqBVzkDMLG1o76
8GyT4ZKWkUmFF0CcPjI3iApqhE8tcQHkeNdgZl0HsXg4R/RGP5eqOS3QejWxgVGF
OA/0+E8+7X8rMcacSA8Q025HFb0+9S/b15JqwOye6Pg5lqSizIi8VeCrGXSPE839
aKOORSABRl/j577p0MmR9I+o4yjICWB74OgZ8l/2ISVLu1Vy9Sw/E7Opkec7svsY
ziQNktvBFl1rD5Spe65nKwMxM8R1RSqhShGimm5C8R8IMZYvey4cgJuGzj2KlE+P
c5wvZB3GBU8EIZ9dVr9SC8Rs2SgZ2/f9NiB4ZzbN/sRMVkIz9AFiOiX11vvS147o
XpksesI1zCOq/cW/P5t0U+Mpc6Gp/pJbucfCk238sqxCONLpe93lv7dfT/uLL3Je
FVYuTfRD6Kl0aRS75gPBXzsNBlSKssHW/XjynxD7GITSFwYTj/4Xcp55h8Y4KMeL
Ts9+wUaGDy0J3aBm7oLa
=+LTt
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
