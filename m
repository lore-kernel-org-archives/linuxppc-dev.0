Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17561.418.97341.74610@cargo.ozlabs.ibm.com>
Date: Wed, 21 Jun 2006 18:21:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git 'merge' branch
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

Please do a pull from the "merge" branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

to get the powerpc changes for 2.6.18 that have accumulated since the
2.6.17 merge window closed.

The powerpc changes are in the "master" branch in that tree.  When I
did a test pull of your tree there were some conflicts, so I did the
merge and resolved the conflicts in the "merge" branch.  I tried to
make the merge commit look like the ones you do (what script do you
use to do that, BTW?).

If you prefer to do the merge yourself, pull from the master branch,
and fix up the conflicts in include/asm-powerpc/spu.h (remove both
#includes in the conflict) and drivers/net/phy/Makefile (include both
lines that conflict).

Also, you'll notice that I have started using a "[POWERPC]" tag in the
commit headlines, similar to what other subsystems do.

Thanks,
Paul.

 arch/powerpc/Kconfig                               |   52 +
 arch/powerpc/Kconfig.debug                         |   13 
 arch/powerpc/Makefile                              |    1 
 arch/powerpc/boot/main.c                           |   27 
 arch/powerpc/boot/prom.h                           |    7 
 arch/powerpc/configs/cell_defconfig                |   34 -
 arch/powerpc/configs/mpc85xx_cds_defconfig         |  846 +++++++++++++++
 arch/powerpc/configs/mpc8641_hpcn_defconfig        |  921 ++++++++++++++++
 arch/powerpc/configs/pmac32_defconfig              |  204 ++--
 arch/powerpc/configs/pseries_defconfig             |   75 +
 arch/powerpc/kernel/align.c                        |  189 ++-
 arch/powerpc/kernel/asm-offsets.c                  |    5 
 arch/powerpc/kernel/cpu_setup_6xx.S                |    2 
 arch/powerpc/kernel/cpu_setup_power4.S             |   17 
 arch/powerpc/kernel/cputable.c                     |  137 +-
 arch/powerpc/kernel/crash.c                        |   13 
 arch/powerpc/kernel/crash_dump.c                   |   11 
 arch/powerpc/kernel/entry_64.S                     |    2 
 arch/powerpc/kernel/fpu.S                          |    6 
 arch/powerpc/kernel/head_32.S                      |   14 
 arch/powerpc/kernel/head_64.S                      |   29 +
 arch/powerpc/kernel/iomap.c                        |    2 
 arch/powerpc/kernel/iommu.c                        |   23 
 arch/powerpc/kernel/irq.c                          |   25 
 arch/powerpc/kernel/lparcfg.c                      |    4 
 arch/powerpc/kernel/machine_kexec_64.c             |   99 ++
 arch/powerpc/kernel/misc_32.S                      |    2 
 arch/powerpc/kernel/misc_64.S                      |    5 
 arch/powerpc/kernel/nvram_64.c                     |    2 
 arch/powerpc/kernel/pci_32.c                       |    7 
 arch/powerpc/kernel/pci_64.c                       |   62 -
 arch/powerpc/kernel/pci_direct_iommu.c             |   18 
 arch/powerpc/kernel/pci_dn.c                       |    6 
 arch/powerpc/kernel/pci_iommu.c                    |   41 -
 arch/powerpc/kernel/proc_ppc64.c                   |    2 
 arch/powerpc/kernel/process.c                      |   55 +
 arch/powerpc/kernel/prom.c                         |  145 ++-
 arch/powerpc/kernel/prom_init.c                    |  120 --
 arch/powerpc/kernel/prom_parse.c                   |   25 
 arch/powerpc/kernel/ptrace.c                       |    2 
 arch/powerpc/kernel/rtas-rtc.c                     |   30 -
 arch/powerpc/kernel/rtas.c                         |  108 +-
 arch/powerpc/kernel/rtas_flash.c                   |   25 
 arch/powerpc/kernel/rtas_pci.c                     |    4 
 arch/powerpc/kernel/setup-common.c                 |   20 
 arch/powerpc/kernel/setup.h                        |    3 
 arch/powerpc/kernel/setup_32.c                     |   18 
 arch/powerpc/kernel/setup_64.c                     |   31 -
 arch/powerpc/kernel/signal_32.c                    |   23 
 arch/powerpc/kernel/signal_64.c                    |   16 
 arch/powerpc/kernel/smp.c                          |    2 
 arch/powerpc/kernel/systbl.S                       |  311 ------
 arch/powerpc/kernel/time.c                         |   67 +
 arch/powerpc/kernel/traps.c                        |    8 
 arch/powerpc/kernel/udbg.c                         |    7 
 arch/powerpc/kernel/vdso.c                         |   57 +
 arch/powerpc/kernel/vector.S                       |    4 
 arch/powerpc/kernel/vio.c                          |  344 +++++-
 arch/powerpc/kernel/vmlinux.lds.S                  |    5 
 arch/powerpc/lib/Makefile                          |    5 
 arch/powerpc/lib/bitops.c                          |  150 ---
 arch/powerpc/mm/hash_low_32.S                      |   34 -
 arch/powerpc/mm/hash_low_64.S                      |   31 +
 arch/powerpc/mm/hash_native_64.c                   |    2 
 arch/powerpc/mm/hash_utils_64.c                    |   84 +
 arch/powerpc/mm/lmb.c                              |   43 +
 arch/powerpc/mm/mem.c                              |    6 
 arch/powerpc/mm/mmu_context_32.c                   |    2 
 arch/powerpc/mm/mmu_context_64.c                   |    3 
 arch/powerpc/mm/numa.c                             |    8 
 arch/powerpc/mm/ppc_mmu_32.c                       |   16 
 arch/powerpc/mm/slb.c                              |   32 -
 arch/powerpc/mm/slb_low.S                          |   17 
 arch/powerpc/mm/stab.c                             |    4 
 arch/powerpc/mm/tlb_32.c                           |    6 
 arch/powerpc/mm/tlb_64.c                           |    5 
 arch/powerpc/oprofile/Kconfig                      |    1 
 arch/powerpc/oprofile/Makefile                     |    4 
 arch/powerpc/oprofile/common.c                     |    6 
 arch/powerpc/oprofile/op_model_power4.c            |   37 -
 arch/powerpc/platforms/85xx/Kconfig                |    9 
 arch/powerpc/platforms/85xx/Makefile               |    1 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |  359 ++++++
 arch/powerpc/platforms/85xx/mpc85xx_cds.h          |   43 +
 arch/powerpc/platforms/86xx/Kconfig                |   36 +
 arch/powerpc/platforms/86xx/Makefile               |   10 
 arch/powerpc/platforms/86xx/mpc8641_hpcn.h         |   54 +
 arch/powerpc/platforms/86xx/mpc86xx.h              |   28 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |  326 ++++++
 arch/powerpc/platforms/86xx/mpc86xx_pcie.c         |  173 +++
 arch/powerpc/platforms/86xx/mpc86xx_smp.c          |  117 ++
 arch/powerpc/platforms/86xx/pci.c                  |  325 ++++++
 arch/powerpc/platforms/Makefile                    |    1 
 arch/powerpc/platforms/cell/Kconfig                |    9 
 arch/powerpc/platforms/cell/Makefile               |   23 
 arch/powerpc/platforms/cell/cbe_regs.c             |  128 ++
 arch/powerpc/platforms/cell/cbe_regs.h             |  129 ++
 arch/powerpc/platforms/cell/interrupt.c            |   40 -
 arch/powerpc/platforms/cell/iommu.c                |   18 
 arch/powerpc/platforms/cell/pervasive.c            |  104 --
 arch/powerpc/platforms/cell/pervasive.h            |   37 -
 arch/powerpc/platforms/cell/ras.c                  |  112 ++
 arch/powerpc/platforms/cell/ras.h                  |    9 
 arch/powerpc/platforms/cell/setup.c                |   14 
 arch/powerpc/platforms/cell/spu_base.c             |  179 ++-
 arch/powerpc/platforms/cell/spu_callbacks.c        |  314 ------
 arch/powerpc/platforms/cell/spu_priv1.c            |  133 --
 arch/powerpc/platforms/cell/spu_priv1_mmio.c       |  159 +++
 arch/powerpc/platforms/cell/spufs/Makefile         |   14 
 arch/powerpc/platforms/cell/spufs/context.c        |   12 
 arch/powerpc/platforms/cell/spufs/file.c           |   67 +
 arch/powerpc/platforms/cell/spufs/hw_ops.c         |    1 
 arch/powerpc/platforms/cell/spufs/inode.c          |   30 -
 arch/powerpc/platforms/cell/spufs/sched.c          |    3 
 .../cell/spufs/spu_restore_dump.h_shipped          | 1122 ++++++++++++++++++-----
 .../platforms/cell/spufs/spu_save_dump.h_shipped   |  922 +++++++++++++++----
 arch/powerpc/platforms/cell/spufs/switch.c         |   48 +
 arch/powerpc/platforms/iseries/Makefile            |    6 
 arch/powerpc/platforms/iseries/call_pci.h          |   19 
 arch/powerpc/platforms/iseries/dt.c                |  615 +++++++++++
 arch/powerpc/platforms/iseries/iommu.c             |   46 -
 arch/powerpc/platforms/iseries/irq.c               |    7 
 arch/powerpc/platforms/iseries/irq.h               |    2 
 arch/powerpc/platforms/iseries/mf.c                |    9 
 arch/powerpc/platforms/iseries/pci.c               |  347 +-----
 arch/powerpc/platforms/iseries/setup.c             |  271 -----
 arch/powerpc/platforms/iseries/setup.h             |    2 
 arch/powerpc/platforms/iseries/vio.c               |  131 --
 arch/powerpc/platforms/maple/pci.c                 |    3 
 arch/powerpc/platforms/maple/setup.c               |    2 
 arch/powerpc/platforms/powermac/cpufreq_32.c       |    2 
 arch/powerpc/platforms/powermac/feature.c          |    2 
 arch/powerpc/platforms/powermac/pci.c              |    3 
 arch/powerpc/platforms/powermac/pfunc_core.c       |   14 
 arch/powerpc/platforms/powermac/setup.c            |    2 
 arch/powerpc/platforms/pseries/Makefile            |    5 
 arch/powerpc/platforms/pseries/eeh_cache.c         |    2 
 arch/powerpc/platforms/pseries/eeh_driver.c        |   55 +
 arch/powerpc/platforms/pseries/eeh_event.c         |   50 -
 arch/powerpc/platforms/pseries/iommu.c             |  182 +--
 arch/powerpc/platforms/pseries/rtasd.c             |    6 
 arch/powerpc/platforms/pseries/scanlog.c           |    6 
 arch/powerpc/platforms/pseries/setup.c             |    6 
 arch/powerpc/platforms/pseries/vio.c               |  274 -----
 arch/powerpc/platforms/pseries/xics.c              |   25 
 arch/powerpc/sysdev/Makefile                       |    4 
 arch/powerpc/sysdev/dart_iommu.c                   |    2 
 arch/powerpc/sysdev/mpic.c                         |   20 
 arch/ppc/Kconfig                                   |    4 
 arch/ppc/mm/init.c                                 |    2 
 arch/ppc/mm/mmu_context.c                          |    2 
 arch/ppc/mm/tlb.c                                  |    6 
 arch/ppc/platforms/4xx/Kconfig                     |    2 
 arch/ppc/platforms/4xx/cpci405.c                   |  139 ++
 arch/ppc/platforms/4xx/cpci405.h                   |   30 -
 arch/um/sys-ppc/misc.S                             |    6 
 drivers/block/viodasd.c                            |    2 
 drivers/cdrom/viocd.c                              |    2 
 drivers/char/hvc_console.c                         |    4 
 drivers/char/hvc_rtas.c                            |   37 -
 drivers/char/hvsi.c                                |    2 
 drivers/char/viotape.c                             |    2 
 drivers/i2c/busses/Kconfig                         |    4 
 drivers/macintosh/via-pmu.c                        |    4 
 drivers/net/Kconfig                                |    8 
 drivers/net/ibmveth.c                              |    2 
 drivers/net/iseries_veth.c                         |   27 
 drivers/net/phy/Kconfig                            |    5 
 drivers/net/phy/Makefile                           |    1 
 drivers/net/phy/vitesse.c                          |  112 ++
 include/asm-powerpc/bitops.h                       |    6 
 include/asm-powerpc/cputable.h                     |   82 +
 include/asm-powerpc/delay.h                        |   13 
 include/asm-powerpc/eeh.h                          |   15 
 include/asm-powerpc/eeh_event.h                    |   10 
 include/asm-powerpc/elf.h                          |    2 
 include/asm-powerpc/hvcall.h                       |   10 
 include/asm-powerpc/immap_86xx.h                   |  199 ++++
 include/asm-powerpc/io.h                           |    6 
 include/asm-powerpc/iommu.h                        |    6 
 include/asm-powerpc/irq.h                          |   86 ++
 include/asm-powerpc/iseries/iommu.h                |    6 
 include/asm-powerpc/kdump.h                        |   29 -
 include/asm-powerpc/kexec.h                        |   16 
 include/asm-powerpc/machdep.h                      |    5 
 include/asm-powerpc/mmu.h                          |   16 
 include/asm-powerpc/mmu_context.h                  |   12 
 include/asm-powerpc/mpc86xx.h                      |   47 +
 include/asm-powerpc/mpic.h                         |   10 
 include/asm-powerpc/paca.h                         |    4 
 include/asm-powerpc/page.h                         |   11 
 include/asm-powerpc/pci-bridge.h                   |   14 
 include/asm-powerpc/pgtable-4k.h                   |    2 
 include/asm-powerpc/pgtable-64k.h                  |    2 
 include/asm-powerpc/pgtable.h                      |   10 
 include/asm-powerpc/processor.h                    |   16 
 include/asm-powerpc/prom.h                         |    9 
 include/asm-powerpc/ptrace.h                       |    2 
 include/asm-powerpc/reg.h                          |   69 +
 include/asm-powerpc/rtas.h                         |    9 
 include/asm-powerpc/spu.h                          |   29 -
 include/asm-powerpc/spu_csa.h                      |   13 
 include/asm-powerpc/spu_priv1.h                    |  182 +++
 include/asm-powerpc/systbl.h                       |  306 +++++
 include/asm-powerpc/tce.h                          |   35 -
 include/asm-powerpc/topology.h                     |    9 
 include/asm-powerpc/udbg.h                         |    3 
 include/asm-powerpc/vio.h                          |   16 
 include/asm-ppc/mmu.h                              |   23 
 include/asm-ppc/mmu_context.h                      |   27 
 include/asm-ppc/mpc85xx.h                          |    3 
 include/asm-ppc/pgtable.h                          |    2 
 include/linux/delay.h                              |    5 
 include/linux/prctl.h                              |    7 
 kernel/sys.c                                       |   13 
 215 files changed, 9825 insertions(+), 4033 deletions(-)
 create mode 100644 arch/powerpc/configs/mpc85xx_cds_defconfig
 create mode 100644 arch/powerpc/configs/mpc8641_hpcn_defconfig
 delete mode 100644 arch/powerpc/lib/bitops.c
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_cds.c
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_cds.h
 create mode 100644 arch/powerpc/platforms/86xx/Kconfig
 create mode 100644 arch/powerpc/platforms/86xx/Makefile
 create mode 100644 arch/powerpc/platforms/86xx/mpc8641_hpcn.h
 create mode 100644 arch/powerpc/platforms/86xx/mpc86xx.h
 create mode 100644 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
 create mode 100644 arch/powerpc/platforms/86xx/mpc86xx_pcie.c
 create mode 100644 arch/powerpc/platforms/86xx/mpc86xx_smp.c
 create mode 100644 arch/powerpc/platforms/86xx/pci.c
 create mode 100644 arch/powerpc/platforms/cell/cbe_regs.c
 create mode 100644 arch/powerpc/platforms/cell/cbe_regs.h
 create mode 100644 arch/powerpc/platforms/cell/ras.c
 create mode 100644 arch/powerpc/platforms/cell/ras.h
 delete mode 100644 arch/powerpc/platforms/cell/spu_priv1.c
 create mode 100644 arch/powerpc/platforms/cell/spu_priv1_mmio.c
 create mode 100644 arch/powerpc/platforms/iseries/dt.c
 delete mode 100644 arch/powerpc/platforms/iseries/vio.c
 delete mode 100644 arch/powerpc/platforms/pseries/vio.c
 create mode 100644 drivers/net/phy/vitesse.c
 create mode 100644 include/asm-powerpc/immap_86xx.h
 rename arch/powerpc/platforms/iseries/iommu.h => include/asm-powerpc/iseries/iommu.h (91%)
 create mode 100644 include/asm-powerpc/mpc86xx.h
 create mode 100644 include/asm-powerpc/spu_priv1.h
 create mode 100644 include/asm-powerpc/systbl.h

