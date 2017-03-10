Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfZX42t31zDqY2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 15:48:20 +1100 (AEDT)
Date: Fri, 10 Mar 2017 15:48:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v8 00/10] powerpc/kvm/vfio: Enable in-kernel
 acceleration
Message-ID: <20170310044813.GB3167@umbus.fritz.box>
References: <20170310035337.22091-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
In-Reply-To: <20170310035337.22091-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2017 at 02:53:27PM +1100, Alexey Kardashevskiy wrote:
> This is my current queue of patches to add acceleration of TCE
> updates in KVM.
>=20
> This is based on Linus'es tree sha1 c1aa905a304e.

I think we're finally there - I've now sent an R-b for all patches.


>=20
> Please comment. Thanks.
>=20
> Changes:
> v8:
> * kept fixing oddities with error handling in 10/10
>=20
> v7:
> * added realmode's WARN_ON_ONCE_RM in arch/powerpc/kvm/book3s_64_vio_hv.c
>=20
> v6:
> * reworked the last patch in terms of error handling and parameters check=
ing
>=20
> v5:
> * replaced "KVM: PPC: Separate TCE validation from update" with
> "KVM: PPC: iommu: Unify TCE checking"
> * changed already reviewed "powerpc/iommu/vfio_spapr_tce: Cleanup iommu_t=
able disposal"
> * reworked "KVM: PPC: VFIO: Add in-kernel acceleration for VFIO"
> * more details in individual commit logs
>=20
> v4:
> * addressed comments from v3
> * updated subject lines with correct component names
> * regrouped the patchset in order:
> 	- powerpc fixes;
> 	- vfio_spapr_tce driver fixes;
> 	- KVM/PPC fixes;
> 	- KVM+PPC+VFIO;
> * everything except last 2 patches have "Reviewed-By: David"
>=20
> v3:
> * there was no full repost, only last patch was posted
>=20
> v2:
> * 11/11 reworked to use new notifiers, it is rather RFC as it still has
> a issue;
> * got 09/11, 10/11 to use notifiers in 11/11;
> * added rb: David to most of patches and added a comment in 05/11.
>=20
> Alexey Kardashevskiy (10):
>   powerpc/mmu: Add real mode support for IOMMU preregistered memory
>   powerpc/powernv/iommu: Add real mode version of
>     iommu_table_ops::exchange()
>   powerpc/iommu/vfio_spapr_tce: Cleanup iommu_table disposal
>   powerpc/vfio_spapr_tce: Add reference counting to iommu_table
>   KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO capability number
>   KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64 permanently
>   KVM: PPC: Pass kvm* to kvmppc_find_table()
>   KVM: PPC: Use preregistered memory API to access TCE list
>   KVM: PPC: iommu: Unify TCE checking
>   KVM: PPC: VFIO: Add in-kernel acceleration for VFIO
>=20
>  Documentation/virtual/kvm/devices/vfio.txt |  22 +-
>  arch/powerpc/include/asm/iommu.h           |  32 ++-
>  arch/powerpc/include/asm/kvm_host.h        |   8 +
>  arch/powerpc/include/asm/kvm_ppc.h         |  12 +-
>  arch/powerpc/include/asm/mmu_context.h     |   4 +
>  include/uapi/linux/kvm.h                   |   9 +
>  arch/powerpc/kernel/iommu.c                |  86 +++++---
>  arch/powerpc/kvm/book3s_64_vio.c           | 330 +++++++++++++++++++++++=
+++++-
>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 303 ++++++++++++++++++++++-=
---
>  arch/powerpc/kvm/powerpc.c                 |   2 +
>  arch/powerpc/mm/mmu_context_iommu.c        |  39 ++++
>  arch/powerpc/platforms/powernv/pci-ioda.c  |  46 ++--
>  arch/powerpc/platforms/powernv/pci.c       |   1 +
>  arch/powerpc/platforms/pseries/iommu.c     |   3 +-
>  arch/powerpc/platforms/pseries/vio.c       |   2 +-
>  drivers/vfio/vfio_iommu_spapr_tce.c        |   2 +-
>  virt/kvm/vfio.c                            |  60 ++++++
>  arch/powerpc/kvm/Kconfig                   |   1 +
>  18 files changed, 855 insertions(+), 107 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwjANAAoJEGw4ysog2bOSpZ0QAMjeLv4ikxgZx7uZ2OEbP5c3
ztOIVvTnDAHemXKZvPQ+WA4KVefxxFqob9JJTpuibXzfV0tEJO5JKUa5Ip+SeHhX
USpB/M6ZFkqcq0gKuvaWeyWdZauUp2XGhBQ2Tyhme+mfcuHUfwCe1N644SVWmuVL
Vn5rjnaOcULZGNNs7kru96beW09JI+Xpr+88OvU46w8+uPznr8co4Wsc//ChAnCI
Rqe53hFNcYW8Y7TQLdAE4EfSLAKtkA/E7AFbgQNK4Xm8bNouUHQUYfgP57L/iJUO
Dcb+pigROdFdqQFXersyUCweO1VWHXNe0Q6zgnuEHbYxpjcZET77TKwoWjgRPGtI
tHbg3KHXnfmL3542cZyeSvh2S0IFUeR/ySC0cXO7OG03/kL01FqgGDF7JZw2kYES
QH2lHeKC0qmhuTY/rYIzqqFyO58vArp4oy+KvrXViPSlSTPQw3NBgZigk1Abi23g
1mNQdyhCKggK0x7uG7dM5YnpFoS0TNgaobS5L49XoRSGDO2us+p3TnhF0FbmGio0
WKoE98RDoOT6dojHPlyvtBvZ5eAnUT7J6hJnOM9sgvsiX67Vcvn4rY6JyAod9vBh
MvW6WBTqx5excIi358ZX2ssOagXbAJ8Uan3Z3sKFpyBifUGav31sLHV7Yq02OXuG
PvUCy7ggMvZD+jMsuE5E
=2PGo
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
