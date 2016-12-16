Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg2Mf5Gs3zDwB9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 18:42:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: afleming@gmail.com, aik@ozlabs.ru, alex.williamson@redhat.com,
 andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 anton@au.ibm.com, anton@samba.org, b.zolnierkie@samsung.com,
 bauerman@linux.vnet.ibm.com, benh@kernel.crashing.org, boqun.feng@gmail.com,
 bsingharora@gmail.com, christophe.jaillet@wanadoo.fr, christophe.leroy@c-s.fr,
 claudiu.manoil@nxp.com, colin.king@canonical.com, david.engraf@sysgo.com,
 dyoung@redhat.com, ego@linux.vnet.ibm.com, fabf@skynet.be,
 fbarrat@linux.vnet.ibm.com, fl@n621.de, geliangtang@gmail.com,
 geoff@infradead.org, gwshan@linux.vnet.ibm.com, hkallweit1@gmail.com,
 huawei.libin@huawei.com, imunsie@au1.ibm.com, jack@codezen.org,
 johan@kernel.org, kda@linux-powerpc.org, khandual@linux.vnet.ibm.com,
 lars@metafoo.de, leolow@au1.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, madalin.bucur@nxp.com, maddy@linux.vnet.ibm.com,
 mikey@neuling.org, naveen.n.rao@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 npiggin@gmail.com, oss@bus
 error.net, paulus@ozlabs.org, peter.senna@gmail.com, peterz@infradead.org,
 rashmicy@gmail.com, riesebie@lxtec.de, robh@kernel.org,
 rui.teng@linux.vnet.ibm.com, ruscur@russell.cc, sjitindarsingh@gmail.com,
 tklauser@distanz.ch, vaibhav@linux.vnet.ibm.com, wei.guo.simon@gmail.com,
 weiyongjun1@huawei.com, xinhui.pan@linux.vnet.ibm.com, paulus@samba.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.10-1 tag
Date: Fri, 16 Dec 2016 18:42:20 +1100
Message-ID: <87mvfwialf.fsf@concordia.ellerman.id.au>
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

Please pull powerpc updates for 4.10:

