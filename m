Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D67181A0CD3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 13:26:04 +1000 (AEST)
Date: Wed, 29 Apr 2015 12:14:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 08/32] vfio: powerpc/spapr: Moving
 pinning/unpinning to helpers
Message-ID: <20150429021403.GG32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-9-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
In-Reply-To: <1429964096-11524-9-git-send-email-aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:32PM +1000, Alexey Kardashevskiy wrote:
> This is a pretty mechanical patch to make next patches simpler.
>=20
> New tce_iommu_unuse_page() helper does put_page() now but it might skip
> that after the memory registering patch applied.
>=20
> As we are here, this removes unnecessary checks for a value returned
> by pfn_to_page() as it cannot possibly return NULL.
>=20
> This moves tce_iommu_disable() later to let tce_iommu_clear() know if
> the container has been enabled because if it has not been, then
> put_page() must not be called on TCEs from the TCE table. This situation
> is not yet possible but it will after KVM acceleration patchset is
> applied.
>=20
> This changes code to work with physical addresses rather than linear
> mapping addresses for better code readability. Following patches will
> add an xchg() callback for an IOMMU table which will accept/return
> physical addresses (unlike current tce_build()) which will eliminate
> redundant conversions.
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

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQD5rAAoJEGw4ysog2bOSTGcP/jFZBLEMaDST9qBuxdE8Fb6y
Zl5/TmUWX4Cs6yVMuu3+7AuQpGWeanNOauEv9o4O4BnRv/mykLVgrZ70qbfOnad0
PcTt0m3BjkrXT6/tILD6+xktFDmmpOnjDTV6klKkCaSrKc9/UEAkx9SjgOLmFqjq
qNORcMWgcOx48MHK2V4Pp6cy+G8YRKHcS6VxVHdCykNkOWdWSuRpB2ZQh7VMDmVn
bKVgjXJEVs9/9DhtVm3m2sxtWSIVzRI+fEuEJg974iwlismRL45qL4yqOsVy1Qnx
JaCJYWPLV+9QI4qP60WP9C/GHy7y2gkOiWrl7hyIXb7nnVms0X+QQA8k58LIqsNv
50lyCgMAhlc1UUQSPnQ4z6oGPJWnuGT7FktNhTw41Ox7mU+fD83lXvh5WIZG6Usa
DT64NFuisSbapleoCW1AOd9V8NDtnhASZQrDIbwnMD3T2YntYLUaifSvXxbFM4G1
/zMZPHdzAsSZ4/8TJCkZVnztbNgpBuxgkiqRW+D6s87P+JvJRzYlbOkhq4RbIzIZ
1oyxyDus6lfTV8zYu2hTryZ0oFcWq5Mdr0re+LRnKYpqNlOczAIxt8kHj7Ef0ioW
dFf5CPFB/Ri2EIG386uNHAWoXE7DVa+522dWhtIm9+XrivpK+Djd1bkfrsRjSWeH
XEenY0PMMnbaRCm9niDl
=wyZS
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
