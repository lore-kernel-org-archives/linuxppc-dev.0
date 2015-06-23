Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E3A121A105E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:32:21 +1000 (AEST)
Message-ID: <1435055539.20070.7.camel@ellerman.id.au>
Subject: [git pull] Please pull mpe/linux.git powerpc-4.2-1 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Igal.Liberman@freescale.com, Shengzhou.Liu@freescale.com,
 X.Xie@freescale.com, aik@ozlabs.ru, alex.williamson@redhat.com,
 alistair@popple.id.au, aneesh.kumar@linux.vnet.ibm.com, anton@samba.org,
 christophe.leroy@c-s.fr, clg@fr.ibm.com, cminyard@mvista.com,
 cyrilbur@gmail.com,  david@gibson.dropbear.id.au, dja@axtens.net,
 fthain@telegraphics.com.au,  galak@kernel.crashing.org,
 geert+renesas@glider.be, geert@linux-m68k.org,  gwshan@linux.vnet.ibm.com,
 haokexin@gmail.com, igal.liberman@freescale.com,  imunsie@au1.ibm.com,
 jiang.liu@linux.intel.com, jk@ozlabs.org, joel@jms.id.au,
 k.kozlowski.k@gmail.com, khandual@linux.vnet.ibm.com,
 ldufour@linux.vnet.ibm.com,  linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 neelegup@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 sam.bobroff@au1.ibm.com,  scottwood@freescale.com,
 shreyas@linux.vnet.ibm.com, shuahkh@osg.samsung.com,
 stewart@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 weiyang@linux.vnet.ibm.com
Date: Tue, 23 Jun 2015 20:32:19 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-h4/wxnyYT1fcNIml0XCM"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-h4/wxnyYT1fcNIml0XCM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc updates for 4.2:

The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736=
:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git tags/powerpc-=
4.2-1

for you to fetch changes up to 6096f884515466f400864ad23d16f20b731a7ce7:

  Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/scot=
twood/linux into next (2015-06-19 17:23:48 +1000)

----------------------------------------------------------------
powerpc updates for 4.2

 - Disable the 32-bit vdso when building LE, so we can build with a 64-bit =
only
   toolchain.
 - EEH fixes from Gavin & Richard.
 - Enable the sys_kcmp syscall from Laurent.
 - Sysfs control for fastsleep workaround from Shreyas.
 - Expose OPAL events as an irq chip by Alistair.
 - MSI ops moved to pci_controller_ops by Daniel.
 - Fix for kernel to userspace backtraces for perf from Anton.
 - Merge pseries and pseries_le defconfigs from Cyril.
 - CXL in-kernel API from Mikey.
 - OPAL prd driver from Jeremy.
 - Fix for DSCR handling & tests from Anshuman.
 - Powernv flash mtd driver from Cyril.
 - Dynamic DMA Window support on powernv from Alexey.
 - LLVM clang fixes & workarounds from Anton.
 - Reworked version of the patch to abort syscalls when transactional.
 - Fix the swap encoding to support 4TB, from Aneesh.
 - Various fixes as usual.
 - Freescale updates from Scott: Highlights include more 8xx optimizations,=
 an
   e6500 hugetlb optimization, QMan device tree nodes, t1024/t1023 support,=
 and
   various fixes and cleanup.

----------------------------------------------------------------
Alexey Kardashevskiy (36):
      powerpc/eeh/ioda2: Use device::iommu_group to check IOMMU group
      powerpc/iommu/powernv: Get rid of set_iommu_table_base_and_group
      powerpc/powernv/ioda: Clean up IOMMU group registration
      powerpc/iommu: Put IOMMU group explicitly
      powerpc/iommu: Always release iommu_table in iommu_free_table()
      vfio: powerpc/spapr: Move page pinning from arch code to VFIO IOMMU d=
river
      vfio: powerpc/spapr: Check that IOMMU page is fully contained by syst=
em page
      vfio: powerpc/spapr: Use it_page_size
      vfio: powerpc/spapr: Move locked_vm accounting to helpers
      vfio: powerpc/spapr: Disable DMA mappings on disabled container
      vfio: powerpc/spapr: Moving pinning/unpinning to helpers
      vfio: powerpc/spapr: Rework groups attaching
      powerpc/powernv: Do not set "read" flag if direction=3D=3DDMA_NONE
      powerpc/iommu: Move tce_xxx callbacks from ppc_md to iommu_table
      powerpc/powernv/ioda/ioda2: Rework TCE invalidation in tce_build()/tc=
