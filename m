Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35Zd30rnzDrdP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:17:28 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id s3so12729934plp.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 03:17:28 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 0/9] modernize early memory allocation limits and
Date: Fri, 22 Dec 2017 21:17:07 +1000
Message-Id: <20171222111716.13101-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series improves (mostly relaxes) limits on early memory
allocations for stacks, pacas, etc. on 64s.

It also avoids allocating lppacas for bare metal, and it changes
allocation of paca and lppaca from single big arrays to inividual
allocations.

The main goal of this is toward allocating these basic structures
per-node. We're not there yet, but closer.

Thanks,
Nick

Nicholas Piggin (9):
  powerpc/powernv: Remove real mode access limit for early allocations
  powerpc/pseries: radix is not subject to RMA limit, remove it
  powerpc/64: rtas avoid accessing paca in 32-bit mode
  powerpc/pseries: lift RTAS limit for radix
  powerpc/pseries: lift RTAS limit for hash
  powerpc/64s: Relax PACA address limitations
  powerpc/64s: do not allocate lppaca if we are not virtualized
  powerpc/64: Use array of paca pointers and allocate pacas individually
  powerpc/64s: Use array of lppaca pointers and allocate lppacas
    individually

 arch/powerpc/include/asm/kvm_ppc.h           |   8 +-
 arch/powerpc/include/asm/lppaca.h            |  26 ++--
 arch/powerpc/include/asm/paca.h              |  12 +-
 arch/powerpc/include/asm/pmc.h               |  13 +-
 arch/powerpc/include/asm/smp.h               |   4 +-
 arch/powerpc/kernel/asm-offsets.c            |   5 +
 arch/powerpc/kernel/crash.c                  |   2 +-
 arch/powerpc/kernel/entry_64.S               |  17 ++-
 arch/powerpc/kernel/head_64.S                |  19 +--
 arch/powerpc/kernel/machine_kexec_64.c       |  37 +++---
 arch/powerpc/kernel/paca.c                   | 174 ++++++++++++++-------------
 arch/powerpc/kernel/setup.h                  |   4 +
 arch/powerpc/kernel/setup_64.c               |  40 +++---
 arch/powerpc/kernel/smp.c                    |  10 +-
 arch/powerpc/kernel/sysfs.c                  |   2 +-
 arch/powerpc/kvm/book3s_hv.c                 |  34 +++---
 arch/powerpc/kvm/book3s_hv_builtin.c         |   2 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S      |   3 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S      |   3 +-
 arch/powerpc/mm/hash_utils_64.c              |  24 ++--
 arch/powerpc/mm/numa.c                       |   4 +-
 arch/powerpc/mm/pgtable-radix.c              |  17 +--
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
 36 files changed, 289 insertions(+), 229 deletions(-)

-- 
2.15.0
