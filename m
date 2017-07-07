Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3vv86NswzDr5V
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 23:04:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akshay.adiga@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
 andrew@aj.id.au, anton@samba.org, arnd@arndb.de, bauerman@linux.vnet.ibm.com,
 benh@kernel.crashing.org, bsingharora@gmail.com, christophe.leroy@c-s.fr,
 clombard@linux.vnet.ibm.com, colin.king@canonical.com,
 dan.carpenter@oracle.com, ego@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 hbathini@linux.vnet.ibm.com, imunsie@au1.ibm.com, ivan@de.ibm.com,
 javier@dowhile0.org, john.stultz@linaro.org, keescook@chromium.org,
 khandual@linux.vnet.ibm.com, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 matthew.brown.dev@gmail.com, mikey@neuling.org, mingo@kernel.org,
 mopsfelder@gmail.com, msuchanek@suse.de, naveen.n.rao@linux.vnet.ibm.com,
 npiggin@gmail.com, oohall@gmail.com, oss@buserror.net, paulus@ozlabs.org,
 pavel@denx.de, peterz@infradead.org, ruscur@russell.cc, santosh@fossix.org,
 sfr@canb.auug.org.au, svaidy@linux.vnet.ibm.com, yamada.masahiro@socionext.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.13-1 tag
Date: Fri, 07 Jul 2017 23:03:53 +1000
Message-ID: <878tk0v1om.fsf@concordia.ellerman.id.au>
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

Please pull powerpc updates for 4.13.

No conflicts or anything I'm aware of. I did merge my own fixes branch
into my next, so I had to generate the diffstat below by hand, but I'm
pretty sure it's correct.

The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.13-1

for you to fetch changes up to 1e0fc9d1eb2b0241a03e0a02bcdb9b5b641b9d35:

  powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some configs (2017-07-04 11:37:44 +1000)

----------------------------------------------------------------
powerpc updates for 4.13

Highlights include:

 - Support for STRICT_KERNEL_RWX on 64-bit server CPUs.

 - Platform support for FSP2 (476fpe) board

 - Enable ZONE_DEVICE on 64-bit server CPUs.

 - Generic & powerpc spin loop primitives to optimise busy waiting

 - Convert VDSO update function to use new update_vsyscall() interface

 - Optimisations to hypercall/syscall/context-switch paths

 - Improvements to the CPU idle code on Power8 and Power9.

As well as many other fixes and improvements.

Thanks to:
  Akshay Adiga, Andrew Donnellan, Andrew Jeffery, Anshuman Khandual, Anton
  Blanchard, Balbir Singh, Benjamin Herrenschmidt, Christophe Leroy, Christophe
  Lombard, Colin Ian King, Dan Carpenter, Gautham R. Shenoy, Hari Bathini, Ian
  Munsie, Ivan Mikhaylov, Javier Martinez Canillas, Madhavan Srinivasan,
  Masahiro Yamada, Matt Brown, Michael Neuling, Michal Suchanek, Murilo
  Opsfelder Araujo, Naveen N. Rao, Nicholas Piggin, Oliver O'Halloran, Paul
  Mackerras, Pavel Machek, Russell Currey, Santosh Sivaraj, Stephen Rothwell,
  Thiago Jung Bauermann, Yang Li.

----------------------------------------------------------------
Akshay Adiga (2):
      powerpc/powernv/idle: Restore SPRs for deep idle states via stop API.
      powerpc/powernv/idle: Clear r12 on wakeup from stop lite

Andrew Donnellan (1):
      MAINTAINERS: cxl: update maintainership

Andrew Jeffery (1):
      powerpc: Tweak copy selection parameter in __copy_tofrom_user_power7()

Anshuman Khandual (2):
      powerpc/mm: Add comments to the vmemmap layout
      powerpc/mm: Add comments on vmemmap physical mapping

Anton Blanchard (2):
      powerpc: Add HAVE_IRQ_TIME_ACCOUNTING
      powerpc/mm: Wire up hpte_removebolted for powernv

