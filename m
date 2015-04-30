Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CEA261A04B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 14:37:59 +1000 (AEST)
Date: Thu, 30 Apr 2015 14:32:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 21/32] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_set_window
Message-ID: <20150430043237.GG15238@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-22-git-send-email-aik@ozlabs.ru>
 <20150429044510.GR32589@voom.redhat.com>
 <5540A3C4.2040908@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
In-Reply-To: <5540A3C4.2040908@ozlabs.ru>
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


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2015 at 07:26:28PM +1000, Alexey Kardashevskiy wrote:
> On 04/29/2015 02:45 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:45PM +1000, Alexey Kardashevskiy wrote:
> >>This is a part of moving DMA window programming to an iommu_ops
> >>callback. pnv_pci_ioda2_set_window() takes an iommu_table_group as
> >>a first parameter (not pnv_ioda_pe) as it is going to be used as
> >>a callback for VFIO DDW code.
> >>
> >>This adds pnv_pci_ioda2_tvt_invalidate() to invalidate TVT as it is
> >>a good thing to do.
> >
> >What's the TVT and why is invalidating it a good thing?
>=20
>=20
> "TCE Validation Table". Yeah, I need to rephrase it. Will do.
>=20
>=20
> >Also, it looks like it didn't add it, just move it.
>=20
> Agrh. Lost it in rebases. Will fix.
>=20
>=20
> >>It does not have immediate effect now as the table
> >>is never recreated after reboot but it will in the following patches.
> >>
> >>This should cause no behavioural change.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >
> >Really?  I don't remember this one.
>=20
>=20
> Message-ID: <20150416064351.GK3632@voom.redhat.com>
> :)
>=20
> But I believe it did not have TVT stuff then so I should have removed your
> RB from here.

Yeah, that's probably why I didn't recognize it.

>=20
> >
> >>---
> >>Changes:
> >>v9:
> >>* initialize pe->table_group.tables[0] at the very end when
> >>tbl is fully initialized
> >>* moved pnv_pci_ioda2_tvt_invalidate() from earlier patch
> >>---
> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 67 ++++++++++++++++++++++=
+--------
> >>  1 file changed, 51 insertions(+), 16 deletions(-)
> >>
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index b9b3773..59baa15 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -1960,6 +1960,52 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv=
_phb *phb,
> >>  		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
> >>  }
> >>
> >>+static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_g=
roup,
> >>+		struct iommu_table *tbl)
> >>+{
> >>+	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_=
pe,
> >>+			table_group);
> >>+	struct pnv_phb *phb =3D pe->phb;
> >>+	int64_t rc;
> >>+	const __u64 start_addr =3D tbl->it_offset << tbl->it_page_shift;
> >>+	const __u64 win_size =3D tbl->it_size << tbl->it_page_shift;
> >>+
> >>+	pe_info(pe, "Setting up window at %llx..%llx "
> >>+			"pgsize=3D0x%x tablesize=3D0x%lx\n",
> >>+			start_addr, start_addr + win_size - 1,
> >>+			1UL << tbl->it_page_shift, tbl->it_size << 3);
> >>+
> >>+	tbl->it_table_group =3D &pe->table_group;
> >>+
> >>+	/*
> >>+	 * Map TCE table through TVT. The TVE index is the PE number
> >>+	 * shifted by 1 bit for 32-bits DMA space.
> >>+	 */
> >>+	rc =3D opal_pci_map_pe_dma_window(phb->opal_id,
> >>+			pe->pe_number,
> >>+			pe->pe_number << 1,
> >>+			1,
> >>+			__pa(tbl->it_base),
> >>+			tbl->it_size << 3,
> >>+			1ULL << tbl->it_page_shift);
> >>+	if (rc) {
> >>+		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
> >>+		goto fail;
> >>+	}
> >>+
> >>+	pnv_pci_ioda2_tvt_invalidate(pe);
> >>+
> >>+	/* Store fully initialized *tbl (may be external) in PE */
> >>+	pe->table_group.tables[0] =3D *tbl;
> >
> >Hrm, a non-atomic copy of a whole structure into the array.  Is that
> >really what you want?
>=20
>=20
> set_window is called from VFIO (protected by mutex there) and the platform
> code which I believe is not racy (or hotplug takes care of it anyway). Or=
 I
> am missing something else?

Sorry, I wasn't clear.  It's not that I actually think the copy is
going to race with anything now.

It's more that copying whole structures about is a rather odd way of
doing things, and makes it much less obvious how object lifetimes
interact.

=46rom what I've seen of the rest of the series it seems like the
following scheme would make more sense:

  * struct iommu_table has identical lifetime to the actual tables
    allocated under it.
      * So, the "create" function both allocates the header structure,
        all the actual TCE tables under it, and fills in the header
	with the details of same (size, levelsize, levels etc.)
  * table_group would have an array of pointers to iommu_table
    structs, rather than embedding an array of iommu_table structs
      * This pointers would be optionally populated
      * set_window function would populate the table_group array with
        a previously "create"ed iommu_table
      * unset window would clear the pointer, and unref the iommu_table
  * "free" and "reset" for a single table would be rolled back into a
     single function

Unless there's some reason I've missed that you want to embed the
whole array of iommu_table structs.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQbBlAAoJEGw4ysog2bOS0lEQAMmPOfrVl/oCRfWV1mKA0EEk
mySyWRFpbu9fFPME3wJRqjo4CmqG2TiEFSjmvxF9CX6YO/UKqmJU0qv0WSx4SpPP
ha1auw9m5740OYPU3xiZzGBiq+R0IOEcNZ6ETCY6q+tBVA/aBI1cUiPAHSHc9G9J
A7jtWCq0GduUH2vX7abwkq+kCvVZ8TXUhcZceOPUpm1nIfhwIc+vK/v7piNYDiLW
9avC1gf/bXeb3nNdmelI07zJDOVIsWJ99f3Rr/JL1ze0E4VI5tnkTk70fd3gDoAU
543O4ZG2vl63Q9/pBOpiDm9KsZts4F/zWYqi8yDZZX0OxBjHA8jfzxqeq76Cn9/z
1Orxu1P4ltXI2I7o3eIa3TVrHRIOWDfP6Ty8LQA3kSobDXT+7ZwPq2PVQzW6KQxy
gBt28Xt6x2lEvirvb6IYRGMmMpQOXu2YgPLvLqP4c+aKBUA9mS8ZnopKbY4WiMYd
WuQb9nP/k+lb7inSlL0vwLz1xVI70zqaYgfy0n6eykiIv9LVbnfLb4wxtvFhP5ll
tEn22CmSZclJVxVWdcaFQC9H0ui4egZDwJnVp3eqHv61+1x4hOggM7or+Es1Vl4F
fu9QURKoKq8Ma5IjXMH42arql7tlBApFHHUYLTUqFTUE7H+MPHgI8CruOKYLuYVl
447dZ+EKuAUWbRvS6UjE
=cKjm
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
