Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rB3Hx3CnfzDqCg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 19:57:01 +1000 (AEST)
Message-ID: <1463738202.23394.6.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.7-1 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Zhiqiang.Hou@freescale.com, aaro.koskinen@iki.fi, acme@redhat.com,
 aik@ozlabs.ru, alessio.bogani@elettra.eu, alex.williamson@redhat.com,
 andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 benh@kernel.crashing.org,  bsingharora@gmail.com,
 chandan.kumar@linux.vnet.ibm.com,  chenhui.zhao@freescale.com,
 chenhui.zhao@nxp.com, chris@distroguy.com,  clombard@linux.vnet.ibm.com,
 dja@axtens.net, elfring@users.sourceforge.net,  fbarrat@linux.vnet.ibm.com,
 felix@linux.vnet.ibm.com,  gpiccoli@linux.vnet.ibm.com,
 gwshan@linux.vnet.ibm.com,  hbathini@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, lsorense@csclub.uwaterloo.ca,
 maddy@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 mike.marciniszyn@intel.com,  mikey@neuling.org,
 naveen.n.rao@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 oohall@gmail.com, oss@buserror.net, paul.gortmaker@windriver.com,
 paulus@ozlabs.org, rashmicy@gmail.com, robh@kernel.org,
 rostedt@goodmis.org,  ruscur@russell.cc, sjitindarsingh@gmail.com,
 stewart@linux.vnet.ibm.com,  valentinrothberg@gmail.com,
 vipin@linux.vnet.ibm.com, viresh.kumar@linaro.org
Date: Fri, 20 May 2016 19:56:42 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-fo2eVXpRN0LHJxeQiacE"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-fo2eVXpRN0LHJxeQiacE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc updates for 4.7:

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb=
:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.7-1

for you to fetch changes up to 138a076496e61c68ebc1dcccc088705826bbe26d:

  Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/scot=
twood/linux into next (2016-05-19 17:43:20 +1000)


There's one conflict in arch/powerpc/kernel/prom.c. It's trivial, but also =
easy
to get wrong, because the added line needs an extra element initialised, an=
d the
compiler won't catch it, the result should be:

	{0, MMU_FTR_RADIX, 0, 0,		40, 0, 0},

(And yes I plan to rewrite that code to use designated intialisers)

----------------------------------------------------------------
powerpc updates for 4.7

Highlights:
 - Support for Power ISA 3.0 (Power9) Radix Tree MMU from Aneesh Kumar K.V
 - Live patching support for ppc64le (also merged via livepatching.git)

Various cleanups & minor fixes from:
 - Aaro Koskinen, Alexey Kardashevskiy, Andrew Donnellan, Aneesh Kumar K.V,
   Chris Smart, Daniel Axtens, Frederic Barrat, Gavin Shan, Ian Munsie, Len=
nart
   Sorensen, Madhavan Srinivasan, Mahesh Salgaonkar, Markus Elfring, Michae=
l
   Ellerman, Oliver O'Halloran, Paul Gortmaker, Paul Mackerras, Rashmica Gu=
pta,
   Russell Currey, Suraj Jitindar Singh, Thiago Jung Bauermann, Valentin
   Rothberg, Vipin K Parashar.

General:
 - Update LMB associativity index during DLPAR add/remove from Nathan Fonte=
not
 - Fix branching to OOL handlers in relocatable kernel from Hari Bathini
 - Add support for userspace Power9 copy/paste from Chris Smart
 - Always use STRICT_MM_TYPECHECKS from Michael Ellerman
 - Add mask of possible MMU features from Michael Ellerman

PCI:
 - Enable pass through of NVLink to guests from Alexey Kardashevskiy
 - Cleanups in preparation for powernv PCI hotplug from Gavin Shan
 - Don't report error in eeh_pe_reset_and_recover() from Gavin Shan
 - Restore initial state in eeh_pe_reset_and_recover() from Gavin Shan
 - Revert "powerpc/eeh: Fix crash in eeh_add_device_early() on Cell" from G=
uilherme G. Piccoli
 - Remove the dependency on EEH struct in DDW mechanism from Guilherme G. P=
iccoli

selftests:
 - Test cp_abort during context switch from Chris Smart
 - Add several tests for transactional memory support from Rashmica Gupta

perf:
 - Add support for sampling interrupt register state from Anju T
 - Add support for unwinding perf-stackdump from Chandan Kumar

cxl:
 - Configure the PSL for two CAPI ports on POWER8NVL from Philippe Bergheau=
