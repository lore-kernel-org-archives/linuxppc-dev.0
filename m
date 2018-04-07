Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40JHMB1NmHzF20J
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 23:23:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Larry.Finger@lwfinger.net, aaro.koskinen@iki.fi, agust@denx.de,
 aik@ozlabs.ru, alexandre.belloni@bootlin.com, alistair@popple.id.au,
 ananth@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
 aneesh.kumar@linux.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bauerman@linux.vnet.ibm.com, bsingharora@gmail.com,
 christophe.leroy@c-s.fr, clombard@linux.vnet.ibm.com,
 elfring@users.sourceforge.net, fbarrat@linux.vnet.ibm.com,
 felix@linux.vnet.ibm.com, fthain@telegraphics.com.au,
 gromero@linux.vnet.ibm.com, j.neuschaefer@gmx.net,
 khandual@linux.vnet.ibm.com, ldufour@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linuxram@us.ibm.com, logang@deltatee.com, maddy@linux.vnet.ibm.com,
 malat@debian.org, matt@ozlabs.org, matthew.brown.dev@gmail.com,
 mauricfo@linux.vnet.ibm.com, mgreer@animalcreek.com,
 mhairgrove@nvidia.com, mikey@neuling.org, naveen.n.rao@linux.vnet.ibm.com,
 npiggin@gmail.com, paulus@ozlabs.org, robh@kernel.org,
 sam.bobroff@au1.ibm.com, segher@kernel.crashing.org,
 sjitindarsingh@gmail.com, stewart@linux.ibm.com,
 sukadev@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 wei.guo.simon@gmail.com, weiyongjun1@huawei.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.17-1 tag
Date: Sat, 07 Apr 2018 23:23:20 +1000
Message-ID: <87woxjb16f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull powerpc updates for 4.17.

A bit late unfortunately, not due to anything terrible, but just a
trickle of small fixes through the week.

There's one minor merge conflict in the lib/raid6/test/Makefile, between
our changes and the removal of the tilegx implementation.

Other than that the only other out-of-area change is a minor change to
memblock.[ch], to export a function, which was OK'ed by Andrew.

cheers


The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-4.17-1

for you to fetch changes up to c1b25a17d24925b0961c319cfc3fd7e1dc778914:

  powerpc/64s/idle: Fix restore of AMOR on POWER9 after deep sleep (2018-04=
-05 16:48:52 +1000)

=2D ----------------------------------------------------------------
powerpc updates for 4.17

Notable changes:

 - Support for 4PB user address space on 64-bit, opt-in via mmap().

 - Removal of POWER4 support, which was accidentally broken in 2016 and no =
one
   noticed, and blocked use of some modern instructions.

 - Workarounds so that the hypervisor can enable Transactional Memory on Po=
wer9.

 - A series to disable the DAWR (Data Address Watchpoint Register) on Power=
9.

 - More information displayed in the meltdown/spectre_v1/v2 sysfs files.

 - A vpermxor (Power8 Altivec) implementation for the raid6 Q Syndrome.

 - A big series to make the allocation of our pacas (per cpu area), kernel =
page
   tables, and per-cpu stacks NUMA aware when using the Radix MMU on Power9.

And as usual many fixes, reworks and cleanups.

Thanks to:
  Aaro Koskinen, Alexandre Belloni, Alexey Kardashevskiy, Alistair Popple, =
Andy
  Shevchenko, Aneesh Kumar K.V, Anshuman Khandual, Balbir Singh, Benjamin
  Herrenschmidt, Christophe Leroy, Christophe Lombard, Cyril Bur, Daniel Ax=
tens,
  Dave Young, Finn Thain, Frederic Barrat, Gustavo Romero, Horia Geant=C4=
=83,
  Jonathan Neusch=C3=A4fer, Kees Cook, Larry Finger, Laurent Dufour, Lauren=
t Vivier,
  Logan Gunthorpe, Madhavan Srinivasan, Mark Greer, Mark Hairgrove, Markus
  Elfring, Mathieu Malaterre, Matt Brown, Matt Evans, Mauricio Faria de
  Oliveira, Michael Neuling, Naveen N. Rao, Nicholas Piggin, Paul Mackerras,
  Philippe Bergheaud, Ram Pai, Rob Herring, Sam Bobroff, Segher Boessenkool,
  Simon Guo, Simon Horman, Stewart Smith, Sukadev Bhattiprolu, Suraj Jitind=
ar
  Singh, Thiago Jung Bauermann, Vaibhav Jain, Vaidyanathan Srinivasan, Vasa=
nt
  Hegde, Wei Yongjun.

=2D ----------------------------------------------------------------
Aaro Koskinen (1):
      drivers: macintosh: rack-meter: really fix bogus memsets

Alexandre Belloni (2):
      powerpc/time: stop validating rtc_time in .read_time
      powerpc/5200: dts: digsy_mtc.dts: fix rv3029 compatible

Alexey Kardashevskiy (4):
      powerpc/init: Do not advertise radix during client-architecture-suppo=
rt
      powerpc/lpar/debug: Initialize flags before printing debug message
      powerpc/mm: Fix typo in comments
      powerpc/powernv/npu: Do not try invalidating 32bit table when 64bit t=
able is enabled

Alistair Popple (1):
      powerpc/powernv/npu: Fix deadlock in mmio_invalidate()

