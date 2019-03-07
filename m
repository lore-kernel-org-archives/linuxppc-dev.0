Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA131C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 13:15:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576FA2081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 13:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576FA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FWMc0dKHzDqD1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 00:15:24 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FWJy5CFjzDqCV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 00:13:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44FWJp0Wqnz9sB3;
 Fri,  8 Mar 2019 00:12:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-1 tag
Date: Fri, 08 Mar 2019 00:12:51 +1100
Message-ID: <87a7i6x1yk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mark.rutland@arm.com, sbobroff@linux.ibm.com, maddy@linux.vnet.ibm.com,
 clombard@linux.vnet.ibm.com, gustavo@embeddedor.com, aik@ozlabs.ru,
 mark.cave-ayland@ilande.co.uk, peterx@redhat.com,
 yamada.masahiro@socionext.com, oohall@gmail.com, sandipan@linux.ibm.com,
 mcroce@redhat.com, leitao@debian.org, rashmica.g@gmail.com, hch@lst.de,
 sergey.senozhatsky.work@gmail.com, joe.lawrence@redhat.com,
 sabyasachi.linux@gmail.com, aneesh.kumar@linux.ibm.com, yuehaibing@huawei.com,
 rppt@linux.ibm.com, firoz.khan@linaro.org, clabbe@baylibre.com,
 jniethe5@gmail.com, nfont@linux.vnet.ibm.com, rpjday@crashcourse.ca,
 joel@jms.id.au, igor.stoppa@gmail.com, nstange@suse.de, j.neuschaefer@gmx.net,
 npiggin@gmail.com, cai@lca.pw, tyreld@linux.vnet.ibm.com,
 natechancellor@gmail.com, arbab@linux.ibm.com, dvyukov@google.com,
 chunkeey@gmail.com, geoff@infradead.org, prasannatsmkumar@gmail.com,
 linux-kernel@vger.kernel.org, malat@debian.org, tglx@linutronix.de,
 jrdr.linux@gmail.com, andrew.donnellan@au1.ibm.com, brajeswar.linux@gmail.com,
 fbarrat@linux.ibm.com, vaibhav@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull powerpc updates for 5.1.

Stephen reported a couple of conflicts with the dma & swiotlb trees due to
Christoph's DMA series, but you haven't merged those trees yet so I'm not s=
eeing
them when I test merge. They were both fairly trivial though so I don't thi=
nk
they should cause any trouble.

cheers


The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-5.1-1

for you to fetch changes up to 9580b71b5a7863c24a9bd18bcd2ad759b86b1eff:

  powerpc/32: Clear on-stack exception marker upon exception return (2019-0=
3-04 00:37:23 +1100)

- ------------------------------------------------------------------
powerpc updates for 5.1

Notable changes:

 - Enable THREAD_INFO_IN_TASK to move thread_info off the stack.

 - A big series from Christoph reworking our DMA code to use more of the ge=
neric
   infrastructure, as he said:
   "This series switches the powerpc port to use the generic swiotlb and
    noncoherent dma ops, and to use more generic code for the coherent dire=
ct
    mapping, as well as removing a lot of dead code."

 - Increase our vmalloc space to 512T with the Hash MMU on modern CPUs, all=
owing
   us to support machines with larger amounts of total RAM or distance betw=
een
   nodes.

 - Two series from Christophe, one to optimise TLB miss handlers on 6xx, and
   another to optimise the way STRICT_KERNEL_RWX is implemented on some 32-=
bit
   CPUs.

 - Support for KCOV coverage instrumentation which means we can run syzkall=
er
   and discover even more bugs in our code.

And as always many clean-ups, reworks and minor fixes etc.

Thanks to:
 Alan Modra, Alexey Kardashevskiy, Alistair Popple, Andrea Arcangeli, Andrew
 Donnellan, Aneesh Kumar K.V, Aravinda Prasad, Balbir Singh, Brajeswar Ghos=
h,
 Breno Leitao, Christian Lamparter, Christian Zigotzky, Christophe Leroy,
 Christoph Hellwig, Corentin Labbe, Daniel Axtens, David Gibson, Diana Crac=
iun,
 Firoz Khan, Gustavo A. R. Silva, Igor Stoppa, Joe Lawrence, Joel Stanley,
 Jonathan Neusch=C3=A4fer, Jordan Niethe, Laurent Dufour, Madhavan Srinivas=
an, Mahesh
 Salgaonkar, Mark Cave-Ayland, Masahiro Yamada, Mathieu Malaterre, Matteo C=
roce,
 Meelis Roos, Michael W. Bringmann, Nathan Chancellor, Nathan Fontenot, Nic=
holas
 Piggin, Nick Desaulniers, Nicolai Stange, Oliver O'Halloran, Paul Mackerra=
