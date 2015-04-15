Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC09B1A0B8D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 18:32:39 +1000 (AEST)
Date: Wed, 15 Apr 2015 17:17:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 09/31] powerpc/powernv: Do not set "read" flag
 if direction==DMA_NONE
Message-ID: <20150415071710.GK25040@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-10-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fLj60tP2PZ34xyqD"
In-Reply-To: <1428647473-11738-10-git-send-email-aik@ozlabs.ru>
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


--fLj60tP2PZ34xyqD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:51PM +1000, Alexey Kardashevskiy wrote:
> Normally a bitmap from the iommu_table is used to track what TCE entry
> is in use. Since we are going to use iommu_table without its locks and
> do xchg() instead, it becomes essential not to put bits which are not
> implied in the direction flag.

It's not clear to me from this why lack of locking implies the need to
not put extra bits in.

> This adds iommu_direction_to_tce_perm() (its counterpart is there already)
> and uses it for powernv's pnv_tce_build().
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I have no objection to the patch though, so

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fLj60tP2PZ34xyqD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLhB2AAoJEGw4ysog2bOScMsQAL2KUT/Uxo4QovRyJ9O8q1me
lKQxaXH6+VQwsX8/ODIPXMUSympjxlKV82JYkDOMgaZlXjamAUiqU3Tho72Ap89F
0e6RHGlt9+fU6shUiFj411hsOqvaa8WCbwdADddh/hSJAGkdQg9Tafv1en1mJ6P8
TgYmT0wjdVTmkCqAuZqq0l/r1X9X3LFh12GOEfqOGFnogE6Y84Y7fCg0UWPFrAWc
fmp6uJLOIyaHVK4rjYj8wzdcfA+RwAJAdEBVA8E4u8jTcVJxIonshs8mj1F9jfaH
utkEFWrR+tQodaYgo6dE11xiLRZDo5UGhBZsJgGucyagV+IjTN4xz1XfXT5kl5ut
yijvu7H2niJtrbe3a1tqspb4GygIk1TdhEOeYJHdzROKYOwZe1waAoVUbU+1ye2q
dvSr7aPi5l4i2ZVzThj8ScsAfIEEYopynJ3Rxwe70tFxN+/ijd7Ck1dsF2r4EqYY
vzo06FssC5YJMhsjCj8luwPOKCsbpFB6NE7KvZ4DSCznEoMNL5dBRLnSZ8gMhVo2
uzFBZIdAnLy5GfGf4X86nk80iNhQK5x4G9zsr34Ar816ypBEQqTvsmKfTFMMcSEy
QcizIkE1GYNLw6z1wpQP0L4IiFhbCCe+SK8leDSLEZPeDiRT2YCCwDLHLzbHpSUR
NoKQCS0gFyVJKPAwiYbG
=J9ey
-----END PGP SIGNATURE-----

--fLj60tP2PZ34xyqD--
