Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3AD21A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 15:47:25 +1000 (AEST)
Date: Mon, 1 Jun 2015 15:11:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 16/34] powerpc/spapr: vfio: Replace
 iommu_table with iommu_table_group
Message-ID: <20150601051129.GI22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-17-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
In-Reply-To: <1432889098-22924-17-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:40PM +1000, Alexey Kardashevskiy wrote:
> Modern IBM POWERPC systems support multiple (currently two) TCE tables
> per IOMMU group (a.k.a. PE). This adds a iommu_table_group container
> for TCE tables. Right now just one table is supported.
>=20
> This defines iommu_table_group struct which stores pointers to
> iommu_group and iommu_table(s). This replaces iommu_table with
> iommu_table_group where iommu_table was used to identify a group:
> - iommu_register_group();
> - iommudata of generic iommu_group;
>=20
> This removes @data from iommu_table as it_table_group provides
> same access to pnv_ioda_pe.
>=20
> For IODA, instead of embedding iommu_table, the new iommu_table_group
> keeps pointers to those. The iommu_table structs are allocated
> dynamically.
>=20
> For P5IOC2, both iommu_table_group and iommu_table are embedded into
> PE struct. As there is no EEH and SRIOV support for P5IOC2,
> iommu_free_table() should not be called on iommu_table struct pointers
> so we can keep it embedded in pnv_phb::p5ioc2.
>=20
> For pSeries, this replaces multiple calls of kzalloc_node() with a new
> iommu_pseries_alloc_group() helper and stores the table group struct
> pointer into the pci_dn struct. For release, a iommu_table_free_group()
> helper is added.
>=20
> This moves iommu_table struct allocation from SR-IOV code to
> the generic DMA initialization code in pnv_pci_ioda_setup_dma_pe and
> pnv_pci_ioda2_setup_dma_pe as this is where DMA is actually initialized.
> This change is here because those lines had to be changed anyway.
>=20
> This should cause no behavioural change.
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

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVa+mBAAoJEGw4ysog2bOSCTUP/AuuxYTp3wrxDsi7t1sIRi63
uaet5Qf4RFmHFf+27Fxl9uxMcsukzJ+W3KOOCp5aNMhf7I6JjHO7zS9gUfKCn7zQ
fvASG7HOc9TM6ecLzc2JLYVL5wsps496Pvo7gmE5xEP/mv8+xlt9urjbTq5AYsTB
wYyaVAzEfEmGEq+0EiCIZYbW5/jmbTkdVA1jdJE2eKJeAJdfgjBOZjILg0TPjRMd
KzGiq6hU0wwSSE5qs0QniYuqRfo+a/ceAq5khvmnbAPhNzmen2RMYp2UzS66JnxW
VEU5Cv7duZlzIJwCkdEedOL25CI6patfnGUmuMo6BsG6p6m9rMmY7zGdT+Ymz6jW
wmH285AL0w4+JpRBAgsZNiUY9ipV6g3Rrhd28Knyod9XwuACQ5XDfaUzbK+gIofn
sddBAk/613Bvp6cbTdBieYINMog/Rk1iHCZN/hbagcAGTkktnswZBBAosQsbL71c
knR9hkEH7BeqMWMMC0jfC0J+lTbPwHv8iFhGJuPHj6C5a9pXMWY+FskTptxPFsrv
HeMmUvcti39vmpTRlMKgYCbEeAdGdM0pzKgZucRqCzTvxm4qHZyd67lEPxPtwpcX
UmIX+dDfJBiAUHtGOSvhJVc9TH1uq24QJfWa39ki4GhMKU37n7UCV6JOa//3o0NK
2hLJlKO2VHHHoHmy21u5
=ht7D
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--
