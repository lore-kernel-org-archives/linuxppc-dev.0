Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72B291A02D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 13:37:34 +1000 (AEST)
Date: Tue, 9 Jun 2015 12:36:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v12 17/34] powerpc/spapr: vfio: Switch from
 iommu_table to new iommu_table_group
Message-ID: <20150609023632.GA11000@voom.redhat.com>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
 <1433486126-23551-18-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <1433486126-23551-18-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2015 at 04:35:09PM +1000, Alexey Kardashevskiy wrote:
> So far one TCE table could only be used by one IOMMU group. However
> IODA2 hardware allows programming the same TCE table address to
> multiple PE allowing sharing tables.
>=20
> This replaces a single pointer to a group in a iommu_table struct
> with a linked list of groups which provides the way of invalidating
> TCE cache for every PE when an actual TCE table is updated. This adds pnv=
_pci_link_table_and_group() and pnv_pci_unlink_table_and_group() helpers to=
 manage the list. However without VFIO, it is still going
> to be a single IOMMU group per iommu_table.
>=20
> This changes iommu_add_device() to add a device to a first group
> from the group list of a table as it is only called from the platform
> init code or PCI bus notifier and at these moments there is only
> one group per table.
>=20
> This does not change TCE invalidation code to loop through all
> attached groups in order to simplify this patch and because
> it is not really needed in most cases. IODA2 is fixed in a later
> patch.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJVdlEwAAoJEGw4ysog2bOSLtkP91iljpnAadgepMxaeDxDAesu
Qz7bkm3zabt60YSjntFDCpNhuvRccoAMPIAQkDMI8EPVpLoPq4Moq0pT9sbFxgtT
W8AlrU/6md+WeQFaKXl99I1lbQ+f9zf6yntBjcU8TCBs616AYTt21I4ZN77/P616
q/36gGU/INBYiYB0v0RgEubgkZefIq8EztkGxnmDhGHQHEQNScyFtHyH8w0WfC44
dUKcUcNboA5kRQs+1gbiRy563J6Fp9DKAJVXJu2TCth+G0CwW+GZTxrp1HOZLFeU
sxNHHMe10BbOjNtaHVtuG+06LZj63sShfoHiZ9Zsf62K0kn+BqHQhGlL6ruPhnPh
PUiVDl0L/k0xZ4Ix7N7XfQsFR4Abf3DtcOAUDUDdg+kQsjcozANcUvdGsaHoXERp
/AWmMpeJIPcuvIlkODwxx/SzBdj5Z8XRB6u2q79UEHU7WpSIJdKXPhH9vZDnxF5Y
WFk739kjgK8Iikl6turP0w8geKf891YYrDYOpTUjQoXWY0nNa++k0XwoVRvsoTuL
Qvtgsk82/EnPf4TJo6Hhc/V9YxaDmstQDymqphi4hsX9S2mwKiy9rwMzbKqF700z
wyH6OJhIP8SW0D1jbjpgybkcJWPK1WoTWR/amhesYLaR6ivcRHj6BWCG64itVuPc
pHHsBEP4VhHui5G5OeA=
=vC9I
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
