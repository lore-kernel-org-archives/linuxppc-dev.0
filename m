Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhx833bsPzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 11:54:11 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id b5so20618508pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 17:54:11 -0700 (PDT)
Subject: Re: [PATCH kernel v8 00/10] powerpc/kvm/vfio: Enable in-kernel
 acceleration
To: David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20170310035337.22091-1-aik@ozlabs.ru>
 <20170310044813.GB3167@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0c355414-253f-2ceb-b45e-90d8c01fafdf@ozlabs.ru>
Date: Tue, 14 Mar 2017 11:54:03 +1100
MIME-Version: 1.0
In-Reply-To: <20170310044813.GB3167@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OugLBhqK8OgRH8TJURbwcH5IX7aIFm5Bf"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OugLBhqK8OgRH8TJURbwcH5IX7aIFm5Bf
Content-Type: multipart/mixed; boundary="XClhEm4bEPvTX6VTJSB6WQTWXE1TAXuU2";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Message-ID: <0c355414-253f-2ceb-b45e-90d8c01fafdf@ozlabs.ru>
Subject: Re: [PATCH kernel v8 00/10] powerpc/kvm/vfio: Enable in-kernel
 acceleration
References: <20170310035337.22091-1-aik@ozlabs.ru>
 <20170310044813.GB3167@umbus.fritz.box>
In-Reply-To: <20170310044813.GB3167@umbus.fritz.box>

--XClhEm4bEPvTX6VTJSB6WQTWXE1TAXuU2
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 10/03/17 15:48, David Gibson wrote:
> On Fri, Mar 10, 2017 at 02:53:27PM +1100, Alexey Kardashevskiy wrote:
>> This is my current queue of patches to add acceleration of TCE
>> updates in KVM.
>>
>> This is based on Linus'es tree sha1 c1aa905a304e.
>=20
> I think we're finally there - I've now sent an R-b for all patches.

Thanks for the patience.


I supposed in order to proceed now I need an ack from Alex, correct?


>=20
>=20
>>
>> Please comment. Thanks.
>>
>> Changes:
>> v8:
>> * kept fixing oddities with error handling in 10/10
>>
>> v7:
>> * added realmode's WARN_ON_ONCE_RM in arch/powerpc/kvm/book3s_64_vio_h=
v.c
>>
>> v6:
>> * reworked the last patch in terms of error handling and parameters ch=
ecking
>>
>> v5:
>> * replaced "KVM: PPC: Separate TCE validation from update" with
>> "KVM: PPC: iommu: Unify TCE checking"
>> * changed already reviewed "powerpc/iommu/vfio_spapr_tce: Cleanup iomm=
u_table disposal"
>> * reworked "KVM: PPC: VFIO: Add in-kernel acceleration for VFIO"
>> * more details in individual commit logs
>>
>> v4:
>> * addressed comments from v3
>> * updated subject lines with correct component names
>> * regrouped the patchset in order:
>> 	- powerpc fixes;
>> 	- vfio_spapr_tce driver fixes;
>> 	- KVM/PPC fixes;
>> 	- KVM+PPC+VFIO;
>> * everything except last 2 patches have "Reviewed-By: David"
>>
>> v3:
>> * there was no full repost, only last patch was posted
>>
>> v2:
>> * 11/11 reworked to use new notifiers, it is rather RFC as it still ha=
s
>> a issue;
>> * got 09/11, 10/11 to use notifiers in 11/11;
>> * added rb: David to most of patches and added a comment in 05/11.
>>
>> Alexey Kardashevskiy (10):
>>   powerpc/mmu: Add real mode support for IOMMU preregistered memory
>>   powerpc/powernv/iommu: Add real mode version of
>>     iommu_table_ops::exchange()
>>   powerpc/iommu/vfio_spapr_tce: Cleanup iommu_table disposal
>>   powerpc/vfio_spapr_tce: Add reference counting to iommu_table
>>   KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO capability number
>>   KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64 permanently
>>   KVM: PPC: Pass kvm* to kvmppc_find_table()
>>   KVM: PPC: Use preregistered memory API to access TCE list
>>   KVM: PPC: iommu: Unify TCE checking
>>   KVM: PPC: VFIO: Add in-kernel acceleration for VFIO
>>
>>  Documentation/virtual/kvm/devices/vfio.txt |  22 +-
>>  arch/powerpc/include/asm/iommu.h           |  32 ++-
>>  arch/powerpc/include/asm/kvm_host.h        |   8 +
>>  arch/powerpc/include/asm/kvm_ppc.h         |  12 +-
>>  arch/powerpc/include/asm/mmu_context.h     |   4 +
>>  include/uapi/linux/kvm.h                   |   9 +
>>  arch/powerpc/kernel/iommu.c                |  86 +++++---
>>  arch/powerpc/kvm/book3s_64_vio.c           | 330 ++++++++++++++++++++=
++++++++-
>>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 303 ++++++++++++++++++++=
++----
>>  arch/powerpc/kvm/powerpc.c                 |   2 +
>>  arch/powerpc/mm/mmu_context_iommu.c        |  39 ++++
>>  arch/powerpc/platforms/powernv/pci-ioda.c  |  46 ++--
>>  arch/powerpc/platforms/powernv/pci.c       |   1 +
>>  arch/powerpc/platforms/pseries/iommu.c     |   3 +-
>>  arch/powerpc/platforms/pseries/vio.c       |   2 +-
>>  drivers/vfio/vfio_iommu_spapr_tce.c        |   2 +-
>>  virt/kvm/vfio.c                            |  60 ++++++
>>  arch/powerpc/kvm/Kconfig                   |   1 +
>>  18 files changed, 855 insertions(+), 107 deletions(-)
>>
>=20


