Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDqWS5W2rzDqv4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 11:17:55 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id q85so5883873pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:17:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 00/11] relaxing allocation constraints on radix and bare
 metal
Date: Sat, 22 Jul 2017 11:17:30 +1000
Message-Id: <20170722011741.13942-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This series isn't greatly polished or well tested yet, but it's
conceptually simple so I'll just get some comments. Powernv does not
have any real mode access limitation, and ISA3 radix does not have
any SLB/TLB limitation on the kernel linear address. We also can
avoid some allocations when not running as a LPAR guest.

After lifting these limits, we're in a better position to make some
of our important structures node-local. At least on radix. Hash could
as well, if node > 0 CPUs were to also bolt SLB corresponding with
their local memory (but that's left as an exercise for the reader).

Anyway, I'd be interested in comments.

Thanks,
Nick

Nicholas Piggin (11):
  powerpc/powernv: powernv platform is not constrained by RMA
  powerpc/powernv: Remove real mode access limit for early allocations
  powerpc/64s/radix: Remove SLB address limit for per-cpu stacks
  powerpc/64s: Relax PACA address limitations
  powerpc/64s/radix: Do not allocate SLB shadow structures
  powerpc/64s: do not allocate lppaca if we are not virtualized
  mm: make memblock_alloc_base_nid non-static
  powerpc/64: Allocate PACAs node-local if possible
  powerpc/64s: Allocate LPPACAs node-local if possible
  powerpc/64: allocate per-cpu stacks node-local if possible
  powerpc/64s/radix: allocate kernel page tables node-local if possible

 arch/powerpc/include/asm/book3s/64/hash.h    |   2 +-
 arch/powerpc/include/asm/book3s/64/radix.h   |   2 +-
 arch/powerpc/include/asm/kvm_ppc.h           |   8 +-
 arch/powerpc/include/asm/lppaca.h            |  15 +-
 arch/powerpc/include/asm/paca.h              |  12 +-
 arch/powerpc/include/asm/pmc.h               |  10 +-
 arch/powerpc/include/asm/smp.h               |   4 +-
 arch/powerpc/include/asm/sparsemem.h         |   2 +-
 arch/powerpc/kernel/asm-offsets.c            |   7 +
 arch/powerpc/kernel/crash.c                  |   2 +-
 arch/powerpc/kernel/head_64.S                |  12 +-
 arch/powerpc/kernel/machine_kexec_64.c       |  37 +++--
 arch/powerpc/kernel/paca.c                   | 192 ++++++++++++++++--------
 arch/powerpc/kernel/prom.c                   |  10 +-
 arch/powerpc/kernel/setup_64.c               |  69 +++++----
 arch/powerpc/kernel/smp.c                    |  10 +-
 arch/powerpc/kvm/book3s_hv.c                 |  21 +--
 arch/powerpc/kvm/book3s_hv_builtin.c         |   2 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S      |   3 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S      |   5 +-
 arch/powerpc/mm/hash_utils_64.c              |  26 ++--
 arch/powerpc/mm/mem.c                        |   4 +-
 arch/powerpc/mm/numa.c                       |  13 +-
 arch/powerpc/mm/pgtable-book3s64.c           |   6 +-
 arch/powerpc/mm/pgtable-radix.c              | 210 +++++++++++++++++----------
 arch/powerpc/platforms/85xx/smp.c            |   8 +-
 arch/powerpc/platforms/cell/smp.c            |   4 +-
 arch/powerpc/platforms/powernv/idle.c        |  13 +-
 arch/powerpc/platforms/powernv/opal.c        |   7 +-
 arch/powerpc/platforms/powernv/setup.c       |   4 +-
 arch/powerpc/platforms/powernv/smp.c         |   2 +-
 arch/powerpc/platforms/powernv/subcore.c     |   2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   2 +-
 arch/powerpc/platforms/pseries/lpar.c        |   4 +-
 arch/powerpc/platforms/pseries/setup.c       |   2 +-
 arch/powerpc/platforms/pseries/smp.c         |   4 +-
 arch/powerpc/sysdev/xics/icp-native.c        |   2 +-
 arch/powerpc/xmon/xmon.c                     |   2 +-
 include/linux/memblock.h                     |   5 +-
 mm/memblock.c                                |   2 +-
 40 files changed, 465 insertions(+), 282 deletions(-)

-- 
2.11.0