Aneesh Kumar K.V (12):
      powerpc/mm/keys: Move pte bits to correct headers
      powerpc/mm/slice: Consolidate return path in slice_get_unmapped_area()
      powerpc/mm: Add support for handling > 512TB address in SLB miss
      powerpc/mm/hash64: Increase the VA range
      powerpc/mm/hash: Don't memset pgd table if not needed
      powerpc/kvm: Fix guest boot failure on Power9 since DAWR changes
      powerpc: Fix oops due to bad access of lppaca on bare metal
      powerpc/mm/keys: Update documentation and remove unnecessary check
      powerpc/mm/radix: Update pte fragment count from 16 to 256 on radix
      powerpc/mm/hugetlb: initialize the pagetable cache correctly for huge=
tlb
      powerpc/mm/radix: Parse disable_radix commandline correctly.
      powerpc/mm/radix: Update command line parsing for disable_radix

Anshuman Khandual (1):
      powerpc/mm: Drop the function native_register_proc_table()

Balbir Singh (1):
      powerpc/powernv/mce: Don't silently restart the machine

Christophe Leroy (7):
      powerpc/mm/slice: Remove intermediate bitmap copy
      powerpc/mm/slice: create header files dedicated to slices
      powerpc/mm/slice: Enhance for supporting PPC32
      powerpc/mm/slice: Fix hugepage allocation at hint address on 8xx
      powerpc/mm/slice: Allow up to 64 low slices
      powerpc/8xx: Increase number of slices to 64
      powerpc/8xx: fix cpm_cascade() dual end of interrupt

Christophe Lombard (1):
      cxl: Fix timebase synchronization status on P9

Finn Thain (1):
      macintosh/adb: Use C99 initializers for struct adb_driver instances

Frederic Barrat (2):
      powerpc/xive: Fix wrong xmon output caused by typo
      cxl: Fix possible deadlock when processing page faults from cxllib

Gustavo Romero (1):
      selftests/powerpc: Skip tm-unavailable if TM is not enabled

Jonathan Neusch=C3=A4fer (10):
      powerpc/wii: Probe the whole devicetree
      powerpc/wii: Explicitly configure GPIO owner for poweroff pin
      powerpc/wii.dts: Add ngpios property
      powerpc/wii.dts: Add GPIO line names
      powerpc/wii.dts: Add drive slot LED
      powerpc/mm: Simplify page_is_ram by using memblock_is_memory
      powerpc/mm: Use memblock API for PPC32 page_is_ram
      powerpc/mm/32: Use page_is_ram to check for RAM
      powerpc/wii: Don't rely on the reserved memory hack
      powerpc/mm/32: Remove the reserved memory hack

Larry Finger (1):
      macintosh: Add module license to ans-lcd

Laurent Dufour (1):
      selftest/powerpc: Add test for sigreturn in transaction

Logan Gunthorpe (2):
      powerpc: io.h: move iomap.h include so that it can use readq/writeq d=
efs
      powerpc: iomap.c: introduce io{read|write}64_{lo_hi|hi_lo}

Madhavan Srinivasan (5):
      powerpc/perf: Prevent kernel address leak to userspace via BHRB buffer
      powerpc/perf: Prevent kernel address leak via perf_get_data_addr()
      powerpc/perf: Infrastructure to support addition of blacklisted events
      powerpc/perf: Add blacklisted events for Power9 DD2.1
      powerpc/perf: Add blacklisted events for Power9 DD2.2

Mark Greer (1):
      powerpc/boot: Remove duplicate typedefs from libfdt_env.h

Mark Hairgrove (1):
      powerpc/npu-dma.c: Fix crash after __mmu_notifier_register failure

Markus Elfring (1):
      powerpc: Use sizeof(*foo) rather than sizeof(struct foo)

Mathieu Malaterre (22):
      powerpc/via-pmu: Fix section mismatch warning
      powerpc/epapr: Move register keyword at the beginning of declaration
      powerpc/32: Move the inline keyword at the beginning of function decl=
aration
      powerpc/32: Mark both tmp variables as unused
      powerpc/embedded6xx: Make functions flipper_pic_init() & ug_udbg_putc=
() static
      powerpc/kernel: Make function __giveup_fpu() static
      powerpc: Add missing prototype for slb_miss_bad_addr()
      powerpc: Add missing prototype for hdec_interrupt
      powerpc: Add missing prototype for time_init()
      powerpc: Add missing prototype for arch_dup_task_struct()
      powerpc: Add missing prototype for arch_irq_work_raise()
      powerpc: Add missing prototype for init_IRQ()
      powerpc: Add missing prototype for sys_debug_setcontext()
      powerpc: Add missing prototypes for sys_sigreturn() & sys_rt_sigretur=
n()
      powerpc: Add missing prototypes for hw_breakpoint_handler() & arch_un=
register_hw_breakpoint()
      powerpc: Add missing prototypes for ppc_select() & ppc_fadvise64_64()
      powerpc/prom: Remove warning on array size when empty
      powerpc: Avoid comparison of unsigned long >=3D 0 in pfn_valid()
      powerpc: Avoid comparison of unsigned long >=3D 0 in __access_ok()
      powerpc/32: Make some functions static
      powerpc/32: Add missing prototypes for (early|machine)_init()
      powerpc/mm/radix: Fix always false comparison against MMU_NO_CONTEXT

