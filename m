Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17264.9241.956155.64385@cargo.ozlabs.ibm.com>
Date: Tue, 8 Nov 2005 15:05:45 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: please pull powerpc-merge.git
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

to get a powerpc update - various bug fixes (including Ben's fix for
the oops that Martin Bligh reported), some powermac and 8xx updates,
and a bit more merging.  Diffstat and shortlog follow.

Thanks,
Paul.

 arch/powerpc/Kconfig                            |    9 
 arch/powerpc/configs/g5_defconfig               |  261 +++++--
 arch/powerpc/kernel/misc_64.S                   |   70 ++
 arch/powerpc/kernel/process.c                   |    4 
 arch/powerpc/kernel/prom.c                      |   21 -
 arch/powerpc/kernel/prom_init.c                 |   11 
 arch/powerpc/kernel/rtas.c                      |    5 
 arch/powerpc/kernel/setup-common.c              |   40 +
 arch/powerpc/kernel/setup_32.c                  |    1 
 arch/powerpc/kernel/setup_64.c                  |   46 -
 arch/powerpc/kernel/signal_32.c                 |    1 
 arch/powerpc/kernel/signal_64.c                 |    1 
 arch/powerpc/kernel/smp.c                       |    1 
 arch/powerpc/kernel/time.c                      |    5 
 arch/powerpc/kernel/traps.c                     |   11 
 arch/powerpc/lib/locks.c                        |    1 
 arch/powerpc/mm/fault.c                         |   17 
 arch/powerpc/mm/hash_utils_64.c                 |   10 
 arch/powerpc/mm/init_64.c                       |    1 
 arch/powerpc/mm/mem.c                           |    2 
 arch/powerpc/mm/numa.c                          |    1 
 arch/powerpc/mm/pgtable_64.c                    |    1 
 arch/powerpc/oprofile/op_model_power4.c         |   24 +
 arch/powerpc/platforms/iseries/irq.c            |    5 
 arch/powerpc/platforms/iseries/pci.c            |   37 -
 arch/powerpc/platforms/iseries/setup.c          |    4 
 arch/powerpc/platforms/iseries/smp.c            |    1 
 arch/powerpc/platforms/powermac/Makefile        |    3 
 arch/powerpc/platforms/powermac/cpufreq_32.c    |   15 
 arch/powerpc/platforms/powermac/cpufreq_64.c    |  323 ++++++++
 arch/powerpc/platforms/powermac/setup.c         |   13 
 arch/powerpc/platforms/pseries/iommu.c          |    2 
 arch/powerpc/platforms/pseries/lpar.c           |    3 
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   10 
 arch/powerpc/platforms/pseries/ras.c            |    2 
 arch/powerpc/platforms/pseries/setup.c          |   18 
 arch/powerpc/sysdev/i8259.c                     |    5 
 arch/powerpc/sysdev/u3_iommu.c                  |    1 
 arch/ppc/kernel/misc.S                          |  145 +++-
 arch/ppc/kernel/traps.c                         |   12 
 arch/ppc/syslib/m8xx_wdt.c                      |   13 
 arch/ppc/syslib/prom.c                          |    4 
 arch/ppc/xmon/xmon.c                            |    5 
 arch/ppc64/Kconfig                              |   11 
 arch/ppc64/Kconfig.debug                        |    4 
 arch/ppc64/kernel/idle.c                        |    1 
 arch/ppc64/kernel/machine_kexec.c               |    1 
 arch/ppc64/kernel/misc.S                        |   72 ++
 arch/ppc64/kernel/pci.c                         |   17 
 arch/ppc64/kernel/prom.c                        |   25 +
 arch/ppc64/kernel/prom_init.c                   |    3 
 arch/ppc64/kernel/rtas_pci.c                    |    6 
 arch/ppc64/kernel/udbg.c                        |   55 -
 drivers/block/swim3.c                           |   20 -
 drivers/ide/ppc/pmac.c                          |    9 
 drivers/macintosh/Kconfig                       |   19 
 drivers/macintosh/Makefile                      |    9 
 drivers/macintosh/smu.c                         |  174 ++++-
 drivers/macintosh/via-pmu.c                     |   10 
 drivers/macintosh/windfarm.h                    |  131 +++
 drivers/macintosh/windfarm_core.c               |  426 +++++++++++
 drivers/macintosh/windfarm_cpufreq_clamp.c      |  105 +++
 drivers/macintosh/windfarm_lm75_sensor.c        |  263 +++++++
 drivers/macintosh/windfarm_pid.c                |  145 ++++
 drivers/macintosh/windfarm_pid.h                |   84 ++
 drivers/macintosh/windfarm_pm81.c               |  879 +++++++++++++++++++++++
 drivers/macintosh/windfarm_pm91.c               |  814 +++++++++++++++++++++
 drivers/macintosh/windfarm_smu_controls.c       |  282 +++++++
 drivers/macintosh/windfarm_smu_sensors.c        |  479 +++++++++++++
 fs/proc/proc_devtree.c                          |   57 +
 include/asm-powerpc/ide.h                       |   29 -
 include/asm-powerpc/machdep.h                   |    4 
 include/asm-powerpc/ppc-pci.h                   |    1 
 include/asm-powerpc/prom.h                      |    2 
 include/asm-powerpc/reg.h                       |    9 
 include/asm-powerpc/smp.h                       |    4 
 include/asm-powerpc/smu.h                       |  199 +++++
 include/asm-powerpc/xmon.h                      |    1 
 include/asm-ppc/btext.h                         |   22 -
 include/asm-ppc/io.h                            |   12 
 include/asm-ppc/kgdb.h                          |    2 
 include/asm-ppc/prom.h                          |    2 
 include/asm-ppc64/ide.h                         |   30 -
 include/asm-ppc64/pci.h                         |    8 
 include/asm-ppc64/ppcdebug.h                    |  108 ---
 include/asm-ppc64/prom.h                        |    2 
 include/asm-ppc64/udbg.h                        |    3 
 include/linux/proc_fs.h                         |    9 
 88 files changed, 5134 insertions(+), 579 deletions(-)
 rename arch/powerpc/platforms/powermac/{cpufreq.c => cpufreq_32.c} (99%)
 create mode 100644 arch/powerpc/platforms/powermac/cpufreq_64.c
 create mode 100644 drivers/macintosh/windfarm.h
 create mode 100644 drivers/macintosh/windfarm_core.c
 create mode 100644 drivers/macintosh/windfarm_cpufreq_clamp.c
 create mode 100644 drivers/macintosh/windfarm_lm75_sensor.c
 create mode 100644 drivers/macintosh/windfarm_pid.c
 create mode 100644 drivers/macintosh/windfarm_pid.h
 create mode 100644 drivers/macintosh/windfarm_pm81.c
 create mode 100644 drivers/macintosh/windfarm_pm91.c
 create mode 100644 drivers/macintosh/windfarm_smu_controls.c
 create mode 100644 drivers/macintosh/windfarm_smu_sensors.c
 rename include/{asm-ppc/ide.h => asm-powerpc/ide.h} (78%)
 delete mode 100644 include/asm-ppc64/ide.h
 delete mode 100644 include/asm-ppc64/ppcdebug.h

