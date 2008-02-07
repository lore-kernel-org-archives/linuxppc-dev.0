Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18346.31072.982702.10064@cargo.ozlabs.ibm.com>
Date: Thu, 7 Feb 2008 14:22:08 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git for-2.6.25 branch
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

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git for-2.6.25

to get another powerpc update for 2.6.25.  Various bug fixes have come
in, plus there are a few patches that I missed from the previous set.

Thanks,
Paul.

 arch/powerpc/Kconfig                            |   21 -
 arch/powerpc/Makefile                           |    9 
 arch/powerpc/boot/Makefile                      |  126 ++++---
 arch/powerpc/boot/cuboot-mpc7448hpc2.c          |    0 
 arch/powerpc/boot/dts/adder875-redboot.dts      |    1 
 arch/powerpc/boot/dts/adder875-uboot.dts        |    1 
 arch/powerpc/boot/dts/mpc5121ads.dts            |  122 +++++++
 arch/powerpc/boot/dts/mpc8313erdb.dts           |    4 
 arch/powerpc/boot/dts/mpc8315erdb.dts           |    2 
 arch/powerpc/boot/dts/mpc834x_mds.dts           |    2 
 arch/powerpc/boot/dts/mpc8572ds.dts             |   12 +
 arch/powerpc/boot/dts/mpc885ads.dts             |    1 
 arch/powerpc/boot/dts/storcenter.dts            |   12 -
 arch/powerpc/boot/wrapper                       |   23 +
 arch/powerpc/configs/mpc83xx_defconfig          |   10 -
 arch/powerpc/kernel/asm-offsets.c               |    3 
 arch/powerpc/kernel/cputable.c                  |   10 -
 arch/powerpc/kernel/legacy_serial.c             |    3 
 arch/powerpc/kernel/pmc.c                       |    2 
 arch/powerpc/kernel/traps.c                     |    2 
 arch/powerpc/kernel/vio.c                       |    2 
 arch/powerpc/mm/mem.c                           |    7 
 arch/powerpc/mm/numa.c                          |   66 +++-
 arch/powerpc/oprofile/Makefile                  |    2 
 arch/powerpc/oprofile/common.c                  |    6 
 arch/powerpc/oprofile/op_model_fsl_emb.c        |   28 +
 arch/powerpc/platforms/512x/Kconfig             |   20 +
 arch/powerpc/platforms/512x/Makefile            |    4 
 arch/powerpc/platforms/512x/mpc5121_ads.c       |  104 ++++++
 arch/powerpc/platforms/82xx/mpc8272_ads.c       |    3 
 arch/powerpc/platforms/82xx/pq2fads.c           |    3 
 arch/powerpc/platforms/83xx/mpc832x_rdb.c       |    2 
 arch/powerpc/platforms/83xx/mpc83xx.h           |    2 
 arch/powerpc/platforms/83xx/usb.c               |   17 +
 arch/powerpc/platforms/8xx/adder875.c           |    6 
 arch/powerpc/platforms/8xx/ep88xc.c             |    1 
 arch/powerpc/platforms/Kconfig                  |    2 
 arch/powerpc/platforms/Kconfig.cputype          |   10 -
 arch/powerpc/platforms/Makefile                 |    1 
 arch/powerpc/platforms/cell/Kconfig             |    7 
 arch/powerpc/platforms/cell/axon_msi.c          |   99 ++---
 arch/powerpc/platforms/cell/setup.c             |    2 
 arch/powerpc/platforms/cell/spufs/Makefile      |    2 
 arch/powerpc/platforms/cell/spufs/file.c        |    6 
 arch/powerpc/platforms/cell/spufs/inode.c       |   29 +-
 arch/powerpc/platforms/cell/spufs/run.c         |    7 
 arch/powerpc/platforms/cell/spufs/sched.c       |   28 +
 arch/powerpc/platforms/cell/spufs/spufs.h       |    5 
 arch/powerpc/platforms/cell/spufs/sputrace.c    |  250 +++++++++++++
 arch/powerpc/platforms/embedded6xx/storcenter.c |   25 -
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |    2 
 arch/powerpc/platforms/pseries/kexec.c          |    2 
 arch/powerpc/platforms/pseries/reconfig.c       |    1 
 arch/powerpc/platforms/pseries/xics.c           |  118 +++---
 arch/powerpc/platforms/pseries/xics.h           |    3 
 arch/powerpc/sysdev/fsl_soc.c                   |    2 
 arch/powerpc/sysdev/mpc8xx_pic.c                |   10 -
 arch/powerpc/sysdev/qe_lib/qe.c                 |   10 -
 drivers/cdrom/viocd.c                           |    2 
 drivers/net/Kconfig                             |    4 
 drivers/net/cpmac.c                             |   55 +--
 drivers/of/base.c                               |   25 +
 drivers/of/platform.c                           |   10 +
 drivers/serial/Kconfig                          |   12 -
 drivers/serial/mpc52xx_uart.c                   |  431 +++++++++++++++++++----
 include/asm-powerpc/cputable.h                  |    2 
 include/asm-powerpc/mpc512x.h                   |   22 +
 include/asm-powerpc/mpc52xx_psc.h               |   48 +++
 include/asm-powerpc/oprofile_impl.h             |    2 
 include/asm-powerpc/reg.h                       |    4 
 include/asm-powerpc/reg_booke.h                 |   62 ---
 include/asm-powerpc/reg_fsl_emb.h               |   72 ++++
 include/asm-powerpc/system.h                    |    2 
 include/asm-powerpc/vio.h                       |    2 
 include/linux/of.h                              |    1 
 75 files changed, 1534 insertions(+), 482 deletions(-)
 rename arch/powerpc/boot/{cuboot-hpc2.c => cuboot-mpc7448hpc2.c} (100%)
 create mode 100644 arch/powerpc/boot/dts/mpc5121ads.dts
 rename arch/powerpc/oprofile/{op_model_fsl_booke.c => op_model_fsl_emb.c} (90%)
 create mode 100644 arch/powerpc/platforms/512x/Kconfig
 create mode 100644 arch/powerpc/platforms/512x/Makefile
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_ads.c
 create mode 100644 arch/powerpc/platforms/cell/spufs/sputrace.c
 create mode 100644 include/asm-powerpc/mpc512x.h
 create mode 100644 include/asm-powerpc/reg_fsl_emb.h