Matt Brown (3):
      lib/raid6/altivec: Add vpermxor implementation for raid6 Q syndrome
      lib/raid6: Build proper raid6test files on powerpc
      powerpc: Remove unused flush_dcache_phys_range()

Matt Evans (1):
      powerpc: Clear branch trap (MSR.BE) before delivering SIGTRAP

Mauricio Faria de Oliveira (5):
      powerpc/rfi-flush: Differentiate enabled and patched flush types
      powerpc/mm: Fix section mismatch warning in stop_machine_change_mappi=
ng()
      powerpc/pseries: Fix clearing of security feature flags
      powerpc: Move default security feature flags
      powerpc/pseries: Restore default security feature flags on setup

Michael Ellerman (29):
      Merge two commits from 'kvm-ppc-fixes' into next
      powerpc/pseries: Move smp_query_cpu_stopped() etc. out of plpar_wrapp=
ers.h
      powerpc/pseries: Make plpar_wrappers.h safe to include when PSERIES=
=3Dn
      powerpc: Rename plapr routines to plpar
      powerpc/xmon: Move empty plpar_set_ciabr() into plpar_wrappers.h
      Merge branch 'topic/ppc-kvm' into next
      powerpc/perf: Fix kernel address leak via sampling registers
      powerpc/rfi-flush: Move the logic to avoid a redo into the debugfs co=
de
      powerpc/rfi-flush: Make it possible to call setup_rfi_flush() again
      powerpc/rfi-flush: Always enable fallback flush on pseries
      powerpc/rfi-flush: Call setup_rfi_flush() after LPM migration
      powerpc/pseries: Add new H_GET_CPU_CHARACTERISTICS flags
      powerpc: Add security feature flags for Spectre/Meltdown
      powerpc/pseries: Set or clear security feature flags
      powerpc/powernv: Set or clear security feature flags
      powerpc/64s: Move cpu_show_meltdown()
      powerpc/64s: Enhance the information in cpu_show_meltdown()
      powerpc/powernv: Use the security flags in pnv_setup_rfi_flush()
      powerpc/pseries: Use the security flags in pseries_setup_rfi_flush()
      powerpc/64s: Wire up cpu_show_spectre_v1()
      powerpc/64s: Wire up cpu_show_spectre_v2()
      Merge branch 'topic/ppc-kvm' into next
      Merge branch 'fixes' into next
      powerpc/mpic: Check if cpu_possible() in mpic_physmask()
      Merge branch 'topic/paca' into next
      powerpc/64e: Fix oops due to deferral of paca allocation
      selftests/powerpc: Fix copyloops build since Power4 assembler change
      powerpc/64s/idle: Consolidate power9_offline_stop()/power9_idle_stop()
      Revert "powerpc/64s/idle: POWER9 ESL=3D0 stop avoid save/restore over=
head"

Michael Neuling (9):
      powerpc: Add ppc_breakpoint_available()
      powerpc: Update ptrace to use ppc_breakpoint_available()
      powerpc: Update xmon to use ppc_breakpoint_available()
      KVM: PPC: Book3S HV: Return error from h_set_mode(SET_DAWR) on POWER9
      KVM: PPC: Book3S HV: Return error from h_set_dabr() on POWER9
      KVM: PPC: Book3S HV: Handle migration with POWER9 disabled DAWR
      powerpc: Disable DAWR on POWER9 via CPU feature quirk
      powerpc: Disable DAWR in the base POWER9 CPU features
      powerpc/eeh: Fix race with driver un/bind

Naveen N. Rao (2):
      powerpc/kprobes: Fix call trace due to incorrect preempt count
      powerpc/hw_breakpoint: Only disable hw breakpoint if cpu supports it

Nicholas Piggin (50):
      powerpc/mm/slice: Simplify and optimise slice context initialisation
      powerpc/mm/slice: tidy lpsizes and hpsizes update loops
      powerpc/mm/slice: pass pointers to struct slice_mask where possible
      powerpc/mm/slice: implement a slice mask cache
      powerpc/mm/slice: implement slice_check_range_fits
      powerpc/mm/slice: Switch to 3-operand slice bitops helpers
      powerpc/mm/slice: remove dead code
      powerpc/mm/slice: Use const pointers to cached slice masks where poss=
ible
      powerpc/mm/slice: remove radix calls to the slice code
      selftests/powerpc: Add process creation benchmark
      powerpc/64s: Do not allocate lppaca if we are not virtualized
      powerpc/64: Use array of paca pointers and allocate pacas individually
      powerpc/64s: Allocate LPPACAs individually
      powerpc/64s: Allocate slb_shadow structures individually
      mm: make memblock_alloc_base_nid() non-static
      powerpc/mm/numa: move numa topology discovery earlier
      powerpc/64: move default SPR recording
      powerpc/setup: Add cpu_to_phys_id array
      powerpc/64: Defer paca allocation until memory topology is discovered
      powerpc/64: Allocate pacas per node
      powerpc/64: Allocate per-cpu stacks node-local if possible
      powerpc/64s/radix: Split early page table mapping to its own function
      powerpc/64s/radix: Allocate kernel page tables node-local if possible
      powerpc/mm: Pass node id into create_section_mapping
      powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()
      powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently
      powerpc/64s: return more carefully from sreset NMI
      powerpc/64s: sreset panic if there is no debugger or crash dump handl=
