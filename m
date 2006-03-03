Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17416.10009.397916.760085@cargo.ozlabs.ibm.com>
Date: Fri, 3 Mar 2006 22:23:05 +1100
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

More bugfixes, including a fix for the nasty timebase synchronization
bug reported by Kyle Moffett, plus a patch from Ben H. to tell
userland (via the AT_HWCAP mechanism) if the cpu has hardware threads
and if the i-cache snoops the d-cache.

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

 arch/powerpc/kernel/cputable.c               |    9 +++++--
 arch/powerpc/kernel/prom_init.c              |    2 +-
 arch/powerpc/kernel/traps.c                  |    2 ++
 arch/powerpc/platforms/powermac/pfunc_base.c |    5 ++++
 arch/powerpc/platforms/powermac/pfunc_core.c |    6 +++++
 arch/powerpc/platforms/powermac/smp.c        |    2 +-
 drivers/macintosh/windfarm_core.c            |    7 ++++++
 drivers/macintosh/windfarm_cpufreq_clamp.c   |    8 +++++++
 drivers/macintosh/windfarm_lm75_sensor.c     |   32 +++++++++++++++++++-------
 drivers/macintosh/windfarm_max6690_sensor.c  |   25 +++++++++++++++-----
 drivers/macintosh/windfarm_pm112.c           |    8 ++++---
 include/asm-powerpc/cputable.h               |    2 ++
 include/asm-powerpc/pgtable-4k.h             |    2 +-
 13 files changed, 85 insertions(+), 25 deletions(-)
