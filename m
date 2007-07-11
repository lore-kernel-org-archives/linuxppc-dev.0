Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18068.24740.835856.894886@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jul 2007 14:46:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
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
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a powerpc update for 2.6.23.

Note the changes to Documentation/cachetlb.txt, mm/vmalloc.c and
include/linux/vmalloc.h - that is Ben H's change of unmap_vm_area to
unmap_kernel_range, which was OK'd by Andrew Morton.

Thanks,
Paul.

 Documentation/cachetlb.txt                        |    2 
 Documentation/feature-removal-schedule.txt        |   12 
 Documentation/powerpc/booting-without-of.txt      |   40 +
 arch/powerpc/Kconfig                              |  267 -------
 arch/powerpc/Makefile                             |    2 
 arch/powerpc/boot/44x.c                           |   45 +
 arch/powerpc/boot/44x.h                           |    3 
 arch/powerpc/boot/Makefile                        |   81 +-
 arch/powerpc/boot/cuboot-83xx.c                   |   13 
 arch/powerpc/boot/cuboot-85xx.c                   |   13 
 arch/powerpc/boot/cuboot-ebony.c                  |   16 
 arch/powerpc/boot/cuboot.c                        |   35 +
 arch/powerpc/boot/cuboot.h                        |   14 
 arch/powerpc/boot/dcr.h                           |   37 +
 arch/powerpc/boot/dts/ebony.dts                   |   12 
 arch/powerpc/boot/dts/holly.dts                   |   52 +
 arch/powerpc/boot/dts/mpc7448hpc2.dts             |   33 -
 arch/powerpc/boot/dts/mpc8272ads.dts              |   42 -
 arch/powerpc/boot/dts/mpc832x_mds.dts             |   16 
 arch/powerpc/boot/dts/mpc832x_rdb.dts             |   16 
 arch/powerpc/boot/dts/mpc8349emitx.dts            |   10 
 arch/powerpc/boot/dts/mpc834x_mds.dts             |   10 
 arch/powerpc/boot/dts/mpc836x_mds.dts             |   16 
 arch/powerpc/boot/dts/mpc8540ads.dts              |  147 ++--
 arch/powerpc/boot/dts/mpc8541cds.dts              |   90 +-
 arch/powerpc/boot/dts/mpc8544ds.dts               |   18 
 arch/powerpc/boot/dts/mpc8548cds.dts              |  108 +--
 arch/powerpc/boot/dts/mpc8555cds.dts              |   90 +-
 arch/powerpc/boot/dts/mpc8560ads.dts              |  148 ++--
 arch/powerpc/boot/dts/mpc8568mds.dts              |   66 +-
 arch/powerpc/boot/dts/mpc8641_hpcn.dts            |  147 +++-
 arch/powerpc/boot/dts/mpc866ads.dts               |   31 -
 arch/powerpc/boot/dts/mpc885ads.dts               |   54 +
 arch/powerpc/boot/dts/prpmc2800.dts               |    2 
 arch/powerpc/boot/dts/ps3.dts                     |   68 ++
 arch/powerpc/boot/ebony.c                         |   19 
 arch/powerpc/boot/main.c                          |    2 
 arch/powerpc/boot/of.c                            |  212 -----
 arch/powerpc/boot/of.h                            |   21 +
 arch/powerpc/boot/ofconsole.c                     |   45 +
 arch/powerpc/boot/oflib.c                         |  202 +++++
 arch/powerpc/boot/ops.h                           |    4 
 arch/powerpc/boot/ps3-head.S                      |   80 ++
 arch/powerpc/boot/ps3-hvcall.S                    |  184 +++++
 arch/powerpc/boot/ps3.c                           |  161 ++++
 arch/powerpc/boot/serial.c                        |    2 
 arch/powerpc/boot/stdio.c                         |   10 
 arch/powerpc/boot/types.h                         |    4 
 arch/powerpc/boot/wrapper                         |   55 +
 arch/powerpc/boot/zImage.ps3.lds.S                |   50 +
 arch/powerpc/configs/holly_defconfig              |    6 
 arch/powerpc/configs/ps3_defconfig                |   52 +
 arch/powerpc/kernel/Makefile                      |    7 
 arch/powerpc/kernel/cputable.c                    |   35 +
 arch/powerpc/kernel/head_32.S                     |  122 ---
 arch/powerpc/kernel/head_64.S                     |    4 
 arch/powerpc/kernel/io.c                          |   12 
 arch/powerpc/kernel/irq.c                         |   60 +-
 arch/powerpc/kernel/isa-bridge.c                  |  271 +++++++
 arch/powerpc/kernel/misc_32.S                     |   10 
 arch/powerpc/kernel/misc_64.S                     |   26 -
 arch/powerpc/kernel/of_platform.c                 |    8 
 arch/powerpc/kernel/pci-common.c                  |  454 ++++++++++++
 arch/powerpc/kernel/pci_32.c                      |  510 -------------
 arch/powerpc/kernel/pci_64.c                      |  750 +++----------------
 arch/powerpc/kernel/ppc_ksyms.c                   |    5 
 arch/powerpc/kernel/process.c                     |   14 
 arch/powerpc/kernel/prom.c                        |   29 -
 arch/powerpc/kernel/prom_init.c                   |    4 
 arch/powerpc/kernel/ptrace-common.h               |  161 ----
 arch/powerpc/kernel/ptrace.c                      |  325 ++++++--
 arch/powerpc/kernel/ptrace32.c                    |  239 +++---
 arch/powerpc/kernel/rtas_pci.c                    |    7 
 arch/powerpc/kernel/setup-common.c                |   21 +
 arch/powerpc/kernel/setup_32.c                    |   12 
 arch/powerpc/kernel/setup_64.c                    |   12 
 arch/powerpc/kernel/signal.c                      |  180 +++++
 arch/powerpc/kernel/signal.h                      |   55 +
 arch/powerpc/kernel/signal_32.c                   |  191 +----
 arch/powerpc/kernel/signal_64.c                   |  182 -----
 arch/powerpc/kernel/sysfs.c                       |    5 
 arch/powerpc/kernel/time.c                        |   65 +-
 arch/powerpc/kernel/vdso.c                        |    2 
 arch/powerpc/kernel/vmlinux.lds.S                 |    6 
 arch/powerpc/mm/44x_mmu.c                         |    1 
 arch/powerpc/mm/4xx_mmu.c                         |    1 
 arch/powerpc/mm/Makefile                          |    3 
 arch/powerpc/mm/fault.c                           |    2 
 arch/powerpc/mm/fsl_booke_mmu.c                   |    1 
 arch/powerpc/mm/hash_native_64.c                  |   27 -
 arch/powerpc/mm/hash_utils_64.c                   |    2 
 arch/powerpc/mm/imalloc.c                         |  313 --------
 arch/powerpc/mm/init_32.c                         |    1 
 arch/powerpc/mm/init_64.c                         |    1 
 arch/powerpc/mm/mem.c                             |    3 
 arch/powerpc/mm/mmu_context_32.c                  |    1 
 arch/powerpc/mm/mmu_decl.h                        |   17 
 arch/powerpc/mm/pgtable_32.c                      |  123 ---
 arch/powerpc/mm/pgtable_64.c                      |  206 +----
 arch/powerpc/mm/ppc_mmu_32.c                      |    7 
 arch/powerpc/mm/stab.c                            |    4 
 arch/powerpc/mm/tlb_32.c                          |    1 
 arch/powerpc/mm/tlb_64.c                          |   57 +
 arch/powerpc/oprofile/op_model_power4.c           |   14 
 arch/powerpc/platforms/52xx/efika.c               |   13 
 arch/powerpc/platforms/52xx/lite5200.c            |    2 
 arch/powerpc/platforms/52xx/mpc52xx_pci.c         |   18 
 arch/powerpc/platforms/52xx/mpc52xx_pm.c          |    8 
 arch/powerpc/platforms/82xx/Kconfig               |    2 
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |   17 
 arch/powerpc/platforms/83xx/Kconfig               |    2 
 arch/powerpc/platforms/83xx/Makefile              |    2 
 arch/powerpc/platforms/83xx/mpc8313_rdb.c         |    8 
 arch/powerpc/platforms/83xx/mpc832x_mds.c         |    7 
 arch/powerpc/platforms/83xx/mpc832x_rdb.c         |    7 
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |    9 
 arch/powerpc/platforms/83xx/mpc834x_mds.c         |   56 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c         |    7 
 arch/powerpc/platforms/83xx/mpc83xx.h             |   34 +
 arch/powerpc/platforms/83xx/pci.c                 |   18 
 arch/powerpc/platforms/83xx/usb.c                 |  181 +++++
 arch/powerpc/platforms/85xx/misc.c                |   32 +
 arch/powerpc/platforms/85xx/mpc8544_ds.c          |   15 
 arch/powerpc/platforms/85xx/mpc85xx.h             |    2 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |   32 -
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |  116 +--
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |   28 -
 arch/powerpc/platforms/85xx/pci.c                 |   11 
 arch/powerpc/platforms/86xx/Kconfig               |    2 
 arch/powerpc/platforms/86xx/mpc86xx.h             |   11 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |   27 -
 arch/powerpc/platforms/86xx/pci.c                 |   67 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c           |    5 
 arch/powerpc/platforms/8xx/mpc885ads_setup.c      |   71 ++
 arch/powerpc/platforms/Kconfig                    |   29 +
 arch/powerpc/platforms/Kconfig.cputype            |  221 ++++++
 arch/powerpc/platforms/apus/Kconfig               |  130 ---
 arch/powerpc/platforms/cell/io-workarounds.c      |    2 
 arch/powerpc/platforms/cell/spu_base.c            |   59 +-
 arch/powerpc/platforms/cell/spufs/backing_ops.c   |    6 
 arch/powerpc/platforms/cell/spufs/context.c       |   15 
 arch/powerpc/platforms/cell/spufs/fault.c         |   29 +
 arch/powerpc/platforms/cell/spufs/file.c          |  149 ++++
 arch/powerpc/platforms/cell/spufs/inode.c         |   10 
 arch/powerpc/platforms/cell/spufs/run.c           |   45 +
 arch/powerpc/platforms/cell/spufs/sched.c         |  476 ++++++++++--
 arch/powerpc/platforms/cell/spufs/spu_restore.c   |    2 
 arch/powerpc/platforms/cell/spufs/spu_save.c      |    2 
 arch/powerpc/platforms/cell/spufs/spufs.h         |   84 ++
 arch/powerpc/platforms/cell/spufs/switch.c        |   18 
 arch/powerpc/platforms/chrp/Kconfig               |    1 
 arch/powerpc/platforms/chrp/Makefile              |    3 
 arch/powerpc/platforms/chrp/pci.c                 |    7 
 arch/powerpc/platforms/embedded6xx/Kconfig        |    2 
 arch/powerpc/platforms/embedded6xx/holly.c        |    2 
 arch/powerpc/platforms/embedded6xx/linkstation.c  |   10 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    9 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h |    5 
 arch/powerpc/platforms/iseries/call_hpt.h         |    9 
 arch/powerpc/platforms/iseries/htab.c             |    8 
 arch/powerpc/platforms/iseries/pci.c              |    7 
 arch/powerpc/platforms/iseries/setup.c            |    6 
 arch/powerpc/platforms/maple/pci.c                |   41 -
 arch/powerpc/platforms/pasemi/Kconfig             |    9 
 arch/powerpc/platforms/pasemi/Makefile            |    1 
 arch/powerpc/platforms/pasemi/electra_ide.c       |   96 ++
 arch/powerpc/platforms/pasemi/pci.c               |   24 -
 arch/powerpc/platforms/pasemi/setup.c             |    2 
 arch/powerpc/platforms/powermac/Kconfig           |    1 
 arch/powerpc/platforms/powermac/low_i2c.c         |   23 -
 arch/powerpc/platforms/powermac/pci.c             |   46 -
 arch/powerpc/platforms/ps3/Kconfig                |   26 -
 arch/powerpc/platforms/ps3/Makefile               |    1 
 arch/powerpc/platforms/ps3/device-init.c          |  785 ++++++++++++++++++++
 arch/powerpc/platforms/ps3/htab.c                 |   31 -
 arch/powerpc/platforms/ps3/interrupt.c            |  272 ++++---
 arch/powerpc/platforms/ps3/mm.c                   |  632 +++++++++++++---
 arch/powerpc/platforms/ps3/os-area.c              |    4 
 arch/powerpc/platforms/ps3/platform.h             |   43 +
 arch/powerpc/platforms/ps3/repository.c           |  586 ++++++++-------
 arch/powerpc/platforms/ps3/setup.c                |  105 ++-
 arch/powerpc/platforms/ps3/smp.c                  |   18 
 arch/powerpc/platforms/ps3/spu.c                  |   13 
 arch/powerpc/platforms/ps3/system-bus.c           |  562 ++++++++++++--
 arch/powerpc/platforms/ps3/time.c                 |    2 
 arch/powerpc/platforms/pseries/Makefile           |    2 
 arch/powerpc/platforms/pseries/eeh.c              |   19 
 arch/powerpc/platforms/pseries/eeh_cache.c        |    5 
 arch/powerpc/platforms/pseries/eeh_driver.c       |    6 
 arch/powerpc/platforms/pseries/eeh_sysfs.c        |   87 ++
 arch/powerpc/platforms/pseries/lpar.c             |   17 
 arch/powerpc/platforms/pseries/pci_dlpar.c        |    9 
 arch/powerpc/platforms/pseries/plpar_wrappers.h   |   15 
 arch/powerpc/platforms/pseries/pseries.h          |    2 
 arch/powerpc/platforms/pseries/reconfig.c         |    2 
 arch/powerpc/platforms/pseries/setup.c            |    2 
 arch/powerpc/platforms/pseries/xics.c             |   53 +
 arch/powerpc/sysdev/Makefile                      |    6 
 arch/powerpc/sysdev/fsl_pcie.c                    |  171 ----
 arch/powerpc/sysdev/fsl_soc.c                     |   13 
 arch/powerpc/sysdev/indirect_pci.c                |   44 +
 arch/powerpc/sysdev/mpc8xx_pic.h                  |   11 
 arch/powerpc/sysdev/mv64x60_dev.c                 |   28 +
 arch/powerpc/sysdev/mv64x60_pci.c                 |    7 
 arch/powerpc/sysdev/qe_lib/ucc.c                  |    2 
 arch/powerpc/sysdev/qe_lib/ucc_fast.c             |    8 
 arch/powerpc/sysdev/rtc_cmos_setup.c              |   49 +
 arch/powerpc/sysdev/timer.c                       |   14 
 arch/powerpc/sysdev/tsi108_dev.c                  |   33 +
 arch/powerpc/sysdev/tsi108_pci.c                  |   10 
 arch/powerpc/xmon/xmon.c                          |    2 
 arch/ppc/kernel/misc.S                            |    8 
 arch/ppc/kernel/ppc_ksyms.c                       |    1 
 arch/ppc/kernel/setup.c                           |    2 
 arch/ppc/mm/tlb.c                                 |    1 
 arch/ppc/platforms/prep_setup.c                   |    3 
 arch/ppc/syslib/Makefile                          |    1 
 arch/ppc/syslib/indirect_pci.c                    |  134 +++
 arch/ppc/syslib/virtex_devices.c                  |   38 +
 drivers/block/viodasd.c                           |    4 
 drivers/char/briq_panel.c                         |   10 
 drivers/char/hvc_console.c                        |    2 
 drivers/char/viotape.c                            |   12 
 drivers/pci/hotplug/rpadlpar_core.c               |    6 
 drivers/pcmcia/Kconfig                            |   17 
 drivers/pcmcia/m8xx_pcmcia.c                      |  351 ++++-----
 drivers/ps3/Makefile                              |    5 
 drivers/ps3/ps3av.c                               |  372 +++++-----
 drivers/ps3/ps3av_cmd.c                           |   51 -
 drivers/ps3/ps3stor_lib.c                         |  302 ++++++++
 drivers/ps3/sys-manager-core.c                    |   68 ++
 drivers/ps3/sys-manager.c                         |  290 +++++--
 drivers/ps3/vuart.c                               |  817 +++++++++++++--------
 drivers/ps3/vuart.h                               |   71 +-
 drivers/rtc/Kconfig                               |    2 
 drivers/serial/cpm_uart/cpm_uart_core.c           |    2 
 drivers/serial/of_serial.c                        |   33 +
 drivers/video/Kconfig                             |    4 
 drivers/video/ps3fb.c                             |  290 +++----
 include/asm-powerpc/cache.h                       |    4 
 include/asm-powerpc/cputable.h                    |  111 +--
 include/asm-powerpc/floppy.h                      |    6 
 include/asm-powerpc/hvcall.h                      |    1 
 include/asm-powerpc/io.h                          |   26 -
 include/asm-powerpc/irq.h                         |    9 
 include/asm-powerpc/lppaca.h                      |    2 
 include/asm-powerpc/lv1call.h                     |    3 
 include/asm-powerpc/machdep.h                     |    2 
 include/asm-powerpc/mmu-8xx.h                     |  147 ++++
 include/asm-powerpc/mmu-fsl-booke.h               |   88 ++
 include/asm-powerpc/mmu-hash32.h                  |   91 ++
 include/asm-powerpc/mmu-hash64.h                  |    9 
 include/asm-powerpc/mmu.h                         |   13 
 include/asm-powerpc/mmu_context.h                 |  202 +++++
 include/asm-powerpc/mpc86xx.h                     |    6 
 include/asm-powerpc/mpc8xx.h                      |    4 
 include/asm-powerpc/pci-bridge.h                  |  148 +++-
 include/asm-powerpc/pci.h                         |   11 
 include/asm-powerpc/pgtable-ppc32.h               |   50 -
 include/asm-powerpc/pgtable-ppc64.h               |   50 -
 include/asm-powerpc/pgtable.h                     |   28 +
 include/asm-powerpc/ppc-pci.h                     |    9 
 include/asm-powerpc/processor.h                   |    8 
 include/asm-powerpc/prom.h                        |   18 
 include/asm-powerpc/ps3.h                         |  182 +++--
 include/asm-powerpc/ps3av.h                       |   48 +
 include/asm-powerpc/ps3fb.h                       |   12 
 include/asm-powerpc/ps3stor.h                     |   71 ++
 include/asm-powerpc/ptrace.h                      |   22 -
 include/asm-powerpc/reg.h                         |    2 
 include/asm-powerpc/spu.h                         |   24 +
 include/asm-powerpc/syscalls.h                    |    7 
 include/asm-powerpc/system.h                      |    4 
 include/asm-powerpc/termbits.h                    |    4 
 include/asm-powerpc/thread_info.h                 |   12 
 include/asm-powerpc/time.h                        |    4 
 include/asm-powerpc/tlbflush.h                    |    5 
 include/linux/fsl_devices.h                       |    5 
 include/linux/vmalloc.h                           |    3 
 mm/vmalloc.c                                      |   13 
 280 files changed, 10940 insertions(+), 6951 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot.c
 create mode 100644 arch/powerpc/boot/cuboot.h
 create mode 100644 arch/powerpc/boot/dts/ps3.dts
 create mode 100644 arch/powerpc/boot/of.h
 create mode 100644 arch/powerpc/boot/ofconsole.c
 create mode 100644 arch/powerpc/boot/oflib.c
 create mode 100644 arch/powerpc/boot/ps3-head.S
 create mode 100644 arch/powerpc/boot/ps3-hvcall.S
 create mode 100644 arch/powerpc/boot/ps3.c
 create mode 100644 arch/powerpc/boot/zImage.ps3.lds.S
 create mode 100644 arch/powerpc/kernel/isa-bridge.c
 create mode 100644 arch/powerpc/kernel/pci-common.c
 delete mode 100644 arch/powerpc/kernel/ptrace-common.h
 create mode 100644 arch/powerpc/kernel/signal.c
 create mode 100644 arch/powerpc/kernel/signal.h
 delete mode 100644 arch/powerpc/mm/imalloc.c
 create mode 100644 arch/powerpc/platforms/83xx/usb.c
 create mode 100644 arch/powerpc/platforms/Kconfig.cputype
 delete mode 100644 arch/powerpc/platforms/apus/Kconfig
 create mode 100644 arch/powerpc/platforms/pasemi/electra_ide.c
 create mode 100644 arch/powerpc/platforms/ps3/device-init.c
 create mode 100644 arch/powerpc/platforms/pseries/eeh_sysfs.c
 delete mode 100644 arch/powerpc/sysdev/fsl_pcie.c
 create mode 100644 arch/powerpc/sysdev/rtc_cmos_setup.c
 create mode 100644 arch/ppc/syslib/indirect_pci.c
 create mode 100644 drivers/ps3/ps3stor_lib.c
 create mode 100644 drivers/ps3/sys-manager-core.c
 create mode 100644 include/asm-powerpc/mmu-8xx.h
 create mode 100644 include/asm-powerpc/mmu-fsl-booke.h
 create mode 100644 include/asm-powerpc/mmu-hash32.h
 create mode 100644 include/asm-powerpc/ps3stor.h