--=20
Alexey


--XClhEm4bEPvTX6VTJSB6WQTWXE1TAXuU2--

--OugLBhqK8OgRH8TJURbwcH5IX7aIFm5Bf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYxz8sDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5R0gQALTs
/cpa2o9vFLxiZobQu0L5Gpi5C/BasipVGj9cZA6Q7juvFH8Ck+kdg4GwW7Xhat5d
p6Xl/U16aqYcQKHUhrxJ6/OOFxwOJqCX08CcQrLysvqCNkZggbU/8egNW/eX919D
KMx4WGLe5mvcyFVNO9Scd+JSVth6vU2DpEqq3WDbZFPgRjXMsf6pC97rcO7qlK5i
ONUcMID8mHtpsQeuUig3ml4U0JjxV3/+omqe3DejoVSCjDhOyntcZcGyK2uXxPOq
ckiX1PLqGSmMEvVZfNzpouqnUMT0qYI7T4abFTvpWluHcNHM/CvgfYK8ysw3OuKn
s5C0hjWjrnw6jTrG6MKRFiuBEnGJ8TEnOf12C5ckKbBEjex3mVDaYz8XP6uZzsj1
6PSVNetWs8yApWbR0eKFWHuGmq5jwJar4uXmv9pFLCUNythtuGwQM0GtIoHQa2iG
kCJpwZdUAdi0ETdc1CIKrkl5ip7yq2rlhU1DuKKlx0EChD7+WExIx1aNB3xVY8Km
3OZ5TK9YpqCA2WO4Yui8gwjxM4l2wm3E2diuOmTCp9YStSpfAoKlh0pjJwSL8X3g
mk01TnLT4D9isk2zd6mA7QTbYJq92XCybDGLP75vvFKjeFVD0YX2SkYPk50YgfXF
yeVnOjcpA4xiww85GB+208qBmr6BNqLX4M8OyT/7
=mUpa
-----END PGP SIGNATURE-----

--OugLBhqK8OgRH8TJURbwcH5IX7aIFm5Bf--