Amos Waterland:
      [POWERPC] Fix builtin command line interaction with firmware

Andreas Schwab:
      [POWERPC] Unify ppc syscall tables

Andrew Morton:
      powerpc kbuild warning fix

Andy Fleming:
      Add 85xx CDS to arch/powerpc

Anton Blanchard:
      powerpc: remove io_page_mask
      powerpc: add num_pmcs to 970MP cputable entry
      Add a prctl to change the endianness of a process.
      [POWERPC] 64bit FPSCR support
      [POWERPC] Optimise some TOC usage
      [POWERPC] Remove stale 64bit on 32bit kernel code
      [POWERPC] Update pseries defconfig
      [POWERPC] pcibus_to_node fixes
      [POWERPC] node local IOMMU tables
      [POWERPC] cleanup dma_mapping_ops
      [POWERPC] Fix HV bit handling on non partitioned machines
      [POWERPC] system call micro optimisation
      [POWERPC] update pmac32_defconfig
      [POWERPC] Fix mdelay badness on shared processor partitions
      [POWERPC] Dont look for class-code in pci children
      [POWERPC] support ibm,extended-*-frequency properties

Arnd Bergmann:
      [POWERPC] disable floating point exceptions for init

arnd@arndb.de:
      [POWERPC] cell: fix interrupt priority handling
      [POWERPC] cell: update defconfig
      [POWERPC] cell: always build spu base into the kernel
      [POWERPC] spufs: restore mapping of mssync register
      [POWERPC] spufs: set up correct SLB entries for 64k pages
      [POWERPC] spufs: add a phys-id attribute to each SPU context
      [POWERPC] spufs: fix initial state of wbox file
      [POWERPC] spufs: dont try to access SPE channel 1 count
      [POWERPC] spufs: fail spu_create with invalid flags
      [POWERPC] spufs: one more fix for 64k pages

