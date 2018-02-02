Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXypQ709czF0Z0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 00:42:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, amodra@gmail.com, andrew.donnellan@au1.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, anton@samba.org,
 arnd@arndb.de, bauerman@linux.vnet.ibm.com, benh@kernel.crashing.org,
 bhaktipriya96@gmail.com, bhelgaas@google.com, bryantly@linux.vnet.ibm.com,
 bsingharora@gmail.com, christophe.leroy@c-s.fr,
 clombard@linux.vnet.ibm.com, cyrilbur@gmail.com,
 daniel.thompson@linaro.org, david@gibson.dropbear.id.au,
 dmitry.torokhov@gmail.com, fbarrat@linux.vnet.ibm.com,
 geert+renesas@glider.be, geoff@infradead.org, gomonovych@gmail.com,
 gpiccoli@linux.vnet.ibm.com, gromero@linux.vnet.ibm.com,
 gustavo@embeddedor.com, ivan@de.ibm.com, jk@ozlabs.org,
 joakim.tjernlund@infinera.com, joe@perches.com, jpoimboe@redhat.com,
 jsperbeck@google.com, julia@ni.com, kamalesh@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, leoyang.li@nxp.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linuxram@us.ibm.com, maddy@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 malat@debian.org, mwb@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, npiggin@gmail.com, oss@buserror.net,
 paulus@ozlabs.org, robh@kernel.org, ruscur@russell.cc, santosh@fossix.org,
 schwab@linux-m68k.org, stewart@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, tj@kernel.org, wei.guo.simon@gmail.com,
 gregkh@linuxfoundation.org, dan.j.williams@intel.com, bhelgaas@google.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.16-1 tag
Date: Sat, 03 Feb 2018 00:42:17 +1100
Message-ID: <87y3kbpkxy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc updates for 4.16.

We've added a new driver in drivers/misc, which Greg was OK for us to
merge via powerpc, though it has still resulted in a trivial
conflict in the Makefile and Kconfig.

There's also a conflict with the nvdimm tree, which you haven't merged
yet AFIACS, but also trivial (just take our deletion), and Dan is aware
of it.

And there's one change to non-powerpc PCI code, in aerdrv_core.c, which
was acked by Bjorn.

cheers


The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-4.16-1

for you to fetch changes up to 015eb1b89e959c9349f0a01803fb8ed1ced36f09:

  powerpc/mm/radix: Fix build error when RADIX_MMU=3Dn (2018-01-30 20:41:30=
 +1100)

=2D---------------------------------------------------------------
powerpc updates for 4.16

Highlights:

 - Enable support for memory protection keys aka "pkeys" on Power7/8/9 when
   using the hash table MMU.

 - Extend our interrupt soft masking to support masking PMU interrupts as w=
ell
   as "normal" interrupts, and then use that to implement local_t for a ~4x
   speedup vs the current atomics-based implementation.

 - A new driver "ocxl" for "Open Coherent Accelerator Processor Interface
   (OpenCAPI)" devices.

 - Support for new device tree properties on PowerVM to describe hotpluggab=
le
   memory and devices.

 - Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE to the 64-bit VDSO.

 - Freescale updates from Scott:
     "Contains fixes for CPM GPIO and an FSL PCI erratum workaround, plus a
      minor cleanup patch."

As well as quite a lot of other changes all over the place, and small fixes=
 and
cleanups as always.

Thanks to:
  Alan Modra, Alastair D'Silva, Alexey Kardashevskiy, Alistair Popple, Andr=
eas
  Schwab, Andrew Donnellan, Aneesh Kumar K.V, Anju T Sudhakar, Anshuman
  Khandual, Anton Blanchard, Arnd Bergmann, Balbir Singh, Benjamin
  Herrenschmidt, Bhaktipriya Shridhar, Bryant G. Ly, C=C3=A9dric Le Goater,
  Christophe Leroy, Christophe Lombard, Cyril Bur, David Gibson, Desnes A. =
Nunes
  do Rosario, Dmitry Torokhov, Frederic Barrat, Geert Uytterhoeven, Guilher=
me G.
  Piccoli, Gustavo A. R. Silva, Gustavo Romero, Ivan Mikhaylov, Joakim
  Tjernlund, Joe Perches, Josh Poimboeuf, Juan J. Alvarez, Julia Cartwright,
  Kamalesh Babulal, Madhavan Srinivasan, Mahesh Salgaonkar, Mathieu Malater=
re,
  Michael Bringmann, Michael Hanselmann, Michael Neuling, Nathan Fontenot,
  Naveen N. Rao, Nicholas Piggin, Paul Mackerras, Philippe Bergheaud, Ram P=
ai,
  Russell Currey, Santosh Sivaraj, Scott Wood, Seth Forshee, Simon Guo, Ste=
wart
  Smith, Sukadev Bhattiprolu, Thiago Jung Bauermann, Vaibhav Jain, Vasyl
  Gomonovych.

=2D---------------------------------------------------------------
Alan Modra (1):
      powerpc/modules: Fix alignment of .toc section in kernel modules

Alexey Kardashevskiy (2):
      powerpc/powernv/ioda: Finish removing explicit max window size check
      powerpc/powernv/idoa: Remove unnecessary pcidev from pci_dn

Andreas Schwab (1):
      macintosh/adb: Properly mark continued kernel messages

Andrew Donnellan (2):
      selftests/powerpc: Add alignment handler selftest
      powerpc/powernv: Set correct configuration space size for opencapi de=
vices

