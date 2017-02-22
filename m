Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSvyG22SXzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 22:19:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alistair@popple.id.au, andrew.donnellan@au1.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, anton@samba.org,
 arbab@linux.vnet.ibm.com, ast@kernel.org, benh@kernel.crashing.org,
 bsingharora@gmail.com, chris.packham@alliedtelesis.co.nz, daniel@iogearbox.net,
 david@gibson.dropbear.id.au, dja@axtens.net, ego@linux.vnet.ibm.com,
 elfring@users.sourceforge.net, fbarrat@linux.vnet.ibm.com,
 fthain@telegraphics.com.au, geert@linux-m68k.org, groug@kaod.org,
 gwshan@linux.vnet.ibm.com, imunsie@au1.ibm.com, jallen@linux.vnet.ibm.com,
 joel@jms.id.au, keescook@chromium.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org, mikey@neuling.org,
 naveen.n.rao@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com, npiggin@gmail.com,
 paulus@ozlabs.org, rafael.j.wysocki@intel.com,
 ravi.bangoria@linux.vnet.ibm.com, robh@kernel.org, shailendras@nvidia.com,
 vaibhav@linux.vnet.ibm.com, weiyongjun1@huawei.com, pbon
 zini@redhat.com, rkrcmar@redhat.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.11-1 tag
Date: Wed, 22 Feb 2017 22:18:59 +1100
Message-ID: <8737f6lbh8.fsf@concordia.ellerman.id.au>
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

Please pull the first set of powerpc updates for 4.11.

I've split it in two because I had a last minute query on one of the
commits in my next branch. This pull includes everything up to but not
including that commit. I'll send you a second pull once that's resolved.

The changes to arch/m68k, kernel/kprobes.c and include/linux/cpuidle.h
were all acked.

The KVM changes are also being merged via the KVM tree.

There's a minor conflict in arch/powerpc/Kconfig, where the resolution
is just to drop the HAVE_CC_STACKPROTECTOR line.

cheers


