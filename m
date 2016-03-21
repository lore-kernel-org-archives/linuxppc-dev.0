Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT4YK1fcpzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 16:45:25 +1100 (AEDT)
Date: Mon, 21 Mar 2016 16:46:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org, aik@ozlabs.ru, benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 michael@ellerman.id.au
Subject: Re: [RFCv3 00/17] PAPR HPT resizing, guest & host side
Message-ID: <20160321054634.GK23586@voom.redhat.com>
References: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pN9MePJoZbRKbUk1"
In-Reply-To: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pN9MePJoZbRKbUk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 21, 2016 at 02:53:07PM +1100, David Gibson wrote:
> This is an implementation of the kernel parts of the PAPR hashed page
> table (HPT) resizing extension.
>=20
> It contains a complete guest-side implementation - or as complete as
> it can be until we have a final PAPR change.
>=20
> It also contains a draft host side implementation for KVM HV (the KVM
> PR and TCG host-side implementations live in qemu).  This works, but
> is very slow in the critical section (where the guest must be
> stopped).  It is significantly slower than the TCG/PR implementation;
> unusably slow for large hash tables (~2.8s for a 1G HPT).

Since posting this, I've managed to bring this down to ~570ms for a 1G
HPT.  Still slow, but much better.  The optimization to do this was to
skip rehashing an HPTE if neither VALID|ABSENT are set *before*
locking the HPTE.  I believe this is safe, since nothing should be
able to add new VALID|ABSENT HPTEs while the guest is stopped.

>=20
> I'm still looking into what's the cause of the slowness, and I'm not
> sure yet if the current approach can be tweaked to be fast enough, or
> if it will require a new approach.
>=20
> Changes since RFCv2:
>   * Completely new approach to handling KVM HV implementation.  Much
>     simpler synchronization requirements, but also slower
>   * Rebase to latest Linus' tree
>   * Changed number for capability, so as not to collide
>   * Host side now actually works
>=20
> David Gibson (17):
>   pseries: Add hypercall wrappers for hash page table resizing
>   pseries: Add support for hash table resizing
>   pseries: Advertise HPT resizing support via CAS
>   pseries: Automatically resize HPT for memory hot add/remove
>   powerpc/kvm: Corectly report KVM_CAP_PPC_ALLOC_HTAB
>   powerpc/kvm: Add capability flag for hashed page table resizing
>   powerpc/kvm: Rename kvm_alloc_hpt() for clarity
>   powerpc/kvm: Gather HPT related variables into sub-structure
>   powerpc/kvm: Don't store values derivable from HPT order
>   powerpc/kvm: Split HPT allocation from activation
>   powerpc/kvm: Allow KVM_PPC_ALLOCATE_HTAB ioctl() to change HPT size
>   powerpc/kvm: Create kvmppc_unmap_hpte_helper()
>   powerpc/kvm: KVM-HV HPT resizing stub implementation
>   powerpc/kvm: Outline of KVM-HV HPT resizing implementation
>   powerpc/kvm: KVM-HV HPT resizing, preparation path
>   powerpc/kvm: HVM-HV HPT resizing, commit path
>   powerpc/kvm: Advertise availablity of HPT resizing on KVM HV
>=20
>  arch/powerpc/include/asm/firmware.h       |   5 +-
>  arch/powerpc/include/asm/hvcall.h         |   2 +
>  arch/powerpc/include/asm/kvm_book3s.h     |  12 +-
>  arch/powerpc/include/asm/kvm_book3s_64.h  |  15 +
>  arch/powerpc/include/asm/kvm_host.h       |  17 +-
>  arch/powerpc/include/asm/kvm_ppc.h        |  11 +-
>  arch/powerpc/include/asm/machdep.h        |   1 +
>  arch/powerpc/include/asm/plpar_wrappers.h |  12 +
>  arch/powerpc/include/asm/prom.h           |   1 +
>  arch/powerpc/include/asm/sparsemem.h      |   1 +
>  arch/powerpc/kernel/prom_init.c           |   2 +-
>  arch/powerpc/kvm/book3s_64_mmu_hv.c       | 626 ++++++++++++++++++++++++=
------
>  arch/powerpc/kvm/book3s_hv.c              |  37 +-
>  arch/powerpc/kvm/book3s_hv_builtin.c      |   8 +-
>  arch/powerpc/kvm/book3s_hv_rm_mmu.c       |  68 ++--
>  arch/powerpc/kvm/powerpc.c                |  17 +-
>  arch/powerpc/mm/hash_utils_64.c           |  57 +++
>  arch/powerpc/mm/mem.c                     |   4 +
>  arch/powerpc/platforms/pseries/firmware.c |   1 +
>  arch/powerpc/platforms/pseries/lpar.c     | 110 ++++++
>  include/uapi/linux/kvm.h                  |   1 +
>  21 files changed, 825 insertions(+), 183 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pN9MePJoZbRKbUk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW74q6AAoJEGw4ysog2bOSXXcP/it54SXTD6d/gq2ISm7Po2wI
W37NYPFJgsaOAHCXi9N2iaVlawT7I5LOshvWULA9fPFsfbqvQrWUVMNIgLjjNMKS
sr58uJgKCYM5fTLq5DOd/j8TzTnxVMEWjSIUoVXeLYnrWvlN5+CyLBiSxgcW2ViK
MyeCE8paEzK8pu0hiyo+xsmpfwNUskHq5G4eGoP/VYDcC471NXnqCvgMsK1ZcW5A
+6qi6jrSmuZEUFMjcgfaL/IWVehihsmFCSjwXhzZXG3LqwbSh+IgrBvrd65riM0l
l/2sbUsxLIIOIiOZHUk1fSd+0h7heQeJXy05DJTPVOlJ/pVClD52Ow15Gc+q1ekm
/McQuJCIZN4DVJt1n83qmn2Fm88D3Z2bRCrhw0vB3TqrflgGpYow5iLormhG1ZpR
vOOM5PQxmxmrSyjB1g/X7iGyFGgwmVYqTc82RhJTTsEzerKSm5ckSLAK0NfpTmNN
+bsaK2GRvLcG7NSTWMUzaE4U1ES8oECH6GXuOisNVGx4m8YtiKLUpjs0tuosJz0V
tNGrmhn+MyUB3L0glXbA/pdo3Zd+Eh4CwqtBv0YydYbdkWHeRaBsPpMyRWzNKcwR
24KyAyR7lDLQFLMFRTntNd2haRZ47UJ310OahOfhz0ehCWEdhUNIaZoHr7cknVGp
r1Zk0EJHfH1TWhN0Olrj
=c/7o
-----END PGP SIGNATURE-----

--pN9MePJoZbRKbUk1--
