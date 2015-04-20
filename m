Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EAA41A2C4E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 16:02:53 +1000 (AEST)
Date: Mon, 20 Apr 2015 12:37:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 12/31] powerpc/spapr: vfio: Switch from
 iommu_table to new iommu_table_group
Message-ID: <20150420023709.GC10218@voom>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-13-git-send-email-aik@ozlabs.ru>
 <20150416055555.GC3632@voom.redhat.com>
 <5530D66F.3070208@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
In-Reply-To: <5530D66F.3070208@ozlabs.ru>
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


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2015 at 07:46:23PM +1000, Alexey Kardashevskiy wrote:
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
>=20
>=20
> Later in the patchset, the code will look at @it_size to know if the table
> is in use.

Ok, that makes sense.  Might be worth a comment here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNGZVAAoJEGw4ysog2bOSaq8QAIO5PUXneUmVb+ZhFKTKhw63
e44U1SBuJA7nRttnXCGw79MXNTE0l/EFOItfJ8zvrsFn+BYp1TXnkt1Yp6RjgTXP
D3JyLNXVlg5MclmfPhF6X3qQrbdRzPh77zysPCWmzGp4wo+rDWLGDK2JuDhwCHxC
2vBN00Agydn2vxF+x6aBFCcCPafawMJ8mstDM0rZ4CW8eYvgMXNQJLlLumTwKOf3
uNE/uHS3WZMK/HrGGPbm9GnHnWUNuejISWsektAdTzSI+5kR9H1cophBrTmGNprC
oFaorqAbcD7nXbQiOZjibvi0qP5q5dX8aJsCaNOKNWvQuK8QiYTAHsIvCTEssfTK
qEFBBZrX6c9hdHiioCwycUG/fcrdmcGWmzrPaezBhO5BWMbMNk2QtLqzw1iw9qme
oL8/7aId2nPHPZk3JTeXsn0XmS7pqf9tmrGLY+q2n3htaZJ/AsXYVIxaeNQ12bwT
R+ciZVauZlm6qE/wdcwLZdKXJAsmVTqIF8FjIjoz32t/zR11E0KE01z1cdkW6k9y
yJPftnY1B4kZeIzxARyOrEY//VZSAI5wMMZoQN4iGz6vriK7Rp7ZLXyEj56KExXu
t0BLcRSvn87St2Phve2EwsfxxHajUPoqWXLCK336d64dxQq7+Eg3MeUPCY39jDX/
L3VzKQjnH8bNuGR1vijd
=m6Mj
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
