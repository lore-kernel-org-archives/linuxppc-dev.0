Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AFFC1A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:06 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 00/25] PAPR HPT resizing, guest side & host side preliminaries
Date: Tue,  8 Mar 2016 14:08:37 +1100
Message-Id: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an unfinished implementation of the kernel parts of the PAPR
hashed page table (HPT) resizing extension.

It contains a complete guest-side implementation - or as complete as
it can be until we have a final PAPR change.

It also contains a host side implementation for KVM HV (the KVM PR and
TCG host-side implementations live in qemu).  This is "complete" in
the sense that there's no specific piece I know still needs to be
done, but is still a fair way from actually working, with both guest
and host crashes commonplaces during and/or after an attempted resize.

I'm continuing to debug this, obviously, but any review I can get on
the basic approach would be helpful.  With the various failure and
cancellation paths the synchronization is rather hairier than I'd
like.

David Gibson (25):
  powerpc/mm: Clean up error handling for htab_remove_mapping
  powerpc/mm: Handle removing maybe-present bolted HPTEs
  powerpc/mm: Clean up memory hotplug failure paths
  powerpc/mm: Split hash page table sizing heuristic into a helper
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
  powerpc/kvm: HPT resizing stub implementation
  powerpc/kvm: Advertise availablity of HPT resizing on KVM HV
  powerpc/kvm: Outline of HPT resizing implementation
  powerpc/kbm: Allocations for HPT resizing
  powerpc/kvm: Make MMU notifier handlers more flexible
  powerpc/kvm: Make MMU notifiers HPT resize aware
  powerpc/kvm: Exclude HPT resizes when collecting the dirty log
  powerpc/kvm: Rehashing for HPT resizing
  powerpc/kvm: HPT resize pivot
  powerpc/kvm: Harvest RC bits from old HPT after HPT resize

 arch/powerpc/include/asm/firmware.h       |   5 +-
 arch/powerpc/include/asm/hvcall.h         |   2 +
 arch/powerpc/include/asm/kvm_book3s.h     |  12 +-
 arch/powerpc/include/asm/kvm_book3s_64.h  |  15 +
 arch/powerpc/include/asm/kvm_host.h       |  19 +-
 arch/powerpc/include/asm/kvm_ppc.h        |  11 +-
 arch/powerpc/include/asm/machdep.h        |   3 +-
 arch/powerpc/include/asm/mmu-hash64.h     |   3 +
 arch/powerpc/include/asm/plpar_wrappers.h |  12 +
 arch/powerpc/include/asm/prom.h           |   1 +
 arch/powerpc/include/asm/sparsemem.h      |   1 +
 arch/powerpc/kernel/prom_init.c           |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c       | 836 ++++++++++++++++++++++++++----
 arch/powerpc/kvm/book3s_hv.c              |  39 +-
 arch/powerpc/kvm/book3s_hv_builtin.c      |   8 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c       |  68 +--
 arch/powerpc/kvm/powerpc.c                |  17 +-
 arch/powerpc/mm/hash_utils_64.c           | 128 ++++-
 arch/powerpc/mm/init_64.c                 |  47 +-
 arch/powerpc/mm/mem.c                     |  14 +-
 arch/powerpc/platforms/pseries/firmware.c |   1 +
 arch/powerpc/platforms/pseries/lpar.c     | 119 ++++-
 include/uapi/linux/kvm.h                  |   1 +
 23 files changed, 1151 insertions(+), 213 deletions(-)

-- 
2.5.0