e_free()
      powerpc/spapr: vfio: Replace iommu_table with iommu_table_group
      powerpc/spapr: vfio: Switch from iommu_table to new iommu_table_group
      vfio: powerpc/spapr/iommu/powernv/ioda2: Rework IOMMU ownership contr=
ol
      powerpc/iommu: Fix IOMMU ownership control functions
      powerpc/powernv/ioda2: Move TCE kill register address to PE
      powerpc/powernv/ioda2: Add TCE invalidation for all attached groups
      powerpc/powernv: Implement accessor to TCE entry
      powerpc/iommu/powernv: Release replaced TCE
      powerpc/powernv/ioda2: Rework iommu_table creation
      powerpc/powernv/ioda2: Introduce helpers to allocate TCE pages
      powerpc/powernv/ioda2: Introduce pnv_pci_ioda2_set_window
      powerpc/powernv: Implement multilevel TCE tables
      vfio: powerpc/spapr: powerpc/powernv/ioda: Define and implement DMA w=
indows API
      powerpc/powernv/ioda2: Use new helpers to do proper cleanup on PE rel=
ease
      powerpc/iommu/ioda2: Add get_table_size() to calculate the size of fu=
ture table
      vfio: powerpc/spapr: powerpc/powernv/ioda2: Use DMA windows API in ow=
nership control
      powerpc/mmu: Add userspace-to-physical addresses translation cache
      vfio: powerpc/spapr: Register memory and define IOMMU v2
      vfio: powerpc/spapr: Support Dynamic DMA windows
      powerpc/iommu/ioda2: Enable compile with IOV=3Don and IOMMU_API=3Doff
      powerpc/powernv: Fix wrong IOMMU table in pnv_ioda_setup_bus_dma()

Alistair Popple (10):
      powerpc/powernv: Reorder OPAL subsystem initialisation
      powerpc/powernv: Add a virtual irqchip for opal events
      ipmi/powernv: Convert to irq event interface
      hvc: Convert to using interrupts instead of opal events
      powernv/eeh: Update the EEH code to use the opal irq domain
      powernv/opal: Convert opal message events to opal irq domain
      powernv/elog: Convert elog to opal irq domain
      powernv/opal-dump: Convert to irq domain
      opal: Remove events notifier
      powerpc/powernv: Increase opal-irqchip initcall priority

Aneesh Kumar K.V (3):
      powerpc/mm: Add trace point for tracking hash pte fault
      powerpc/mm: PTE_RPN_MAX is not used, remove the same
      powerpc/mm: Change the swap encoding in pte.

Anshuman Khandual (12):
      powerpc: Fix handling of DSCR related facility unavailable exception
      powerpc/kernel: Remove the unused extern dscr_default
      powerpc/kernel: Rename PACA_DSCR to PACA_DSCR_DEFAULT
      powerpc/dscr: Add some in-code documentation
      powerpc/dscr: Add documentation for DSCR support
      selftests/powerpc: Add test for system wide DSCR default
      selftests/powerpc: Add test for explicitly changing DSCR value
      selftests/powerpc: Add test for DSCR SPR numbers
      selftests/powerpc: Add test for DSCR value inheritence across fork
      selftests/powerpc: Add test for DSCR inheritence across fork & exec
      selftests/powerpc: Add test for all DSCR sysfs interfaces
      selftests/powerpc: Add gitignore file for the new DSCR tests

Anton Blanchard (9):
      powerpc/perf: Fix book3s kernel to userspace backtraces
      powerpc: Relocatable system call no longer uses the LR
      powerpc: Non relocatable system call doesn't need a trampoline
      powerpc/config: Enable bnx2x on ppc64 and pseries defconfigs
      powerpc: Fix duplicate const clang warning in user access code
      powerpc: Only use -mabi=3Daltivec if toolchain supports it
      powerpc: Only use -mtraceback=3Dno, -mno-string and -msoft-float if t=
oolchain supports it
      powerpc: Don't use -mno-strict-align on clang
      powerpc: Don't use gcc specific options on clang

