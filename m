Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F8791A0D0F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 14:53:56 +1000 (AEST)
Date: Fri, 1 May 2015 14:33:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 31/32] vfio: powerpc/spapr: Support multiple
 groups in one container if possible
Message-ID: <20150501043354.GN24886@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-32-git-send-email-aik@ozlabs.ru>
 <20150430072221.GD24886@voom.redhat.com>
 <5541F6D5.9040809@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PtLnLSExlPr13a2X"
In-Reply-To: <5541F6D5.9040809@ozlabs.ru>
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


--PtLnLSExlPr13a2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2015 at 07:33:09PM +1000, Alexey Kardashevskiy wrote:
> On 04/30/2015 05:22 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:55PM +1000, Alexey Kardashevskiy wrote:
> >>At the moment only one group per container is supported.
> >>POWER8 CPUs have more flexible design and allows naving 2 TCE tables per
> >>IOMMU group so we can relax this limitation and support multiple groups
> >>per container.
> >
> >It's not obvious why allowing multiple TCE tables per PE has any
> >pearing on allowing multiple groups per container.
>=20
>=20
> This patchset is a global TCE tables rework (patches 1..30, roughly) with=
 2
> outcomes:
> 1. reusing the same IOMMU table for multiple groups - patch 31;
> 2. allowing dynamic create/remove of IOMMU tables - patch 32.
>=20
> I can remove this one from the patchset and post it separately later but
> since 1..30 aim to support both 1) and 2), I'd think I better keep them a=
ll
> together (might explain some of changes I do in 1..30).

The combined patchset is fine.  My comment is because your commit
message says that multiple groups are possible *because* 2 TCE tables
per group are allowed, and it's not at all clear why one follows from
the other.

> >>This adds TCE table descriptors to a container and uses iommu_table_gro=
up_ops
> >>to create/set DMA windows on IOMMU groups so the same TCE tables will be
> >>shared between several IOMMU groups.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>[aw: for the vfio related changes]
> >>Acked-by: Alex Williamson <alex.williamson@redhat.com>
> >>---
> >>Changes:
> >>v7:
> >>* updated doc
> >>---
> >>  Documentation/vfio.txt              |   8 +-
> >>  drivers/vfio/vfio_iommu_spapr_tce.c | 268 ++++++++++++++++++++++++++-=
---------
> >>  2 files changed, 199 insertions(+), 77 deletions(-)
> >>
> >>diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> >>index 94328c8..7dcf2b5 100644
> >>--- a/Documentation/vfio.txt
> >>+++ b/Documentation/vfio.txt
> >>@@ -289,10 +289,12 @@ PPC64 sPAPR implementation note
> >>
> >>  This implementation has some specifics:
> >>
> >>-1) Only one IOMMU group per container is supported as an IOMMU group
> >>-represents the minimal entity which isolation can be guaranteed for and
> >>-groups are allocated statically, one per a Partitionable Endpoint (PE)
> >>+1) On older systems (POWER7 with P5IOC2/IODA1) only one IOMMU group per
> >>+container is supported as an IOMMU table is allocated at the boot time,
> >>+one table per a IOMMU group which is a Partitionable Endpoint (PE)
> >>  (PE is often a PCI domain but not always).
> >
> >I thought the more fundamental problem was that different PEs tended
> >to use disjoint bus address ranges, so even by duplicating put_tce
> >across PEs you couldn't have a common address space.
>=20
>=20
> Sorry, I am not following you here.
>=20
> By duplicating put_tce, I can have multiple IOMMU groups on the same virt=
ual
> PHB in QEMU, "[PATCH qemu v7 04/14] spapr_pci_vfio: Enable multiple groups
> per container" does this, the address ranges will the same.

Oh, ok.  For some reason I thought that (at least on the older
machines) the different PEs used different and not easily changeable
DMA windows in bus addresses space.

> What I cannot do on p5ioc2 is programming the same table to multiple
> physical PHBs (or I could but it is very different than IODA2 and pretty
> ugly and might not always be possible because I would have to allocate th=
ese
> pages from some common pool and face problems like fragmentation).

So allowing multiple groups per container should be possible (at the
kernel rather than qemu level) by writing the same value to multiple
TCE tables.  I guess its not worth doing for just the almost-obsolete
IOMMUs though.