Aneesh Kumar K.V (6):
      powerpc/mm/hugetlb: Use pte_access_permitted for hugetlb access check
      powerpc/mm/book3s/64: Add proper pte access check helper
      powerpc/mm: Add proper pte access check helper for other platforms
      powerpc/mm: Remove unused flag arg in global_invalidates
      powerpc/hash: Skip non initialized page size in init_hpte_page_sizes
      selftest/powerpc: Add additional option to mmap_bench test

Anju T Sudhakar (5):
      powerpc/perf: Remove thread_imc_pmu global variable from
      powerpc/perf: IMC code cleanup with some code refactoring
      powerpc/perf: Pass struct imc_events as a parameter to imc_parse_even=
t()
      powerpc/powernv: Add debugfs interface for imc-mode and imc-command
      powerpc/perf: Change the data type for the variable 'ncpu' in IMC code

Anshuman Khandual (1):
      powerpc/mm: Invalidate subpage_prot() system call on radix platforms

Anton Blanchard (1):
      powerpc: Expose TSCR via sysfs

Arnd Bergmann (2):
      powerpc/mpic_timer: avoid struct timeval
      powerpc/spufs: use timespec64 for timestamps

Balbir Singh (2):
      powerpc/crash: Remove the test for cpu_online in the IPI callback
      powernv/kdump: Fix cases where the kdump kernel can get HMI's

Benjamin Herrenschmidt (10):
      powerpc: Remove DEBUG define in 64-bit early setup code
      powerpc: Reduce log level of "OPAL detected !" message
      powerpc/xive: Move definition of ESB bits
      powerpc/xive: Add interrupt flag to disable automatic EOI
      powerpc: Add aacraid and nvme to powernv_defconfig
      powerpc: Make newline in cpuinfo unconditional
      powerpc: Cosmetic cleanup of cpuinfo_op
      powerpc/xive: Remove incorrect debug code
      powerpc: Remove useless EXC_COMMON_HV
      powerpc: Use the TRAP macro whenever comparing a trap number

Bhaktipriya Shridhar (1):
      ps3: Remove deprecated create_singlethread_workqueue

Bryant G. Ly (10):
      powerpc/pci: Separate SR-IOV Calls
      powerpc/pseries: Add pseries SR-IOV Machine dependent calls
      PCI/IOV: Add pci_vf_drivers_autoprobe() interface
      powerpc/eeh: Update VF config space after EEH
      PCI/AER: Add uevents in AER and EEH error/resume
      powerpc/pseries: Set eeh_pe of EEH_PE_VF type
      powerpc/eeh: Add EEH operations to notify resume
      powerpc/eeh: Add EEH notify resume sysfs
      powerpc/pseries/pci: Associate PEs to VFs in configure SR-IOV
      powerpc/pseries: Add Initialization of VF Bars

Christophe Leroy (15):
      powerpc/32s: Fix compile error with CONFIG_PPC_PTDUMP
      powerpc/8xx: do not select CONFIG_PPC_LIB_RHEAP
      powerpc/8xx: Remove CPU6 ERRATA Workaround
      powerpc/8xx: remove EXCEPTION_PROLOG/EPILOG_0 and change r3 to r12
      powerpc/8xx: Only perform perf counting when perf is in use.
      powerpc/8xx: remove unused _PAGE_WRITETHRU
      powerpc/mm: extend _PAGE_PRIVILEGED to all CPUs
      powerpc/mm: Introduce _PAGE_NA
      powerpc/8xx: Remove _PAGE_USER and handle user access at PMD level
      powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for CONFIG_SWAP
      powerpc: restore alphabetic order in Kconfig
      powerpc/lib/code-patching: refactor patch_instruction()
      powerpc/lib/feature-fixups: use raw_patch_instruction()
      powerpc/sysdev: change CPM GPIO to platform_device
      powerpc/mm/nohash: do not flush the entire mm when range is a single =
page

Christophe Lombard (1):
      cxl: Add support for ASB_Notify on POWER9

Cyril Bur (1):
      selftests/powerpc: Check for pthread errors in tm-unavailable

David Gibson (1):
      powerpc/pseries: Don't give a warning when HPT resizing isn't availab=
le

Dmitry Torokhov (4):
      powerpc/powermac: fix OF node refcount leak
      powerpc/powermac: drop useless call to of_find_node_by_name
      powerpc: Use of for_each_node_by_name() instead of open-coding it
      powerpc: make use of for_each_node_by_type() instead of open-coding it

Frederic Barrat (12):
      powerpc/powernv: Introduce new PHB type for opencapi links
      powerpc/powernv: Add opal calls for opencapi
      powerpc/powernv: Add platform-specific services for opencapi
      powerpc/powernv: Capture actag information for the device
      ocxl: Driver code for 'generic' opencapi devices
      ocxl: Add AFU interrupt support
      ocxl: Add a kernel API for other opencapi drivers
      ocxl: Add trace points
      ocxl: Add Makefile and Kconfig
      cxl: Remove support for "Processing accelerators" class
      ocxl: Documentation
      ocxl: add MAINTAINERS entry

Geert Uytterhoeven (1):
      dt: booting-without-of: DT fix s/#interrupt-cell/#interrupt-cells/

Guilherme G. Piccoli (1):
      powerpc/powernv: Add ppc_pci_reset_phbs parameter to issue a PHB reset

Gustavo A. R. Silva (2):
      macintosh: change some data types from int to bool
      macintosh/ams-input: Use true and false for boolean values

Gustavo Romero (2):
      powerpc/tm: Fix endianness flip on trap
      powerpc/selftests: Check endianness on trap in TM