Balbir Singh (16):
      powerpc/mm/ptdump: Dump the first entry of the linear mapping as well
      powerpc/mm/hash: Do a local flush if possible when no batch is active
      powerpc/mm/book(e)(3s)/64: Add page table accounting
      powerpc/mm/book(e)(3s)/32: Add page table accounting
      powerpc/mm/hugetlb: Add support for page accounting
      powerpc/mm: Trace tlbie(l) instructions
      powerpc/pseries: Fix passing of pp0 in updatepp() and updateboltedpp()
      powerpc/mm/radix: Fix execute permissions for interrupt_vectors
      powerpc/kprobes: Move kprobes over to patch_instruction()
      powerpc/kprobes/optprobes: Use patch_instruction()
      powerpc/xmon: Add patch_instruction() support for xmon
      powerpc/lib/code-patching: Use alternate map for patch_instruction()
      powerpc/vmlinux.lds: Align __init_begin to 16M
      powerpc/mm/hash: Implement mark_rodata_ro() for hash
      powerpc/mm/radix: Implement STRICT_RWX/mark_rodata_ro() for Radix
      powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some configs

Benjamin Herrenschmidt (3):
      powerpc: Only do ERAT invalidate on radix context switch on P9 DD1
      powerpc/64s: Invalidate ERAT on powersave wakeup for POWER9
      powerpc/xive: Silence message about VP block allocation

Christophe Leroy (13):
      powerpc/mm: Remove __this_fixmap_does_not_exist()
      powerpc/mm: Only call store_updates_sp() on stores in do_page_fault()
      powerpc/mm: Remove a redundant test in do_page_fault()
      powerpc/mm: Evaluate user_mode(regs) only once in do_page_fault()
      powerpc/mm: The 8xx doesn't call do_page_fault() for breakpoints
      powerpc/40x: Clear MSR_DR in one insn instead of two
      powerpc/8xx: fix mpc8xx_get_irq() return on no irq
      powerpc: Handle simultaneous interrupts at once
      powerpc: Discard ffs()/__ffs() function and use builtin functions instead
      powerpc: Use builtin functions for fls()/__fls()/fls64()
      powerpc: Replace ffz() by equivalent generic function
      powerpc: Remove __ilog2()s and use generic ones
      powerpc/mm: Rename map_page() to map_kernel_page() on 32-bit

Christophe Lombard (1):
      cxl: Export library to support IBM XSL

Colin Ian King (1):
      powerpc: Fix some spelling mistakes

Dan Carpenter (1):
      cxl: Unlock on error in probe

Gautham R. Shenoy (5):
      powerpc/powernv/idle: Correctly initialize core_idle_state_ptr
      powerpc/powernv/idle: Decouple Timebase restore & Per-core SPRs restore
      powerpc/powernv/idle: Restore LPCR on wakeup from deep-stop
      powerpc/powernv/idle: Use Requested Level for restoring state on P9 DD1
      cpuidle-powernv: Allow Deep stop states that don't stop time

Hari Bathini (7):
      powerpc/fadump: Add a warning when 'fadump_reserve_mem=' is used
      powerpc/fadump: Update comment about offset where fadump is reserved
      powerpc/fadump: Set an upper limit for boot memory size
      powerpc/fadump: avoid duplicates in crash memory ranges
      powerpc/fadump: avoid holes in boot memory area when fadump is registered
      powerpc/fadump: provide a helpful error message
      powerpc/fadump: add reschedule point while releasing memory

Ian Munsie (1):
      MAINTAINERS: Remove myself as cxl maintainer

Ivan Mikhaylov (4):
      powerpc/44x/fsp2: Platform support for FSP2 (476fpe) board
      powerpc/44x/fsp2: Add device tree for FSP2 board
      powerpc/44x/fsp2: Add defconfig for FSP2 board
      powerpc/[booke|4xx]: Don't clobber TCR[WP] when setting TCR[DIE]

Javier Martinez Canillas (5):
      powerpc/5200: Add generic compatible string for I2C EEPROM
      powerpc/fsl: Add generic compatible string for I2C EEPROM
      powerpc/512x: Add generic compatible string for I2C EEPROM
      powerpc/83xx: Add generic compatible string for I2C EEPROM
      powerpc/44x: Add generic compatible string for I2C EEPROM

