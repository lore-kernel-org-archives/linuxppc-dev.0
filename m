Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKCF44FldzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 23:20:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, alastair@d-silva.org, alex.williamson@redhat.com,
 alistair@popple.id.au, ananth@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 anton@samba.org, ben@decadent.org.uk, benh@kernel.crashing.org,
 bsingharora@gmail.com, cascardo@canonical.com, christophe.leroy@c-s.fr,
 clombard@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 ego@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com, geert@linux-m68k.org,
 gpiccoli@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 hamish.martin@alliedtelesis.co.nz, hbathini@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, ldufour@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 matthew.brown.dev@gmail.com, me@tobin.cc, mhiramat@kernel.org,
 mikey@neuling.org, mrochs@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com, oohall@gmail.com,
 peterz@infradead.org, rashmica.g@gmail.com, robh@kernel.org,
 ruscur@russell.cc, sukadev@linux.vnet.ibm.com, tyreld@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, vipin@linux.vnet.ibm.com,
 xinhui.pan@linux.vnet.ibm.com, yang.shi@windriver.com,
 pbonzini@redhat.com, paulus@samba.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.12-1 tag
Date: Fri, 05 May 2017 23:20:21 +1000
Message-ID: <87k25vh23u.fsf@concordia.ellerman.id.au>
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

Please pull the first set of powerpc updates for 4.12.

There's one conflict in kernel/kprobes.c, the resolution should look like:

	if (symbol_name) {
		addr = kprobe_lookup_name(symbol_name, offset);
		if (!addr)
			return ERR_PTR(-ENOENT);
	}

Also due to a screw-up on my part, we need a hunk added when you merge
the powerpc tree with the KVM tree:

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 7807ee17af4b..ffe1da95033a 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -24,6 +24,7 @@
 #include <asm/xive.h>
 #include <asm/xive-regs.h>
 #include <asm/debug.h>
+#include <asm/debugfs.h>
 #include <asm/time.h>
 #include <asm/opal.h>


I haven't seen a pull request from Paolo yet, so possibly you'll need
to add that later when you merge the KVM tree.

cheers


The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.12-1

for you to fetch changes up to 700b7eadd5625d22b8235fb21259b3d7d564c000:

  powerpc/64s: Power9 has no LPCR[VRMASD] field so don't set it (2017-05-03 20:45:55 +1000)

----------------------------------------------------------------
powerpc updates for 4.12 part 1.

Highlights include:

 - Larger virtual address space on 64-bit server CPUs. By default we use a 128TB
   virtual address space, but a process can request access to the full 512TB by
   passing a hint to mmap().

 - Support for the new Power9 "XIVE" interrupt controller.

 - TLB flushing optimisations for the radix MMU on Power9.

 - Support for CAPI cards on Power9, using the "Coherent Accelerator Interface
   Architecture 2.0".

 - The ability to configure the mmap randomisation limits at build and runtime.

 - Several small fixes and cleanups to the kprobes code, as well as support for
   KPROBES_ON_FTRACE.

 - Major improvements to handling of system reset interrupts, correctly treating
   them as NMIs, giving them a dedicated stack and using a new hypervisor call
   to trigger them, all of which should aid debugging and robustness.

Many fixes and other minor enhancements.

Thanks to:
  Alastair D'Silva, Alexey Kardashevskiy, Alistair Popple, Andrew Donnellan,
  Aneesh Kumar K.V, Anshuman Khandual, Anton Blanchard, Balbir Singh, Ben
  Hutchings, Benjamin Herrenschmidt, Bhupesh Sharma, Chris Packham, Christian
  Zigotzky, Christophe Leroy, Christophe Lombard, Daniel Axtens, David Gibson,
  Gautham R. Shenoy, Gavin Shan, Geert Uytterhoeven, Guilherme G. Piccoli,
  Hamish Martin, Hari Bathini, Kees Cook, Laurent Dufour, Madhavan Srinivasan,
  Mahesh J Salgaonkar, Mahesh Salgaonkar, Masami Hiramatsu, Matt Brown, Matthew
  R. Ochs, Michael Neuling, Naveen N. Rao, Nicholas Piggin, Oliver O'Halloran,
  Pan Xinhui, Paul Mackerras, Rashmica Gupta, Russell Currey, Sukadev
  Bhattiprolu, Thadeu Lima de Souza Cascardo, Tobin C. Harding, Tyrel Datwyler,
  Uma Krishnan, Vaibhav Jain, Vipin K Parashar, Yang Shi.

----------------------------------------------------------------
Alastair D'Silva (1):
      cxl: Mask slice error interrupts after first occurrence