Cyril Bur (3):
      powerpc/configs: Merge pseries_defconfig and pseries_le_defconfig
      powerpc/configs: Replace pseries_le_defconfig with a Makefile target =
using merge_config
      mtd: powernv: Add powernv flash MTD abstraction driver

C=C3=A9dric Le Goater (1):
      powerpc/powernv: convert OPAL codes returned by sysparam calls

Daniel Axtens (14):
      powerpc: Add MSI operations to pci_controller_ops struct
      powerpc/powernv: Move MSI-related ops to pci_controller_ops
      powerpc/cell: Move MSI-related ops to pci_controller_ops
      powerpc/pseries: Move MSI-related ops to pci_controller_ops
      powerpc/fsl_msi: Move MSI-related ops to pci_controller_ops
      powerpc/ppc4xx_msi: Move MSI-related ops to pci_controller_ops
      powerpc/ppc4xx_hsta_msi: Move MSI-related ops to pci_controller_ops
      powerpc/pasemi: Move MSI-related ops to pci_controller_ops
      powerpc/mpic_u3msi: Move MSI-related ops to pci_controller_ops
      powerpc: Remove MSI-related PCI controller ops from ppc_md
      powerpc/powernv: Specialise pci_controller_ops for each controller ty=
pe
      powerpc/pci: add dma_set_mask to pci_controller_ops
      powerpc/powernv: Move dma_set_mask() from pnv_phb to pci_controller_o=
ps
      powerpc/pci: Export symbols for CXL

David Gibson (1):
      powerpc/eeh: Fix trivial error in eeh_restore_dev_state()

Finn Thain (1):
      macintosh/nvram: Remove as unused

Gavin Shan (3):
      powerpc/eeh: Move PE state constants around
      powerpc/eeh: Introduce eeh_pe_inject_err()
      drivers/vfio: Support EEH error injection

Geert Uytterhoeven (1):
      powerpc/85xx: Replace CONFIG_USB_ISP1760_HCD by CONFIG_USB_ISP1760

Ian Munsie (2):
      cxl: Use call_rcu to reduce latency when releasing the afu fd
      cxl: Re-order card init to check the VSEC earlier

Igal Liberman (4):
      powerpc/dts: Unify B4 mux nodes
      dt/bindings: fsl/guts: Added global-utilities compatibles
      powerpc/dts: Fix incorrect clock-names property
      powerpc/fsl: Add FMan Port 10G compatibles

Jeremy Kerr (5):
      powerpc/powernv: Merge common platform device initialisation
      powerpc/powernv: Expose OPAL APIs required by PRD interface
      powerpc/powernv: Add opal-prd channel
      powerpc/powernv: fix construction of opal PRD messages
      powerpc/include: Add opal-prd to installed uapi headers

Jiang Liu (1):
      powerpc: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc

Joel Stanley (1):
      powerpc/powernv: Silence SYSPARAM warning on boot

Kevin Hao (1):
      powerpc: mpc85xx: flush the l1 cache before cpu down in kexec

Krzysztof Kozlowski (1):
      powerpc: Constify irq_domain_ops

Kumar Gala (1):
      powerpc/mpc85xx: Add FSL QorIQ DPAA QMan support to device tree(s)

LEROY Christophe (9):
      powerpc/8xx: mmu_virtual_psize incorrect for 16k pages
      powerpc/8xx: macro for handling CPU15 errata
      powerpc/8xx: Handle CR out of exception PROLOG/EPILOG
      powerpc/8xx: dont save CR in SCRATCH registers
      powerpc/8xx: Use SPRG2 instead of DAR for saving r3
      powerpc/8xx: Add support for TASK_SIZE greater than 0x80000000
      powerpc/8xx: mark _PAGE_SHARED all types of kernel pages
      powerpc/8xx: Handle PAGE_USER via APG bits
      powerpc/8xx: Implementation of PAGE_EXEC

Laurent Dufour (1):
      powerpc: Enable sys_kcmp() for CRIU

