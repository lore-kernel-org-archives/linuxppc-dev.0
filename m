Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x22b.google.com (mail-pg0-x22b.google.com
 [IPv6:2607:f8b0:400e:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgmBt0sZkzF1Nt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 02:08:37 +1100 (AEDT)
Received: by mail-pg0-x22b.google.com with SMTP id y8so35582pgr.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:08:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 00/14] numa aware allocation for pacas, stacks, pagetables
Date: Wed, 14 Feb 2018 01:08:10 +1000
Message-Id: <20180213150824.27689-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series allows numa aware allocations for various early data
structures for radix. Hash still has a bolted SLB limitation that
prevents at least pacas and stacks from node-affine allocations.

Fixed up a number of bugs, got pSeries working, added a couple more
cases where page tables can be allocated node-local.

Thanks,
Nick

Nicholas Piggin (14):
  powerpc/64s: do not allocate lppaca if we are not virtualized
  powerpc/64: Use array of paca pointers and allocate pacas individually
  powerpc/64s: allocate lppacas individually
  powerpc/64s: allocate slb_shadow structures individually
  mm: make memblock_alloc_base_nid non-static
  powerpc/mm/numa: move numa topology discovery earlier
  powerpc/64: move default SPR recording
  powerpc/setup: cpu_to_phys_id array
  powerpc/64: defer paca allocation until memory topology is discovered
  powerpc/64: allocate pacas per node
  powerpc/64: allocate per-cpu stacks node-local if possible
  powerpc: pass node id into create_section_mapping
  powerpc/64s/radix: split early page table mapping to its own function
  powerpc/64s/radix: allocate kernel page tables node-local if possible

 arch/powerpc/include/asm/book3s/64/hash.h    |   2 +-
 arch/powerpc/include/asm/book3s/64/radix.h   |   2 +-
 arch/powerpc/include/asm/kvm_ppc.h           |   8 +-
 arch/powerpc/include/asm/lppaca.h            |  26 +--
 arch/powerpc/include/asm/paca.h              |  16 +-
 arch/powerpc/include/asm/pmc.h               |  13 +-
 arch/powerpc/include/asm/setup.h             |   1 +
 arch/powerpc/include/asm/smp.h               |   5 +-
 arch/powerpc/include/asm/sparsemem.h         |   2 +-
 arch/powerpc/kernel/asm-offsets.c            |   5 +
 arch/powerpc/kernel/crash.c                  |   2 +-
 arch/powerpc/kernel/head_64.S                |  19 ++-
 arch/powerpc/kernel/machine_kexec_64.c       |  37 +++--
 arch/powerpc/kernel/paca.c                   | 238 ++++++++++++++-------------
 arch/powerpc/kernel/prom.c                   |  12 +-
 arch/powerpc/kernel/setup-common.c           |  30 +++-
 arch/powerpc/kernel/setup.h                  |   9 +-
 arch/powerpc/kernel/setup_64.c               |  80 ++++++---
 arch/powerpc/kernel/smp.c                    |  10 +-
 arch/powerpc/kernel/sysfs.c                  |  18 +-
 arch/powerpc/kvm/book3s_hv.c                 |  34 ++--
 arch/powerpc/kvm/book3s_hv_builtin.c         |   2 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S      |   3 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S      |   3 +-
 arch/powerpc/mm/hash_utils_64.c              |   2 +-
 arch/powerpc/mm/mem.c                        |   9 +-
 arch/powerpc/mm/numa.c                       |  36 ++--
 arch/powerpc/mm/pgtable-book3s64.c           |   6 +-
 arch/powerpc/mm/pgtable-radix.c              | 203 ++++++++++++++++-------
 arch/powerpc/mm/tlb-radix.c                  |   2 +-
 arch/powerpc/platforms/85xx/smp.c            |   8 +-
 arch/powerpc/platforms/cell/smp.c            |   4 +-
 arch/powerpc/platforms/powernv/idle.c        |  13 +-
 arch/powerpc/platforms/powernv/setup.c       |   4 +-
 arch/powerpc/platforms/powernv/smp.c         |   2 +-
 arch/powerpc/platforms/powernv/subcore.c     |   2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   2 +-
 arch/powerpc/platforms/pseries/kexec.c       |   7 +-
 arch/powerpc/platforms/pseries/lpar.c        |   4 +-
 arch/powerpc/platforms/pseries/setup.c       |   2 +-
 arch/powerpc/platforms/pseries/smp.c         |   4 +-
 arch/powerpc/sysdev/xics/icp-native.c        |   2 +-
 arch/powerpc/xmon/xmon.c                     |   2 +-
 include/linux/memblock.h                     |   5 +-
 mm/memblock.c                                |   2 +-
 45 files changed, 543 insertions(+), 355 deletions(-)

-- 
2.16.1