Ivan Mikhaylov (4):
      powerpc/44x/fsp2: Add fsp2 headers
      powerpc/44x/fsp2: Interrupt handling setup
      powerpc/44x/fsp2: tvsense workaround for dd1
      powerpc/44x/fsp2: Add irq error handlers

Joakim Tjernlund (1):
      powerpc/fsl_pci: Correct fsl_pci_mcheck_exception

Joe Perches (1):
      powerpc: Use pr_warn instead of pr_warning

Josh Poimboeuf (2):
      powerpc/modules: Don't try to restore r2 after a sibling call
      powerpc/modules: Improve restore_r2() error message

Julia Cartwright (1):
      powerpc/mpc52xx_gpt: make use of raw_spinlock variants

Kamalesh Babulal (1):
      powerpc/modules: Add REL24 relocation support of livepatch symbols

Madhavan Srinivasan (16):
      powerpc: Hard wire PT_SOFTE value to 1 in ptrace & signals
      powerpc/64: Add #defines for paca->soft_enabled flags
      powerpc/64: Fix arch_local_irq_disable() prototype
      powerpc/64: Move set_soft_enabled() and rename
      powerpc/64: Implement and use soft_enabled_return API
      powerpc/64: Implement and use soft_enabled_set_return API
      powerpc/64: Cleanup hard_irq_disable() macro
      powerpc/64: Change soft_enabled from flag to bitmask
      powerpc/64: Rename soft_enabled to irq_soft_mask
      powerpc/64s: Avoid using EXCEPTION_PROLOG_1 macro in MASKABLE_*
      powerpc/64s: Add support to take additional parameter in MASKABLE_* m=
acro
      powerpc/64s: Add support to mask perf interrupts and replay them
      powerpc: Add new kconfig CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
      powerpc/64s: Add new set of irq_soft_mask_ functions for PMI masking
      powerpc: use generic atomic implementation for local_t
      powerpc/64s: Implement local_t using irq soft masking

Mahesh Salgaonkar (1):
      powerpc/radix: Remove trace_tlbie call from radix__flush_tlb_all

Mathieu Malaterre (5):
      powerpc/xive: Properly use static keyword for inline function
      powerpc/xmon: Do not compute/store the major opcode
      powerpc: Fix old-style function definition
      backlight: Fix old-style function definition
      powerpc/boot/dts: Remove leading 0x and 0s from bindings notation

Michael Bringmann (7):
      powerpc/firmware: Add definitions for new drc-info firmware feature
      pseries/drc-info: Search DRC properties for CPU indexes
      hotplug/drc-info: Add code to search ibm,drc-info property
      powerpc: Enable support for ibm,drc-info devtree property
      powerpc/numa: Use ibm,max-associativity-domains to discover possible =
nodes
      powerpc/numa: Ensure nodes initialized for hotplug
      powerpc/pseries: Fix cpu hotplug crash with memoryless nodes

Michael Ellerman (13):
      powerpc/boot: Only build uartlite if XILINX_VIRTEX=3Dy
      powerpc/boot: Only build OPAL code when necessary
      powerpc/boot: Only build CPM code when necessary
      selftests/powerpc: Add a test of SEGV error behaviour
      powerpc/64s: Fix ps3 build error due to tlbiel_all()
      Merge branch 'topic/ppc-kvm' into next
      Merge branch 'fixes' into next
      Merge branch 'next' of https://git.kernel.org/.../scottwood/linux int=
o next
      powerpc/cell: Remove axonram driver
      powerpc/watchdog: Tweak watchdog printks
      powerpc/watchdog: regs can't be null in soft_nmi_interrupt()
      powerpc/watchdog: Print the NIP in soft_nmi_interrupt()
      powerpc/mm/radix: Fix build error when RADIX_MMU=3Dn

Nathan Fontenot (9):
      powerpc/numa: Look up device node in of_get_assoc_arrays()
      powerpc/numa: Look up device node in of_get_usable_memory()
      powerpc/numa: Look up associativity array in of_drconf_to_nid_single
      powerpc/mm: Separate ibm, dynamic-memory data from DT format
      powerpc/numa: Update numa code use walk_drmem_lmbs
      powerpc/pseries: Update memory hotplug code to use drmem LMB array
      powerpc: Move of_drconf_cell struct to asm/drmem.h
      powerpc/drmem: Add support for ibm, dynamic-memory-v2 property
      powerpc/pseries: Enable support of ibm,dynamic-memory-v2

Nicholas Piggin (19):
      powerpc/32: Add .data.rel* sections explicitly
      powerpc/64: Don't trace irqs-off at interrupt return to soft-disabled=
 context
      powerpc: System reset avoid interleaving oops using die synchronisati=
on
      powerpc/64s: Improve local TLB flush for boot and MCE on POWER9
      powerpc/powernv: Remove real mode access limit for early allocations
      powerpc/pseries: radix is not subject to RMA limit, remove it
      powerpc/64: rtas avoid accessing paca in 32-bit mode
      powerpc/pseries: lift RTAS limit for radix
      powerpc/pseries: lift RTAS limit for hash
      powerpc/64s: Relax PACA address limitations
      powerpc/watchdog: remove arch_trigger_cpumask_backtrace
      powerpc: define __ARCH_IRQ_EXIT_IRQS_DISABLED
      cpuidle/powernv: avoid double irq enable coming out of idle
      cpuidle/powernv: avoid double irq enable coming out of idle
      powerpc/pseries/cpuidle: add polling idle for shared processor guests
      powerpc/64: Improve inline asm in arch_local_irq_disable
      powerpc/watchdog: improve watchdog comments
      powerpc/pseries, ps3: panic flush kernel messages before halting syst=