Michael Ellerman (15):
      powerpc: Make STRICT_MM_TYPECHECKS a config option
      powerpc/pasemi: Only the build the pasemi MSI code for PASEMI=3Dy
      powerpc: Show utsname->machine in boot-up banner
      powerpc: Don't do gcc version checks if we're building with clang
      powerpc: Reject binutils 2.24 when building little endian
      powerpc/vdso: Remove unused debug code
      powerpc/vdso: Combine start/size variables
      powerpc/vdso: Disable building the 32-bit VDSO on little endian
      powerpc/cell: Drop cbe-oss-dev mailing list from MAINTAINERS
      powerpc: Little endian should depend on PPC_BOOK3S_64
      powerpc/mm: Fix build break with STRICT_MM_TYPECHECKS && DEBUG_PAGEAL=
LOC
      selftests/powerpc: Add install support to more powerpc tests
      selftests/powerpc: Add thread based stress test for DSCR sysfs interf=
aces
      powerpc/powernv: pnv_init_idle_states() should only run on powernv
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into =
next

Michael Neuling (25):
      powerpc/copro: Fix faulting kernel segments
      powerpc/pci: Add release_device() hook to phb ops
      powerpc: Add cxl context to device archdata
      powerpc/pci: Add shutdown hook to pci_controller_ops
      powerpc/pci: Add pcibios_disable_device() hook
      cxl: Document external user of existing API
      cxl: Add shutdown hook
      cxl: Remove unnecessarily verbose print in cxl_remove()
      cxl: Fix error path on probe
      cxl: Dump debug info on the AFU configuration record
      cxl: Add cookie parameter to afu_release_irqs()
      cxl: Rework detach context functions
      cxl: cxl_afu_reset() -> __cxl_afu_reset()
      cxl: Export some symbols
      cxl: Only check pid for userspace contexts
      cxl: Split afu_register_irqs() function
      cxl: Configure PSL for kernel contexts and merge code
      cxl: Rework context lifetimes
      cxl: Cleanup Makefile
      cxl: Move include file cxl.h -> cxl-base.h
      cxl: Export file ops for use by API
      cxl: Add AFU virtual PHB and kernel API
      cxl: Reset default context for vPHB on release
      cxl: Add CXL_KERNEL_API config option
      cxl: Fix typo in debug print

Nathan Fontenot (1):
      powerpc/pseries: Fix possible leaked device node reference

Sam bobroff (1):
      powerpc/tm: Abort syscalls in active transactions

Scott Wood (4):
      powerpc/e6500: Optimize hugepage TLB misses
      powerpc/e500mc: Remove dead L2 flushing code in idle_e500.S
      powerpc/mm: Use PFN_PHYS() in devmem_is_allowed()
      powerpc/qman: Change fsl,qman-channel-id to cell-index

Shengzhou Liu (4):
      powerpc/fsl-booke: Add device tree support for T1024/T1023 SoC
      powerpc/fsl-booke: Add T1024 QDS board support
      powerpc/fsl-booke: Add T1024 RDB board support
      powerpc/fsl-booke: Add T1023 RDB board support

Shreyas B. Prabhu (4):
      powerpc: Fix cpu_online_cores_map to return only online threads mask
      powerpc/powernv: Move cpuidle related code from setup.c to new file
      powerpc/powernv: Introduce sysfs control for fastsleep workaround beh=
avior
      powerpc: Make doorbell check preemption safe

Vaibhav Jain (2):
      cxl: Implement an ioctl to fetch afu card-id, offset-id and mode
      cxl: Export AFU error buffer via sysfs

Wei Yang (4):
      powerpc/eeh: fix start/end/flags type in struct pci_io_addr_range{}
      powerpc/eeh: fix comment for wait_state()
      powerpc/eeh: fix powernv_eeh_wait_state delay logic
      powerpc/eeh: remove unused macro IS_BRIDGE