Andre Detsch (1):
      [POWERPC] spufs: Fix memory leak on SPU affinity

Andy Fleming (2):
      [POWERPC] Made FSL Book-E PMC support more generic
      [POWERPC} Add oprofile support for e300

Anton Vorontsov (2):
      cpmac: convert to new Fixed PHY infrastructure
      [POWERPC] qe_lib: fix few fluffy negligences

Balbir Singh (1):
      [POWERPC] Fake NUMA emulation for PowerPC

Bryan O'Donoghue (1):
      [POWERPC] 8xx: Add clock-frequency to adder875 and mpc885ads dts

Christoph Hellwig (1):
      [POWERPC] spufs: Add marker-based tracing facility

Grant Likely (1):
      [POWERPC] bootwrapper: Build multiple cuImages

Jeremy Kerr (1):
      [POWERPC] spufs: Fix SPE single-step mode

John Rigby (4):
      [POWERPC] mpc512x: Basic platform support
      [POWERPC] mpc512x: Device tree for MPC5121 ADS
      [POWERPC] mpc512x: Factor out 5200 dependencies from 52xx psc driver
      [POWERPC] mpc512x: Add MPC512x PSC support to MPC52xx psc driver

Jon Loeliger (1):
      [POWERPC] Fix storcenter DTS typos, feedback, IRQs.

Julia Lawall (3):
      [POWERPC] arch/powerpc/platforms/pseries: Add missing of_node_put
      [POWERPC] arch/powerpc/sysdev: Add missing of_node_put
      [POWERPC] arch/powerpc/platforms/82xx: Add missing of_node_put

Kim Phillips (6):
      [POWERPC] 83xx: configure USB clock for MPC8315E
      [POWERPC] 83xx: Correct 2nd PCI controller interrupt value in mpc834x_mds dts
      [POWERPC] 83xx: Add rtc node to mpc8313erdb dts
      [POWERPC] 83xx: mpc832x_rdb: fix compiler warning
      [POWERPC] FSL: fix mpc83xx_spi device registration
      [POWERPC] 83xx: Update mpc83xx_defconfig

Kumar Gala (1):
      [POWERPC] 85xx: Add second cpu to 8572 dts

Michael Ellerman (6):
      [POWERPC] Add of_get_next_parent()
      [POWERPC] Search for and publish cell OF platform devices earlier
      [POWERPC] Create and hook up of_platform_device_shutdown
      [POWERPC] Convert axon_msi to an of_platform driver
      [POWERPC] Avoid DMA exception when using axon_msi with IOMMU
      [POWERPC] Fix legacy serial search for opb bus ports

Nathan Fontenot (4):
      [POWERPC] Update irq descriptor affinity
      [POWERPC] Split xics_teardown_cpu()
      [POWERPC] Remove redundant of_get_cpu_node routine
      [POWERPC] Update default irq servers when boot cpu is removed

Olof Johansson (1):
      [POWERPC] Fix compilation for CONFIG_DEBUGGER=n and CONFIG_KEXEC=y

Scott Wood (2):
      [POWERPC] 8xx: adder875, ep88xc: fix to match recent 8xx cleanups.
      [POWERPC] update_mmu_cache: Don't cache-flush non-readable pages

Stephen Rothwell (3):
      [POWERPC] Avoid possible extra of_node_put in axon_msi.c
      [POWERPC] iSeries: Fix section mismatch in viodsasd
      [POWERPC] iSeries: Fix section mismatch in viocd

Tony Breeds (1):
      [POWERPC] Use a sensible default for clock_getres() in the VDSO
