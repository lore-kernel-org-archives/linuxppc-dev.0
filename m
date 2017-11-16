Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yczwK45NFzDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 22:46:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, alistair@popple.id.au, allen.lkml@gmail.com,
 andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 arnd@arndb.de, benh@kernel.crashing.org, bhelgaas@google.com,
 boris.brezillon@free-electrons.com, bsingharora@gmail.com,
 christophe.leroy@c-s.fr, clombard@linux.vnet.ibm.com, cyrilbur@gmail.com,
 elfring@users.sourceforge.net, fbarrat@linux.vnet.ibm.com,
 geert+renesas@glider.be, gpiccoli@linux.vnet.ibm.com,
 gromero@linux.vnet.ibm.com, haren@linux.vnet.ibm.com,
 hbathini@linux.vnet.ibm.com, joel@jms.id.au, kamalesh@linux.vnet.ibm.com,
 kautuk.consul.1980@gmail.com, leitao@debian.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mhiramat@kernel.org, mikey@neuling.org, msuchanek@suse.de,
 mwb@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 npiggin@gmail.com, oohall@gmail.com, paulus@ozlabs.org, robh@kernel.org,
 ruscur@russell.cc, sandipan@linux.vnet.ibm.com,
 seth.forshee@canonical.com, sfr@canb.auug.org.au,
 shriyak@linux.vnet.ibm.com, stewart@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 tyreld@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com, wak@google.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.15-1 tag
Date: Thu, 16 Nov 2017 22:46:02 +1100
Message-ID: <87bmk2v43p.fsf@concordia.ellerman.id.au>
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

Please pull powerpc updates for 4.15. Apologies this is a bit late, we
had some late breaking fixes come in.

A bit of a small release, I suspect in part due to me travelling for KS.
But my backlog of patches to review is smaller than usual, so I think in
part folks just didn't send as much this cycle.

There's two conflicts you'll see. The first in KVM code against a fix
that went through Paul's tree, and the other against one of the timer
changes.

The correct resoultion in the KVM case is:
	case KVM_CAP_PPC_HTM:
		r = hv_enabled &&
		    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_HTM_COMP);

And for the timer change:
	mod_timer(&topology_timer, jiffies + topology_timer_secs * HZ);

cheers