Adrian Bunk (1):
      [POWERPC] Make drivers/char/hvc_console.c:khvcd() static

Anton Blanchard (1):
      [POWERPC] Reserve threadinfo flags for perfmon2

Arnd Bergmann (7):
      [POWERPC] Split out CPU specific options into a new Kconfig file
      [POWERPC] move 82xx/83xx/86xx Kconfig options to platform selection
      [POWERPC] rename add_bridge to avoid namespace clashes
      [POWERPC] mpc82xx_ads build fix
      [POWERPC] kill isa_{io,mem}_base definitions for !PCI
      [POWERPC] fix building without PCI
      [POWERPC] disallow building powermac and tsi108 without PCI

Benjamin Herrenschmidt (18):
      [POWERPC] unmap_vm_area becomes unmap_kernel_range for the public
      [POWERPC] Rewrite IO allocation & mapping on powerpc64
      [POWERPC] spufs: Add support for SPU single stepping
      [POWERPC] spufs: Add a "capabilities" file to spu contexts
      [POWERPC] Disable broken PPC_PTRACE_GETFPREGS on 32 bits
      [POWERPC] ptrace cleanups
      [POWERPC] ptrace updates & new, better requests
      [POWERPC] Uninline common ptrace bits
      [POWERPC] Remove some useless ifdef's in ptrace
      [POWERPC] Allow ptrace write to pt_regs trap and orig_r3
      [POWERPC] ptrace shouldn't touch FP exec mode
      [POWERPC] powerpc: ptrace can set DABR on both 32 and 64 bits
      [POWERPC] Always apply DABR changes on context switches
      [POWERPC] Make syscall restart code more common
      [POWERPC] Remove obsolete freezer bits
      [POWERPC] Merge creation of signal frame
      [POWERPC] Remove #ifdef around set_dabr in signal code
      [POWERPC] Less ifdef's in signal.c/signal.h