s,
 Peter Xu, PrasannaKumar Muralidharan, Qian Cai, Rashmica Gupta, Reza Arbab,
 Robert P. J. Day, Russell Currey, Sabyasachi Gupta, Sam Bobroff, Sandipan =
Das,
 Sergey Senozhatsky, Souptick Joarder, Stewart Smith, Tyrel Datwyler, Vaibh=
av
 Jain, YueHaibing.

- ------------------------------------------------------------------
Alexey Kardashevskiy (4):
      powerpc/mm: Fix compile when CONFIG_PPC_RADIX_MMU is not defined
      powerpc/powernv: Remove never used pnv_power9_force_smt4
      powerpc/powernv/npu: Remove obsolete comment about TCE_KILL_INVAL_ALL
      powerpc/powernv/ioda: Fix locked_vm counting for memory used by IOMMU=
 tables

Andrew Donnellan (1):
      powerpc: Enable kcov

Aneesh Kumar K.V (3):
      powerpc/book3s: Remove pgd/pud/pmd_set() interfaces
      powerpc/hugetlb: Handle mmap_min_addr correctly in get_unmapped_area =
callback
      powerpc/mm/hash: Handle mmap_min_addr correctly in get_unmapped_area =
topdown search

Brajeswar Ghosh (1):
      powerpc/kernel/time: Remove duplicate header

Breno Leitao (2):
      selftests/powerpc: New TM signal self test
      powerpc/ptrace: Mitigate potential Spectre v1

Christian Lamparter (1):
      powerpc: Enable kernel XZ compression option on 44x

Christoph Hellwig (32):
      net: pasemi: set a 64-bit DMA mask on the DMA device
      dma-direct: we might need GFP_DMA for 32-bit dma masks
      powerpc/dma: untangle vio_dma_mapping_ops from dma_iommu_ops
      powerpc/dma: handle iommu bypass in dma_iommu_ops
      powerpc/pseries: unwind dma_get_required_mask_pSeriesLP a bit
      powerpc/pseries: use the generic iommu bypass code
      powerpc/cell: move dma direct window setup out of dma_configure
      powerpc/cell: use the generic iommu bypass code
      powerpc/dart: remove dead cleanup code in iommu_init_early_dart
      powerpc/dart: use the generic iommu bypass code
      powerpc/powernv: remove pnv_pci_ioda_pe_single_vendor
      powerpc/powernv: remove pnv_npu_dma_set_mask
      powerpc/powernv: use the generic iommu bypass code
      powerpc/dma: stop overriding dma_get_required_mask
      powerpc/pci: remove the dma_set_mask pci_controller ops methods
      powerpc/dma: remove the iommu fallback for coherent allocations
      powerpc/dma: remove get_pci_dma_ops
      powerpc/dma: move pci_dma_dev_setup_swiotlb to fsl_pci.c
      powerpc/dma: remove max_direct_dma_addr
      powerpc/dma: fix an off-by-one in dma_capable
      dma-mapping, powerpc: simplify the arch dma_set_mask override
      powerpc/dma: use phys_to_dma instead of get_dma_offset
      powerpc/dma: remove dma_nommu_mmap_coherent
      powerpc/dma: remove dma_nommu_get_required_mask
      powerpc/dma: remove dma_nommu_dma_supported
      swiotlb: remove swiotlb_dma_supported
      powerpc/dma: use the dma-direct allocator for coherent platforms
      powerpc/dma: use the dma_direct mapping routines
      powerpc/dma: use the generic direct mapping bypass
      powerpc/dma: remove get_dma_offset
      powerpc/dma: remove set_dma_offset
      powerpc/dma: trim the fat from <asm/dma-mapping.h>

Christophe Leroy (66):
      powerpc/irq: drop arch_early_irq_init()
      powerpc/ipic: drop unused functions
      powerpc/traps: Fix the message printed when stack overflows
      powerpc: Drop page_is_ram() and walk_system_ram_range()
      powerpc: drop unused GENERIC_CSUM Kconfig item
      powerpc/selftest: fix type of mftb() in null_syscall
      powerpc/8xx: hide itlbie and dtlbie symbols
      powerpc/setup: display reason for not booting
      powerpc/32: Remove unneccessary MSR[RI] clearing for 8xx
      powerpc/traps: fix recoverability of machine check handling on book3s=
/32
      powerpc/83xx: Also save/restore SPRG4-7 during suspend
      powerpc: simplify BDI switch
      powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in =
RTAS
      powerpc/6xx: Store PGDIR physical address in a SPRG
      powerpc/603: use physical address directly in TLB miss handlers.
      powerpc/hash32: use physical address directly in hash handlers.
      powerpc/603: Don't handle kernel page TLB misses when not need
      powerpc/603: Don't handle _PAGE_RW and _PAGE_DIRTY on ITLB misses
      powerpc/603: let's handle PAGE_DIRTY directly
      powerpc/603: Don't worry about _PAGE_USER in TLB miss handlers
      powerpc/603: don't handle PAGE_ACCESSED in TLB miss handlers.
      powerpc/book3s32: Reorder _PAGE_XXX flags to simplify TLB handling
      powerpc/32: Fix CONFIG_VIRT_CPU_ACCOUNTING_NATIVE for 40x/booke
      tools/selftest/vm: allow choosing mem size and page size in map_huget=
