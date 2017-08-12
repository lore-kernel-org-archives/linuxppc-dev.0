Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xV0CC5vl5zDr4v
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 21:34:31 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 83so5061825pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 04:34:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 0/9] improve early structure allocations (paca, lppaca, etc)
Date: Sat, 12 Aug 2017 21:34:07 +1000
Message-Id: <20170812113416.15978-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I last posted this series here,

http://marc.info/?l=linuxppc-embedded&m=150068630827162&w=2

Since then it's become apparent that NUMA allocation support was not
quite right and will require some fiddly rejigging of the early dt
parsing to make it work. So I've dropped those NUMA patches from the
series for now.

The series relaxes memory allocation limits on various platforms (e.g.,
powernv has no RMA restriction, radix has no SLB restriction, etc). It
also avoids unnecessary allocations (powernv does not require lppaca,
radix does not require SLB).

Finally, it moves paca and lppaca allocations from a single big array
to a table of pointers. This gets to a point where we can easily
allocate these on local node if we had the topology info available at
the time of allocation (which we don't at the moment).

I also found a small KVM bug I think (patch 1).

Thanks,
Nick

Nicholas Piggin (9):
  KVM: PPC: Book3S HV: Fix H_REGISTER_VPA VPA size validation
  powerpc/powernv: powernv platform is not constrained by RMA
  powerpc/powernv: Remove real mode access limit for early allocations
  powerpc/64s/radix: Remove bolted-SLB address limit for per-cpu stacks
  powerpc/64s: Relax PACA address limitations
  powerpc/64s/radix: Do not allocate SLB shadow structures
  powerpc/64s: do not allocate lppaca if we are not virtualized
  powerpc/64: Use a table of paca pointers and allocate pacas
    individually
  powerpc/64: Use a table of lppaca pointers and allocate lppacas
    individually

 arch/powerpc/include/asm/kvm_ppc.h           |   8 +-
 arch/powerpc/include/asm/lppaca.h            |  26 ++--
 arch/powerpc/include/asm/paca.h              |  12 +-
 arch/powerpc/include/asm/pmc.h               |  10 +-
 arch/powerpc/include/asm/smp.h               |   4 +-
 arch/powerpc/kernel/asm-offsets.c            |   7 ++
 arch/powerpc/kernel/crash.c                  |   2 +-
 arch/powerpc/kernel/head_64.S                |  12 +-
 arch/powerpc/kernel/machine_kexec_64.c       |  30 +++--
 arch/powerpc/kernel/paca.c                   | 178 +++++++++++++++++----------
 arch/powerpc/kernel/prom.c                   |  10 +-
 arch/powerpc/kernel/setup.h                  |   4 +
 arch/powerpc/kernel/setup_64.c               |  36 +++---
 arch/powerpc/kernel/smp.c                    |  10 +-
 arch/powerpc/kvm/book3s_hv.c                 |  22 ++--
 arch/powerpc/kvm/book3s_hv_builtin.c         |   2 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S      |   3 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S      |   5 +-
 arch/powerpc/mm/hash_utils_64.c              |  24 ++--
 arch/powerpc/mm/numa.c                       |   4 +-
 arch/powerpc/mm/pgtable-radix.c              |  33 ++---
 arch/powerpc/mm/tlb-radix.c                  |   2 +-
 arch/powerpc/platforms/85xx/smp.c            |   8 +-
 arch/powerpc/platforms/cell/smp.c            |   4 +-
 arch/powerpc/platforms/powernv/idle.c        |  13 +-
 arch/powerpc/platforms/powernv/opal.c        |   7 +-
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
 36 files changed, 301 insertions(+), 206 deletions(-)

-- 
2.13.3
