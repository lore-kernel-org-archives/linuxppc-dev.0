Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EBED1A0E27
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 16:23:07 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, thuth@redhat.com,
 lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 0/9] PAPR hash page table resizing (guest side)
Date: Fri, 29 Jan 2016 16:23:54 +1100
Message-Id: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here's a second prototype of the guest side work for runtime resizing
of the has page table in PAPR guests.

This is now feature complete.  It implements the resizing, advertises
it with CAS, and will automatically invoke it to maintain a good HPT
size when memory is hot-added or hot-removed.

Patches 1-5 are standalone prerequisite cleanups that I'll be pushing
concurrently.

David Gibson (9):
  memblock: Don't mark memblock_phys_mem_size() as __init
  arch/powerpc: Clean up error handling for htab_remove_mapping
  arch/powerpc: Handle removing maybe-present bolted HPTEs
  arch/powerpc: Clean up memory hotplug failure paths
  arch/powerpc: Split hash page table sizing heuristic into a helper
  pseries: Add hypercall wrappers for hash page table resizing
  pseries: Add support for hash table resizing
  pseries: Advertise HPT resizing support via CAS
  pseries: Automatically resize HPT for memory hot add/remove

 arch/powerpc/include/asm/firmware.h       |   5 +-
 arch/powerpc/include/asm/hvcall.h         |   2 +
 arch/powerpc/include/asm/machdep.h        |   3 +-
 arch/powerpc/include/asm/mmu-hash64.h     |   3 +
 arch/powerpc/include/asm/plpar_wrappers.h |  12 +++
 arch/powerpc/include/asm/prom.h           |   1 +
 arch/powerpc/include/asm/sparsemem.h      |   1 +
 arch/powerpc/kernel/prom_init.c           |   2 +-
 arch/powerpc/mm/hash_utils_64.c           | 121 ++++++++++++++++++++++++------
 arch/powerpc/mm/init_64.c                 |  47 ++++++++----
 arch/powerpc/mm/mem.c                     |  14 +++-
 arch/powerpc/platforms/pseries/firmware.c |   1 +
 arch/powerpc/platforms/pseries/lpar.c     | 117 ++++++++++++++++++++++++++++-
 mm/memblock.c                             |   2 +-
 14 files changed, 281 insertions(+), 50 deletions(-)

-- 
2.5.0