lb
      powerpc: dump as a single line areas mapping a single physical page.
      powerpc: Move page table dump files in a dedicated subdirectory
      powerpc/8xx: replace most #ifdef by IS_ENABLED() in 8xx_mmu.c
      powerpc/8xx: Map 32Mb of RAM at init.
      powerpc/wii: properly disable use of BATs when requested.
      powerpc/mm/32: add base address to mmu_mapin_ram()
      powerpc/mm/32s: rework mmu_mapin_ram()
      powerpc/mm/32s: use generic mmu_mapin_ram() for all blocks.
      powerpc/32: always populate page tables for Abatron BDI.
      powerpc/wii: remove wii_mmu_mapin_mem2()
      powerpc/mm/32s: use _PAGE_EXEC in setbat()
      powerpc/32: add helper to write into segment registers
      powerpc/mmu: add is_strict_kernel_rwx() helper
      powerpc/kconfig: define PAGE_SHIFT inside Kconfig
      powerpc/kconfig: define CONFIG_DATA_SHIFT and CONFIG_ETEXT_SHIFT
      powerpc/mm/32s: add setibat() clearibat() and update_bats()
      powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX
      powerpc/kconfig: make _etext and data areas alignment configurable on=
 Book3s 32
      powerpc/8xx: don't disable large TLBs with CONFIG_STRICT_KERNEL_RWX
      powerpc/kconfig: make _etext and data areas alignment configurable on=
 8xx
      powerpc/irq: use memblock functions returning virtual address
      powerpc: Avoid circular header inclusion in mmu-hash.h
      powerpc: Only use task_struct 'cpu' field on SMP
      powerpc: prep stack walkers for THREAD_INFO_IN_TASK
      powerpc: Rename THREAD_INFO to TASK_STACK
      powerpc: call_do_[soft]irq() takes a pointer to the stack
      powerpc: Don't use CURRENT_THREAD_INFO to find the stack
      powerpc: Replace current_thread_info()->task with current
      powerpc: Update comments in preparation for THREAD_INFO_IN_TASK
      powerpc/64: Use task_stack_page() to initialise paca->kstack
      powerpc: Use sizeof(struct thread_info) in INIT_SP_LIMIT
      powerpc: Use linux/thread_info.h in processor.h
      powerpc: Use task_stack_page() in current_pt_regs()
      powerpc/idle/6xx: Use r1 with CURRENT_THREAD_INFO()
      powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
      powerpc: regain entire stack space
      powerpc: 'current_set' is now a table of task_struct pointers
      powerpc/32: Remove CURRENT_THREAD_INFO and rename TI_CPU
      powerpc/64: Replace CURRENT_THREAD_INFO with PACA_THREAD_INFO
      powerpc: clean stack pointers naming
      powerpc/fsl: Fix the flush of branch predictor.
      powerpc/32: Clear on-stack exception marker upon exception return

Corentin Labbe (1):
      powerpc/dts: Build virtex dtbs

Firoz Khan (1):
      powerpc: remove nargs from __SYSCALL

Gustavo A. R. Silva (2):
      powerpc/ps3: Use struct_size() in kzalloc()
      powerpc/spufs: use struct_size() in kmalloc()

Igor Stoppa (1):
      powerpc: remove unnecessary unlikely()

Joe Lawrence (4):
      powerpc/livepatch: relax reliable stack tracer checks for first-frame
      powerpc/livepatch: small cleanups in save_stack_trace_tsk_reliable()
      powerpc/livepatch: return -ERRNO values in save_stack_trace_tsk_relia=
ble()
      powerpc: Remove export of save_stack_trace_tsk_reliable()

Joel Stanley (2):
      powerpc: Use ALIGN instead of BLOCK
      powerpc/32: Include .branch_lt in data section

Jonathan Neusch=C3=A4fer (2):
      powerpc: wii.dts: Add interrupt-related properties to GPIO node
      powerpc: wii.dts: Add GPIO keys

Jordan Niethe (1):
      powerpc/powernv: Make opal log only readable by root

Madhavan Srinivasan (1):
      powerpc/perf: Add mem access events to sysfs

Mark Cave-Ayland (1):
      powerpc: Fix 32-bit KVM-PR lockup and host crash with MacOS guest

Masahiro Yamada (3):
      KVM: powerpc: remove -I. header search paths
      powerpc: remove redundant header search path additions
      powerpc: math-emu: remove unneeded header search paths

