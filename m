Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FB3C1A2C4D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 16:02:53 +1000 (AEST)
Date: Mon, 20 Apr 2015 12:36:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 12/31] powerpc/spapr: vfio: Switch from
 iommu_table to new iommu_table_group
Message-ID: <20150420023608.GB10218@voom>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-13-git-send-email-aik@ozlabs.ru>
 <20150416055555.GC3632@voom.redhat.com>
 <552FD9BD.9060001@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
In-Reply-To: <552FD9BD.9060001@ozlabs.ru>
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


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2015 at 01:48:13AM +1000, Alexey Kardashevskiy wrote:
> On 04/16/2015 03:55 PM, David Gibson wrote:
> >On Fri, Apr 10, 2015 at 04:30:54PM +1000, Alexey Kardashevskiy wrote:
> >>Modern IBM POWERPC systems support multiple (currently two) TCE tables
> >>per IOMMU group (a.k.a. PE). This adds a iommu_table_group container
> >>for TCE tables. Right now just one table is supported.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>  arch/powerpc/include/asm/iommu.h            |  18 +++--
> >>  arch/powerpc/kernel/iommu.c                 |  34 ++++----
> >>  arch/powerpc/platforms/powernv/pci-ioda.c   |  38 +++++----
> >>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |  17 ++--
> >>  arch/powerpc/platforms/powernv/pci.c        |   2 +-
> >>  arch/powerpc/platforms/powernv/pci.h        |   4 +-
> >>  arch/powerpc/platforms/pseries/iommu.c      |   9 ++-
> >>  drivers/vfio/vfio_iommu_spapr_tce.c         | 120 +++++++++++++++++++=
+--------
> >>  8 files changed, 160 insertions(+), 82 deletions(-)
> >>
> >>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/as=
m/iommu.h
> >>index eb75726..667aa1a 100644
> >>--- a/arch/powerpc/include/asm/iommu.h
> >>+++ b/arch/powerpc/include/asm/iommu.h
> >>@@ -90,9 +90,7 @@ struct iommu_table {
> >>  	struct iommu_pool pools[IOMMU_NR_POOLS];
> >>  	unsigned long *it_map;       /* A simple allocation bitmap for now */
> >>  	unsigned long  it_page_shift;/* table iommu page size */
> >>-#ifdef CONFIG_IOMMU_API
> >>-	struct iommu_group *it_group;
> >>-#endif
> >>+	struct iommu_table_group *it_group;
> >>  	struct iommu_table_ops *it_ops;
> >>  	void (*set_bypass)(struct iommu_table *tbl, bool enable);
> >>  };
> >>@@ -126,14 +124,24 @@ extern void iommu_free_table(struct iommu_table *=
tbl, const char *node_name);
> >>   */
> >>  extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
> >>  					    int nid);
> >>+
> >>+#define IOMMU_TABLE_GROUP_MAX_TABLES	1
> >>+
> >>+struct iommu_table_group {
> >>  #ifdef CONFIG_IOMMU_API
> >>-extern void iommu_register_group(struct iommu_table *tbl,
> >>+	struct iommu_group *group;
> >>+#endif
> >>+	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> >
> >There's nothing to indicate which of the tables are in use at the
> >current time.  I mean, it doesn't matter now because there's only one,
> >but the patch doesn't make a whole lot of sense without that.
> >
> >>+};
> >>+
> >>+#ifdef CONFIG_IOMMU_API
> >>+extern void iommu_register_group(struct iommu_table_group *table_group,
> >>  				 int pci_domain_number, unsigned long pe_num);
> >>  extern int iommu_add_device(struct device *dev);
> >>  extern void iommu_del_device(struct device *dev);
> >>  extern int __init tce_iommu_bus_notifier_init(void);
> >>  #else
> >>-static inline void iommu_register_group(struct iommu_table *tbl,
> >>+static inline void iommu_register_group(struct iommu_table_group *tabl=
e_group,
> >>  					int pci_domain_number,
> >>  					unsigned long pe_num)
> >>  {
> >>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> >>index b39d00a..fd49c8e 100644
> >>--- a/arch/powerpc/kernel/iommu.c
> >>+++ b/arch/powerpc/kernel/iommu.c
> >>@@ -712,17 +712,20 @@ struct iommu_table *iommu_init_table(struct iommu=
_table *tbl, int nid)
> >>
> >>  struct iommu_table *iommu_table_alloc(int node)
> >>  {
> >>-	struct iommu_table *tbl;
> >>+	struct iommu_table_group *table_group;
> >>
> >>-	tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
> >>+	table_group =3D kzalloc_node(sizeof(struct iommu_table_group), GFP_KE=
RNEL,
> >>+			   node);
> >>+	table_group->tables[0].it_group =3D table_group;
> >>
> >>-	return tbl;
> >>+	return &table_group->tables[0];
> >>  }
> >>
> >>  void iommu_free_table(struct iommu_table *tbl, const char *node_name)
> >
> >Surely the free function should take a table group rather than a table
> >as argument.
>=20
>=20
> No, it should not. Tables lifetime is not the same even within the
> same group.

If that's so, then this function shouldn't free the group...

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNGYYAAoJEGw4ysog2bOShbMQALwUM7wMeHcGjTGfedZl4tbq
bFuUc52Z+9WV+qWkkSb9lBnyg4FDePvSU7KSEXSqraYu/0n9wm9DruDrV/eiQbD3
IvyoqstwQ9B4JkXLzEGKH+5uTFfMNWOVBCRCODCwivwpYa7SBkPqg90j5BAXswA6
15czkbIfveQq9eZY6gBE80e85/HwB+/Mww+BRb1J4EbOVcKL1Bo7F61AfNt7D4tG
bEyf2kwCz3kInRLLgfeeevY2nbjRDWXRRtuzm9ojBUfYZzHhJ5C9xzvm/KL7EYMn
XY9/z5jGFP9H+DsyjZL4wAoFMPiws1QK0Dj0WhDC7wfGlEpmpGSWkg5yxlEdzaes
b5yZXoayiUQr7VHkB6DWkkkjgltnroMAH2+YOOKN3hBRjhqCPFv82n7spdASrLsO
4sU0gPR3xI5qWyNewgiF4JQZfdEZA3MqSouZ6gHqUZWJCbJpwskRF24wCZBSobYl
kcFuMdnK/sYEF4Kf/+leDW9+jVkz1N97lig4/nMjZuRB4Fl2ecyqFt3jHOie50k0
FfJ8Y1+OLvHC1w4kvGQITjeZahHunu3uDF5CuFQueQjM5HEWRKWUDw+dJegTAZTe
IO7h8mw+w9X93wPfSTfh0YVZIWjjh5xgXth8vt/pXAAbTiwtdEFBxwP2ixtayCZI
u8ulTydh6i9uGh+zBX6a
=E3MO
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
