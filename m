Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A44CC1A0415
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 14:37:59 +1000 (AEST)
Date: Thu, 30 Apr 2015 14:21:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 18/32] powerpc/iommu/powernv: Release replaced
 TCE
Message-ID: <20150430042107.GE15238@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-19-git-send-email-aik@ozlabs.ru>
 <20150429041808.GO32589@voom.redhat.com>
 <5540A999.9060507@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
In-Reply-To: <5540A999.9060507@ozlabs.ru>
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


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2015 at 07:51:21PM +1000, Alexey Kardashevskiy wrote:
> On 04/29/2015 02:18 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:42PM +1000, Alexey Kardashevskiy wrote:
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
> >>the caller can release the pages afterwards. The exchange() receives
> >>a physical address unlike set() which receives linear mapping address;
> >>and returns a physical address as the clear() does.
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
> >>[aw: for the vfio related changes]
> >>Acked-by: Alex Williamson <alex.williamson@redhat.com>
> >
> >This looks mostly good, but there are couple of details that need fixing.
> >
>=20
>=20
> [...]
>=20
> >>diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platfo=
rms/powernv/pci.c
> >>index ba75aa5..e8802ac 100644
> >>--- a/arch/powerpc/platforms/powernv/pci.c
> >>+++ b/arch/powerpc/platforms/powernv/pci.c
> >>@@ -598,6 +598,23 @@ int pnv_tce_build(struct iommu_table *tbl, long in=
dex, long npages,
> >>  	return 0;
> >>  }
> >>
> >>+#ifdef CONFIG_IOMMU_API
> >>+int pnv_tce_xchg(struct iommu_table *tbl, long index,
> >>+		unsigned long *tce, enum dma_data_direction *direction)
> >>+{
> >>+	u64 proto_tce =3D iommu_direction_to_tce_perm(*direction);
> >>+	unsigned long newtce =3D *tce | proto_tce;
> >>+	unsigned long idx =3D index - tbl->it_offset;
> >
> >Should this have a BUG_ON or WARN_ON if the supplied tce has bits set
> >below the page mask?
>=20
>=20
> Why? The caller checks these bits, do we really need to duplicate it
> here?

Because this is the crunch point where bad bits will actually cause
strange stuff to happen.

As much as anything the point of a BUG_ON would be to document that
this function expects the parameter to be aligned.

>=20
>=20
> >>+	*tce =3D xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
> >>+	*tce =3D be64_to_cpu(*tce);
> >>+	*direction =3D iommu_tce_direction(*tce);
> >>+	*tce &=3D ~(TCE_PCI_READ | TCE_PCI_WRITE);
> >>+
> >>+	return 0;
> >>+}
> >>+#endif
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQa2zAAoJEGw4ysog2bOSHRoQALQCjqiLvIwDjCsNQ6eeY8TR
Ak3g8Iw+1m7236V3pqV7wS7jEkzkaJ3uB4IAjmcEFElu5iKq6LOgfvPXsT7AAOYY
BgqN/bD/8KSGUtgg85bU3PWS362K6MRQc7JVDMDns3nXX7ALJkaVYGg2boZaGnyO
ta6n37r3kikP/rnaeqN6PZgqZcAzH+P6Y4EzFwzrlGM1wLOljY0KI8Zl4815m8lw
x0RwYUgaSaKdTwRZSnS2J3/eDfEMLJxiQ33/8ZtUu0YjmUvXuUqSJ/prEVRT6HHT
D1LiMpRLFIenaILfuI/78D4lUWyVESChyRk1Dw+w3/9RZUDytdCAHt3jjZj0i0BE
yDNItdXvPc10SEbdj625y58f9yc8vIYWZ/+7+GBA3FH3nXK+u0p/2kTEenMKXjWr
RS1XnYGNpvIII+MDEwJpRVwTzDSuCzBGBss2a7x9mkbwtcP0mjIwaheJOjJiDFLH
7G6ywu1xudmUhVQD8dcqaOPUQZA7DExXRkxhav0e7C6nG+EPifYevwQU39umNIj1
QscAeh8E0FJRSukVn4yjAREaGZFCdo/1rnmf22MWAkbxSTxr+pzB4MReqblaGDD4
fenNyoH5Da7LgPeEEFifoEaRa8vhvF5nLOoiIEsZWz2zkvJd/DE945p15+ObJtDa
ZUTbBxFURWIvOOujaA7p
=PDor
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