The following changes since commit a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6:

  Linux 4.9-rc5 (2016-11-13 10:32:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.10-1

for you to fetch changes up to c6f6634721c871bfab4235e1cbcad208d3063798:

  Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux into next (2016-12-16 15:05:38 +1100)


The change to the generic and arch/x86 kexec code were acked by Dave Young, and
have been in linux-next for a long time.

I see one conflict in asm-prototypes.h, AFAICS the resolution is to drop
the include of linux/kprobes.h and keep the rest.

cheers

----------------------------------------------------------------
powerpc updates for 4.10

Highlights include:

 - Support for the kexec_file_load() syscall, which is a prereq for secure and
   trusted boot.

 - Prevent kernel execution of userspace on P9 Radix (similar to SMEP/PXN).

 - Sort the exception tables at build time, to save time at boot, and store
   them as relative offsets to save space in the kernel image & memory.

 - Allow building the kernel with thin archives, which should allow us to build
   an allyesconfig once some other fixes land.

 - Build fixes to allow us to correctly rebuild when changing the kernel endian
   from big to little or vice versa.

 - Plumbing so that we can avoid doing a full mm TLB flush on P9 Radix.

 - Initial stack protector support (-fstack-protector).

 - Support for dumping the radix (aka. Linux) and hash page tables via debugfs.

 - Fix an oops in cxl coredump generation when cxl_get_fd() is used.

 - Freescale updates from Scott: "Highlights include 8xx hugepage support,
   qbman fixes/cleanup, device tree updates, and some misc cleanup."

 - Many and varied fixes and minor enhancements as always.

Thanks to:
  Alexey Kardashevskiy, Andrew Donnellan, Aneesh Kumar K.V, Anshuman Khandual,
  Anton Blanchard, Balbir Singh, Bartlomiej Zolnierkiewicz, Christophe Jaillet,
  Christophe Leroy, Denis Kirjanov, Elimar Riesebieter, Frederic Barrat,
  Gautham R. Shenoy, Geliang Tang, Geoff Levand, Jack Miller, Johan Hovold,
  Lars-Peter Clausen, Libin, Madhavan Srinivasan, Michael Neuling, Nathan
  Fontenot, Naveen N. Rao, Nicholas Piggin, Pan Xinhui, Peter Senna Tschudin,
  Rashmica Gupta, Rui Teng, Russell Currey, Scott Wood, Simon Guo, Suraj
  Jitindar Singh, Thiago Jung Bauermann, Tobias Klauser, Vaibhav Jain.

----------------------------------------------------------------
Alexey Kardashevskiy (7):
      powerpc/iommu: Pass mm_struct to init/cleanup helpers
      powerpc/iommu: Stop using @current in mm_iommu_xxx
      vfio/spapr: Postpone allocation of userspace version of TCE table
      vfio/spapr: Add a helper to create default DMA window
      vfio/spapr: Postpone default window creation
      vfio/spapr: Reference mm in tce_container
      powerpc/mm/iommu, vfio/spapr: Put pages on VFIO container shutdown

Andrew Donnellan (1):
      cxl: Fix coccinelle warnings

Andy Fleming (1):
      powerpc/85xx: Enable gpio power/reset driver

Aneesh Kumar K.V (8):
      powerpc/mm/coproc: Handle bad address on coproc slb fault
      powerpc/mm: Rename hugetlb-radix.h to hugetlb.h
      powerpc/mm/hugetlb: Handle hugepage size supported by hash config
      powerpc/mm: Introduce _PAGE_LARGE software pte bits
      powerpc/mm: Add radix__tlb_flush_pte_p9_dd1()
      powerpc/mm: update radix__ptep_set_access_flag to not do full mm tlb flush
      powerpc/mm: update radix__pte_update to not do full mm tlb flush
      powerpc/mm: Batch tlb flush when invalidating pte entries

Anshuman Khandual (11):
      selftests/powerpc: Add more SPR numbers, TM & VMX instructions to 'reg.h'/'instructions.h'
      selftests/powerpc: Add ptrace tests for GPR/FPR registers
      selftests/powerpc: Add ptrace tests for GPR/FPR registers in TM
      selftests/powerpc: Add ptrace tests for GPR/FPR registers in suspended TM
      selftests/powerpc: Add ptrace tests for TAR, PPR, DSCR registers
      selftests/powerpc: Add ptrace tests for TAR, PPR, DSCR in TM
      selftests/powerpc: Add ptrace tests for TAR, PPR, DSCR in suspended TM
      selftests/powerpc: Add ptrace tests for VSX, VMX registers
      selftests/powerpc: Add ptrace tests for VSX, VMX registers in TM
      selftests/powerpc: Add ptrace tests for VSX, VMX registers in suspended TM
      selftests/powerpc: Add ptrace tests for TM SPR registers

Anton Blanchard (2):
      selftests/powerpc: Add Anton's null_syscall benchmark to the selftests
      powerpc/pseries: Use H_CLEAR_HPT to clear MMU hash table during kexec

Balbir Singh (7):
      powerpc/hash64: Be more careful when generating tlbiel
      powerpc/mm: Fix typo in radix encodings print
      powerpc/mm/radix: Setup AMOR in HV mode to allow key 0
      powerpc/mm: Detect instruction fetch denied and report
      powerpc/mm/radix: Prevent kernel execution of user space
      powerpc/mm: Fix no execute fault handling on pre-POWER5
      powerpc Don't print misleading facility name in facility unavailable exception

Bartlomiej Zolnierkiewicz (12):
      powerpc: convert amigaone_defconfig to use libata PATA drivers
      powerpc: convert cell_defconfig to use libata PATA drivers
      powerpc: convert chrp32_defconfig to use libata PATA drivers
      powerpc: convert g5_defconfig to use libata PATA drivers
      powerpc: convert maple_defconfig to use libata PATA drivers
      powerpc: disable IDE subsystem in pasemi_defconfig
      powerpc: convert pmac32_defconfig to use libata PATA drivers
      powerpc: convert ppc64_defconfig to use libata PATA drivers
      powerpc: convert ppc64e_defconfig to use libata PATA drivers
      powerpc: convert ppc6xx_defconfig to use libata PATA drivers
      powerpc: convert pseries_defconfig to use libata PATA drivers
      powerpc: convert storcenter_defconfig to use libata PATA drivers

Christophe Jaillet (3):
      cxl: Fix memory allocation failure test
      cxl: Fix error handling in _cxl_cx4_setup_msi_irqs()
      cxl: Fix error handling in _cxl_pci_associate_default_context()

Christophe Leroy (6):
      powerpc/64: get rid of MIN_HUGEPTE_SHIFT
      powerpc: Initial stack protector (-fstack-protector) support
      powerpc/32: Change the stack protector canary value per task
      powerpc: port 64 bits pgtable_cache to 32 bits
      powerpc: get hugetlbpage handling more generic
      powerpc/8xx: Implement support of hugepages

Claudiu Manoil (15):
      soc/qman: Fix h/w resource cleanup error path handling
      soc/qbman: Fix resource leak on portal probing error path
      soc/qman: Fix struct qm_fqd set accessor for context_a
      soc/qman: Fix direct access to fd's addr_lo, use proper accesor
      soc/qman: test: Fix implementation of fd_cmp()
      soc/qman: Don't add a new platform device for dma mapping
      soc/qman: test: Don't use dummy platform device for dma mapping
      soc/qman: Remove redundant checks from qman_create_cgr()
      soc/qman: Remove unused struct qm_mcc* layouts
      soc/qman: Fix accesses to fqid, cleanup
      soc/qman: Drop unused field from eqcr/dqrr descriptors
      soc/qbman: Handle endianness of qm/bm_in/out()
      soc/qman: Change remaining contextB into context_b
      soc/qman: Clean up CGR CSCN target update operations
      soc/qman: Handle endianness of h/w descriptors

Colin Ian King (1):
      soc/fsl: fix spelling mistakes in critical error messages

David Engraf (1):
      powerpc/85xx/qemu: Enable CONFIG_E500 and CONFIG_PPC_E500MC

Denis Kirjanov (1):
      i2c_powermac: shut up lockdep warning

Elimar Riesebieter (1):
      macintosh: Remove dependency on IDE_GD_ATA if ADB_PMU_LED_DISK is selected

Fabian Frederick (2):
      powerpc/fsl-lbc: use DEFINE_SPINLOCK()
      soc/fsl/qman: test: use DEFINE_SPINLOCK()

Florian Larysch (2):
      DT: i2c: W83793 is a trivial device
      powerpc/dts: add device tree entry for W83793 on T4240RDB

Frederic Barrat (1):
      cxl: Fix coredump generation when cxl_get_fd() is used

Gautham R. Shenoy (1):
      powernv: Clear SPRN_PSSCR when a POWER9 CPU comes online

Geliang Tang (5):
      cxl: drop duplicate header sched.h
      powerpc/of_platform: Use builtin_platform_driver
      powerpc/83xx/suspend: use builtin_platform_driver
      powerpc/fsl_pmc: use builtin_platform_driver
      soc/fsl/qe: use builtin_platform_driver

Geoff Levand (1):
      powerpc/ps3: Fix system hang with GCC 5 builds

Heiner Kallweit (3):
      powerpc/fsl_soc: improve and simplify fsl_get_sys_freq
      powerpc/fsl_soc: improve and simplify get_brgfreq
      powerpc/fsl_soc: improve and simplify get_baudrate

Jack Miller (1):
      powerpc/powernv: Simplify searching for compatible device nodes

Johan Hovold (4):
      powerpc/ibmebus: Fix device reference leaks in sysfs interface
      powerpc/ibmebus: Fix further device reference leaks
      powerpc/vio: Clarify vio_find_node() reference counting
      powerpc/pci/rpadlpar: Fix device reference leaks

Lars-Peter Clausen (1):
      powerpc/pseries/ibmebus: Remove legacy suspend/resume support

Libin (1):
      powerpc/ftrace: Fix the comments for ftrace_modify_code

Madalin Bucur (6):
      soc/qman: Check ioremap return value
      soc/qman: Replace of_get_property() with portable equivalent
      powerpc/fsl/dts: add QMan and BMan nodes on t1023
      powerpc/fsl/dts: add QMan and BMan nodes on t1024
      powerpc/fsl/dts: add sg_2500_aqr105_phy4 alias on t1024rdb
      powerpc/fsl/dts: add FMan node for t1042d4rdb

Madhavan Srinivasan (4):
      powerpc/perf: factor out the event format field
      powerpc/perf: update attribute_group data structure
      powerpc/perf: power9 raw event format encoding
      powerpc/perf: macros for power9 format encoding

Michael Ellerman (27):
      powerpc/asm: Allow including ppc_asm.h in asm files
      powerpc/module: Add support for R_PPC64_REL32 relocations
      selftests/powerpc: Abort load_unaligned_zeropad on unhandled SEGV
      selftests/powerpc: Fail load_unaligned_zeropad on miscompare
      powerpc/book3s64: Always build for power4 or later
      powerpc/configs: Drop REISERFS from pseries & powernv
      powerpc/pseries: Move CMO code from plapr_wrappers.h to platforms/pseries
      powerpc/lib: Fix randconfig build failure in sstep.c
      powerpc/pseries: Move vio.c into platforms pseries
      powerpc/pseries: Move ibmebus.c into platforms pseries
      powerpc/pseries: Disable IBMEBUS on little endian builds
      powerpc/configs: Turn on PPC crypto implementations in the server defconfigs
      powerpc/64: Used named initialisers for ibm_pa_features
      powerpc/reg: Add definition for LPCR_PECE_HVEE
      Merge branch 'topic/ppc-kvm' into next
      powerpc: Fix __cmpxchg() to take a volatile ptr again
      powerpc/xmon: Add 'dt' command to dump trace buffers
      powerpc: Stop passing ARCH=ppc64 to boot Makefile
      powerpc/boot: All uses of if_changed should depend on FORCE
      powerpc/boot: Fix rebuild when changing kernel endian
      powerpc/prom: Define structs for client architecture vectors
      powerpc/prom: Switch to using structs for ibm_architecture_vec
      powerpc/mm: Fix page table dump build on non-Book3S
      powerpc/cell: Drop select of MEMORY_HOTPLUG
      powerpc: Make selects of IBM_EMAC_* depend on IBM_EMAC
      powerpc/64: Define ILLEGAL_POINTER_VALUE for 64-bit
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into next

Michael Neuling (3):
      selftests/powerpc: Revert Load Monitor Register Tests
      powerpc: Revert Load Monitor Register Support
      powerpc/powernv: Define and set POWER9 HFSCR doorbell bit

Nathan Fontenot (2):
      powerpc/pseries: Correct possible read beyond dlpar sysfs buffer
      powerpc/pseries: Use lmb_is_removable() to check removability

Naveen N. Rao (2):
      powerpc: Remove extraneous header from asm-prototypes.h
      powerpc/kprobes: Invoke handlers directly

Nicholas Piggin (13):
      powerpc/64s: Reduce exception alignment
      powerpc: EX_TABLE macro for exception tables
      powerpc: Add support for relative exception tables
      powerpc: Build-time sort the exception table
      powerpc: Make _ASM_NOKPROBE_SYMBOL a noop when KPROBES not defined
      powerpc/64: Add an option to force run-at-load to test relocation
      powerpc: Add option to use thin archives
      powerpc: Fix graceful debugger recovery
      powerpc: Fix second nested oops hang
      powerpc/64e: Convert cmpi to cmpwi in head_64.S
      powerpc/64e: Don't branch to dot symbols
      powerpc/pseries: add definitions for new H_SIGNAL_SYS_RESET hcall
      powerpc/boot: Request no dynamic linker for boot wrapper

Pan Xinhui (1):
      powerpc: Implement {cmp}xchg for u8 and u16

Paul Mackerras (4):
      powerpc/64: Simplify adaptation to new ISA v3.00 HPTE format
      powerpc/64: Add some more SPRs and SPR bits for POWER9
      powerpc/64: Provide functions for accessing POWER9 partition table
      powerpc/powernv: Define real-mode versions of OPAL XICS accessors

Peter Senna Tschudin (1):
      selftests/powerpc: Return false instead of -1 in require_paranoia_below()

Rashmica Gupta (2):
      powerpc/mm: Dump linux pagetables
      powerpc/mm: Dump hash table

Rui Teng (1):
      powerpc: Remove suspect CONFIG_PPC_BOOK3E #ifdefs in nohash/64/pgtable.h

Russell Currey (3):
      powerpc/powernv: Don't warn on PE init if unfreeze is unsupported
      powerpc/pci: Always print PHB and PE numbers as hexadecimal
      powerpc/eeh: Refactor EEH PE reset functions

Simon Guo (1):
      selftests/powerpc: Move shared headers into new include dir

Suraj Jitindar Singh (2):
      powerpc/mm: Correct process and partition table max size
      powerpc/64: Define new ISA v3.00 logical PVR value and PCR register value

Thiago Jung Bauermann (8):
      kexec_file: Allow arch-specific memory walking for kexec_add_buffer
      kexec_file: Change kexec_add_buffer to take kexec_buf as argument.
      kexec_file: Factor out kexec_locate_mem_hole from kexec_add_buffer.
      powerpc: Change places using CONFIG_KEXEC to use CONFIG_KEXEC_CORE instead.
      powerpc: Add support code for kexec_file_load()
      powerpc: Add purgatory for kexec_file_load() implementation.
      powerpc/kexec: Enable kexec_file_load() syscall
      powerpc: Enable CONFIG_KEXEC_FILE in powerpc server defconfigs.

Tobias Klauser (2):
      powerpc: Fix old style declaration GCC warnings
      powerpc/mce: Remove unused but set variable

Vaibhav Jain (1):
      cxl: Do adapter fence check before handling afu interrupt

Wei Yongjun (1):
      soc/fsl/bman: Use resource_size instead of computation
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 arch/powerpc/Kconfig                               |  41 +-
 arch/powerpc/Kconfig.debug                         |  16 +
 arch/powerpc/Makefile                              |  14 +-
 arch/powerpc/boot/Makefile                         |  30 +-
 arch/powerpc/boot/dts/fsl/t1023rdb.dts             |  29 +
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        | 103 +++
 arch/powerpc/boot/dts/fsl/t1024qds.dts             |  29 +
 arch/powerpc/boot/dts/fsl/t1024rdb.dts             |  33 +
 arch/powerpc/boot/dts/fsl/t1042d4rdb.dts           |  52 ++
 arch/powerpc/boot/dts/fsl/t4240rdb.dts             |   4 +
 arch/powerpc/boot/ps3-head.S                       |   5 -
 arch/powerpc/boot/ps3.c                            |   8 +-
 arch/powerpc/boot/wrapper                          |  24 +-
 arch/powerpc/configs/amigaone_defconfig            |  10 +-
 arch/powerpc/configs/cell_defconfig                |   7 +-
 arch/powerpc/configs/chrp32_defconfig              |  10 +-
 arch/powerpc/configs/fsl-emb-nonhw.config          |   6 +
 arch/powerpc/configs/g5_defconfig                  |   5 +-
 arch/powerpc/configs/maple_defconfig               |   9 +-
 arch/powerpc/configs/pasemi_defconfig              |   3 -
 arch/powerpc/configs/pmac32_defconfig              |  15 +-
 arch/powerpc/configs/powernv_defconfig             |   9 +-
 arch/powerpc/configs/ppc64_defconfig               |  14 +-
 arch/powerpc/configs/ppc64e_defconfig              |   6 +-
 arch/powerpc/configs/ppc6xx_defconfig              |  10 +-
 arch/powerpc/configs/pseries_defconfig             |  16 +-
 arch/powerpc/configs/storcenter_defconfig          |   5 +-
 arch/powerpc/include/asm/asm-prototypes.h          |   1 -
 arch/powerpc/include/asm/book3s/32/pgalloc.h       |  44 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |  43 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |   3 -
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |   3 -
 .../asm/book3s/64/{hugetlb-radix.h => hugetlb.h}   |  28 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  18 +-
 arch/powerpc/include/asm/book3s/64/radix.h         |  28 +-
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   2 +
 arch/powerpc/include/asm/cache.h                   |   3 +
 arch/powerpc/include/asm/cmpxchg.h                 | 107 +++-
 arch/powerpc/include/asm/debug.h                   |   2 +-
 arch/powerpc/include/asm/futex.h                   |  14 +-
 arch/powerpc/include/asm/head-64.h                 |   8 +-
 arch/powerpc/include/asm/hugetlb.h                 |  21 +-
 arch/powerpc/include/asm/hvcall.h                  |  30 +-
 arch/powerpc/include/asm/io.h                      |  19 +-
 arch/powerpc/include/asm/kexec.h                   |  16 +-
 arch/powerpc/include/asm/kprobes.h                 |   7 +
 arch/powerpc/include/asm/machdep.h                 |   4 +-
 arch/powerpc/include/asm/mmu-8xx.h                 |  35 +
 arch/powerpc/include/asm/mmu.h                     |  23 +-
 arch/powerpc/include/asm/mmu_context.h             |  20 +-
 arch/powerpc/include/asm/module.h                  |   4 -
 arch/powerpc/include/asm/nohash/32/pgalloc.h       |  44 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  45 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |   1 +
 arch/powerpc/include/asm/nohash/64/pgtable-4k.h    |   3 -
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h   |   3 -
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  19 +-
 arch/powerpc/include/asm/nohash/pgtable.h          |   4 +
 arch/powerpc/include/asm/pgtable.h                 |   2 +
 arch/powerpc/include/asm/plpar_wrappers.h          |  37 +-
 arch/powerpc/include/asm/ppc-pci.h                 |   2 +-
 arch/powerpc/include/asm/ppc_asm.h                 |  20 +-
 arch/powerpc/include/asm/processor.h               |   2 -
 arch/powerpc/include/asm/prom.h                    |   6 -
 arch/powerpc/include/asm/reg.h                     |   5 -
 arch/powerpc/include/asm/reg_8xx.h                 |   2 +-
 arch/powerpc/include/asm/smp.h                     |   2 +-
 arch/powerpc/include/asm/stackprotector.h          |  40 ++
 arch/powerpc/include/asm/systbl.h                  |   1 +
 arch/powerpc/include/asm/uaccess.h                 |  52 +-
 arch/powerpc/include/asm/unistd.h                  |   2 +-
 arch/powerpc/include/asm/word-at-a-time.h          |   6 +-
 arch/powerpc/include/uapi/asm/unistd.h             |   1 +
 arch/powerpc/kernel/Makefile                       |  11 +-
 arch/powerpc/kernel/asm-offsets.c                  |   3 +
 arch/powerpc/kernel/cpu_setup_power.S              |   2 +
 arch/powerpc/kernel/eeh.c                          |  84 ++-
 arch/powerpc/kernel/eeh_driver.c                   |  12 +-
 arch/powerpc/kernel/eeh_event.c                    |   4 +-
 arch/powerpc/kernel/eeh_pe.c                       |   4 +-
 arch/powerpc/kernel/entry_32.S                     |   6 +-
 arch/powerpc/kernel/exceptions-64e.S               |   6 +-
 arch/powerpc/kernel/exceptions-64s.S               |   2 +-
 arch/powerpc/kernel/ftrace.c                       |  12 +-
 arch/powerpc/kernel/head_64.S                      |  19 +-
 arch/powerpc/kernel/head_8xx.S                     | 119 +++-
 arch/powerpc/kernel/kexec_elf_64.c                 | 663 +++++++++++++++++++
 arch/powerpc/kernel/kprobes.c                      |  31 +-
 arch/powerpc/kernel/machine_kexec_64.c             |   2 +-
 arch/powerpc/kernel/machine_kexec_file_64.c        | 338 ++++++++++
 arch/powerpc/kernel/mce.c                          |   3 -
 arch/powerpc/kernel/misc_32.S                      |   2 +-
 arch/powerpc/kernel/misc_64.S                      |   6 +-
 arch/powerpc/kernel/module_64.c                    |   5 +
 arch/powerpc/kernel/of_platform.c                  |   7 +-
 arch/powerpc/kernel/process.c                      |  24 +-
 arch/powerpc/kernel/prom.c                         |  23 +-
 arch/powerpc/kernel/prom_init.c                    | 295 ++++++---
 arch/powerpc/kernel/setup-common.c                 |   2 +-
 arch/powerpc/kernel/setup_64.c                     |   4 +-
 arch/powerpc/kernel/smp.c                          |   6 +-
 arch/powerpc/kernel/traps.c                        |  48 +-
 arch/powerpc/lib/checksum_32.S                     |  47 +-
 arch/powerpc/lib/checksum_64.S                     |  20 +-
 arch/powerpc/lib/copy_32.S                         |  55 +-
 arch/powerpc/lib/copyuser_64.S                     | 271 ++++----
 arch/powerpc/lib/copyuser_power7.S                 |  20 +-
 arch/powerpc/lib/ldstfp.S                          |  24 +-
 arch/powerpc/lib/sstep.c                           |  16 +-
 arch/powerpc/lib/string.S                          |  11 +-
 arch/powerpc/lib/string_64.S                       |  16 +-
 arch/powerpc/mm/Makefile                           |   5 +-
 arch/powerpc/mm/copro_fault.c                      |   3 +
 arch/powerpc/mm/dump_hashpagetable.c               | 551 ++++++++++++++++
 arch/powerpc/mm/dump_linuxpagetables.c             | 442 +++++++++++++
 arch/powerpc/mm/fault.c                            |  17 +-
 arch/powerpc/mm/hash_native_64.c                   |  10 +-
 arch/powerpc/mm/hugetlbpage.c                      | 216 +++----
 arch/powerpc/mm/init-common.c                      | 107 ++++
 arch/powerpc/mm/init_64.c                          |  77 ---
 arch/powerpc/mm/mmu_context_book3s64.c             |   6 +-
 arch/powerpc/mm/mmu_context_iommu.c                |  60 +-
 arch/powerpc/mm/pgtable-book3s64.c                 |   3 +-
 arch/powerpc/mm/pgtable-radix.c                    |  40 +-
 arch/powerpc/mm/pgtable.c                          |   2 +-
 arch/powerpc/mm/pgtable_32.c                       |  37 --
 arch/powerpc/mm/tlb-radix.c                        |  18 +
 arch/powerpc/mm/tlb_nohash.c                       |  21 +-
 arch/powerpc/perf/isa207-common.c                  |  91 ++-
 arch/powerpc/perf/isa207-common.h                  |  30 +-
 arch/powerpc/perf/power8-pmu.c                     |  39 +-
 arch/powerpc/perf/power9-pmu.c                     | 114 +++-
 arch/powerpc/platforms/40x/Kconfig                 |  12 +-
 arch/powerpc/platforms/44x/Kconfig                 |  56 +-
 arch/powerpc/platforms/83xx/suspend.c              |   6 +-
 arch/powerpc/platforms/85xx/Kconfig                |   2 +
 arch/powerpc/platforms/85xx/corenet_generic.c      |   2 +-
 arch/powerpc/platforms/85xx/smp.c                  |   8 +-
 arch/powerpc/platforms/8xx/Kconfig                 |   1 +
 arch/powerpc/platforms/Kconfig                     |  11 -
 arch/powerpc/platforms/Kconfig.cputype             |   1 +
 arch/powerpc/platforms/cell/Kconfig                |   9 +-
 arch/powerpc/platforms/cell/spu_base.c             |   2 +-
 arch/powerpc/platforms/embedded6xx/holly.c         |   2 +-
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c  |   2 +-
 arch/powerpc/platforms/powermac/low_i2c.c          |   4 +
 arch/powerpc/platforms/powernv/eeh-powernv.c       |   4 +-
 arch/powerpc/platforms/powernv/npu-dma.c           |   2 +-
 arch/powerpc/platforms/powernv/opal.c              |  24 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  40 +-
 arch/powerpc/platforms/powernv/pci.c               |   6 +-
 arch/powerpc/platforms/powernv/setup.c             |   6 +-
 arch/powerpc/platforms/ps3/setup.c                 |   4 +-
 arch/powerpc/platforms/pseries/Kconfig             |  11 +
 arch/powerpc/platforms/pseries/Makefile            |   4 +-
 arch/powerpc/platforms/pseries/cmm.c               |  34 +
 arch/powerpc/platforms/pseries/dlpar.c             | 142 ++--
 arch/powerpc/platforms/pseries/eeh_pseries.c       |   8 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c    |   7 +-
 .../{kernel => platforms/pseries}/ibmebus.c        | 314 +--------
 arch/powerpc/platforms/pseries/lpar.c              |  24 +-
 arch/powerpc/platforms/pseries/lparcfg.c           |   1 +
 arch/powerpc/platforms/pseries/pseries.h           |  19 +
 arch/powerpc/platforms/pseries/setup.c             |   4 +-
 arch/powerpc/{kernel => platforms/pseries}/vio.c   |   3 +
 arch/powerpc/purgatory/.gitignore                  |   2 +
 arch/powerpc/purgatory/Makefile                    |  15 +
 arch/powerpc/purgatory/trampoline.S                | 128 ++++
 arch/powerpc/sysdev/fsl_lbc.c                      |   2 +-
 arch/powerpc/sysdev/fsl_pmc.c                      |   6 +-
 arch/powerpc/sysdev/fsl_rio.c                      |   8 +-
 arch/powerpc/sysdev/fsl_soc.c                      |  48 +-
 arch/powerpc/sysdev/tsi108_pci.c                   |   6 +-
 arch/powerpc/xmon/xmon.c                           |   6 +
 arch/x86/kernel/crash.c                            |  37 +-
 arch/x86/kernel/kexec-bzimage64.c                  |  48 +-
 drivers/macintosh/Kconfig                          |   1 -
 drivers/misc/cxl/api.c                             | 147 ++++-
 drivers/misc/cxl/context.c                         |  17 +-
 drivers/misc/cxl/cxl.h                             |   6 +-
 drivers/misc/cxl/debugfs.c                         |   6 +-
 drivers/misc/cxl/file.c                            |   5 +-
 drivers/misc/cxl/guest.c                           |   2 +-
 drivers/misc/cxl/irq.c                             |   2 +-
 drivers/misc/cxl/native.c                          |  20 +-
 drivers/misc/cxl/pci.c                             |   2 +-
 drivers/misc/cxl/phb.c                             |   2 +-
 drivers/pci/hotplug/rpadlpar_core.c                |  10 +-
 drivers/soc/fsl/qbman/bman.c                       |   8 +-
 drivers/soc/fsl/qbman/bman_ccsr.c                  |   3 +-
 drivers/soc/fsl/qbman/bman_portal.c                |  17 +-
 drivers/soc/fsl/qbman/dpaa_sys.h                   |   1 +
 drivers/soc/fsl/qbman/qman.c                       | 233 ++++---
 drivers/soc/fsl/qbman/qman_ccsr.c                  |   3 +
 drivers/soc/fsl/qbman/qman_portal.c                |  41 +-
 drivers/soc/fsl/qbman/qman_priv.h                  |  17 +-
 drivers/soc/fsl/qbman/qman_test_api.c              |  27 +-
 drivers/soc/fsl/qbman/qman_test_stash.c            |  38 +-
 drivers/soc/fsl/qe/qe.c                            |   6 +-
 drivers/vfio/vfio_iommu_spapr_tce.c                | 328 ++++++----
 include/linux/kexec.h                              |  36 +-
 include/soc/fsl/qman.h                             |  62 +-
 kernel/kexec_file.c                                | 141 ++--
 kernel/kexec_internal.h                            |  16 -
 scripts/sortextable.c                              |   2 +
 tools/testing/selftests/powerpc/Makefile           |   5 +-
 .../selftests/powerpc/benchmarks/.gitignore        |   3 +-
 .../testing/selftests/powerpc/benchmarks/Makefile  |   2 +-
 .../selftests/powerpc/benchmarks/context_switch.c  |   2 +-
 .../selftests/powerpc/benchmarks/null_syscall.c    | 157 +++++
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |   2 +
 .../testing/selftests/powerpc/copyloops/validate.c |   2 +-
 tools/testing/selftests/powerpc/dscr/dscr.h        |  10 +-
 .../selftests/powerpc/{ => include}/basic_asm.h    |  37 +-
 .../selftests/powerpc/{ => include}/fpu_asm.h      |   0
 .../selftests/powerpc/{ => include}/gpr_asm.h      |   0
 .../selftests/powerpc/{ => include}/instructions.h |   0
 tools/testing/selftests/powerpc/include/reg.h      | 145 +++++
 .../selftests/powerpc/{ => include}/subunit.h      |   0
 .../selftests/powerpc/{ => include}/utils.h        |   0
 .../selftests/powerpc/{ => include}/vmx_asm.h      |   0
 .../selftests/powerpc/{ => include}/vsx_asm.h      |   0
 tools/testing/selftests/powerpc/lib/reg.S          | 397 ++++++++++++
 tools/testing/selftests/powerpc/math/fpu_asm.S     |   4 +-
 tools/testing/selftests/powerpc/math/vmx_asm.S     |   4 +-
 tools/testing/selftests/powerpc/math/vsx_asm.S     |   4 +-
 tools/testing/selftests/powerpc/pmu/ebb/.gitignore |   2 -
 tools/testing/selftests/powerpc/pmu/ebb/Makefile   |   2 +-
 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c  | 143 -----
 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h  |  39 --
 .../selftests/powerpc/pmu/ebb/ebb_lmr_regs.c       |  37 --
 tools/testing/selftests/powerpc/pmu/lib.c          |   6 +-
 .../selftests/powerpc/primitives/asm/firmware.h    |   0
 .../selftests/powerpc/primitives/asm/ppc_asm.h     |   1 +
 .../selftests/powerpc/primitives/asm/processor.h   |   0
 .../selftests/powerpc/primitives/linux/stringify.h |   0
 .../powerpc/primitives/load_unaligned_zeropad.c    |  21 +-
 tools/testing/selftests/powerpc/ptrace/.gitignore  |  10 +
 tools/testing/selftests/powerpc/ptrace/Makefile    |  14 +
 .../testing/selftests/powerpc/ptrace/ptrace-gpr.c  | 123 ++++
 .../testing/selftests/powerpc/ptrace/ptrace-gpr.h  |  74 +++
 .../testing/selftests/powerpc/ptrace/ptrace-tar.c  | 135 ++++
 .../testing/selftests/powerpc/ptrace/ptrace-tar.h  |  50 ++
 .../selftests/powerpc/ptrace/ptrace-tm-gpr.c       | 158 +++++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c   | 169 +++++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-tar.c   | 174 +++++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c   | 185 ++++++
 .../selftests/powerpc/ptrace/ptrace-tm-spr.c       | 168 +++++
 .../selftests/powerpc/ptrace/ptrace-tm-tar.c       | 160 +++++
 .../selftests/powerpc/ptrace/ptrace-tm-vsx.c       | 168 +++++
 .../testing/selftests/powerpc/ptrace/ptrace-vsx.c  | 117 ++++
 .../testing/selftests/powerpc/ptrace/ptrace-vsx.h  | 127 ++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    | 711 +++++++++++++++++++++
 tools/testing/selftests/powerpc/reg.h              |  60 --
 tools/testing/selftests/powerpc/signal/signal.S    |   2 +-
 .../testing/selftests/powerpc/stringloops/memcmp.c |   2 +-
 tools/testing/selftests/powerpc/tm/tm-signal.S     |  10 +-
 tools/testing/selftests/powerpc/tm/tm.h            |   2 +-
 259 files changed, 8698 insertions(+), 2634 deletions(-)
 rename arch/powerpc/include/asm/book3s/64/{hugetlb-radix.h => hugetlb.h} (52%)
 create mode 100644 arch/powerpc/include/asm/stackprotector.h
 create mode 100644 arch/powerpc/kernel/kexec_elf_64.c
 create mode 100644 arch/powerpc/kernel/machine_kexec_file_64.c
 create mode 100644 arch/powerpc/mm/dump_hashpagetable.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables.c
 create mode 100644 arch/powerpc/mm/init-common.c
 rename arch/powerpc/{kernel => platforms/pseries}/ibmebus.c (65%)
 rename arch/powerpc/{kernel => platforms/pseries}/vio.c (99%)
 create mode 100644 arch/powerpc/purgatory/.gitignore
 create mode 100644 arch/powerpc/purgatory/Makefile
 create mode 100644 arch/powerpc/purgatory/trampoline.S
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/null_syscall.c
 rename tools/testing/selftests/powerpc/{ => include}/basic_asm.h (66%)
 rename tools/testing/selftests/powerpc/{ => include}/fpu_asm.h (100%)
 rename tools/testing/selftests/powerpc/{ => include}/gpr_asm.h (100%)
 rename tools/testing/selftests/powerpc/{ => include}/instructions.h (100%)
 create mode 100644 tools/testing/selftests/powerpc/include/reg.h
 rename tools/testing/selftests/powerpc/{ => include}/subunit.h (100%)
 rename tools/testing/selftests/powerpc/{ => include}/utils.h (100%)
 rename tools/testing/selftests/powerpc/{ => include}/vmx_asm.h (100%)
 rename tools/testing/selftests/powerpc/{ => include}/vsx_asm.h (100%)
 create mode 100644 tools/testing/selftests/powerpc/lib/reg.S
 delete mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c
 delete mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h
 delete mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c
 create mode 100644 tools/testing/selftests/powerpc/primitives/asm/firmware.h
 create mode 120000 tools/testing/selftests/powerpc/primitives/asm/ppc_asm.h
 create mode 100644 tools/testing/selftests/powerpc/primitives/asm/processor.h
 create mode 100644 tools/testing/selftests/powerpc/primitives/linux/stringify.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/ptrace/Makefile
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-gpr.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tar.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tar.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-tar.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-vsx.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-vsx.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.h
 delete mode 100644 tools/testing/selftests/powerpc/reg.h

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYU5rdAAoJEFHr6jzI4aWA5GgP/2mYJwHvk4/7lqAg6ZyxHej4
d+nlEKpHKYpSvGofKAPvakZ74DEsv08nM7nmEBsE3fZdETTBfT/9NQqZPRTiZ0Qv
/yqlRCRachEYxelr0phSmUQyMk72at/2kP9iGkW/UkeMFGtAsrlqJRdRgr9G8EXi
VFv7+t/AHTEFav3/cKRrZTL+ZXSy4RxygNJVXkty2wVGSmVmLmNm+nWrPCe2bSjn
fOQUFkw2qCm397kVYbza0qw8jVuCJ1zMroMWYwdeSotHHUv9pIvjA9Yvi9jk7XZP
CSGM0jUUT0yaPZ7EKNe55jHIu5oXqsIAE2aJuMnkti/iNL5qcwYuqaMlEuIrNtzO
qS8GlCals2bdVYv9lTQ8mXF0wFlfoKf+WKmsDPIe0OxBbHfHz84bZ96x9FuKqfFO
eOZgHWpiDqNafmE1QpsV3NSBONFdC2uJrJNiit+0epxW+/zLLkUG5gG2lcgEyHO3
4TAcSeVLlHM3Vl4et2VrH7kCsUFokL/HyUgLR0j1FcreZQgLnC8QVXCD2m0K7dMj
zntp0Ox6OkqYtYYTd9cdySFdETw1Ro+P+N6zPq7293e4HufrAzSBMUWqUmMkhGlp
U3iIv5nU0JeCMiKKME/5tNaVfkItO0cdsUY9M4nR8P9QrTkHfu/hmiRq1G5oKO9I
1nP3EDr/nG+uf/P7Fkxt
=IV4V
-----END PGP SIGNATURE-----
--=-=-=--