d
 - Allow initialization on timebase sync failures from Frederic Barrat
 - Increase timeout for detection of AFU mmio hang from Frederic Barrat
 - Handle num_of_processes larger than can fit in the SPA from Ian Munsie
 - Ensure PSL interrupt is configured for contexts with no AFU IRQs from Ia=
n Munsie
 - Add kernel API to allow a context to operate with relocate disabled from=
 Ian Munsie
 - Check periodically the coherent platform function's state from Christoph=
e Lombard

Freescale:
 - Updates from Scott: "Contains 86xx fixes, minor device tree fixes, an er=
ratum
   workaround, and a kconfig dependency fix."

----------------------------------------------------------------
Aaro Koskinen (2):
      drivers: macintosh: rack-meter: limit idle ticks to total ticks
      drivers: macintosh: rack-meter: fix bogus memsets

Alessio Igor Bogani (3):
      powerpc/fsl: Fix build of the dtb embedded kernel images
      powerpc/86xx: Move pci1 definition to the include file
      powerpc/86xx: Fix PCI interrupt map definition

Alexey Kardashevskiy (13):
      powerpc/powernv/pci: Fix cfg_dbg() & replace with pr_devel()
      vfio/spapr: Relax the IOMMU compatibility check
      powerpc/powernv: Rename pnv_pci_ioda2_tce_invalidate_entire
      powerpc/powernv: Define TCE Kill flags
      powerpc/powernv/npu: TCE Kill helpers cleanup
      powerpc/powernv/npu: Use the correct IOMMU page size
      powerpc/powernv/npu: Simplify DMA setup
      powerpc/powernv/ioda2: Export debug helper pe_level_printk()
      powerpc/powernv/npu: Add set/unset window helpers
      powerpc/powernv/npu: Rework TCE Kill handling
      powerpc/powernv/npu: Enable NVLink pass through
      powerpc/powernv: Fix insufficient memory allocation
      powerpc/powernv/npu: Add PE to PHB's list

Andrew Donnellan (2):
      powerpc/eeh: fix misleading indentation
      powerpc/mpic: handle subsys_system_register() failure

Aneesh Kumar K.V (69):
      cxl: Fix DAR check & use REGION_ID instead of opencoding
      IB/qib: Use cache inhibitted and guarded mapping on powerpc
      powerpc/mm: Drop PTE_ATOMIC_UPDATES from pmd_hugepage_update()
      powerpc/mm: Use big endian Linux page tables for book3s 64
      powerpc/mm: Use _PAGE_READ to indicate Read access
      powerpc/mm/subpage: Clear RWX bit to indicate no access
      powerpc/mm: Use pte_user() instead of open coding
      powerpc/mm: Replace _PAGE_USER with _PAGE_PRIVILEGED
      powerpc/mm: Remove RPN_SHIFT and RPN_SIZE
      powerpc/mm: Update _PAGE_KERNEL_RO
      powerpc/mm: Use a helper for finding pte bits mapping I/O area
      powerpc/mm: Drop WIMG in favour of new constants
      powerpc/mm: Use generic version of pmdp_clear_flush_young()
      powerpc/mm: Use generic version of ptep_clear_flush_young()
      powerpc/mm: Move radix/hash common data structures to book3s64 header=
s
      powerpc/mm/radix: Add partition table format & callback
      powerpc/mm/hash: Add support for Power9 Hash
      powerpc/mm: Move hash and no hash code to separate files
      powerpc/mm/book3s: Rename hash specific PTE bits to carry H_ prefix
      powerpc/mm: Handle _PTE_NONE_MASK
      powerpc/mm: Move common pte bits and accessors to book3s/64/pgtable.h
      powerpc/mm: Move pte accessors that operate on common pte bits to pgt=
able.h
      powerpc/mm: Make page table size a variable
      powerpc/mm: Move page table index and and vaddr to pgtable.h
      powerpc/mm: Move pte related functions together
      powerpc/mm/radix: Add radix pte #defines
      powerpc/mm/radix: Add dummy radix_enabled()
      powerpc/mm: Add radix callbacks to pte accessors
      powerpc/mm: Move hugetlb and THP related pmd accessors to pgtable.h
      powerpc/mm/radix: Add radix callback for pmd accessors
      powerpc/mm: Abstract early MMU init in preparation for radix
      powerpc/mm/radix: Add radix callbacks for early init routines
      powerpc/mm: Abstraction for vmemmap and map_kernel_page()
      powerpc/mm/radix: Add radix callbacks for vmemmap and map_kernel page=