Alexey Kardashevskiy (10):
      powerpc/powernv: Fix it_ops::get() callback to return in cpu endian
      powerpc/powernv/npu: Remove dead iommu code
      powerpc/mmu: Add real mode support for IOMMU preregistered memory
      powerpc/powernv/iommu: Add real mode version of iommu_table_ops::exchange()
      powerpc/iommu/vfio_spapr_tce: Cleanup iommu_table disposal
      powerpc/vfio_spapr_tce: Add reference counting to iommu_table
      powerpc/iommu: Do not call PageTransHuge() on tail pages
      powerpc/powernv: Check kzalloc() return value in pnv_pci_table_alloc
      powerpc/powernv: Fix iommu table size calculation hook for small tables
      powerpc/pseries: Enable VFIO

Alistair Popple (5):
      drivers/of/base.c: Add of_property_read_u64_index
      powerpc/powernv: Add sanity checks to pnv_pci_get_{gpu|npu}_dev
      powerpc/powernv: Introduce address translation services for Nvlink2
      powerpc/powernv: Require MMU_NOTIFIER to fix NPU build
      powerpc/powernv: Fix TCE kill on NVLink2

Andrew Donnellan (1):
      powerpc/powernv: Document cxl dependency on special case in pnv_eeh_reset()

Aneesh Kumar K.V (32):
      powerpc/mm/nohash: MM_SLICE is only used by book3s 64
      powerpc/mm/slice: Fix off-by-1 error when computing slice mask
      powerpc/mm: Cleanup bits definition between hash and radix.
      powerpc/mm/radix: rename _PAGE_LARGE to R_PAGE_LARGE
      powerpc/mm: Add translation mode information in /proc/cpuinfo
      powerpc/mm/hugetlb: Filter out hugepage size not supported by page table layout
      powerpc/mm: Define _PAGE_SOFT_DIRTY unconditionally
      powerpc/mm: Define all PTE bits based on radix definitions.
      powerpc/mm: Lower the max real address to 53 bits
      powerpc/mm: Move hash specific pte bits to be top bits of RPN
      powerpc/mm/slice: Convert slice_mask high slice to a bitmap
      powerpc/mm/slice: Update the function prototype
      powerpc/mm: Move copy_mm_to_paca to paca.c
      powerpc/mm: Remove checks that TASK_SIZE_USER64 is too small
      powerpc/mm/slice: Move slice_mask struct definition to slice.c
      powerpc/mm/slice: Update slice mask printing to use bitmap printing.
      powerpc/mm/hash: Use context ids 1-4 for the kernel
      powerpc/mm/hash: Support 68 bit VA
      powerpc/mm/hash: Convert mask to unsigned long
      powerpc/mm/hash: Increase VA range to 128TB
      powerpc/mm: Add addr_limit to mm_context and use it to derive max slice index
      powerpc/mm/hash: Store addr_limit in PACA
      powerpc/pseries: Skip using reserved virtual address range
      powerpc/mm: Switch some TASK_SIZE checks to use mm_context addr_limit
      powerpc/mm: Enable mappings above 128TB
      powerpc/mm/radix: Don't do page walk cache flush when doing full mm flush
      powerpc/mm/radix: Remove unnecessary ptesync
      powerpc/mm/hash: Don't open code VMALLOC_INDEX
      powerpc/mm/radix: Use mm->task_size for boundary checking instead of addr_limit
      powerpc/mmap: Any hint > 128TB searches the full VA space
      powerpc/mm/radix: Optimise Page Walk Cache flush
      powerpc/mm/radix: Optimise tlbiel flush all case

Anshuman Khandual (2):
      powerpc/mm: Remove reduntant initmem information from log
      powerpc/hugetlb: Add ABI defines for supported HugeTLB page sizes

Anton Blanchard (4):
      powerpc/configs: Re-enable ISO9660_FS as a built-in in 64 bit configs
      powerpc/configs: Make oprofile a module
      powerpc/configs: Re-enable POWER8 crc32c
      powerpc: Avoid taking a data miss on every userspace instruction miss

Balbir Singh (1):
      powerpc/tracing: Allow tracing of mmap syscalls

Ben Hutchings (2):
      powerpc/32: Remove Mac-on-Linux/rtlinux hooks
      powerpc: Fix missing CRCs, add more asm-prototypes.h declarations

Benjamin Herrenschmidt (10):
      powerpc/powernv: Add XIVE related definitions to opal-api.h
      powerpc: Add more PPC bit conversion macros
      powerpc: Add optional smp_ops->prepare_cpu SMP callback
      powerpc/smp: Remove migrate_irq() custom implementation
      powerpc/xive: Native exploitation of the XIVE interrupt controller
      powerpc/kvm: Massage order of #include
      powerpc/kvm: Make kvmppc_xics_create_icp static
      powerpc/kvm: Remove obsolete kvm_vm_ioctl_xics_irq declaration
      powerpc: Consolidate variants of real-mode MMIOs
      powerpc: Fixup LPCR:PECE and HEIC setting on POWER9

