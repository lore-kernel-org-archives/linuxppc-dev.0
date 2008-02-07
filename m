Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18346.59710.553689.906799@cargo.ozlabs.ibm.com>
Date: Thu, 7 Feb 2008 22:19:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Re: Please pull powerpc.git for-2.6.25 branch
In-Reply-To: <18346.31072.982702.10064@cargo.ozlabs.ibm.com>
References: <18346.31072.982702.10064@cargo.ozlabs.ibm.com>
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

I have added a few more commits since yesterday's pull request: some
commits updating the 4xx support from Josh Boyer's tree, a compile fix
for 52xx, and a string of commits from Roland McGrath to convert
powerpc over to using the new user_regset stuff for ptrace and core
dumps.

The diffstat and log below show all the commits that are waiting to be
pulled, including the ones in the previous pull request.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt    |   42 +
 arch/powerpc/Kconfig                            |   22 -
 arch/powerpc/Makefile                           |    9 
 arch/powerpc/boot/Makefile                      |  126 ++-
 arch/powerpc/boot/cuboot-mpc7448hpc2.c          |    0 
 arch/powerpc/boot/dts/adder875-redboot.dts      |    1 
 arch/powerpc/boot/dts/adder875-uboot.dts        |    1 
 arch/powerpc/boot/dts/mpc5121ads.dts            |  122 +++
 arch/powerpc/boot/dts/mpc8313erdb.dts           |    4 
 arch/powerpc/boot/dts/mpc8315erdb.dts           |    2 
 arch/powerpc/boot/dts/mpc834x_mds.dts           |    2 
 arch/powerpc/boot/dts/mpc8572ds.dts             |   12 
 arch/powerpc/boot/dts/mpc885ads.dts             |    1 
 arch/powerpc/boot/dts/sequoia.dts               |    8 
 arch/powerpc/boot/dts/storcenter.dts            |   12 
 arch/powerpc/boot/wrapper                       |   23 +
 arch/powerpc/configs/mpc83xx_defconfig          |   10 
 arch/powerpc/kernel/Makefile                    |    4 
 arch/powerpc/kernel/asm-offsets.c               |    3 
 arch/powerpc/kernel/binfmt_elf32.c              |   69 --
 arch/powerpc/kernel/cputable.c                  |   10 
 arch/powerpc/kernel/legacy_serial.c             |    3 
 arch/powerpc/kernel/pmc.c                       |    2 
 arch/powerpc/kernel/ptrace.c                    |  727 +++++++++++++-----
 arch/powerpc/kernel/ptrace32.c                  |  161 +---
 arch/powerpc/kernel/traps.c                     |    2 
 arch/powerpc/kernel/vio.c                       |    2 
 arch/powerpc/mm/mem.c                           |    7 
 arch/powerpc/mm/numa.c                          |   66 ++
 arch/powerpc/oprofile/Makefile                  |    2 
 arch/powerpc/oprofile/common.c                  |    6 
 arch/powerpc/oprofile/op_model_fsl_emb.c        |   28 -
 arch/powerpc/platforms/40x/Kconfig              |    1 
 arch/powerpc/platforms/40x/virtex.c             |    2 
 arch/powerpc/platforms/40x/walnut.c             |    1 
 arch/powerpc/platforms/44x/warp.c               |    2 
 arch/powerpc/platforms/512x/Kconfig             |   20 +
 arch/powerpc/platforms/512x/Makefile            |    4 
 arch/powerpc/platforms/512x/mpc5121_ads.c       |  104 +++
 arch/powerpc/platforms/82xx/mpc8272_ads.c       |    3 
 arch/powerpc/platforms/82xx/pq2fads.c           |    3 
 arch/powerpc/platforms/83xx/mpc832x_rdb.c       |    2 
 arch/powerpc/platforms/83xx/mpc83xx.h           |    2 
 arch/powerpc/platforms/83xx/usb.c               |   17 
 arch/powerpc/platforms/8xx/adder875.c           |    6 
 arch/powerpc/platforms/8xx/ep88xc.c             |    1 
 arch/powerpc/platforms/Kconfig                  |    2 
 arch/powerpc/platforms/Kconfig.cputype          |   10 
 arch/powerpc/platforms/Makefile                 |    1 
 arch/powerpc/platforms/cell/Kconfig             |    7 
 arch/powerpc/platforms/cell/axon_msi.c          |   99 +--
 arch/powerpc/platforms/cell/setup.c             |    2 
 arch/powerpc/platforms/cell/spufs/Makefile      |    2 
 arch/powerpc/platforms/cell/spufs/file.c        |    6 
 arch/powerpc/platforms/cell/spufs/inode.c       |   29 +
 arch/powerpc/platforms/cell/spufs/run.c         |    7 
 arch/powerpc/platforms/cell/spufs/sched.c       |   28 +
 arch/powerpc/platforms/cell/spufs/spufs.h       |    5 
 arch/powerpc/platforms/cell/spufs/sputrace.c    |  250 ++++++
 arch/powerpc/platforms/embedded6xx/storcenter.c |   25 -
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |    2 
 arch/powerpc/platforms/pseries/kexec.c          |    2 
 arch/powerpc/platforms/pseries/reconfig.c       |    1 
 arch/powerpc/platforms/pseries/xics.c           |  118 +--
 arch/powerpc/platforms/pseries/xics.h           |    3 
 arch/powerpc/sysdev/dcr.c                       |    5 
 arch/powerpc/sysdev/fsl_soc.c                   |    2 
 arch/powerpc/sysdev/mpc8xx_pic.c                |   10 
 arch/powerpc/sysdev/qe_lib/qe.c                 |   10 
 drivers/block/xsysace.c                         |    6 
 drivers/cdrom/viocd.c                           |    2 
 drivers/char/Kconfig                            |   10 
 drivers/char/Makefile                           |    1 
 drivers/char/xilinx_hwicap/Makefile             |    7 
 drivers/char/xilinx_hwicap/buffer_icap.c        |  380 ++++++++++
 drivers/char/xilinx_hwicap/buffer_icap.h        |   57 +
 drivers/char/xilinx_hwicap/fifo_icap.c          |  381 ++++++++++
 drivers/char/xilinx_hwicap/fifo_icap.h          |   62 ++
 drivers/char/xilinx_hwicap/xilinx_hwicap.c      |  904 +++++++++++++++++++++++
 drivers/char/xilinx_hwicap/xilinx_hwicap.h      |  193 +++++
 drivers/net/Kconfig                             |    4 
 drivers/net/cpmac.c                             |   55 -
 drivers/of/base.c                               |   25 +
 drivers/of/platform.c                           |   10 
 drivers/serial/Kconfig                          |   12 
 drivers/serial/mpc52xx_uart.c                   |  424 +++++++++--
 drivers/serial/uartlite.c                       |   53 -
 drivers/video/xilinxfb.c                        |    4 
 include/asm-powerpc/cputable.h                  |    2 
 include/asm-powerpc/dcr-native.h                |   47 +
 include/asm-powerpc/elf.h                       |    2 
 include/asm-powerpc/mpc512x.h                   |   22 +
 include/asm-powerpc/mpc52xx_psc.h               |   48 +
 include/asm-powerpc/oprofile_impl.h             |    2 
 include/asm-powerpc/ptrace.h                    |    2 
 include/asm-powerpc/reg.h                       |    4 
 include/asm-powerpc/reg_booke.h                 |   62 --
 include/asm-powerpc/reg_fsl_emb.h               |   72 ++
 include/asm-powerpc/system.h                    |    2 
 include/asm-powerpc/vio.h                       |    2 
 include/linux/elf.h                             |    1 
 include/linux/of.h                              |    1 
 102 files changed, 4173 insertions(+), 969 deletions(-)
 rename arch/powerpc/boot/{cuboot-hpc2.c => cuboot-mpc7448hpc2.c} (100%)
 create mode 100644 arch/powerpc/boot/dts/mpc5121ads.dts
 delete mode 100644 arch/powerpc/kernel/binfmt_elf32.c
 rename arch/powerpc/oprofile/{op_model_fsl_booke.c => op_model_fsl_emb.c} (90%)
 create mode 100644 arch/powerpc/platforms/512x/Kconfig
 create mode 100644 arch/powerpc/platforms/512x/Makefile
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_ads.c
 create mode 100644 arch/powerpc/platforms/cell/spufs/sputrace.c
 create mode 100644 drivers/char/xilinx_hwicap/Makefile
 create mode 100644 drivers/char/xilinx_hwicap/buffer_icap.c
 create mode 100644 drivers/char/xilinx_hwicap/buffer_icap.h
 create mode 100644 drivers/char/xilinx_hwicap/fifo_icap.c
 create mode 100644 drivers/char/xilinx_hwicap/fifo_icap.h
 create mode 100644 drivers/char/xilinx_hwicap/xilinx_hwicap.c
 create mode 100644 drivers/char/xilinx_hwicap/xilinx_hwicap.h
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

