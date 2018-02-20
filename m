Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmCwB4zSPzDqpl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 08:11:20 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 17so3962206pfw.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 13:11:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/9] powerpc cpu feature and kernel build stuff
Date: Wed, 21 Feb 2018 05:08:23 +1000
Message-Id: <20180220190832.1872-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are various things that came up after taking a look
at dt_cpu_ftrs again. Just a bunch of small cleanups and
fixes.

Nicholas Piggin (9):
  powerpc/64s: cputable add all POWER9 features to CPU_FTRS_ALWAYS
  powerpc/64s: fix CPU_FTRS_POSSIBLE vector features
  powerpc/64s: kbuild set assembler machine type to POWER4
  powerpc/64s: dt_cpu_ftrs fix POWER9 DD2.2 and above
  powerpc: remove unused CPU_FTR_ARCH_201
  powerpc/64s: remove POWER4 support
  powerpc/64/le: add GENERIC_CPU support
  powerpc/64s/le: refine feature sets for little endian builds
  powerpc/64s: add POWER9 CPU type selection

 arch/powerpc/Makefile                  |  12 +-
 arch/powerpc/include/asm/cputable.h    |  33 +-
 arch/powerpc/include/asm/mmu.h         |   6 +-
 arch/powerpc/include/asm/ppc_asm.h     |  11 +-
 arch/powerpc/kernel/cputable.c         |  36 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c      |   4 +-
 arch/powerpc/kernel/entry_64.S         |   2 +-
 arch/powerpc/kernel/exceptions-64s.S   |  10 +-
 arch/powerpc/kernel/prom_init.c        |  10 +-
 arch/powerpc/kvm/emulate.c             |   6 -
 arch/powerpc/lib/copypage_power7.S     |   3 -
 arch/powerpc/lib/copyuser_power7.S     |   3 -
 arch/powerpc/lib/memcpy_power7.S       |   3 -
 arch/powerpc/mm/hash_utils_64.c        |   9 +-
 arch/powerpc/perf/Makefile             |   2 +-
 arch/powerpc/perf/power4-pmu.c         | 622 ---------------------------------
 arch/powerpc/platforms/Kconfig.cputype |  17 +-
 17 files changed, 63 insertions(+), 726 deletions(-)
 delete mode 100644 arch/powerpc/perf/power4-pmu.c

-- 
2.16.1