Xie Xiaobo (1):
      powerpc/85xx: p1025twr: add module conditional to fix QE-uart issue

 Documentation/ABI/testing/sysfs-class-cxl          |   33 +
 .../devicetree/bindings/powerpc/fsl/fman.txt       |   13 +
 .../devicetree/bindings/powerpc/fsl/guts.txt       |    5 +
 .../devicetree/bindings/soc/fsl/qman-portals.txt   |    4 +-
 Documentation/powerpc/00-INDEX                     |    2 +
 Documentation/powerpc/cxl.txt                      |    4 +
 Documentation/powerpc/dscr.txt                     |   83 ++
 Documentation/powerpc/transactional_memory.txt     |   32 +-
 Documentation/vfio.txt                             |   62 +-
 MAINTAINERS                                        |    9 +-
 arch/powerpc/Kconfig.debug                         |    8 +
 arch/powerpc/Makefile                              |   50 +-
 arch/powerpc/boot/dts/b4qds.dtsi                   |   12 +
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |   15 +-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |   84 +-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |  118 +++
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi        |   43 +
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   13 +
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   13 +
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   13 +
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |   13 +
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   13 +
 arch/powerpc/boot/dts/fsl/qoriq-qman1-portals.dtsi |   20 +-
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |  330 ++++++
 arch/powerpc/boot/dts/fsl/t1024si-post.dtsi        |  100 ++
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |   87 ++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   78 ++
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |  130 ++-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  318 ++++++
 arch/powerpc/boot/dts/kmcoge4.dts                  |   12 +
 arch/powerpc/boot/dts/oca4080.dts                  |   12 +
 arch/powerpc/boot/dts/p1023rdb.dts                 |   12 +
 arch/powerpc/boot/dts/p2041rdb.dts                 |   12 +
 arch/powerpc/boot/dts/p3041ds.dts                  |   12 +
 arch/powerpc/boot/dts/p4080ds.dts                  |   12 +
 arch/powerpc/boot/dts/p5020ds.dts                  |   12 +
 arch/powerpc/boot/dts/p5040ds.dts                  |   12 +
 arch/powerpc/boot/dts/t1023rdb.dts                 |  151 +++
 arch/powerpc/boot/dts/t1024qds.dts                 |  251 +++++
 arch/powerpc/boot/dts/t1024rdb.dts                 |  185 ++++
 arch/powerpc/boot/dts/t104xqds.dtsi                |   12 +
 arch/powerpc/boot/dts/t104xrdb.dtsi                |   12 +
 arch/powerpc/boot/dts/t208xqds.dtsi                |   12 +
 arch/powerpc/boot/dts/t208xrdb.dtsi                |   12 +
 arch/powerpc/boot/dts/t4240qds.dts                 |   12 +
 arch/powerpc/boot/dts/t4240rdb.dts                 |   12 +
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig    |    2 +-
 arch/powerpc/configs/le.config                     |    1 +
 arch/powerpc/configs/ppc64_defconfig               |    1 +
 arch/powerpc/configs/pseries_defconfig             |    2 +-
 arch/powerpc/configs/pseries_le_defconfig          |  319 ------
 arch/powerpc/include/asm/cputable.h                |   12 +-
 arch/powerpc/include/asm/cputhreads.h              |   13 +-
 arch/powerpc/include/asm/device.h                  |    3 +
 arch/powerpc/include/asm/eeh.h                     |    9 +-
 arch/powerpc/include/asm/iommu.h                   |  119 ++-
 arch/powerpc/include/asm/machdep.h                 |   31 -
 arch/powerpc/include/asm/mmu-8xx.h                 |   33 +
 arch/powerpc/include/asm/mmu-hash64.h              |    3 +
 arch/powerpc/include/asm/mmu_context.h             |   18 +
 arch/powerpc/include/asm/opal-api.h                |   28 +-
 arch/powerpc/include/asm/opal.h                    |    8 +
 arch/powerpc/include/asm/page.h                    |    4 +-
 arch/powerpc/include/asm/pci-bridge.h              |   16 +-
 arch/powerpc/include/asm/pgtable-ppc32.h           |   19 -
 arch/powerpc/include/asm/pgtable-ppc64.h           |   28 +-
 arch/powerpc/include/asm/pnv-pci.h                 |    2 +-
 arch/powerpc/include/asm/processor.h               |    9 +
 arch/powerpc/include/asm/pte-8xx.h                 |   31 +-
 arch/powerpc/include/asm/pte-book3e.h              |    1 +
 arch/powerpc/include/asm/pte-common.h              |    2 -
 arch/powerpc/include/asm/pte-hash64.h              |    1 +
 arch/powerpc/include/asm/systbl.h                  |    2 +-
 arch/powerpc/include/asm/trace.h                   |   20 +
 arch/powerpc/include/asm/uaccess.h                 |    8 +-
 arch/powerpc/include/uapi/asm/Kbuild               |    1 +
 arch/powerpc/include/uapi/asm/cputable.h           |    1 +
 arch/powerpc/include/uapi/asm/eeh.h                |   56 +
 arch/powerpc/include/uapi/asm/opal-prd.h           |   58 ++
 arch/powerpc/include/uapi/asm/tm.h                 |    2 +-
 arch/powerpc/kernel/Makefile                       |    3 +-
 arch/powerpc/kernel/asm-offsets.c                  |    2 +-
 arch/powerpc/kernel/cputable.c                     |    4 +-
 arch/powerpc/kernel/dma.c                          |    8 +
 arch/powerpc/kernel/eeh.c                          |   43 +-
 arch/powerpc/kernel/eeh_cache.c                    |   16 +-
 arch/powerpc/kernel/eeh_driver.c                   |    2 +-
 arch/powerpc/kernel/entry_64.S                     |   37 +-
 arch/powerpc/kernel/exceptions-64s.S               |   16 +-
 arch/powerpc/kernel/head_8xx.S                     |  110 +-
 arch/powerpc/kernel/idle_e500.S                    |    9 -
 arch/powerpc/kernel/iommu.c                        |  245 ++---
 arch/powerpc/kernel/msi.c                          |   11 +-
 arch/powerpc/kernel/pci-common.c                   |   11 +
 arch/powerpc/kernel/pci-hotplug.c                  |    5 +
 arch/powerpc/kernel/process.c                      |    1 -
 arch/powerpc/kernel/setup_64.c                     |    6 +-
 arch/powerpc/kernel/sysfs.c                        |   38 +
 arch/powerpc/kernel/tm.S                           |    4 +-
 arch/powerpc/kernel/traps.c                        |   45 +-
 arch/powerpc/kernel/vdso.c                         |  135 ++-
 arch/powerpc/kernel/vio.c                          |    5 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |    2 +-
 arch/powerpc/lib/Makefile                          |    2 +-
 arch/powerpc/mm/Makefile                           |    1 +
 arch/powerpc/mm/copro_fault.c                      |    9 +-
 arch/powerpc/mm/hash_native_64.c                   |    2 +-
 arch/powerpc/mm/hash_utils_64.c                    |    4 +-
 arch/powerpc/mm/mem.c                              |    2 +-
 arch/powerpc/mm/mmu_context_hash64.c               |    6 +
 arch/powerpc/mm/mmu_context_iommu.c                |  316 ++++++
 arch/powerpc/mm/tlb_low_64e.S                      |   51 +-
 arch/powerpc/perf/core-book3s.c                    |   11 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |    2 +-
 arch/powerpc/platforms/85xx/Kconfig                |    2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c      |    3 +
 arch/powerpc/platforms/85xx/smp.c                  |   51 +-
 arch/powerpc/platforms/85xx/twr_p102x.c            |    4 +-
 arch/powerpc/platforms/Kconfig.cputype             |   11 +
 arch/powerpc/platforms/cell/axon_msi.c             |    7 +-
 arch/powerpc/platforms/cell/iommu.c                |    8 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |    2 +-
 arch/powerpc/platforms/pasemi/Makefile             |    1 +
 arch/powerpc/platforms/pasemi/iommu.c              |    7 +-
 .../mpic_pasemi_msi.c =3D> platforms/pasemi/msi.c}   |   13 +-
 arch/powerpc/platforms/powernv/Kconfig             |    7 +
 arch/powerpc/platforms/powernv/Makefile            |    5 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |   62 +-
 arch/powerpc/platforms/powernv/idle.c              |  293 ++++++
 arch/powerpc/platforms/powernv/opal-async.c        |    3 +-
 arch/powerpc/platforms/powernv/opal-dump.c         |   56 +-
 arch/powerpc/platforms/powernv/opal-elog.c         |   32 +-
 arch/powerpc/platforms/powernv/opal-hmi.c          |    3 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c      |  253 +++++
 .../powerpc/platforms/powernv/opal-memory-errors.c |    2 +-
 arch/powerpc/platforms/powernv/opal-prd.c          |  449 ++++++++
 arch/powerpc/platforms/powernv/opal-sensor.c       |    3 +-
 arch/powerpc/platforms/powernv/opal-sysparam.c     |   43 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S     |    2 +
 arch/powerpc/platforms/powernv/opal.c              |  221 +---
 arch/powerpc/platforms/powernv/pci-ioda.c          |  790 ++++++++++----
 arch/powerpc/platforms/powernv/pci-p5ioc2.c        |   45 +-
 arch/powerpc/platforms/powernv/pci.c               |  204 ++--
 arch/powerpc/platforms/powernv/pci.h               |   31 +-
 arch/powerpc/platforms/powernv/powernv.h           |   11 +-
 arch/powerpc/platforms/powernv/setup.c             |  181 +---
 arch/powerpc/platforms/pseries/dlpar.c             |    3 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c       |    2 +-
 arch/powerpc/platforms/pseries/iommu.c             |  179 +++-
 arch/powerpc/platforms/pseries/msi.c               |   16 +-
 arch/powerpc/sysdev/Makefile                       |    2 +-
 arch/powerpc/sysdev/dart_iommu.c                   |   12 +-
 arch/powerpc/sysdev/fsl_msi.c                      |   23 +-
 arch/powerpc/sysdev/i8259.c                        |    2 +-
 arch/powerpc/sysdev/ipic.c                         |    2 +-
 arch/powerpc/sysdev/mpc8xx_pic.c                   |    2 +-
 arch/powerpc/sysdev/mpic.c                         |    2 +-
 arch/powerpc/sysdev/mpic.h                         |   10 +-
 arch/powerpc/sysdev/mpic_u3msi.c                   |    9 +-
 arch/powerpc/sysdev/mv64x60_pic.c                  |    2 +-
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c              |    7 +-
 arch/powerpc/sysdev/ppc4xx_msi.c                   |    7 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c                 |    2 +-
 arch/powerpc/sysdev/tsi108_pci.c                   |    2 +-
 arch/powerpc/sysdev/uic.c                          |    4 +-
 arch/powerpc/sysdev/xics/icp-native.c              |   14 +-
 arch/powerpc/sysdev/xics/xics-common.c             |    4 +-
 arch/powerpc/sysdev/xilinx_intc.c                  |    2 +-
 drivers/char/ipmi/ipmi_powernv.c                   |   39 +-
 drivers/macintosh/nvram.c                          |  130 ---
 drivers/misc/cxl/Kconfig                           |    5 +
 drivers/misc/cxl/Makefile                          |    4 +-
 drivers/misc/cxl/api.c                             |  331 ++++++
 drivers/misc/cxl/base.c                            |    2 +-
 drivers/misc/cxl/context.c                         |   36 +-
 drivers/misc/cxl/cxl.h                             |   38 +-
 drivers/misc/cxl/fault.c                           |   34 +-
 drivers/misc/cxl/file.c                            |   48 +-
 drivers/misc/cxl/irq.c                             |   37 +-
 drivers/misc/cxl/main.c                            |    2 +-
 drivers/misc/cxl/native.c                          |   83 +-
 drivers/misc/cxl/pci.c                             |  129 ++-
 drivers/misc/cxl/sysfs.c                           |   35 +-
 drivers/misc/cxl/vphb.c                            |  270 +++++
 drivers/mtd/devices/Kconfig                        |    8 +
 drivers/mtd/devices/Makefile                       |    1 +
 drivers/mtd/devices/powernv_flash.c                |  285 +++++
 drivers/tty/hvc/hvc_opal.c                         |   33 +-
 drivers/vfio/vfio_iommu_spapr_tce.c                | 1101 ++++++++++++++++=