em
      powerpc/64s: Improve RFI L1-D cache flush fallback

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Improve handling of debug-trigger HMIs on POWER9

Ram Pai (30):
      powerpc: introduce pte_set_hidx() helper
      powerpc: introduce pte_get_hash_gslot() helper
      powerpc: Free up four 64K PTE bits in 4K backed HPTE pages
      powerpc: Free up four 64K PTE bits in 64K backed HPTE pages
      powerpc: shifted-by-one hidx value
      powerpc: Swizzle around 4K PTE bits to free up bit 5 and bit 6
      powerpc: use helper functions to get and set hash slots
      powerpc: capture the PTE format changes in the dump pte report
      powerpc: initial pkey plumbing
      powerpc: track allocation status of all pkeys
      powerpc: helper function to read, write AMR, IAMR, UAMOR registers
      powerpc: helper functions to initialize AMR, IAMR and UAMOR registers
      powerpc: cleanup AMR, IAMR when a key is allocated or freed
      powerpc: implementation for arch_set_user_pkey_access()
      powerpc: ability to create execute-disabled pkeys
      powerpc: store and restore the pkey state across context switches
      powerpc: introduce execute-only pkey
      powerpc: ability to associate pkey to a vma
      powerpc: implementation for arch_override_mprotect_pkey()
      powerpc: map vma key-protection bits to pte key bits.
      powerpc: Program HPTE key protection bits
      powerpc: helper to validate key-access permissions of a pte
      powerpc: check key protection for user page access
      powerpc: implementation for arch_vma_access_permitted()
      powerpc: Handle exceptions caused by pkey violation
      powerpc: introduce get_mm_addr_key() helper
      powerpc: Deliver SEGV signal on pkey violation
      powerpc: Enable pkey subsystem
      powerpc: sys_pkey_alloc() and sys_pkey_free() system calls
      powerpc: sys_pkey_mprotect() system call

Russell Currey (1):
      powerpc: Use octal numbers for file permissions

Santosh Sivaraj (1):
      powerpc/vdso64: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE

Simon Guo (1):
      selftests/powerpc: Fix build errors in powerpc ptrace selftests

Stewart Smith (1):
      rtc-opal: Fix handling of firmware error codes, prevent busy loops

Sukadev Bhattiprolu (1):
      powerpc/kernel: Block interrupts when updating TIDR

Thiago Jung Bauermann (1):
      powerpc/ptrace: Add memory protection key regset