Benjamin Herrenschmidt:
      powerpc vdso updates
      powerpc: Fix buglet with MMU hash management
      powerpc: Add udbg-immortal kernel option
      [POWERPC] cell: add RAS support

Christoph Hellwig:
      powerpc: implement pcibus_to_node and pcibus_to_cpumask
      powerpc: node-aware dma allocations

Dave C Boutcher:
      [POWERPC] check firmware state before suspending

Geoff Levand:
      powerpc: remove do-nothing cpu setup routines
      [POWERPC] spufs: split the Cell BE support into generic and platform dependant parts
      [POWERPC] spufs: further abstract priv1 register access
      [POWERPC] spufs: fix spu irq affinity setting

Haren Myneni:
      powerpc: clear IPIs on kdump

Jake Moilanen:
      [POWERPC] Add support for PCI-Express nodes in the device tree
      [POWERPC] MSI abstraction

Jeremy Kerr:
      powerpc: cell: use kzalloc in alloc_spu_context()
      powerpc: Add of_parse_dma_window()
      powerpc: pseries: Use generic dma-window parsing function
      [POWERPC] cell: register SPUs as sysdevs
      [POWERPC] spufs: use kzalloc in create_spu

Jimi Xenidis:
      powerpc: Auto reserve of device tree blob

