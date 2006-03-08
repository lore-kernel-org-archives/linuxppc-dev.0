Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17422.16982.705624.256207@cargo.ozlabs.ibm.com>
Date: Wed, 8 Mar 2006 13:32:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc-merge.git
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do a pull from

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

There is just one new commit - the one from me fixing some problems in
the syscall entry/exit path.  There are 8 commits still there from the
last pull request.

Thanks,
Paul.

Benjamin Herrenschmidt:
      powerpc: Fix old g5 issues with windfarm
      powerpc: Fix windfarm_pm112 not starting all control loops
      powerpc: Expose SMT and L1 icache snoop userland features
      powerpc: incorrect rmo_top handling in prom_init

David Gibson:
      powerpc: Fix incorrect pud_ERROR() message

Paul Mackerras:
      powerpc: Fix might-sleep warning in program check exception handler
      powerpc: Turn off verbose debug output in powermac platform functions
      powerpc32: Fix timebase synchronization on 32-bit powermacs
      powerpc: Fix various syscall/signal/swapcontext bugs

 arch/powerpc/kernel/asm-offsets.c            |    1 
 arch/powerpc/kernel/cputable.c               |    9 ++
 arch/powerpc/kernel/entry_32.S               |   95 +++++++-------------------
 arch/powerpc/kernel/entry_64.S               |   94 ++++++--------------------
 arch/powerpc/kernel/prom_init.c              |    2 -
 arch/powerpc/kernel/ptrace.c                 |    5 -
 arch/powerpc/kernel/signal_32.c              |   19 +----
 arch/powerpc/kernel/signal_64.c              |    9 --
 arch/powerpc/kernel/systbl.S                 |    2 -
 arch/powerpc/kernel/traps.c                  |    2 +
 arch/powerpc/platforms/powermac/pfunc_base.c |    5 +
 arch/powerpc/platforms/powermac/pfunc_core.c |    6 ++
 arch/powerpc/platforms/powermac/smp.c        |    2 -
 arch/ppc/kernel/asm-offsets.c                |    1 
 arch/ppc/kernel/entry.S                      |   95 +++++++-------------------
 drivers/macintosh/windfarm_core.c            |    7 ++
 drivers/macintosh/windfarm_cpufreq_clamp.c   |    8 ++
 drivers/macintosh/windfarm_lm75_sensor.c     |   32 ++++++---
 drivers/macintosh/windfarm_max6690_sensor.c  |   25 +++++--
 drivers/macintosh/windfarm_pm112.c           |    8 +-
 include/asm-powerpc/cputable.h               |    2 +
 include/asm-powerpc/pgtable-4k.h             |    2 -
 include/asm-powerpc/thread_info.h            |    8 +-
 23 files changed, 163 insertions(+), 276 deletions(-)
