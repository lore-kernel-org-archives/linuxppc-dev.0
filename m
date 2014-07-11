Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BB391A0175
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jul 2014 15:44:32 +1000 (EST)
Message-ID: <1405057463.20996.32.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2014 15:44:23 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here are a few more powerpc fixes for 3.16

There's a small series of 3 patches that fix saving/restoring MMUCR2
when using KVM without which perf goes completely bonkers in the host
system. Another perf fix from Anton that's been rotting away in patchwork
due to my poor eyesight, a couple of compile fixes, a little addition
to the WSP removal by Michael (removing a bit more dead stuff) and
a fix for an embarassing regression with our soft irq masking.

Cheers,
Ben.

The following changes since commit 6663a4fa6711050036562ddfd2086edf735fae21:

  powerpc: Don't skip ePAPR spin-table CPUs (2014-06-25 13:10:49 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to f56029410a13cae3652d1f34788045c40a13ffc7:

  powerpc/perf: Never program book3s PMCs with values >= 0x80000000 (2014-07-11 13:50:47 +1000)

----------------------------------------------------------------
Anton Blanchard (1):
      powerpc/perf: Never program book3s PMCs with values >= 0x80000000

Guenter Roeck (1):
      powerpc: Disable RELOCATABLE for COMPILE_TEST with PPC64

Joel Stanley (3):
      powerpc/kvm: Remove redundant save of SIER AND MMCR2
      powerpc/perf: Add PPMU_ARCH_207S define
      powerpc/perf: Clear MMCR2 when enabling PMU

Michael Ellerman (2):
      powerpc/cell: Fix compilation with CONFIG_COREDUMP=n
      powerpc: Clean up MMU_FTRS_A2 and MMU_FTR_TYPE_3E

Preeti U Murthy (1):
      powerpc/powernv: Check for IRQHAPPENED before sleeping

 arch/powerpc/Kconfig                         |  3 ++-
 arch/powerpc/include/asm/mmu.h               | 10 +---------
 arch/powerpc/include/asm/perf_event_server.h |  3 +--
 arch/powerpc/kernel/idle_power7.S            |  2 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S      |  5 -----
 arch/powerpc/mm/mmu_context_nohash.c         | 12 +-----------
 arch/powerpc/perf/core-book3s.c              | 26 ++++++++++++++++++++++----
 arch/powerpc/perf/power8-pmu.c               |  2 +-
 arch/powerpc/platforms/cell/spu_syscalls.c   |  2 ++
 arch/powerpc/platforms/cell/spufs/Makefile   |  3 ++-
 arch/powerpc/platforms/cell/spufs/syscalls.c |  6 ++++--
 11 files changed, 37 insertions(+), 37 deletions(-)
