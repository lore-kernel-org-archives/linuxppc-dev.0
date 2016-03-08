Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB5531A011E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 16:10:53 +1100 (AEDT)
Date: Tue, 8 Mar 2016 15:50:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 4/9] powerpc/powernv/iommu: Add real mode version
 of xchg()
Message-ID: <20160308045058.GX22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-5-git-send-email-aik@ozlabs.ru>
 <20160307060519.GM22546@voom.fritz.box>
 <56DD2E87.1010504@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OtXN0xDA1zr/oUEL"
In-Reply-To: <56DD2E87.1010504@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OtXN0xDA1zr/oUEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 06:32:23PM +1100, Alexey Kardashevskiy wrote:
> On 03/07/2016 05:05 PM, David Gibson wrote:
> >On Mon, Mar 07, 2016 at 02:41:12PM +1100, Alexey Kardashevskiy wrote:
> >>In real mode, TCE tables are invalidated using different
> >>cache-inhibited store instructions which is different from
> >>the virtual mode.
> >>
> >>This defines and implements exchange_rm() callback. This does not
> >>define set_rm/clear_rm/flush_rm callbacks as there is no user for those=
 -
> >>exchange/exchange_rm are only to be used by KVM for VFIO.
> >>
> >>The exchange_rm callback is defined for IODA1/IODA2 powernv platforms.
> >>
> >>This replaces list_for_each_entry_rcu with its lockless version as
> >>from now on pnv_pci_ioda2_tce_invalidate() can be called in
> >>the real mode too.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>  arch/powerpc/include/asm/iommu.h          |  7 +++++++
> >>  arch/powerpc/kernel/iommu.c               | 15 +++++++++++++++
> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 28 ++++++++++++++++++++++=
+++++-
> >>  3 files changed, 49 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/as=
m/iommu.h
> >>index 7b87bab..3ca877a 100644
> >>--- a/arch/powerpc/include/asm/iommu.h
> >>+++ b/arch/powerpc/include/asm/iommu.h
> >>@@ -64,6 +64,11 @@ struct iommu_table_ops {
> >>  			long index,
> >>  			unsigned long *hpa,
> >>  			enum dma_data_direction *direction);
> >>+	/* Real mode */
> >>+	int (*exchange_rm)(struct iommu_table *tbl,
> >>+			long index,
> >>+			unsigned long *hpa,
> >>+			enum dma_data_direction *direction);
> >>  #endif
> >>  	void (*clear)(struct iommu_table *tbl,
> >>  			long index, long npages);
> >>@@ -208,6 +213,8 @@ extern void iommu_del_device(struct device *dev);
> >>  extern int __init tce_iommu_bus_notifier_init(void);
> >>  extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long ent=
ry,
> >>  		unsigned long *hpa, enum dma_data_direction *direction);
> >>+extern long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long e=
ntry,
> >>+		unsigned long *hpa, enum dma_data_direction *direction);
> >>  #else
> >>  static inline void iommu_register_group(struct iommu_table_group *tab=
le_group,
> >>  					int pci_domain_number,
> >>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> >>index a8e3490..2fcc48b 100644
> >>--- a/arch/powerpc/kernel/iommu.c
> >>+++ b/arch/powerpc/kernel/iommu.c
> >>@@ -1062,6 +1062,21 @@ void iommu_release_ownership(struct iommu_table =
*tbl)
> >>  }
> >>  EXPORT_SYMBOL_GPL(iommu_release_ownership);
> >>
> >>+long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
> >>+		unsigned long *hpa, enum dma_data_direction *direction)
> >>+{
> >>+	long ret;
> >>+
> >>+	ret =3D tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> >>+
> >>+	if (!ret && ((*direction =3D=3D DMA_FROM_DEVICE) ||
> >>+			(*direction =3D=3D DMA_BIDIRECTIONAL)))
> >>+		SetPageDirty(realmode_pfn_to_page(*hpa >> PAGE_SHIFT));
> >>+
> >>+	return ret;
> >>+}
> >>+EXPORT_SYMBOL_GPL(iommu_tce_xchg_rm);
> >
> >>  int iommu_add_device(struct device *dev)
> >>  {
> >>  	struct iommu_table *tbl;
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index c5baaf3..bed1944 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -1791,6 +1791,18 @@ static int pnv_ioda1_tce_xchg(struct iommu_table=
 *tbl, long index,
> >>
> >>  	return ret;
> >>  }
> >>+
> >>+static int pnv_ioda1_tce_xchg_rm(struct iommu_table *tbl, long index,
> >>+		unsigned long *hpa, enum dma_data_direction *direction)
> >>+{
> >>+	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction);
> >>+
> >>+	if (!ret && (tbl->it_type &
> >>+			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
> >>+		pnv_pci_ioda1_tce_invalidate(tbl, index, 1, true);
> >>+
> >>+	return ret;
> >>+}
> >>  #endif
> >
> >Both your _rm variants are identical to the non _rm versions.  Why not
> >just set the function poiinter to the same thing, rather than copying
> >the whole function.
>=20
>=20
> The last parameter - "rm" - to pnv_pci_ioda1_tce_invalidate() is
> different.

Ah, missed that, sorry.

>=20
>=20
> >
> >>  static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
> >>@@ -1806,6 +1818,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops=
 =3D {
> >>  	.set =3D pnv_ioda1_tce_build,
> >>  #ifdef CONFIG_IOMMU_API
> >>  	.exchange =3D pnv_ioda1_tce_xchg,
> >>+	.exchange_rm =3D pnv_ioda1_tce_xchg_rm,
> >>  #endif
> >>  	.clear =3D pnv_ioda1_tce_free,
> >>  	.get =3D pnv_tce_get,
> >>@@ -1866,7 +1879,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct i=
ommu_table *tbl,
> >>  {
> >>  	struct iommu_table_group_link *tgl;
> >>
> >>-	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
> >>+	list_for_each_entry_lockless(tgl, &tbl->it_group_list, next) {
> >>  		struct pnv_ioda_pe *npe;
> >>  		struct pnv_ioda_pe *pe =3D container_of(tgl->table_group,
> >>  				struct pnv_ioda_pe, table_group);
> >>@@ -1918,6 +1931,18 @@ static int pnv_ioda2_tce_xchg(struct iommu_table=
 *tbl, long index,
> >>
> >>  	return ret;
> >>  }
> >>+
> >>+static int pnv_ioda2_tce_xchg_rm(struct iommu_table *tbl, long index,
> >>+		unsigned long *hpa, enum dma_data_direction *direction)
> >>+{
> >>+	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction);
> >>+
> >>+	if (!ret && (tbl->it_type &
> >>+			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
> >>+		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, true);
> >>+
> >>+	return ret;
> >>+}
> >>  #endif
> >>
> >>  static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
> >>@@ -1939,6 +1964,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops=
 =3D {
> >>  	.set =3D pnv_ioda2_tce_build,
> >>  #ifdef CONFIG_IOMMU_API
> >>  	.exchange =3D pnv_ioda2_tce_xchg,
> >>+	.exchange_rm =3D pnv_ioda2_tce_xchg_rm,
> >>  #endif
> >>  	.clear =3D pnv_ioda2_tce_free,
> >>  	.get =3D pnv_tce_get,
> >
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OtXN0xDA1zr/oUEL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3loyAAoJEGw4ysog2bOSIj4QAOUtqs30naysW4dlT70imwjS
u1QUpgFUL7wF7ruXmBVOfOeP8dFlGI/PL9bf4+9qSA3dNZvEocsdr0mqd3wzJmnR
jbQKZr41NaLQi1GG3JYVr9pcyyH5ump+Sbw1jXSTiKGUfKGSrXgX6KPIdlPZo2Db
lA1qmydVCcxGR/pSgDvx0PD+m+GM1JYGAaO4eDEygSwjWb+eFpq7TGrV2/GikSl7
q8B8Afo8D0/hMpKktYGwPwzTwl6Vx746sPH9bW8ZEfyyyHgMqtL6TfVtdd4K9ifs
6SRxED+332c76lyg+NfzGJ+4MjoUpCnsts0K9GMf+HJ16lwg+7XBfRf88rMZflbg
ZsL1bMS6pr5F52sRL32ymU+SFcxOe4EOiJUIBAsGablKcONWKTAM3fcghCEcWaSN
77glahmdH7WPYQO4ZL93h9JdAK/kHMzA7x3gCMtOcXkVCTTL7lXdRzjWXadcF8nw
Um/WboctthmEF0RACiJWCKlzqHNK80Dp2MwYUwEDunQ0lNvAA44LTKPR0WMN4KQ6
u/hxqGsinAmeXmOkcfVKrYhik0V9Qx+QGM+mYTwifX3TYu4I9xOUAOhea17uU8vL
qB2bgVv7Sh9nhFRtU4DE0SC/25Llqs8sNFxRhgYBIXSau85290pMGK+M3OlgThLC
4I9bNVoZHIktX3/5HT+c
=JEBG
-----END PGP SIGNATURE-----

--OtXN0xDA1zr/oUEL--
