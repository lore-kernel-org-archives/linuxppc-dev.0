Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT22m4lCvzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 14:52:16 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 michael@ellerman.id.au, David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv3 00/17] PAPR HPT resizing, guest & host side
Date: Mon, 21 Mar 2016 14:53:07 +1100
Message-Id: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an implementation of the kernel parts of the PAPR hashed page
table (HPT) resizing extension.

It contains a complete guest-side implementation - or as complete as
it can be until we have a final PAPR change.

It also contains a draft host side implementation for KVM HV (the KVM
PR and TCG host-side implementations live in qemu).  This works, but
is very slow in the critical section (where the guest must be
stopped).  It is significantly slower than the TCG/PR implementation;
unusably slow for large hash tables (~2.8s for a 1G HPT).

I'm still looking into what's the cause of the slowness, and I'm not
sure yet if the current approach can be tweaked to be fast enough, or
if it will require a new approach.

Changes since RFCv2:
  * Completely new approach to handling KVM HV implementation.  Much
    simpler synchronization requirements, but also slower
  * Rebase to latest Linus' tree
  * Changed number for capability, so as not to collide
  * Host side now actually works

David Gibson (17):
  pseries: Add hypercall wrappers for hash page table resizing
  pseries: Add support for hash table resizing
  pseries: Advertise HPT resizing support via CAS
  pseries: Automatically resize HPT for memory hot add/remove
  powerpc/kvm: Corectly report KVM_CAP_PPC_ALLOC_HTAB
  powerpc/kvm: Add capability flag for hashed page table resizing
  powerpc/kvm: Rename kvm_alloc_hpt() for clarity
  powerpc/kvm: Gather HPT related variables into sub-structure
  powerpc/kvm: Don't store values derivable from HPT order
  powerpc/kvm: Split HPT allocation from activation
  powerpc/kvm: Allow KVM_PPC_ALLOCATE_HTAB ioctl() to change HPT size
  powerpc/kvm: Create kvmppc_unmap_hpte_helper()
  powerpc/kvm: KVM-HV HPT resizing stub implementation
  powerpc/kvm: Outline of KVM-HV HPT resizing implementation
  powerpc/kvm: KVM-HV HPT resizing, preparation path
  powerpc/kvm: HVM-HV HPT resizing, commit path
  powerpc/kvm: Advertise availablity of HPT resizing on KVM HV

 arch/powerpc/include/asm/firmware.h       |   5 +-
 arch/powerpc/include/asm/hvcall.h         |   2 +
 arch/powerpc/include/asm/kvm_book3s.h     |  12 +-
 arch/powerpc/include/asm/kvm_book3s_64.h  |  15 +
 arch/powerpc/include/asm/kvm_host.h       |  17 +-
 arch/powerpc/include/asm/kvm_ppc.h        |  11 +-
 arch/powerpc/include/asm/machdep.h        |   1 +
 arch/powerpc/include/asm/plpar_wrappers.h |  12 +
 arch/powerpc/include/asm/prom.h           |   1 +
 arch/powerpc/include/asm/sparsemem.h      |   1 +
 arch/powerpc/kernel/prom_init.c           |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c       | 626 ++++++++++++++++++++++++------
 arch/powerpc/kvm/book3s_hv.c              |  37 +-
 arch/powerpc/kvm/book3s_hv_builtin.c      |   8 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c       |  68 ++--
 arch/powerpc/kvm/powerpc.c                |  17 +-
 arch/powerpc/mm/hash_utils_64.c           |  57 +++
 arch/powerpc/mm/mem.c                     |   4 +
 arch/powerpc/platforms/pseries/firmware.c |   1 +
 arch/powerpc/platforms/pseries/lpar.c     | 110 ++++++
 include/uapi/linux/kvm.h                  |   1 +
 21 files changed, 825 insertions(+), 183 deletions(-)

-- 
2.5.0