Brian King (1):
      [POWERPC] Add H_ILLAN_ATTRIBUTES hcall number

Christoph Hellwig (16):
      [POWERPC] Consolidate sys_sigaltstack
      [POWERPC] Consolidate restore_sigmask
      [POWERPC] Consolidate do_signal
      [POWERPC] spusched: Switch from workqueues to kthread + timer tick
      [POWERPC] spusched: Dynamic timeslicing for SCHED_OTHER
      [POWERPC] spusched: Update scheduling paramters on every spu_run
      [POWERPC] spusched: fix cpu/node binding
      [POWERPC] spusched: Catch nosched contexts in spu_deactivate
      [POWERPC] spusched: No preemption for nosched contexts
      [POWERPC] spufs: Add tid file
      [POWERPC] spufs: Implement /proc/spu_loadavg
      [POWERPC] spufs: Add stat file to spufs
      [POWERPC] spusched: Disable tick when not needed
      [POWERPC] spusched: Fix runqueue corruption
      [POWERPC] spufs: Add spu stats in sysfs
      [POWERPC] Remove unused do_signal export

David Gibson (18):
      [POWERPC] Split low-level OF-related bootloader code into separate files
      [POWERPC] Split out asm-ppc/mmu.h portions for the "classic" hash-based MMU
      [POWERPC] Abolish iopa(), mm_ptov(), io_block_mapping() from arch/powerpc
      [POWERPC] Remove the dregs of APUS support from arch/powerpc
      [POWERPC] Remove a couple of unused definitions from pgtable_32.c
      [POWERPC] Start factoring pgtable-ppc32.h and pgtable-ppc64.h
      [POWERPC] Kill typedef-ed structs for hash PTEs and BATs
      [POWERPC] Merge CPU features pertaining to icache coherency
      [POWERPC] Factor zImage's 44x reset code out of ebony.c
      [POWERPC] Derive ebc ranges property from EBC registers
      [POWERPC] Consolidate cuboot initialization code
      [POWERPC] Don't store a command line in the Holly device tree
      [POWERPC] Fix problems with device tree representation of TSI-1xx bridges
      [POWERPC] Make more OF-related bootwrapper functions available to non-OF platforms
      [POWERPC] Abolish unused ucBoardRev variables
      [POWERPC] In booting-without-of.txt, clarify that properties must precede subnodes
      [POWERPC] Split out asm-ppc/mmu.h portions for Freescale Book-E
      [POWERPC] Split out asm-ppc/mmu.h portions for PowerPC 8xx

