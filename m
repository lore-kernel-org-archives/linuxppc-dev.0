Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
Date: Fri, 15 Jun 2007 14:50:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: for-2.6.23 branch in powerpc.git created
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have created a for-2.6.23 branch in the powerpc.git repository
(git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git)
where I have started queueing up patches to go in once the 2.6.23
merge window opens.  For now at least it's the same as the master
branch.

The patches I put in are listed below.  If you have a patch that
should go in but isn't listed, remind me about it.

Paul.

 Documentation/cachetlb.txt                   |    2 
 arch/powerpc/Kconfig                         |  256 -------------------
 arch/powerpc/boot/44x.c                      |   45 +++
 arch/powerpc/boot/44x.h                      |    3 
 arch/powerpc/boot/Makefile                   |    4 
 arch/powerpc/boot/cuboot-83xx.c              |   13 -
 arch/powerpc/boot/cuboot-85xx.c              |   13 -
 arch/powerpc/boot/cuboot-ebony.c             |   16 -
 arch/powerpc/boot/cuboot.c                   |   35 +++
 arch/powerpc/boot/cuboot.h                   |   14 +
 arch/powerpc/boot/dcr.h                      |   37 +++
 arch/powerpc/boot/dts/ebony.dts              |    8 -
 arch/powerpc/boot/dts/holly.dts              |   52 ++--
 arch/powerpc/boot/dts/mpc7448hpc2.dts        |   33 +-
 arch/powerpc/boot/ebony.c                    |   19 -
 arch/powerpc/boot/of.c                       |  188 +-------------
 arch/powerpc/boot/of.h                       |   15 +
 arch/powerpc/boot/ofconsole.c                |   45 +++
 arch/powerpc/boot/oflib.c                    |  172 ++++++++++++
 arch/powerpc/configs/holly_defconfig         |    3 
 arch/powerpc/kernel/Makefile                 |    5 
 arch/powerpc/kernel/head_32.S                |  122 ---------
 arch/powerpc/kernel/irq.c                    |    1 
 arch/powerpc/kernel/isa-bridge.c             |  271 ++++++++++++++++++++
 arch/powerpc/kernel/misc_32.S                |   10 -
 arch/powerpc/kernel/of_platform.c            |    8 -
 arch/powerpc/kernel/pci_64.c                 |  358 +++++++++-----------------
 arch/powerpc/kernel/process.c                |   14 +
 arch/powerpc/kernel/prom_init.c              |    4 
 arch/powerpc/kernel/ptrace-common.h          |  161 ------------
 arch/powerpc/kernel/ptrace.c                 |  325 ++++++++++++++++--------
 arch/powerpc/kernel/ptrace32.c               |  239 ++++++++---------
 arch/powerpc/kernel/rtas_pci.c               |    7 -
 arch/powerpc/kernel/setup_32.c               |   12 -
 arch/powerpc/kernel/signal.c                 |  180 +++++++++++++
 arch/powerpc/kernel/signal.h                 |   55 ++++
 arch/powerpc/kernel/signal_32.c              |  191 ++------------
 arch/powerpc/kernel/signal_64.c              |  182 -------------
 arch/powerpc/kernel/vdso.c                   |    2 
 arch/powerpc/mm/44x_mmu.c                    |    1 
 arch/powerpc/mm/4xx_mmu.c                    |    1 
 arch/powerpc/mm/Makefile                     |    3 
 arch/powerpc/mm/fault.c                      |    2 
 arch/powerpc/mm/fsl_booke_mmu.c              |    1 
 arch/powerpc/mm/hash_native_64.c             |   25 +-
 arch/powerpc/mm/hash_utils_64.c              |    2 
 arch/powerpc/mm/imalloc.c                    |  313 -----------------------
 arch/powerpc/mm/init_32.c                    |    1 
 arch/powerpc/mm/init_64.c                    |    1 
 arch/powerpc/mm/mem.c                        |    1 
 arch/powerpc/mm/mmu_context_32.c             |    1 
 arch/powerpc/mm/mmu_decl.h                   |   17 -
 arch/powerpc/mm/pgtable_32.c                 |  123 ---------
 arch/powerpc/mm/pgtable_64.c                 |  206 ++++-----------
 arch/powerpc/mm/ppc_mmu_32.c                 |    7 -
 arch/powerpc/mm/tlb_32.c                     |    1 
 arch/powerpc/mm/tlb_64.c                     |   57 ++++
 arch/powerpc/platforms/Kconfig               |    7 -
 arch/powerpc/platforms/Kconfig.cputype       |  252 ++++++++++++++++++
 arch/powerpc/platforms/apus/Kconfig          |  130 ---------
 arch/powerpc/platforms/cell/io-workarounds.c |    2 
 arch/powerpc/platforms/cell/spufs/file.c     |   27 ++
 arch/powerpc/platforms/cell/spufs/run.c      |   12 +
 arch/powerpc/platforms/iseries/call_hpt.h    |    9 -
 arch/powerpc/platforms/iseries/htab.c        |    8 -
 arch/powerpc/platforms/iseries/pci.c         |    5 
 arch/powerpc/platforms/maple/pci.c           |   35 ---
 arch/powerpc/platforms/pasemi/pci.c          |   20 -
 arch/powerpc/platforms/powermac/pci.c        |   32 --
 arch/powerpc/platforms/ps3/htab.c            |   14 +
 arch/powerpc/platforms/pseries/Makefile      |    2 
 arch/powerpc/platforms/pseries/eeh.c         |   19 +
 arch/powerpc/platforms/pseries/eeh_cache.c   |    5 
 arch/powerpc/platforms/pseries/eeh_driver.c  |    6 
 arch/powerpc/platforms/pseries/eeh_sysfs.c   |   87 ++++++
 arch/powerpc/platforms/pseries/pci_dlpar.c   |    9 -
 arch/powerpc/platforms/pseries/pseries.h     |    2 
 arch/powerpc/platforms/pseries/setup.c       |    2 
 arch/powerpc/sysdev/tsi108_dev.c             |   33 ++
 arch/ppc/kernel/misc.S                       |    8 -
 arch/ppc/kernel/setup.c                      |    2 
 drivers/pci/hotplug/rpadlpar_core.c          |    6 
 include/asm-powerpc/cputable.h               |   95 +++----
 include/asm-powerpc/floppy.h                 |    6 
 include/asm-powerpc/io.h                     |   26 +-
 include/asm-powerpc/lppaca.h                 |    2 
 include/asm-powerpc/mmu-hash32.h             |   91 +++++++
 include/asm-powerpc/mmu-hash64.h             |    6 
 include/asm-powerpc/mmu.h                    |    3 
 include/asm-powerpc/pci-bridge.h             |   23 +-
 include/asm-powerpc/pci.h                    |    4 
 include/asm-powerpc/pgtable-ppc32.h          |   50 ----
 include/asm-powerpc/pgtable-ppc64.h          |   50 +---
 include/asm-powerpc/pgtable.h                |   28 ++
 include/asm-powerpc/ppc-pci.h                |    9 -
 include/asm-powerpc/ptrace.h                 |   22 +-
 include/asm-powerpc/syscalls.h               |    7 -
 include/asm-powerpc/thread_info.h            |   12 +
 include/asm-powerpc/tlbflush.h               |    5 
 include/linux/vmalloc.h                      |    3 
 mm/vmalloc.c                                 |   13 +
 101 files changed, 2299 insertions(+), 2773 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot.c
 create mode 100644 arch/powerpc/boot/cuboot.h
 create mode 100644 arch/powerpc/boot/of.h
 create mode 100644 arch/powerpc/boot/ofconsole.c
 create mode 100644 arch/powerpc/boot/oflib.c
 create mode 100644 arch/powerpc/kernel/isa-bridge.c
 delete mode 100644 arch/powerpc/kernel/ptrace-common.h
 create mode 100644 arch/powerpc/kernel/signal.c
 create mode 100644 arch/powerpc/kernel/signal.h
 delete mode 100644 arch/powerpc/mm/imalloc.c
 create mode 100644 arch/powerpc/platforms/Kconfig.cputype
 delete mode 100644 arch/powerpc/platforms/apus/Kconfig
 create mode 100644 arch/powerpc/platforms/pseries/eeh_sysfs.c
 create mode 100644 include/asm-powerpc/mmu-hash32.h


Anton Blanchard (1):
      [POWERPC] Reserve threadinfo flags for perfmon2

Arnd Bergmann (1):
      [POWERPC] Split out CPU specific options into a new Kconfig file

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

Christoph Hellwig (3):
      [POWERPC] Consolidate sys_sigaltstack
      [POWERPC] Consolidate restore_sigmask
      [POWERPC] Consolidate do_signal

David Gibson (13):
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

Jake Moilanen (1):
      [POWERPC] Donate idle CPU cycles on dedicated partitions

Jon Tollefson (1):
      [POWERPC] Move common code out of if/else

Linas Vepstas (5):
      [POWERPC] pseries: asm/pci-bridge.h CONFIG_ minor cleanup
      [POWERPC] Add EEH sysfs blinkenlights
      [POWERPC] Show EEH per-device false positives
      [POWERPC] Remove dead EEH code
      [POWERPC] Tweak EEH copyright info

Segher Boessenkool (1):
      [POWERPC] Fix VDSO compile warning

will schmidt (1):
      [POWERPC] During VM oom condition, kill all threads in process group
