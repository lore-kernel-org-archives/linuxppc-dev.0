Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C0ED1A04B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 10:38:28 +1000 (AEST)
Date: Thu, 30 Apr 2015 10:13:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 17/32] powerpc/powernv: Implement accessor to
 TCE entry
Message-ID: <20150430001327.GZ32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-18-git-send-email-aik@ozlabs.ru>
 <20150429040436.GN32589@voom.redhat.com>
 <55409E19.3090204@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3rx43rDlPB5nB2+S"
In-Reply-To: <55409E19.3090204@ozlabs.ru>
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


--3rx43rDlPB5nB2+S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2015 at 07:02:17PM +1000, Alexey Kardashevskiy wrote:
> On 04/29/2015 02:04 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:41PM +1000, Alexey Kardashevskiy wrote:
> >>This replaces direct accesses to TCE table with a helper which
> >>returns an TCE entry address. This does not make difference now but will
> >>when multi-level TCE tables get introduces.
> >>
> >>No change in behavior is expected.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >
> >Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >
> >
> >>---
> >>Changes:
> >>v9:
> >>* new patch in the series to separate this mechanical change from
> >>functional changes; this is not right before
> >>"powerpc/powernv: Implement multilevel TCE tables" but here in order
> >>to let the next patch - "powerpc/iommu/powernv: Release replaced TCE" -
> >>use pnv_tce() and avoid changing the same code twice
> >>---
> >>  arch/powerpc/platforms/powernv/pci.c | 34 +++++++++++++++++++++------=
-------
> >>  1 file changed, 21 insertions(+), 13 deletions(-)
> >>
> >>diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platfo=
rms/powernv/pci.c
> >>index 84b4ea4..ba75aa5 100644
> >>--- a/arch/powerpc/platforms/powernv/pci.c
> >>+++ b/arch/powerpc/platforms/powernv/pci.c
> >>@@ -572,38 +572,46 @@ struct pci_ops pnv_pci_ops =3D {
> >>  	.write =3D pnv_pci_write_config,
> >>  };
> >>
> >>+static __be64 *pnv_tce(struct iommu_table *tbl, long idx)
> >>+{
> >>+	__be64 *tmp =3D ((__be64 *)tbl->it_base);
> >>+
> >>+	return tmp + idx;
> >>+}
> >>+
> >>  int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
> >>  		unsigned long uaddr, enum dma_data_direction direction,
> >>  		struct dma_attrs *attrs)
> >>  {
> >>  	u64 proto_tce =3D iommu_direction_to_tce_perm(direction);
> >>-	__be64 *tcep;
> >>-	u64 rpn;
> >>+	u64 rpn =3D __pa(uaddr) >> tbl->it_page_shift;
> >
> >I guess this was a problem in the existing code, not this patch.  But
> >"uaddr" is a really bad name (and unsigned long is a bad type) for
> >what must actually be a kernel linear mapping address.
>=20
>=20
> Yes and may be one day I'll clean this up. s/uaddr/linear/ and s/hwaddr/h=
pa/
> are the first things to do globally but not in this patchset.

Ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3rx43rDlPB5nB2+S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQXOnAAoJEGw4ysog2bOSrQMP/1Ar5IePUlCg1JjlkWDqe7ab
AJlizBRTnjgdKo7Mf53y6kBx/uZe3mgr5QQNnLcXl+KoWlXOiCI5yX83qeDGsbc6
RteWzju76A6373beQA1YKXXRraMnWY/sted0h8flaMB/NPHFgWIcZOByNaiPscyO
eDNIbU+8SslCFHNc1/d+r7gTxhQnq8t0R/MLabKsVz594/D3xg4ehY0RV9ZZep+s
UhsO29o0VGGlgRScj9N8ZCiu4Hmrs9L86lE2s3x9ZkODulJ4xgRcvuEMsS2/1RVf
+rmWbdE7VVtL3XeSkcK2plaleOrT/Suw16wI3fRxDyJbhtKVnRhJdEf9BJ1/Hr6u
1ceVCo+VI7xVv8ltZ8mZ4uBhlWW2xjYcj2NVXV4uK7HkvV6famdVhfuZTbTpLIJB
8vkyCX3nQaOwHnHzKr/BUjxPnQXFibsEpn7+w2jFsYwmpwnaSGzR1/JoBB52qZ72
ZXpw0uU6LbumacG7PUYYaqB109oziTYY0zhcuQUv0Ia6TUcJDMzp4rbav7NLYaFc
tA0vO7/SSWE9CWfXGcuqtRyB3biXNryWG70EuJ8QBBE8HsFK4xz8LPR57Q/v10Dx
gQO2E3j5IE2RSMeJ8xxTczsuaz6XuWi6KhrUgX12EzReVlMDu29tk80s9TYDVLRo
aKgODyOqFRq/DiTYzyky
=1jJK
-----END PGP SIGNATURE-----

--3rx43rDlPB5nB2+S--