()
      powerpc/mm: Abstraction for switch_mmu_context()
      powerpc/mm/radix: Add mmu context handling callback for radix
      powerpc/mm: Rename mmu_context_hash64.c to mmu_context_book3s64.c
      powerpc/mm: Hash abstraction for tlbflush routines
      powerpc/mm/radix: Add tlbflush routines
      powerpc/mm/radix: Add MMU_FTR_RADIX
      powerpc/mm/radix: Use STD_MMU_64 to properly isolate hash related cod=
e
      powerpc/mm/radix: Isolate hash table function from pseries guest code
      powerpc/mm/radix: Add checks in slice code to catch radix usage
      powerpc/mm/radix: Limit paca allocation in radix
      powerpc/mm/radix: Pick the address layout for radix config
      powerpc/mm/radix: Update PTCR on secondary CPUs
      powerpc/mm: Make a copy of pgalloc.h for 32 and 64 book3s
      powerpc/mm: Copy pgalloc (part 2)
      powerpc/mm: Revert changes made to nohash pgalloc-64.h
      powerpc/mm: Simplify the code dropping 4-level table #ifdef
      powerpc/mm: Rename function to indicate we are allocating fragments
      powerpc/mm: Make 4K and 64K use pte_t for pgtable_t
      powerpc/mm: Add radix pgalloc details
      powerpc/mm: Update pte filter for radix
      powerpc/mm: vmalloc abstraction in preparation for radix
      powerpc/radix: Update MMU cache
      powerpc/mm: pte_frag abstraction
      powerpc/mm: Fix vma_mmu_pagesize() for radix
      powerpc/mm: Add radix support for hugetlb
      powerpc/mm/radix: Make sure swapper pgdir is properly aligned
      powerpc/mm/radix: Add hugetlb support 4K page size
      powerpc/mm: THP is only available on hash64 as of now
      powerpc/mm/thp: Abstraction for THP functions
      powerpc/mm/radix: Add radix THP callbacks
      powerpc/mm/radix: Add THP support for 4K linux page size
      powerpc/mm/radix: Use firmware feature to enable Radix MMU
      powerpc/mm/radix: Document software bits for radix
      powerpc/mm/subpage: Initialise user psize correctly
      powerpc/mm/slice: Remove slice_mm_new_context()

Anju T (3):
      powerpc/perf: Assign an id to each powerpc register
      powerpc/perf: Add support for sampling interrupt register state
      tools/perf: Map the ID values with register names

Chandan Kumar (2):
      powerpc: Add HAVE_PERF_USER_STACK_DUMP support
      perf/powerpc: Add support for unwinding perf-stackdump

Chenhui Zhao (1):
      powerpc/fsl: Fix rcpm compatible string

Chris Smart (3):
      powerpc: Add support for userspace P9 copy paste
      powerpc: Remove unnecessary CONFIG_SMP #ifdefs
      selftests/powerpc: Test cp_abort during context switch

Christophe Lombard (1):
      cxl: Check periodically the coherent platform function's state

Daniel Axtens (3):
      powerpc: sparse: static-ify some things
      powerpc: sparse: Include headers for __weak symbols
      powerpc: rework sparse for lib/xor_vmx.c

Frederic Barrat (3):
      cxl: Remove dead code
      cxl: Allow initialization on timebase sync failures
      cxl: Increase timeout for detection of AFU mmio hang

Gavin Shan (31):
      powerpc/mm: Improve readability of update_mmu_cache()
      powerpc/pci: Cleanup on struct pci_controller_ops
      powerpc/powernv: Cleanup on pci_controller_ops instances
      powerpc/powernv: Drop phb->bdfn_to_pe()
      powerpc/powernv: Reorder fields in struct pnv_phb
      powerpc/powernv: Rename PE# fields in struct pnv_phb
      powerpc/powernv: Data type unsigned int for PE number
      powerpc/powernv: Fix initial IO and M32 segmap
      powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
      powerpc/powernv: IO and M32 mapping based on PCI device resources
      powerpc/powernv: Track M64 segment consumption
      powerpc/powernv: Rename M64 related functions
      powerpc/powernv/ioda1: M64 support on P7IOC
      powerpc/powernv/ioda1: Rename pnv_pci_ioda_setup_dma_pe()
      powerpc/powernv/ioda1: Introduce PNV_IODA1_DMA32_SEGSIZE
      powerpc/powernv: Remove DMA32 PE list
      powerpc/powernv/ioda1: Improve DMA32 segment track
      powerpc/powernv: Use PE instead of number during setup and release
      powerpc/pci: Rename pcibios_{add, remove}_pci_devices()
      powerpc/pci: Rename pcibios_find_pci_bus()
      powerpc/pci: Move pci_find_bus_by_node() around
      powerpc/pci: Export pci_add_device_node_info()
      powerpc/pci: Introduce pci_remove_device_node_info()
      powerpc/pci: Export pci_traverse_device_nodes()
      powerpc/pci: Don't scan empty slot
      powerpc/powernv: Simplify pnv_eeh_reset()
      powerpc/powernv: Exclude root bus in pnv_pci_reset_secondary_bus()
      powerpc/eeh: Don't report error in eeh_pe_reset_and_recover()
      powerpc/eeh: Restore initial state in eeh_pe_reset_and_recover()
      powerpc/eeh: Ignore handlers in eeh_pe_reset_and_recover()
      powerpc/eeh: Drop unnecessary label in eeh_pe_change_owner()

