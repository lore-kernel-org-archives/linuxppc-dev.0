Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2EAB1A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 17:04:31 +1000 (AEST)
Date: Mon, 1 Jun 2015 17:04:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 23/34] powerpc/iommu/powernv: Release replaced
 TCE
Message-ID: <20150601070449.GN22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-24-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Nj4mAaUCx+wbOcQD"
In-Reply-To: <1432889098-22924-24-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Nj4mAaUCx+wbOcQD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:47PM +1000, Alexey Kardashevskiy wrote:
> At the moment writing new TCE value to the IOMMU table fails with EBUSY
> if there is a valid entry already. However PAPR specification allows
> the guest to write new TCE value without clearing it first.
>=20
> Another problem this patch is addressing is the use of pool locks for
> external IOMMU users such as VFIO. The pool locks are to protect
> DMA page allocator rather than entries and since the host kernel does
> not control what pages are in use, there is no point in pool locks and
> exchange()+put_page(oldtce) is sufficient to avoid possible races.
>=20
> This adds an exchange() callback to iommu_table_ops which does the same
> thing as set() plus it returns replaced TCE and DMA direction so
> the caller can release the pages afterwards. The exchange() receives
> a physical address unlike set() which receives linear mapping address;
> and returns a physical address as the clear() does.
>=20
> This implements exchange() for P5IOC2/IODA/IODA2. This adds a requirement
> for a platform to have exchange() implemented in order to support VFIO.
>=20
> This replaces iommu_tce_build() and iommu_clear_tce() with
> a single iommu_tce_xchg().
>=20
> This makes sure that TCE permission bits are not set in TCE passed to
> IOMMU API as those are to be calculated by platform code from
> DMA direction.
>=20
> This moves SetPageDirty() to the IOMMU code to make it work for both
> VFIO ioctl interface in in-kernel TCE acceleration (when it becomes
> available later).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Nj4mAaUCx+wbOcQD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbAQRAAoJEGw4ysog2bOSyakQAOGhQZsx6QpTVVU1tKBNa6u/
kFF39uYlZJw1X1831dvLG6yWdFgdEfXfEXayNbdxkqeV0kCsbf5rqRzN49hoyS51
4cehmzvob8kcJBhRSh+TTpAIKcLq3lB6HO+CViGFeweiKnTVA3BuRxpZ75QdGzlg
OkcSCAZxemq1RVS4YedDtEtzRCjmqyEW7EDOlv6FHCOIGy4rv+CQGdU7GiS6A6g2
YjQjmrwo06okpYFF3FXYBuJ3Ts9UudP3+DzDTinSiY/HaRiW6uEpWzDjbjcnOltV
8sIfb/SjNHfW5Uj8nA0lMioeHzgnausxjK4RJOB/Dll59+z4I1KyaFKMwkVSWQNY
DKLuX8ifhd0F+byDvXJQipgmgptdH2vMExoCqkiFwLIcK3s2a5s3ArBH5rfvaPdN
d4D+Lt5FlKyC3O0VtnEZugjNhwwMfu+/O2wpmgtcNlB1VluSRvmsIlB18kJaGV5y
N+uyFlouELFn4dpW8p5TQifv9l/LPpJsnM72VhK7LAXyUE3wcExh9oLh4ZQMsX3s
inYD8k1pAQrOJThvOQsVNzqNvbX7j+7J64p5CiDwXOTKHTo7RndfAa3yLuK5V9Ra
xpYZl9PbeDBXPwwCcoV4WlM4lkH5qKAqRZHMqU/OioXvVE/XUerf90Yk5Aa3szSK
ccASEzchbx5ZKOxscUI1
=yvXx
-----END PGP SIGNATURE-----

--Nj4mAaUCx+wbOcQD--