ers
      powerpc/64s/idle: POWER9 implement a separate idle stop function for =
hotplug
      powerpc/64s/idle: avoid sync for KVM state when waking from idle
      powerpc/64s: Add all POWER9 features to CPU_FTRS_ALWAYS
      powerpc/64s: Explicitly add vector features to CPU_FTRS_POSSIBLE
      powerpc/64s: Set assembler machine type to POWER4
      powerpc/64s: Fix POWER9 DD2.2 and above in DT CPU features
      powerpc: Remove unused CPU_FTR_ARCH_201
      powerpc/64s: Remove POWER4 support
      powerpc/64: Add GENERIC_CPU support for little endian
      powerpc/64s: Refine feature sets for little endian builds
      powerpc/64s: Add POWER9 CPU type selection
      KVM: PPC: Book3S HV: Fix ppc_breakpoint_available compile error
      powerpc: Don't write to DABR on >=3D Power8 if DAWR is disabled
      powerpc/powernv: Fix SMT4 forcing idle code
      powerpc: use NMI IPI for smp_send_stop
      powerpc: hard disable irqs in smp_send_stop loop
      powerpc/powernv: Always stop secondaries before reboot/shutdown
      powerpc/64s/idle: POWER9 ESL=3D0 stop avoid save/restore overhead
      powerpc/64s: Fix dt_cpu_ftrs to have restore_cpu clear unwanted LPCR =
bits
      powerpc/64s: Fix pkey support in dt_cpu_ftrs, add CPU_FTR_PKEY bit
      powerpc/64s: Fix POWER9 DD2.2 and above in cputable features
      powerpc/64s/idle: Fix restore of AMOR on POWER9 after deep sleep

Paul Mackerras (8):
      powerpc: Use feature bit for RTC presence rather than timebase presen=
ce
      powerpc: Book E: Remove unused CPU_FTR_L2CSR bit
      powerpc: Free up CPU feature bits on 64-bit machines
      powerpc: Add CPU feature bits for TM bug workarounds on POWER9 v2.2
      powerpc/powernv: Provide a way to force a core into SMT4 mode
      KVM: PPC: Book3S HV: Work around transactional memory bugs in POWER9
      KVM: PPC: Book3S HV: Work around TEXASR bug in fake suspend state
      powerpc/64: Call H_REGISTER_PROC_TBL when running as a HPT guest on P=
OWER9

Philippe Bergheaud (2):
      powerpc/powernv: Enable tunneled operations
      cxl: read PHB indications from the device tree

Ram Pai (1):
      powerpc/mm: Fix thread_pkey_regs_init()

Rob Herring (1):
      powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'

Sam Bobroff (9):
      powerpc/eeh: Remove eeh_handle_event()
      powerpc/eeh: Manage EEH_PE_RECOVERING inside eeh_handle_normal_event()
      powerpc/eeh: Fix misleading comment in __eeh_addr_cache_get_device()
      powerpc/eeh: Remove misleading test in eeh_handle_normal_event()
      powerpc/eeh: Rename frozen_bus to bus in eeh_handle_normal_event()
      powerpc/eeh: Clarify arguments to eeh_reset_device()
      powerpc/eeh: Remove always-true tests in eeh_reset_device()
      powerpc/eeh: Factor out common code eeh_reset_device()
      powerpc/eeh: Add eeh_state_active() helper

Segher Boessenkool (1):
      powerpc: Keep const vars out of writable .sdata

Simon Guo (1):
      PCI/hotplug: ppc: correct a php_slot usage after free

Sukadev Bhattiprolu (4):
      powerpc/powernv/vas: Remove a stray line in Makefile
      powerpc/powernv/vas: Fix order of cleanup in vas_window_init_dbgdir()
      powerpc/vas: Fix cleanup when VAS is not configured
      powerpc/vas: Add a couple of trace points

Suraj Jitindar Singh (1):
      KVM: PPC: Book3S HV: Work around XER[SO] bug in fake suspend mode

Thiago Jung Bauermann (1):
      powerpc/kexec_file: Fix error code when trying to load kdump kernel

Vaibhav Jain (5):
      powerpc/xmon: Setup debugger hooks when first break-point is set
      powerpc/xmon: Clear all breakpoints when xmon is disabled via debugfs
      cxl: Enable NORST bit in PSL_DEBUG register for PSL9
      cxl: Remove function write_timebase_ctrl_psl9() for PSL9
      cxl: Check if PSL data-cache is available before issue flush request