The following changes since commit 7a308bb3016f57e5be11a677d15b821536419d36:

  Linux 4.10-rc5 (2017-01-22 12:54:15 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.11-1

for you to fetch changes up to 438e69b52be776c035aa2a851ccc1709033d729b:

  powerpc/mm/radix: Skip ptesync in pte update helpers (2017-02-15 20:02:41 +1100)

----------------------------------------------------------------
powerpc updates for 4.11 part 1.

Highlights include:

 - Support for direct mapped LPC on POWER9, giving Linux direct access to
   devices that may be on there such as a UART.

 - Memory hotplug support for the Power9 Radix MMU.

 - Add new AUX vectors describing the processor's cache geometry, to be used by
   glibc.

 - The ability for a guest to ask the hypervisor to resize the guest's hash
   table, and in addition support for doing so automatically when memory is
   hotplugged into/out-of the guest. This allows the hash table to be sized
   based on the current memory usage of the guest, rather than the maximum
   possible memory usage.

 - Implementation of optprobes (kprobe optimisation) for powerpc.

In addition there's the topic branch shared with the KVM tree, which includes
support for guests to use the Radix MMU on Power9.

Thanks to:
  Alistair Popple, Andrew Donnellan, Aneesh Kumar K.V, Anju T, Anton Blanchard,
  Benjamin Herrenschmidt, Chris Packham, Daniel Axtens, Daniel Borkmann, David
  Gibson, Finn Thain, Gautham R. Shenoy, Gavin Shan, Greg Kurz, Joel Stanley,
  John Allen, Madhavan Srinivasan, Mahesh Salgaonkar, Markus Elfring, Michael
  Neuling, Nathan Fontenot, Naveen N. Rao, Nicholas Piggin, Paul Mackerras, Ravi
  Bangoria, Reza Arbab, Shailendra Singh, Vaibhav Jain, Wei Yongjun.

----------------------------------------------------------------
Alistair Popple (2):
      powerpc/powernv: Initialise nest mmu
      powerpc/powernv: Use OPAL call for TCE kill on NVLink2

Andrew Donnellan (5):
      cxl: Prevent read/write to AFU config space while AFU not configured
      cxl: Fix build when CONFIG_DEBUG_FS=n
      gcc-plugins: Fix definition of DISABLE_LATENT_ENTROPY_PLUGIN
      powerpc: Correctly disable latent entropy GCC plugin on prom_init.o
      powerpc: Enable support for GCC plugins

Aneesh Kumar K.V (9):
      powerpc/mm: Remove the debug hugepd_ok check
      powerpc/mm/4k: don't allocate larger pmd page table for 4k
      powerpc/mm: Fixup wrong LPCR_VRMASD value
      powerpc/mm/hash: Properly mask the ESID bits when building proto VSID
      powerpc/mm: Add MMU_FTR_KERNEL_RO to possible feature mask
      powerpc/mm: Update PROTFAULT handling in the page fault path
      powerpc/mm/radix: Update pte update sequence for pte clear case
      powerpc/mm/radix: Use ptep_get_and_clear_full when clearing pte for full mm
      powerpc/mm/radix: Skip ptesync in pte update helpers

Anju T (3):
      powerpc: Add helper to check if offset is within relative branch range
      powerpc/kprobes: Implement Optprobes
      powerpc/kprobes: Optimize kprobe in kretprobe_trampoline()

Anton Blanchard (3):
      powerpc/64: Move HAVE_CONTEXT_TRACKING from pseries to common Kconfig
      powerpc/64: Add BPF_JIT to powernv and pseries defconfigs
      powerpc/ftrace: Fix confusing help text for DISABLE_MPROFILE_KERNEL

Benjamin Herrenschmidt (15):
      powerpc: Move isa bridge definitions to separate include
      powerpc: Add support for non-PCI ISA bridges
      powerpc/powernv: Add support for direct mapped LPC on POWER9
      powerpc: Move ARCH_DLINFO out of uapi
      powerpc: Move {d,i,u}cache_bsize definitions to a common place
      powerpc: Remove obsolete comment about patching instructions
      powerpc/64: Fix naming of cache block vs. cache line
      powerpc/64: Retrieve number of L1 cache sets from device-tree
      powerpc/64: Clean up ppc64_caches using a struct per cache
      powerpc/64: Add L2 and L3 cache shape info
      powerpc/64: Hard code cache geometry on POWER8
      powerpc: Add new cache geometry aux vectors
      powerpc/powernv: Remove separate entry for OPAL real mode calls
      powerpc/opal-irqchip: Use interrupt names if present
      powerpc/opal-lpc: Remove unneeded include

Chris Packham (1):
      Documentation: powerpc/fsl: Update compatible for l2cache binding

Daniel Axtens (3):
      powerpc/sparse: Constify the address pointer in __get_user_check()
      powerpc/sparse: Constify the address pointer in __get_user_nocheck()
      powerpc/sparse: Constify the address pointer in __get_user_nosleep()

Daniel Borkmann (1):
      powerpc/bpf: Remove redundant check for non-null image

David Gibson (4):
      powerpc/pseries: Add hypercall wrappers for hash page table resizing
      powerpc/pseries: Add support for hash table resizing
      powerpc/pseries: Advertise HPT resizing support via CAS
      powerpc/pseries: Automatically resize HPT for memory hot add/remove

Finn Thain (10):
      via-cuda: Cleanup printk calls
      via-cuda: Remove redundant temporary variable
      via-cuda: Add TREQ, TIP and TACK signal helpers
      via-cuda: Prevent read buffer overflow
      via-cuda: Fix re-initialization of reply_ptr and reading_reply
      via-cuda: Avoid TREQ race condition
      via-cuda: Use spinlock_irq_save/restore instead of enable/disable_irq
      via-cuda: Initialize data_index early and increment consistently
      via-cuda: Add support for Egret system controller
      m68k/mac: Replace via-maciisi driver with via-cuda driver

Gautham R. Shenoy (5):
      powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
      powernv:stop: Rename pnv_arch300_idle_init to pnv_power9_idle_init
      cpuidle:powernv: Add helper function to populate powernv idle states.
      powernv: Pass PSSCR value and mask to power9_idle_stop
      Documentation:powerpc: Add device-tree bindings for power-mgt

Gavin Shan (3):
      powerpc/kernel: Remove nested if statements in rtas_initialize()
      powerpc/kernel: Use of_property_read_u32() in rtas_initialize()
      powerpc/kernel: Fix unbalanced refcount on RTAS device node

Greg Kurz (1):
      cxl: Drop unused header asm/pnv-pci.h

Joel Stanley (1):
      powerpc/powernv: Report size of OPAL memcons log

John Allen (3):
      powerpc/pseries: Make the acquire/release of the drc for memory a seperate step
      powerpc/pseries: Introduce memory hotplug READD operation
      powerpc/pseries: Update affinity for memory and cpus specified in a PRRN event

Madhavan Srinivasan (1):
      powerpc/xmon: Cleanup to use is_kernel_addr macro

Mahesh Salgaonkar (2):
      powerpc/fadump: Fix the race in crash_fadump().
      powerpc/powernv: Display the correct error info for CAPP errors.

Markus Elfring (3):
      powerpc/powernv/pci: Use kmalloc_array() in two functions
      powerpc/sstep: Return directly after a failed address_ok() in emulate_step()
      powerpc/mm: Return directly after a failed __copy_from_user() in sys_subpage_prot()

Michael Ellerman (9):
      powerpc/powernv: Fix section mismatch from opal_lpc_init()
      powerpc/debug: PTDUMP should depend on DEBUG_FS
      powerpc/boot: Update .gitignore
      powerpc: Add a prototype for mcount() so it can be versioned
      powerpc/powernv: Fix opal_exit tracepoint opcode
      powerpc/mm: Fix build break with RADIX=y & HUGETLBFS=n
      powerpc/mm: Fix build break when CMA=n && SPAPR_TCE_IOMMU=y
      Merge branch 'topic/ppc-kvm' into next
      powerpc/mm: Fix build break with BOOK3S_64=n and MEMORY_HOTPLUG=y

Michael Neuling (1):
      powerpc/powernv: Add XHCI and USB storage to defconfig

Nathan Fontenot (1):
      powerpc/pseries: Report DLPAR capabilities

Naveen N. Rao (6):
      powerpc/bpf: Flush the entire JIT buffer
      powerpc/64: Include bpf/bcc related config options in defconfigs
      powerpc/bpf: Introduce __PPC_SH64()
      powerpc/kprobes: Fixes for kprobe_lookup_name() on BE
      kprobes: Introduce weak variant of kprobe_exceptions_notify()
      powerpc/kprobes: Remove kprobe_exceptions_notify()

Nicholas Piggin (6):
      KVM: PPC: Book3S: Change interrupt call to reduce scratch space use on HV
      KVM: PPC: Book3S: Move 64-bit KVM interrupt handler out from alt section
      KVM: PPC: Book3S: 64-bit CONFIG_RELOCATABLE support for interrupts
      powerpc/64s: Tidy up after exception handler rework
      powerpc/64s: Use (start, size) rather than (start, end) for exception handlers
      powerpc/64: CONFIG_RELOCATABLE support for hmi interrupts

Paul Mackerras (22):
      powerpc/64: Fix checksum folding in csum_tcpudp_nofold and ip_fast_csum_nofold
      powerpc/64: Use optimized checksum routines on little-endian
      powerpc/64: Don't try to use radix MMU under a hypervisor
      powerpc/pseries: Fixes for the "ibm,architecture-vec-5" options
      powerpc/64: Enable use of radix MMU under hypervisor on POWER9
      powerpc/64: More definitions for POWER9
      powerpc/64: Export pgtable_cache and pgtable_cache_add for KVM
      powerpc/64: Make type of partition table flush depend on partition type
      powerpc/64: Allow for relocation-on interrupts from guest to host
      KVM: PPC: Book3S HV: Add userspace interfaces for POWER9 MMU
      KVM: PPC: Book3S HV: Set process table for HPT guests on POWER9
      KVM: PPC: Book3S HV: Use ASDR for HPT guests on POWER9
      KVM: PPC: Book3S HV: Add basic infrastructure for radix guests
      KVM: PPC: Book3S HV: Modify guest entry/exit paths to handle radix guests
      KVM: PPC: Book3S HV: Page table construction and page faults for radix guests
      KVM: PPC: Book3S HV: MMU notifier callbacks for radix guests
      KVM: PPC: Book3S HV: Implement dirty page logging for radix guests
      KVM: PPC: Book3S HV: Make HPT-specific hypercalls return error in radix mode
      KVM: PPC: Book3S HV: Invalidate TLB on radix guest vcpu movement
      KVM: PPC: Book3S HV: Allow guest exit path to have MMU on
      KVM: PPC: Book3S HV: Invalidate ERAT on guest entry/exit for POWER9 DD1
      KVM: PPC: Book3S HV: Enable radix guest support

Ravi Bangoria (1):
      powerpc/xmon: Fix data-breakpoint

Reza Arbab (6):
      powerpc/mm: Simplify loop control in parse_numa_properties()
      powerpc/mm: Allow memory hotplug into an offline node
      powerpc/mm: refactor radix physical page mapping
      powerpc/mm: add radix__create_section_mapping()
      powerpc/mm: add radix__remove_section_mapping()
      powerpc/mm: unstub radix__vmemmap_remove_mapping()

Shailendra Singh (1):
      powerpc: Drop GPL from of_node_to_nid() export to match other arches

Vaibhav Jain (1):
      cxl: Force psl data-cache flush during device shutdown

Wei Yongjun (1):
      powerpc/pseries: Fix typo in parameter description

 .../devicetree/bindings/powerpc/fsl/l2cache.txt    |  42 +-
 .../devicetree/bindings/powerpc/opal/power-mgt.txt | 118 ++++
 Documentation/virtual/kvm/api.txt                  |  83 +++
 arch/m68k/include/asm/macintosh.h                  |   2 +-
 arch/m68k/mac/config.c                             |  18 +-
 arch/m68k/mac/misc.c                               |  72 +--
 arch/powerpc/Kconfig                               |   9 +-
 arch/powerpc/Kconfig.debug                         |   3 +-
 arch/powerpc/boot/.gitignore                       |   4 +
 arch/powerpc/configs/powernv_defconfig             |  11 +-
 arch/powerpc/configs/ppc64_defconfig               |   7 +
 arch/powerpc/configs/pseries_defconfig             |   8 +
 arch/powerpc/include/asm/asm-prototypes.h          |   2 +
 arch/powerpc/include/asm/book3s/64/hash.h          |   4 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |   8 +-
 arch/powerpc/include/asm/book3s/64/mmu.h           |  18 +-
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h    |   5 +
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h   |   8 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  17 +
 arch/powerpc/include/asm/book3s/64/radix.h         |  41 +-
 arch/powerpc/include/asm/cache.h                   |  23 +-
 arch/powerpc/include/asm/checksum.h                |  21 +-
 arch/powerpc/include/asm/code-patching.h           |   2 +
 arch/powerpc/include/asm/cpuidle.h                 |  49 +-
 arch/powerpc/include/asm/elf.h                     |  42 ++
 arch/powerpc/include/asm/exception-64s.h           |  83 ++-
 arch/powerpc/include/asm/firmware.h                |   5 +-
 arch/powerpc/include/asm/head-64.h                 | 232 +++----
 arch/powerpc/include/asm/hvcall.h                  |  13 +
 arch/powerpc/include/asm/isa-bridge.h              |  29 +
 arch/powerpc/include/asm/kprobes.h                 |  27 +-
 arch/powerpc/include/asm/kvm_book3s.h              |  26 +-
 arch/powerpc/include/asm/kvm_book3s_64.h           |   6 +
 arch/powerpc/include/asm/kvm_host.h                |   6 +
 arch/powerpc/include/asm/kvm_ppc.h                 |   2 +
 arch/powerpc/include/asm/mmu.h                     |   1 +
 arch/powerpc/include/asm/opal-api.h                |   3 +-
 arch/powerpc/include/asm/opal.h                    |   8 +-
 arch/powerpc/include/asm/page_64.h                 |   4 +-
 arch/powerpc/include/asm/pci-bridge.h              |  18 -
 arch/powerpc/include/asm/plpar_wrappers.h          |  12 +
 arch/powerpc/include/asm/powernv.h                 |  19 +
 arch/powerpc/include/asm/ppc-opcode.h              |   1 +
 arch/powerpc/include/asm/processor.h               |   3 +-
 arch/powerpc/include/asm/prom.h                    |  18 +-
 arch/powerpc/include/asm/reg.h                     |   6 +-
 arch/powerpc/include/asm/rtas.h                    |   1 +
 arch/powerpc/include/asm/sparsemem.h               |   7 +
 arch/powerpc/include/asm/uaccess.h                 |   6 +-
 arch/powerpc/include/uapi/asm/auxvec.h             |  33 +-
 arch/powerpc/include/uapi/asm/elf.h                |  23 -
 arch/powerpc/include/uapi/asm/kvm.h                |  20 +
 arch/powerpc/kernel/Makefile                       |   3 +-
 arch/powerpc/kernel/align.c                        |   2 +-
 arch/powerpc/kernel/asm-offsets.c                  |  14 +-
 arch/powerpc/kernel/exceptions-64s.S               | 262 ++++----
 arch/powerpc/kernel/fadump.c                       |  25 +-
 arch/powerpc/kernel/hw_breakpoint.c                |   4 +-
 arch/powerpc/kernel/idle_book3s.S                  |  46 +-
 arch/powerpc/kernel/iomap.c                        |   1 +
 arch/powerpc/kernel/isa-bridge.c                   |  92 +++
 arch/powerpc/kernel/kprobes.c                      |  17 +-
 arch/powerpc/kernel/legacy_serial.c                |   3 +-
 arch/powerpc/kernel/misc_64.S                      |  28 +-
 arch/powerpc/kernel/optprobes.c                    | 347 ++++++++++
 arch/powerpc/kernel/optprobes_head.S               | 135 ++++
 arch/powerpc/kernel/prom_init.c                    |  20 +-
 arch/powerpc/kernel/rtas.c                         |  32 +-
 arch/powerpc/kernel/rtasd.c                        |   7 +-
 arch/powerpc/kernel/setup-common.c                 |   9 +
 arch/powerpc/kernel/setup_32.c                     |   8 -
 arch/powerpc/kernel/setup_64.c                     | 196 ++++--
 arch/powerpc/kernel/vdso.c                         |  18 +-
 arch/powerpc/kvm/Makefile                          |   3 +-
 arch/powerpc/kvm/book3s.c                          |   1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c                | 110 ++--
 arch/powerpc/kvm/book3s_64_mmu_radix.c             | 716 +++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c                       | 205 +++++-
 arch/powerpc/kvm/book3s_hv_builtin.c               |  30 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |  25 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c               |  18 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            | 154 ++++-
 arch/powerpc/kvm/book3s_segment.S                  |  32 +-
 arch/powerpc/kvm/powerpc.c                         |  32 +
 arch/powerpc/lib/Makefile                          |   2 -
 arch/powerpc/lib/checksum_64.S                     |  12 +-
 arch/powerpc/lib/code-patching.c                   |  45 +-
 arch/powerpc/lib/copypage_64.S                     |   4 +-
 arch/powerpc/lib/sstep.c                           |   6 +-
 arch/powerpc/lib/string_64.S                       |   6 +-
 arch/powerpc/mm/copro_fault.c                      |  10 +-
 arch/powerpc/mm/fault.c                            |  43 +-
 arch/powerpc/mm/hash_utils_64.c                    |  62 ++
 arch/powerpc/mm/hugetlbpage-hash64.c               |  21 -
 arch/powerpc/mm/init-common.c                      |   3 +-
 arch/powerpc/mm/init_64.c                          |  35 +
 arch/powerpc/mm/mem.c                              |   4 +
 arch/powerpc/mm/mmu_context_iommu.c                |   2 +-
 arch/powerpc/mm/numa.c                             |  15 +-
 arch/powerpc/mm/pgtable-book3s64.c                 |   4 +-
 arch/powerpc/mm/pgtable-radix.c                    | 261 ++++++--
 arch/powerpc/mm/pgtable_64.c                       |  22 +-
 arch/powerpc/mm/subpage-prot.c                     |   4 +-
 arch/powerpc/net/bpf_jit.h                         |  11 +-
 arch/powerpc/net/bpf_jit_comp.c                    |  17 +-
 arch/powerpc/net/bpf_jit_comp64.c                  |  16 +-
 arch/powerpc/platforms/maple/pci.c                 |   1 +
 arch/powerpc/platforms/powernv/idle.c              | 142 +++-
 arch/powerpc/platforms/powernv/opal-hmi.c          |   3 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c      |  55 +-
 arch/powerpc/platforms/powernv/opal-lpc.c          |  22 +-
 arch/powerpc/platforms/powernv/opal-msglog.c       |   4 +
 arch/powerpc/platforms/powernv/opal-wrappers.S     |  73 +--
 arch/powerpc/platforms/powernv/opal.c              |  11 +
 arch/powerpc/platforms/powernv/pci-ioda.c          |  23 +-
 arch/powerpc/platforms/powernv/pci.c               |   7 +
 arch/powerpc/platforms/powernv/pci.h               |   1 +
 arch/powerpc/platforms/powernv/powernv.h           |   3 +-
 arch/powerpc/platforms/powernv/smp.c               |  14 +-
 arch/powerpc/platforms/pseries/Kconfig             |   1 -
 arch/powerpc/platforms/pseries/cmm.c               |   2 +-
 arch/powerpc/platforms/pseries/dlpar.c             |   8 +-
 arch/powerpc/platforms/pseries/firmware.c          |   3 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c    |  75 ++-
 arch/powerpc/platforms/pseries/lpar.c              | 138 ++++
 arch/powerpc/platforms/pseries/mobility.c          |  34 +
 arch/powerpc/platforms/pseries/setup.c             |   1 +
 arch/powerpc/xmon/xmon.c                           |   8 +-
 drivers/cpuidle/cpuidle-powernv.c                  | 129 ++--
 drivers/macintosh/Kconfig                          |  24 +-
 drivers/macintosh/Makefile                         |   1 -
 drivers/macintosh/adb.c                            |   4 -
 drivers/macintosh/via-cuda.c                       | 294 ++++++---
 drivers/macintosh/via-maciisi.c                    | 677 -------------------
 drivers/misc/cxl/Makefile                          |   3 +-
 drivers/misc/cxl/api.c                             |   1 -
 drivers/misc/cxl/cxl.h                             |  61 +-
 drivers/misc/cxl/main.c                            |   3 +-
 drivers/misc/cxl/pci.c                             |   5 +
 drivers/misc/cxl/vphb.c                            |  51 +-
 include/linux/cpuidle.h                            |   1 +
 include/uapi/linux/kvm.h                           |   6 +
 kernel/kprobes.c                                   |   6 +
 scripts/Makefile.gcc-plugins                       |  10 +-
 144 files changed, 4502 insertions(+), 1832 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
 create mode 100644 arch/powerpc/include/asm/isa-bridge.h
 create mode 100644 arch/powerpc/include/asm/powernv.h
 create mode 100644 arch/powerpc/kernel/optprobes.c
 create mode 100644 arch/powerpc/kernel/optprobes_head.S
 create mode 100644 arch/powerpc/kvm/book3s_64_mmu_radix.c
 delete mode 100644 drivers/macintosh/via-maciisi.c

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYrXOkAAoJEFHr6jzI4aWA6aQP/06QQJe8Hv0Dde+s97a8Jsop
mLwni4wE0RZeG4lNqhO4ZzQZd/Q/YsvEK3ie1wWRoFyCtQL/3cb50IhO6Nx5TL91
RfbdVq9PeMYWoBoyCPzTOQK7aSaGSB/9pPvEUzIPSC8Nj2tHPgFi3s9Cdmn+uOXB
zqPgIUQwRxve3ohgSwk03LT7V1jKXMOXYcCxpqA/+CSBAwWCPpja2/QlXCMUMf6M
fkxBvnd4h2doRK8+9GdmjuPWmBcL+ZXXYQoC20S2o+OMseUppMxLJpc+PfhMTpLB
z6puzrrXP0gGFZ8tno/lSs7Pq7Yj2QSJsG8WYQ4Hagf3xYwbgkdA8WQJ1w32gmhx
g9qHLSC+GUBfa8FdZ2uDPCNlYp/3Mh0ccfeI2nOHdgVTBBQ4bgw7ZI3eZlpezJzG
miBNWhz7skpxpxIV6U+4GWd/am/FqoRyUDfavRHEVZvMv3M7/bb9M51DkZhax7SM
9iDS20nx3zdqbeXLmIAHjB0g+g08w3tGivCOqf4ip6djogEPP862FxY+5NaemVFy
ApZ2y+NwZQv0SrNnkNfIV0+f6pY40ggOqFxSTwU7/hmQPk58UUTWc1ZK3ruP59+3
p0SmvHh3GvjXsEiOCHOBpUOZHi8x8/GbNrSt3MyUeG5vXZO8GT6xuyPVImPXyu0t
MKCCD328MhZhxSSiCBxt
=zm5Y
-----END PGP SIGNATURE-----
--=-=-=--