Madhavan Srinivasan (1):
      powerpc/perf: Fix branch event code for power9

Masahiro Yamada (1):
      powerpc/dts: Use #include "..." to include local DT

Matt Brown (1):
      powerpc/lib/xor_vmx: Ensure no altivec code executes before enable_kernel_altivec()

Michael Ellerman (6):
      Revert "powerpc: Handle simultaneous interrupts at once"
      powerpc/mm/radix: Only add X for pages overlapping kernel text
      powerpc/64s: Use BRANCH_TO_COMMON() for slb_miss_realmode
      powerpc/64s: Rename slb_miss_realmode() to slb_miss_common()
      powerpc/64s: Rename slb_allocate_realmode() to slb_allocate()
      Merge branch 'fixes' into next

Michael Neuling (3):
      powerpc: Fix /proc/cpuinfo revision for POWER9 DD2
      powerpc: Fix asm offsets to point to actual FP and VMX regs
      powerpc/tm: Fix comment

Michal Suchanek (1):
      powerpc/fadump: Return error when fadump registration fails

Murilo Opsfelder Araujo (1):
      drivers/watchdog/Kconfig: Update CONFIG_WATCHDOG_RTAS dependencies

Naveen N. Rao (7):
      powerpc64/elfv1: Only dereference function descriptor for non-text symbols
      powerpc/64s: Convert .L__replay_interrupt_return to a local label
      powerpc/64s: Blacklist system_call() and system_call_common() from kprobes
      powerpc/64s: Move system_call() symbol to just after setting MSR_EE
      powerpc/64s: Un-blacklist system_call() from kprobes
      powerpc/64s: Blacklist functions invoked on a trap
      powerpc/64s: Blacklist rtas entry/exit from kprobes

Nicholas Piggin (45):
      powerpc/64s: Fix FIXUP_ENDIAN non-maskable interrupt reentrancy
      powerpc/64s: Fix OPAL_CALL non-maskable interrupt reentrancy
      powerpc/powernv: Fix CPU_HOTPLUG=n idle.c compile error
      powerpc/xmon: Fix compile error with PPC_8xx=y
      powerpc/64: Place sfpr section explicitly with the linker script
      powerpc/64: Do not link crtsavres.o in vmlinux
      powerpc/64: Do not link crtsaveres.o in boot
      powerpc/64: Do not create new section for save/restore functions
      powerpc/64: Linker on-demand sfpr functions for modules
      powerpc/64s: Tool to flag direct branches from unrelocated interrupt vectors
      powerpc/64: Handle linker stubs in low .text code
      powerpc/64: Tool to check head sections location sanity
      powerpc: Link warning for orphan sections
      selftests/powerpc: context_switch use private futexes with threads
      powerpc/64s: Machine check handle ifetch from foreign real address for POWER9
      powerpc/64s: Optimize hypercall/syscall entry
      powerpc/64: Avoid restore_math call if possible in syscall exit
      powerpc/64s: Leave interrupts hard enabled in context switch for radix
      powerpc/64: Drop reservation-clearing ldarx in context switch
      powerpc/64: Drop explicit hwsync in context switch
      powerpc/64s: Avoid cpabort in context switch when possible
      powerpc/64s/idle: Move soft interrupt mask logic into C code
      powerpc/powernv: Simplify lazy IRQ handling in CPU offline
      powerpc/64s/idle: Process interrupts from system reset wakeup
      powerpc/64s: msgclr when handling doorbell exceptions from system reset
      powerpc/64s: Don't unbalance the return branch predictor in __replay_interrupt()
      powerpc/64s/idle: Branch to handler with virtual mode offset
      powerpc/64s/idle: Avoid SRR usage in idle sleep/wake paths
      powerpc/64s/idle: Predict HMI wakeup as unlikely
      powerpc/64s/idle: Run latch switch is done with MSR[EE]=0
      powerpc/64s: Preserve r3 in slb_allocate_realmode()
      powerpc/64s: Avoid saving faulting address into EX_DAR in SLB miss
      powerpc/64s: SLB miss already has CTR saved for relocatable kernel
      powerpc/64s: Avoid r3 save/restore in SLB miss handler
      powerpc/64s: Add EX_SIZE definition for paca exception save areas
      powerpc/64s/paca: EX_SRR0 is unused, remove it
      powerpc/64s/paca: EX_LR can be merged with EX_DAR
      powerpc/64s/paca: EX_R3 can be merged with EX_DAR
      powerpc/64s/paca: EX_CTR is not used with RELOCATABLE=n, remove it
      cpuidle: powerpc: cpuidle set polling before enabling irqs
      cpuidle: powerpc: read mostly for common globals
      cpuidle: powerpc: no memory barrier after break from idle
      spin loop primitives for busy waiting
      powerpc/64: implement spin loop primitives
      powerpc: use spin loop primitives in some functions

