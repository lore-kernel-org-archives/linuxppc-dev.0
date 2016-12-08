Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZ3RV5tVzzDvHy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 16:13:26 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: michael@ellerman.id.au,
	paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/6] powerpc: Hash Page Table resizing for PAPR guests
Date: Thu,  8 Dec 2016 16:13:15 +1100
Message-Id: <20161208051321.31446-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series implements the guest side of a PAPR ACR which allows a
POWER guest's Hashed Page Table (HPT) to be resized at runtime.  This
is useful when a guest has a very large theoretical maximum RAM, but
is likely to only ever be expanded to a modest amount of RAM in
practice.  Without resizing the HPT has to be sized for the maximum
possible guest RAM, which can be very wasteful if that maximum is
never reached.

To use this requires a hypervisor/host which also supports the PAPR
extension.  The only implementation so far is my qemu branch at
    https://github.com/dgibson/qemu/tree/upstream/hpt-resize
    
I expect to merge that code to upstream qemu for qemu-2.9.  Note that
HPT resizing will so far only work for TCG guests, KVM support is in
the works.  The guest side code here will not require changing for
KVM, however.

An HPT resize can be triggered in one of two ways:
    * /sys/kernel/debug/powerpc/pft-size

        This debugfs file contains the current size of the HPT (as
        encoded in the ibm,pft-size) device tree property.  Writing to
        it will cause the guest to attempt an HPT resize to the given
        value.  Note that the current qemu implementation will not
        allow the guest to resize the HPT to more than 1/64th of guest
        RAM size.

    * Automatically on memory hotplug / unplug

        With these patches applied, the guest will automatically
        attempt to resize its HPT when its RAM size changes due to
        hotplug events.  (When hot adding RAM qemu considers the new
        size for purposes of the limit mentioned above, so this method
        can lift the HPT size larger than the former).

David Gibson (6):
  kvm: Move KVM_PPC_PVINFO_FLAGS_EV_IDLE definition next to its
    structure
  powerpc/kvm: Corectly report KVM_CAP_PPC_ALLOC_HTAB
  pseries: Add hypercall wrappers for hash page table resizing
  pseries: Add support for hash table resizing
  pseries: Advertise HPT resizing support via CAS
  pseries: Automatically resize HPT for memory hot add/remove

 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   1 +
 arch/powerpc/include/asm/firmware.h           |   5 +-
 arch/powerpc/include/asm/hvcall.h             |   4 +-
 arch/powerpc/include/asm/plpar_wrappers.h     |  12 +++
 arch/powerpc/include/asm/prom.h               |   1 +
 arch/powerpc/include/asm/sparsemem.h          |   1 +
 arch/powerpc/kernel/prom_init.c               |   2 +-
 arch/powerpc/kvm/powerpc.c                    |   5 +-
 arch/powerpc/mm/hash_utils_64.c               |  57 +++++++++++++
 arch/powerpc/mm/mem.c                         |   4 +
 arch/powerpc/platforms/pseries/firmware.c     |   1 +
 arch/powerpc/platforms/pseries/lpar.c         | 110 ++++++++++++++++++++++++++
 include/uapi/linux/kvm.h                      |   5 +-
 13 files changed, 201 insertions(+), 7 deletions(-)

-- 
2.9.3