Christophe Leroy (4):
      powerpc/mm: Fix page table dump build on PPC32
      powerpc/mm: Fix missing page attributes in page table dump
      powerpc/mm: On PPC32, display 32 bits addresses in page table dump
      powerpc/mm: Rename table dump file name

Christophe Lombard (7):
      cxl: Read vsec perst load image
      cxl: Remove unused values in bare-metal environment.
      cxl: Keep track of mm struct associated with a context
      cxl: Update implementation service layer
      cxl: Rename some psl8 specific functions
      cxl: Isolate few psl8 specific calls
      cxl: Add psl9 specific code

David Gibson (1):
      powerpc/mm: Ensure IRQs are off in switch_mm()

Gautham R. Shenoy (4):
      powerpc/powernv: Move CPU-Offline idle state invocation from smp.c to idle.c
      powerpc/powernv/smp: Add busy-wait loop as fall back for CPU-Hotplug
      powerpc/powernv/idle: Don't override default/deepest directly in kernel
      powerpc/powernv: Recover correct PACA on wakeup from a stop on P9 DD1

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for powerpc device tree bindings

Guilherme G. Piccoli (2):
      powerpc/xmon: drop the nobt option from xmon plus minor fixes
      powerpc/xmon: add debugfs entry for xmon

Hamish Martin (2):
      powerpc: Move THREAD_SHIFT config to Kconfig
      powerpc/64: Allow for THREAD_SIZE > 16k

Hari Bathini (2):
      powerpc/fadump: Reserve memory at an offset closer to bottom of RAM
      powerpc/fadump: Update fadump documentation

Laurent Dufour (3):
      powerpc/mm: Move mmap_sem unlock up from do_sigbus
      powerpc/mm: Handle VM_FAULT_RETRY earlier
      powerpc/mm: Move mmap_sem unlocking in do_page_fault()

Madhavan Srinivasan (5):
      powerpc/perf: Export memory hierarchy info to user space
      powerpc/perf: Support to export MMCRA[TEC*] field to userspace
      powerpc/perf: Support to export SIERs bit in Power8
      powerpc/perf: Support to export SIERs bit in Power9
      powerpc/perf: Add Power8 mem_access event to sysfs

Mahesh Salgaonkar (2):
      powerpc/book3s: Print the kernel function name in machine check
      powerpc/book3s/mce: Move add_taint() later in virtual mode

Masami Hiramatsu (1):
      kprobes: Skip preparing optprobe if the probe is ftrace-based

Matt Brown (1):
      powerpc/powernv: Add OPAL exports attributes to sysfs

Matthew R. Ochs (1):
      cxl: Enable PCI device IDs for future IBM CXL adapters

Michael Ellerman (32):
      selftests/powerpc: Refactor the AUXV routines
      selftests/powerpc: Add cache_shape sniff test
      drivers/pcmcia: NO_IRQ removal for electra_cf.c
      powerpc/64: Don't use early_cpu_has_feature() in cpu_ready_for_interrupts()
      powerpc/mm/hash: Abstract context id allocation for KVM
      powerpc/mm/hash: Pull hash constants into hash__alloc_context_id()
      powerpc/mm: Split radix vs hash mm context initialisation
      powerpc/mm/hash: Check for non-kernel address in get_kernel_vsid()
      powerpc/book3s: Print task info if we take a machine check in user mode
      powerpc: Create asm/debugfs.h and move powerpc_debugfs_root there
      powerpc: Remove unnecessary includes of asm/debug.h
      powerpc/nohash: Fix use of mmu_has_feature() in setup_initial_memory_limit()
      powerpc: Make sparsemem the default on 64-bit Book3S
      Merge branch 'topic/xive' (early part) into next
      powerpc/mm: Fix swapper_pg_dir size on 64-bit hash w/64K pages
      powerpc: Drop include of linux/io.h from asm/io.h
      powerpc: Allow platforms to force-enable CONFIG_SMP
      powerpc/powernv: Always enable SMP when building powernv
      powerpc/pseries: Always enable SMP when building pseries
      powerpc/xive: Fix missing check of rc != OPAL_BUSY
      powerpc/mm: Add support for runtime configuration of ASLR limits
      Merge branch 'topic/kprobes' into next
      powerpc/xmon: Deindent the SLB dumping logic
      powerpc/mm: Fix possible out-of-bounds shift in arch_mmap_rnd()
      powerpc/powernv: Fix missing attr initialisation in opal_export_attrs()
      powerpc/powernv: Fix oops on P9 DD1 in cause_ipi()
      Merge branch 'topic/ppc-kvm' into next
      powerpc/mm/hash: Fix off-by-one in comment about kernel contexts ids
      powerpc/mpc52xx: Don't select user-visible RTAS_PROC
      powerpc/smp: Document irq enable/disable after migrating IRQs
      powerpc/sysfs: Move #ifdef CONFIG_HOTPLUG_CPU out of the function body
      powerpc/mm/radix: Drop support for CPUs without lockless tlbie