David Woodhouse (3):
      [POWERPC] PS3: System-bus uevent
      [POWERPC] PS3: System-bus modinfo attribute
      [POWERPC] Enable arbitary speed tty ioctls and split input/output speed

Domen Puncer (1):
      [POWERPC] 52xx: sparse fixes

Geert Uytterhoeven (7):
      [POWERPC] PS3: Fix sparse warnings
      [POWERPC] PS3: Simplify definition of DBG
      [POWERPC] PS3: Frame buffer system-bus rework
      [POWERPC] PS3: Fix more sparse warnings
      [POWERPC] PS3: Preallocate bootmem memory for the PS3 FLASH ROM storage driver
      [POWERPC] PS3: Storage Driver Core
      [POWERPC] PS3: Storage device registration routines

Geoff Levand (24):
      [POWERPC] cell: Add spu shutdown method
      [POWERPC] PS3: Rename IPI symbols
      [POWERPC] PS3: Use __maybe_unused
      [POWERPC] PS3: Map SPU regions as non-guarded
      [POWERPC] PS3: Move chip mask defs up
      [POWERPC] PS3: Kexec support
      [POWERPC] PS3: System-bus rework
      [POWERPC] PS3: Repository probe cleanups
      [POWERPC] PS3: Vuart rework
      [POWERPC] PS3: System manager re-work
      [POWERPC] PS3: Rework AV settings driver
      [POWERPC] PS3: Device registration routines.
      [POWERPC] PS3: Rename processor id symbols
      [POWERPC] PS3: Use clear_bit
      [POWERPC] Output params value in early_init_devtree
      [POWERPC] Correct __secondary_hold comment
      [POWERPC] Add signed types to bootwrapper
      [POWERPC] Add u64 printf to bootwrapper
      [POWERPC] Fix constantness of bootwrapper arg
      [POWERPC] Make kernel_entry_t have global scope in bootwrapper
      [POWERPC] PS3: Device tree source
      [POWERPC] PS3: Select MEMORY_HOTPLUG
      [POWERPC] PS3: Update ps3_defconfig
      [POWERPC] PS3: Bootwrapper support.