Guilherme G. Piccoli (2):
      Revert "powerpc/eeh: Fix crash in eeh_add_device_early() on Cell"
      powerpc/iommu: Remove the dependency on EEH struct in DDW mechanism

Hari Bathini (2):
      powerpc/book3s64: Fix branching to OOL handlers in relocatable kernel
      powerpc/book3s64: Remove __end_handlers marker

Hou Zhiqiang (1):
      powerpc/fsl: Fix SPI compatible on t208xrdb and t1040rdb

Ian Munsie (4):
      cxl: Handle num_of_processes larger than can fit in the SPA
      cxl: Remove duplicate #defines
      cxl: Ensure PSL interrupt is configured for contexts with no AFU IRQs
      cxl: Add kernel API to allow a context to operate with relocate disab=
led

Lennart Sorensen (1):
      powerpc/sstep: Fix sstep.c compile on powerpcspe

Madhavan Srinivasan (2):
      tool/perf: Add sample_reg_mask to include all perf_regs
      powerpc/perf: Replace raw event hex values with #defines

Mahesh Salgaonkar (1):
      powerpc/powernv: Rename machine_check_pSeries_early() to powernv

Markus Elfring (1):
      cxl: Delete an unnecessary check before the function call "kfree"

Michael Ellerman (20):
      powerpc/mm: Remove long disabled SLB code
      powerpc: Remove orphaned asm implementation of abs()
      powerpc: Make generic_memcpy() private to copy_32.S
      MAINTAINERS: Add powerpc drivers to the powerpc section
      ftrace: Make ftrace_location_range() global
      livepatch: Allow architectures to specify an alternate ftrace locatio=
n
      powerpc/livepatch: Add livepatch header
      powerpc/livepatch: Add livepatch stack to struct thread_info
      powerpc/livepatch: Add live patching support on ppc64le
      Merge branch 'topic/livepatch' into next
      powerpc/mm: Always use STRICT_MM_TYPECHECKS
      powerpc/mm: Add pte_xchg() helper
      powerpc/mm: Use pte_raw() in pte_same()/pmd_same()
      powerpc/mm: Convert pte_user() to static inline
      powerpc/mm: Add mask of possible MMU features
      selftests/powerpc: Fix subpage_prot test to return !0 on failure
      powerpc/mm/hash64: Factor out hash preload psize check
      powerpc/mm/hash64: Fix subpage protection with 4K HPTE config
      Revert "powerpc/powernv: Exclude root bus in pnv_pci_reset_secondary_=
bus()"
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into =
next

Nathan Fontenot (2):
      powerpc/pseries: Refactor dlpar_add_lmb() code
      powerpc/pseries: Update LMB associativity index during DLPAR add/remo=
ve

Naveen N. Rao (1):
      perf tools: Fix perf regs mask generation

Oliver O'Halloran (2):
      powerpc/sstep: Fix emulation fall-through
      powerpc/mm: define TOP_ZONE as a constant

Paul Gortmaker (3):
      powerpc/cell: Make spu_base.c explicitly non-modular
      powerpc: make kernel/nvram_64.c explicitly non-modular
      drivers/cpufreq: make ppc_cbe_cpufreq_pmi driver explicitly non-modul=
ar

Paul Mackerras (1):
      powerpc/xmon: Fix SPR read/write commands and add command to dump SPR=
s

Philippe Bergheaud (2):
      powerpc: Define PVR value for POWER8NVL processor
      cxl: Configure the PSL for two CAPI ports on POWER8NVL

Rashmica Gupta (7):
      powerpc/Kconfig: Update config option based on page size.
      powerpc: Remove unused remnants from A2 cpu
      selftests/powerpc: Make reg.h common to all powerpc selftests
      selftests/powerpc: Standardise TM calls
      selftests/powerpc: Add test for forking inside transaction
      selftests/powerpc: Add TM test to check if TAR is corrupted
      selftests/powerpc: Add test to check if TM SPRs are corrupted

