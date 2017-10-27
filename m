Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNVjy1d9zzDrbl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 15:08:53 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9R47kdA137528
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 00:08:50 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2duusgmdgs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 00:08:50 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 26 Oct 2017 22:08:49 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 00/16] Remove hash page table slot tracking from linux PTE
Date: Fri, 27 Oct 2017 09:38:17 +0530
Message-Id: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

With hash translation mode we always tracked the hash pte slot details in linux page table.
This occupied space in the linux page table and also limitted our ability to support
linux features that require additional PTE bits. This series attempt to lift this
limitation by not tracking slot number in linux page table. We still track slot details
w.r.t Transparent Hugepage entries because an invalidate there requires us to go through
all the 256 hash pte slots. So tracking whether hash page table entry is valid helps us in
avoiding a lot of hcalls there. With THP entries we don't keep slot details in the primary
linux page table entry but in the second half of page table. Hence tracking slot details
for THP doesn't take up space in PTE.

Even though we don't track slot, for removing/updating hash page table entry, PAPR hcalls expect
hash page table slot details. On pseries we find slot using H_READ hcall using H_READ_4 flags.
This implies an additional 2 hcalls in the updatepp and remove paths. The patch series also
attempt to limit the impact of this by adding new hcalls that does remove/update of hash page table
entry using hash value instead of hash page table slot.

Below is the performance numbers observed when running a workload that does the below sequence

for(5000) {
mmap(128M)
touch every page of 2048 page
munmap()
}

The test is run with address randomization off, swap disabled in both host and guest.


|------------+----------+---------------+--------------------------+-----------------------|
| iterations | platform | without patch | With series and no hcall | With series and hcall |
|------------+----------+---------------+--------------------------+-----------------------|
|          1 | powernv  |               |                50.818343 |                       |
|          2 | powernv  |               |                50.744123 |                       |
|          3 | powernv  |               |                50.721603 |                       |
|          4 | powernv  |               |                50.739922 |                       |
|          5 | powernv  |               |                50.638555 |                       |
|          1 | powernv  |     51.388249 |                          |                       |
|          2 | powernv  |     51.789701 |                          |                       |
|          3 | powernv  |     52.240394 |                          |                       |
|          4 | powernv  |     51.432255 |                          |                       |
|          5 | powernv  |     51.392947 |                          |                       |
|------------+----------+---------------+--------------------------+-----------------------|
|          1 | pseries  |               |                          |            123.154394 |
|          2 | pseries  |               |                          |            122.253956 |
|          3 | pseries  |               |                          |            117.666344 |
|          4 | pseries  |               |                          |            117.681479 |
|          5 | pseries  |               |                          |            117.735808 |
|          1 | pseries  |               |               119.424940 |                       |
|          2 | pseries  |               |               117.663078 |                       |
|          3 | pseries  |               |               118.345584 |                       |
|          4 | pseries  |               |               119.620934 |                       |
|          5 | pseries  |               |               119.463185 |                       |
|          1 | pseries  |    122.810867 |                          |                       |
|          2 | pseries  |    115.760801 |                          |                       |
|          3 | pseries  |    115.257030 |                          |                       |
|          4 | pseries  |    116.617884 |                          |                       |
|          5 | pseries  |    117.247036 |                          |                       |
|------------+----------+---------------+--------------------------+-----------------------|

-aneesh

Aneesh Kumar K.V (16):
  powerpc/mm/hash: Remove the superfluous bitwise operation when find
    hpte group
  powerpc/mm: Update native_hpte_find to return hash pte
  powerpc/pseries: Update hpte find helper to take hash value
  powerpc/mm: Add hash invalidate callback
  powerpc/mm: use hash_invalidate for __kernel_map_pages()
  powerpc/mm: Switch flush_hash_range to not use slot
  powerpc/mm: Add hash updatepp callback
  powerpc/mm/hash: Don't track hash pte slot number in linux page table.
  powerpc/mm: Add new firmware feature HASH API
  powerpc/kvm/hash: Implement HASH_REMOVE hcall
  powerpc/kvm/hash: Implement HASH_PROTECT hcall
  powerpc/kvm/hash: Implement HASH_BULK_REMOVE hcall
  powerpc/mm/pseries: Use HASH_PROTECT hcall in guest
  powerpc/mm/pseries: Use HASH_REMOVE hcall in guest
  powerpc/mm/pseries: Move slot based bulk remove to helper
  powerpc/mm/pseries: Use HASH_BULK_REMOVE hcall in guest

 arch/powerpc/include/asm/book3s/64/hash-4k.h       |  16 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  44 +--
 arch/powerpc/include/asm/book3s/64/hash.h          |   5 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |  12 +
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  26 --
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |   3 +-
 arch/powerpc/include/asm/firmware.h                |   3 +-
 arch/powerpc/include/asm/hvcall.h                  |   5 +-
 arch/powerpc/include/asm/pgtable-be-types.h        |  10 -
 arch/powerpc/include/asm/pgtable-types.h           |   9 -
 arch/powerpc/include/asm/plpar_wrappers.h          |  23 ++
 arch/powerpc/kvm/book3s_hv.c                       |   3 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                | 297 ++++++++++++++++++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   4 +
 arch/powerpc/kvm/powerpc.c                         |   4 +
 arch/powerpc/mm/dump_hashpagetable.c               |   2 +-
 arch/powerpc/mm/dump_linuxpagetables.c             |  10 -
 arch/powerpc/mm/hash64_4k.c                        |  17 +-
 arch/powerpc/mm/hash64_64k.c                       | 124 +++------
 arch/powerpc/mm/hash_native_64.c                   | 175 ++++++++----
 arch/powerpc/mm/hash_utils_64.c                    |  75 ++----
 arch/powerpc/mm/hugepage-hash64.c                  |   9 +-
 arch/powerpc/mm/hugetlbpage-hash64.c               |  13 +-
 arch/powerpc/mm/tlb_hash64.c                       |   9 +-
 arch/powerpc/platforms/ps3/htab.c                  |  88 ++++++
 arch/powerpc/platforms/pseries/firmware.c          |   1 +
 arch/powerpc/platforms/pseries/lpar.c              | 196 +++++++++++---
 include/uapi/linux/kvm.h                           |   1 +
 28 files changed, 760 insertions(+), 424 deletions(-)

-- 
2.13.6
