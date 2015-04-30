Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B3301A05E6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 14:37:59 +1000 (AEST)
Date: Thu, 30 Apr 2015 14:24:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 20/32] powerpc/powernv/ioda2: Introduce
 pnv_pci_create_table/pnv_pci_free_table
Message-ID: <20150430042407.GF15238@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-21-git-send-email-aik@ozlabs.ru>
 <20150429043949.GQ32589@voom.redhat.com>
 <5540A085.8080606@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
In-Reply-To: <5540A085.8080606@ozlabs.ru>
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


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2015 at 07:12:37PM +1000, Alexey Kardashevskiy wrote:
> On 04/29/2015 02:39 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:44PM +1000, Alexey Kardashevskiy wrote:
> >>This is a part of moving TCE table allocation into an iommu_ops
> >>callback to support multiple IOMMU groups per one VFIO container.
> >>
> >>This moves a table creation window to the file with common powernv-pci
> >>helpers as it does not do anything IODA2-specific.
> >>
> >>This adds pnv_pci_free_table() helper to release the actual TCE table.
> >>
> >>This enforces window size to be a power of two.
> >>
> >>This should cause no behavioural change.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>---
> >>Changes:
> >>v9:
> >>* moved helpers to the common powernv pci.c file from pci-ioda.c
> >>* moved bits from pnv_pci_create_table() to pnv_alloc_tce_table_pages()
> >>---
> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 36 ++++++------------
> >>  arch/powerpc/platforms/powernv/pci.c      | 61 ++++++++++++++++++++++=
+++++++++
> >>  arch/powerpc/platforms/powernv/pci.h      |  4 ++
> >>  3 files changed, 76 insertions(+), 25 deletions(-)
> >>
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index a80be34..b9b3773 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -1307,8 +1307,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct p=
ci_dev *dev, struct pnv_ioda_pe
> >>  	if (rc)
> >>  		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
> >>
> >>-	iommu_reset_table(tbl, of_node_full_name(dev->dev.of_node));
> >>-	free_pages(addr, get_order(TCE32_TABLE_SIZE));
> >>+	pnv_pci_free_table(tbl);
> >>  }
> >>
> >>  static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
> >>@@ -2039,10 +2038,7 @@ static struct iommu_table_group_ops pnv_pci_ioda=
2_ops =3D {
> >>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> >>  				       struct pnv_ioda_pe *pe)
> >>  {
> >>-	struct page *tce_mem =3D NULL;
> >>-	void *addr;
> >>  	struct iommu_table *tbl =3D &pe->table_group.tables[0];
> >>-	unsigned int tce_table_size, end;
> >>  	int64_t rc;
> >>
> >>  	/* We shouldn't already have a 32-bit DMA associated */
> >>@@ -2053,29 +2049,20 @@ static void pnv_pci_ioda2_setup_dma_pe(struct p=
nv_phb *phb,
> >>
> >>  	/* The PE will reserve all possible 32-bits space */
> >>  	pe->tce32_seg =3D 0;
> >>-	end =3D (1 << ilog2(phb->ioda.m32_pci_base));
> >>-	tce_table_size =3D (end / 0x1000) * 8;
> >>  	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
> >>-		end);
> >>+		phb->ioda.m32_pci_base);
> >>
> >>-	/* Allocate TCE table */
> >>-	tce_mem =3D alloc_pages_node(phb->hose->node, GFP_KERNEL,
> >>-				   get_order(tce_table_size));
> >>-	if (!tce_mem) {
> >>-		pe_err(pe, "Failed to allocate a 32-bit TCE memory\n");
> >>-		goto fail;
> >>+	rc =3D pnv_pci_create_table(&pe->table_group, pe->phb->hose->node,
> >>+			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base, tbl);
> >>+	if (rc) {
> >>+		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
> >>+		return;
> >>  	}
> >>-	addr =3D page_address(tce_mem);
> >>-	memset(addr, 0, tce_table_size);
> >>-
> >>-	/* Setup iommu */
> >>-	tbl->it_table_group =3D &pe->table_group;
> >>-
> >>-	/* Setup linux iommu table */
> >>-	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
> >>-			IOMMU_PAGE_SHIFT_4K);
> >>
> >>  	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
> >>+
> >>+	/* Setup iommu */
> >>+	tbl->it_table_group =3D &pe->table_group;
> >>  	iommu_init_table(tbl, phb->hose->node);
> >>  #ifdef CONFIG_IOMMU_API
> >>  	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
> >>@@ -2121,8 +2108,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
> >>  fail:
> >>  	if (pe->tce32_seg >=3D 0)
> >>  		pe->tce32_seg =3D -1;
> >>-	if (tce_mem)
> >>-		__free_pages(tce_mem, get_order(tce_table_size));
> >>+	pnv_pci_free_table(tbl);
> >>  }
> >>
> >>  static void pnv_ioda_setup_dma(struct pnv_phb *phb)
> >>diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platfo=
rms/powernv/pci.c
> >>index e8802ac..6bcfad5 100644
> >>--- a/arch/powerpc/platforms/powernv/pci.c
> >>+++ b/arch/powerpc/platforms/powernv/pci.c
> >>@@ -20,7 +20,9 @@
> >>  #include <linux/io.h>
> >>  #include <linux/msi.h>
> >>  #include <linux/iommu.h>
> >>+#include <linux/memblock.h>
> >>
> >>+#include <asm/mmzone.h>
> >>  #include <asm/sections.h>
> >>  #include <asm/io.h>
> >>  #include <asm/prom.h>
> >>@@ -645,6 +647,65 @@ void pnv_pci_setup_iommu_table(struct iommu_table =
*tbl,
> >>  	tbl->it_type =3D TCE_PCI;
> >>  }
> >>
> >>+static __be64 *pnv_alloc_tce_table_pages(int nid, unsigned shift,
> >>+		unsigned long *tce_table_allocated)
> >
> >I'm a bit confused by the tce_table_allocated parameter.  What's the
> >circumstance where more memory is requested than required, and why
> >does it matter to the caller?
>=20
> It does not make much sense here but it does for "powerpc/powernv: Implem=
ent
> multilevel TCE tables" - I was trying to avoid changing same lines many
> times.
>=20
> The idea is if multilevel table is requested, I do not really want to
> allocate the whole tree. For example, if the userspace asked for 64K table
> and 5 levels, the result will be a list of just 5 pages - last one will be
> the actual table and upper levels will have a single valud TCE entry
> pointing to next level.
>=20
> But I change the prototype there anyway so I'll just move this
> tce_table_allocated thing there.