jimix@watson.ibm.com:
      powerpc: udbg_printf() formatting attribute

Johannes Berg:
      [POWERPC] make pmf irq_client functions safe against pmf interrupts coming in

John Rose:
      powerpc: reorg RTAS delay code
      [POWERPC] RTAS delay, fix module build breaks

Jon Loeliger:
      [POWERPC] Guard L3CR references with CPU_FTR_L3CR.
      [POWERPC] Prevent duplicate lmb reservations for Device Tree blob.
      [POWERPC] Add the mpc8641 hpcn Kconfig and Makefiles.
      [POWERPC] Add mpc8641_hpcn_defconfig config file.
      [POWERPC] Add 8641 CPU table entry.
      [POWERPC] Add starting of secondary 86xx CPUs.
      [POWERPC] Add the MPC8641 HPCN platform files.
      [POWERPC] Add mpc8641hpcn PCI/PCI-Express platform files.
      [POWERPC] Add 8641 Register space and IRQ definitions.
      [POWERPC] Document I2C_MPC option for 86xx too.
      [POWERPC] Add Vitesse 8244 PHY for MPC8641 HPCN platform.

Jon Mason:
      remove powerpc bitops in favor of existing generic bitops

Kelly Daly:
      [POWERPC] re-enable OProfile for iSeries, using timer interrupt