Grant Likely (2):
      [POWERPC] 83xx: Add USB support to mpc8349-mitx board port
      [POWERPC] xilinxfb: Parameterize xilinxfb platform device registration

Guennadi Liakhovetski (1):
      [POWERPC] Don't link timer.o for powerpc systems using generic rtc

Ishizaki Kou (2):
      [POWERPC] of_serial: Ignore unknown serial port
      [POWERPC] of_serial: add port type checking

Jake Moilanen (1):
      [POWERPC] Donate idle CPU cycles on dedicated partitions

Jeremy Kerr (5):
      [POWERPC] spusched: Fix timeslice calculations
      [POWERPC] spusched: Print out scheduling tunables with DEBUG
      [POWERPC] spufs: Remove spufs_dir_inode_operations
      [POWERPC] spufs: Trivial whitespace fixes
      [POWERPC] spufs: Fix libassist accounting

Johannes Berg (3):
      [POWERPC] Use mktime in timer sysdev
      [POWERPC] powermac i2c: Use mutex
      [POWERPC] arch/powerpc/kernel/sysfs.c: Move NUMA exports

Jon Loeliger (1):
      [POWERPC] Replace use of GET_64BIT(prop, i) with of_read_number().

Jon Tollefson (1):
      [POWERPC] Move common code out of if/else