Mathieu Malaterre (3):
      powerpc: Allow CPU selection of G4/74xx variant
      powerpc: Remove trailing semicolon after curly brace
      Move static keyword at beginning of declaration

Matteo Croce (1):
      powerpc/hvsi: Fix spelling mistake: "lenght" should be "length"

Michael Ellerman (19):
      powerpc: Stop using pr_cont() in __die()
      powerpc: Show PAGE_SIZE in __die() output
      powerpc/64s: Add MMU type to __die() output
      Merge branch 'fixes' into next
      KVM: PPC: Book3S HV: Context switch AMR on Power9
      Merge branch 'topic/dma' into next
      Merge branch 'topic/ppc-kvm' into next
      powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning
      powerpc/mm/hash: Increase vmalloc space to 512T with hash MMU
      powerpc/44x: Force PCI on for CURRITUCK
      powerpc/64: Make sys_switch_endian() traceable
      powerpc: Make PPC_64K_PAGES depend on only 44x or PPC_BOOK3S_64
      powerpc/64s: Fix logic when handling unknown CPU features
      powerpc/kvm: Save and restore host AMR/IAMR/UAMOR
      Revert "powerpc/book3s32: Reorder _PAGE_XXX flags to simplify TLB han=
dling"
      powerpc/64s: Remove MSR_RI optimisation in system_call_exit()
      powerpc/64: Simplify __secondary_start paca->kstack handling
      selftests/powerpc: Remove duplicate header
      Merge branch 'topic/ppc-kvm' into next

Nathan Chancellor (1):
      powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc

Nathan Fontenot (1):
      powerpc/pseries: Perform full re-add of CPU for topology update post-=
migration

Nicholas Piggin (10):
      powerpc/64s/hash: Fix assert_slb_presence() use of the slbfee. instru=
ction
      powerpc/smp: Fix NMI IPI timeout
      powerpc/smp: Fix NMI IPI xmon timeout
      powerpc/smp: Make __smp_send_nmi_ipi() static
      powerpc/64s: Fix HV NMI vs HV interrupt recoverability test
      powerpc/64s: system reset interrupt preserve HSRRs
      powerpc/64s: Prepare to handle data interrupts vs d-side MCE reentran=
cy
      powerpc/64s: Fix data interrupts vs d-side MCE reentrancy
      powerpc/powernv: move OPAL call wrapper tracing and interrupt handlin=
g to C
      powerpc/64s: Fix unrelocated interrupt trampoline address test

Nicolai Stange (2):
      powerpc/64s: Clear on-stack exception marker upon exception return
      powerpc/64s: Make reliable stacktrace dependency clearer

Oliver O'Halloran (8):
      powerpc/powernv: Escalate reset when IODA reset fails
      powerpc/eeh: Use debugfs_create_u32 for eeh_max_freezes
      powerpc/eeh_cache: Add pr_debug() prints for insert/remove
      powerpc/eeh_cache: Add a way to dump the EEH address cache
      powerpc/eeh_cache: Bump log level of eeh_addr_cache_print()
      powerpc/pci: Add pci_find_controller_for_domain()
      powerpc/eeh: Allow disabling recovery
      powerpc/eeh: Add eeh_force_recover to debugfs

Paul Mackerras (3):
      KVM: PPC: Book3S HV: Simplify machine check handling
      powerpc/64s: Better printing of machine check info for guest MCEs
      powerpc/powernv: Don't reprogram SLW image on every KVM guest entry/e=
xit

Peter Xu (1):
      powerpc/powernv/npu: Remove redundant change_pte() hook

PrasannaKumar Muralidharan (1):
      powerpc sstep: Add support for modsw, moduw instructions

Qian Cai (2):
      powerpc/mm: Fix "sz" set but not used warning
      powerpc/mm: fix "section_base" set but not used

Rashmica Gupta (1):
      powerpc/mm: Check secondary hash page table

Reza Arbab (1):
      powerpc/mm: Add _PAGE_SAO to _PAGE_CACHE_CTL mask

Robert P. J. Day (1):
      powerpc/dts: Standardize DTS status assignments from "ok" to "okay"

Sabyasachi Gupta (2):
      powerpc/powernv: Remove duplicate header
      powerpc/cell: Remove duplicate header

Sam Bobroff (6):
      powerpc/eeh: Cleanup eeh_pe_clear_frozen_state()
      powerpc/eeh: remove sw_state from eeh_unfreeze_pe()
      powerpc/eeh: Add include_passed to eeh_pe_state_clear()
      powerpc/eeh: Add include_passed to eeh_clear_pe_frozen_state()
      powerpc/eeh: Improve recovery of passed-through devices
      powerpc/eeh: Correct retries in eeh_pe_reset_full()