>=20
>=20
>=20
> >>+Newer systems (POWER8 with IODA2) have improved hardware design which =
allows
> >>+to remove this limitation and have multiple IOMMU groups per a VFIO co=
ntainer.
> >>
> >>  2) The hardware supports so called DMA windows - the PCI address range
> >>  within which DMA transfer is allowed, any attempt to access address s=
pace
> >>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> >>index a7d6729..970e3a2 100644
> >>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>@@ -82,6 +82,11 @@ static void decrement_locked_vm(long npages)
> >>   * into DMA'ble space using the IOMMU
> >>   */
> >>
> >>+struct tce_iommu_group {
> >>+	struct list_head next;
> >>+	struct iommu_group *grp;
> >>+};
> >>+
> >>  /*
> >>   * The container descriptor supports only a single group per containe=
r.
> >>   * Required by the API as the container is not supplied with the IOMM=
U group
> >>@@ -89,10 +94,11 @@ static void decrement_locked_vm(long npages)
> >>   */
> >>  struct tce_container {
> >>  	struct mutex lock;
> >>-	struct iommu_group *grp;
> >>  	bool enabled;
> >>  	unsigned long locked_pages;
> >>  	bool v2;
> >>+	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> >
> >Hrm,  so here we have more copies of the full iommu_table structures,
> >which again muddies the lifetime.  The table_group pointer is
> >presumably meaningless in these copies, which seems dangerously
> >confusing.
>=20
>=20
> Ouch. This is bad. No, table_group is not pointless here as it is used to
> get to the PE number to invalidate TCE cache. I just realized although I
> need to update just a single table, I still have to invalidate TCE cache =
for
> every attached group/PE so I need a list of iommu_table_group's here, not=
 a
> single pointer...

Right.

> >>+	struct list_head group_list;
> >>  };
> >>
> >>  static long tce_unregister_pages(struct tce_container *container,
> >>@@ -154,20 +160,20 @@ static bool tce_page_is_contained(struct page *pa=
ge, unsigned page_shift)
> >>  	return (PAGE_SHIFT + compound_order(compound_head(page))) >=3D page_=
shift;
> >>  }
> >>
> >>+static inline bool tce_groups_attached(struct tce_container *container)
> >>+{
> >>+	return !list_empty(&container->group_list);
> >>+}
> >>+
> >>  static struct iommu_table *spapr_tce_find_table(
> >>  		struct tce_container *container,
> >>  		phys_addr_t ioba)
> >>  {
> >>  	long i;
> >>  	struct iommu_table *ret =3D NULL;
> >>-	struct iommu_table_group *table_group;
> >>-
> >>-	table_group =3D iommu_group_get_iommudata(container->grp);
> >>-	if (!table_group)
> >>-		return NULL;
> >>
> >>  	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> >>-		struct iommu_table *tbl =3D &table_group->tables[i];
> >>+		struct iommu_table *tbl =3D &container->tables[i];
> >>  		unsigned long entry =3D ioba >> tbl->it_page_shift;
> >>  		unsigned long start =3D tbl->it_offset;
> >>  		unsigned long end =3D start + tbl->it_size;
> >>@@ -186,9 +192,7 @@ static int tce_iommu_enable(struct tce_container *c=
ontainer)
> >>  	int ret =3D 0;
> >>  	unsigned long locked;
> >>  	struct iommu_table_group *table_group;
> >>-
> >>-	if (!container->grp)
> >>-		return -ENXIO;
> >>+	struct tce_iommu_group *tcegrp;
> >>
> >>  	if (!current->mm)
> >>  		return -ESRCH; /* process exited */
> >>@@ -225,7 +229,12 @@ static int tce_iommu_enable(struct tce_container *=
container)
> >>  	 * as there is no way to know how much we should increment
> >>  	 * the locked_vm counter.
> >>  	 */
> >>-	table_group =3D iommu_group_get_iommudata(container->grp);
> >>+	if (!tce_groups_attached(container))
> >>+		return -ENODEV;
> >>+
> >>+	tcegrp =3D list_first_entry(&container->group_list,
> >>+			struct tce_iommu_group, next);
> >>+	table_group =3D iommu_group_get_iommudata(tcegrp->grp);
> >>  	if (!table_group)
> >>  		return -ENODEV;
> >>
> >>@@ -257,6 +266,48 @@ static void tce_iommu_disable(struct tce_container=
 *container)
> >>  	decrement_locked_vm(container->locked_pages);
> >>  }
> >>
> >>+static long tce_iommu_create_table(struct iommu_table_group *table_gro=
up,
> >>+			int num,
> >>+			__u32 page_shift,
> >>+			__u64 window_size,
> >>+			__u32 levels,
> >>+			struct iommu_table *tbl)
> >
> >With multiple groups (and therefore PEs) per container, this seems
> >wrong.  There's only one table_group per PE, so what's special about
> >PE whose table group is passed in here.
>=20
>=20
> The created table is allocated at the same node as table_group
> (pe->phb->hose->node). This does not make much sense if we put multiple
> groups to the same container but we will recommend people to avoid putting
> groups from different NUMA nodes to the same container.