Wei Yongjun (1):
      powerpc/4xx: Fix error return code in ppc4xx_msi_probe()

 arch/powerpc/Makefile                              |  14 +-
 arch/powerpc/boot/dts/acadia.dts                   |   2 +-
 arch/powerpc/boot/dts/adder875-redboot.dts         |   2 +-
 arch/powerpc/boot/dts/adder875-uboot.dts           |   2 +-
 arch/powerpc/boot/dts/akebono.dts                  |   2 +-
 arch/powerpc/boot/dts/amigaone.dts                 |   2 +-
 arch/powerpc/boot/dts/asp834x-redboot.dts          |   2 +-
 arch/powerpc/boot/dts/bamboo.dts                   |   2 +-
 arch/powerpc/boot/dts/c2k.dts                      |   2 +-
 arch/powerpc/boot/dts/currituck.dts                |   2 +-
 arch/powerpc/boot/dts/digsy_mtc.dts                |   2 +-
 arch/powerpc/boot/dts/ebony.dts                    |   2 +-
 arch/powerpc/boot/dts/eiger.dts                    |   2 +-
 arch/powerpc/boot/dts/ep405.dts                    |   2 +-
 arch/powerpc/boot/dts/fsl/mvme7100.dts             |   2 +-
 arch/powerpc/boot/dts/fsp2.dts                     |   2 +-
 arch/powerpc/boot/dts/holly.dts                    |   2 +-
 arch/powerpc/boot/dts/hotfoot.dts                  |   2 +-
 arch/powerpc/boot/dts/icon.dts                     |   2 +-
 arch/powerpc/boot/dts/iss4xx-mpic.dts              |   2 +-
 arch/powerpc/boot/dts/iss4xx.dts                   |   2 +-
 arch/powerpc/boot/dts/katmai.dts                   |   2 +-
 arch/powerpc/boot/dts/klondike.dts                 |   2 +-
 arch/powerpc/boot/dts/ksi8560.dts                  |   2 +-
 arch/powerpc/boot/dts/media5200.dts                |   2 +-
 arch/powerpc/boot/dts/mpc8272ads.dts               |   2 +-
 arch/powerpc/boot/dts/mpc866ads.dts                |   2 +-
 arch/powerpc/boot/dts/mpc885ads.dts                |   2 +-
 arch/powerpc/boot/dts/mvme5100.dts                 |   2 +-
 arch/powerpc/boot/dts/obs600.dts                   |   2 +-
 arch/powerpc/boot/dts/pq2fads.dts                  |   2 +-
 arch/powerpc/boot/dts/rainier.dts                  |   2 +-
 arch/powerpc/boot/dts/redwood.dts                  |   2 +-
 arch/powerpc/boot/dts/sam440ep.dts                 |   2 +-
 arch/powerpc/boot/dts/sequoia.dts                  |   2 +-
 arch/powerpc/boot/dts/storcenter.dts               |   2 +-
 arch/powerpc/boot/dts/taishan.dts                  |   2 +-
 arch/powerpc/boot/dts/virtex440-ml507.dts          |   2 +-
 arch/powerpc/boot/dts/virtex440-ml510.dts          |   2 +-
 arch/powerpc/boot/dts/walnut.dts                   |   2 +-
 arch/powerpc/boot/dts/warp.dts                     |   2 +-
 arch/powerpc/boot/dts/wii.dts                      |  21 +
 arch/powerpc/boot/dts/xpedite5200_xmon.dts         |   2 +-
 arch/powerpc/boot/dts/yosemite.dts                 |   2 +-
 arch/powerpc/boot/libfdt_env.h                     |   2 -
 arch/powerpc/include/asm/asm-prototypes.h          |  15 +
 arch/powerpc/include/asm/barrier.h                 |   3 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |  14 +
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  25 +-
 arch/powerpc/include/asm/book3s/64/hash.h          |   2 +-
 arch/powerpc/include/asm/book3s/64/mmu.h           |  54 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |  12 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  19 -
 arch/powerpc/include/asm/book3s/64/radix-4k.h      |   5 +
 arch/powerpc/include/asm/book3s/64/radix-64k.h     |   6 +
 arch/powerpc/include/asm/book3s/64/radix.h         |   2 +-
 arch/powerpc/include/asm/book3s/64/slice.h         |  27 +
 arch/powerpc/include/asm/cacheflush.h              |   1 -
 arch/powerpc/include/asm/cputable.h                | 263 +++++----
 arch/powerpc/include/asm/debug.h                   |   1 +
 arch/powerpc/include/asm/eeh.h                     |   6 +
 arch/powerpc/include/asm/eeh_event.h               |   3 +-
 arch/powerpc/include/asm/epapr_hcalls.h            |  22 +-
 arch/powerpc/include/asm/hugetlb.h                 |   8 +-
 arch/powerpc/include/asm/hvcall.h                  |   4 +
 arch/powerpc/include/asm/hw_breakpoint.h           |   5 +-
 arch/powerpc/include/asm/io.h                      |   4 +-
 arch/powerpc/include/asm/irq.h                     |   1 +
 arch/powerpc/include/asm/irq_work.h                |   1 +
 arch/powerpc/include/asm/kvm_asm.h                 |   2 +
 arch/powerpc/include/asm/kvm_book3s.h              |   4 +
 arch/powerpc/include/asm/kvm_book3s_64.h           |  43 ++
 arch/powerpc/include/asm/kvm_book3s_asm.h          |   1 +
 arch/powerpc/include/asm/kvm_host.h                |   1 +
 arch/powerpc/include/asm/kvm_ppc.h                 |   8 +-
 arch/powerpc/include/asm/lppaca.h                  |  29 +-
 arch/powerpc/include/asm/mmu-8xx.h                 |  21 +
 arch/powerpc/include/asm/mmu.h                     |   6 +-
 arch/powerpc/include/asm/mmu_context.h             |  39 ++
 arch/powerpc/include/asm/nohash/32/slice.h         |  18 +
 arch/powerpc/include/asm/nohash/64/slice.h         |  12 +
 arch/powerpc/include/asm/opal-api.h                |   4 +-
 arch/powerpc/include/asm/opal.h                    |   4 +-
 arch/powerpc/include/asm/paca.h                    |  27 +-
 arch/powerpc/include/asm/page.h                    |  11 +-
 arch/powerpc/include/asm/page_64.h                 |  59 --
 arch/powerpc/include/asm/perf_event_server.h       |   2 +
 arch/powerpc/include/asm/plpar_wrappers.h          |  24 +-
 arch/powerpc/include/asm/pmc.h                     |  13 +-
 arch/powerpc/include/asm/pnv-pci.h                 |   6 +
 arch/powerpc/include/asm/powernv.h                 |   1 +
 arch/powerpc/include/asm/ppc-opcode.h              |  10 +
 arch/powerpc/include/asm/ppc_asm.h                 |  11 +-
 arch/powerpc/include/asm/processor.h               |  16 +-
 arch/powerpc/include/asm/reg.h                     |   7 +
 arch/powerpc/include/asm/security_features.h       |  74 +++
 arch/powerpc/include/asm/setup.h                   |   3 +-
 arch/powerpc/include/asm/slice.h                   |  40 ++
 arch/powerpc/include/asm/smp.h                     |   5 +-
 arch/powerpc/include/asm/sparsemem.h               |   2 +-
 arch/powerpc/include/asm/spinlock.h                |   2 +
 arch/powerpc/include/asm/switch_to.h               |   1 -
 arch/powerpc/include/asm/synch.h                   |   4 -
 arch/powerpc/include/asm/thread_info.h             |   1 +
 arch/powerpc/include/asm/time.h                    |   4 +-
 arch/powerpc/include/asm/uaccess.h                 |  10 +-
 arch/powerpc/kernel/Makefile                       |   2 +-
 arch/powerpc/kernel/asm-offsets.c                  |   8 +
 arch/powerpc/kernel/cpu_setup_6xx.S                |   2 +-
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
 arch/powerpc/kernel/cputable.c                     |  59 +-
 arch/powerpc/kernel/crash.c                        |   2 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |  36 +-
 arch/powerpc/kernel/eeh.c                          |  19 +-
 arch/powerpc/kernel/eeh_cache.c                    |   3 +-
 arch/powerpc/kernel/eeh_driver.c                   | 205 ++++---
 arch/powerpc/kernel/eeh_event.c                    |   6 +-
 arch/powerpc/kernel/entry_64.S                     |   2 +-
 arch/powerpc/kernel/exceptions-64s.S               |  86 ++-
 arch/powerpc/kernel/head_64.S                      |  19 +-
 arch/powerpc/kernel/hw_breakpoint.c                |   3 +
 arch/powerpc/kernel/idle_book3s.S                  |  50 +-
 arch/powerpc/kernel/iomap.c                        |  40 ++
 arch/powerpc/kernel/kprobes.c                      |  30 +-
 arch/powerpc/kernel/machine_kexec_64.c             |  37 +-
 arch/powerpc/kernel/machine_kexec_file_64.c        |   2 +-
 arch/powerpc/kernel/misc_64.S                      |  38 --
 arch/powerpc/kernel/nvram_64.c                     |   9 +-
 arch/powerpc/kernel/paca.c                         | 242 ++++----
 arch/powerpc/kernel/process.c                      |  26 +-
 arch/powerpc/kernel/prom.c                         |  19 +-
 arch/powerpc/kernel/prom_init.c                    |  29 +-
 arch/powerpc/kernel/prom_init_check.sh             |   2 +-
 arch/powerpc/kernel/ptrace.c                       |  16 +-
 arch/powerpc/kernel/security.c                     |  88 +++
 arch/powerpc/kernel/setup-common.c                 |  37 +-
 arch/powerpc/kernel/setup.h                        |   9 +-
 arch/powerpc/kernel/setup_32.c                     |   8 +-
 arch/powerpc/kernel/setup_64.c                     | 113 ++--
 arch/powerpc/kernel/signal.h                       |   5 +
 arch/powerpc/kernel/signal_32.c                    |   4 +-
 arch/powerpc/kernel/smp.c                          |  23 +-
 arch/powerpc/kernel/sysfs.c                        |  20 +-
 arch/powerpc/kernel/time.c                         |   5 +-
 arch/powerpc/kernel/traps.c                        |  31 +-
 arch/powerpc/kernel/vdso.c                         |  12 +-
 arch/powerpc/kvm/Makefile                          |   7 +
 arch/powerpc/kvm/book3s_hv.c                       |  55 +-
 arch/powerpc/kvm/book3s_hv_builtin.c               |   2 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S            |   3 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            | 187 ++++++-
 arch/powerpc/kvm/book3s_hv_tm.c                    | 216 +++++++
 arch/powerpc/kvm/book3s_hv_tm_builtin.c            | 109 ++++
 arch/powerpc/kvm/emulate.c                         |   6 -
 arch/powerpc/kvm/powerpc.c                         |   5 +-
 arch/powerpc/lib/Makefile                          |   6 +-
 arch/powerpc/lib/copypage_64.S                     |   2 +
 arch/powerpc/lib/copypage_power7.S                 |   3 -
 arch/powerpc/lib/copyuser_64.S                     |   2 +
 arch/powerpc/lib/copyuser_power7.S                 |   3 -
 arch/powerpc/lib/feature-fixups.c                  |   9 +-
 arch/powerpc/lib/memcpy_64.S                       |   2 +
 arch/powerpc/lib/memcpy_power7.S                   |   3 -
 arch/powerpc/lib/sstep.c                           |   4 +-
 arch/powerpc/mm/8xx_mmu.c                          |   2 +-
 arch/powerpc/mm/copro_fault.c                      |   2 +-
 arch/powerpc/mm/fault.c                            |  28 +-
 arch/powerpc/mm/hash_native_64.c                   |  15 -
 arch/powerpc/mm/hash_utils_64.c                    |  34 +-
 arch/powerpc/mm/hugetlbpage.c                      |  26 +-
 arch/powerpc/mm/init_32.c                          |   7 +-
 arch/powerpc/mm/init_64.c                          |   8 +-
 arch/powerpc/mm/mem.c                              |  25 +-
 arch/powerpc/mm/mmu_context_book3s64.c             |  24 +-
 arch/powerpc/mm/mmu_context_nohash.c               |  15 +-
 arch/powerpc/mm/mmu_decl.h                         |   1 -
 arch/powerpc/mm/numa.c                             |  36 +-
 arch/powerpc/mm/pgtable-book3s64.c                 |   8 +-
 arch/powerpc/mm/pgtable-hash64.c                   |   6 +-
 arch/powerpc/mm/pgtable-radix.c                    | 218 +++++---
 arch/powerpc/mm/pgtable_32.c                       |   2 +-
 arch/powerpc/mm/pgtable_64.c                       |   5 -
 arch/powerpc/mm/pkeys.c                            |  17 +-
 arch/powerpc/mm/slb.c                              | 108 ++++
 arch/powerpc/mm/slb_low.S                          |  19 +-
 arch/powerpc/mm/slice.c                            | 485 ++++++++--------
 arch/powerpc/mm/tlb-radix.c                        |  14 +-
 arch/powerpc/mm/tlb_hash64.c                       |   2 +-
 arch/powerpc/oprofile/cell/spu_task_sync.c         |   2 +-
 arch/powerpc/oprofile/cell/vma_map.c               |   4 +-
 arch/powerpc/perf/Makefile                         |   2 +-
 arch/powerpc/perf/core-book3s.c                    |  50 ++
 arch/powerpc/perf/power4-pmu.c                     | 622 -----------------=