Sandipan Das (8):
      powerpc: sstep: Add tests for compute type instructions
      powerpc: sstep: Add tests for add[.] instruction
      powerpc: sstep: Add tests for addc[.] instruction
      powerpc: sstep: Add support for maddhd, maddhdu, maddld instructions
      powerpc: sstep: Add support for darn instruction
      powerpc sstep: Add support for cnttzw, cnttzd instructions
      powerpc sstep: Add support for extswsli instruction
      powerpc sstep: Add support for modsd, modud instructions

Sergey Senozhatsky (1):
      powerpc: use a CONSOLE_LOGLEVEL_DEBUG macro

Tyrel Datwyler (1):
      powerpc/pseries: export timebase register sample in lparcfg

Vaibhav Jain (1):
      cxl: Wrap iterations over afu slices inside 'afu_list_lock'

YueHaibing (1):
      powerpc/mm: Fix debugfs_simple_attr.cocci warnings


 arch/powerpc/Kconfig                               |  79 ++-
 arch/powerpc/Kconfig.debug                         |   4 -
 arch/powerpc/Makefile                              |  11 +-
 arch/powerpc/boot/dts/Makefile                     |   1 +
 arch/powerpc/boot/dts/akebono.dts                  |   2 +-
 arch/powerpc/boot/dts/bluestone.dts                |   2 +-
 arch/powerpc/boot/dts/currituck.dts                |   2 +-
 arch/powerpc/boot/dts/iss4xx-mpic.dts              |   2 +-
 arch/powerpc/boot/dts/wii.dts                      |  22 +
 arch/powerpc/include/asm/asm-prototypes.h          |  14 +-
 arch/powerpc/include/asm/book3s/32/mmu-hash.h      |   2 +
 arch/powerpc/include/asm/book3s/32/pgtable.h       |  11 +
 arch/powerpc/include/asm/book3s/64/hash.h          |  32 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |   2 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |   8 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  16 +-
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  30 +-
 arch/powerpc/include/asm/checksum.h                |   4 -
 arch/powerpc/include/asm/device.h                  |  10 +-
 arch/powerpc/include/asm/dma-direct.h              |  18 +-
 arch/powerpc/include/asm/dma-mapping.h             |  92 ----
 arch/powerpc/include/asm/eeh.h                     |  10 +-
 arch/powerpc/include/asm/eeh_event.h               |   1 +
 arch/powerpc/include/asm/exception-64s.h           |   4 +-
 arch/powerpc/include/asm/hvsi.h                    |   2 +-
 arch/powerpc/include/asm/iommu.h                   |  17 +
 arch/powerpc/include/asm/ipic.h                    |   3 -
 arch/powerpc/include/asm/irq.h                     |  18 +-
 arch/powerpc/include/asm/kvm_ppc.h                 |   3 +-
 arch/powerpc/include/asm/livepatch.h               |   7 +-
 arch/powerpc/include/asm/machdep.h                 |   4 +-
 arch/powerpc/include/asm/mce.h                     |   2 +-
 arch/powerpc/include/asm/mmu.h                     |  13 +
 arch/powerpc/include/asm/nmi.h                     |   2 +
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h       |   3 +-
 arch/powerpc/include/asm/page.h                    |  14 +-
 arch/powerpc/include/asm/pci-bridge.h              |   7 +-
 arch/powerpc/include/asm/pci.h                     |   2 -
 arch/powerpc/include/asm/pgtable.h                 |   1 -
 arch/powerpc/include/asm/powernv.h                 |   3 +-
 arch/powerpc/include/asm/ppc-opcode.h              |  16 +-
 arch/powerpc/include/asm/ppc-pci.h                 |   4 +-
 arch/powerpc/include/asm/processor.h               | 108 +----
 arch/powerpc/include/asm/ptrace.h                  |   2 +-
 arch/powerpc/include/asm/reg.h                     |   9 +-
 arch/powerpc/include/asm/sections.h                |   7 +
 arch/powerpc/include/asm/smp.h                     |  17 +-
 arch/powerpc/include/asm/swiotlb.h                 |   5 -
 arch/powerpc/include/asm/task_size_32.h            |  21 +
 arch/powerpc/include/asm/task_size_64.h            |  79 +++
 arch/powerpc/include/asm/thread_info.h             |  19 -
 arch/powerpc/include/asm/topology.h                |   2 +
 arch/powerpc/kernel/Makefile                       |  15 +-
 arch/powerpc/kernel/asm-offsets.c                  |  15 +-
 arch/powerpc/kernel/cpu_setup_6xx.S                |   4 +
 arch/powerpc/kernel/dma-iommu.c                    |  75 ++-
 arch/powerpc/kernel/dma-mask.c                     |  12 +
 arch/powerpc/kernel/dma-swiotlb.c                  |  89 ----
 arch/powerpc/kernel/dma.c                          | 362 --------------
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |  17 +-
 arch/powerpc/kernel/eeh.c                          | 190 ++++++--
 arch/powerpc/kernel/eeh_cache.c                    |  36 +-
 arch/powerpc/kernel/eeh_driver.c                   |  86 ++--
 arch/powerpc/kernel/eeh_event.c                    |  16 +-
 arch/powerpc/kernel/eeh_pe.c                       |  68 ++-
 arch/powerpc/kernel/eeh_sysfs.c                    |   3 +-
 arch/powerpc/kernel/entry_32.S                     |  97 ++--
 arch/powerpc/kernel/entry_64.S                     |  53 +-
 arch/powerpc/kernel/epapr_hcalls.S                 |   5 +-
 arch/powerpc/kernel/exceptions-64e.S               |  14 +-
 arch/powerpc/kernel/exceptions-64s.S               |  94 +++-
 arch/powerpc/kernel/head_32.S                      | 160 +++---
 arch/powerpc/kernel/head_40x.S                     |   9 +-
 arch/powerpc/kernel/head_44x.S                     |   8 +-
 arch/powerpc/kernel/head_64.S                      |  20 +-
 arch/powerpc/kernel/head_8xx.S                     | 124 +++--
 arch/powerpc/kernel/head_booke.h                   |  12 +-
 arch/powerpc/kernel/head_fsl_booke.S               |  16 +-
 arch/powerpc/kernel/idle_6xx.S                     |   8 +-
 arch/powerpc/kernel/idle_book3e.S                  |   2 +-
 arch/powerpc/kernel/idle_e500.S                    |   8 +-
 arch/powerpc/kernel/idle_power4.S                  |   2 +-
 arch/powerpc/kernel/irq.c                          | 119 +----
 arch/powerpc/kernel/kgdb.c                         |  28 --
 arch/powerpc/kernel/machine_kexec_64.c             |   6 +-
 arch/powerpc/kernel/mce.c                          |  11 +-
 arch/powerpc/kernel/misc_32.S                      |  17 +-
 arch/powerpc/kernel/pci-common.c                   |  21 +-
 arch/powerpc/kernel/process.c                      |  68 +--
 arch/powerpc/kernel/ptrace.c                       |  18 +-
 arch/powerpc/kernel/setup-common.c                 |   5 +-
 arch/powerpc/kernel/setup_32.c                     |  26 +-
 arch/powerpc/kernel/setup_64.c                     |  51 +-
 arch/powerpc/kernel/smp.c                          | 109 ++---
 arch/powerpc/kernel/stacktrace.c                   | 102 ++--
 arch/powerpc/kernel/syscalls.c                     |   2 +-
 arch/powerpc/kernel/syscalls/syscalltbl.sh         |   4 +-
 arch/powerpc/kernel/systbl.S                       |   6 +-
 arch/powerpc/kernel/time.c                         |   1 -
 arch/powerpc/kernel/trace/Makefile                 |   3 +-
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S     |   6 +-
 arch/powerpc/kernel/traps.c                        | 133 ++++-
 arch/powerpc/kernel/udbg.c                         |   2 +-
 arch/powerpc/kernel/vdso32/Makefile                |   1 +
 arch/powerpc/kernel/vdso64/Makefile                |   1 +
 arch/powerpc/kernel/vmlinux.lds.S                  |  14 +-
 arch/powerpc/kvm/Makefile                          |   5 -
 arch/powerpc/kvm/book3s.c                          |   7 +
 arch/powerpc/kvm/book3s_hv.c                       |  25 +-
 arch/powerpc/kvm/book3s_hv_hmi.c                   |   1 +
 arch/powerpc/kvm/book3s_hv_ras.c                   |  58 +--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |  66 +--
 arch/powerpc/lib/Makefile                          |   3 +-
 arch/powerpc/lib/sstep.c                           | 114 ++++-
 arch/powerpc/lib/test_emulate_step.c               | 535 +++++++++++++++++=
