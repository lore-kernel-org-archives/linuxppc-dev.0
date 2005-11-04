Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17259.62376.607009.876422@cargo.ozlabs.ibm.com>
Date: Sat, 5 Nov 2005 10:50:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511041115000.28804@g5.osdl.org>
References: <17249.30677.31240.212459@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0511041115000.28804@g5.osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: ppc32/64 merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

>   arch/ppc64/include/asm/elf.h:190:8: warning: memset with byte count of -160
> 
> when checking ppc64 with sparse.
> 
> It looks like it's even correct. I think elf_gregset_t gets set to 
> elf_gregset_t32, which is why "struct pt_regs" is so much bigger than 
> elf_gregset_t.
> 
> Maybe it's a sparse bug. And maybe it isn't.

No it isn't, it's our bug.  Stephen Rothwell and Michael Ellerman
found it a day or two ago and there is a fix in the powerpc-merge tree
already.

If you do a pull from the powerpc-merge tree at

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

(once it's mirrored, or the equivalent from master.kernel.org) you'll
get the fix along with some more merging and some ppc patches.
Diffstat and shortlog follow.

Thanks,
Paul.

 arch/powerpc/Kconfig                            |   29 
 arch/powerpc/Makefile                           |    5 
 arch/powerpc/configs/cell_defconfig             | 1024 +++++++++++++++++
 arch/powerpc/configs/g5_defconfig               | 1392 +++++++++++++++++++++++
 arch/powerpc/configs/iseries_defconfig          |  998 ++++++++++++++++
 arch/powerpc/configs/maple_defconfig            | 1062 ++++++++++++++++++
 arch/powerpc/configs/pseries_defconfig          | 1371 +++++++++++++++++++++++
 arch/powerpc/kernel/Makefile                    |    9 
 arch/powerpc/kernel/asm-offsets.c               |    2 
 arch/powerpc/kernel/head_64.S                   |   20 
 arch/powerpc/kernel/lparmap.c                   |    2 
 arch/powerpc/kernel/ppc32.h                     |   16 
 arch/powerpc/kernel/ppc_ksyms.c                 |    9 
 arch/powerpc/kernel/process.c                   |   22 
 arch/powerpc/kernel/prom.c                      |    2 
 arch/powerpc/kernel/prom_init.c                 |    2 
 arch/powerpc/kernel/rtas-proc.c                 |    0 
 arch/powerpc/kernel/rtas.c                      |   19 
 arch/powerpc/kernel/rtas_flash.c                |  113 ++
 arch/powerpc/kernel/setup-common.c              |  123 ++
 arch/powerpc/kernel/setup_32.c                  |    2 
 arch/powerpc/kernel/setup_64.c                  |  168 +--
 arch/powerpc/kernel/signal_32.c                 |    2 
 arch/powerpc/kernel/signal_64.c                 |    0 
 arch/powerpc/kernel/smp-tbsync.c                |  171 +++
 arch/powerpc/kernel/smp.c                       |   61 -
 arch/powerpc/kernel/time.c                      |    4 
 arch/powerpc/kernel/traps.c                     |   12 
 arch/powerpc/kernel/vmlinux.lds.S               |   29 
 arch/powerpc/lib/Makefile                       |    9 
 arch/powerpc/lib/bitops.c                       |   97 +-
 arch/powerpc/lib/locks.c                        |    2 
 arch/powerpc/platforms/Makefile                 |    1 
 arch/powerpc/platforms/cell/Makefile            |    2 
 arch/powerpc/platforms/cell/interrupt.c         |    8 
 arch/powerpc/platforms/cell/interrupt.h         |    8 
 arch/powerpc/platforms/cell/iommu.c             |   44 -
 arch/powerpc/platforms/cell/iommu.h             |   10 
 arch/powerpc/platforms/cell/setup.c             |   46 -
 arch/powerpc/platforms/cell/smp.c               |  230 ++++
 arch/powerpc/platforms/cell/spider-pic.c        |    2 
 arch/powerpc/platforms/chrp/nvram.c             |   13 
 arch/powerpc/platforms/chrp/pegasos_eth.c       |    1 
 arch/powerpc/platforms/chrp/smp.c               |   39 -
 arch/powerpc/platforms/iseries/call_hpt.h       |    4 
 arch/powerpc/platforms/iseries/call_pci.h       |    4 
 arch/powerpc/platforms/iseries/call_sm.h        |    4 
 arch/powerpc/platforms/iseries/hvlog.c          |    6 
 arch/powerpc/platforms/iseries/hvlpconfig.c     |    2 
 arch/powerpc/platforms/iseries/iommu.c          |    2 
 arch/powerpc/platforms/iseries/irq.c            |    6 
 arch/powerpc/platforms/iseries/ksyms.c          |    2 
 arch/powerpc/platforms/iseries/lpardata.c       |   12 
 arch/powerpc/platforms/iseries/lpevents.c       |    8 
 arch/powerpc/platforms/iseries/mf.c             |    8 
 arch/powerpc/platforms/iseries/naca.h           |    8 
 arch/powerpc/platforms/iseries/pci.c            |    4 
 arch/powerpc/platforms/iseries/proc.c           |    4 
 arch/powerpc/platforms/iseries/release_data.h   |    2 
 arch/powerpc/platforms/iseries/setup.c          |   58 +
 arch/powerpc/platforms/iseries/smp.c            |    2 
 arch/powerpc/platforms/iseries/vio.c            |    8 
 arch/powerpc/platforms/iseries/viopath.c        |   12 
 arch/powerpc/platforms/iseries/vpdinfo.c        |    2 
 arch/powerpc/platforms/powermac/pic.c           |    8 
 arch/powerpc/platforms/powermac/setup.c         |    3 
 arch/powerpc/platforms/pseries/Kconfig          |    9 
 arch/powerpc/platforms/pseries/Makefile         |    2 
 arch/powerpc/platforms/pseries/iommu.c          |    5 
 arch/powerpc/platforms/pseries/lpar.c           |   13 
 arch/powerpc/platforms/pseries/plpar_wrappers.h |  102 +-
 arch/powerpc/platforms/pseries/rtas-fw.c        |  138 --
 arch/powerpc/platforms/pseries/rtas-fw.h        |    3 
 arch/powerpc/platforms/pseries/rtasd.c          |    0 
 arch/powerpc/platforms/pseries/setup.c          |   21 
 arch/powerpc/platforms/pseries/smp.c            |    3 
 arch/powerpc/sysdev/Makefile                    |    1 
 arch/powerpc/sysdev/dart.h                      |    6 
 arch/powerpc/sysdev/mmio_nvram.c                |   60 -
 arch/powerpc/sysdev/u3_iommu.c                  |    5 
 arch/ppc/8xx_io/commproc.c                      |    5 
 arch/ppc/Makefile                               |    3 
 arch/ppc/kernel/Makefile                        |    1 
 arch/ppc/kernel/bitops.c                        |  126 --
 arch/ppc/kernel/irq.c                           |    2 
 arch/ppc/kernel/machine_kexec.c                 |    2 
 arch/ppc/kernel/ppc_ksyms.c                     |    5 
 arch/ppc/kernel/traps.c                         |    8 
 arch/ppc/syslib/m8xx_setup.c                    |    1 
 arch/ppc64/Kconfig                              |    5 
 arch/ppc64/Makefile                             |    1 
 arch/ppc64/kernel/Makefile                      |   16 
 arch/ppc64/kernel/asm-offsets.c                 |    2 
 arch/ppc64/kernel/head.S                        |   20 
 arch/ppc64/kernel/irq.c                         |    4 
 arch/ppc64/kernel/lparcfg.c                     |    4 
 arch/ppc64/kernel/machine_kexec.c               |    1 
 arch/ppc64/kernel/pacaData.c                    |    2 
 arch/ppc64/kernel/pci_dn.c                      |    5 
 arch/ppc64/kernel/proc_ppc64.c                  |    2 
 arch/ppc64/kernel/prom_init.c                   |    4 
 arch/ppc64/kernel/smp-tbsync.c                  |  179 ---
 arch/ppc64/kernel/udbg_scc.c                    |    1 
 arch/ppc64/lib/Makefile                         |    5 
 arch/ppc64/lib/string.S                         |  179 ---
 drivers/block/viodasd.c                         |    8 
 drivers/cdrom/viocd.c                           |    6 
 drivers/char/viocons.c                          |   10 
 drivers/char/viotape.c                          |   10 
 drivers/macintosh/via-pmu.c                     |   29 
 drivers/net/iseries_veth.c                      |    8 
 drivers/scsi/ibmvscsi/iseries_vscsi.c           |    8 
 include/asm-powerpc/bitops.h                    |  437 +++++++
 include/asm-powerpc/bug.h                       |   34 -
 include/asm-powerpc/elf.h                       |   22 
 include/asm-powerpc/futex.h                     |   45 -
 include/asm-powerpc/ioctls.h                    |    3 
 include/asm-powerpc/ipcbuf.h                    |   34 +
 include/asm-powerpc/irq.h                       |    2 
 include/asm-powerpc/iseries/hv_call.h           |   10 
 include/asm-powerpc/iseries/hv_call_event.h     |   10 
 include/asm-powerpc/iseries/hv_call_sc.h        |    6 
 include/asm-powerpc/iseries/hv_call_xm.h        |   10 
 include/asm-powerpc/iseries/hv_lp_config.h      |   12 
 include/asm-powerpc/iseries/hv_lp_event.h       |   10 
 include/asm-powerpc/iseries/hv_types.h          |    6 
 include/asm-powerpc/iseries/iseries_io.h        |    6 
 include/asm-powerpc/iseries/it_exp_vpd_panel.h  |    6 
 include/asm-powerpc/iseries/it_lp_naca.h        |    6 
 include/asm-powerpc/iseries/it_lp_queue.h       |    6 
 include/asm-powerpc/iseries/it_lp_reg_save.h    |    4 
 include/asm-powerpc/iseries/lpar_map.h          |    6 
 include/asm-powerpc/iseries/mf.h                |   10 
 include/asm-powerpc/iseries/vio.h               |   10 
 include/asm-powerpc/kexec.h                     |   49 +
 include/asm-powerpc/machdep.h                   |    1 
 include/asm-powerpc/numnodes.h                  |    7 
 include/asm-powerpc/ppc_asm.h                   |    7 
 include/asm-powerpc/processor.h                 |    2 
 include/asm-powerpc/ptrace.h                    |  143 +-
 include/asm-powerpc/rtas.h                      |   25 
 include/asm-powerpc/sigcontext.h                |   41 -
 include/asm-powerpc/smp.h                       |   45 +
 include/asm-powerpc/sparsemem.h                 |    6 
 include/asm-powerpc/stat.h                      |   81 +
 include/asm-powerpc/system.h                    |   48 +
 include/asm-powerpc/termios.h                   |  135 --
 include/asm-powerpc/time.h                      |    2 
 include/asm-powerpc/tlb.h                       |   70 +
 include/asm-powerpc/tlbflush.h                  |  146 ++
 include/asm-powerpc/uaccess.h                   |  468 ++++++++
 include/asm-powerpc/ucontext.h                  |   40 +
 include/asm-ppc/bitops.h                        |  460 --------
 include/asm-ppc/commproc.h                      |    2 
 include/asm-ppc/futex.h                         |   53 -
 include/asm-ppc/ipcbuf.h                        |   29 
 include/asm-ppc/kexec.h                         |   40 -
 include/asm-ppc/ptrace.h                        |  152 ---
 include/asm-ppc/sigcontext.h                    |   15 
 include/asm-ppc/stat.h                          |   69 -
 include/asm-ppc/tlb.h                           |   57 -
 include/asm-ppc/tlbflush.h                      |  115 --
 include/asm-ppc/uaccess.h                       |  393 ------
 include/asm-ppc/ucontext.h                      |   27 
 include/asm-ppc64/bitops.h                      |  360 ------
 include/asm-ppc64/io.h                          |    2 
 include/asm-ppc64/ipcbuf.h                      |   28 
 include/asm-ppc64/kexec.h                       |   41 -
 include/asm-ppc64/mmu_context.h                 |   15 
 include/asm-ppc64/numnodes.h                    |    7 
 include/asm-ppc64/nvram.h                       |    2 
 include/asm-ppc64/paca.h                        |    2 
 include/asm-ppc64/spinlock.h                    |    2 
 include/asm-ppc64/stat.h                        |   60 -
 include/asm-ppc64/tlb.h                         |   39 -
 include/asm-ppc64/tlbflush.h                    |   52 -
 include/asm-ppc64/uaccess.h                     |  341 ------
 include/asm-ppc64/ucontext.h                    |   22 
 178 files changed, 8701 insertions(+), 4075 deletions(-)
 create mode 100644 arch/powerpc/configs/cell_defconfig
 create mode 100644 arch/powerpc/configs/g5_defconfig
 create mode 100644 arch/powerpc/configs/iseries_defconfig
 create mode 100644 arch/powerpc/configs/maple_defconfig
 create mode 100644 arch/powerpc/configs/pseries_defconfig
 rename include/asm-ppc64/ppc32.h => arch/powerpc/kernel/ppc32.h (86%)
 rename arch/{ppc64/kernel/rtas-proc.c => powerpc/kernel/rtas-proc.c} (100%)
 rename arch/{ppc64/kernel/rtas_flash.c => powerpc/kernel/rtas_flash.c} (87%)
 rename arch/{ppc64/kernel/signal.c => powerpc/kernel/signal_64.c} (100%)
 create mode 100644 arch/powerpc/kernel/smp-tbsync.c
 rename arch/{ppc64/kernel/smp.c => powerpc/kernel/smp.c} (88%)
 rename arch/{ppc64/kernel/bitops.c => powerpc/lib/bitops.c} (55%)
 create mode 100644 arch/powerpc/platforms/cell/Makefile
 rename arch/{ppc64/kernel/bpa_iic.c => powerpc/platforms/cell/interrupt.c} (98%)
 rename arch/{ppc64/kernel/bpa_iic.h => powerpc/platforms/cell/interrupt.h} (93%)
 rename arch/{ppc64/kernel/bpa_iommu.c => powerpc/platforms/cell/iommu.c} (95%)
 rename arch/{ppc64/kernel/bpa_iommu.h => powerpc/platforms/cell/iommu.h} (92%)
 rename arch/{ppc64/kernel/bpa_setup.c => powerpc/platforms/cell/setup.c} (81%)
 create mode 100644 arch/powerpc/platforms/cell/smp.c
 rename arch/{ppc64/kernel/spider-pic.c => powerpc/platforms/cell/spider-pic.c} (100%)
 rename include/asm-ppc64/naca.h => arch/powerpc/platforms/iseries/naca.h (78%)
 rename include/asm-ppc64/plpar_wrappers.h => arch/powerpc/platforms/pseries/plpar_wrappers.h (59%)
 delete mode 100644 arch/powerpc/platforms/pseries/rtas-fw.c
 delete mode 100644 arch/powerpc/platforms/pseries/rtas-fw.h
 rename arch/{ppc64/kernel/rtasd.c => powerpc/platforms/pseries/rtasd.c} (100%)
 rename include/asm-ppc64/dart.h => arch/powerpc/sysdev/dart.h (94%)
 rename arch/{ppc64/kernel/bpa_nvram.c => powerpc/sysdev/mmio_nvram.c} (76%)
 delete mode 100644 arch/ppc/kernel/bitops.c
 delete mode 100644 arch/ppc64/kernel/smp-tbsync.c
 delete mode 100644 arch/ppc64/lib/Makefile
 delete mode 100644 arch/ppc64/lib/string.S
 create mode 100644 include/asm-powerpc/bitops.h
 rename include/{asm-ppc64/futex.h => asm-powerpc/futex.h} (68%)
 create mode 100644 include/asm-powerpc/ipcbuf.h
 rename include/{asm-ppc64/iSeries/HvCall.h => asm-powerpc/iseries/hv_call.h} (93%)
 rename include/{asm-ppc64/iSeries/HvCallEvent.h => asm-powerpc/iseries/hv_call_event.h} (96%)
 rename include/{asm-ppc64/iSeries/HvCallSc.h => asm-powerpc/iseries/hv_call_sc.h} (92%)
 rename include/{asm-ppc64/iSeries/HvCallXm.h => asm-powerpc/iseries/hv_call_xm.h} (87%)
 rename include/{asm-ppc64/iSeries/HvLpConfig.h => asm-powerpc/iseries/hv_lp_config.h} (92%)
 rename include/{asm-ppc64/iSeries/HvLpEvent.h => asm-powerpc/iseries/hv_lp_event.h} (96%)
 rename include/{asm-ppc64/iSeries/HvTypes.h => asm-powerpc/iseries/hv_types.h} (96%)
 rename include/{asm-ppc64/iSeries/iSeries_io.h => asm-powerpc/iseries/iseries_io.h} (93%)
 rename include/{asm-ppc64/iSeries/ItExtVpdPanel.h => asm-powerpc/iseries/it_exp_vpd_panel.h} (88%)
 rename include/{asm-ppc64/iSeries/ItLpNaca.h => asm-powerpc/iseries/it_lp_naca.h} (95%)
 rename include/{asm-ppc64/iSeries/ItLpQueue.h => asm-powerpc/iseries/it_lp_queue.h} (95%)
 rename include/{asm-ppc64/iSeries/ItLpRegSave.h => asm-powerpc/iseries/it_lp_reg_save.h} (97%)
 rename include/{asm-ppc64/iSeries/LparMap.h => asm-powerpc/iseries/lpar_map.h} (95%)
 rename include/{asm-ppc64/iSeries/mf.h => asm-powerpc/iseries/mf.h} (94%)
 rename include/{asm-ppc64/iSeries/vio.h => asm-powerpc/iseries/vio.h} (95%)
 create mode 100644 include/asm-powerpc/kexec.h
 create mode 100644 include/asm-powerpc/numnodes.h
 rename include/{asm-ppc64/ptrace.h => asm-powerpc/ptrace.h} (61%)
 rename include/{asm-ppc64/sigcontext.h => asm-powerpc/sigcontext.h} (67%)
 rename include/{asm-ppc64/smp.h => asm-powerpc/smp.h} (66%)
 rename include/{asm-ppc64/sparsemem.h => asm-powerpc/sparsemem.h} (67%)
 create mode 100644 include/asm-powerpc/stat.h
 create mode 100644 include/asm-powerpc/tlb.h
 create mode 100644 include/asm-powerpc/tlbflush.h
 create mode 100644 include/asm-powerpc/uaccess.h
 create mode 100644 include/asm-powerpc/ucontext.h
 delete mode 100644 include/asm-ppc/bitops.h
 delete mode 100644 include/asm-ppc/futex.h
 delete mode 100644 include/asm-ppc/ipcbuf.h
 delete mode 100644 include/asm-ppc/kexec.h
 delete mode 100644 include/asm-ppc/ptrace.h
 delete mode 100644 include/asm-ppc/sigcontext.h
 delete mode 100644 include/asm-ppc/stat.h
 delete mode 100644 include/asm-ppc/tlb.h
 delete mode 100644 include/asm-ppc/tlbflush.h
 delete mode 100644 include/asm-ppc/uaccess.h
 delete mode 100644 include/asm-ppc/ucontext.h
 delete mode 100644 include/asm-ppc64/bitops.h
 delete mode 100644 include/asm-ppc64/ipcbuf.h
 delete mode 100644 include/asm-ppc64/kexec.h
 delete mode 100644 include/asm-ppc64/numnodes.h
 delete mode 100644 include/asm-ppc64/stat.h
 delete mode 100644 include/asm-ppc64/tlb.h
 delete mode 100644 include/asm-ppc64/tlbflush.h
 delete mode 100644 include/asm-ppc64/uaccess.h
 delete mode 100644 include/asm-ppc64/ucontext.h

Al Viro:
      ppc bug.h namespace pollution

Arnd Bergmann:
      powerpc: Rename BPA to Cell
      powerpc: create a new arch/powerpc/platforms/cell/smp.c
      powerpc: move rtas_fw.c out of platforms/pseries
      powerpc: move mmio_nvram.c over to arch/powerpc
      powerpc: move arch/ppc64/kernel/bpa* to arch/powerpc/platforms/cell

Becky Bruce:
      ppc: Fix build warnings in arch/ppc/kernel/traps.c

David Gibson:
      powerpc: Merge ipcbuf.h
      powerpc: Merge bitops.h
      powerpc: Fix merged ipcbuf.h
      powerpc: Merge futex.h
      powerpc: Merge (move) numnodes.h and sparsemem.h
      powerpc: Move dart.h
      powerpc: Move naca.h to platforms/iseries
      powerpc: Keep fixing merged ipcbuf.h

David Woodhouse:
      powerpc: always init nvram on 64-bit powermac

John Rose:
      ppc64: Fix add notifier crashes

Kelly Daly:
      merge filename and modify references to iseries/hv_call.h
      merge filename and modify references to iseries/hv_call_event.h
      merge filename and modify references to iseries/hv_call_sc.h
      merge filename and modify references to iseries/hv_call_xm.h
      merge filename and modify reference to iseries/hv_lp_config.h
      merge filename and modify references to iseries/hv_lp_event.h
      merge filename and modify references to iseries/hv_types.h
      merge filename and modify references to iseries/it_exp_vpd_panel.h
      merge filename and modify references to iseries/it_lp_naca.h
      merge filename and modify references to iseries/it_lp_queue.h
      merge filename and modify references to iseries/it_lp_reg_save.h
      merge filename and modify references to iseries/lpar_map.h
      merge filename and modify references to iseries/iseries_io.h
      merge filename and modify references to iSeries/mf.h
      merge filename and modify references to iseries/vio.h
      fix incorrect dir
      modify defines according to _ASM_POWERPC_ISERIES_

Marcelo Tosatti:
      ppc32 8xx: export symbols required for modular IDE
      ppc32 8xx: Fix harmless warning in 8xx_io/commproc.c
      ppc32 8xx: fix cpm_dpalloc() comment

Michael Ellerman:
      powerpc: Copy default configs into arch/powerpc/configs
      powerpc: Make set_dabr() a ppc_md function
      powerpc: Move plpar_wrappers.h into arch/powerpc/platforms/pseries
      powerpc: Merge asm-ppc/kexec.h and asm-ppc64/kexec.h
      powerpc: Make early debugging fit on 80 character terminal
      powerpc: Set entry point and text address in linker script
      powerpc: Add helper functions for synthesising instructions at runtime
      powerpc: Cleanup vpa code
      powerpc: Implement smp_release_cpus() in C not asm
      powerpc: Fix random memory corruption in merged elf.h
      Merge with Paulus

Paul Mackerras:
      powerpc: Fix BUG/WARN macros for 64-bit
      powerpc: Fix pseries (64-bit) build
      powerpc: Use rtas_call not call_rtas in CHRP code
      powerpc: Fix compile error with CONFIG_TAU=y
      powerpc: exclude powerbook sleep code with CONFIG_PPC64 and CONFIG_PM
      Merge git://oak/home/sfr/kernels/iseries/work
      powerpc: clean up bug.h further
      Merge ../linux-2.6
      powerpc: include lmb.h in arch/powerpc/platforms/powermac/setup.c
      powerpc: include <linux/platform_device.h> in pegasos_eth.c
      powerpc: Compile fixes for chrp/nvram.c
      powerpc: Merge remaining RTAS code
      Merge git://oak/home/sfr/kernels/iseries/work
      powerpc: Merge smp-tbsync.c (the generic timebase sync routine)
      Merge branch 'for-paulus' of git://kernel/home/michael/src/work/
      Merge git://oak/home/sfr/kernels/iseries/work
      powerpc: Merge smp.c and smp.h
      powerpc: Fix vmlinux.lds.S for 32-bit

Stephen Rothwell:
      powerpc: merge uaccess.h
      powerpc: fix __strnlen_user in merge tree
      powerpc: make mem= work on iSeries again
      powerpc: remove duplicate ioctl definitions
      powerpc: use asm-generic/termios.h
      powerpc: clean up uaccess.h
      Merge iSeries include file move
      Merge Paulus' tree
      powerpc: merge stat.h
      powerpc: merge ptrace.h
      powerpc: move ppc64/kernel/signal.c to arch/powerpc
      powerpc: move include/asm-ppc64/ppc32.h to arch/powerpc/kernel
      powerpc: merge sigcontext.h
      powerpc: merge ucontext.h
      powerpc: merge tlb.h
      powerpc: merge tlbflush.h

Vitaly Bordug:
      ppc32: Fixed warning in m8xx_setup.c
