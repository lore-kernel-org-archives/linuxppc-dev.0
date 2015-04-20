Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AE181A1B22
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 16:02:53 +1000 (AEST)
Date: Mon, 20 Apr 2015 12:50:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 17/31] powerpc/iommu/powernv: Release replaced
 TCE
Message-ID: <20150420025009.GF10218@voom>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-18-git-send-email-aik@ozlabs.ru>
 <20150416062619.GH3632@voom.redhat.com>
 <5530E282.3060106@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
In-Reply-To: <5530E282.3060106@ozlabs.ru>
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


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2015 at 08:37:54PM +1000, Alexey Kardashevskiy wrote:
> On 04/16/2015 04:26 PM, David Gibson wrote:
> >On Fri, Apr 10, 2015 at 04:30:59PM +1000, Alexey Kardashevskiy wrote:
> >>At the moment writing new TCE value to the IOMMU table fails with EBUSY
> >>if there is a valid entry already. However PAPR specification allows
> >>the guest to write new TCE value without clearing it first.
> >>
> >>Another problem this patch is addressing is the use of pool locks for
> >>external IOMMU users such as VFIO. The pool locks are to protect
> >>DMA page allocator rather than entries and since the host kernel does
> >>not control what pages are in use, there is no point in pool locks and
> >>exchange()+put_page(oldtce) is sufficient to avoid possible races.
> >>
> >>This adds an exchange() callback to iommu_table_ops which does the same
> >>thing as set() plus it returns replaced TCE and DMA direction so
> >>the caller can release the pages afterwards.
> >>
> >>The returned old TCE value is a virtual address as the new TCE value.
> >>This is different from tce_clear() which returns a physical address.
> >>
> >>This implements exchange() for P5IOC2/IODA/IODA2. This adds a requireme=
nt
> >>for a platform to have exchange() implemented in order to support VFIO.
> >>
> >>This replaces iommu_tce_build() and iommu_clear_tce() with
> >>a single iommu_tce_xchg().
> >>
> >>This makes sure that TCE permission bits are not set in TCE passed to
> >>IOMMU API as those are to be calculated by platform code from DMA direc=
tion.
> >>
> >>This moves SetPageDirty() to the IOMMU code to make it work for both
> >>VFIO ioctl interface in in-kernel TCE acceleration (when it becomes
> >>available later).
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>  arch/powerpc/include/asm/iommu.h            | 17 ++++++--
> >>  arch/powerpc/kernel/iommu.c                 | 53 +++++++++-----------=
----
> >>  arch/powerpc/platforms/powernv/pci-ioda.c   | 38 ++++++++++++++++++
> >>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |  3 ++
> >>  arch/powerpc/platforms/powernv/pci.c        | 17 ++++++++
> >>  arch/powerpc/platforms/powernv/pci.h        |  2 +
> >>  drivers/vfio/vfio_iommu_spapr_tce.c         | 62 ++++++++++++++++++--=
---------
> >>  7 files changed, 130 insertions(+), 62 deletions(-)
> >>
> >>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/as=
m/iommu.h
> >>index d1f8c6c..bde7ee7 100644
> >>--- a/arch/powerpc/include/asm/iommu.h
> >>+++ b/arch/powerpc/include/asm/iommu.h
> >>@@ -44,11 +44,22 @@ extern int iommu_is_off;
> >>  extern int iommu_force_on;
> >>
> >>  struct iommu_table_ops {
> >>+	/* When called with direction=3D=3DDMA_NONE, it is equal to clear() */
> >>  	int (*set)(struct iommu_table *tbl,
> >>  			long index, long npages,
> >>  			unsigned long uaddr,
> >>  			enum dma_data_direction direction,
> >>  			struct dma_attrs *attrs);
> >>+#ifdef CONFIG_IOMMU_API
> >>+	/*
> >>+	 * Exchanges existing TCE with new TCE plus direction bits;
> >>+	 * returns old TCE and DMA direction mask
> >>+	 */
> >>+	int (*exchange)(struct iommu_table *tbl,
> >>+			long index,
> >>+			unsigned long *tce,
> >>+			enum dma_data_direction *direction);
> >>+#endif
> >>  	void (*clear)(struct iommu_table *tbl,
> >>  			long index, long npages);
> >>  	unsigned long (*get)(struct iommu_table *tbl, long index);
> >>@@ -152,6 +163,8 @@ extern void iommu_register_group(struct iommu_table=
_group *table_group,
> >>  extern int iommu_add_device(struct device *dev);
> >>  extern void iommu_del_device(struct device *dev);
> >>  extern int __init tce_iommu_bus_notifier_init(void);
> >>+extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entr=
y,
> >>+		unsigned long *tce, enum dma_data_direction *direction);
> >>  #else
> >>  static inline void iommu_register_group(struct iommu_table_group *tab=
le_group,
> >>  					int pci_domain_number,
> >>@@ -231,10 +244,6 @@ extern int iommu_tce_clear_param_check(struct iomm=
u_table *tbl,
> >>  		unsigned long npages);
> >>  extern int iommu_tce_put_param_check(struct iommu_table *tbl,
> >>  		unsigned long ioba, unsigned long tce);
> >>-extern int iommu_tce_build(struct iommu_table *tbl, unsigned long entr=
y,
> >>-		unsigned long hwaddr, enum dma_data_direction direction);
> >>-extern unsigned long iommu_clear_tce(struct iommu_table *tbl,
> >>-		unsigned long entry);
> >>
> >>  extern void iommu_flush_tce(struct iommu_table *tbl);
> >>  extern int iommu_take_ownership(struct iommu_table_group *table_group=
);
> >>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> >>index 068fe4ff..501e8ee 100644
> >>--- a/arch/powerpc/kernel/iommu.c
> >>+++ b/arch/powerpc/kernel/iommu.c
> >>@@ -982,9 +982,6 @@ EXPORT_SYMBOL_GPL(iommu_tce_clear_param_check);
> >>  int iommu_tce_put_param_check(struct iommu_table *tbl,
> >>  		unsigned long ioba, unsigned long tce)
> >>  {
> >>-	if (!(tce & (TCE_PCI_WRITE | TCE_PCI_READ)))
> >>-		return -EINVAL;
> >>-
> >>  	if (tce & ~(IOMMU_PAGE_MASK(tbl) | TCE_PCI_WRITE | TCE_PCI_READ))
> >>  		return -EINVAL;
> >>
> >>@@ -1002,44 +999,20 @@ int iommu_tce_put_param_check(struct iommu_table=
 *tbl,
> >>  }
> >>  EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
> >>
> >>-unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long e=
ntry)
> >>-{
> >>-	unsigned long oldtce;
> >>-	struct iommu_pool *pool =3D get_pool(tbl, entry);
> >>-
> >>-	spin_lock(&(pool->lock));
> >>-
> >>-	oldtce =3D tbl->it_ops->get(tbl, entry);
> >>-	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
> >>-		tbl->it_ops->clear(tbl, entry, 1);
> >>-	else
> >>-		oldtce =3D 0;
> >>-
> >>-	spin_unlock(&(pool->lock));
> >>-
> >>-	return oldtce;
> >>-}
> >>-EXPORT_SYMBOL_GPL(iommu_clear_tce);
> >>-
> >>  /*
> >>   * hwaddr is a kernel virtual address here (0xc... bazillion),
> >>   * tce_build converts it to a physical address.
> >>   */
> >>-int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
> >>-		unsigned long hwaddr, enum dma_data_direction direction)
> >>+long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
> >>+		unsigned long *tce, enum dma_data_direction *direction)
> >>  {
> >>-	int ret =3D -EBUSY;
> >>-	unsigned long oldtce;
> >>-	struct iommu_pool *pool =3D get_pool(tbl, entry);
> >>+	long ret;
> >>
> >>-	spin_lock(&(pool->lock));
> >>+	ret =3D tbl->it_ops->exchange(tbl, entry, tce, direction);
> >>
> >>-	oldtce =3D tbl->it_ops->get(tbl, entry);
> >>-	/* Add new entry if it is not busy */
> >>-	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
> >>-		ret =3D tbl->it_ops->set(tbl, entry, 1, hwaddr, direction, NULL);
> >>-
> >>-	spin_unlock(&(pool->lock));
> >>+	if (!ret && ((*direction =3D=3D DMA_FROM_DEVICE) ||
> >>+			(*direction =3D=3D DMA_BIDIRECTIONAL)))
> >>+		SetPageDirty(pfn_to_page(__pa(*tce) >> PAGE_SHIFT));
> >>
> >>  	/* if (unlikely(ret))
> >>  		pr_err("iommu_tce: %s failed on hwaddr=3D%lx ioba=3D%lx kva=3D%lx r=
et=3D%d\n",
> >>@@ -1048,13 +1021,23 @@ int iommu_tce_build(struct iommu_table *tbl, un=
signed long entry,
> >>
> >>  	return ret;
> >>  }
> >>-EXPORT_SYMBOL_GPL(iommu_tce_build);
> >>+EXPORT_SYMBOL_GPL(iommu_tce_xchg);
> >>
> >>  static int iommu_table_take_ownership(struct iommu_table *tbl)
> >>  {
> >>  	unsigned long flags, i, sz =3D (tbl->it_size + 7) >> 3;
> >>  	int ret =3D 0;
> >>
> >>+	/*
> >>+	 * VFIO does not control TCE entries allocation and the guest
> >>+	 * can write new TCEs on top of existing ones so iommu_tce_build()
> >>+	 * must be able to release old pages. This functionality
> >>+	 * requires exchange() callback defined so if it is not
> >>+	 * implemented, we disallow taking ownership over the table.
> >>+	 */
> >>+	if (!tbl->it_ops->exchange)
> >>+		return -EINVAL;
> >>+
> >>  	spin_lock_irqsave(&tbl->large_pool.lock, flags);
> >>  	for (i =3D 0; i < tbl->nr_pools; i++)
> >>  		spin_lock(&tbl->pools[i].lock);
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index fd993bc..4d80502 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -1128,6 +1128,20 @@ static int pnv_ioda1_tce_build_vm(struct iommu_t=
able *tbl, long index,
> >>  	return ret;
> >>  }
> >>
> >>+#ifdef CONFIG_IOMMU_API
> >>+static int pnv_ioda1_tce_xchg_vm(struct iommu_table *tbl, long index,
> >>+		unsigned long *tce, enum dma_data_direction *direction)
> >>+{
> >>+	long ret =3D pnv_tce_xchg(tbl, index, tce, direction);
> >>+
> >>+	if (!ret && (tbl->it_type &
> >>+			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
> >>+		pnv_pci_ioda1_tce_invalidate(tbl, index, 1, false);
> >>+
> >>+	return ret;
> >>+}
> >>+#endif
> >>+
> >>  static void pnv_ioda1_tce_free_vm(struct iommu_table *tbl, long index,
> >>  		long npages)
> >>  {
> >>@@ -1139,6 +1153,9 @@ static void pnv_ioda1_tce_free_vm(struct iommu_ta=
ble *tbl, long index,
> >>
> >>  struct iommu_table_ops pnv_ioda1_iommu_ops =3D {
> >>  	.set =3D pnv_ioda1_tce_build_vm,
> >>+#ifdef CONFIG_IOMMU_API
> >>+	.exchange =3D pnv_ioda1_tce_xchg_vm,
> >>+#endif
> >>  	.clear =3D pnv_ioda1_tce_free_vm,
> >>  	.get =3D pnv_tce_get,
> >>  };
> >>@@ -1190,6 +1207,20 @@ static int pnv_ioda2_tce_build_vm(struct iommu_t=
able *tbl, long index,
> >>  	return ret;
> >>  }
> >>
> >>+#ifdef CONFIG_IOMMU_API
> >>+static int pnv_ioda2_tce_xchg_vm(struct iommu_table *tbl, long index,
> >>+		unsigned long *tce, enum dma_data_direction *direction)
> >>+{
> >>+	long ret =3D pnv_tce_xchg(tbl, index, tce, direction);
> >>+
> >>+	if (!ret && (tbl->it_type &
> >>+			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
> >>+		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, false);
> >>+
> >>+	return ret;
> >>+}
> >>+#endif
> >>+
> >>  static void pnv_ioda2_tce_free_vm(struct iommu_table *tbl, long index,
> >>  		long npages)
> >>  {
> >>@@ -1201,6 +1232,9 @@ static void pnv_ioda2_tce_free_vm(struct iommu_ta=
ble *tbl, long index,
> >>
> >>  static struct iommu_table_ops pnv_ioda2_iommu_ops =3D {
> >>  	.set =3D pnv_ioda2_tce_build_vm,
> >>+#ifdef CONFIG_IOMMU_API
> >>+	.exchange =3D pnv_ioda2_tce_xchg_vm,
> >>+#endif
> >>  	.clear =3D pnv_ioda2_tce_free_vm,
> >>  	.get =3D pnv_tce_get,
> >>  };
> >>@@ -1353,6 +1387,7 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct =
pnv_phb *phb,
> >>  	pnv_pci_ioda2_set_bypass(pe, true);
> >>  }
> >>
> >>+#ifdef CONFIG_IOMMU_API
> >>  static void pnv_ioda2_set_ownership(struct iommu_table_group *table_g=
roup,
> >>  				     bool enable)
> >>  {
> >>@@ -1369,6 +1404,7 @@ static void pnv_ioda2_set_ownership(struct iommu_=
table_group *table_group,
> >>  static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
> >>  	.set_ownership =3D pnv_ioda2_set_ownership,
> >>  };
> >>+#endif
> >>
> >>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> >>  				       struct pnv_ioda_pe *pe)
> >>@@ -1437,7 +1473,9 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
> >>  	}
> >>  	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
> >>  	iommu_init_table(tbl, phb->hose->node);
> >>+#ifdef CONFIG_IOMMU_API
> >>  	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
> >>+#endif
> >>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
> >>  			pe->pe_number);
> >>
> >>diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc=
/platforms/powernv/pci-p5ioc2.c
> >>index 6906a9c..d2d9092 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> >>@@ -85,6 +85,9 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *=
phb) { }
> >>
> >>  static struct iommu_table_ops pnv_p5ioc2_iommu_ops =3D {
> >>  	.set =3D pnv_tce_build,
> >>+#ifdef CONFIG_IOMMU_API
> >>+	.exchange =3D pnv_tce_xchg,
> >>+#endif
> >>  	.clear =3D pnv_tce_free,
> >>  	.get =3D pnv_tce_get,
> >>  };
> >>diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platfo=
rms/powernv/pci.c
> >>index a8c05de..a9797dd 100644
> >>--- a/arch/powerpc/platforms/powernv/pci.c
> >>+++ b/arch/powerpc/platforms/powernv/pci.c
> >>@@ -615,6 +615,23 @@ int pnv_tce_build(struct iommu_table *tbl, long in=
dex, long npages,
> >>  	return 0;
> >>  }
> >>
> >>+#ifdef CONFIG_IOMMU_API
> >>+int pnv_tce_xchg(struct iommu_table *tbl, long index,
> >>+		unsigned long *tce, enum dma_data_direction *direction)
> >>+{
> >>+	u64 proto_tce =3D iommu_direction_to_tce_perm(*direction);
> >>+	unsigned long newtce =3D  __pa(*tce) | proto_tce;
> >>+	unsigned long idx =3D index - tbl->it_offset;
> >>+
> >>+	*tce =3D xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
> >>+	*tce =3D (unsigned long) __va(be64_to_cpu(*tce));
> >>+	*direction =3D iommu_tce_direction(*tce);
> >>+	*tce &=3D ~(TCE_PCI_READ | TCE_PCI_WRITE);
> >>+
> >>+	return 0;
> >>+}
> >>+#endif
> >>+
> >>  void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
> >>  {
> >>  	long i;
> >>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platfo=
rms/powernv/pci.h
> >>index 0d4df32..4d1a78c 100644
> >>--- a/arch/powerpc/platforms/powernv/pci.h
> >>+++ b/arch/powerpc/platforms/powernv/pci.h
> >>@@ -220,6 +220,8 @@ extern int pnv_tce_build(struct iommu_table *tbl, l=
ong index, long npages,
> >>  		unsigned long uaddr, enum dma_data_direction direction,
> >>  		struct dma_attrs *attrs);
> >>  extern void pnv_tce_free(struct iommu_table *tbl, long index, long np=
ages);
> >>+extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
> >>+		unsigned long *tce, enum dma_data_direction *direction);
> >>  extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
> >>  extern struct iommu_table_ops pnv_ioda1_iommu_ops;
> >>
> >>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> >>index d5d8c50..7c3c215 100644
> >>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>@@ -251,9 +251,6 @@ static void tce_iommu_unuse_page(struct tce_contain=
er *container,
> >>  {
> >>  	struct page *page;
> >>
> >>-	if (!(oldtce & (TCE_PCI_READ | TCE_PCI_WRITE)))
> >>-		return;
> >>-
> >>  	/*
> >>  	 * VFIO cannot map/unmap when a container is not enabled so
> >>  	 * we would not need this check but KVM could map/unmap and if
> >>@@ -264,10 +261,6 @@ static void tce_iommu_unuse_page(struct tce_contai=
ner *container,
> >>  		return;
> >>
> >>  	page =3D pfn_to_page(__pa(oldtce) >> PAGE_SHIFT);
> >>-
> >>-	if (oldtce & TCE_PCI_WRITE)
> >>-		SetPageDirty(page);
> >>-
> >
> >Seems to me that unuse_page() should get a direction parameter,
> >instead of moving the PageDirty (and DMA_NONE test) to all the
> >callers.
>=20
>=20
> Sorry, I am not following you here. There is just a single gateway for VF=
IO
> to the platform code which is iommu_tce_xchg() and this is where the
> SetPageDirty() check went. What are "all the callers"?

Oh, ok, I think I see.  I just saw the dirty check being removed here,
and it's not obvious looking at this patch alone that iommu_tce_xchg()
is called at all the callsites of unuse_page.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNGlhAAoJEGw4ysog2bOSxlEQAIUx7JApb91dL/mbWpRLUfIs
O58NrS7DSdkNgNG2i5Oc0gpR8/ZDTUzHsixgjvArirmxbP6AssjlhzuEGbCvcckD
7FzDGdf9Ea7IA9JauHwu7LnbYcqNWtOOu/KA6bnIzgH1MfasmN0JKZxD4bA8NwD2
IKwm+rDgqRYDqqCrGMdJcSECtinnyivr7VHlUss1oKgRtzmoGn9m7D2K3npAUivt
NA9XCmCLytwxPqBXGSxb6TVZxHwiiqLVuf+x9118UsngTvcvHgciWc87IaANfXWR
jsU+oBHgnORFhejchIFSnydJN4qWNAXqnSwc/v1TqxL/qVzhnap7k8H74LGCp/Q8
5EgyJpZ8OlfD5xt6HWOF1QT8D7EGt/s3YZhXpuMr+DhgGywemjiFoT11shadB6r7
9cY8cb+59BCYBklFPxRwQYnjO54L7jL0v1B4cIvE3TAVoo9VbG/A7Ub8PvHzRnUV
w6cWp+AP5XtTx86xPGqxWETz6HdRO3o7rDR8iclhllB1Ghu/gVB+WF06LKiZLRX7
CylAN/6MQpCe8qIuoQOotBMvvh0cKdhhvdMCQMXTYjNMpWR7s3TjhdsMdyD81B88
rtenAzfZTtFNqWDLM/lpPoCSSuaomyOtl8YXAD7YfwtaCQOk1Yc17Qpa7hUWVMA6
EAoeuUb5q73N3NEoAOwB
=9PuG
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