+++-
 arch/powerpc/lib/test_emulate_step_exec_instr.S    | 150 ++++++
 arch/powerpc/math-emu/Makefile                     |   2 +-
 arch/powerpc/mm/40x_mmu.c                          |   2 +-
 arch/powerpc/mm/44x_mmu.c                          |   2 +-
 arch/powerpc/mm/8xx_mmu.c                          |  91 ++--
 arch/powerpc/mm/Makefile                           |  15 +-
 arch/powerpc/mm/dma-noncoherent.c                  |  40 +-
 arch/powerpc/mm/fsl_booke_mmu.c                    |   2 +-
 arch/powerpc/mm/hash_low_32.S                      |  76 ++-
 arch/powerpc/mm/hash_utils_64.c                    |   6 +-
 arch/powerpc/mm/hugetlbpage-hash64.c               |   3 +-
 arch/powerpc/mm/hugetlbpage-radix.c                |   5 +-
 arch/powerpc/mm/init_32.c                          |   6 +-
 arch/powerpc/mm/init_64.c                          |   2 -
 arch/powerpc/mm/mem.c                              |  61 +--
 arch/powerpc/mm/mmu_decl.h                         |  10 +-
 arch/powerpc/mm/numa.c                             |   9 +-
 arch/powerpc/mm/pgtable_32.c                       |  42 +-
 arch/powerpc/mm/ppc_mmu_32.c                       | 186 +++++--
 .../{dump_linuxpagetables-8xx.c =3D> ptdump/8xx.c}   |   2 +-
 arch/powerpc/mm/ptdump/Makefile                    |   9 +
 arch/powerpc/mm/{dump_bats.c =3D> ptdump/bats.c}     |   0
 .../book3s64.c}                                    |   2 +-
 .../hashpagetable.c}                               |   2 +-
 .../mm/{dump_linuxpagetables.c =3D> ptdump/ptdump.c} |  20 +-
 .../mm/{dump_linuxpagetables.h =3D> ptdump/ptdump.h} |   0
 .../mm/{dump_sr.c =3D> ptdump/segment_regs.c}        |   0
 .../shared.c}                                      |   2 +-
 arch/powerpc/mm/slb.c                              |   5 +
 arch/powerpc/mm/slice.c                            |  10 +-
 arch/powerpc/mm/tlb_nohash.c                       |   2 +-
 arch/powerpc/net/bpf_jit32.h                       |   5 +-
 arch/powerpc/perf/power9-events-list.h             |  24 +
 arch/powerpc/perf/power9-pmu.c                     |   4 +
 arch/powerpc/platforms/44x/Kconfig                 |   1 +
 arch/powerpc/platforms/44x/ppc476.c                |   1 +
 arch/powerpc/platforms/44x/warp.c                  |   2 +-
 arch/powerpc/platforms/83xx/suspend-asm.S          |  34 +-
 arch/powerpc/platforms/85xx/corenet_generic.c      |   5 +-
 arch/powerpc/platforms/85xx/ge_imp3a.c             |   2 -
 arch/powerpc/platforms/85xx/mpc8536_ds.c           |   2 -
 arch/powerpc/platforms/85xx/mpc85xx_ds.c           |   4 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   4 -
 arch/powerpc/platforms/85xx/p1010rdb.c             |   1 -
 arch/powerpc/platforms/85xx/p1022_ds.c             |   2 -
 arch/powerpc/platforms/85xx/p1022_rdk.c            |   2 -
 arch/powerpc/platforms/85xx/qemu_e500.c            |   1 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |   1 -
 arch/powerpc/platforms/Kconfig.cputype             |   9 +
 arch/powerpc/platforms/cell/iommu.c                | 172 +------
 arch/powerpc/platforms/cell/spu_callbacks.c        |   2 +-
 arch/powerpc/platforms/cell/spu_syscalls.c         |   1 -
 arch/powerpc/platforms/cell/spufs/file.c           |   5 +-
 arch/powerpc/platforms/embedded6xx/wii.c           |  24 -
 arch/powerpc/platforms/pasemi/iommu.c              |   2 +-
 arch/powerpc/platforms/pasemi/setup.c              |  51 --
 arch/powerpc/platforms/powernv/Makefile            |   5 +-
 arch/powerpc/platforms/powernv/idle.c              |  27 +-
 arch/powerpc/platforms/powernv/npu-dma.c           |  16 +-
 arch/powerpc/platforms/powernv/opal-call.c         | 283 +++++++++++
 arch/powerpc/platforms/powernv/opal-msglog.c       |   2 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S     | 344 ++-----------
 arch/powerpc/platforms/powernv/opal.c              |   3 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c      |   1 -
 arch/powerpc/platforms/powernv/pci-ioda.c          | 146 ++----
 arch/powerpc/platforms/powernv/smp.c               |  25 +
 arch/powerpc/platforms/ps3/device-init.c           |   4 +-
 arch/powerpc/platforms/ps3/os-area.c               |   4 +-
 arch/powerpc/platforms/ps3/system-bus.c            |   4 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |  19 +
 arch/powerpc/platforms/pseries/iommu.c             |  99 +---
 arch/powerpc/platforms/pseries/lparcfg.c           |   1 +
 arch/powerpc/platforms/pseries/vio.c               |  95 ++--
 arch/powerpc/sysdev/6xx-suspend.S                  |   5 +-
 arch/powerpc/sysdev/dart_iommu.c                   |  58 +--
 arch/powerpc/sysdev/fsl_pci.c                      |  25 +-
 arch/powerpc/sysdev/ipic.c                         |  35 --
 arch/powerpc/sysdev/tsi108_dev.c                   |   2 +-
 arch/powerpc/sysdev/xive/common.c                  |   2 +-
 arch/powerpc/xmon/Makefile                         |   1 +
 arch/powerpc/xmon/ppc-dis.c                        |   2 +-
 arch/powerpc/xmon/xmon.c                           |   2 +-
 drivers/misc/cxl/guest.c                           |   2 +
 drivers/misc/cxl/pci.c                             |  39 +-
 drivers/misc/cxl/vphb.c                            |   3 +-
 drivers/net/ethernet/pasemi/pasemi_mac.c           |   1 +
 drivers/vfio/vfio_spapr_eeh.c                      |   6 +-
 include/linux/swiotlb.h                            |   3 -
 kernel/dma/Kconfig                                 |   3 +
 kernel/dma/direct.c                                |   3 +-
 kernel/dma/mapping.c                               |  11 +-
 kernel/dma/swiotlb.c                               |  12 -
 kernel/resource.c                                  |   4 -
 .../selftests/powerpc/benchmarks/null_syscall.c    |   2 +-
 tools/testing/selftests/powerpc/include/reg.h      |   8 +
 tools/testing/selftests/powerpc/include/utils.h    |   2 +
 .../selftests/powerpc/pmu/ebb/fork_cleanup_test.c  |   1 -
 tools/testing/selftests/powerpc/tm/.gitignore      |   1 +
 tools/testing/selftests/powerpc/tm/Makefile        |   4 +-
 .../powerpc/tm/tm-signal-context-force-tm.c        | 184 +++++++
 tools/testing/selftests/vm/map_hugetlb.c           |  29 +-
 216 files changed, 3619 insertions(+), 2991 deletions(-)
 create mode 100644 arch/powerpc/include/asm/task_size_32.h
 create mode 100644 arch/powerpc/include/asm/task_size_64.h
 create mode 100644 arch/powerpc/kernel/dma-mask.c
 delete mode 100644 arch/powerpc/kernel/dma.c
 create mode 100644 arch/powerpc/lib/test_emulate_step_exec_instr.S
 rename arch/powerpc/mm/{dump_linuxpagetables-8xx.c =3D> ptdump/8xx.c} (97%)
 create mode 100644 arch/powerpc/mm/ptdump/Makefile
 rename arch/powerpc/mm/{dump_bats.c =3D> ptdump/bats.c} (100%)
 rename arch/powerpc/mm/{dump_linuxpagetables-book3s64.c =3D> ptdump/book3s=
64.c} (98%)
 rename arch/powerpc/mm/{dump_hashpagetable.c =3D> ptdump/hashpagetable.c} =
