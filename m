Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZXcJ2GfTzDw6F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 11:07:44 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: michael@ellerman.id.au,
	paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCHv2 0/4] Hash Page Table resizing for PAPR guests
Date: Fri,  9 Dec 2016 11:07:34 +1100
Message-Id: <20161209000738.8984-1-david@gibson.dropbear.id.au>
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

Changes since v1:
  * Remove two patches which belong with the (upcoming) host side
    support rather than guest side (and therefore also should go via
    the kvm tree instead of the powerpc tree)
  * Protected the debugfs code with #ifdef CONFIG_DEBUG_FS.  Couldn't
    actually get a compile error myself, but the KVM buildbot did get
    one.

David Gibson (4):
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
 arch/powerpc/mm/hash_utils_64.c               |  61 ++++++++++++++
 arch/powerpc/mm/mem.c                         |   4 +
 arch/powerpc/platforms/pseries/firmware.c     |   1 +
 arch/powerpc/platforms/pseries/lpar.c         | 110 ++++++++++++++++++++++++++
 11 files changed, 198 insertions(+), 4 deletions(-)

-- 
2.9.3