Michael Neuling (2):
      powerpc/powernv: Fix XSCOM address mangling for form 1 indirect
      powerpc/xmon: Teach xmon oops about radix vectors

Naveen N. Rao (16):
      kprobes: Convert kprobe_lookup_name() to a function
      powerpc/kprobes: Fix handling of function offsets on ABIv2
      powerpc/kretprobes: Override default function entry offset
      powerpc/kprobes: Factor out code to emulate instruction into a helper
      powerpc/kprobes: Emulate instructions on kprobe handler re-entry
      powerpc/kprobes: Remove duplicate saving of MSR
      powerpc/ftrace: Move stack setup and teardown code into ftrace_graph_caller()
      powerpc/kprobes: Convert __kprobes to NOKPROBE_SYMBOL()
      powerpc/kprobes: Blacklist exception handlers
      powerpc/kprobes: Blacklist common exception handlers
      powerpc/ftrace: Restore LR from pt_regs
      powerpc/kprobes: Add support for KPROBES_ON_FTRACE
      powerpc: Introduce a new helper to obtain function entry points
      powerpc/kprobes: Prefer ftrace when probing function entry
      powerpc: Split ftrace bits into a separate file
      powerpc/ftrace/64: Split further based on -mprofile-kernel

Nicholas Piggin (42):
      powerpc/64s: Machine check print NIP
      powerpc/64s: Clean up machine check recovery flushing
      powerpc/64s: Move POWER machine check defines into mce_power.c
      powerpc/64s: Data driven machine check evaluation
      powerpc/64s: Data driven machine check handling
      powerpc/64s: POWER8 add missing machine check definitions
      powerpc/64s: Add msgp facility unavailable log string
      powerpc/64s: Add SCV FSCR bit for ISA v3.0
      powerpc: Change the doorbell IPI calling convention
      powerpc: Introduce msgsnd/doorbell barrier primitives
      powerpc/64s: Avoid a branch for ppc_msgsnd
      powerpc/powernv: POWER9 support for msgsnd/doorbell IPI
      powerpc/64s: Revert setting of LPCR[LPES] on POWER9
      powerpc/64s: Minor fix for MCE TLB flush for radix
      powerpc/64s: Remove ICSWX feature from Power9
      powerpc/64s: Remove SAO feature from Power9 DD1
      powerpc/64s: Use relon prolog for EXC_VIRT_OOL_MASKABLE_HV handlers
      powerpc/64s: Remove unnecessary relocation branch from idle handler
      powerpc/64s: Move remaining system reset idle code into idle_book3s.S
      powerpc/64s: Stop using bit in HSPRG0 to test winkle
      powerpc/64s: Use alternative feature patching
      powerpc/64s: Fix POWER9 machine check handler from stop state
      powerpc/64s: Expand core idle state bits
      powerpc/64s: Idle do not hold reservation longer than required
      powerpc/64s: Idle POWER8 avoid full state loss recovery where possible
      powerpc/64s: Simplify POWER9 DD1 idle workaround code
      powerpc/pasemi: Do not process external or decrementer interrupts from sreset
      powerpc/cbe: Do not process external or decremeter interrupts from sreset
      powerpc/64s: Add exception macro that does not enable RI
      powerpc/64s: Exception macro for stack frame and initial register save
      powerpc/64s: Fix system reset vs general interrupt reentrancy
      powerpc/64s: Disallow system reset vs system reset reentrancy
      powerpc/64s: Dedicated system reset interrupt stack
      powerpc: Mark system reset as an NMI with nmi_enter/exit()
      powerpc: Add NMI IPI infrastructure
      powerpc: Add struct smp_ops_t.cause_nmi_ipi operation
      powerpc/pseries: Implement NMI IPI with H_SIGNAL_SYS_RESET
      powerpc/xmon: Wait for secondaries before IPI'ing on system reset
      powerpc: Use the new post-link pass to check relocations
      powerpc: Add arch/powerpc/tools directory
      powerpc/64: Allow CONFIG_RELOCATABLE if COMPILE_TEST
      powerpc/64s: Power9 has no LPCR[VRMASD] field so don't set it

Oliver O'Halloran (5):
      powerpc/powernv: de-deuplicate OPAL call wrappers
      powerpc/mm: Remove stale comment about the DART hole
      powerpc/mm: Fix missing _PAGE_NON_IDEMPOTENT in pgtable dump
      powerpc/mm: Add physical address to Linux page table dump
      powerpc/mm: Wire up ioremap_cache()

Pan Xinhui (1):
      powerpc/xmon: Fix an unexpected xmon on/off state change

Rashmica Gupta (1):
      powerpc/mm: Fix hash table dump when memory is not contiguous