Kumar Gala:
      powerpc: provide ppc_md.panic() for both ppc32 & ppc64

Linas Vepstas:
      powerpc/pseries: clear PCI failure counter if no new failures
      powerpc/pseries: Increment fail counter in PCI recovery
      [POWERPC] pseries: Print PCI slot location code on failure

Mark A. Greer:
      [POWERPC] mpic: add support for serial mode interrupts

Masato Noguchi:
      [POWERPC] spufs: remove stop_code from struct spu
      [POWERPC] spufs: fix Makefile for "make clean"
      [POWERPC] spufs: clear class2 interrupt status before wakeup

Matthias Fuchs:
      [POWERPC] ppc32: fix CPCI405 board support

Michael Ellerman:
      powerpc: Disable and EOI interrupts in machine_crash_shutdown()
      powerpc: Make early debugging options behave with oldconfig
      powerpc: Make early xmon logic immune to location of early parsing
      powerpc: Parse early parameters earlier
      powerpc: Unify mem= handling
      powerpc: Kdump header cleanup
      powerpc: Move crashkernel= handling into the kernel.
      powerpc: Make rtas console _much_ faster
      powerpc: Cleanup hvc_rtas.c a little
      [POWERPC] spufs: fix deadlock in spu_create error path

Michael Neuling:
      powerpc: whitespace cleanup in reg.h
      powerpc: oprofile support for POWER6