++--
 drivers/vfio/vfio_spapr_eeh.c                      |   10 +
 include/misc/cxl-base.h                            |   48 +
 include/misc/cxl.h                                 |  207 +++-
 include/uapi/linux/vfio.h                          |  102 +-
 include/uapi/misc/cxl.h                            |   22 +
 lib/raid6/Makefile                                 |    2 +-
 tools/testing/selftests/powerpc/Makefile           |    2 +-
 tools/testing/selftests/powerpc/dscr/.gitignore    |    7 +
 tools/testing/selftests/powerpc/dscr/Makefile      |   14 +
 tools/testing/selftests/powerpc/dscr/dscr.h        |  127 +++
 .../selftests/powerpc/dscr/dscr_default_test.c     |  127 +++
 .../selftests/powerpc/dscr/dscr_explicit_test.c    |   71 ++
 .../powerpc/dscr/dscr_inherit_exec_test.c          |  117 +++
 .../selftests/powerpc/dscr/dscr_inherit_test.c     |   95 ++
 .../selftests/powerpc/dscr/dscr_sysfs_test.c       |   97 ++
 .../powerpc/dscr/dscr_sysfs_thread_test.c          |   80 ++
 .../selftests/powerpc/dscr/dscr_user_test.c        |   61 ++
 .../selftests/powerpc/switch_endian/Makefile       |   14 +-
 tools/testing/selftests/powerpc/tm/Makefile        |    4 +-
 tools/testing/selftests/powerpc/tm/tm-syscall.c    |    3 +-
 tools/testing/selftests/powerpc/vphn/Makefile      |   13 +-
 210 files changed, 9258 insertions(+), 2216 deletions(-)
 create mode 100644 Documentation/powerpc/dscr.txt
 create mode 100644 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t1024si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/t1023rdb.dts
 create mode 100644 arch/powerpc/boot/dts/t1024qds.dts
 create mode 100644 arch/powerpc/boot/dts/t1024rdb.dts
 create mode 100644 arch/powerpc/configs/le.config
 delete mode 100644 arch/powerpc/configs/pseries_le_defconfig
 create mode 100644 arch/powerpc/include/uapi/asm/eeh.h
 create mode 100644 arch/powerpc/include/uapi/asm/opal-prd.h
 create mode 100644 arch/powerpc/mm/mmu_context_iommu.c
 rename arch/powerpc/{sysdev/mpic_pasemi_msi.c =3D> platforms/pasemi/msi.c}=
 (93%)
 create mode 100644 arch/powerpc/platforms/powernv/idle.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-irqchip.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-prd.c
 delete mode 100644 drivers/macintosh/nvram.c
 create mode 100644 drivers/misc/cxl/api.c
 create mode 100644 drivers/misc/cxl/vphb.c
 create mode 100644 drivers/mtd/devices/powernv_flash.c
 create mode 100644 include/misc/cxl-base.h
 create mode 100644 tools/testing/selftests/powerpc/dscr/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/dscr/Makefile
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr.h
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_default_test.=
c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_explicit_test=
.c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_=
test.c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_inherit_test.=
c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_=
test.c
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_user_test.c