Russell Currey (2):
      powerpc/eeh: Avoid use after free in eeh_handle_special_event()
      powerpc/eeh: Clean up and document event handling functions

Sukadev Bhattiprolu (2):
      powerpc/prom: Increase minimum RMA size to 512MB
      powerpc/perf: Define big-endian version of perf_mem_data_src

Thadeu Lima de Souza Cascardo (1):
      powerpc: Make /proc/self/stack always print the current stack

Tobin C. Harding (3):
      powerpc/pseries: Move struct hcall_stats to hvCall_inst.c
      powerpc/swsusp: Include suspend.h to silence sparse warnings
      powerpc/ftrace: Add prototype for prepare_ftrace_return()

Tyrel Datwyler (2):
      powerpc/pseries: Fix of_node_put() underflow during DLPAR remove
      powerpc/sysfs: Fix reference leak of cpu device_nodes present at boot

Vaibhav Jain (2):
      cxl: Force context lock during EEH flow
      cxl: Route eeh events to all drivers in cxl_pci_error_detected()

Vipin K Parashar (1):
      powerpc/powernv: Handle OPAL_WRONG_STATE in opal_get_sensor_data()

Yang Shi (1):
      powerpc/4xx: Make sam440ep_setup_rtc() init

 .../debug/kprobes-on-ftrace/arch-support.txt       |    2 +-
 Documentation/powerpc/cxl.txt                      |   15 +-
 Documentation/powerpc/firmware-assisted-dump.txt   |   34 +-
 MAINTAINERS                                        |    3 +-
 arch/powerpc/Kconfig                               |   66 +-
 arch/powerpc/Makefile                              |   13 +-
 arch/powerpc/Makefile.postlink                     |   34 +
 arch/powerpc/configs/powernv_defconfig             |    6 +-
 arch/powerpc/configs/ppc64_defconfig               |    6 +-
 arch/powerpc/configs/pseries_defconfig             |    6 +-
 arch/powerpc/include/asm/asm-prototypes.h          |    4 +
 arch/powerpc/include/asm/bitops.h                  |    8 +
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |    2 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |   10 +-
 arch/powerpc/include/asm/book3s/64/hash.h          |   16 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h       |    2 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |  200 +--
 arch/powerpc/include/asm/book3s/64/mmu.h           |    9 +
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   58 +-
 arch/powerpc/include/asm/book3s/64/radix.h         |    8 +-
 arch/powerpc/include/asm/code-patching.h           |   41 +
 arch/powerpc/include/asm/cpuidle.h                 |   33 +-
 arch/powerpc/include/asm/cputable.h                |    5 +-
 arch/powerpc/include/asm/dbell.h                   |   40 +-
 arch/powerpc/include/asm/debug.h                   |    2 -
 arch/powerpc/include/asm/debugfs.h                 |   17 +
 arch/powerpc/include/asm/exception-64s.h           |   87 +-
 arch/powerpc/include/asm/feature-fixups.h          |    3 +
 arch/powerpc/include/asm/head-64.h                 |    1 +
 arch/powerpc/include/asm/hvcall.h                  |   10 -
 arch/powerpc/include/asm/io.h                      |  102 +-
 arch/powerpc/include/asm/iommu.h                   |   12 +-
 arch/powerpc/include/asm/kprobes.h                 |   63 +-
 arch/powerpc/include/asm/kvm_book3s_64.h           |    2 -
 arch/powerpc/include/asm/kvm_book3s_asm.h          |    2 +-
 arch/powerpc/include/asm/kvm_ppc.h                 |   10 +-
 arch/powerpc/include/asm/mce.h                     |   94 +-
 arch/powerpc/include/asm/mmu-book3e.h              |    5 -
 arch/powerpc/include/asm/mmu.h                     |   19 +-
 arch/powerpc/include/asm/mmu_context.h             |   24 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h       |    5 -
 arch/powerpc/include/asm/opal-api.h                |   77 +-
 arch/powerpc/include/asm/opal.h                    |   41 +
 arch/powerpc/include/asm/paca.h                    |   38 +-
 arch/powerpc/include/asm/page_64.h                 |   14 -
 arch/powerpc/include/asm/perf_event_server.h       |    3 +
 arch/powerpc/include/asm/powernv.h                 |   22 +
 arch/powerpc/include/asm/ppc-opcode.h              |    2 +
 arch/powerpc/include/asm/processor.h               |   41 +-
 arch/powerpc/include/asm/reg.h                     |    4 +
 arch/powerpc/include/asm/sections.h                |    2 +
 arch/powerpc/include/asm/smp.h                     |   21 +-
 arch/powerpc/include/asm/syscalls.h                |    4 +-
 arch/powerpc/include/asm/thread_info.h             |   10 +-
 arch/powerpc/include/asm/xics.h                    |    2 +-
 arch/powerpc/include/asm/xive-regs.h               |   97 ++
 arch/powerpc/include/asm/xive.h                    |  163 +++
 arch/powerpc/include/asm/xmon.h                    |    2 +
 arch/powerpc/include/uapi/asm/mman.h               |   16 +
 arch/powerpc/kernel/Makefile                       |   12 +-
 arch/powerpc/kernel/asm-offsets.c                  |    9 +-
 arch/powerpc/kernel/cpu_setup_power.S              |   36 +-
 arch/powerpc/kernel/dbell.c                        |   58 +-
 arch/powerpc/kernel/eeh.c                          |    3 +-
 arch/powerpc/kernel/eeh_driver.c                   |   55 +-
 arch/powerpc/kernel/entry_32.S                     |  107 --
 arch/powerpc/kernel/entry_64.S                     |  380 ------
 arch/powerpc/kernel/exceptions-64s.S               |  186 ++-
 arch/powerpc/kernel/fadump.c                       |   36 +-
 arch/powerpc/kernel/head_32.S                      |   16 +-
 arch/powerpc/kernel/head_64.S                      |    3 +-
 arch/powerpc/kernel/idle_book3s.S                  |  285 ++++-
 arch/powerpc/kernel/iommu.c                        |   54 +-
 arch/powerpc/kernel/irq.c                          |   41 -
 arch/powerpc/kernel/kprobes-ftrace.c               |  104 ++
 arch/powerpc/kernel/kprobes.c                      |  214 +++-
 arch/powerpc/kernel/mce.c                          |   18 +-
 arch/powerpc/kernel/mce_power.c                    |  780 ++++++------
 arch/powerpc/kernel/optprobes.c                    |    6 +-
 arch/powerpc/kernel/paca.c                         |   21 +
 arch/powerpc/kernel/prom.c                         |    1 -
 arch/powerpc/kernel/prom_init.c                    |    2 +-
 arch/powerpc/kernel/setup-common.c                 |   11 +-
 arch/powerpc/kernel/setup_64.c                     |    9 +-
 arch/powerpc/kernel/smp.c                          |  299 ++++-
 arch/powerpc/kernel/stacktrace.c                   |    9 +-
 arch/powerpc/kernel/swsusp.c                       |    1 +
 arch/powerpc/kernel/syscalls.c                     |   16 +-
 arch/powerpc/kernel/sysfs.c                        |   12 +-
 arch/powerpc/kernel/trace/Makefile                 |   29 +
 arch/powerpc/kernel/{ => trace}/ftrace.c           |    1 +
 arch/powerpc/kernel/trace/ftrace_32.S              |  118 ++
 arch/powerpc/kernel/trace/ftrace_64.S              |   85 ++
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S     |  272 ++++
 arch/powerpc/kernel/trace/ftrace_64_pg.S           |   68 +
 arch/powerpc/kernel/{ => trace}/trace_clock.c      |    0
 arch/powerpc/kernel/traps.c                        |   27 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |    2 +
 arch/powerpc/kvm/book3s.c                          |    8 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c              |   10 +-
 arch/powerpc/kvm/book3s_hv.c                       |   18 +-
 arch/powerpc/kvm/book3s_hv_builtin.c               |   29 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c               |    5 +-
 arch/powerpc/kvm/book3s_xics.c                     |    5 +-
 arch/powerpc/lib/code-patching.c                   |    4 +-
 arch/powerpc/lib/sstep.c                           |   82 +-
 arch/powerpc/mm/dump_hashpagetable.c               |    2 +-
 arch/powerpc/mm/dump_linuxpagetables.c             |  106 +-
 arch/powerpc/mm/fault.c                            |   84 +-
 arch/powerpc/mm/hash_low_32.S                      |    2 -
 arch/powerpc/mm/hash_utils_64.c                    |   26 +-
 arch/powerpc/mm/hugetlbpage-book3e.c               |    7 -
 arch/powerpc/mm/hugetlbpage-radix.c                |   11 +-
 arch/powerpc/mm/hugetlbpage.c                      |   18 +
 arch/powerpc/mm/init_64.c                          |    4 -
 arch/powerpc/mm/mmap.c                             |   53 +-
 arch/powerpc/mm/mmu_context_book3s64.c             |  116 +-
 arch/powerpc/mm/mmu_context_iommu.c                |   43 +-
 arch/powerpc/mm/mmu_context_nohash.c               |    5 -
 arch/powerpc/mm/numa.c                             |    7 -
 arch/powerpc/mm/slb.c                              |    4 +-
 arch/powerpc/mm/slb_low.S                          |   82 +-
 arch/powerpc/mm/slice.c                            |  258 ++--
 arch/powerpc/mm/subpage-prot.c                     |    3 +-
 arch/powerpc/mm/tlb-radix.c                        |   93 +-
 arch/powerpc/mm/tlb_nohash.c                       |    2 +-
 arch/powerpc/perf/core-book3s.c                    |    8 +
 arch/powerpc/perf/isa207-common.c                  |   82 ++
 arch/powerpc/perf/isa207-common.h                  |   26 +-
 arch/powerpc/perf/power8-events-list.h             |    6 +
 arch/powerpc/perf/power8-pmu.c                     |    4 +
 arch/powerpc/perf/power9-pmu.c                     |    2 +
 arch/powerpc/platforms/44x/sam440ep.c              |    2 +-
 arch/powerpc/platforms/52xx/Kconfig                |    1 -
 arch/powerpc/platforms/85xx/smp.c                  |   12 +-
 arch/powerpc/platforms/86xx/mpc86xx_smp.c          |    1 +
 arch/powerpc/platforms/Kconfig.cputype             |   14 +-
 arch/powerpc/platforms/cell/axon_msi.c             |    2 +-
 arch/powerpc/platforms/cell/interrupt.c            |    2 +-
 arch/powerpc/platforms/cell/pervasive.c            |   11 +-
 arch/powerpc/platforms/chrp/smp.c                  |    1 +
 arch/powerpc/platforms/pasemi/idle.c               |   11 +-
 arch/powerpc/platforms/powermac/smp.c              |    3 +-
 arch/powerpc/platforms/powernv/Kconfig             |    3 +
 arch/powerpc/platforms/powernv/eeh-powernv.c       |    7 +
 arch/powerpc/platforms/powernv/idle.c              |  109 +-
 arch/powerpc/platforms/powernv/npu-dma.c           |  470 ++++++-
 arch/powerpc/platforms/powernv/opal-lpc.c          |    3 +-
 arch/powerpc/platforms/powernv/opal-sensor.c       |    4 +
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   71 +-
 arch/powerpc/platforms/powernv/opal-xscom.c        |   27 +-
 arch/powerpc/platforms/powernv/opal.c              |   79 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |   71 +-
 arch/powerpc/platforms/powernv/pci.c               |    6 +-
 arch/powerpc/platforms/powernv/pci.h               |   17 +-
 arch/powerpc/platforms/powernv/powernv.h           |    2 -
 arch/powerpc/platforms/powernv/rng.c               |    2 +-
 arch/powerpc/platforms/powernv/setup.c             |   19 +-
 arch/powerpc/platforms/powernv/smp.c               |  107 +-
 arch/powerpc/platforms/ps3/smp.c                   |    4 +-
 arch/powerpc/platforms/pseries/Kconfig             |    3 +-
 arch/powerpc/platforms/pseries/dlpar.c             |    1 -
 arch/powerpc/platforms/pseries/dtl.c               |    3 +-
 arch/powerpc/platforms/pseries/hvCall_inst.c       |   10 +
 arch/powerpc/platforms/pseries/iommu.c             |   43 +-
 arch/powerpc/platforms/pseries/lpar.c              |   61 +
 arch/powerpc/platforms/pseries/ras.c               |    4 +
 arch/powerpc/platforms/pseries/setup.c             |    4 +
 arch/powerpc/platforms/pseries/smp.c               |   49 +-
 arch/powerpc/platforms/pseries/vio.c               |    2 +-
 arch/powerpc/sysdev/Kconfig                        |    1 +
 arch/powerpc/sysdev/Makefile                       |    1 +
 arch/powerpc/sysdev/scom.c                         |    3 +-
 arch/powerpc/sysdev/xics/icp-hv.c                  |    2 +-
 arch/powerpc/sysdev/xics/icp-native.c              |   20 +-
 arch/powerpc/sysdev/xics/icp-opal.c                |    2 +-
 arch/powerpc/sysdev/xics/xics-common.c             |    6 +-
 arch/powerpc/sysdev/xive/Kconfig                   |   11 +
 arch/powerpc/sysdev/xive/Makefile                  |    4 +
 arch/powerpc/sysdev/xive/common.c                  | 1302 ++++++++++++++++++++
 arch/powerpc/sysdev/xive/native.c                  |  640 ++++++++++
 arch/powerpc/sysdev/xive/xive-internal.h           |   62 +
 .../gcc-check-mprofile-kernel.sh                   |    0
 arch/powerpc/{ => tools}/relocs_check.sh           |    0
 arch/powerpc/xmon/xmon.c                           |  241 +++-
 drivers/misc/cxl/api.c                             |   17 +-
 drivers/misc/cxl/context.c                         |   68 +-
 drivers/misc/cxl/cxl.h                             |  263 +++-
 drivers/misc/cxl/debugfs.c                         |   41 +-
 drivers/misc/cxl/fault.c                           |  136 +-
 drivers/misc/cxl/file.c                            |   15 +-
 drivers/misc/cxl/guest.c                           |   10 +-
 drivers/misc/cxl/hcalls.c                          |    6 +-
 drivers/misc/cxl/irq.c                             |   53 +-
 drivers/misc/cxl/main.c                            |   12 +-
 drivers/misc/cxl/native.c                          |  339 ++++-
 drivers/misc/cxl/pci.c                             |  409 +++++-
 drivers/misc/cxl/trace.h                           |   43 +
 drivers/of/base.c                                  |   31 +
 drivers/pcmcia/electra_cf.c                        |    4 +-
 drivers/vfio/vfio_iommu_spapr_tce.c                |    2 +-
 include/linux/kprobes.h                            |    1 +
 include/linux/of.h                                 |    3 +
 include/uapi/linux/perf_event.h                    |   16 +
 kernel/kprobes.c                                   |   32 +-
 tools/include/uapi/linux/perf_event.h              |   16 +
 tools/testing/selftests/powerpc/Makefile           |    1 +
 .../selftests/powerpc/cache_shape/.gitignore       |    1 +
 .../testing/selftests/powerpc/cache_shape/Makefile |   10 +
 .../selftests/powerpc/cache_shape/cache_shape.c    |  125 ++
 tools/testing/selftests/powerpc/include/utils.h    |    6 +-
 tools/testing/selftests/powerpc/utils.c            |   53 +-
 212 files changed, 8698 insertions(+), 2790 deletions(-)
 create mode 100644 arch/powerpc/Makefile.postlink
 create mode 100644 arch/powerpc/include/asm/debugfs.h
 create mode 100644 arch/powerpc/include/asm/xive-regs.h
 create mode 100644 arch/powerpc/include/asm/xive.h
 create mode 100644 arch/powerpc/kernel/kprobes-ftrace.c
 create mode 100644 arch/powerpc/kernel/trace/Makefile
 rename arch/powerpc/kernel/{ => trace}/ftrace.c (99%)
 create mode 100644 arch/powerpc/kernel/trace/ftrace_32.S
 create mode 100644 arch/powerpc/kernel/trace/ftrace_64.S
 create mode 100644 arch/powerpc/kernel/trace/ftrace_64_mprofile.S
 create mode 100644 arch/powerpc/kernel/trace/ftrace_64_pg.S
 rename arch/powerpc/kernel/{ => trace}/trace_clock.c (100%)
 create mode 100644 arch/powerpc/sysdev/xive/Kconfig
 create mode 100644 arch/powerpc/sysdev/xive/Makefile
 create mode 100644 arch/powerpc/sysdev/xive/common.c
 create mode 100644 arch/powerpc/sysdev/xive/native.c
 create mode 100644 arch/powerpc/sysdev/xive/xive-internal.h
 rename arch/powerpc/{scripts => tools}/gcc-check-mprofile-kernel.sh (100%)
 rename arch/powerpc/{ => tools}/relocs_check.sh (100%)
 create mode 100644 tools/testing/selftests/powerpc/cache_shape/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/cache_shape/Makefile
 create mode 100644 tools/testing/selftests/powerpc/cache_shape/cache_shape.c

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZDHwWAAoJEFHr6jzI4aWAfjMP/2gurBjhaxt50ofbTt63aAqx
rD+U7nwNaJGHFleg8peDgFWETAQKbr7C+vjupebi6nvlpKjeoUX5R+zUwiS9lVik
rjUhCczQYL5lUwLrjUZDK0jrgMX9PkUZEryDTtuzGVIWGJfsTMxg3tpQcRWeN7Qs
o+VRQUWm++THCU9KIBZNfoFbpeoSBq57cxMpH04Jmkn3wY5Gmot1EBFXBI5ZAJq3
ZrnBgCAZ1xpZRZ3ZmyMz5UME0gC6DYQlEgFhLyvZmI1nhSQAoOUY6cEG2bBnBuvY
lzhPxfc7dRlgUI7HkWcOmssSmmZsMRzLgBg6QHhjHTHHr+fs6gnuhG1tEH6VTkbK
MwZi7M+ExeHgp+NAiz6hq601pHk4Z8635O2Y2V7ljZhxMOASXaa4VLpL31gHi5fL
71Hv+Wsw1mFZ6mTHtg3yLFXU4MkJejovxu8Pu3RDZJ0lcYO5rB/sU2ama0zmZMYj
Y3vjOgJYvQD3/LoMnSsD845xr71A8t7TVzlTCo153sR7NZmpr5/hS/KHJwHH/k19
mt7szBTyV3NC2BQTLZT1U3pn7TFMYz7JzOzMVHV7b486YH4Ei0J3yaNe/VmVKvov
YPh4w5kYETxZzeNyxNvf9zEOFvvg0/FYNj/NMcJjdvXvhEITU/C2oWI5XZJh6HuA
JvpeR5OcJt7K6J/j10Ep
=Cs70
-----END PGP SIGNATURE-----
--=-=-=--
