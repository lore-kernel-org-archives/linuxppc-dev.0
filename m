Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C29871A0CCA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 13:26:04 +1000 (AEST)
Date: Wed, 29 Apr 2015 12:49:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 12/32] powerpc/spapr: vfio: Switch from
 iommu_table to new iommu_table_group
Message-ID: <20150429024959.GI32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-13-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
In-Reply-To: <1429964096-11524-13-git-send-email-aik@ozlabs.ru>
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


--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:36PM +1000, Alexey Kardashevskiy wrote:
> Modern IBM POWERPC systems support multiple (currently two) TCE tables
> per IOMMU group (a.k.a. PE). This adds a iommu_table_group container
> for TCE tables. Right now just one table is supported.
>=20
> For P5IOC2 and IODA, iommu_table_group is embedded into PE struct
> (pnv_ioda_pe and pnv_phb) and does not require iommu_free_table(), only .
> iommu_reset_table().
>=20
> For pSeries, this replaces multiple calls of kzalloc_node() with a new
> iommu_pseries_group_alloc() helper and stores the table group struct
> pointer into the pci_dn struct. For release, a iommu_table_group_free()
> helper is added.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

I'm not particularly fond of the "table_group" name, but I can't
really think of a better name for now.  So,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQEbXAAoJEGw4ysog2bOS2akP/iFfQm6Qod3xpH1CnJuHScai
ZiYxrO9tXPxql5VYk57D7vd6j9bfgjsKsypSSuWv0/5GPGYmIVFerZCwYmPKFgmP
bWF+4rX4t/BXIxmIIsTPb228nm+GPyr96+oJNEwoIPPBOXaY+NrO4sOM3Mk9wF+F
yq0Ujba5yR2sLrQrDLHZsKqbxDwKPe3EDc824q9aGMO4eFQfmtpAI+ZsHsjTKBen
VTaPM8yflqYpL9J2pH/nK9dNkAHHqZnIWuKPcf03uZTEJmQRFpnto2Q2sHbDxvG7
qT0dFqNJmi1nxh4T3V6k45WANElV7Gc/c033A7sWiNfjV+PxE0NEyEedl96Rhd5R
8uKhiz7Khtpb9jRLETfLGODj76GCDvBiYeio9/EyiarWAu/eSuTBVrODxexcDl+p
sajZ7jJ0QRgZfzzwMiCVzC/LNEzYBoUR+r4JY2ny4Ci03iDD8gQcIba7wLLXZ6TJ
3l21gNKSuhhB1L0WPu8qVK5u9lUubz/IfF0lWqGEyj0JlR7kLUuRyM1GZWLG8atY
oBW+R7eWoASiWL171uITcJZ9zLWxMswnA3SOymK2CD98veWTcbFaG5Uye6B8PNdi
e4SxtOlYcyB3ddjSPIkINgFH3IRKQHW5uo7pJUAhZLLPz1n+j6icnpubS/jI2c6P
4k2HLIth7dJQf8ovd0El
=nBpN
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--
