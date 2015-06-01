Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AC9B1A0C2A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 16:49:08 +1000 (AEST)
Date: Mon, 1 Jun 2015 16:47:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 20/34] powerpc/powernv/ioda2: Move TCE kill
 register address to PE
Message-ID: <20150601064714.GL22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-21-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="x1F0m3RQhDZyj8sd"
In-Reply-To: <1432889098-22924-21-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--x1F0m3RQhDZyj8sd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:44PM +1000, Alexey Kardashevskiy wrote:
> At the moment the DMA setup code looks for the "ibm,opal-tce-kill"
> property which contains the TCE kill register address. Writing to
> this register invalidates TCE cache on IODA/IODA2 hub.
>=20
> This moves the register address from iommu_table to pnv_pnb as this
> register belongs to PHB and invalidates TCE cache for all tables of
> all attached PEs.
>=20
> This moves the property reading/remapping code to a helper which is
> called when DMA is being configured for PE and which does DMA setup
> for both IODA1 and IODA2.
>=20
> This adds a new pnv_pci_ioda2_tce_invalidate_entire() helper which
> invalidates cache for the entire table. It should be called after
> every call to opal_pci_map_pe_dma_window(). It was not required before
> because there was just a single TCE table and 64bit DMA was handled via
> bypass window (which has no table so no cache was used) but this is going
> to change with Dynamic DMA windows (DDW).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--x1F0m3RQhDZyj8sd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVa//yAAoJEGw4ysog2bOScmkQAKVpRAemabng+bhle8Fjqf3v
MuqQZBswjCr4TmA6SivWD2EwpNKgOzR9n2uEkNHsZqtO2/LndLjSkdWorsJiadD/
HunROyKGtYO9cEnXWOmu3+NeIoILvZgyIh0ybkqZL8b9/uvZoZVNDfOk21o2quhK
gUHbFaLoaa2qI6dgc0v2WmYkdC4AWXiHdvyxfyPvaXbC96NxiKJwDwSMuDX0Ud4E
XY6LL0lR4rKF/ckNeo6V1axlcbhdYL9qP1NH5X4AMyfTmnsULFeYMxHksgRcqKEy
9YghH6c4k5zmYOKvXK7Ea3EcPOEk91kS/cg5gprlWMn/4fp4iJQ/xORIgY9HCbEN
5b7SljwhuEyesycM5vXQjQ8uIz8W0oX79hIo/L474Y6jJOWpdkAn0gZLFU0KeyxP
x89NWiRyrX8LxaLKlysF1AmGnQZEklvOR6NUbegsmIc0bEGr482b4RfwaYwanpAI
eiTA5qXOv3C1P9XTv0O7BKkKmwlochg4AibBY17TfJrrWP6g8xRwvR863o2+c6Oo
Ut7CBbDceE0Xw5sMVxDFzC2W9M1aOCPWdGQVR3M73rQerjUY4oujWXSgtS+lkGKs
5ThJa1PD3MSKnSQ3NDIbnboS48xIxYpRGyL6W2K7E8JAWbgjX517sUOAxL6vopf2
l+4o33Lr5k+sGPeyNUpF
=6W4h
-----END PGP SIGNATURE-----

--x1F0m3RQhDZyj8sd--