----
 arch/powerpc/perf/power9-events-list.h             |  28 +
 arch/powerpc/perf/power9-pmu.c                     |  48 ++
 arch/powerpc/platforms/4xx/msi.c                   |   5 +-
 arch/powerpc/platforms/4xx/ocm.c                   |   2 +-
 arch/powerpc/platforms/85xx/smp.c                  |   8 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c            |   8 +-
 arch/powerpc/platforms/Kconfig.cputype             |  20 +-
 arch/powerpc/platforms/cell/axon_msi.c             |   2 +-
 arch/powerpc/platforms/cell/smp.c                  |   4 +-
 arch/powerpc/platforms/cell/spider-pci.c           |   2 +-
 arch/powerpc/platforms/cell/spufs/lscsa_alloc.c    |   2 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |   2 +-
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |   2 +-
 arch/powerpc/platforms/embedded6xx/wii.c           |  23 +-
 arch/powerpc/platforms/powermac/low_i2c.c          |   2 +-
 arch/powerpc/platforms/powermac/pfunc_core.c       |   4 +-
 arch/powerpc/platforms/powernv/Makefile            |   1 -
 arch/powerpc/platforms/powernv/eeh-powernv.c       |   9 +-
 arch/powerpc/platforms/powernv/idle.c              |  88 ++-
 arch/powerpc/platforms/powernv/npu-dma.c           | 261 +++++----
 arch/powerpc/platforms/powernv/opal-flash.c        |  32 +-
 arch/powerpc/platforms/powernv/opal-hmi.c          |   2 +-
 arch/powerpc/platforms/powernv/opal-imc.c          |  10 +-
 .../powerpc/platforms/powernv/opal-memory-errors.c |   2 +-
 arch/powerpc/platforms/powernv/opal-nvram.c        |   4 +
 arch/powerpc/platforms/powernv/opal-psr.c          |   2 +-
 .../powerpc/platforms/powernv/opal-sensor-groups.c |   4 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   2 +
 arch/powerpc/platforms/powernv/opal-xscom.c        |   2 +-
 arch/powerpc/platforms/powernv/opal.c              |   5 +-
 arch/powerpc/platforms/powernv/pci-cxl.c           |   8 -
 arch/powerpc/platforms/powernv/pci-ioda.c          |  29 +-
 arch/powerpc/platforms/powernv/pci.c               | 135 +++++
 arch/powerpc/platforms/powernv/setup.c             | 114 ++--
 arch/powerpc/platforms/powernv/smp.c               |   2 +-
 arch/powerpc/platforms/powernv/subcore.c           |   2 +-
 arch/powerpc/platforms/powernv/vas-debug.c         |  19 +-
 arch/powerpc/platforms/powernv/vas-trace.h         | 113 ++++
 arch/powerpc/platforms/powernv/vas-window.c        |   9 +
 arch/powerpc/platforms/powernv/vas.c               |   6 +-
 arch/powerpc/platforms/ps3/mm.c                    |   6 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   2 +-
 arch/powerpc/platforms/pseries/kexec.c             |   7 +-
 arch/powerpc/platforms/pseries/lpar.c              |  18 +-
 arch/powerpc/platforms/pseries/mobility.c          |   3 +
 arch/powerpc/platforms/pseries/pseries.h           |  10 +
 arch/powerpc/platforms/pseries/setup.c             |  85 ++-
 arch/powerpc/platforms/pseries/smp.c               |   6 +-
 arch/powerpc/sysdev/mpic.c                         |   2 +-
 arch/powerpc/sysdev/xics/icp-native.c              |   2 +-
 arch/powerpc/sysdev/xive/common.c                  |   2 +-
 arch/powerpc/xmon/xmon.c                           |  56 +-
 drivers/macintosh/adb-iop.c                        |  14 +-
 drivers/macintosh/ans-lcd.c                        |   1 +
 drivers/macintosh/macio-adb.c                      |  15 +-
 drivers/macintosh/rack-meter.c                     |   6 +-
 drivers/macintosh/via-macii.c                      |  14 +-
 drivers/macintosh/via-pmu.c                        |  16 +-
 drivers/macintosh/via-pmu68k.c                     |  14 +-
 drivers/misc/cxl/cxl.h                             |   6 +-
 drivers/misc/cxl/cxllib.c                          |  87 ++-
 drivers/misc/cxl/native.c                          |  11 +-
 drivers/misc/cxl/pci.c                             | 102 ++--
 drivers/misc/cxl/sysfs.c                           |  12 +
 drivers/pci/hotplug/pnv_php.c                      |   2 +-
 include/linux/memblock.h                           |   3 +
 include/linux/raid/pq.h                            |   4 +
 lib/raid6/.gitignore                               |   1 +
 lib/raid6/Makefile                                 |  27 +-
 lib/raid6/algos.c                                  |   4 +
 lib/raid6/altivec.uc                               |   3 +
 lib/raid6/test/Makefile                            |  25 +-
 lib/raid6/vpermxor.uc                              | 105 ++++
 mm/memblock.c                                      |   2 +-
 .../selftests/powerpc/benchmarks/.gitignore        |   2 +
 .../testing/selftests/powerpc/benchmarks/Makefile  |   7 +-
 .../selftests/powerpc/benchmarks/exec_target.c     |  13 +
 tools/testing/selftests/powerpc/benchmarks/fork.c  | 325 +++++++++++
 tools/testing/selftests/powerpc/copyloops/Makefile |   4 +-
 tools/testing/selftests/powerpc/tm/Makefile        |   2 +-
 tools/testing/selftests/powerpc/tm/tm-sigreturn.c  |  92 +++
 .../testing/selftests/powerpc/tm/tm-unavailable.c  |  24 +-
 275 files changed, 4647 insertions(+), 2427 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/slice.h
 create mode 100644 arch/powerpc/include/asm/nohash/32/slice.h
 create mode 100644 arch/powerpc/include/asm/nohash/64/slice.h
 create mode 100644 arch/powerpc/include/asm/security_features.h
 create mode 100644 arch/powerpc/include/asm/slice.h
 create mode 100644 arch/powerpc/kernel/security.c
 create mode 100644 arch/powerpc/kvm/book3s_hv_tm.c
 create mode 100644 arch/powerpc/kvm/book3s_hv_tm_builtin.c
 delete mode 100644 arch/powerpc/perf/power4-pmu.c
 create mode 100644 arch/powerpc/platforms/powernv/vas-trace.h
 create mode 100644 lib/raid6/vpermxor.uc
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/exec_target.c
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/fork.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-sigreturn.c
=2D----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJayMZIAAoJEFHr6jzI4aWA5N8P/2Ld4s0Olg6bCPR+s49cY6AT
kPphjS90QWYXEV7ZmU5zJtms8n5PCEIzAJ1fZyCvMN2bltzv0Y+GeHmL3VaPPehT
c7T/v0AVs/9j1P3+AwDm3oTZZSnxAW3ruZr62Pn9+9DtNqLuUvvpqqKszGjjWIKe
W7G2pVqF8DDSMoVLWvtgXJbYMbDDsCmKy5ZGX0kenctFZX5hLWGxAURYfymeh/Tx
j3anKXMaeSypAQNQcapHmdqeyMc531niSk5VbN8o/7Tr59igA7Eokzv2+0IIKs37
t5E6Tw99r/qchQiUx3gpy7yf9m+QNEHkwHRa8R6HB2fHIanpg10y7rD7gyQcomFQ
K0Zppm++yms541pll9CMN7RLWa4BhqGoDeDJIv8s/MGIl8ETQIHVfG30doxaFaIN
ivY0u1C9KXAGdUOwjaVT82C7RuGZTKjAjSQ2U2riNGI8iKV7usSioJrwT5ZRxys/
6XATnbugpM4usmbupqs652Ver6o2b7kz2Ek1voYbTF18L0UY5Ez/7ECaZNiTvqKa
R+2VlaUx4B8ei7NYFX+GXP8VN4jecaHUSyPoBLLvyUwXSmvBqwyD0r0yhVHrUGfr
ogneuLDkqVSbG1e2yFWuxe0AKZifmZoTXv/7I6qBlStMtXA/crKSbpd6NUkBUpXH
U4aL/5JjSTR3Zqv3g5BM
=3Dw2Q5
=2D----END PGP SIGNATURE-----
