Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48D071A0CF7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 15:24:04 +1000 (AEST)
Date: Fri, 1 May 2015 15:12:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 27/32] powerpc/iommu/ioda2: Add
 get_table_size() to calculate the size of future table
Message-ID: <20150501051247.GP24886@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-28-git-send-email-aik@ozlabs.ru>
 <20150429064029.GX32589@voom.redhat.com>
 <5542FCD2.9000601@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oDto3OTLsk6uOlQH"
In-Reply-To: <5542FCD2.9000601@ozlabs.ru>
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


--oDto3OTLsk6uOlQH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2015 at 02:10:58PM +1000, Alexey Kardashevskiy wrote:
> On 04/29/2015 04:40 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:51PM +1000, Alexey Kardashevskiy wrote:
> >>This adds a way for the IOMMU user to know how much a new table will
> >>use so it can be accounted in the locked_vm limit before allocation
> >>happens.
> >>
> >>This stores the allocated table size in pnv_pci_create_table()
> >>so the locked_vm counter can be updated correctly when a table is
> >>being disposed.
> >>
> >>This defines an iommu_table_group_ops callback to let VFIO know
> >>how much memory will be locked if a table is created.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>Changes:
> >>v9:
> >>* reimplemented the whole patch
> >>---
> >>  arch/powerpc/include/asm/iommu.h          |  5 +++++
> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++++
> >>  arch/powerpc/platforms/powernv/pci.c      | 36 ++++++++++++++++++++++=
+++++++++
> >>  arch/powerpc/platforms/powernv/pci.h      |  2 ++
> >>  4 files changed, 57 insertions(+)
> >>
> >>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/as=
m/iommu.h
> >>index 1472de3..9844c106 100644
> >>--- a/arch/powerpc/include/asm/iommu.h
> >>+++ b/arch/powerpc/include/asm/iommu.h
> >>@@ -99,6 +99,7 @@ struct iommu_table {
> >>  	unsigned long  it_size;      /* Size of iommu table in entries */
> >>  	unsigned long  it_indirect_levels;
> >>  	unsigned long  it_level_size;
> >>+	unsigned long  it_allocated_size;
> >>  	unsigned long  it_offset;    /* Offset into global table */
> >>  	unsigned long  it_base;      /* mapped address of tce table */
> >>  	unsigned long  it_index;     /* which iommu table this is */
> >>@@ -155,6 +156,10 @@ extern struct iommu_table *iommu_init_table(struct=
 iommu_table * tbl,
> >>  struct iommu_table_group;
> >>
> >>  struct iommu_table_group_ops {
> >>+	unsigned long (*get_table_size)(
> >>+			__u32 page_shift,
> >>+			__u64 window_size,
> >>+			__u32 levels);
> >>  	long (*create_table)(struct iommu_table_group *table_group,
> >>  			int num,
> >>  			__u32 page_shift,
> >>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> >>index e0be556..7f548b4 100644
> >>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>@@ -2062,6 +2062,18 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct=
 pnv_phb *phb,
> >>  }
> >>
> >>  #ifdef CONFIG_IOMMU_API
> >>+static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
> >>+		__u64 window_size, __u32 levels)
> >>+{
> >>+	unsigned long ret =3D pnv_get_table_size(page_shift, window_size, lev=
els);
> >>+
> >>+	if (!ret)
> >>+		return ret;
> >>+
> >>+	/* Add size of it_userspace */
> >>+	return ret + (window_size >> page_shift) * sizeof(unsigned long);
> >
> >This doesn't make much sense.  The userspace view can't possibly be a
> >property of the specific low-level IOMMU model.
>=20
>=20
> This it_userspace thing is all about memory preregistration.
>=20
> I need some way to track how many actual mappings the
> mm_iommu_table_group_mem_t has in order to decide whether to allow
> unregistering or not.
>=20
> When I clear TCE, I can read the old value which is host physical address
> which I cannot use to find the preregistered region and adjust the mappin=
gs
> counter; I can only use userspace addresses for this (not even guest
> physical addresses as it is VFIO and probably no KVM).
>=20
> So I have to keep userspace addresses somewhere, one per IOMMU page, and =
the
> iommu_table seems a natural place for this.

Well.. sort of.  But as noted elsewhere this pulls VFIO specific
constraints into a platform code structure.  And whether you get this
table depends on the platform IOMMU type rather than on what VFIO
wants to do with it, which doesn't make sense.

What might make more sense is an opaque pointer io iommu_table for use
by the table "owner" (in the take_ownership sense).  The pointer would
be stored in iommu_table, but VFIO is responsible for populating and
managing its contents.

Or you could just put the userspace mappings in the container.
Although you might want a different data structure in that case.

The other thing to bear in mind is that registered regions are likely
to be large contiguous blocks in user addresses, though obviously not
contiguous in physical addr.  So you might be able to compaticfy this
information by storing it as a list of variable length blocks in
userspace address space, rather than a per-page address..



But.. isn't there a bigger problem here.  As Paulus was pointing out,
there's nothing guaranteeing the page tables continue to contain the
same page as was there at gup() time.

What's going to happen if you REGISTER a memory region, then mremap()
over it?  Then attempt to PUT_TCE a page in the region? Or what if you
mremap() it to someplace else then try to PUT_TCE a page there? Or
REGISTER it again in its new location?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oDto3OTLsk6uOlQH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQwtOAAoJEGw4ysog2bOSJqgP/19qpUr5YXzGsjYQ8FugugyH
p/Ez8LPcI5i1KFnlTKf70bJ9cBgAJZiP6K5Bdgf5E0YF7JL9xBIDQzqwggi1/AN5
KBQoaMxQoFCq2+mlCXO+Yz86le+iciJ/liimUxn7vG1jauU7FI0QKmzXQBI98E66
esB3Zk8tmHv4U2ggndafqhi/6H+FLDACUgfjS9VLnY2HbmL1Iy0pHd2HCuuLQ9H5
PiIkPa+fmGUSO5UWAdv8fptToI6Q3LmPociv9yz0IkrMS0HnY3ag1phX7AanpTda
1DSdT4ecSF0TizU9LNZDaH5rv67D3SbXNDaF1hZMqSt5LTblg9KoL6tuMV1gQy21
YAsd0IJz41Ufm62rtZn4VKSATs76pEsSegmfsYL8thI3ZLaXS3ECyMl8Dh7LffJv
C0uvHrSTNWNbR7BMf0ev5pG6f7sYkjs3SArHdGqLvEMp4kfH2ptqy0XFkfefcgKE
aUKWHdYo7mLijiY2MW2w8gNzfA/+f/cJ31j5pXDg4jDSiHVNWZdgr93LcxIpt+7Q
KV3f1MrCkVh0budtgSI5bySkMGQoj3R2d+yxMGKB9+bGMFlIsXYMAMH7lgVbDiQW
ySRVW1wP29lysjEClVAiT64MtqLkyroqnF5ZB+gJiWxzb04Yn7VPXzPSQoA3n8CY
evu3aM8dQSJfT0IMJL9W
=pUzd
-----END PGP SIGNATURE-----

--oDto3OTLsk6uOlQH--