Oliver O'Halloran (6):
      powerpc/hugetlbfs: Export HPAGE_SHIFT
      mm, x86: Add ARCH_HAS_ZONE_DEVICE to Kconfig
      powerpc/vmemmap: Reshuffle vmemmap_free()
      powerpc/vmemmap: Add altmap support
      powerpc/mm: Add devmap support for ppc64
      powerpc/mm: Enable ZONE_DEVICE on powerpc

Paul Mackerras (1):
      powerpc: Convert VDSO update function to use new update_vsyscall interface

Pavel Machek (1):
      powerpc/sequoia: Fix NAND partitions not to overlap

Russell Currey (5):
      powerpc/powernv/pci: Reduce spam when dumping PEST
      powerpc/powernv/pci: Dynamically allocate PHB diag data
      powerpc/powernv/pci: Add support for PHB4 diagnostics
      powerpc/powernv/pci: Add helper to check if a PE has a single vendor
      powerpc/powernv/pci: Enable 64-bit devices to access >4GB DMA space

Santosh Sivaraj (3):
      powerpc/time: Fix tracing in time.c
      powerpc/smp: Do not BUG_ON if invalid CPU during kick
      powerpc/smp: Convert NR_CPUS to nr_cpu_ids

Stephen Rothwell (2):
      powerpc: Use the asm-generic versions of some uapi includes
      powerpc: Use uapi/asm-generic/sockios.h

Thiago Jung Bauermann (8):
      powerpc/perf/hv-24x7: Fix passing of catalog version number
      powerpc/perf/hv-24x7: Fix off-by-one error in request_buffer check
      powerpc/perf/hv-24x7: Properly iterate through results
      powerpc-perf/hx-24x7: Don't log failed hcall twice
      powerpc/perf/hv-24x7: Fix return value of hcalls
      powerpc/perf/hv-24x7: Minor improvements
      powerpc/perf/hv-24x7: Support v2 of the hypervisor API
      powerpc/perf/hv-24x7: Aggregate result elements on POWER9 SMT8