Grant Likely (4):
      [POWERPC] Fix incorrectly tagged __devinitdata structures
      [POWERPC] Eliminate broken OF console initialization.
      [POWERPC] bootwrapper: Build multiple cuImages
      [POWERPC] mpc52xx: fix compile error introduce when rebasing patch

Jeremy Kerr (1):
      [POWERPC] spufs: Fix SPE single-step mode

John Rigby (4):
      [POWERPC] mpc512x: Basic platform support
      [POWERPC] mpc512x: Device tree for MPC5121 ADS
      [POWERPC] mpc512x: Factor out 5200 dependencies from 52xx psc driver
      [POWERPC] mpc512x: Add MPC512x PSC support to MPC52xx psc driver

Jon Loeliger (1):
      [POWERPC] Fix storcenter DTS typos, feedback, IRQs.

Josh Boyer (1):
      [POWERPC] 4xx: Fix Walnut build

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

Roland McGrath (15):
      [POWERPC] Use user_regset accessors for FP regs
      [POWERPC] Use user_regset accessors for altivec regs
      [POWERPC] Use user_regset accessors for SPE regs
      [POWERPC] ptrace accessors for special regs MSR and TRAP
      [POWERPC] Use user_regset accessors for GPRs
      [POWERPC] Add user_regset_view definitions
      [POWERPC] Add user_regset compat support
      [POWERPC] Switch to using user_regset-based core dumps
      [POWERPC] Switch to generic compat_binfmt_elf code
      [POWERPC] Use regset code for PTRACE_*REGS* requests
      [POWERPC] Use generic ptrace peekdata/pokedata
      [POWERPC] Use generic compat_ptrace_request
      [POWERPC] Use generic compat_sys_ptrace
      [POWERPC] Use regset code for compat PTRACE_*REGS* calls
      [POWERPC] Add SPE registers to core dumps

Scott Wood (2):
      [POWERPC] 8xx: adder875, ep88xc: fix to match recent 8xx cleanups.
      [POWERPC] update_mmu_cache: Don't cache-flush non-readable pages

Sean MacLennan (1):
      [POWERPC] 4xx: Fix offset value on Warp board

Stephen Neuendorffer (3):
      [POWERPC] Xilinx: Update compatible to use values generated by BSP generator.
      [POWERPC] Xilinx: hwicap driver
      [POWERPC] Xilinx: hwicap: update booting-without-of.txt

Stephen Rothwell (3):
      [POWERPC] Avoid possible extra of_node_put in axon_msi.c
      [POWERPC] iSeries: Fix section mismatch in viodsasd
      [POWERPC] iSeries: Fix section mismatch in viocd

Tony Breeds (1):
      [POWERPC] Use a sensible default for clock_getres() in the VDSO

Valentine Barshak (4):
      [POWERPC] 4xx: Add USB ehci-ppc-of dts bindings.
      [POWERPC] 4xx: Add 440EPx Sequoia ehci dts entry
      [POWERPC] Add missing native dcr dcr_ind_lock spinlock
      [POWERPC] 4xx: PCIe indirect DCR spinlock fix.