Russell Currey (3):
      powerpc/powernv: Use the "unknown" checkstop type as a fallback
      powerpc/eeh: rename EEH from "extended" to "enhanced" error handling
      powerpc/swsusp: Only use tlbie in POWER4 mode

Scott Wood (1):
      powerpc/fsl: Remove FSL_SOC dependency from FSL_LBC

Suraj Jitindar Singh (3):
      powerpc/pseries: Add null property check to pseries_discover_pic()
      drivers/of: Add check for null property in of_remove_property()
      powerpc: Update of_remove_property() call sites to remove null checki=
ng

Thiago Jung Bauermann (1):
      ftrace: Match dot symbols when searching functions on ppc64

Valentin Rothberg (1):
      powerpc/mm/radix: Fix CONFIG_PPC_MMU_STD_64 typo

Vipin K Parashar (1):
      powerpc/opal: Assign numbers to OPAL_MSG macros of enum opal_msg_type

chenhui zhao (1):
      powerpc/fsl-pci: Add a workaround for PCI 5 errata

 Documentation/ABI/testing/sysfs-class-cxl          |   8 +
 .../features/perf/perf-regs/arch-support.txt       |   2 +-
 .../features/perf/perf-stackdump/arch-support.txt  |   2 +-
 Documentation/powerpc/eeh-pci-error-recovery.txt   |   2 +-
 MAINTAINERS                                        |  13 +
 arch/powerpc/Kconfig                               |   7 +-
 arch/powerpc/Kconfig.debug                         |   8 -
 arch/powerpc/boot/Makefile                         |   6 +-
 arch/powerpc/boot/dts/fsl/gef_ppc9a.dts            |   4 +
 arch/powerpc/boot/dts/fsl/gef_sbc310.dts           |  22 -
 arch/powerpc/boot/dts/fsl/gef_sbc610.dts           |   4 +
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts         |  24 +-
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts     |  24 +-
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi      |  41 +-
 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi       |   1 +
 arch/powerpc/boot/dts/fsl/sbc8641d.dts             |  23 -
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi            |   2 +-
 arch/powerpc/boot/dts/fsl/t208xrdb.dtsi            |   2 +-
 arch/powerpc/include/asm/book3s/32/hash.h          |   3 -
 arch/powerpc/include/asm/book3s/32/mmu-hash.h      |   6 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h       | 109 +++
 arch/powerpc/include/asm/book3s/64/hash-4k.h       | 136 +--
 arch/powerpc/include/asm/book3s/64/hash-64k.h      | 215 ++---
 arch/powerpc/include/asm/book3s/64/hash.h          | 485 ++---------
 arch/powerpc/include/asm/book3s/64/hugetlb-radix.h |  14 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |  79 +-
 arch/powerpc/include/asm/book3s/64/mmu.h           | 137 +++
 arch/powerpc/include/asm/book3s/64/pgalloc.h       | 207 +++++
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h    |  53 ++
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h   |  64 ++
 arch/powerpc/include/asm/book3s/64/pgtable.h       | 816 ++++++++++++++++-=
