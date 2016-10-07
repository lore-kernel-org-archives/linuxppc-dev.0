Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sqwyV6Wk7zDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 15:09:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, andrew.donnellan@au1.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, anton@samba.org, arnd@arndb.de,
 benh@kernel.crashing.org, bsingharora@gmail.com, christophe.leroy@c-s.fr,
 colin.king@canonical.com, cyrilbur@gmail.com, daniel@iogearbox.net,
 darren@stevens-zone.net, dja@axtens.net, fbarrat@linux.vnet.ibm.com,
 gwshan@linux.vnet.ibm.com, imunsie@au1.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com, oohall@gmail.com,
 paulus@ozlabs.org, prasannatsmkumar@gmail.com, rui.teng@linux.vnet.ibm.com,
 ruscur@russell.cc, wei.guo.simon@gmail.com, xinhui.pan@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.9-1 tag
Date: Fri, 07 Oct 2016 15:09:33 +1100
Message-ID: <871szser5u.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Hi Linus,

Please pull the first batch of powerpc updates for 4.9:

The following changes since commit c6935931c1894ff857616ff8549b61236a19148f:

  Linux 4.8-rc5 (2016-09-04 14:31:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.9-1

for you to fetch changes up to b7b7013cac55d794940bd9cb7b7c55c9dececac4:

  powerpc/bpf: Add support for bpf constant blinding (2016-10-04 20:33:20 +1100)

----------------------------------------------------------------
powerpc updates for 4.9

Highlights:
 - Major rework of Book3S 64-bit exception vectors (Nicholas Piggin)
   - Use gas sections for arranging exception vectors et. al.
 - Large set of TM cleanups and selftests (Cyril Bur)
 - Enable transactional memory (TM) lazily for userspace (Cyril Bur)
 - Support for XZ compression in the zImage wrapper (Oliver O'Halloran)
 - Add support for bpf constant blinding (Naveen N. Rao)
 - Beginnings of upstream support for PA Semi Nemo motherboards (Darren Stevens)

Fixes:
 - Ensure .mem(init|exit).text are within _stext/_etext (Michael Ellerman)
 - xmon: Don't use ld on 32-bit (Michael Ellerman)
 - vdso64: Use double word compare on pointers (Anton Blanchard)
 - powerpc/nvram: Fix an incorrect partition merge (Pan Xinhui)
 - powerpc: Fix usage of _PAGE_RO in hugepage (Christophe Leroy)
 - powerpc/mm: Update FORCE_MAX_ZONEORDER range to allow hugetlb w/4K (Aneesh Kumar K.V)
 - Fix memory leak in queue_hotplug_event() error path (Andrew Donnellan)
 - Replay hypervisor maintenance interrupt first (Nicholas Piggin)

Cleanups & features:
 - Sparse fixes/cleanups (Daniel Axtens)
 - Preserve CFAR value on SLB miss caused by access to bogus address (Paul Mackerras)
 - Radix MMU fixups for POWER9 (Aneesh Kumar K.V)
 - Support for setting used_(vsr|vr|spe) in sigreturn path (for CRIU) (Simon Guo)
 - Optimise syscall entry for virtual, relocatable case (Nicholas Piggin)
 - Optimise MSR handling in exception handling (Nicholas Piggin)
 - Support for kexec with Radix MMU (Benjamin Herrenschmidt)
 - powernv EEH fixes (Russell Currey)
 - Suprise PCI hotplug support for powernv (Gavin Shan)
 - Endian/sparse fixes for powernv PCI (Gavin Shan)
 - Defconfig updates (Anton Blanchard)
 - Various performance optimisations (Anton Blanchard)
   - Align hot loops of memset() and backwards_memcpy()
   - During context switch, check before setting mm_cpumask
   - Remove static branch prediction in atomic{, 64}_add_unless
   - Only disable HAVE_EFFICIENT_UNALIGNED_ACCESS on POWER7 little endian
   - Set default CPU type to POWER8 for little endian builds

 - KVM: PPC: Book3S HV: Migrate pinned pages out of CMA (Balbir Singh)
 - cxl: Flush PSL cache before resetting the adapter (Frederic Barrat)
 - cxl: replace loop with for_each_child_of_node(), remove unneeded of_node_put() (Andrew Donnellan)
 - Fix HV facility unavailable to use correct handler (Nicholas Piggin)
 - Remove unnecessary syscall trampoline (Nicholas Piggin)
 - fadump: Fix build break when CONFIG_PROC_VMCORE=n (Michael Ellerman)
 - Quieten EEH message when no adapters are found (Anton Blanchard)
 - powernv: Add PHB register dump debugfs handle (Russell Currey)
 - Use kprobe blacklist for exception handlers & asm functions (Nicholas Piggin)
 - Document the syscall ABI (Nicholas Piggin)
 - MAINTAINERS: Update cxl maintainers (Michael Neuling)
 - powerpc: Remove all usages of NO_IRQ (Michael Ellerman)

Minor cleanups:
 - Andrew Donnellan, Christophe Leroy, Colin Ian King, Cyril Bur, Frederic Barrat,
   Pan Xinhui, PrasannaKumar Muralidharan, Rui Teng, Simon Guo.

----------------------------------------------------------------
Andrew Donnellan (3):
      powerpc/pseries: fix memory leak in queue_hotplug_event() error path
      powerpc/powernv: Fix comment style and spelling
      cxl: replace loop with for_each_child_of_node(), remove unneeded of_node_put()

Aneesh Kumar K.V (6):
      powerpc/book3s: Add a cpu table entry for different POWER9 revs
      powerpc/mm/radix: Use different RTS encoding for different POWER9 revs
      powerpc/mm/radix: Use different pte update sequence for different POWER9 revs
      powerpc/mm: Update the HID bit when switching from radix to hash
      powerpc/mm: Update FORCE_MAX_ZONEORDER range to allow hugetlb w/4K
      powerpc/mm: Add radix flush all with IS=3

Anton Blanchard (11):
      powerpc/vdso64: Use double word compare on pointers
      powerpc/64: Align hot loops of memset() and backwards_memcpy()
      powerpc/configs: Enable VMX crypto
      powerpc/configs: Bump kernel ring buffer size on 64 bit configs
      powerpc/configs: Change a few things from built in to modules
      powerpc/configs: Enable Intel i40e on 64 bit configs
      powerpc/eeh: Quieten EEH message when no adapters are found
      powerpc: During context switch, check before setting mm_cpumask
      powerpc: Remove static branch prediction in atomic{, 64}_add_unless
      powerpc: Only disable HAVE_EFFICIENT_UNALIGNED_ACCESS on POWER7 little endian
      powerpc: Set default CPU type to POWER8 for little endian builds

Balbir Singh (1):
      KVM: PPC: Book3S HV: Migrate pinned pages out of CMA

Benjamin Herrenschmidt (4):
      powerpc/64/kexec: NULL check "clear_all" in kexec_sequence
      powerpc/64/kexec: Fix MMU cleanup on radix
      powerpc/64/kexec: Copy image with MMU off when possible
      powerpc/64/kexec: Remove BookE special default_machine_kexec_prepare()

Christophe Leroy (2):
      powerpc: Fix usage of _PAGE_RO in hugepage
      powerpc/32: Remove CLR_TOP32

Colin Ian King (2):
      powerpc/ps3: fix spelling mistake in function name
      powerpc/32: Add missing \n and switch to pr_warn()

Cyril Bur (22):
      selftests/powerpc: Compile selftests against headers without AT_HWCAP2
      powerpc: Always restore FPU/VEC/VSX if hardware transactional memory in use
      powerpc: Add check_if_tm_restore_required() to giveup_all()
      powerpc: Return the new MSR from msr_check_and_set()
      powerpc: Never giveup a reclaimed thread when enabling kernel {fp, altivec, vsx}
      powerpc: signals: Stop using current in signal code
      selftests/powerpc: Check for VSX preservation across userspace preemption
      selftests/powerpc: Rework FPU stack placement macros and move to header file
      selftests/powerpc: Move VMX stack frame macros to header file
      selftests/powerpc: Introduce GPR asm helper header file
      selftests/powerpc: Allow tests to extend their kill timeout
      selftests/powerpc: Add TM tcheck helpers in C
      selftests/powerpc: Check that signals always get delivered
      selftests/powerpc: Add checks for transactional GPRs in signal contexts
      selftests/powerpc: Add checks for transactional FPUs in signal contexts
      selftests/powerpc: Add checks for transactional VMXs in signal contexts
      selftests/powerpc: Add checks for transactional VSXs in signal contexts
      powerpc: tm: Always use fp_state and vr_state to store live registers
      powerpc: tm: Rename transct_(*) to ck(\1)_state
      powerpc: Remove do_load_up_transact_{fpu,altivec}
      powerpc/tm: Add TM Unavailable Exception
      powerpc: tm: Enable transactional memory (TM) lazily for userspace

Daniel Axtens (4):
      powerpc/cell: Drop unused iic_get_irq_host()
      powerpc/sparse: Make a bunch of things static
      powerpc/fadump: Set core e_flags using kernel's ELF ABI version
      powerpc/sparse: Add more assembler prototypes

Darren Stevens (3):
      powerpc/pasemi: Add Nemo motherboard config option.
      powerpc/pasemi: Fix Nemo SB600 i8259 interrupts.
      powerpc/pasemi: Fix device_type of Nemo SB600 node.

Frederic Barrat (2):
      cxl: Fix informational message
      cxl: Flush PSL cache before resetting the adapter

Gavin Shan (13):
      powerpc/powernv: Call opal_pci_poll() if needed
      powerpc/eeh: Allow to freeze PE in eeh_pe_set_option()
      powerpc/eeh: Export confirm_error_lock
      powerpc/eeh: Export eeh_pe_state_mark()
      powerpc/powernv: Unfreeze PE on allocation
      drivers/pci/hotplug: Remove likely() and unlikely() in powernv driver
      drivers/pci/hotplug: Support surprise hotplug in powernv driver
      drivers/pci/hotplug: Use of_property_read_u32() in powernv driver
      powerpc/powernv: Pass CPU-endian PE number to opal_pci_eeh_freeze_clear()
      powerpc/powernv: Use CPU-endian hub diag-data type in pnv_eeh_get_and_dump_hub_diag()
      powerpc/powernv: Specify proper data type for PCI_SLOT_ID_PREFIX
      powerpc/powernv: Use CPU-endian PEST in pnv_pci_dump_p7ioc_diag_data()
      powerpc/powernv: Fix data type for @r in pnv_ioda_parse_m64_window()

Michael Ellerman (13):
      powerpc/xmon: Don't use ld on 32-bit
      powerpc/64: Correct comment on LOAD_HANDLER()
      powerpc/64: Do load of PACAKBASE in LOAD_HANDLER
      powerpc/Makefile: CROSS32AS is unused, remove it
      powerpc/vdso64: Drop vdso64as
      powerpc/boot: Use $(Q) to quiet build rules not @
      powerpc/Makefile: Drop CONFIG_WORD_SIZE for BITS
      powerpc/Makefile: Construct the UTS_MACHINE value more concisely
      powerpc: Don't change the section in _GLOBAL()
      powerpc: Ensure .mem(init|exit).text are within _stext/_etext
      powerpc: Remove all usages of NO_IRQ
      powerpc/64s: Add new exception vector macros
      powerpc/fadump: Fix build break when CONFIG_PROC_VMCORE=n

Michael Neuling (1):
      MAINTAINERS: Update cxl maintainers

Naveen N. Rao (3):
      powerpc/bpf: Introduce accessors for using the tmp local stack space
      powerpc/bpf: Implement support for tail calls
      powerpc/bpf: Add support for bpf constant blinding

Nicholas Piggin (49):
      powerpc: Use kprobe blacklist for exception handlers
      powerpc/kernel: Use kprobe blacklist for asm functions
      powerpc/64: Replay hypervisor maintenance interrupt first
      powerpc/64: Document the syscall ABI
      powerpc/64: Optimise syscall entry for virtual, relocatable case
      powerpc/64s: Optimise MSR handling in exception handling
      powerpc/pseries: Fix HV facility unavailable to use correct handler
      powerpc/pseries: Remove unnecessary syscall trampoline
      powerpc/64s: Consolidate exception handler alignment
      powerpc/64: Change the way relocation copy is calculated
      powerpc: Use gas sections for arranging exception vectors
      powerpc/64s: Consolidate System Reset 0x100 interrupt
      powerpc/64s: Consolidate Machine Check 0x200 interrupt
      powerpc/64s: Consolidate Data Storage 0x300 interrupt
      powerpc/64s: Consolidate Data Segment 0x380 interrupt
      powerpc/64s: Consolidate Instruction Storage 0x400 interrupt
      powerpc/64s: Consolidate Instruction Segment 0x480 interrupt
      powerpc/64s: Consolidate External 0x500 interrupt
      powerpc/64s: Consolidate Alignment 0x600 interrupt
      powerpc/64s: Consolidate Program 0x700 interrupt
      powerpc/64s: Consolidate FP Unavailable 0x800 interrupt
      powerpc/64s: Consolidate Decrementer 0x900 interrupt
      powerpc/64s: Consolidate Hypervisor Decrementer 0x980 interrupt
      powerpc/64s: Consolidate Directed Privileged Doorbell 0xa00 interrupt
      powerpc/64s: Consolidate Reserved 0xb00 interrupt
      powerpc/64s: Consolidate System Call 0xc00 interrupt
      powerpc/64s: Consolidate Trace 0xd00 interrupt
      powerpc/64s: Consolidate Hypervisor Data Storage 0xe00 interrupt
      powerpc/64s: Consolidate Hypervisor Instruction Storage 0xe20 interrupt
      powerpc/64s: Consolidate Hypervisor Emulation Assistance 0xe40 interrupt
      powerpc/64s: Consolidate Hypervisor Maintenance 0xe60 interrupt
      powerpc/64s: Consolidate Directed Hypervisor Doorbell 0xe80 interrupt
      powerpc/64s: Consolidate Hypervisor Virtualization 0xea0 interrupt
      powerpc/64s: Consolidate Reserved 0xec0, 0xee0 interrupts
      powerpc/64s: Consolidate Performance Monitor 0xf00 interrupt
      powerpc/64s: Consolidate Vector Unavailable 0xf20 interrupt
      powerpc/64s: Consolidate VSX Unavailable 0xf40 interrupt
      powerpc/64s: Consolidate Facility Unavailable 0xf60 interrupt
      powerpc/64s: Consolidate Hypervisor Facility Unavailable 0xf80 interrupt
      powerpc/64s: Consolidate Reserved 0xfa0-0x1200 interrupts
      powerpc/64s: Consolidate CBE System Error 0x1200 interrupt
      powerpc/64s: Consolidate Instruction Breakpoint 0x1300 interrupt
      powerpc/64s: Consolidate Softpatch 0x1500 interrupt
      powerpc/64s: Consolidate Debug 0x1600 interrupt
      powerpc/64s: Consolidate Altivec 0x1700 interrupt
      powerpc/64s: Consolidate CBE Thermal 0x1800 interrupt
      powerpc/64s: Move __replay_interrupt function below handlers
      powerpc/64s: Use a single macro for both parts of OOL exception
      powerpc/64s: Remove unused exception code, small cleanups

Oliver O'Halloran (6):
      powerpc/boot: Add sed script
      powerpc/boot: Use CONFIG_KERNEL_GZIP
      powerpc/boot: Use the pre-boot decompression API
      powerpc/boot: Remove the legacy gzip wrapper
      powerpc/boot: Add XZ support to the wrapper script
      powerpc/boot: Add support for XZ compression

Pan Xinhui (2):
      powerpc/nvram: Fix a memory leak in err path
      powerpc/nvram: Fix an incorrect partition merge

Paul Mackerras (1):
      powerpc/mm: Preserve CFAR value on SLB miss caused by access to bogus address

PrasannaKumar Muralidharan (1):
      hwrng: pasemi-rng - Use linux/io.h instead of asm/io.h

Rui Teng (1):
      powerpc: Clean up tm_abort duplication in hash_utils_64.c

Russell Currey (4):
      powerpc/powernv/pci: Add PHB register dump debugfs handle
      powerpc/eeh: Null check uses of eeh_pe_bus_get
      powerpc/powernv/eeh: Skip finding bus for VF resets
      powerpc/eeh: Skip finding bus until after failure reporting

Simon Guo (2):
      powerpc/ptrace: Fix cppcheck issue in gpr32_set_common/gpr32_get_common()
      powerpc: Set used_(vsr|vr|spe) in sigreturn path when MSR bits are active

 Documentation/powerpc/syscall64-abi.txt            |  105 +
 MAINTAINERS                                        |    4 +-
 arch/powerpc/Kconfig                               |   10 +-
 arch/powerpc/Makefile                              |   43 +-
 arch/powerpc/boot/Makefile                         |   86 +-
 arch/powerpc/boot/cuboot-c2k.c                     |    1 -
 arch/powerpc/boot/decompress.c                     |  148 ++
 arch/powerpc/boot/fixup-headers.sed                |   12 +
 arch/powerpc/boot/gunzip_util.c                    |  204 --
 arch/powerpc/boot/gunzip_util.h                    |   45 -
 arch/powerpc/boot/main.c                           |   35 +-
 arch/powerpc/boot/ops.h                            |    3 +
 arch/powerpc/boot/stdbool.h                        |   14 +
 arch/powerpc/boot/stdint.h                         |   13 +
 arch/powerpc/boot/types.h                          |   14 +
 arch/powerpc/boot/wrapper                          |   61 +-
 arch/powerpc/boot/xz_config.h                      |   39 +
 arch/powerpc/configs/powernv_defconfig             |   19 +-
 arch/powerpc/configs/ppc64_defconfig               |   19 +-
 arch/powerpc/configs/pseries_defconfig             |   19 +-
 arch/powerpc/include/asm/asm-prototypes.h          |   43 +-
 arch/powerpc/include/asm/atomic.h                  |    4 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |    3 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |    7 +-
 arch/powerpc/include/asm/book3s/64/radix.h         |   88 +-
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |    1 +
 arch/powerpc/include/asm/cputable.h                |    4 +-
 arch/powerpc/include/asm/exception-64s.h           |  148 +-
 arch/powerpc/include/asm/fadump.h                  |    4 -
 arch/powerpc/include/asm/head-64.h                 |  393 ++++
 arch/powerpc/include/asm/machdep.h                 |    2 +-
 arch/powerpc/include/asm/mmu-book3e.h              |    3 +
 arch/powerpc/include/asm/mmu.h                     |    4 +
 arch/powerpc/include/asm/mmu_context.h             |    4 +-
 arch/powerpc/include/asm/mpic_msgr.h               |    6 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |    3 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h       |    3 +-
 arch/powerpc/include/asm/parport.h                 |    2 +-
 arch/powerpc/include/asm/pnv-pci.h                 |    4 +-
 arch/powerpc/include/asm/ppc-opcode.h              |    2 +
 arch/powerpc/include/asm/ppc_asm.h                 |   49 +-
 arch/powerpc/include/asm/processor.h               |   16 +-
 arch/powerpc/include/asm/reg.h                     |    5 +-
 arch/powerpc/include/asm/signal.h                  |    2 -
 arch/powerpc/include/asm/tm.h                      |    5 -
 arch/powerpc/kernel/Makefile                       |   15 +-
 arch/powerpc/kernel/asm-offsets.c                  |   12 +-
 arch/powerpc/kernel/cputable.c                     |   19 +
 arch/powerpc/kernel/eeh.c                          |    4 +-
 arch/powerpc/kernel/eeh_driver.c                   |   10 +-
 arch/powerpc/kernel/eeh_pe.c                       |    1 +
 arch/powerpc/kernel/entry_32.S                     |    1 -
 arch/powerpc/kernel/entry_64.S                     |   21 +-
 arch/powerpc/kernel/exceptions-64s.S               | 2068 ++++++++++----------
 arch/powerpc/kernel/fadump.c                       |    8 +-
 arch/powerpc/kernel/fpu.S                          |   26 -
 arch/powerpc/kernel/head_32.S                      |    3 -
 arch/powerpc/kernel/head_64.S                      |   53 +-
 arch/powerpc/kernel/head_8xx.S                     |    1 -
 arch/powerpc/kernel/hw_breakpoint.c                |    9 +-
 arch/powerpc/kernel/ibmebus.c                      |    2 +-
 arch/powerpc/kernel/irq.c                          |   17 +-
 arch/powerpc/kernel/legacy_serial.c                |   14 +-
 arch/powerpc/kernel/machine_kexec_64.c             |   75 +-
 arch/powerpc/kernel/misc_32.S                      |    4 +-
 arch/powerpc/kernel/misc_64.S                      |   30 +-
 arch/powerpc/kernel/module.c                       |    2 +-
 arch/powerpc/kernel/nvram_64.c                     |   10 +-
 arch/powerpc/kernel/pci-common.c                   |    5 +-
 arch/powerpc/kernel/pci_of_scan.c                  |    2 +-
 arch/powerpc/kernel/process.c                      |  181 +-
 arch/powerpc/kernel/prom_init.c                    |   82 +
 arch/powerpc/kernel/ptrace.c                       |  353 +---
 arch/powerpc/kernel/signal.c                       |   41 +-
 arch/powerpc/kernel/signal.h                       |   18 +-
 arch/powerpc/kernel/signal_32.c                    |  122 +-
 arch/powerpc/kernel/signal_64.c                    |  207 +-
 arch/powerpc/kernel/syscalls.c                     |    1 +
 arch/powerpc/kernel/time.c                         |    1 +
 arch/powerpc/kernel/tm.S                           |   94 +-
 arch/powerpc/kernel/traps.c                        |   83 +-
 arch/powerpc/kernel/vdso64/Makefile                |    6 -
 arch/powerpc/kernel/vdso64/datapage.S              |    2 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S          |    2 +-
 arch/powerpc/kernel/vector.S                       |   25 -
 arch/powerpc/kernel/vmlinux.lds.S                  |   55 +-
 arch/powerpc/lib/Makefile                          |    2 +-
 arch/powerpc/lib/mem_64.S                          |    2 +
 arch/powerpc/mm/Makefile                           |    7 +-
 arch/powerpc/mm/fault.c                            |    4 +-
 arch/powerpc/mm/hash_utils_64.c                    |   81 +-
 arch/powerpc/mm/hugetlbpage.c                      |    7 +
 arch/powerpc/mm/init_32.c                          |    2 +-
 arch/powerpc/mm/mmu_context_iommu.c                |   81 +-
 arch/powerpc/mm/pgtable-book3s64.c                 |   11 +-
 arch/powerpc/mm/pgtable-radix.c                    |   40 +
 arch/powerpc/mm/pgtable.c                          |    2 +-
 arch/powerpc/mm/slb_low.S                          |    8 +-
 arch/powerpc/mm/tlb-radix.c                        |   24 +
 arch/powerpc/net/bpf_jit.h                         |    2 +
 arch/powerpc/net/bpf_jit64.h                       |   26 +-
 arch/powerpc/net/bpf_jit_comp64.c                  |  264 ++-
 arch/powerpc/oprofile/cell/spu_profiler.c          |    2 +-
 arch/powerpc/oprofile/cell/spu_task_sync.c         |    4 +-
 arch/powerpc/perf/core-book3s.c                    |    2 +-
 arch/powerpc/perf/hv-gpci.c                        |    2 +-
 arch/powerpc/perf/power7-pmu.c                     |    2 +-
 arch/powerpc/perf/power8-pmu.c                     |    2 +-
 arch/powerpc/perf/power9-pmu.c                     |    2 +-
 arch/powerpc/platforms/44x/warp.c                  |    2 +-
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c     |    8 +-
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c      |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c          |    2 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c       |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |    2 +-
 arch/powerpc/platforms/83xx/suspend.c              |    4 +-
 arch/powerpc/platforms/85xx/common.c               |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |    4 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c           |    4 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c    |    6 +-
 arch/powerpc/platforms/86xx/pic.c                  |    4 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c            |    2 +-
 arch/powerpc/platforms/Kconfig.cputype             |    2 +
 arch/powerpc/platforms/cell/axon_msi.c             |    6 +-
 arch/powerpc/platforms/cell/cbe_regs.c             |    2 +-
 arch/powerpc/platforms/cell/interrupt.c            |   18 +-
 arch/powerpc/platforms/cell/iommu.c                |    4 +-
 arch/powerpc/platforms/cell/pmu.c                  |    4 +-
 arch/powerpc/platforms/cell/ras.c                  |    2 +-
 arch/powerpc/platforms/cell/spider-pic.c           |   18 +-
 arch/powerpc/platforms/cell/spu_base.c             |   16 +-
 arch/powerpc/platforms/cell/spu_manage.c           |    9 +-
 arch/powerpc/platforms/chrp/setup.c                |    4 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |    2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |    4 +-
 arch/powerpc/platforms/embedded6xx/mvme5100.c      |    4 +-
 arch/powerpc/platforms/maple/pci.c                 |    6 +-
 arch/powerpc/platforms/maple/setup.c               |    4 +-
 arch/powerpc/platforms/pasemi/Kconfig              |   10 +
 arch/powerpc/platforms/pasemi/gpio_mdio.c          |    4 +-
 arch/powerpc/platforms/pasemi/iommu.c              |    2 +-
 arch/powerpc/platforms/pasemi/misc.c               |    2 +-
 arch/powerpc/platforms/pasemi/msi.c                |    4 +-
 arch/powerpc/platforms/pasemi/setup.c              |    8 +-
 arch/powerpc/platforms/powermac/low_i2c.c          |    6 +-
 arch/powerpc/platforms/powermac/pfunc_base.c       |    4 +-
 arch/powerpc/platforms/powermac/pfunc_core.c       |    2 +-
 arch/powerpc/platforms/powermac/pic.c              |    6 +-
 arch/powerpc/platforms/powermac/smp.c              |    2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |   18 +-
 arch/powerpc/platforms/powernv/npu-dma.c           |    2 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c      |    4 +-
 arch/powerpc/platforms/powernv/pci-cxl.c           |    4 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |   59 +-
 arch/powerpc/platforms/powernv/pci.c               |    8 +-
 arch/powerpc/platforms/ps3/device-init.c           |    2 +-
 arch/powerpc/platforms/ps3/interrupt.c             |   10 +-
 arch/powerpc/platforms/ps3/smp.c                   |    4 +-
 arch/powerpc/platforms/ps3/spu.c                   |    4 +-
 arch/powerpc/platforms/pseries/dlpar.c             |    5 +-
 arch/powerpc/platforms/pseries/event_sources.c     |    2 +-
 arch/powerpc/platforms/pseries/msi.c               |    6 +-
 arch/powerpc/platforms/pseries/scanlog.c           |    2 +-
 arch/powerpc/platforms/pseries/setup.c             |    4 +-
 arch/powerpc/sysdev/axonram.c                      |    6 +-
 arch/powerpc/sysdev/cpm1.c                         |    8 +-
 arch/powerpc/sysdev/ehv_pic.c                      |    4 +-
 arch/powerpc/sysdev/fsl_gtm.c                      |    2 +-
 arch/powerpc/sysdev/fsl_mpic_err.c                 |    6 +-
 arch/powerpc/sysdev/fsl_msi.c                      |   12 +-
 arch/powerpc/sysdev/ge/ge_pic.c                    |    8 +-
 arch/powerpc/sysdev/i8259.c                        |    4 +-
 arch/powerpc/sysdev/ipic.c                         |    4 +-
 arch/powerpc/sysdev/mmio_nvram.c                   |    2 +-
 arch/powerpc/sysdev/mpc8xx_pic.c                   |    2 +-
 arch/powerpc/sysdev/mpic.c                         |   14 +-
 arch/powerpc/sysdev/mpic_msgr.c                    |    4 +-
 arch/powerpc/sysdev/mpic_u3msi.c                   |    4 +-
 arch/powerpc/sysdev/mv64x60_pic.c                  |    2 +-
 arch/powerpc/sysdev/pmi.c                          |    2 +-
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c              |    6 +-
 arch/powerpc/sysdev/ppc4xx_msi.c                   |    6 +-
 arch/powerpc/sysdev/ppc4xx_soc.c                   |    2 +-
 arch/powerpc/sysdev/tsi108_pci.c                   |    2 +-
 arch/powerpc/sysdev/uic.c                          |    2 +-
 arch/powerpc/sysdev/xics/icp-hv.c                  |    6 +-
 arch/powerpc/sysdev/xics/icp-native.c              |    6 +-
 arch/powerpc/sysdev/xics/icp-opal.c                |    8 +-
 arch/powerpc/sysdev/xics/xics-common.c             |    2 +-
 arch/powerpc/xmon/spr_access.S                     |    4 +-
 drivers/char/hw_random/pasemi-rng.c                |    2 +-
 drivers/macintosh/macio_asic.c                     |    4 +-
 drivers/macintosh/rack-meter.c                     |    2 +-
 drivers/macintosh/smu.c                            |   18 +-
 drivers/macintosh/via-cuda.c                       |    2 +-
 drivers/macintosh/via-pmu.c                        |    6 +-
 drivers/misc/cxl/cxl.h                             |    6 +-
 drivers/misc/cxl/native.c                          |   31 +
 drivers/misc/cxl/of.c                              |    8 +-
 drivers/misc/cxl/pci.c                             |    7 +-
 drivers/pci/hotplug/pnv_php.c                      |  283 ++-
 drivers/ps3/ps3-vuart.c                            |    4 +-
 sound/aoa/core/gpio-feature.c                      |    4 +-
 sound/ppc/tumbler.c                                |    8 +-
 tools/testing/selftests/powerpc/Makefile           |    1 +
 tools/testing/selftests/powerpc/fpu_asm.h          |   80 +
 tools/testing/selftests/powerpc/gpr_asm.h          |   96 +
 tools/testing/selftests/powerpc/harness.c          |    9 +-
 tools/testing/selftests/powerpc/math/Makefile      |    5 +-
 tools/testing/selftests/powerpc/math/fpu_asm.S     |   73 +-
 tools/testing/selftests/powerpc/math/vmx_asm.S     |   85 +-
 tools/testing/selftests/powerpc/math/vsx_asm.S     |   61 +
 tools/testing/selftests/powerpc/math/vsx_preempt.c |  147 ++
 tools/testing/selftests/powerpc/signal/Makefile    |   13 +
 tools/testing/selftests/powerpc/signal/signal.S    |   50 +
 tools/testing/selftests/powerpc/signal/signal.c    |  111 ++
 tools/testing/selftests/powerpc/signal/signal_tm.c |  110 ++
 tools/testing/selftests/powerpc/tm/Makefile        |    8 +-
 .../powerpc/tm/tm-signal-context-chk-fpu.c         |   92 +
 .../powerpc/tm/tm-signal-context-chk-gpr.c         |   90 +
 .../powerpc/tm/tm-signal-context-chk-vmx.c         |  110 ++
 .../powerpc/tm/tm-signal-context-chk-vsx.c         |  125 ++
 tools/testing/selftests/powerpc/tm/tm-signal.S     |  114 ++
 tools/testing/selftests/powerpc/tm/tm.h            |   27 +
 tools/testing/selftests/powerpc/utils.h            |    9 +-
 tools/testing/selftests/powerpc/vmx_asm.h          |   96 +
 tools/testing/selftests/powerpc/vsx_asm.h          |   71 +
 227 files changed, 5466 insertions(+), 2926 deletions(-)
 create mode 100644 Documentation/powerpc/syscall64-abi.txt
 create mode 100644 arch/powerpc/boot/decompress.c
 create mode 100644 arch/powerpc/boot/fixup-headers.sed
 delete mode 100644 arch/powerpc/boot/gunzip_util.c
 delete mode 100644 arch/powerpc/boot/gunzip_util.h
 create mode 100644 arch/powerpc/boot/stdbool.h
 create mode 100644 arch/powerpc/boot/stdint.h
 create mode 100644 arch/powerpc/boot/xz_config.h
 create mode 100644 arch/powerpc/include/asm/head-64.h
 create mode 100644 tools/testing/selftests/powerpc/fpu_asm.h
 create mode 100644 tools/testing/selftests/powerpc/gpr_asm.h
 create mode 100644 tools/testing/selftests/powerpc/math/vsx_asm.S
 create mode 100644 tools/testing/selftests/powerpc/math/vsx_preempt.c
 create mode 100644 tools/testing/selftests/powerpc/signal/Makefile
 create mode 100644 tools/testing/selftests/powerpc/signal/signal.S
 create mode 100644 tools/testing/selftests/powerpc/signal/signal.c
 create mode 100644 tools/testing/selftests/powerpc/signal/signal_tm.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vmx.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal.S
 create mode 100644 tools/testing/selftests/powerpc/vmx_asm.h
 create mode 100644 tools/testing/selftests/powerpc/vsx_asm.h

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX9x/+AAoJEFHr6jzI4aWATX0P/RZ9cHJm5ssLEOhMOCtt1jEs
Q8366kcEB18Pk8hiBZPMa7fGqWnRe4wwY4pEUnPEukPezQl7Qxf/2wlJOJItz9Sz
TjXWXovv2IsCgUAlSJ+dKOqxHqxOadzoqDyWRXp9MGS3lYZBdlWonhIIvUPcMqPP
R1XBFcuX6GBAMpfGMAiMSD1fZZfhXBpOYLX/cgQ9UK5u66QcTA/rGXxymhDIo6//
k2KOtHPdeoKiwoNU6vdT1tddyHGQWMeKssDA2GOGIjTGa9TGYx60DF6WDg1fDDJa
wGfkprG65ZtC2l+wBIh77anXzEwCpaLK9v64hbfOjgm/ovbGWRy5cPXw+viXSxjA
9qRfKG0sL+li4EDF5LPB8+mfK3xAdDg5LEYnhx38DnQ6KsYI77mUM1piZJgJRgDG
0gsRNmUPiuC2oxq61bzN0ukMuIqsU73EA3SxZ5QThU/h5g4f/CqcxlG85ztS4Z7e
34W/5XsPaaGxtE5nMKlBPk58rU5CDRd97nmVbvQRvj3WRcAPl4QKlzW6gBUIdYYg
UgC6DmGWoMDHp6kH+7lHhGx6iodJeUxJikxMgzsyuofXGVIpfqLEMSy8uVJpIIQS
Qme6ItZQb8y3+EJgXc1gJKuJmGCxjKCnEB0ZK1VXXkFsRizOSWsXtAQqinP0mhKs
HHoJ8qFWu1kz4kZMobMi
=eiy1
-----END PGP SIGNATURE-----
--=-=-=--