The following changes since commit e19b205be43d11bff638cad4487008c48d21c103:

  Linux 4.14-rc2 (2017-09-24 16:38:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.15-1

for you to fetch changes up to 3ffa9d9e2a7c10127d8cbf91ea2be15390b450ed:

  powerpc/64s: Fix Power9 DD2.0 workarounds by adding DD2.1 feature (2017-11-15 14:25:42 +1100)

----------------------------------------------------------------
powerpc updates for 4.15

Non-highlights:

 - Five fixes for the >128T address space handling, both to fix bugs in our
   implementation and to bring the semantics exactly into line with x86.

Highlights:

 - Support for a new OPAL call on bare metal machines which gives us a true NMI
   (ie. is not masked by MSR[EE]=0) for debugging etc.

 - Support for Power9 DD2 in the CXL driver.

 - Improvements to machine check handling so that uncorrectable errors can be
   reported into the generic memory_failure() machinery.

 - Some fixes and improvements for VPHN, which is used under PowerVM to notify
   the Linux partition of topology changes.

 - Plumbing to enable TM (transactional memory) without suspend on some Power9
   processors (PPC_FEATURE2_HTM_NO_SUSPEND).

 - Support for emulating vector loads form cache-inhibited memory, on some
   Power9 revisions.

 - Disable the fast-endian switch "syscall" by default (behind a CONFIG), we
   believe it has never had any users.

 - A major rework of the API drivers use when initiating and waiting for long
   running operations performed by OPAL firmware, and changes to the
   powernv_flash driver to use the new API.

 - Several fixes for the handling of FP/VMX/VSX while processes are using
   transactional memory.

 - Optimisations of TLB range flushes when using the radix MMU on Power9.

 - Improvements to the VAS facility used to access coprocessors on Power9, and
   related improvements to the way the NX crypto driver handles requests.

 - Implementation of PMEM_API and UACCESS_FLUSHCACHE for 64-bit.

Thanks to:
  Alexey Kardashevskiy, Alistair Popple, Allen Pais, Andrew Donnellan, Aneesh
  Kumar K.V, Arnd Bergmann, Balbir Singh, Benjamin Herrenschmidt, Breno Leitao,
  Christophe Leroy, Christophe Lombard, Cyril Bur, Frederic Barrat, Gautham R.
  Shenoy, Geert Uytterhoeven, Guilherme G. Piccoli, Gustavo Romero, Haren
  Myneni, Joel Stanley, Kamalesh Babulal, Kautuk Consul, Markus Elfring, Masami
  Hiramatsu, Michael Bringmann, Michael Neuling, Michal Suchanek, Naveen N. Rao,
  Nicholas Piggin, Oliver O'Halloran, Paul Mackerras, Pedro Miraglia Franco de
  Carvalho, Philippe Bergheaud, Sandipan Das, Seth Forshee, Shriya, Stephen
  Rothwell, Stewart Smith, Sukadev Bhattiprolu, Tyrel Datwyler, Vaibhav Jain,
  Vaidyanathan Srinivasan, William A. Kennington III.

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      powerpc/powernv: Reserve a hole which appears after enabling IOV
      powerpc/powernv/ioda: Remove explicit max window size check

Alistair Popple (2):
      powerpc/powernv/npu: Use flush_all_mm() instead of flush_tlb_mm()
      powerpc/powernv/npu: Don't explicitly flush nmmu tlb

Allen Pais (3):
      powerpc/oprofile: Use setup_timer() helper
      powerpc/6xx: Use setup_timer() helper
      powerpc/powermac: Use setup_timer() helper

Andrew Donnellan (1):
      powerpc/configs: Enable I2C_CHARDEV for pseries and powernv

Aneesh Kumar K.V (1):
      powerpc/mm/hash: Add pr_fmt() to hash_utils64.c

Arnd Bergmann (1):
      powerpc/eeh: Stop using do_gettimeofday()

Balbir Singh (7):
      powerpc/mce: Remove unused function get_mce_fault_addr()
      powerpc/mce: Align the print of physical address better
      powerpc/mce: Hookup derror (load/store) UE errors
      powerpc/mce: Hookup ierror (instruction) UE errors
      powerpc/mce: hookup memory_failure for UE errors
      powerpc/xmon: Support dumping software pagetables
      powerpc/mm/radix: Fix crashes on Power9 DD1 with radix MMU and STRICT_RWX

Benjamin Herrenschmidt (2):
      powerpc/powernv: Rework EEH initialization on powernv
      powerpc: Fix DABR match on hash based systems

Breno Leitao (1):
      powerpc/xmon: Check before calling xive functions

Christophe Leroy (1):
      powerpc/ipic: Fix status get and status clear

Christophe Lombard (1):
      cxl: Add support for POWER9 DD2

Cyril Bur (15):
      selftests/powerpc: context_switch: Fix pthread errors
      powerpc/tm: Add commandline option to disable hardware transactional memory
      mtd: powernv_flash: Use WARN_ON_ONCE() rather than BUG_ON()
      mtd: powernv_flash: Don't treat OPAL_SUCCESS as an error
      mtd: powernv_flash: Remove pointless goto in driver init
      mtd: powernv_flash: Don't return -ERESTARTSYS on interrupted token acquisition
      powerpc/opal: Make __opal_async_{get, release}_token() static
      powerpc/opal: Rework the opal-async interface
      powerpc/opal: Add opal_async_wait_response_interruptible() to opal-async
      powerpc/powernv: Add OPAL_BUSY to opal_error_code()
      mtd: powernv_flash: Use opal_async_wait_response_interruptible()
      powerpc: Don't enable FP/Altivec if not checkpointed
      powerpc: Force reload for recheckpoint during tm {fp, vec, vsx} unavailable exception
      powerpc: Always save/restore checkpointed regs during treclaim/trecheckpoint
      powerpc: Remove facility loadups on transactional {fp, vec, vsx} unavailable

Frederic Barrat (2):
      powerpc/mm: Export flush_all_mm()
      cxl: Enable global TLBIs for cxl contexts

Geert Uytterhoeven (1):
      powerpc: dts: acadia: DT fix s/#interrupts-parent/#interrupt-parent/

Guilherme G. Piccoli (1):
      powerpc/xmon: Add option to show uptime information

Gustavo Romero (1):
      selftests/powerpc: Check FP/VEC on exception in TM

Haren Myneni (2):
      crypto/nx: Use percpu send window for NX requests
      crypto/nx: Do not initialize workmem allocation

Joel Stanley (1):
      powerpc/configs: Add Skiroot defconfig

Kamalesh Babulal (1):
      powerpc/modules: Use WARN_ON() in stub_for_addr()

Kautuk Consul (1):
      powerpc: get_wchan(): solve possible race scenario due to parallel wakeup

Markus Elfring (3):
      powerpc/axonram: Drop unnecessary variable initialisation
      powerpc-opal: Fix a typo in a comment line of two file headers
      powerpc/pseries: Cleanup error handling in iommu_pseries_alloc_group()

Michael Bringmann (4):
      powerpc/vphn: Update CPU topology when VPHN enabled
      powerpc/vphn: Improve recognition of PRRN/VPHN
      powerpc/hotplug: Improve responsiveness of hotplug change
      powerpc/vphn: Fix numa update end-loop bug

Michael Ellerman (18):
      powerpc/powernv: Make opal_event_shutdown() callable from IRQ context
      KVM: PPC: Tie KVM_CAP_PPC_HTM to the user-visible TM feature
      Merge branch 'topic/ppc-kvm' into next
      powerpc: Add PPC_FEATURE2_HTM_NO_SUSPEND
      powerpc/powernv: Enable TM without suspend if possible
      powerpc/mm/radix: Drop unneeded NULL check
      powerpc/xmon: Add kstack base to paca dump
      powerpc/64s: Move the two FAST_ENDIAN macros next to each other
      powerpc: Disable the fast-endian switch syscall by default
      powerpc/perf/hv-24x7: Fix incorrect comparison in memord
      powerpc/64: Free up CPU_FTR_ICSWX
      powerpc/64s: Replace CONFIG_PPC_STD_MMU_64 with CONFIG_PPC_BOOK3S_64
      powerpc/mm: Add a CONFIG option to choose if radix is used by default
      powerpc/tm: Don't check for WARN in TM Bad Thing handling
      Merge branch 'fixes' into next
      powerpc/64s/hash: Fix 512T hint detection to use >= 128T
      powerpc/64s: Fix masking of SRR1 bits on instruction fault
      powerpc/64s: Fix Power9 DD2.0 workarounds by adding DD2.1 feature

Michael Neuling (3):
      powerpc/64s: Add workaround for P9 vector CI load issue
      powerpc: Add PPC_EMULATED_STATS to powernv_defconfig
      powerpc/tm: P9 disable transactionally suspended sigcontexts

Michal Suchanek (2):
      powerpc/mm/hash: Remove stale comment.
      powerpc/fadump: use kstrtoint to handle sysfs store

Naveen N. Rao (11):
      powerpc/kprobes: Some cosmetic updates to try_to_emulate()
      powerpc/kprobes: Do not suppress instruction emulation if a single run failed
      powerpc/kprobes: Clean up jprobe detection in livepatch handler
      powerpc/kprobes: Fix warnings from __this_cpu_read() on preempt kernels
      powerpc/jprobes: Disable preemption when triggered through ftrace
      powerpc/jprobes: Validate break handler invocation as being due to a jprobe_return()
      powerpc/kprobes: Disable preemption before invoking probe handler for optprobes
      powerpc/kprobes: Do not disable interrupts for optprobes and kprobes_on_ftrace
      powerpc/kprobes: Blacklist emulate_update_regs() from kprobes
      powerpc/kprobes: refactor kprobe_lookup_name for safer string operations
      powerpc/signal: Properly handle return value from uprobe_deny_signal()

Nicholas Piggin (29):
      powerpc/watchdog: Do not panic from locked CPU's IPI handler
      powerpc/watchdog: Do not backtrace locked CPUs twice if allcpus backtrace is enabled
      powerpc/watchdog: Do not trigger SMP crash from touch_nmi_watchdog
      powerpc/xmon: Avoid tripping SMP hardlockup watchdog
      powerpc/64s: Implement system reset idle wakeup reason
      powerpc/powernv: Implement NMI IPI with OPAL_SIGNAL_SYSTEM_RESET
      powerpc/powernv: Use early_radix_enabled in POWER9 tlb flush
      KVM: PPC: Book3S HV: Handle host system reset in guest mode
      powerpc/64: Fix latency tracing for lazy irq replay
      powerpc/book3s: Use label for FIXUP_ENDIAN macro branch
      powerpc/book3s: Add an HV variant of FIXUP_ENDIAN that is recoverable
      powerpc/powernv: Use FIXUP_ENDIAN_HV in OPAL return
      powerpc/64s/radix: Improve preempt handling in TLB code
      powerpc/64s/radix: Fix process table entry cache invalidation
      powerpc: add POWER9_DD20 feature
      powerpc/64s/idle: avoid POWER9 DD1 and DD2.0 ERAT workaround on DD2.1
      powerpc/64s/idle: avoid POWER9 DD1 and DD2.0 PMU workaround on DD2.1
      powerpc/64s/radix: Optimize TLB range flush barriers
      powerpc/64s/radix: Implement _tlbie(l)_va_range flush functions
      powerpc/64s/radix: Optimize flush_tlb_range
      powerpc/64s/radix: Introduce local single page ceiling for TLB range flush
      powerpc/64s/radix: Improve TLB flushing for page table freeing
      powerpc/powernv: Avoid waiting for secondary hold spinloop with OPAL
      powerpc/64: Set DSCR default initially from SPR
      powerpc/64s/hash: Fix 128TB-512TB virtual address boundary case allocation
      powerpc/64s/hash: Fix fork() with 512TB process address space
      powerpc/64s/hash: Allow MAP_FIXED allocations to cross 128TB boundary
      powerpc/64s/radix: Fix 128TB-512TB virtual address boundary case allocation
      powerpc/64s: mm_context.addr_limit is only used on hash

Oliver O'Halloran (2):
      powerpc/lib: Implement PMEM API
      powerpc/lib: Implement UACCESS_FLUSHCACHE API

Paul Mackerras (1):
      Revert "KVM: PPC: Book3S HV: POWER9 does not require secondary thread management"

Sandipan Das (4):
      powerpc/lib/sstep: Add XER bits introduced in POWER ISA v3.0
      powerpc/lib/sstep: Fix fixed-point arithmetic instructions that set CA32
      powerpc/lib/sstep: Fix fixed-point shift instructions that set CA32
      bpf: take advantage of stack_depth tracking in powerpc JIT

Seth Forshee (2):
      powerpc: Always initialize input array when calling epapr_hypercall()
      selftests/powerpc: Use snprintf to construct DSCR sysfs interface paths

Shriya (1):
      powerpc/powernv/cpufreq: Fix the frequency read by /proc/cpuinfo

Stephen Rothwell (1):
      powerpc/64s: ppc_save_regs is now needed for all 64s builds

Stewart Smith (1):
      powernv/opal-sensor: remove not needed lock

Sukadev Bhattiprolu (16):
      powerpc/vas: init missing fields from [rt]xattr
      powerpc/vas: Validate window credits
      powerpc/vas: Cleanup some debug code
      powerpc/vas: Drop poll_window_cast_out().
      powerpc/vas: Use helper to unpin/close window
      powerpc/vas: Reduce polling interval for busy state
      powerpc/vas: Save configured window credits
      powerpc/vas: poll for return of window credits
      powerpc/vas: Create cpu to vas id mapping
      powerpc/vas, nx-842: Define and use chip_to_vas_id()
      powerpc/vas: Export HVWC to debugfs
      powerpc: Add support for setting SPRN_TIDR
      powerpc: Define set_thread_uses_vas()
      powerpc/vas: Define vas_win_paste_addr()
      powerpc/vas: Define vas_win_id()
      powerpc/vas: Add support for user receive window

Tyrel Datwyler (1):
      powerpc/pseries/vio: Dispose of virq mapping on vdevice unregister

Vaibhav Jain (5):
      cxl: Set the valid bit in PE for dedicated mode
      cxl: Rename register PSL9_FIR2 to PSL9_FIR_MASK
      cxl: Dump PSL_FIR register on PSL9 error irq
      cxl: Provide debugfs access to PSL_DEBUG/XSL_DEBUG registers
      cxl: Rework the implementation of cxl_stop_trace_psl9()

Vaidyanathan Srinivasan (1):
      powerpc/powernv/idle: Round up latency and residency values

William A. Kennington III (1):
      powerpc/opal: Fix EBUSY bug in acquiring tokens

 Documentation/admin-guide/kernel-parameters.txt    |   4 +
 arch/powerpc/Kconfig                               |   8 +-
 arch/powerpc/Kconfig.debug                         |   6 +
 arch/powerpc/boot/dts/acadia.dts                   |   2 +-
 arch/powerpc/configs/powernv_defconfig             |   2 +
 arch/powerpc/configs/pseries_defconfig             |   1 +
 arch/powerpc/configs/skiroot_defconfig             | 232 +++++++++++++
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |   2 +-
 arch/powerpc/include/asm/book3s/64/mmu.h           |   2 +-
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  22 ++
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   3 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  15 +
 arch/powerpc/include/asm/cputable.h                |  12 +-
 arch/powerpc/include/asm/eeh.h                     |  10 +-
 arch/powerpc/include/asm/emulated_ops.h            |   4 +
 arch/powerpc/include/asm/epapr_hcalls.h            |  12 +-
 arch/powerpc/include/asm/exception-64s.h           |   5 +
 arch/powerpc/include/asm/hugetlb.h                 |   6 -
 arch/powerpc/include/asm/hw_irq.h                  |   1 +
 arch/powerpc/include/asm/kprobes.h                 |   2 +-
 arch/powerpc/include/asm/kvm_book3s_asm.h          |   4 -
 arch/powerpc/include/asm/mce.h                     |   4 +-
 arch/powerpc/include/asm/mmu_context.h             |  50 +++
 arch/powerpc/include/asm/nohash/64/pgtable.h       |   2 +-
 arch/powerpc/include/asm/opal-api.h                |   3 +
 arch/powerpc/include/asm/opal.h                    |   6 +-
 arch/powerpc/include/asm/paca.h                    |  13 +-
 arch/powerpc/include/asm/page_64.h                 |   6 +-
 arch/powerpc/include/asm/pci-bridge.h              |   1 +
 arch/powerpc/include/asm/pgtable-be-types.h        |   2 +-
 arch/powerpc/include/asm/pgtable-types.h           |   4 +-
 arch/powerpc/include/asm/powernv.h                 |   4 +
 arch/powerpc/include/asm/ppc_asm.h                 |  27 +-
 arch/powerpc/include/asm/processor.h               |   3 +
 arch/powerpc/include/asm/string.h                  |   2 +
 arch/powerpc/include/asm/switch_to.h               |   5 +
 arch/powerpc/include/asm/tlbflush.h                |   2 +-
 arch/powerpc/include/asm/tm.h                      |   7 +-
 arch/powerpc/include/asm/topology.h                |   8 +
 arch/powerpc/include/asm/uaccess.h                 |  22 ++
 arch/powerpc/include/asm/vas.h                     |  21 ++
 arch/powerpc/include/uapi/asm/cputable.h           |   1 +
 arch/powerpc/kernel/Makefile                       |   2 +-
 arch/powerpc/kernel/asm-offsets.c                  |   6 +-
 arch/powerpc/kernel/cputable.c                     |  24 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |   4 +-
 arch/powerpc/kernel/eeh.c                          |  46 +--
 arch/powerpc/kernel/eeh_driver.c                   |   2 +-
 arch/powerpc/kernel/eeh_pe.c                       |   8 +-
 arch/powerpc/kernel/entry_64.S                     |   4 +-
 arch/powerpc/kernel/exceptions-64s.S               |  49 ++-
 arch/powerpc/kernel/fadump.c                       |  17 +-
 arch/powerpc/kernel/head_32.S                      |   2 +-
 arch/powerpc/kernel/head_64.S                      |  16 +-
 arch/powerpc/kernel/idle_book3s.S                  |  70 ++--
 arch/powerpc/kernel/irq.c                          |  51 ++-
 arch/powerpc/kernel/kprobes-ftrace.c               |  34 +-
 arch/powerpc/kernel/kprobes.c                      |  92 +++--
 arch/powerpc/kernel/machine_kexec_64.c             |   4 +-
 arch/powerpc/kernel/mce.c                          | 147 +++++---
 arch/powerpc/kernel/mce_power.c                    | 115 ++++++-
 arch/powerpc/kernel/module_64.c                    |   3 +-
 arch/powerpc/kernel/optprobes.c                    |  15 +-
 arch/powerpc/kernel/paca.c                         |  16 +-
 arch/powerpc/kernel/pci_64.c                       |   4 +-
 arch/powerpc/kernel/process.c                      | 225 +++++++++++--
 arch/powerpc/kernel/prom.c                         |  37 +-
 arch/powerpc/kernel/setup-common.c                 |   7 +-
 arch/powerpc/kernel/setup.h                        |   6 +
 arch/powerpc/kernel/setup_64.c                     |  19 +-
 arch/powerpc/kernel/signal.c                       |   2 +-
 arch/powerpc/kernel/signal_32.c                    |   6 +-
 arch/powerpc/kernel/signal_64.c                    |   7 +-
 arch/powerpc/kernel/sysfs.c                        |  11 +
 arch/powerpc/kernel/tau_6xx.c                      |   3 +-
 arch/powerpc/kernel/tm.S                           |  59 +---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S     |   4 +-
 arch/powerpc/kernel/traps.c                        | 256 +++++++++++---
 arch/powerpc/kernel/watchdog.c                     |  29 +-
 arch/powerpc/kvm/book3s_hv.c                       |  20 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   8 -
 arch/powerpc/kvm/powerpc.c                         |   3 +-
 arch/powerpc/lib/Makefile                          |   2 +-
 arch/powerpc/lib/pmem.c                            |  67 ++++
 arch/powerpc/lib/sstep.c                           |  20 ++
 arch/powerpc/mm/Makefile                           |   6 +-
 arch/powerpc/mm/dump_hashpagetable.c               |   2 +-
 arch/powerpc/mm/dump_linuxpagetables.c             |  10 +-
 arch/powerpc/mm/hash_utils_64.c                    |   1 +
 arch/powerpc/mm/hugetlbpage-radix.c                |  20 +-
 arch/powerpc/mm/init_64.c                          |  21 +-
 arch/powerpc/mm/mmap.c                             |  49 +--
 arch/powerpc/mm/mmu_context.c                      |   9 -
 arch/powerpc/mm/mmu_context_book3s64.c             |  33 +-
 arch/powerpc/mm/numa.c                             |  63 +++-
 arch/powerpc/mm/pgtable-radix.c                    |  10 +
 arch/powerpc/mm/pgtable_64.c                       |   2 +-
 arch/powerpc/mm/slb_low.S                          |   6 +-
 arch/powerpc/mm/slice.c                            |  62 ++--
 arch/powerpc/mm/tlb-radix.c                        | 347 +++++++++++++------
 arch/powerpc/net/bpf_jit64.h                       |   7 +-
 arch/powerpc/net/bpf_jit_comp64.c                  |  16 +-
 arch/powerpc/oprofile/op_model_cell.c              |   8 +-
 arch/powerpc/perf/hv-24x7.c                        |   2 +-
 arch/powerpc/platforms/Kconfig.cputype             |  19 +-
 arch/powerpc/platforms/powermac/low_i2c.c          |   4 +-
 arch/powerpc/platforms/powernv/Makefile            |   3 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |  42 +--
 arch/powerpc/platforms/powernv/npu-dma.c           |  28 +-
 arch/powerpc/platforms/powernv/opal-async.c        | 180 +++++++---
 arch/powerpc/platforms/powernv/opal-hmi.c          |   2 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c      |   8 +-
 .../powerpc/platforms/powernv/opal-memory-errors.c |   2 +-
 arch/powerpc/platforms/powernv/opal-sensor.c       |  17 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   5 +-
 arch/powerpc/platforms/powernv/opal.c              |   2 +
 arch/powerpc/platforms/powernv/pci-ioda.c          |  29 +-
 arch/powerpc/platforms/powernv/pci.h               |   4 +
 arch/powerpc/platforms/powernv/setup.c             |  26 +-
 arch/powerpc/platforms/powernv/smp.c               |  59 ++++
 arch/powerpc/platforms/powernv/vas-debug.c         | 209 ++++++++++++
 arch/powerpc/platforms/powernv/vas-window.c        | 242 +++++++++++---
 arch/powerpc/platforms/powernv/vas.c               |  31 +-
 arch/powerpc/platforms/powernv/vas.h               |  93 +++---
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   2 +
 arch/powerpc/platforms/pseries/iommu.c             |  19 +-
 arch/powerpc/platforms/pseries/lpar.c              |   8 +-
 arch/powerpc/platforms/pseries/lparcfg.c           |   2 +-
 arch/powerpc/platforms/pseries/vio.c               |   2 +
 arch/powerpc/sysdev/axonram.c                      |   2 +-
 arch/powerpc/sysdev/ipic.c                         |   4 +-
 arch/powerpc/xmon/xmon.c                           | 169 +++++++++-
 drivers/cpuidle/cpuidle-powernv.c                  |   4 +-
 drivers/crypto/nx/nx-842-powernv.c                 | 167 ++++------
 drivers/crypto/nx/nx-842.c                         |   2 +-
 drivers/misc/cxl/api.c                             |  16 +-
 drivers/misc/cxl/context.c                         |   3 +
 drivers/misc/cxl/cxl.h                             |  22 +-
 drivers/misc/cxl/debugfs.c                         |  29 +-
 drivers/misc/cxl/fault.c                           |  15 +-
 drivers/misc/cxl/file.c                            |  24 +-
 drivers/misc/cxl/native.c                          |  27 +-
 drivers/misc/cxl/pci.c                             |  88 +++--
 drivers/mtd/devices/powernv_flash.c                |  83 +++--
 .../selftests/powerpc/benchmarks/context_switch.c  |  17 +-
 .../selftests/powerpc/dscr/dscr_sysfs_test.c       |   6 +-
 tools/testing/selftests/powerpc/tm/.gitignore      |   1 +
 tools/testing/selftests/powerpc/tm/Makefile        |   3 +-
 .../testing/selftests/powerpc/tm/tm-unavailable.c  | 371 +++++++++++++++++++++
 tools/testing/selftests/powerpc/tm/tm.h            |   5 +
 150 files changed, 3696 insertions(+), 1144 deletions(-)
 create mode 100644 arch/powerpc/configs/skiroot_defconfig
 create mode 100644 arch/powerpc/lib/pmem.c
 create mode 100644 arch/powerpc/platforms/powernv/vas-debug.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-unavailable.c

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaDXp7AAoJEFHr6jzI4aWAm2EQALg8aOk0bNTsW06M4D1202NB
I0o2GOJxI3E3nbPivNZTzLlMF05WB/ldQaCeQYYc238KSyCGc4yvEPiJpLMeoiqn
jsn7Z4nOSCwpWg/8hoNshPJFD1IZxXdoSX0IkTPsORZ5Chp1yGshosBychMzqadk
byrIcznCgbozhnDoCCKplX3o5eam5pGL3EQ2hYv9BOtdna7bmAaHJCjo9GdtdowR
Sn4ZXbEvq7/Bxm0NbSEbmsqPzL8t4dt6hI965JpTrHO1eGdM+tO7yBnqGeLwykNv
NecTuNWmkRj/fzUuB7d1pg2tqljC49gppuZDBq+mU8YTsS8Ru3K3BQ3W5rtaBiWt
IsSh+9p7T5hz6NVoZXkKxT5TP/Y/AbEUjKNoRU/V4w4Q1S6+0xF4FIXHs5nyJmQM
oxcNDxd5fTbFd1kHft6LpQOgujVot9FopB5TeRYBGVixr/9oj6fRPsef6LmqYjIr
LrZi17rmlyZXhs8zhcyqU93hmSWiWniFUxvzON/wfrZRIModjVo/7mkJsfWxI2N7
TceDZb7lhe7jAq7LjekrFE6GnJrMYrEFLYldEkjVMCAKS2gKmear6gakK+kujWqi
1ROOvsTU+pP8kzMPTK4sCp0TXjHxut5++TfZTacV6Sy88yPqIAtjHgHw1az6mEe3
v89kWAcxeyGokJMB1CLe
=vkuM
-----END PGP SIGNATURE-----
--=-=-=--