-
 arch/powerpc/include/asm/book3s/64/radix-4k.h      |  12 +
 arch/powerpc/include/asm/book3s/64/radix-64k.h     |  12 +
 arch/powerpc/include/asm/book3s/64/radix.h         | 232 +++++
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  41 +-
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  33 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  76 ++
 arch/powerpc/include/asm/book3s/pgalloc.h          |  19 +
 arch/powerpc/include/asm/hugetlb.h                 |  14 +
 arch/powerpc/include/asm/kvm_book3s_64.h           |  36 +-
 arch/powerpc/include/asm/machdep.h                 |   1 +
 arch/powerpc/include/asm/mmu.h                     |  51 +-
 arch/powerpc/include/asm/mmu_context.h             |  29 +-
 .../asm/{pgalloc-32.h =3D> nohash/32/pgalloc.h}      |   0
 .../asm/{pgalloc-64.h =3D> nohash/64/pgalloc.h}      |  92 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  10 +-
 arch/powerpc/include/asm/nohash/pgalloc.h          |  23 +
 arch/powerpc/include/asm/opal-api.h                |  16 +-
 arch/powerpc/include/asm/page.h                    |  14 +-
 arch/powerpc/include/asm/page_64.h                 |   5 +-
 arch/powerpc/include/asm/pci-bridge.h              |  41 +-
 arch/powerpc/include/asm/pgalloc.h                 |  19 +-
 arch/powerpc/include/asm/pgtable-be-types.h        |  92 ++
 arch/powerpc/include/asm/pgtable-types.h           |  58 +-
 arch/powerpc/include/asm/ppc-opcode.h              |   2 +
 arch/powerpc/include/asm/ppc-pci.h                 |   6 +-
 arch/powerpc/include/asm/ppc_asm.h                 |   3 +
 arch/powerpc/include/asm/pte-common.h              |  26 +-
 arch/powerpc/include/asm/reg.h                     |   3 +
 arch/powerpc/include/asm/tlbflush.h                |   3 +-
 arch/powerpc/include/uapi/asm/perf_regs.h          |  50 ++
 arch/powerpc/kernel/asm-offsets.c                  |   4 +
 arch/powerpc/kernel/btext.c                        |   2 +-
 arch/powerpc/kernel/cputable.c                     |   2 -
 arch/powerpc/kernel/eeh.c                          |   9 +-
 arch/powerpc/kernel/eeh_driver.c                   |  46 +-
 arch/powerpc/kernel/eeh_event.c                    |   2 +-
 arch/powerpc/kernel/eeh_pe.c                       |   2 +-
 arch/powerpc/kernel/entry_64.S                     |  16 +-
 arch/powerpc/kernel/exceptions-64s.S               | 163 +---
 arch/powerpc/kernel/ftrace.c                       |  10 +
 arch/powerpc/kernel/head_64.S                      |  13 +-
 arch/powerpc/kernel/ibmebus.c                      |   2 +-
 arch/powerpc/kernel/isa-bridge.c                   |   4 +-
 arch/powerpc/kernel/machine_kexec.c                |  18 +-
 arch/powerpc/kernel/machine_kexec_64.c             |  15 +-
 arch/powerpc/kernel/mce.c                          |   2 +-
 arch/powerpc/kernel/mce_power.c                    |  13 +
 arch/powerpc/kernel/misc_32.S                      |   6 -
 arch/powerpc/kernel/nvram_64.c                     |  12 +-
 arch/powerpc/kernel/pci-hotplug.c                  |  47 +-
 arch/powerpc/kernel/pci_64.c                       |   5 +-
 arch/powerpc/kernel/pci_dn.c                       |  66 +-
 arch/powerpc/kernel/process.c                      |  17 +-
 arch/powerpc/kernel/prom.c                         |   2 +
 arch/powerpc/kernel/rtasd.c                        |   2 +-
 arch/powerpc/kernel/setup-common.c                 |   6 -
 arch/powerpc/kernel/swsusp.c                       |   2 +-
 arch/powerpc/kernel/time.c                         |   1 +
 arch/powerpc/kernel/vio.c                          |   4 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |  11 +-
 arch/powerpc/kvm/book3s_hv.c                       |   6 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |  12 +-
 arch/powerpc/kvm/book3s_pr.c                       |   6 +-
 arch/powerpc/lib/copy_32.S                         |   2 +-
 arch/powerpc/lib/sstep.c                           |   5 +
 arch/powerpc/lib/xor_vmx.c                         |  10 +
 arch/powerpc/mm/Makefile                           |  10 +-
 arch/powerpc/mm/fsl_booke_mmu.c                    |   2 +-
 arch/powerpc/mm/hash64_4k.c                        |  29 +-
 arch/powerpc/mm/hash64_64k.c                       |  71 +-
 arch/powerpc/mm/hash_native_64.c                   |  11 +-
 arch/powerpc/mm/hash_utils_64.c                    | 190 +++-
 arch/powerpc/mm/hugepage-hash64.c                  |  22 +-
 arch/powerpc/mm/hugetlbpage-hash64.c               |  29 +-
 arch/powerpc/mm/hugetlbpage-radix.c                |  87 ++
 arch/powerpc/mm/hugetlbpage.c                      |  20 +-
 arch/powerpc/mm/init_64.c                          |  73 +-
 arch/powerpc/mm/mem.c                              |  40 +-
 arch/powerpc/mm/mmap.c                             | 110 +++
 ...mmu_context_hash64.c =3D> mmu_context_book3s64.c} |  52 +-
 arch/powerpc/mm/mmu_context_nohash.c               |   6 +-
 arch/powerpc/mm/mmu_decl.h                         |   5 -
 arch/powerpc/mm/pgtable-book3e.c                   | 122 +++
 arch/powerpc/mm/pgtable-book3s64.c                 | 118 +++
 arch/powerpc/mm/pgtable-hash64.c                   | 342 ++++++++
 arch/powerpc/mm/pgtable-radix.c                    | 526 ++++++++++++
 arch/powerpc/mm/pgtable.c                          |  24 +-
 arch/powerpc/mm/pgtable_64.c                       | 557 ++----------
 arch/powerpc/mm/slb.c                              |   1 -
 arch/powerpc/mm/slb_low.S                          |  54 +-
 arch/powerpc/mm/slice.c                            |  20 +-
 arch/powerpc/mm/tlb-radix.c                        | 251 ++++++
 arch/powerpc/mm/tlb_hash64.c                       |   6 +-
 arch/powerpc/perf/Makefile                         |   2 +-
 arch/powerpc/perf/callchain.c                      |   2 +-
 arch/powerpc/perf/perf_regs.c                      | 104 +++
 arch/powerpc/perf/power8-events-list.h             |  40 +
 arch/powerpc/perf/power8-pmu.c                     |  41 +-
 arch/powerpc/platforms/Kconfig.cputype             |  11 +-
 arch/powerpc/platforms/cell/spu_base.c             |   9 +-
 arch/powerpc/platforms/cell/spufs/fault.c          |   4 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |  69 +-
 arch/powerpc/platforms/powernv/npu-dma.c           | 283 +++---
 arch/powerpc/platforms/powernv/opal-hmi.c          |   8 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          | 953 +++++++++++++----=