Vasyl Gomonovych (1):
      powerpc/fsl_pci: Fix ptr_ret.cocci warnings

 Documentation/ABI/testing/sysfs-class-ocxl         |  35 +
 Documentation/accelerators/ocxl.rst                | 160 +++++
 Documentation/devicetree/booting-without-of.txt    |   2 +-
 Documentation/filesystems/dax.txt                  |   1 -
 Documentation/ioctl/ioctl-number.txt               |   1 +
 MAINTAINERS                                        |  12 +
 arch/powerpc/Kconfig                               |  19 +-
 arch/powerpc/Kconfig.debug                         |   6 +-
 arch/powerpc/Makefile                              |   1 +
 arch/powerpc/boot/Makefile                         |   8 +-
 arch/powerpc/boot/dts/a3m071.dts                   |  10 +-
 arch/powerpc/boot/dts/akebono.dts                  |   4 +-
 arch/powerpc/boot/dts/c2k.dts                      |   6 +-
 arch/powerpc/boot/dts/currituck.dts                |   2 +-
 arch/powerpc/boot/dts/fsl/mpc8568mds.dts           |  12 +-
 arch/powerpc/boot/dts/fsl/mpc8569mds.dts           |  20 +-
 arch/powerpc/boot/dts/fsl/p1021mds.dts             |   6 +-
 arch/powerpc/boot/dts/fsl/p1025rdb.dtsi            |   8 +-
 arch/powerpc/boot/dts/fsl/p1025rdb_32b.dts         |   2 +-
 arch/powerpc/boot/dts/fsl/p1025twr.dtsi            |   8 +-
 arch/powerpc/boot/dts/fsl/t1040rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1042d4rdb.dts           |  10 +-
 arch/powerpc/boot/dts/fsl/t1042rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi            |   6 +-
 arch/powerpc/boot/dts/fsp2.dts                     |   6 +-
 arch/powerpc/boot/dts/gamecube.dts                 |  14 +-
 arch/powerpc/boot/dts/haleakala.dts                |   2 +-
 arch/powerpc/boot/dts/kilauea.dts                  |   4 +-
 arch/powerpc/boot/dts/kmeter1.dts                  |  10 +-
 arch/powerpc/boot/dts/makalu.dts                   |   4 +-
 arch/powerpc/boot/dts/mpc832x_mds.dts              |  10 +-
 arch/powerpc/boot/dts/mpc832x_rdb.dts              |   8 +-
 arch/powerpc/boot/dts/mpc836x_mds.dts              |   8 +-
 arch/powerpc/boot/dts/sbc8548-altflash.dts         |   8 +-
 arch/powerpc/boot/dts/sbc8548.dts                  |   8 +-
 arch/powerpc/boot/dts/wii.dts                      |  32 +-
 arch/powerpc/boot/serial.c                         |   6 +
 arch/powerpc/configs/mpc866_ads_defconfig          |   1 -
 arch/powerpc/configs/powernv_defconfig             |   2 +
 arch/powerpc/include/asm/book3s/32/pgtable.h       |  23 +
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |  20 +
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  71 +-
 arch/powerpc/include/asm/book3s/64/hash.h          |   8 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |   5 +
 arch/powerpc/include/asm/book3s/64/mmu.h           |  10 +
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  79 ++-
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |   1 +
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   7 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  38 ++
 arch/powerpc/include/asm/bug.h                     |   4 +-
 arch/powerpc/include/asm/code-patching.h           |   2 +
 arch/powerpc/include/asm/cpm.h                     |   2 +-
 arch/powerpc/include/asm/cpm1.h                    |   2 +
 arch/powerpc/include/asm/cputable.h                |  21 +-
 arch/powerpc/include/asm/drmem.h                   | 102 +++
 arch/powerpc/include/asm/eeh.h                     |   2 +
 arch/powerpc/include/asm/exception-64s.h           | 103 +--
 arch/powerpc/include/asm/firmware.h                |   5 +-
 arch/powerpc/include/asm/hardirq.h                 |   1 +
 arch/powerpc/include/asm/head-64.h                 |  47 +-
 arch/powerpc/include/asm/hmi.h                     |   4 +
 arch/powerpc/include/asm/hugetlb.h                 |   3 +-
 arch/powerpc/include/asm/hw_irq.h                  | 161 ++++-
 arch/powerpc/include/asm/imc-pmu.h                 |   9 +-
 arch/powerpc/include/asm/irqflags.h                |  14 +-
 arch/powerpc/include/asm/kexec.h                   |   2 +
 arch/powerpc/include/asm/kvm_ppc.h                 |   2 +-
 arch/powerpc/include/asm/local.h                   | 200 +++---
 arch/powerpc/include/asm/machdep.h                 |   8 +
 arch/powerpc/include/asm/mman.h                    |  13 +-
 arch/powerpc/include/asm/mmu-8xx.h                 |  60 +-
 arch/powerpc/include/asm/mmu.h                     |   9 +
 arch/powerpc/include/asm/mmu_context.h             |  22 +
 arch/powerpc/include/asm/mpic_timer.h              |   8 +-
 arch/powerpc/include/asm/nmi.h                     |   4 -
 arch/powerpc/include/asm/nohash/32/pgalloc.h       |   3 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |   2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |  25 +-
 arch/powerpc/include/asm/nohash/pgtable.h          |  27 +-
 arch/powerpc/include/asm/nohash/pte-book3e.h       |   1 +
 arch/powerpc/include/asm/opal-api.h                |   5 +-
 arch/powerpc/include/asm/opal.h                    |   6 +
 arch/powerpc/include/asm/paca.h                    |   5 +-
 arch/powerpc/include/asm/pci-bridge.h              |   9 +-
 arch/powerpc/include/asm/pci.h                     |   2 +
 arch/powerpc/include/asm/pkeys.h                   | 218 +++++++
 arch/powerpc/include/asm/pnv-ocxl.h                |  36 +
 arch/powerpc/include/asm/ppc-opcode.h              |   2 +
 arch/powerpc/include/asm/processor.h               |   5 +
 arch/powerpc/include/asm/prom.h                    |  27 +-
 arch/powerpc/include/asm/pte-common.h              |  37 +-
 arch/powerpc/include/asm/reg.h                     |   6 +-
 arch/powerpc/include/asm/reg_8xx.h                 |  82 ---
 arch/powerpc/include/asm/systbl.h                  |   3 +
 arch/powerpc/include/asm/unistd.h                  |   6 +-
 arch/powerpc/include/asm/xive-regs.h               |  35 +
 arch/powerpc/include/asm/xive.h                    |  40 +-
 arch/powerpc/include/uapi/asm/elf.h                |   1 +
 arch/powerpc/include/uapi/asm/mman.h               |   6 +
 arch/powerpc/include/uapi/asm/unistd.h             |   3 +
 arch/powerpc/kernel/asm-offsets.c                  |   7 +-
 arch/powerpc/kernel/cpu_setup_power.S              |  50 --
 arch/powerpc/kernel/cputable.c                     |  15 -
 arch/powerpc/kernel/crash.c                        |  16 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |  30 -
 arch/powerpc/kernel/eeh.c                          |  59 ++
 arch/powerpc/kernel/eeh_driver.c                   |  10 +-
 arch/powerpc/kernel/eeh_sysfs.c                    |  64 +-
 arch/powerpc/kernel/entry_32.S                     |  10 +-
 arch/powerpc/kernel/entry_64.S                     |  67 +-
 arch/powerpc/kernel/exceptions-64e.S               |  20 +-
 arch/powerpc/kernel/exceptions-64s.S               | 118 ++--
 arch/powerpc/kernel/head_64.S                      |  11 +-
 arch/powerpc/kernel/head_8xx.S                     | 275 ++++----
 arch/powerpc/kernel/idle_book3e.S                  |   5 +-
 arch/powerpc/kernel/idle_power4.S                  |   5 +-
 arch/powerpc/kernel/irq.c                          |  29 +-
 arch/powerpc/kernel/mce.c                          | 142 +++-
 arch/powerpc/kernel/mce_power.c                    | 115 +---
 arch/powerpc/kernel/module.lds                     |   8 +
 arch/powerpc/kernel/module_64.c                    |  35 +-
 arch/powerpc/kernel/optprobes_head.S               |   2 +-
 arch/powerpc/kernel/paca.c                         |  13 +-
 arch/powerpc/kernel/pci-common.c                   |  27 +-
 arch/powerpc/kernel/pci_dn.c                       |   6 -
 arch/powerpc/kernel/pci_of_scan.c                  |   2 +-
 arch/powerpc/kernel/proc_powerpc.c                 |   2 +-
 arch/powerpc/kernel/process.c                      |  28 +-
 arch/powerpc/kernel/prom.c                         | 115 ++--
 arch/powerpc/kernel/prom_init.c                    |   2 +
 arch/powerpc/kernel/ptrace.c                       |  78 +++
 arch/powerpc/kernel/rtas-proc.c                    |  14 +-
 arch/powerpc/kernel/rtas_flash.c                   |   2 +-
 arch/powerpc/kernel/rtasd.c                        |   2 +-
 arch/powerpc/kernel/setup-common.c                 |  21 +-
 arch/powerpc/kernel/setup.h                        |   4 +
 arch/powerpc/kernel/setup_64.c                     |  48 +-
 arch/powerpc/kernel/signal_32.c                    |   8 +
 arch/powerpc/kernel/signal_64.c                    |  11 +-
 arch/powerpc/kernel/smp.c                          |  18 +
 arch/powerpc/kernel/sysfs.c                        |   8 +
 arch/powerpc/kernel/time.c                         |   6 +-
 arch/powerpc/kernel/traps.c                        |  51 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S          |  67 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |   1 +
 arch/powerpc/kernel/watchdog.c                     | 100 ++-
 arch/powerpc/kvm/book3s_hv.c                       |  10 +-
 arch/powerpc/kvm/book3s_hv_ras.c                   |  14 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |   9 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |  11 +-
 arch/powerpc/kvm/book3s_xics.c                     |   2 +-
 arch/powerpc/lib/code-patching.c                   |  37 +-
 arch/powerpc/lib/feature-fixups.c                  |   8 +-
 arch/powerpc/mm/8xx_mmu.c                          |   4 +-
 arch/powerpc/mm/Makefile                           |   3 +-
 arch/powerpc/mm/drmem.c                            | 439 +++++++++++++
 arch/powerpc/mm/dump_linuxpagetables.c             |  32 +-
 arch/powerpc/mm/fault.c                            |  53 +-
 arch/powerpc/mm/hash64_4k.c                        |  14 +-
 arch/powerpc/mm/hash64_64k.c                       | 123 ++--
 arch/powerpc/mm/hash_native_64.c                   |  97 +++
 arch/powerpc/mm/hash_utils_64.c                    |  97 ++-
 arch/powerpc/mm/hugetlbpage-hash64.c               |  16 +-
 arch/powerpc/mm/hugetlbpage.c                      |   8 +-
 arch/powerpc/mm/init_64.c                          |   5 +-
 arch/powerpc/mm/mem.c                              |   3 +-
 arch/powerpc/mm/mmu_context_book3s64.c             |   2 +
 arch/powerpc/mm/numa.c                             | 333 ++++------
 arch/powerpc/mm/pgtable-radix.c                    |  23 +-
 arch/powerpc/mm/pgtable.c                          |   3 +-
 arch/powerpc/mm/pgtable_32.c                       |   9 +-
 arch/powerpc/mm/pgtable_64.c                       |  14 +-
 arch/powerpc/mm/pkeys.c                            | 468 +++++++++++++
 arch/powerpc/mm/subpage-prot.c                     |   3 +
 arch/powerpc/mm/tlb-radix.c                        |  68 +-
 arch/powerpc/mm/tlb_nohash.c                       |   5 +-
 arch/powerpc/perf/8xx-pmu.c                        |  52 +-
 arch/powerpc/perf/Makefile                         |   2 +-
 arch/powerpc/perf/core-book3s.c                    |   2 +-
 arch/powerpc/perf/imc-pmu.c                        | 102 +--
 arch/powerpc/platforms/44x/fsp2.c                  | 259 +++++++-
 arch/powerpc/platforms/44x/fsp2.h                  | 272 ++++++++
 arch/powerpc/platforms/512x/mpc512x_shared.c       |   4 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |  52 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c     |   2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |   2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |   2 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |   2 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c    |   7 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |   2 +-
 arch/powerpc/platforms/8xx/Kconfig                 |  12 -
 arch/powerpc/platforms/Kconfig                     |  11 -
 arch/powerpc/platforms/Kconfig.cputype             |   8 -
 arch/powerpc/platforms/cell/interrupt.c            |   3 +-
 arch/powerpc/platforms/cell/setup.c                |   3 +-
 arch/powerpc/platforms/cell/spider-pic.c           |   3 +-
 arch/powerpc/platforms/cell/spu_manage.c           |   4 +-
 arch/powerpc/platforms/cell/spufs/file.c           |   6 +-
 arch/powerpc/platforms/cell/spufs/inode.c          |   4 +-
 arch/powerpc/platforms/cell/spufs/spufs.h          |   2 +-
 arch/powerpc/platforms/pasemi/dma_lib.c            |   4 +-
 arch/powerpc/platforms/powermac/backlight.c        |   6 +-
 arch/powerpc/platforms/powermac/feature.c          |   3 +-
 arch/powerpc/platforms/powermac/pic.c              |   8 +-
 arch/powerpc/platforms/powermac/smp.c              |   4 +-
 arch/powerpc/platforms/powernv/Makefile            |   1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c       | 101 +--
 arch/powerpc/platforms/powernv/npu-dma.c           |   7 +-
 arch/powerpc/platforms/powernv/ocxl.c              | 515 +++++++++++++++
 arch/powerpc/platforms/powernv/opal-dump.c         |   4 +-
 arch/powerpc/platforms/powernv/opal-elog.c         |   4 +-
 arch/powerpc/platforms/powernv/opal-imc.c          |  77 +++
 arch/powerpc/platforms/powernv/opal-sysparam.c     |   6 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   3 +
 arch/powerpc/platforms/powernv/opal.c              |  28 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  88 ++-
 arch/powerpc/platforms/powernv/pci.c               |   4 +
 arch/powerpc/platforms/powernv/pci.h               |   8 +-
 arch/powerpc/platforms/powernv/smp.c               |  28 +
 arch/powerpc/platforms/ps3/device-init.c           |  12 +-
 arch/powerpc/platforms/ps3/mm.c                    |   4 +-
 arch/powerpc/platforms/ps3/os-area.c               |   2 +-
 arch/powerpc/platforms/ps3/setup.c                 |   1 +
 arch/powerpc/platforms/pseries/cmm.c               |  16 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c       | 162 ++++-
 arch/powerpc/platforms/pseries/firmware.c          |   2 +
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   3 +
 arch/powerpc/platforms/pseries/hotplug-memory.c    | 522 ++++++---------
 arch/powerpc/platforms/pseries/hvCall_inst.c       |   2 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   4 +-
 arch/powerpc/platforms/pseries/iommu.c             |   8 +-
 arch/powerpc/platforms/pseries/lparcfg.c           |   8 +-
 arch/powerpc/platforms/pseries/mobility.c          |   2 +-
 arch/powerpc/platforms/pseries/of_helpers.c        |  60 ++
 arch/powerpc/platforms/pseries/pci.c               | 177 ++++-
 arch/powerpc/platforms/pseries/pseries_energy.c    | 126 +++-
 arch/powerpc/platforms/pseries/reconfig.c          |   2 +-
 arch/powerpc/platforms/pseries/scanlog.c           |   2 +-
 arch/powerpc/platforms/pseries/setup.c             | 176 ++++-
 arch/powerpc/platforms/pseries/suspend.c           |   3 +-
 arch/powerpc/sysdev/Makefile                       |   4 +-
 arch/powerpc/sysdev/axonram.c                      | 383 -----------
 arch/powerpc/sysdev/cpm1.c                         |  33 +-
 arch/powerpc/sysdev/cpm2.c                         |  11 -
 arch/powerpc/sysdev/cpm_common.c                   |   5 +-
 arch/powerpc/sysdev/cpm_gpio.c                     |  80 +++
 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c        |  16 +-
 arch/powerpc/sysdev/fsl_pci.c                      |  14 +-
 arch/powerpc/sysdev/mpic.c                         |  10 +-
 arch/powerpc/sysdev/mpic_timer.c                   |  55 +-
 arch/powerpc/sysdev/mv64x60_pci.c                  |   2 +-
 arch/powerpc/sysdev/xics/icp-native.c              |  10 +-
 arch/powerpc/sysdev/xics/ics-opal.c                |   4 +-
 arch/powerpc/sysdev/xics/ics-rtas.c                |   4 +-
 arch/powerpc/sysdev/xics/xics-common.c             |   8 +-
 arch/powerpc/sysdev/xive/common.c                  |   8 +-
 arch/powerpc/xmon/ppc-dis.c                        |   4 -
 arch/powerpc/xmon/xmon.c                           |   6 +-
 drivers/cpuidle/cpuidle-powernv.c                  |   2 +
 drivers/cpuidle/cpuidle-pseries.c                  |  16 +-
 drivers/macintosh/adb.c                            |  24 +-
 drivers/macintosh/adbhid.c                         |  55 +-
 drivers/macintosh/ams/ams-input.c                  |   4 +-
 drivers/macintosh/therm_adt746x.c                  |   4 +-
 drivers/macintosh/via-pmu-backlight.c              |   2 +-
 drivers/macintosh/windfarm_pm112.c                 |   8 +-
 drivers/macintosh/windfarm_pm121.c                 |   5 +-
 drivers/macintosh/windfarm_pm72.c                  |   2 +-
 drivers/macintosh/windfarm_pm81.c                  |   5 +-
 drivers/macintosh/windfarm_pm91.c                  |   5 +-
 drivers/macintosh/windfarm_rm31.c                  |   2 +-
 drivers/misc/Kconfig                               |   1 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/cxl/context.c                         |   2 +
 drivers/misc/cxl/cxl.h                             |   3 +
 drivers/misc/cxl/cxllib.c                          |   3 +-
 drivers/misc/cxl/file.c                            |  15 +-
 drivers/misc/cxl/native.c                          |  13 +-
 drivers/misc/cxl/pci.c                             |   2 -
 drivers/misc/ocxl/Kconfig                          |  31 +
 drivers/misc/ocxl/Makefile                         |  11 +
 drivers/misc/ocxl/afu_irq.c                        | 202 ++++++
 drivers/misc/ocxl/config.c                         | 723 +++++++++++++++++=