--=-h4/wxnyYT1fcNIml0XCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJViTWzAAoJEFHr6jzI4aWADlEQAIHwIKHwLp90giUOYF71JNwQ
kleRBZTqRwQvbRMreGmyZGK3536iE43aNVRsU20xdOUmj9dVkFDruLWySYQ6hMIj
9Msqc4kvQ/PICBCLlUc03PcFu3/k/ZkUYh5AQIITO8FP4R+m4l3LPio++zaNARzk
l688sgLY1ICY8OS6EI3blW7qhmpAdBA6sDfQCVNZfVbxaJEHEArE/fWZPIyI2Qu3
wv7wwLoKjUdMTlEQJdVy1gyZRB+t+vs0q9MQ3KmogBNyRN8ySa9vXkRYFbBFsQro
daMbeiyP3rXIALA2cLEG/V0QRWhx9DAH1ggzTG44n2QjrudTAYL0UEcm2oKiqwjp
1CPj78QTfP02ndSuzjcfoqmxh+TwX1mDfPoFbWLUBnTaTmIeAywI0bu4RDQLu5Ga
PJ0LWNz3tfEAOm0IvrqEkZ6vtrbXBUVpuS4UE9LnDbEhZrHxx83qgODG8tppYn7C
0Y+LdUaOidblLzNRRS+3vLG8HXyzyiOtiYeySB707XbFpvKoef6MnapwhWdzmUYB
DhIMsT2gTorsaTg5jwDPnlkrSovGkKZ46ylgJAO4Py+57l9fczHkDbZNv5gZ/aRf
mGXWxScShfAJ9DPnouZJgvX4ANBZjUJT7Cw5iXa/ZKLH1ozg45gRsXxX+WOB7DYP
lQP3iq8L9UpY93KSxNsN
=pY3L
-----END PGP SIGNATURE-----

--=-h4/wxnyYT1fcNIml0XCM--