----
 arch/powerpc/platforms/powernv/pci.c               |  19 +-
 arch/powerpc/platforms/powernv/pci.h               |  72 +-
 arch/powerpc/platforms/powernv/setup.c             |   5 +-
 arch/powerpc/platforms/ps3/htab.c                  |   2 +-
 arch/powerpc/platforms/ps3/spu.c                   |   4 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c    | 225 ++++-
 arch/powerpc/platforms/pseries/iommu.c             |  24 +-
 arch/powerpc/platforms/pseries/lpar.c              |  20 +-
 arch/powerpc/platforms/pseries/lparcfg.c           |   3 +-
 arch/powerpc/platforms/pseries/mobility.c          |   4 +-
 arch/powerpc/platforms/pseries/msi.c               |   4 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c         |  32 -
 arch/powerpc/platforms/pseries/reconfig.c          |   5 +-
 arch/powerpc/platforms/pseries/setup.c             |   4 +-
 arch/powerpc/sysdev/fsl_pci.c                      |  24 +
 arch/powerpc/sysdev/mpic.c                         |   9 +-
 arch/powerpc/xmon/Makefile                         |   2 +-
 arch/powerpc/xmon/spr_access.S                     |  45 +
 arch/powerpc/xmon/xmon.c                           | 138 +--
 drivers/cpufreq/pmac32-cpufreq.c                   |   2 +-
 drivers/infiniband/hw/qib/qib_file_ops.c           |   5 +-
 drivers/infiniband/hw/qib/qib_pcie.c               |   6 -
 drivers/macintosh/rack-meter.c                     |   5 +-
 drivers/macintosh/via-pmu.c                        |   4 +-
 drivers/misc/cxl/api.c                             |  28 +-
 drivers/misc/cxl/context.c                         |   3 +-
 drivers/misc/cxl/cxl.h                             |  15 +-
 drivers/misc/cxl/fault.c                           |  10 +-
 drivers/misc/cxl/guest.c                           |  78 +-
 drivers/misc/cxl/native.c                          |  29 +-
 drivers/misc/cxl/pci.c                             |  64 +-
 drivers/misc/cxl/sysfs.c                           |  10 +
 drivers/of/base.c                                  |   3 +
 drivers/pci/hotplug/rpadlpar_core.c                |   8 +-
 drivers/pci/hotplug/rpaphp_core.c                  |   4 +-
 drivers/pci/hotplug/rpaphp_pci.c                   |   4 +-
 drivers/pcmcia/electra_cf.c                        |   2 +-
 drivers/vfio/vfio_iommu_spapr_tce.c                |   3 +-
 include/misc/cxl.h                                 |   8 +
 kernel/trace/ftrace.c                              |  12 +
 tools/perf/arch/powerpc/include/perf_regs.h        |  69 ++
 tools/perf/arch/powerpc/util/Build                 |   2 +
 tools/perf/arch/powerpc/util/perf_regs.c           |  49 ++
 tools/perf/arch/powerpc/util/unwind-libunwind.c    |  96 +++
 tools/perf/config/Makefile                         |   6 +
 tools/perf/util/perf_regs.c                        |   8 +-
 tools/testing/selftests/powerpc/Makefile           |   1 +
 .../selftests/powerpc/context_switch/.gitignore    |   1 +
 .../selftests/powerpc/context_switch/Makefile      |  10 +
 .../selftests/powerpc/context_switch/cp_abort.c    | 110 +++
 tools/testing/selftests/powerpc/mm/subpage_prot.c  |  18 +-
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c      |   1 -
 .../selftests/powerpc/pmu/ebb/reg_access_test.c    |   1 -
 .../testing/selftests/powerpc/{pmu/ebb =3D> }/reg.h  |  18 +-
 tools/testing/selftests/powerpc/tm/.gitignore      |   3 +
 tools/testing/selftests/powerpc/tm/Makefile        |   3 +-
 tools/testing/selftests/powerpc/tm/tm-fork.c       |  42 +
 .../testing/selftests/powerpc/tm/tm-resched-dscr.c |  16 +-
 .../testing/selftests/powerpc/tm/tm-signal-stack.c |   4 +-
 tools/testing/selftests/powerpc/tm/tm-tar.c        |  90 ++
 tools/testing/selftests/powerpc/tm/tm-tmspr.c      | 143 ++++
 tools/testing/selftests/powerpc/utils.h            |   8 +
 200 files changed, 6907 insertions(+), 3127 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/32/pgalloc.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/mmu.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgalloc.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-4k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-64k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/radix-4k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/radix-64k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/radix.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/tlbflush.h
 create mode 100644 arch/powerpc/include/asm/book3s/pgalloc.h
 rename arch/powerpc/include/asm/{pgalloc-32.h =3D> nohash/32/pgalloc.h} (1=
00%)
 rename arch/powerpc/include/asm/{pgalloc-64.h =3D> nohash/64/pgalloc.h} (6=
8%)
 create mode 100644 arch/powerpc/include/asm/nohash/pgalloc.h
 create mode 100644 arch/powerpc/include/asm/pgtable-be-types.h
 create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/powerpc/mm/hugetlbpage-radix.c
 rename arch/powerpc/mm/{mmu_context_hash64.c =3D> mmu_context_book3s64.c} =