++++
 drivers/misc/ocxl/context.c                        | 279 ++++++++
 drivers/misc/ocxl/file.c                           | 432 ++++++++++++
 drivers/misc/ocxl/link.c                           | 647 ++++++++++++++++++
 drivers/misc/ocxl/main.c                           |  33 +
 drivers/misc/ocxl/ocxl_internal.h                  | 131 ++++
 drivers/misc/ocxl/pasid.c                          | 107 +++
 drivers/misc/ocxl/pci.c                            | 585 +++++++++++++++++
 drivers/misc/ocxl/sysfs.c                          | 142 ++++
 drivers/misc/ocxl/trace.c                          |   6 +
 drivers/misc/ocxl/trace.h                          | 182 ++++++
 drivers/pci/hotplug/rpadlpar_core.c                |  13 +-
 drivers/pci/hotplug/rpadlpar_sysfs.c               |   3 +-
 drivers/pci/hotplug/rpaphp.h                       |   8 +-
 drivers/pci/hotplug/rpaphp_core.c                  | 107 ++-
 drivers/pci/iov.c                                  |  11 +
 drivers/pci/pcie/aer/aerdrv_core.c                 |   3 +
 drivers/ps3/ps3av.c                                |  11 +-
 drivers/rtc/rtc-opal.c                             |  12 +-
 include/linux/pci.h                                |  38 ++
 include/misc/ocxl-config.h                         |  45 ++
 include/misc/ocxl.h                                | 214 ++++++
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/misc/cxl.h                            |  10 +-
 include/uapi/misc/ocxl.h                           |  49 ++
 tools/testing/selftests/powerpc/alignment/Makefile |   3 +-
 .../powerpc/alignment/alignment_handler.c          | 491 ++++++++++++++
 .../selftests/powerpc/benchmarks/mmap_bench.c      |  53 +-
 tools/testing/selftests/powerpc/mm/.gitignore      |   3 +-
 tools/testing/selftests/powerpc/mm/Makefile        |   2 +-
 tools/testing/selftests/powerpc/mm/segv_errors.c   |  78 +++
 .../selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c   |   4 +-
 .../selftests/powerpc/ptrace/ptrace-tm-spr.c       |   3 +-
 .../selftests/powerpc/ptrace/ptrace-tm-vsx.c       |   2 +-
 tools/testing/selftests/powerpc/tm/.gitignore      |   1 +
 tools/testing/selftests/powerpc/tm/Makefile        |   3 +-
 tools/testing/selftests/powerpc/tm/tm-trap.c       | 329 ++++++++++
 .../testing/selftests/powerpc/tm/tm-unavailable.c  |  43 +-
 320 files changed, 11608 insertions(+), 3055 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-ocxl
 create mode 100644 Documentation/accelerators/ocxl.rst
 create mode 100644 arch/powerpc/include/asm/drmem.h
 create mode 100644 arch/powerpc/include/asm/pkeys.h
 create mode 100644 arch/powerpc/include/asm/pnv-ocxl.h
 create mode 100644 arch/powerpc/kernel/module.lds
 create mode 100644 arch/powerpc/mm/drmem.c
 create mode 100644 arch/powerpc/mm/pkeys.c
 create mode 100644 arch/powerpc/platforms/44x/fsp2.h
 create mode 100644 arch/powerpc/platforms/powernv/ocxl.c
 delete mode 100644 arch/powerpc/sysdev/axonram.c
 create mode 100644 arch/powerpc/sysdev/cpm_gpio.c
 create mode 100644 drivers/misc/ocxl/Kconfig
 create mode 100644 drivers/misc/ocxl/Makefile
 create mode 100644 drivers/misc/ocxl/afu_irq.c
 create mode 100644 drivers/misc/ocxl/config.c
 create mode 100644 drivers/misc/ocxl/context.c
 create mode 100644 drivers/misc/ocxl/file.c
 create mode 100644 drivers/misc/ocxl/link.c
 create mode 100644 drivers/misc/ocxl/main.c
 create mode 100644 drivers/misc/ocxl/ocxl_internal.h
 create mode 100644 drivers/misc/ocxl/pasid.c
 create mode 100644 drivers/misc/ocxl/pci.c
 create mode 100644 drivers/misc/ocxl/sysfs.c
 create mode 100644 drivers/misc/ocxl/trace.c
 create mode 100644 drivers/misc/ocxl/trace.h
 create mode 100644 include/misc/ocxl-config.h
 create mode 100644 include/misc/ocxl.h
 create mode 100644 include/uapi/misc/ocxl.h
 create mode 100644 tools/testing/selftests/powerpc/alignment/alignment_han=