Josh Boyer (2):
      [POWERPC] Consolidate PowerPC 750 cputable features
      [POWERPC] Schedule removal of arch/ppc

Kazunori Asayama (2):
      [POWERPC] spufs: Fix lost events in poll/epoll on mfc
      [POWERPC] spufs: Save dma_tagstatus_R in CSA

Kumar Gala (24):
      [POWERPC] Remove set_cfg_type for PCI indirect users that don't need it
      [POWERPC] 52xx: Remove support for PCI bus_offset
      [POWERPC] Pass the pci_controller into pci_exclude_device
      [POWERPC] Remove hack to determine the 2nd PHBs bus number
      [POWERPC] Remove bus_offset in places its not really used
      [POWERPC] Added self_busno to indicate which bus number the PHB is
      [POWERPC] Removed remnants of bus_offset
      [POWERPC] Added indirect_type to handle variants of PCI ops
      [POWERPC] 86xx: Workaround PCI_PRIMARY_BUS usage
      [POWERPC] Merge asm-ppc/pci-bridge.h into asm-power/pci-bridge.h
      [POWERPC] Remove local_number from pci_controller
      [POWERPC] Removed dead code related to PCI on ppc32
      [POWERPC] Use global_number in ppc32 pci_controller
      [POWERPC] Merge ppc32 and ppc64 pcibios_alloc_controller() prototypes
      [POWERPC] Move pci_bus_to_hose users to pci_bus_to_host
      [POWERPC] Move common PCI code out of pci_32/pci_64
      [POWERPC] Use ppc64 style list management for pci_controller on ppc32
      [POWERPC] Add copyright header to pci-common.c based on pci_{32,64}.c
      [POWERPC] Reworked interrupt numbers for OpenPIC based Freescale chips
      [POWERPC] Kill pcibios_enable_resources()
      [POWERPC] Fix up interrupt senses for MPC85xx boards
      [POWERPC] Merge asm-ppc/mmu_context.h into asm-power/mmu_context.h
      [POWERPC] Move inline asm eieio to using eieio inline function
      [POWERPC] CPM_UART: Use inline function form of eieio