(99%)
 rename arch/powerpc/mm/{dump_linuxpagetables.c =3D> ptdump/ptdump.c} (94%)
 rename arch/powerpc/mm/{dump_linuxpagetables.h =3D> ptdump/ptdump.h} (100%)
 rename arch/powerpc/mm/{dump_sr.c =3D> ptdump/segment_regs.c} (100%)
 rename arch/powerpc/mm/{dump_linuxpagetables-generic.c =3D> ptdump/shared.=
c} (97%)
 create mode 100644 arch/powerpc/platforms/powernv/opal-call.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-fo=
rce-tm.c
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcgRh2AAoJEFHr6jzI4aWA4FUQAKLSJ8WL30ez49KGsQbaOx0O
efhhYBYLPIbM/dm4Z0i9enKaOth9g+xDoxHj18E6bwL/IxOPe5O/fgo/JdPVfrgd
R0a53NEmx9c+cwJ1qzxUWuYF09g3+nGOHRRhDDeu4eiSC16zpym33jQzJNdhcuDX
6nhBBL7BRUTxiMnFa8ti9UNG5YmYIwNC4kycaXGzv2wjLbQs2i90XVXAev1xhdY4
lCHdx9oY4YCScraPeREA0ARMQI8uWvcmIG3UZ24gGd4TR7Pf/6UOBMyJ1JStQNhQ
2JM8aahrtY9Z2Cmt/UvPSe1DlE34YLN20vSwYGwihSW1JJrEDOVC5SIeslDE/k46
/6b92l1sZJDgT1OIWk7gmpwP9B7IzLI4CNuqmjs3sOO39UBFmhGq1NgglTxx63ul
w//kFhrVV0lqY0yzwpBnwWcsZtPPozCdPCCcFiRJ/BPLIsTlQtyGOOVqM42rOXez
MKB2yBzils33YEq9c9be+jWDJ3WvWK/MFzJYjw0sg6mebS5uJGJGGbGEcXHm1MiU
3o2IG0I8uvFvVuM0lI/NshId8lntVVPyfsGFq0bkQ4H6sEi1t7Og+LMfTEzvNB7C
ks9VvwJX+VI9dRM8S3OMa5rCv+cn5QNlfWlDSJ3mGPWAarVfFEao54ukIP+cEmR2
4ko9HU39nbrhLVPLr8oY
=3D8u6h
-----END PGP SIGNATURE-----
