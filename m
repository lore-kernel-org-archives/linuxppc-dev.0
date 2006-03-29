Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17450.2513.154365.586522@cargo.ozlabs.ibm.com>
Date: Wed, 29 Mar 2006 15:15:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git
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

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

to get another batch of powerpc updates.

Thanks,
Paul.

Andrew Morton:
      powerpc: hot_add_scn_to_nid() build fix
      git-powerpc: WARN was a dumb idea

Anton Blanchard:
      powerpc: Allow non zero boot cpuids
      powerpc: Consistent printing of node id
      powerpc: Compile warning in hvcs driver
      powerpc: Remove some ifdefs in oprofile_impl.h
      powerpc: export validate_sp for oprofile calltrace
      powerpc: Fix some initcall return values
      powerpc: Add oprofile calltrace support to all powerpc cpus
      powerpc: Remove oprofile spinlock backtrace code

Arnd Bergmann:
      powerpc: fix cell iommu setup
      powerpc: update cell defconfig
      powerpc: work around a cell interrupt HW bug
      powerpc: declare arch syscalls in <asm/syscalls.h>
      spufs: allow SPU code to do syscalls
      spufs: implement mfc access for PPE-side DMA
      powerpc: fix spider-pic affinity setting
      powerpc: use guarded ioremap for cell on-chip mappings
      spufs: Fix endless protection fault on LS writes by SPE.
      powerpc: add hvc backend for rtas
      spufs: fix __init/__exit annotations

Benjamin Herrenschmidt:
      powerpc: Kill _machine and hard-coded platform numbers

Brian Rogan:
      powerpc: Add oprofile calltrace support

Dirk Herrendoerfer:
      spufs: initialize context correctly

Eugene Surovegin:
      lock PTE before updating it in 440/BookE page fault handler

Jens Osterkamp:
      powerpc: cell interrupt controller updates

John Rose:
      powerpc: dynamic probe - use ppc_md.pci_probe_mode()

KAMEZAWA Hiroyuki:
      for_each_possible_cpu: powerpc
      for_each_possible_cpu: ppc

Kumar Gala:
      ppc: fix strncasecmp prototype
      powerpc: use memparse() for mem= command line parsing
      powerpc: move math-emu over to arch/powerpc
      powerpc: Make uImage default build output for MPC8540 ADS
      powerpc: remove OCP references

Laurent MEYER:
      powerpc: fix incorrect SA_ONSTACK behaviour for 64-bit processes

Linas Vepstas:
      powerpc/pseries: Cleanup device name printing.

Mark Nutter:
      spufs: enable SPE problem state MMIO access.

Michael Ellerman:
      powerpc: Make BUG_ON & WARN_ON play nice with compile-time optimisations
      powerpc: Change firmware_has_feature() to a macro
      powerpc: Rename and export ppc64_firmware_features
      powerpc: Cope with duplicate node & property names in /proc/device-tree

Michael Neuling:
      powerpc: legacy_serial loop cleanup
      powerpc: HVC init race

Mike Kravetz:
      powerpc: Workaround for pSeries RTAS bug

Olaf Hering:
      correct the comment about stackpointer alignment in __boot_from_prom
      powerpc: return to OF via trap, not exit

Paul Mackerras:
      powerpc: Unify the 32 and 64 bit idle loops
      powerpc: Simplify pSeries idle loop
      powerpc: Move l2cr.S over to arch/powerpc
      powerpc: Move cpu_setup_6xx.S and temp.c over to arch/powerpc
      powerpc: Move swsusp.S over to arch/powerpc
      powerpc: Move module.c over to arch/powerpc
      powerpc: Move perfmon_fsl_booke.c over to arch/powerpc
      powerpc: Don't compile in arch/ppc/kernel for 32-bit ARCH=powerpc
      ppc: Remove duplicate exports of __down, __up etc.
      powerpc: Fix event-scan code for 32-bit CHRP
      powerpc: Fix goof in 6xx and POWER4 idle power-save functions
      ppc: Remove CHRP, POWER3 and POWER4 support from arch/ppc
      ppc: Fix compile error in arch/ppc/lib/strcase.c