Laurent Pinchart (1):
      [PPC] Add linux/pagemap.h to arch/ppc/mm/tlb.c

Li Yang (3):
      [POWERPC] qe_lib: export symbols for QE driver to compile as module
      [POWERPC] 83xx: USB platform code rework
      [POWERPC] Fix typo in Ebony default DTS

Linas Vepstas (5):
      [POWERPC] pseries: asm/pci-bridge.h CONFIG_ minor cleanup
      [POWERPC] Add EEH sysfs blinkenlights
      [POWERPC] Show EEH per-device false positives
      [POWERPC] Remove dead EEH code
      [POWERPC] Tweak EEH copyright info

Manish Ahuja (1):
      [POWERPC] Remove extra return statement

Mark A. Greer (5):
      [POWERPC] Remove 'make zImage.dts' feature
      [POWERPC] When appropriate, wrap device tree with zImage
      [POWERPC] Update holly to use new dts wrapping feature
      [POWERPC] Call add_preferred_console when MPSC is console
      [POWERPC] Remove 'console=' from cmdline on prpmc2800

Masakazu Mokuno (1):
      [POWERPC] PS3: Compare firmware version

Masashi Kimoto (1):
      [POWERPC] PS3: Add support for HDMI RGB Full Range mode

Mathieu Desnoyers (1):
      [POWERPC] Remove unnecessary #undef printk from prom.c