dler.c
 create mode 100644 tools/testing/selftests/powerpc/mm/segv_errors.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-trap.c



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJadGq5AAoJEFHr6jzI4aWA2TIQALQeH/XyzYMGP4doz16N+Gbl
uDUoj0ySMyqpAAfVrWLW6sHUNknwQz/w8FXTWqJwHYZgehGnIvTGBPaUNMH0ENi3
cNMM9rfXaDaK90kBKEZPvUB5Wka5utKTyjijwkP6wFVSnC8MwXAhruOMZt43Znuu
wXIVP61x1HtXu86wiJkfvCWJ+v5ex8h1ZkJL5kJJr0eq9+w/mKgm+fnENDYBVYa3
SNVxueUBgyNMiLSxsReod/Q7vAn+X/p6SNMe/Z2XhzjDI/osC54SzsJYWpPxO6TF
I6/T1NxpOApnOdS5+oC4XyKSh2IDLEr4K8Ymdkocj/9Tkq0+ogsPrkcIwVyle39C
YyDWODpmET/WppvH0b9O7xo/dM5dAH2OHuMlTdq/ykvJE96c453J2Vu+i3ZTnIWS
zkW8p0ksgZhgNf2W+dMXIEQMrr7Ujz6JcUkUFOdFLX55gVQzuVuejEz53ugSikme
A45mhYB14gr34SXZ1Np/3fMYj4h/vDFCz9ItyzNnrNAUcHUpoJ9MmHqXw0v0FOgg
4zlUWzeREARR4sMedKe99ICjIgRJZEH9VKuUwbsrEubp1nWnuvCgEzFzj9FqC2ct
OO1eGansSSZVnf36rbRN2fxgnNK9GGeyusJOn3ZlPT4Nkr8UncT/BSm+hFlWZh6e
z4DaKPIICWTV+IJ2rXUK
=gXe4
-----END PGP SIGNATURE-----
--=-=-=--