Ryan S. Arnold:
      powerpc: hvc_console updates

Stephen Rothwell:
      powerpc: work around sparse warnings in cputable.h
      powerpc: fix various sparse warnings
      powerpc: make ISA floppies work again
      powerpc: a couple of trivial compile warning fixes

Sylvain Munaut:
      ppc32: Adds support for the PCI hostbridge in MPC5200B
      ppc32: Adds support for the LITE5200B dev board
      ppc32: Reorganize and complete MPC52xx initial cpu setup

 Documentation/powerpc/booting-without-of.txt    |    5 
 arch/powerpc/Kconfig                            |    4 
 arch/powerpc/Kconfig.debug                      |    5 
 arch/powerpc/Makefile                           |    7 
 arch/powerpc/configs/cell_defconfig             |  133 +-
 arch/powerpc/configs/mpc8540_ads_defconfig      |   43 -
 arch/powerpc/kernel/Makefile                    |   11 
 arch/powerpc/kernel/asm-offsets.c               |    2 
 arch/powerpc/kernel/cpu_setup_6xx.S             |    0 
 arch/powerpc/kernel/entry_32.S                  |    8 
 arch/powerpc/kernel/entry_64.S                  |    6 
 arch/powerpc/kernel/firmware.c                  |    4 
 arch/powerpc/kernel/head_64.S                   |   32 
 arch/powerpc/kernel/idle.c                      |  122 ++
 arch/powerpc/kernel/idle_64.c                   |  121 --
 arch/powerpc/kernel/idle_6xx.S                  |   18 
 arch/powerpc/kernel/idle_power4.S               |   38 -
 arch/powerpc/kernel/irq.c                       |    2 
 arch/powerpc/kernel/l2cr_6xx.S                  |    0 
 arch/powerpc/kernel/legacy_serial.c             |   42 -
 arch/powerpc/kernel/lparcfg.c                   |    4 
 arch/powerpc/kernel/module_32.c                 |    0 
 arch/powerpc/kernel/nvram_64.c                  |    7 
 arch/powerpc/kernel/paca.c                      |   21 
 arch/powerpc/kernel/pci_32.c                    |    4 
 arch/powerpc/kernel/pci_64.c                    |    1 
 arch/powerpc/kernel/perfmon_fsl_booke.c         |    0 
 arch/powerpc/kernel/proc_ppc64.c                |    3 
 arch/powerpc/kernel/process.c                   |   11 
 arch/powerpc/kernel/prom.c                      |  154 +-
 arch/powerpc/kernel/prom_init.c                 |   68 +
 arch/powerpc/kernel/rtas-proc.c                 |    2 
 arch/powerpc/kernel/rtas.c                      |    8 
 arch/powerpc/kernel/setup-common.c              |   70 +
 arch/powerpc/kernel/setup_32.c                  |   75 -
 arch/powerpc/kernel/setup_64.c                  |   78 -
 arch/powerpc/kernel/signal_32.c                 |    1 
 arch/powerpc/kernel/signal_64.c                 |    3 
 arch/powerpc/kernel/smp.c                       |    2 
 arch/powerpc/kernel/swsusp_32.S                 |    0 
 arch/powerpc/kernel/syscalls.c                  |    1 
 arch/powerpc/kernel/sysfs.c                     |   12 
 arch/powerpc/kernel/tau_6xx.c                   |    0 
 arch/powerpc/kernel/time.c                      |    4 
 arch/powerpc/kernel/traps.c                     |   35 -
 arch/powerpc/kernel/vdso.c                      |    9 
 arch/powerpc/kernel/vmlinux.lds.S               |  379 +++--
 arch/powerpc/lib/sstep.c                        |    2 
 arch/powerpc/math-emu/Makefile                  |    0 
 arch/powerpc/math-emu/double.h                  |    0 
 arch/powerpc/math-emu/fabs.c                    |    0 
 arch/powerpc/math-emu/fadd.c                    |    0 
 arch/powerpc/math-emu/fadds.c                   |    0 
 arch/powerpc/math-emu/fcmpo.c                   |    0 
 arch/powerpc/math-emu/fcmpu.c                   |    0 
 arch/powerpc/math-emu/fctiw.c                   |    0 
 arch/powerpc/math-emu/fctiwz.c                  |    0 
 arch/powerpc/math-emu/fdiv.c                    |    0 
 arch/powerpc/math-emu/fdivs.c                   |    0 
 arch/powerpc/math-emu/fmadd.c                   |    0 
 arch/powerpc/math-emu/fmadds.c                  |    0 
 arch/powerpc/math-emu/fmr.c                     |    0 
 arch/powerpc/math-emu/fmsub.c                   |    0 
 arch/powerpc/math-emu/fmsubs.c                  |    0 
 arch/powerpc/math-emu/fmul.c                    |    0 
 arch/powerpc/math-emu/fmuls.c                   |    0 
 arch/powerpc/math-emu/fnabs.c                   |    0 
 arch/powerpc/math-emu/fneg.c                    |    0 
 arch/powerpc/math-emu/fnmadd.c                  |    0 
 arch/powerpc/math-emu/fnmadds.c                 |    0 
 arch/powerpc/math-emu/fnmsub.c                  |    0 
 arch/powerpc/math-emu/fnmsubs.c                 |    0 
 arch/powerpc/math-emu/fres.c                    |    0 
 arch/powerpc/math-emu/frsp.c                    |    0 
 arch/powerpc/math-emu/frsqrte.c                 |    0 
 arch/powerpc/math-emu/fsel.c                    |    0 
 arch/powerpc/math-emu/fsqrt.c                   |    0 
 arch/powerpc/math-emu/fsqrts.c                  |    0 
 arch/powerpc/math-emu/fsub.c                    |    0 
 arch/powerpc/math-emu/fsubs.c                   |    0 
 arch/powerpc/math-emu/lfd.c                     |    0 
 arch/powerpc/math-emu/lfs.c                     |    0 
 arch/powerpc/math-emu/math.c                    |    0 
 arch/powerpc/math-emu/mcrfs.c                   |    0 
 arch/powerpc/math-emu/mffs.c                    |    0 
 arch/powerpc/math-emu/mtfsb0.c                  |    0 
 arch/powerpc/math-emu/mtfsb1.c                  |    0 
 arch/powerpc/math-emu/mtfsf.c                   |    0 
 arch/powerpc/math-emu/mtfsfi.c                  |    0 
 arch/powerpc/math-emu/op-1.h                    |    0 
 arch/powerpc/math-emu/op-2.h                    |    0 
 arch/powerpc/math-emu/op-4.h                    |    0 
 arch/powerpc/math-emu/op-common.h               |    0 
 arch/powerpc/math-emu/sfp-machine.h             |    0 
 arch/powerpc/math-emu/single.h                  |    0 
 arch/powerpc/math-emu/soft-fp.h                 |    0 
 arch/powerpc/math-emu/stfd.c                    |    0 
 arch/powerpc/math-emu/stfiwx.c                  |    0 
 arch/powerpc/math-emu/stfs.c                    |    0 
 arch/powerpc/math-emu/types.c                   |    0 
 arch/powerpc/math-emu/udivmodti4.c              |    0 
 arch/powerpc/mm/fault.c                         |   30 
 arch/powerpc/mm/hash_utils_64.c                 |    7 
 arch/powerpc/mm/mem.c                           |    2 
 arch/powerpc/mm/numa.c                          |    2 
 arch/powerpc/mm/pgtable_32.c                    |    6 
 arch/powerpc/mm/stab.c                          |    2 
 arch/powerpc/oprofile/Makefile                  |    2 
 arch/powerpc/oprofile/backtrace.c               |  126 ++
 arch/powerpc/oprofile/common.c                  |    9 
 arch/powerpc/oprofile/op_model_7450.c           |    4 
 arch/powerpc/oprofile/op_model_fsl_booke.c      |    4 
 arch/powerpc/oprofile/op_model_power4.c         |   45 -
 arch/powerpc/oprofile/op_model_rs64.c           |    5 
 arch/powerpc/platforms/85xx/Kconfig             |    1 
 arch/powerpc/platforms/cell/Kconfig             |    5 
 arch/powerpc/platforms/cell/Makefile            |   10 
 arch/powerpc/platforms/cell/interrupt.c         |  135 ++
 arch/powerpc/platforms/cell/interrupt.h         |    2 
 arch/powerpc/platforms/cell/iommu.c             |   16 
 arch/powerpc/platforms/cell/pervasive.c         |    4 
 arch/powerpc/platforms/cell/setup.c             |   11 
 arch/powerpc/platforms/cell/spider-pic.c        |  108 +-
 arch/powerpc/platforms/cell/spu_base.c          |   17 
 arch/powerpc/platforms/cell/spu_callbacks.c     |  345 +++++
 arch/powerpc/platforms/cell/spufs/backing_ops.c |   47 +
 arch/powerpc/platforms/cell/spufs/context.c     |   24 
 arch/powerpc/platforms/cell/spufs/file.c        |  523 +++++++-
 arch/powerpc/platforms/cell/spufs/hw_ops.c      |   57 +
 arch/powerpc/platforms/cell/spufs/inode.c       |    6 
 arch/powerpc/platforms/cell/spufs/run.c         |   91 +
 arch/powerpc/platforms/cell/spufs/sched.c       |    2 
 arch/powerpc/platforms/cell/spufs/spufs.h       |   28 
 arch/powerpc/platforms/cell/spufs/switch.c      |    3 
 arch/powerpc/platforms/chrp/chrp.h              |    2 
 arch/powerpc/platforms/chrp/setup.c             |   77 +
 arch/powerpc/platforms/iseries/setup.c          |   13 
 arch/powerpc/platforms/maple/setup.c            |   10 
 arch/powerpc/platforms/powermac/bootx_init.c    |    6 
 arch/powerpc/platforms/powermac/feature.c       |    2 
 arch/powerpc/platforms/powermac/low_i2c.c       |    3 
 arch/powerpc/platforms/powermac/nvram.c         |   14 
 arch/powerpc/platforms/powermac/pci.c           |    5 
 arch/powerpc/platforms/powermac/pfunc_base.c    |    2 
 arch/powerpc/platforms/powermac/setup.c         |   74 +
 arch/powerpc/platforms/powermac/time.c          |    4 
 arch/powerpc/platforms/powermac/udbg_scc.c      |    2 
 arch/powerpc/platforms/pseries/eeh.c            |    2 
 arch/powerpc/platforms/pseries/eeh_driver.c     |   16 
 arch/powerpc/platforms/pseries/firmware.c       |    2 
 arch/powerpc/platforms/pseries/hvconsole.c      |    5 
 arch/powerpc/platforms/pseries/pci.c            |    2 
 arch/powerpc/platforms/pseries/pci_dlpar.c      |   11 
 arch/powerpc/platforms/pseries/ras.c            |    2 
 arch/powerpc/platforms/pseries/reconfig.c       |    5 
 arch/powerpc/platforms/pseries/rtasd.c          |    3 
 arch/powerpc/platforms/pseries/setup.c          |  223 +--
 arch/powerpc/platforms/pseries/xics.c           |    4 
 arch/ppc/Kconfig                                |   93 -
 arch/ppc/Kconfig.debug                          |    7 
 arch/ppc/Makefile                               |    6 
 arch/ppc/boot/Makefile                          |    7 
 arch/ppc/boot/openfirmware/Makefile             |  109 --
 arch/ppc/boot/openfirmware/chrpmain.c           |  101 -
 arch/ppc/boot/openfirmware/common.c             |  146 --
 arch/ppc/boot/openfirmware/dummy.c              |    4 
 arch/ppc/boot/openfirmware/misc.S               |   67 -
 arch/ppc/boot/openfirmware/start.c              |  172 --
 arch/ppc/boot/simple/mpc10x_memory.c            |    4 
 arch/ppc/boot/simple/relocate.S                 |    2 
 arch/ppc/boot/utils/addnote.c                   |  175 ---
 arch/ppc/boot/utils/hack-coff.c                 |   84 -
 arch/ppc/boot/utils/mknote.c                    |   44 -
 arch/ppc/configs/ibmchrp_defconfig              |  875 -------------
 arch/ppc/configs/pmac_defconfig                 | 1591 -----------------------
 arch/ppc/configs/power3_defconfig               | 1035 ---------------
 arch/ppc/configs/prep_defconfig                 |    0 
 arch/ppc/kernel/Makefile                        |   28 
 arch/ppc/kernel/entry.S                         |   60 -
 arch/ppc/kernel/head.S                          |  183 ---
 arch/ppc/kernel/idle.c                          |  112 --
 arch/ppc/kernel/idle_6xx.S                      |  233 ---
 arch/ppc/kernel/idle_power4.S                   |   91 -
 arch/ppc/kernel/pci.c                           |  396 ------
 arch/ppc/kernel/ppc_htab.c                      |    8 
 arch/ppc/kernel/ppc_ksyms.c                     |   26 
 arch/ppc/kernel/setup.c                         |  256 ----
 arch/ppc/kernel/smp.c                           |    2 
 arch/ppc/lib/strcase.c                          |    3 
 arch/ppc/mm/fault.c                             |   30 
 arch/ppc/mm/hashtable.S                         |   34 
 arch/ppc/mm/init.c                              |   13 
 arch/ppc/mm/mmu_context.c                       |    2 
 arch/ppc/mm/pgtable.c                           |    8 
 arch/ppc/mm/ppc_mmu.c                           |   28 
 arch/ppc/platforms/Makefile                     |   12 
 arch/ppc/platforms/chrp_nvram.c                 |   83 -
 arch/ppc/platforms/chrp_pci.c                   |  309 ----
 arch/ppc/platforms/chrp_pegasos_eth.c           |  211 ---
 arch/ppc/platforms/chrp_setup.c                 |  669 ----------
 arch/ppc/platforms/chrp_smp.c                   |   99 -
 arch/ppc/platforms/chrp_time.c                  |  235 ---
 arch/ppc/platforms/lite5200.c                   |   71 +
 arch/ppc/platforms/prep_setup.c                 |   12 
 arch/ppc/syslib/Makefile                        |    2 
 arch/ppc/syslib/mpc52xx_pci.c                   |    3 
 arch/ppc/syslib/mpc52xx_setup.c                 |   48 +
 arch/ppc/syslib/open_pic.c                      |    2 
 arch/ppc/syslib/prom.c                          | 1429 ---------------------
 arch/ppc/syslib/prom_init.c                     | 1011 ---------------
 arch/ppc/xmon/start.c                           |    2 
 drivers/char/Kconfig                            |   17 
 drivers/char/Makefile                           |    4 
 drivers/char/generic_nvram.c                    |    5 
 drivers/char/hvc_console.c                      |  101 +
 drivers/char/hvc_console.h                      |   63 +
 drivers/char/hvc_rtas.c                         |  138 ++
 drivers/char/hvc_vio.c                          |   11 
 drivers/char/hvcs.c                             |    1 
 drivers/ide/pci/via82cxxx.c                     |    2 
 drivers/ide/ppc/pmac.c                          |    2 
 drivers/ieee1394/ohci1394.c                     |    4 
 drivers/macintosh/adb.c                         |    3 
 drivers/macintosh/adbhid.c                      |    4 
 drivers/macintosh/mediabay.c                    |    4 
 drivers/media/video/planb.c                     |    2 
 drivers/net/tulip/de4x5.c                       |    2 
 drivers/scsi/mesh.c                             |    2 
 drivers/usb/core/hcd-pci.c                      |    4 
 drivers/video/aty/aty128fb.c                    |    7 
 drivers/video/aty/atyfb_base.c                  |    7 
 drivers/video/aty/radeon_pm.c                   |    4 
 drivers/video/cirrusfb.c                        |    4 
 drivers/video/matrox/matroxfb_base.c            |    3 
 drivers/video/nvidia/nvidia.c                   |    5 
 drivers/video/radeonfb.c                        |    2 
 drivers/video/riva/fbdev.c                      |    9 
 fs/partitions/mac.c                             |    3 
 fs/proc/proc_devtree.c                          |  103 +
 include/asm-powerpc/bug.h                       |   36 -
 include/asm-powerpc/cputable.h                  |  299 ++--
 include/asm-powerpc/firmware.h                  |   10 
 include/asm-powerpc/floppy.h                    |    5 
 include/asm-powerpc/hvcall.h                    |    1 
 include/asm-powerpc/hvconsole.h                 |   26 
 include/asm-powerpc/machdep.h                   |   43 -
 include/asm-powerpc/oprofile_impl.h             |   17 
 include/asm-powerpc/paca.h                      |    2 
 include/asm-powerpc/percpu.h                    |    2 
 include/asm-powerpc/pmac_feature.h              |    2 
 include/asm-powerpc/processor.h                 |   43 -
 include/asm-powerpc/prom.h                      |   14 
 include/asm-powerpc/reg.h                       |    4 
 include/asm-powerpc/smp.h                       |    2 
 include/asm-powerpc/spu.h                       |   11 
 include/asm-powerpc/syscalls.h                  |   58 +
 include/asm-powerpc/unistd.h                    |   35 -
 include/asm-powerpc/vdso_datapage.h             |    3 
 include/asm-ppc/machdep.h                       |   17 
 include/asm-ppc/mpc52xx.h                       |    4 
 include/asm-ppc/pgtable.h                       |    3 
 include/asm-ppc/prom.h                          |  156 --
 include/asm-ppc/serial.h                        |    7 
 include/linux/pci_ids.h                         |    1 
 sound/oss/dmasound/dmasound_awacs.c             |    2 
 sound/ppc/pmac.c                                |    2 
 266 files changed, 3450 insertions(+), 11829 deletions(-)
 rename arch/{ppc/kernel/cpu_setup_6xx.S => powerpc/kernel/cpu_setup_6xx.S} (100%)
 create mode 100644 arch/powerpc/kernel/idle.c
 delete mode 100644 arch/powerpc/kernel/idle_64.c
 rename arch/{ppc/kernel/l2cr.S => powerpc/kernel/l2cr_6xx.S} (100%)
 rename arch/{ppc/kernel/module.c => powerpc/kernel/module_32.c} (100%)
 rename arch/{ppc/kernel/perfmon_fsl_booke.c => powerpc/kernel/perfmon_fsl_booke.c} (100%)
 rename arch/{ppc/kernel/swsusp.S => powerpc/kernel/swsusp_32.S} (100%)
 rename arch/{ppc/kernel/temp.c => powerpc/kernel/tau_6xx.c} (100%)
 rename arch/{ppc/math-emu/Makefile => powerpc/math-emu/Makefile} (100%)
 rename arch/{ppc/math-emu/double.h => powerpc/math-emu/double.h} (100%)
 rename arch/{ppc/math-emu/fabs.c => powerpc/math-emu/fabs.c} (100%)
 rename arch/{ppc/math-emu/fadd.c => powerpc/math-emu/fadd.c} (100%)
 rename arch/{ppc/math-emu/fadds.c => powerpc/math-emu/fadds.c} (100%)
 rename arch/{ppc/math-emu/fcmpo.c => powerpc/math-emu/fcmpo.c} (100%)
 rename arch/{ppc/math-emu/fcmpu.c => powerpc/math-emu/fcmpu.c} (100%)
 rename arch/{ppc/math-emu/fctiw.c => powerpc/math-emu/fctiw.c} (100%)
 rename arch/{ppc/math-emu/fctiwz.c => powerpc/math-emu/fctiwz.c} (100%)
 rename arch/{ppc/math-emu/fdiv.c => powerpc/math-emu/fdiv.c} (100%)
 rename arch/{ppc/math-emu/fdivs.c => powerpc/math-emu/fdivs.c} (100%)
 rename arch/{ppc/math-emu/fmadd.c => powerpc/math-emu/fmadd.c} (100%)
 rename arch/{ppc/math-emu/fmadds.c => powerpc/math-emu/fmadds.c} (100%)
 rename arch/{ppc/math-emu/fmr.c => powerpc/math-emu/fmr.c} (100%)
 rename arch/{ppc/math-emu/fmsub.c => powerpc/math-emu/fmsub.c} (100%)
 rename arch/{ppc/math-emu/fmsubs.c => powerpc/math-emu/fmsubs.c} (100%)
 rename arch/{ppc/math-emu/fmul.c => powerpc/math-emu/fmul.c} (100%)
 rename arch/{ppc/math-emu/fmuls.c => powerpc/math-emu/fmuls.c} (100%)
 rename arch/{ppc/math-emu/fnabs.c => powerpc/math-emu/fnabs.c} (100%)
 rename arch/{ppc/math-emu/fneg.c => powerpc/math-emu/fneg.c} (100%)
 rename arch/{ppc/math-emu/fnmadd.c => powerpc/math-emu/fnmadd.c} (100%)
 rename arch/{ppc/math-emu/fnmadds.c => powerpc/math-emu/fnmadds.c} (100%)
 rename arch/{ppc/math-emu/fnmsub.c => powerpc/math-emu/fnmsub.c} (100%)
 rename arch/{ppc/math-emu/fnmsubs.c => powerpc/math-emu/fnmsubs.c} (100%)
 rename arch/{ppc/math-emu/fres.c => powerpc/math-emu/fres.c} (100%)
 rename arch/{ppc/math-emu/frsp.c => powerpc/math-emu/frsp.c} (100%)
 rename arch/{ppc/math-emu/frsqrte.c => powerpc/math-emu/frsqrte.c} (100%)
 rename arch/{ppc/math-emu/fsel.c => powerpc/math-emu/fsel.c} (100%)
 rename arch/{ppc/math-emu/fsqrt.c => powerpc/math-emu/fsqrt.c} (100%)
 rename arch/{ppc/math-emu/fsqrts.c => powerpc/math-emu/fsqrts.c} (100%)
 rename arch/{ppc/math-emu/fsub.c => powerpc/math-emu/fsub.c} (100%)
 rename arch/{ppc/math-emu/fsubs.c => powerpc/math-emu/fsubs.c} (100%)
 rename arch/{ppc/math-emu/lfd.c => powerpc/math-emu/lfd.c} (100%)
 rename arch/{ppc/math-emu/lfs.c => powerpc/math-emu/lfs.c} (100%)
 rename arch/{ppc/math-emu/math.c => powerpc/math-emu/math.c} (100%)
 rename arch/{ppc/math-emu/mcrfs.c => powerpc/math-emu/mcrfs.c} (100%)
 rename arch/{ppc/math-emu/mffs.c => powerpc/math-emu/mffs.c} (100%)
 rename arch/{ppc/math-emu/mtfsb0.c => powerpc/math-emu/mtfsb0.c} (100%)
 rename arch/{ppc/math-emu/mtfsb1.c => powerpc/math-emu/mtfsb1.c} (100%)
 rename arch/{ppc/math-emu/mtfsf.c => powerpc/math-emu/mtfsf.c} (100%)
 rename arch/{ppc/math-emu/mtfsfi.c => powerpc/math-emu/mtfsfi.c} (100%)
 rename arch/{ppc/math-emu/op-1.h => powerpc/math-emu/op-1.h} (100%)
 rename arch/{ppc/math-emu/op-2.h => powerpc/math-emu/op-2.h} (100%)
 rename arch/{ppc/math-emu/op-4.h => powerpc/math-emu/op-4.h} (100%)
 rename arch/{ppc/math-emu/op-common.h => powerpc/math-emu/op-common.h} (100%)
 rename arch/{ppc/math-emu/sfp-machine.h => powerpc/math-emu/sfp-machine.h} (100%)
 rename arch/{ppc/math-emu/single.h => powerpc/math-emu/single.h} (100%)
 rename arch/{ppc/math-emu/soft-fp.h => powerpc/math-emu/soft-fp.h} (100%)
 rename arch/{ppc/math-emu/stfd.c => powerpc/math-emu/stfd.c} (100%)
 rename arch/{ppc/math-emu/stfiwx.c => powerpc/math-emu/stfiwx.c} (100%)
 rename arch/{ppc/math-emu/stfs.c => powerpc/math-emu/stfs.c} (100%)
 rename arch/{ppc/math-emu/types.c => powerpc/math-emu/types.c} (100%)
 rename arch/{ppc/math-emu/udivmodti4.c => powerpc/math-emu/udivmodti4.c} (100%)
 create mode 100644 arch/powerpc/oprofile/backtrace.c
 create mode 100644 arch/powerpc/platforms/cell/spu_callbacks.c
 delete mode 100644 arch/ppc/boot/openfirmware/Makefile
 delete mode 100644 arch/ppc/boot/openfirmware/chrpmain.c
 delete mode 100644 arch/ppc/boot/openfirmware/common.c
 delete mode 100644 arch/ppc/boot/openfirmware/dummy.c
 delete mode 100644 arch/ppc/boot/openfirmware/misc.S
 delete mode 100644 arch/ppc/boot/openfirmware/start.c
 delete mode 100644 arch/ppc/boot/utils/addnote.c
 delete mode 100644 arch/ppc/boot/utils/hack-coff.c
 delete mode 100644 arch/ppc/boot/utils/mknote.c
 delete mode 100644 arch/ppc/configs/ibmchrp_defconfig
 delete mode 100644 arch/ppc/configs/pmac_defconfig
 delete mode 100644 arch/ppc/configs/power3_defconfig
 rename arch/ppc/configs/{common_defconfig => prep_defconfig} (100%)
 delete mode 100644 arch/ppc/kernel/idle.c
 delete mode 100644 arch/ppc/kernel/idle_6xx.S
 delete mode 100644 arch/ppc/kernel/idle_power4.S
 delete mode 100644 arch/ppc/platforms/chrp_nvram.c
 delete mode 100644 arch/ppc/platforms/chrp_pci.c
 delete mode 100644 arch/ppc/platforms/chrp_pegasos_eth.c
 delete mode 100644 arch/ppc/platforms/chrp_setup.c
 delete mode 100644 arch/ppc/platforms/chrp_smp.c
 delete mode 100644 arch/ppc/platforms/chrp_time.c
 delete mode 100644 arch/ppc/syslib/prom.c
 delete mode 100644 arch/ppc/syslib/prom_init.c
 create mode 100644 drivers/char/hvc_console.h
 create mode 100644 drivers/char/hvc_rtas.c
 create mode 100644 include/asm-powerpc/syscalls.h