Yeah, I think that's better.  It is more churn, but I think the
clearer reviewability is worth it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQa5nAAoJEGw4ysog2bOScr0P/jakUXLDF38mYuHHFKfMM+P7
Yc/gZYT0WrZTJ+kFzRr017My0syIaImNYBCMrPy+7dX/N5ipHhVF4kWQrwzcUoIY
iUmhyFu9om0uOxlB/hgmQMXlgj9zj3OtXX3kz6g3D0qNWR7mNE5LUgPV4Ac4VZz6
yzKl2t2a9d53d/aU6jaCSqvXC4cEfEsEYMBDu0/0s1wLoZMygakSLYmp/Z0NSbqZ
VBCjaMkK1eqIp1PQL5YLzVrP+8Tf9OR4koAJ5Kt4K5HS1kXqEgiYoi3mQVi+y+Qu
BEOkp9EsaC1qY/rBoGY0G5Y4/nwIdD2RwOX2zPM8kTpUyJDi3VmS5S4WllJnse+R
GZk+UNhNJUUhc5zIA3Svo3u6RYnxYooaTMifpSRta2OgtVShdNieC68GFafysn8I
rCsu/8TmGebOo/5iJl8J+GhVyyG5tKx1Ld+/BPHIZVNJsb+r/b0lYX+uRkTdaBws
br6mUaSS9SQUe6V3GSyM/VLqWRjZxZoxX/uV0jCB4xhP4oOQ5tRB8vDcQvBHffIb
Tuy0Jv/U3aT9pU4WJ/QyX88WyG511/5/p4v3+SsrHdig2wDPmuAqkoYqFhGYAS12
xCrMQJ8rUS4Ueqv09SHNl8dH0QWGQIl7d82Wji7CimQExN/YxX0pPuWTf27l8ABZ
7n9wfW0C0W7ZurGmznqR
=UxHx
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