mostrows@watson.ibm.com:
      powerpc: Create /proc/rtas, /proc/ppc64/rtas if RTAS exists.
      [POWERPC] Editable kernel command-line in zImage binary.

Nathan Lynch:
      [POWERPC] Extra sanity check in EEH code

Olof Johansson:
      powerpc: Quiet HVSI boot output
      powerpc: Quiet time init output
      powerpc: Quiet page order output
      powerpc: Quiet VETH version printk
      powerpc: Don't print chosen idle loop at every boot
      powerpc: Less verbose mem configuration output
      powerpc: Lack of ISA interrupts on XICS isn't dangerous
      powerpc: Quiet PCI init printouts
      powerpc: Quiet rtasd output at boot
      powerpc: Quiet oprofile output at boot
      powerpc: Remove stale iseries global
      powerpc: kill union tce_entry
      powerpc iommu: minor cleanup

Paul Mackerras:
      powerpc: Implement support for setting little-endian mode via prctl
      powerpc: Implement PR_[GS]ET_UNALIGN prctls for powerpc
      powerpc: Fix bug in iommu_alloc_coherent causing hang during boot
      powerpc: add context.vdso_base for 32-bit too
      powerpc: Remove unused paca->pgdir field
      powerpc: Fix some missed ppc32 mm->context.id conversions
      powerpc: Use 64k pages without needing cache-inhibited large pages
      powerpc: Simplify push_end definition in pci_32.c

Renzo Davoli:
      powerpc: enable PPC_PTRACE_[GS]ETREGS on ppc32

Stephen Rothwell:
      powerpc: add all the iSeries virtual devices to the device tree
      powerpc: use the device tree for the iSeries vio bus probe
      powerpc: use a common vio_match_device routine
      powerpc: merge the rest of the vio code
      powerpc: update iseries_veth device-tree information
      powerpc: update iSeries viodasd device-tree entries
      powerpc: update iSeries vdevice
      powerpc: update iSeries viocd and viotape device-tree
      powerpc: the iSeries vio lan driver changed device type
      powerpc: tidy up iseries/pci.c
      powerpc: reintroduce HvCallPci_configLoad32
      powerpc: move iSeries PCI devices to the device tree
      powerpc: remove iSeries_Global_Device_List
      powerpc: remove Irq from pci_dn
      powerpc: remove LogicalSlot from pci_dn
      powerpc: iSeries PCI devices can now have a devpsec attribute
      powerpc: clean up iSeries PCI probe
      powerpc: make iSeries flat device tree stuff static
      powerpc: give iSeries device tree nodes better names
      powerpc: split device tree stuff out of iseries/setup.c
      powerpc: make iSeries flattened device tree dynamic
      powerpc: make iSeries flattened device tree dynamic - part 2
      powerpc: cleanup of iSeries flat device tree

Will Schmidt:
      nvram_print_partitions cosmetic fixup
      powerpc: fix of_parse_dma_window