Ok.  I guess the point is that the first PE attached has a special
bearing on how the table is configured, and that's what the
table_group here represents.

> Also, the allocated table gets bus offset initialized in create_table()
> (which is IODA2-specific knowledge). It is there to emphasize the fact th=
at
> we do not get to choose where to map the window on a bus, it is hardcoded
> and easier to deal with the tables which have offset set once - I could a=
dd
> a bus_offset parameter to set_window() but it would be converted back to =
the
> window number.
>=20
>=20
>=20
> >>+{
> >>+	long ret, table_size;
> >>+
> >>+	table_size =3D table_group->ops->get_table_size(page_shift, window_si=
ze,
> >>+			levels);
> >>+	if (!table_size)
> >>+		return -EINVAL;
> >>+
> >>+	ret =3D try_increment_locked_vm(table_size >> PAGE_SHIFT);
> >>+	if (ret)
> >>+		return ret;
> >>+
> >>+	ret =3D table_group->ops->create_table(table_group, num,
> >>+			page_shift, window_size, levels, tbl);
> >>+
> >>+	WARN_ON(!ret && !tbl->it_ops->free);
> >>+	WARN_ON(!ret && (tbl->it_allocated_size !=3D table_size));
> >>+
> >>+	if (ret)
> >>+		decrement_locked_vm(table_size >> PAGE_SHIFT);
> >>+
> >>+	return ret;
> >>+}
> >>+
> >>+static void tce_iommu_free_table(struct iommu_table *tbl)
> >>+{
> >>+	unsigned long pages =3D tbl->it_allocated_size >> PAGE_SHIFT;
> >>+
> >>+	if (!tbl->it_size)
> >>+		return;
> >>+
> >>+	tbl->it_ops->free(tbl);
> >
> >So, this is exactly the case where the lifetimes are badly confusing.
> >How can you be confident here that another copy of the iommu_table
> >struct isn't referencing the same TCE tables?
>=20
>=20
> Create/remove window is handled by a single file driver. It is not like m=
any
> of there tables. But yes, valid point.
>=20
>=20
>=20
> >>+	decrement_locked_vm(pages);
> >>+	memset(tbl, 0, sizeof(*tbl));
> >>+}
> >>+
> >>  static void *tce_iommu_open(unsigned long arg)
> >>  {
> >>  	struct tce_container *container;
> >>@@ -271,19 +322,41 @@ static void *tce_iommu_open(unsigned long arg)
> >>  		return ERR_PTR(-ENOMEM);
> >>
> >>  	mutex_init(&container->lock);
> >>+	INIT_LIST_HEAD_RCU(&container->group_list);
> >
> >I see no other mentions of rcu related to this list, which doesn't
> >seem right.
> >
> >>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> >>
> >>  	return container;
> >>  }
> >>
> >>+static int tce_iommu_clear(struct tce_container *container,
> >>+		struct iommu_table *tbl,
> >>+		unsigned long entry, unsigned long pages);
> >>+
> >>  static void tce_iommu_release(void *iommu_data)
> >>  {
> >>  	struct tce_container *container =3D iommu_data;
> >>+	struct iommu_table_group *table_group;
> >>+	struct tce_iommu_group *tcegrp;
> >>+	long i;
> >>
> >>-	WARN_ON(container->grp);
> >>+	while (tce_groups_attached(container)) {
> >>+		tcegrp =3D list_first_entry(&container->group_list,
> >>+				struct tce_iommu_group, next);
> >>+		table_group =3D iommu_group_get_iommudata(tcegrp->grp);
> >>+		tce_iommu_detach_group(iommu_data, tcegrp->grp);
> >>+	}
> >>
> >>-	if (container->grp)
> >>-		tce_iommu_detach_group(iommu_data, container->grp);
> >>+	/*
> >>+	 * If VFIO created a table, it was not disposed
> >>+	 * by tce_iommu_detach_group() so do it now.
> >>+	 */
> >>+	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> >>+		struct iommu_table *tbl =3D &container->tables[i];
> >>+
> >>+		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> >>+		tce_iommu_free_table(tbl);
> >>+	}
> >>
> >>  	tce_iommu_disable(container);
> >>  	mutex_destroy(&container->lock);
> >>@@ -509,12 +582,15 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>
> >>  	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
> >>  		struct vfio_iommu_spapr_tce_info info;
> >>+		struct tce_iommu_group *tcegrp;
> >>  		struct iommu_table_group *table_group;
> >>
> >>-		if (WARN_ON(!container->grp))
> >>+		if (!tce_groups_attached(container))
> >>  			return -ENXIO;
> >>
> >>-		table_group =3D iommu_group_get_iommudata(container->grp);
> >>+		tcegrp =3D list_first_entry(&container->group_list,
> >>+				struct tce_iommu_group, next);
> >>+		table_group =3D iommu_group_get_iommudata(tcegrp->grp);
> >>
> >>  		if (!table_group)
> >>  			return -ENXIO;
> >>@@ -707,12 +783,20 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>  		tce_iommu_disable(container);
> >>  		mutex_unlock(&container->lock);
> >>  		return 0;
> >>-	case VFIO_EEH_PE_OP:
> >>-		if (!container->grp)
> >>-			return -ENODEV;
> >>
> >>-		return vfio_spapr_iommu_eeh_ioctl(container->grp,
> >>-						  cmd, arg);
> >>+	case VFIO_EEH_PE_OP: {
> >>+		struct tce_iommu_group *tcegrp;
> >>+
> >>+		ret =3D 0;
> >>+		list_for_each_entry(tcegrp, &container->group_list, next) {
> >>+			ret =3D vfio_spapr_iommu_eeh_ioctl(tcegrp->grp,
> >>+					cmd, arg);
> >>+			if (ret)
> >>+				return ret;
> >
> >Hrm.  It occurs to me that EEH may need a way of referencing
> >individual groups.  Even if multiple PEs are referencing the same TCE
> >tables, presumably EEH will isolate them individually.
>=20
>=20
> Well. I asked our EEH guy Gavin, he did not object to this change but I'll
> double check :)
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PtLnLSExlPr13a2X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQwIyAAoJEGw4ysog2bOSuP0P/is6Suh4dR3W338kx+4z78hO
P9g/yza5qVyRl8nQZezwU3HcsJNs+MiDlsRo3i0nVDIjsm2pM0iTbf/W8+cz0dLA
N1k8fs/CRND5nyenNps/iAQzLcZ07Djsub9w9OLKMdaMzHyCxzwfA5QDdlae/02R
JxDcBlk6ubG9b2u3VDcpK8uvdJVmBS5lxI76/pXCPsvJD3w09Mu8O1QOSKBTpH8o
8KJ8wFvOaE5hoKVHDMzUv6IxfUbmNbTIGZCS8ZWbdPhyCvSjercoxgcS5+LZ+rKv
ba47DeBK2XHnA18IL4CuBscUcGrs6xYcZKFO4bO7V413RmZlGzNR1qEUAdH4hsoe
r1xBqIgaBf3LxQbYWTNzYg297ULroUFPAunaLPZHg60ndScmt6Te4PSa2TzRiwc0
EYshwhtaLdf1Rd2U6UKgEnscaZWh2cShxxhIj9mMqAm2MZbdoWi1aEKlVrK1vuzh
ToBJwZ8+uw7AcTEhm14sv18lcpxeUSqrnapUBmuLATcDGJ8aBMe3YlW56mhf10DQ
XClJ5NNd+3FFRc8juQTTEgFbzSeYF1G1UUtjBOh5d54xI7ZIdcQO22F+9t46GZhH
3E/2lo2sW0FGjllVTFpDqWTUxuLPpnPf6eHrgYekijOre5+Fi29OmyzSO8esXjhl
cZJint4dKznhgKqaQr5D
=tYBt
-----END PGP SIGNATURE-----

--PtLnLSExlPr13a2X--