Yang Li (2):
      MAINTAINERS: Update entry for Freescale SoC drivers
      MAINTAINERS: Update my email address from freescale to nxp

 Documentation/powerpc/firmware-assisted-dump.txt   |   4 +-
 MAINTAINERS                                        |  13 +-
 arch/powerpc/Kconfig                               |  25 +-
 arch/powerpc/Makefile                              |  11 +
 arch/powerpc/Makefile.postlink                     |  17 +-
 arch/powerpc/boot/Makefile                         |   5 +-
 arch/powerpc/boot/crtsavres.S                      |   8 +-
 arch/powerpc/boot/dts/ac14xx.dts                   |   2 +-
 arch/powerpc/boot/dts/digsy_mtc.dts                |   2 +-
 arch/powerpc/boot/dts/fsl/b4qds.dtsi               |   8 +-
 arch/powerpc/boot/dts/fsl/c293pcie.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/p1010rdb.dtsi            |   2 +-
 arch/powerpc/boot/dts/fsl/p1023rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/p2041rdb.dts             |   4 +-
 arch/powerpc/boot/dts/fsl/p3041ds.dts              |   4 +-
 arch/powerpc/boot/dts/fsl/p4080ds.dts              |   4 +-
 arch/powerpc/boot/dts/fsl/p5020ds.dts              |   4 +-
 arch/powerpc/boot/dts/fsl/p5040ds.dts              |   4 +-
 arch/powerpc/boot/dts/fsl/t208xqds.dtsi            |   8 +-
 arch/powerpc/boot/dts/fsl/t4240qds.dts             |  12 +-
 arch/powerpc/boot/dts/fsl/t4240rdb.dts             |   6 +-
 arch/powerpc/boot/dts/fsp2.dts                     | 608 +++++++++++++++++++++
 arch/powerpc/boot/dts/mpc5121ads.dts               |   4 +-
 arch/powerpc/boot/dts/mpc8308_p1m.dts              |   2 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts             |   4 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts              |   2 +-
 arch/powerpc/boot/dts/mpc8377_wlan.dts             |   2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts              |   2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts              |   2 +-
 arch/powerpc/boot/dts/pcm030.dts                   |   2 +-
 arch/powerpc/boot/dts/pcm032.dts                   |   2 +-
 arch/powerpc/boot/dts/pdm360ng.dts                 |   2 +-
 arch/powerpc/boot/dts/sequoia.dts                  |   2 +-
 arch/powerpc/boot/dts/warp.dts                     |   2 +-
 arch/powerpc/boot/ppc_asm.h                        |  12 +-
 arch/powerpc/configs/44x/fsp2_defconfig            | 126 +++++
 arch/powerpc/include/asm/barrier.h                 |   5 +
 arch/powerpc/include/asm/bitops.h                  |  87 +--
 arch/powerpc/include/asm/book3s/32/pgalloc.h       |   3 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |   2 +
 arch/powerpc/include/asm/book3s/64/hash.h          |   3 +
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |  16 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  45 ++
 arch/powerpc/include/asm/book3s/64/radix.h         |   6 +-
 arch/powerpc/include/asm/code-patching.h           |  10 +-
 arch/powerpc/include/asm/dbell.h                   |  13 +
 arch/powerpc/include/asm/delay.h                   |  16 +-
 arch/powerpc/include/asm/exception-64s.h           |  49 +-
 arch/powerpc/include/asm/fadump.h                  |   4 +
 arch/powerpc/include/asm/head-64.h                 |  25 +-
 arch/powerpc/include/asm/hw_irq.h                  |   4 +
 arch/powerpc/include/asm/machdep.h                 |   1 +
 arch/powerpc/include/asm/mce.h                     |  15 +-
 arch/powerpc/include/asm/nohash/32/pgalloc.h       |   3 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |   2 +
 arch/powerpc/include/asm/nohash/64/pgalloc.h       |  11 +-
 arch/powerpc/include/asm/opal-api.h                |  76 ++-
 arch/powerpc/include/asm/paca.h                    |  14 +-
 arch/powerpc/include/asm/pgalloc.h                 |  14 +
 arch/powerpc/include/asm/ppc-opcode.h              |  11 +-
 arch/powerpc/include/asm/ppc_asm.h                 |  11 +-
 arch/powerpc/include/asm/processor.h               |  30 +-
 arch/powerpc/include/asm/trace.h                   |  33 ++
 arch/powerpc/include/uapi/asm/Kbuild               |   6 +
 arch/powerpc/include/uapi/asm/param.h              |   1 -
 arch/powerpc/include/uapi/asm/poll.h               |   1 -
 arch/powerpc/include/uapi/asm/resource.h           |   1 -
 arch/powerpc/include/uapi/asm/sockios.h            |  20 -
 arch/powerpc/include/uapi/asm/statfs.h             |   6 -
 arch/powerpc/kernel/Makefile                       |   2 -
 arch/powerpc/kernel/asm-offsets.c                  |  10 +-
 arch/powerpc/kernel/entry_64.S                     | 193 ++++---
 arch/powerpc/kernel/exceptions-64s.S               | 284 ++++++----
 arch/powerpc/kernel/fadump.c                       | 196 ++++++-
 arch/powerpc/kernel/idle_book3s.S                  | 188 +++----
 arch/powerpc/kernel/irq.c                          |  62 ++-
 arch/powerpc/kernel/kprobes.c                      |   8 +-
 arch/powerpc/kernel/mce.c                          |   1 +
 arch/powerpc/kernel/mce_power.c                    |   3 +
 arch/powerpc/kernel/misc_32.S                      |   6 +-
 arch/powerpc/kernel/optprobes.c                    |  53 +-
 arch/powerpc/kernel/process.c                      |  45 +-
 arch/powerpc/kernel/setup-common.c                 |   4 +
 arch/powerpc/kernel/smp.c                          |   7 +-
 arch/powerpc/kernel/time.c                         |  96 +++-
 arch/powerpc/kernel/tm.S                           |   4 +-
 arch/powerpc/kernel/traps.c                        |   3 +
 arch/powerpc/kernel/vmlinux.lds.S                  |  61 ++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |  11 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |  12 +-
 arch/powerpc/lib/Makefile                          |  15 +-
 arch/powerpc/lib/code-patching.c                   | 171 +++++-
 arch/powerpc/lib/copyuser_power7.S                 |   4 +-
 arch/powerpc/lib/crtsavres.S                       |   6 +-
 arch/powerpc/lib/xor_vmx.c                         |  53 +-
 arch/powerpc/lib/xor_vmx.h                         |  20 +
 arch/powerpc/lib/xor_vmx_glue.c                    |  62 +++
 arch/powerpc/mm/8xx_mmu.c                          |   2 +-
 arch/powerpc/mm/dma-noncoherent.c                  |   2 +-
 arch/powerpc/mm/dump_hashpagetable.c               |   2 +-
 arch/powerpc/mm/fault.c                            |  17 +-
 arch/powerpc/mm/hash_native_64.c                   |  41 +-
 arch/powerpc/mm/hash_utils_64.c                    |   2 +
 arch/powerpc/mm/hugetlbpage.c                      |   5 +-
 arch/powerpc/mm/init_64.c                          |  82 ++-
 arch/powerpc/mm/mem.c                              |  20 +-
 arch/powerpc/mm/mmu_context_book3s64.c             |  15 +-
 arch/powerpc/mm/mmu_decl.h                         |   1 -
 arch/powerpc/mm/pgtable-book3s64.c                 |   4 +-
 arch/powerpc/mm/pgtable-hash64.c                   | 115 +++-
 arch/powerpc/mm/pgtable-radix.c                    |  90 ++-
 arch/powerpc/mm/pgtable_32.c                       |  15 +-
 arch/powerpc/mm/pgtable_64.c                       |  45 +-
 arch/powerpc/mm/slb.c                              |  10 +-
 arch/powerpc/mm/slb_low.S                          |  30 +-
 arch/powerpc/mm/tlb-radix.c                        |   9 +
 arch/powerpc/mm/tlb_hash64.c                       |   6 +-
 arch/powerpc/perf/hv-24x7.c                        | 242 +++++---
 arch/powerpc/perf/hv-24x7.h                        |  69 ++-
 arch/powerpc/perf/power9-events-list.h             |   4 +-
 arch/powerpc/perf/power9-pmu.c                     |   8 +-
 arch/powerpc/platforms/44x/Kconfig                 |  12 +
 arch/powerpc/platforms/44x/Makefile                |   1 +
 arch/powerpc/platforms/44x/fsp2.c                  |  62 +++
 arch/powerpc/platforms/cell/smp.c                  |   3 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |  16 +-
 arch/powerpc/platforms/powernv/idle.c              | 198 +++++--
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   6 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          | 133 ++++-
 arch/powerpc/platforms/powernv/pci.c               | 160 +++++-
 arch/powerpc/platforms/powernv/pci.h               |  13 +-
 arch/powerpc/platforms/powernv/smp.c               |  34 +-
 arch/powerpc/platforms/powernv/subcore.c           |   3 +-
 arch/powerpc/platforms/pseries/Kconfig             |   2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   2 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c    |   7 +
 arch/powerpc/platforms/pseries/lpar.c              |  11 +-
 arch/powerpc/platforms/pseries/smp.c               |   3 +-
 arch/powerpc/sysdev/mpc8xx_pic.c                   |   2 +-
 arch/powerpc/sysdev/xive/common.c                  |   2 +-
 arch/powerpc/sysdev/xive/native.c                  |   4 +-
 arch/powerpc/tools/head_check.sh                   |  78 +++
 arch/powerpc/tools/unrel_branch_check.sh           |  57 ++
 arch/powerpc/xmon/xmon.c                           |  15 +-
 arch/x86/Kconfig                                   |   1 +
 drivers/cpuidle/cpuidle-powernv.c                  |  53 +-
 drivers/cpuidle/cpuidle-pseries.c                  |  22 +-
 drivers/misc/cxl/Kconfig                           |   5 +
 drivers/misc/cxl/Makefile                          |   2 +-
 drivers/misc/cxl/cxl.h                             |   6 +
 drivers/misc/cxl/cxllib.c                          | 246 +++++++++
 drivers/misc/cxl/fault.c                           |  29 +-
 drivers/misc/cxl/flash.c                           |   8 +-
 drivers/misc/cxl/native.c                          |  16 +-
 drivers/misc/cxl/pci.c                             |  41 +-
 drivers/watchdog/Kconfig                           |   2 +-
 include/asm-generic/vmlinux.lds.h                  |  12 +
 include/linux/processor.h                          |  70 +++
 include/misc/cxllib.h                              | 133 +++++
 mm/Kconfig                                         |   6 +-
 .../selftests/powerpc/benchmarks/context_switch.c  |  53 +-
 161 files changed, 4328 insertions(+), 1082 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsp2.dts
 create mode 100644 arch/powerpc/configs/44x/fsp2_defconfig
 delete mode 100644 arch/powerpc/include/uapi/asm/param.h
 delete mode 100644 arch/powerpc/include/uapi/asm/poll.h
 delete mode 100644 arch/powerpc/include/uapi/asm/resource.h
 delete mode 100644 arch/powerpc/include/uapi/asm/sockios.h
 delete mode 100644 arch/powerpc/include/uapi/asm/statfs.h
 create mode 100644 arch/powerpc/lib/xor_vmx.h
 create mode 100644 arch/powerpc/lib/xor_vmx_glue.c
 create mode 100644 arch/powerpc/platforms/44x/fsp2.c
 create mode 100644 arch/powerpc/tools/head_check.sh
 create mode 100755 arch/powerpc/tools/unrel_branch_check.sh
 create mode 100644 drivers/misc/cxl/cxllib.c
 create mode 100644 include/linux/processor.h
 create mode 100644 include/misc/cxllib.h

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZX4a6AAoJEFHr6jzI4aWAk5UP/15b26/CzHfa+AmFQqjk+8KJ
j0a74bwBwWpEpuKWn+E6D8m286a0kHXADfoEVvOzVqEu8+VdD2bvjBu1WzLDJrki
n8CacuHOrJqNmv7NKp/cdJc23QP3ohkU7PUxB1THisXQvHeXqjgcKklmP/Tai3sO
/IiMrWRJEvhxWqG7ksTjvi2XaGWT8vekGjq6+evYZvKt5GAt424sWgjKGm/fqxgV
FHXYbLhJ3DEVhLvy3ask4IKjoHJFiPcFbi1ZsNEYMKqXUi0/R9+2lmjuT49iJ846
4AVS9PgAnjKlz8/POA02diOpAdAdC8T/jM/QedDIbgPrQONQ+qUTsU1YMpjP6eKm
O4G058gCyX8vpX8yf8wYSyjHeJijvqpFlNiqWGjfV0g3IZiQ5M4ZLgKU40fFOdXf
dV2LvMrwq46AD1Cdh8lFOjnLA4zBs0GVcVw0QWwKCtoRzY2QDYqGuwE1fp4uxZsD
VnkTrL2uRmdNa7d0XD/TeLgPS60NpN807gpOU2p5BQSvibwApfwiTlr+i7yGf4G8
jZzHvwZpqrBHVyG7aI5PDcQetY0KaO2Yw7U3xkOjpajRZ2Li1Dn72rb1dItggJip
aT0OrwOn2nGwS6hm+RKj9HU0ZOB75LiCp7a4YvTdCV0ruEfPmwwwh0IBU4TgSu9e
7K4z+vA/vDKhApm1lhz1
=0zM9
-----END PGP SIGNATURE-----
--=-=-=--