(70%)
 create mode 100644 arch/powerpc/mm/pgtable-book3e.c
 create mode 100644 arch/powerpc/mm/pgtable-book3s64.c
 create mode 100644 arch/powerpc/mm/pgtable-hash64.c
 create mode 100644 arch/powerpc/mm/pgtable-radix.c
 create mode 100644 arch/powerpc/mm/tlb-radix.c
 create mode 100644 arch/powerpc/perf/perf_regs.c
 create mode 100644 arch/powerpc/xmon/spr_access.S
 create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h
 create mode 100644 tools/perf/arch/powerpc/util/perf_regs.c
 create mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c
 create mode 100644 tools/testing/selftests/powerpc/context_switch/.gitigno=
re
 create mode 100644 tools/testing/selftests/powerpc/context_switch/Makefile
 create mode 100644 tools/testing/selftests/powerpc/context_switch/cp_abort=
.c
 rename tools/testing/selftests/powerpc/{pmu/ebb =3D> }/reg.h (74%)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-fork.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-tar.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-tmspr.c

--=-fo2eVXpRN0LHJxeQiacE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJXPt9aAAoJEFHr6jzI4aWAlfwQALZgcE57cjSYbBuq/HhHsf2W
4dvM7XYHB6PXK8jsGlx2ioz9kz2Ms2BgiokmzPHtj/EMQO3uCZRcSukh/tFRMD/D
NFH0wb5yTPn0lg1+n2k8FWkonzLtesk10EAtl2pXZtp9iVreIMrhmExIAlrKXuo0
vFAI4LngSMGS9MXiKCCFUF47PJOStFR2rwHdVkLwWKAWUmU7/qrS1l0YxXy9Phrp
VaZm1AzpzPdtVkT5Lx3a4lYcL0ObbCJK2zng7VsPFVlC9qx7BG65T5NX5ZUsiQlo
qArwuef9jgXuaogYUAfwZxdZ2exgVM2At2frZYt2zGxfz63cOd8Nw6ejbrYYr8KL
8UssL0KhKVt9I9fMJizFpCPEoABj/i53kloFoOwohoFY//W4noH9JcJm27c4ao/G
OW2fv1kzTl3y8dyEvh+W6qEMCa9eV4evoAQdr4KTbexXlX4Wtu28AQeSjKEv0D80
IyeOk24DiFje70l6JIX04drCpKm3CuIKnXFr5Ck4et5sorM4FDo+niqrOrgoAk/F
ch+gNi7BOWlPEiBDd90lu3EDFrVmQpeoiSlL1K16M1Lsvz2uQ2QGJ+v9DvdFJ9cC
8sfrE0EBajYQKjWi28JkuvZ33PQvs8bBlPmhpKxU4spOKW/BIWwMy0NMcCgHXbS/
yd/vOZnZUQow055aFZEJ
=jqGX
-----END PGP SIGNATURE-----

--=-fo2eVXpRN0LHJxeQiacE--