Michael Ellerman (8):
      [POWERPC] Split virq setup logic out into irq_setup_virq()
      [POWERPC] Add irq_create_direct_mapping()
      [POWERPC] Add for_each_compatible_node()
      [POWERPC] Turn off debugging in arch/powerpc/kernel/pci_64.c
      [POWERPC] Check for the root node in of_detach_node()
      [POWERPC] Generalise device_node flag interface
      [POWERPC] Add a warning to help trackdown device_node refcounting bugs
      [POWERPC] Make the debugfs "powerpc" dir globally accessible

Michael Neuling (2):
      [POWERPC] Fix stolen time for SMT without LPAR
      [POWERPC] Do firmware feature fixups after features are initialised

Mike Wolf (1):
      [POWERPC] Oprofile support for Power 5++

Milton Miller (1):
      [POWERPC] kexec: Send slaves to new kernel earlier

Mohan Kumar M (1):
      [POWERPC] Fix interrupt distribution in ppc970

Nathan Lynch (1):
      [POWERPC] Remove spinlock from struct cpu_purr_data

Olaf Hering (1):
      [POWERPC] Make two xmon variables static

Olof Johansson (4):
      [POWERPC] pasemi: Electra IDE/pata_platform glue
      [POWERPC] Uninline and export virq_to_hw()
      [POWERPC] pasemi: Rename platform
      [POWERPC] pasemi: Don't auto-select CONFIG_EMBEDDED

Robert P. J. Day (2):
      [POWERPC] VIOTAPE: Use designated initializers for fops member structures.
      [POWERPC] Remove dead code for preventing pread() and pwrite() calls

Roland Dreier (1):
      [POWERPC] Add cputable entry for PowerPC 440SPe Rev. B

Roy Zang (4):
      [POWERPC] Document the global utilities node define and example
      [POWERPC] Fix the node index confusion for SOC
      [POWERPC] 85xx: Fix 8548CDS reset bug
      [POWERPC] Remove redundant pci_read_irq_line() function for 85xx platform

Sachin P. Sant (1):
      [POWERPC] Fix Kexec/Kdump for power6

Sebastian Siewior (2):
      [POWERPC] spufs: fix building spufs/spu_save_dump.h
      [POWERPC] spufs: Add bit definition

Segher Boessenkool (1):
      [POWERPC] Fix VDSO compile warning

Sonny Rao (1):
      [POWERPC] Check for NULL ppc_md.init_IRQ() before calling

Stephen Rothwell (1):
      [POWERPC] Fix viodasd geometry calculations

Timur Tabi (1):
      [POWERPC] Fix MAC address entries for 83xx, 85xx, and 86xx device trees

Tony Breeds (4):
      [POWERPC] Move iSeries_tb_recal into its own late_initcall.
      [POWERPC] Create a dummy zImage if no valid platform has been selected
      [POWERPC] Modify sched_clock() to make CONFIG_PRINTK_TIME more sane
      [POWERPC] Add __read_mostly support for powerpc

Vitaly Bordug (2):
      [POWERPC] 8xx: mpc885ads pcmcia support
      [POWERPC] dts: kill hardcoded phandles

Wade Farnsworth (4):
      [POWERPC] 86xx: Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
      [POWERPC] Fix drivers/rtc/Kconfig for powerpc
      [POWERPC] Add a check for keyboard/mouse device nodes in check_legacy_ioport()
      [POWERPC] Create add_rtc() function to enable the RTC CMOS driver

York Sun (1):
      [POWERPC] Let subordinate transparent bridges be transparent.

Zhang Wei (4):
      [POWERPC] Remove PCI-e errata for MPC8641 silicon ver 1.0
      [POWERPC] 86xx: Avoid system halt if link training isn't at least L0.
      [POWERPC] MPC8641HPCN: Set IDE in ULI1575 to not native mode.
      [POWERPC] 86xx: Created quirk_fsl_pcie_transparent() to initialize bridge resources.

will schmidt (2):
      [POWERPC] During VM oom condition, kill all threads in process group
      [POWERPC] Oprofile enhanced instruction sampling support