Anton Blanchard:
      ppc64: fix Memory: summary line
      ppc64: fix oprofile sample bit handling
      ppc64: remove some direct xmon calls

Benjamin Herrenschmidt:
      ppc64: SMU based macs cpufreq support
      ppc64: SMU partition recovery
      ppc64: Update g5_defconfig for ARCH=powerpc
      ppc64: More U3 device-tree fixes
      ppc64: Thermal control for SMU based machines
      ppc: fix a bunch of warnings
      ppc: Fix ARCH=ppc build with xmon
      ppc: Fix PowerBook HD led on ARCH=powerpc
      ppc64: Fix the lazy icache/dcache code for non-RAM pages

David Gibson:
      powerpc: Kill ppcdebug

David Woodhouse:
      powerpc: Fix i8259 cascade IRQ
      powerpc: Fix ppc32 initrd

John Rose:
      dlpar enable for OF pci probe

Marcelo Tosatti:
      ppc32 8xx: fix m8xx_wdt accessor macro update
      ppc32: handle access to non-present IO ports on 8xx

Michael Ellerman:
      powerpc: Make ppc_md.set_dabr non 64-bit specific

Mike Kravetz:
      Memory Add Fixes for ppc64

Olof Johansson:
      powerpc: Nicer printing of address at oops

Paul Mackerras:
      powerpc: Various UP build fixes
      Merge ../linux-2.6
      Merge ../linux-2.6
      powerpc: Fix typo in pmac_cpufreq_resume
      macintosh: Always export pmu_[un]register_sleep_notifier if CONFIG_PM set
      powermac: Use a spinlock in swim3.c (floppy driver) instead of cli

Stephen Rothwell:
      powerpc: merge ide.h
