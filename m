Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRP9k3F9dzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 23:07:38 +1100 (AEDT)
Message-ID: <1458302850.10432.2.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.6-1 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Igal.Liberman@freescale.com, Zhiqiang.Hou@freescale.com,
 adam.buchbinder@gmail.com, aik@ozlabs.ru, alessio.bogani@elettra.eu,
 andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 b.zolnierkie@samsung.com, bhelgaas@google.com, boqun.feng@gmail.com,
 bsingharora@gmail.com, chenhui.zhao@freescale.com, christophe.leroy@c-s.fr,
 clombard@linux.vnet.ibm.com, cyrilbur@gmail.com,
 david@gibson.dropbear.id.au,  dongsheng.wang@freescale.com,
 dougmill@linux.vnet.ibm.com, duwe@lst.de,  duwe@suse.de,
 fbarrat@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 igal.liberman@freescale.com, imunsie@au1.ibm.com, jk@ozlabs.org,
 joel@jms.id.au,  kirill.shutemov@linux.intel.com, leoyang.li@nxp.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 luis.henriques@canonical.com, maddy@linux.vnet.ibm.com,
 manoj@linux.vnet.ibm.com,  mikey@neuling.org, mrochs@linux.vnet.ibm.com,
 oss@buserror.net, paulus@ozlabs.org,  paulus@samba.org, qiang.zhao@nxp.com,
 raghav.dogra@nxp.com, ruscur@russell.cc,  saurabh.truth@gmail.com,
 sjitindarsingh@gmail.com, stewart@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 weiyang@linux.vnet.ibm.com, xinhui.pan@linux.vnet.ibm.com,
 xuelin.shi@nxp.com
Date: Fri, 18 Mar 2016 23:07:30 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-oGM34Ph8IdpV2ZMnPKP5"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-oGM34Ph8IdpV2ZMnPKP5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc updates for 4.6:

The following changes since commit 9ab3ac233a8b4ffcc27c8475b83dee49fc46bc76=
:

  powerpc/mm/hash: Clear the invalid slot information correctly (2016-02-22=
 19:27:39 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.6-1

for you to fetch changes up to 6e669f085d595cb6053920832c89f1a13067db44:

  powerpc: Fix unrecoverable SLB miss during restore_math() (2016-03-16 15:=
23:02 +1100)


This was delayed a day or two by some build-breakage on old toolchains whic=
h
we've now fixed.

There's two PCI commits both acked by Bjorn.

There's one commit to mm/hugepage.c which is (co)authored by Kirill.

There's one minor merge conflict in the powerpc KVM code that is already in
your tree.

I couldn't convince git request-pull to generate a sane diffstat below, it
seems to be confused because I merged powerpc-4.5-4 into my next. So I just=
 did
the merge and took that diffstat. Hopefully that makes sense.

cheers

----------------------------------------------------------------
powerpc updates for 4.6

Highlights:
 - Restructure Linux PTE on Book3S/64 to Radix format from Paul Mackerras
 - Book3s 64 MMU cleanup in preparation for Radix MMU from Aneesh Kumar K.V
 - Add POWER9 cputable entry from Michael Neuling
 - FPU/Altivec/VSX save/restore optimisations from Cyril Bur
 - Add support for new ftrace ABI on ppc64le from Torsten Duwe

Various cleanups & minor fixes from:
 - Adam Buchbinder, Andrew Donnellan, Balbir Singh, Christophe Leroy, Cyril
   Bur, Luis Henriques, Madhavan Srinivasan, Pan Xinhui, Russell Currey,
   Sukadev Bhattiprolu, Suraj Jitindar Singh.

General:
 - atomics: Allow architectures to define their own __atomic_op_* helpers f=
rom
   Boqun Feng
 - Implement atomic{, 64}_*_return_* variants and acquire/release/relaxed
   variants for (cmp)xchg from Boqun Feng
 - Add powernv_defconfig from Jeremy Kerr
 - Fix BUG_ON() reporting in real mode from Balbir Singh
 - Add xmon command to dump OPAL msglog from Andrew Donnellan
 - Add xmon command to dump process/task similar to ps(1) from Douglas Mill=
er
 - Clean up memory hotplug failure paths from David Gibson

pci/eeh:
 - Redesign SR-IOV on PowerNV to give absolute isolation between VFs from W=
ei
   Yang.
 - EEH Support for SRIOV VFs from Wei Yang and Gavin Shan.
 - PCI/IOV: Rename and export virtfn_{add, remove} from Wei Yang
 - PCI: Add pcibios_bus_add_device() weak function from Wei Yang
 - MAINTAINERS: Update EEH details and maintainership from Russell Currey

cxl:
 - Support added to the CXL driver for running on both bare-metal and
   hypervisor systems, from Christophe Lombard and Frederic Barrat.
 - Ignore probes for virtual afu pci devices from Vaibhav Jain

perf:
 - Export Power8 generic and cache events to sysfs from Sukadev Bhattiprolu
 - hv-24x7: Fix usage with chip events, display change in counter values,
   display domain indices in sysfs, eliminate domain suffix in event names,
   from Sukadev Bhattiprolu

Freescale:
 - Updates from Scott: "Highlights include 8xx optimizations, 32-bit checks=
um
   optimizations, 86xx consolidation, e5500/e6500 cpu hotplug, more fman an=
d
   other dt bits, and minor fixes/cleanup."

----------------------------------------------------------------
Adam Buchbinder (1):
      powerpc: Fix misspellings in comments.

Alessio Igor Bogani (6):
      powerpc/86xx: Consolidate common platform code
      powerpc/86xx: Update defconfigs
      powerpc/86xx: Switch to kconfig fragments approach
      powerpc/86xx: Move dts files to fsl directory
      powerpc/86xx: Update device tree
      powerpc/86xx: Introduce and use common dtsi

Andrew Donnellan (6):
      powerpc/xmon: fix typo in usage message
      powerpc/eeh: fix incorrect function name in comment
      powerpc/powernv: new function to access OPAL msglog
      powerpc/xmon: add command to dump OPAL msglog
      powerpc/powernv: don't create OPAL msglog sysfs entry if memcons init=
 fails
      powerpc/eeh: eeh_pci_enable(): fix checking of post-request state

Aneesh Kumar K.V (7):
      powerpc/mm: Split pgtable types to separate header
      powerpc/mm: Don't have conditional defines for real_pte_t
      powerpc/mm: Switch book3s 64 with 64K page size to 4 level page table
      powerp/mm: Update code comments
      powerpc/mm: add _PAGE_HASHPTE similar to 4K hash
      powerpc/mm: Move hash related mmu-*.h headers to book3s/
      powerpc/mm: Move hash64 tlbflush code into a new header

Balbir Singh (2):
      powerpc: Fix kgdb on little endian ppc64le
      powerpc: Fix BUG_ON() reporting in real mode

Bartlomiej Zolnierkiewicz (4):
      powerpc/83xx: disable IDE subsystem in mpc834x_itx_defconfig
      powerpc/85xx: disable IDE subsystem in ksi8560_defconfig
      powerpc/85xx: disable IDE subsystem in stx_gp3_defconfig
      powerpc/86xx: disable IDE subsystem in mpc8610_hpcd_defconfig

Boqun Feng (4):
      atomics: Allow architectures to define their own __atomic_op_* helper=
s
      powerpc: atomic: Implement atomic{, 64}_*_return_* variants
      powerpc: atomic: Implement acquire/release/relaxed variants for xchg
      powerpc: atomic: Implement acquire/release/relaxed variants for cmpxc=
hg

Christophe Leroy (32):
      powerpc: unexport csum_tcpudp_magic
      powerpc: mark xer clobbered in csum_add()
      powerpc32: checksum_wrappers_64 becomes checksum_wrappers
      powerpc: inline ip_fast_csum()
      powerpc32: rewrite csum_partial_copy_generic() based on copy_tofrom_u=
ser()
      powerpc32: optimise a few instructions in csum_partial()
      powerpc32: optimise csum_partial() loop
      powerpc: simplify csum_add(a, b) in case a or b is constant 0
      powerpc/885: set SDCR to 0x40
      powerpc/8xx: CONFIG_DEBUG_PAGEALLOC requires ITLBmiss for kernel addr=
esses
      powerpc: optimise csum_partial() call when len is constant
      powerpc/8xx: Save r3 all the time in DTLB miss handler
      powerpc/8xx: Map linear kernel RAM with 8M pages
      powerpc: Update documentation for noltlbs kernel parameter
      powerpc/8xx: move setup_initial_memory_limit() into 8xx_mmu.c
      powerpc32: Fix pte_offset_kernel() to return NULL for bad pages
      powerpc32: refactor x_mapped_by_bats() and x_mapped_by_tlbcam() toget=
her
      powerpc32: Remove useless/wrong MMU:setio progress message
      powerpc32: remove ioremap_base
      powerpc/8xx: Add missing SPRN defines into reg_8xx.h
      powerpc/8xx: Handle CPU6 ERRATA directly in mtspr() macro
      powerpc/8xx: remove special handling of CPU6 errata in set_dec()
      powerpc/8xx: rewrite set_context() in C
      powerpc/8xx: rewrite flush_instruction_cache() in C
      powerpc: add inline functions for cache related instructions
      powerpc32: Remove clear_pages() and define clear_page() inline
      powerpc32: move xxxxx_dcache_range() functions inline
      powerpc: Simplify test in __dma_sync()
      powerpc32: small optimisation in flush_icache_range()
      powerpc32: Remove one insn in mulhdu
      powerpc32: PAGE_EXEC required for inittext
      powerpc/8xx: Fix do_mtspr_cpu6() build on older compilers

Christophe Lombard (9):
      cxl: Move common code away from bare-metal-specific files
      powerpc: New possible return value from hcall
      cxl: New hcalls to support cxl adapters
      cxl: Separate bare-metal fields in adapter and AFU data structures
      cxl: Add guest-specific code
      cxl: sysfs support for guests
      cxl: Support to flash a new image on the adapter from a guest
      cxl: Adapter failure handling
      cxl: Add tracepoints around the cxl hcall

Cyril Bur (10):
      selftests/powerpc: Test the preservation of FPU and VMX regs across s=
yscall
      selftests/powerpc: Test preservation of FPU and VMX regs across preem=
ption
      selftests/powerpc: Test FPU and VMX regs in signal ucontext
      powerpc: Explicitly disable math features when copying thread
      powerpc: Restore FPU/VEC/VSX if previously used
      powerpc: Prepare for splitting giveup_{fpu, altivec, vsx} in two
      powerpc: Add the ability to save FPU without giving it up
      powerpc: Add the ability to save Altivec without giving it up
      powerpc: Add the ability to save VSX without giving it up
      powerpc: Fix unrecoverable SLB miss during restore_math()

David Gibson (4):
      powerpc/mm: Clean up error handling for htab_remove_mapping
      powerpc/mm: Handle removing maybe-present bolted HPTEs
      powerpc/mm: Clean up memory hotplug failure paths
      powerpc/mm: Split hash page table sizing heuristic into a helper

Douglas Miller (1):
      powerpc/xmon: Add xmon command to dump process/task similar to ps(1)

Frederic Barrat (11):
      cxl: Move bare-metal specific code to specialized files
      cxl: Define process problem state area at attach time only
      cxl: Introduce implementation-specific API
      cxl: Rename some bare-metal specific functions
      cxl: Isolate a few bare-metal-specific calls
      cxl: Update cxl_irq() prototype
      cxl: IRQ allocation for guests
      cxl: Parse device tree and create cxl device(s) at boot
      cxl: Support the cxl kernel API from a guest
      cxlflash: Use new cxl_pci_read_adapter_vpd() API
      cxl: Remove cxl_get_phys_dev() kernel API

Gavin Shan (6):
      powerpc/powernv: Simplify definitions of EEH debugfs handlers
      powerpc/eeh: Reworked eeh_pe_bus_get()
      powerpc/eeh: Don't propagate error to guest
      powerpc/eeh: Don't remove passed VFs
      powerpc/eeh: Synchronize recovery in host/guest
      powerpc/eeh: Remove duplicated check in eeh_dump_pe_log()

Hou Zhiqiang (1):
      powerpc/fsl/dts: Add "jedec,spi-nor" flash compatible

Igal Liberman (3):
      powerpc/fsl: Update fman dt binding with pcs-phy and tbi-phy
      powerpc/mpc85xx: Add MDIO bus muxing support to the board device tree=
(s)
      powerpc/mpc85xx: Add pcsphy nodes to FManV3 device tree

Jeremy Kerr (3):
      powerpc/powernv: Add powernv_defconfig
      powerpc/powernv: Add powernv firmware interface drivers to powernv_de=
fconfig
      powerpc/powernv: Add AST graphics driver to powernv_defconfig

Kirill A. Shutemov (1):
      mm: Some arch may want to use HPAGE_PMD related values as variables

Luis Henriques (4):
      powerpc/ps3: gelic_udbg: use struct ethhdr from <linux/if_ether.h>
      powerpc/ps3: gelic_udbg: use struct vlan_hdr from <linux/if_vlan.h>
      powerpc/ps3: gelic_udbg: use struct iphdr from <linux/ip.h>
      powerpc/ps3: gelic_udbg: use struct udphdr from <linux/udp.h>

Madhavan Srinivasan (1):
      powerpc/perf: Fix misleading comment in pmao_restore_workaround()

Michael Ellerman (9):
      Merge tag 'powerpc-4.5-4' into next
      selftests/powerpc: Fix out of bounds access in TM signal test
      powerpc: Create a helper for getting the kernel toc value
      powerpc/module: Only try to generate the ftrace_caller() stub once
      powerpc/module: Mark module stubs with a magic value
      powerpc/module: Create a special stub for ftrace_caller()
      Merge branch 'topic/mprofile-kernel' into next
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into =
next
      powerpc/rcpm: Fix build break when SMP=3Dn

Michael Neuling (3):
      powerpc/powernv: Create separate subcores CPU feature bit
      powerpc: Use defines for __init_tlb_power[78]
      powerpc: Add POWER9 cputable entry

Paul Mackerras (9):
      powerpc/mm/book3s-64: Clean up some obsolete or misleading comments
      powerpc/mm/book3s-64: Free up 7 high-order bits in the Linux PTE
      powerpc/mm/book3s-64: Use physical addresses in upper page table tree=
 levels
      powerpc/mm/book3s-64: Move _PAGE_PRESENT to the most significant bit
      powerpc/mm/book3s-64: Move _PAGE_PTE to 2nd most significant bit
      powerpc/mm/book3s-64: Move HPTE-related bits in PTE to upper end
      powerpc/mm/book3s-64: Shuffle read, write, execute and user bits in P=
TE
      powerpc/mm/book3s-64: Move software-used bits in PTE
      powerpc/mm/book3s-64: Expand the real page number field of the Linux =
PTE

Raghav Dogra (1):
      powerpc/fsl-lbc: Modify suspend/resume entry sequence

Russell Currey (2):
      powerpc/powernv: Remove support for p5ioc2
      MAINTAINERS: Update EEH details and maintainership

Saurabh Sengar (2):
      qe: Make cpm_muram_alloc_common static
      qe: Use GFP_ATOMIC while spin_lock_irqsave is held

Scott Wood (1):
      powerpc/book3e-64: Use hardcoded mttmr opcode

Sukadev Bhattiprolu (7):
      powerpc/perf/hv-gpci: Increase request buffer size
      powerpc/perf: Remove PME_ prefix for power7 events
      powerpc/perf: Export Power8 generic and cache events to sysfs
      powerpc/perf/hv-24x7: Fix usage with chip events.
      powerpc/perf/hv-24x7: Display change in counter values
      powerpc/perf/hv-24x7: Display domain indices in sysfs
      powerpc/perf/24x7: Eliminate domain suffix in event names

Suraj Jitindar Singh (1):
      selftests/powerpc: Remove -flto from common CFLAGS

Torsten Duwe (4):
      powerpc/ftrace: Use generic ftrace_modify_all_code()
      powerpc/ftrace: Use $(CC_FLAGS_FTRACE) when disabling ftrace
      powerpc/ftrace: Add support for -mprofile-kernel ftrace ABI
      powerpc/ftrace: Add Kconfig & Make glue for mprofile-kernel

Vaibhav Jain (1):
      cxl: Ignore probes for virtual afu pci devices

Wang Dongsheng (1):
      Documentation: dt: binding: fsl: add devicetree binding for describin=
g RCPM

Wei Yang (15):
      powerpc/powernv: don't enable SRIOV when VF BAR has non 64bit-prefetc=
hable BAR
      powerpc/powernv: simplify the calculation of iov resource alignment
      powerpc/powernv: use one M64 BAR in Single PE mode for one VF BAR
      powerpc/powernv: replace the hard coded boundary with gate
      powerpc/powernv: boundary the total VF BAR size instead of the indivi=
dual one
      powerpc/powernv: allocate sparse PE# when using M64 BAR in Single PE =
mode
      PCI/IOV: Rename and export virtfn_{add, remove}
      PCI: Add pcibios_bus_add_device() weak function
      powerpc/pci: Remove VFs prior to PF
      powerpc/eeh: Cache normal BARs, not windows or IOV BARs
      powerpc/eeh: EEH device for VF
      powerpc/eeh: Create PE for VFs
      powerpc/powernv: Support EEH reset for VF PE
      powerpc/powernv: Support PCI config restore for VFs
      powerpc/eeh: powerpc/eeh: Support error recovery for VF PE

Xuelin Shi (1):
      powerpc/p5040: Add device node for RAID Engine

Zhao Qiang (2):
      qe/ic: fix a buffer overflow error and add check elsewhere
      powerpc/T104xRDB: add tdm riser card node to device tree

chenhui zhao (6):
      powerpc/mm: any thread in one core can be the first to setup TLB1
      powerpc/cache: add cache flush operation for various e500
      powerpc/rcpm: add RCPM driver
      powerpc/mpc85xx: refactor the PM operations
      powerpc/mpc85xx: Add hotplug support on E5500 and E500MC cores
      powerpc/mpc85xx: Add CPU hotplug support for E6500

pan xinhui (1):
      powerpc: Use BUILD_BUG_ON_MSG() for unsupported {cmp}xchg sizes

 Documentation/ABI/testing/sysfs-class-cxl          |   10 +-
 .../devicetree/bindings/powerpc/fsl/fman.txt       |   40 +
 Documentation/devicetree/bindings/soc/fsl/rcpm.txt |   63 ++
 Documentation/kernel-parameters.txt                |    2 +-
 Documentation/powerpc/cxl.txt                      |   55 +
 MAINTAINERS                                        |   16 +-
 arch/powerpc/Kconfig                               |   23 +-
 arch/powerpc/Makefile                              |   25 +
 arch/powerpc/boot/dts/fsl/b4860qds.dts             |   60 +-
 arch/powerpc/boot/dts/fsl/b4qds.dtsi               |   53 +-
 arch/powerpc/boot/dts/fsl/bsc9131rdb.dtsi          |    2 +-
 arch/powerpc/boot/dts/fsl/bsc9132qds.dtsi          |    2 +-
 arch/powerpc/boot/dts/fsl/c293pcie.dts             |    2 +-
 arch/powerpc/boot/dts/fsl/gef_ppc9a.dts            |  216 ++++
 arch/powerpc/boot/dts/fsl/gef_sbc310.dts           |  260 +++++
 arch/powerpc/boot/dts/fsl/gef_sbc610.dts           |  214 ++++
 arch/powerpc/boot/dts/fsl/kmcoge4.dts              |    4 +-
 arch/powerpc/boot/dts/fsl/mpc8536ds.dtsi           |    8 +-
 arch/powerpc/boot/dts/{ =3D> fsl}/mpc8641_hpcn.dts   |  347 +-----
 .../boot/dts/{ =3D> fsl}/mpc8641_hpcn_36b.dts        |  330 +-----
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi      |  120 ++
 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi       |   58 +
 arch/powerpc/boot/dts/fsl/mvme2500.dts             |    4 +-
 arch/powerpc/boot/dts/fsl/p1010rdb.dtsi            |    2 +-
 arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi         |    2 +-
 arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts          |    2 +-
 arch/powerpc/boot/dts/fsl/p1020rdb.dtsi            |    2 +-
 arch/powerpc/boot/dts/fsl/p1021mds.dts             |    2 +-
 arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi         |    2 +-
 arch/powerpc/boot/dts/fsl/p1022ds.dtsi             |    2 +-
 arch/powerpc/boot/dts/fsl/p1022rdk.dts             |    2 +-
 arch/powerpc/boot/dts/fsl/p1024rdb.dtsi            |    2 +-
 arch/powerpc/boot/dts/fsl/p1025rdb.dtsi            |    2 +-
 arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi         |    2 +-
 arch/powerpc/boot/dts/fsl/p2020rdb.dts             |    2 +-
 arch/powerpc/boot/dts/fsl/p2041rdb.dts             |   94 +-
 arch/powerpc/boot/dts/fsl/p3041ds.dts              |  114 +-
 arch/powerpc/boot/dts/fsl/p4080ds.dts              |  186 +++-
 arch/powerpc/boot/dts/fsl/p5020ds.dts              |  114 +-
 arch/powerpc/boot/dts/fsl/p5040ds.dts              |  236 +++-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |    1 +
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |    6 +
 .../dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi   |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi |    5 +
 .../dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi   |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi  |    5 +
 arch/powerpc/boot/dts/fsl/sbc8641d.dts             |  203 ++++
 arch/powerpc/boot/dts/fsl/t1023rdb.dts             |   43 +-
 arch/powerpc/boot/dts/fsl/t1024qds.dts             |    6 +-
 arch/powerpc/boot/dts/fsl/t1024rdb.dts             |   47 +-
 arch/powerpc/boot/dts/fsl/t1040rdb.dts             |   32 +-
 arch/powerpc/boot/dts/fsl/t1042rdb.dts             |   30 +-
 arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts          |   18 +-
 arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi          |    2 +-
 arch/powerpc/boot/dts/fsl/t104xqds.dtsi            |  180 ++-
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi            |   40 +-
 arch/powerpc/boot/dts/fsl/t2080qds.dts             |  158 ++-
 arch/powerpc/boot/dts/fsl/t2080rdb.dts             |   67 +-
 arch/powerpc/boot/dts/fsl/t2081qds.dts             |  221 +++-
 arch/powerpc/boot/dts/fsl/t208xqds.dtsi            |    6 +-
 arch/powerpc/boot/dts/fsl/t208xrdb.dtsi            |    2 +-
 arch/powerpc/boot/dts/fsl/t4240qds.dts             |  402 ++++++-
 arch/powerpc/boot/dts/fsl/t4240rdb.dts             |  151 ++-
 arch/powerpc/boot/dts/gef_ppc9a.dts                |  425 -------
 arch/powerpc/boot/dts/gef_sbc310.dts               |  459 --------
 arch/powerpc/boot/dts/gef_sbc610.dts               |  423 -------
 arch/powerpc/boot/dts/sbc8641d.dts                 |  447 --------
 arch/powerpc/boot/rs6000.h                         |    2 +-
 arch/powerpc/boot/treeboot-akebono.c               |    2 +-
 arch/powerpc/boot/treeboot-currituck.c             |    2 +-
 arch/powerpc/boot/treeboot-iss4xx.c                |    2 +-
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig    |    1 -
 arch/powerpc/configs/85xx/ksi8560_defconfig        |    1 -
 arch/powerpc/configs/85xx/stx_gp3_defconfig        |    2 -
 arch/powerpc/configs/86xx-hw.config                |  104 ++
 arch/powerpc/configs/86xx-smp.config               |    2 +
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig      |  216 ----
 arch/powerpc/configs/86xx/gef_sbc310_defconfig     |  214 ----
 arch/powerpc/configs/86xx/gef_sbc610_defconfig     |  273 -----
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig   |  110 --
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig   |  156 ---
 arch/powerpc/configs/86xx/sbc8641d_defconfig       |  246 ----
 arch/powerpc/configs/mpc86xx_basic_defconfig       |   10 +
 arch/powerpc/configs/mpc86xx_defconfig             |  162 ---
 arch/powerpc/configs/powernv_defconfig             |  313 ++++++
 arch/powerpc/crypto/aes-spe-core.S                 |    4 +-
 arch/powerpc/crypto/aes-spe-glue.c                 |    2 +-
 arch/powerpc/include/asm/atomic.h                  |  159 +--
 .../asm/{mmu-hash32.h =3D> book3s/32/mmu-hash.h}     |    0
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |   36 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |   57 +-
 arch/powerpc/include/asm/book3s/64/hash.h          |   68 +-
 .../asm/{mmu-hash64.h =3D> book3s/64/mmu-hash.h}     |    4 +
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   36 +-
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |   94 ++
 arch/powerpc/include/asm/cache.h                   |   19 +
 arch/powerpc/include/asm/cacheflush.h              |   54 +-
 arch/powerpc/include/asm/checksum.h                |  141 ++-
 arch/powerpc/include/asm/cmpxchg.h                 |  237 +++-
 arch/powerpc/include/asm/code-patching.h           |   21 +
 arch/powerpc/include/asm/cputable.h                |   28 +-
 arch/powerpc/include/asm/cputhreads.h              |   15 +
 arch/powerpc/include/asm/eeh.h                     |    5 +
 arch/powerpc/include/asm/fsl_pm.h                  |   51 +
 arch/powerpc/include/asm/ftrace.h                  |    5 +
 arch/powerpc/include/asm/hugetlb.h                 |    2 +-
 arch/powerpc/include/asm/hvcall.h                  |    1 +
 arch/powerpc/include/asm/hydra.h                   |    2 +-
 arch/powerpc/include/asm/io.h                      |    2 +-
 arch/powerpc/include/asm/machdep.h                 |    6 +-
 arch/powerpc/include/asm/mmu-8xx.h                 |    4 +-
 arch/powerpc/include/asm/mmu.h                     |    5 +-
 arch/powerpc/include/asm/module.h                  |   14 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |    5 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h       |    3 +
 arch/powerpc/include/asm/opal.h                    |    3 +
 arch/powerpc/include/asm/page.h                    |  111 +-
 arch/powerpc/include/asm/page_32.h                 |   17 +-
 arch/powerpc/include/asm/pci-bridge.h              |    9 +-
 arch/powerpc/include/asm/perf_event_server.h       |   10 +-
 arch/powerpc/include/asm/pgalloc-64.h              |   42 +-
 arch/powerpc/include/asm/pgtable-types.h           |  103 ++
 arch/powerpc/include/asm/pmac_feature.h            |    2 +-
 arch/powerpc/include/asm/processor.h               |    2 +
 arch/powerpc/include/asm/reg.h                     |   18 +-
 arch/powerpc/include/asm/reg_8xx.h                 |   93 ++
 arch/powerpc/include/asm/reg_booke.h               |    2 +-
 arch/powerpc/include/asm/sections.h                |   12 +
 arch/powerpc/include/asm/smp.h                     |    4 +
 arch/powerpc/include/asm/smu.h                     |    2 +-
 arch/powerpc/include/asm/switch_to.h               |   13 +-
 arch/powerpc/include/asm/time.h                    |    6 +-
 arch/powerpc/include/asm/tlbflush.h                |   92 +-
 arch/powerpc/include/asm/uninorth.h                |    2 +-
 arch/powerpc/include/asm/xics.h                    |    2 +-
 arch/powerpc/include/uapi/asm/epapr_hcalls.h       |    4 +-
 arch/powerpc/kernel/Makefile                       |   12 +-
 arch/powerpc/kernel/asm-offsets.c                  |    3 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |  112 ++
 arch/powerpc/kernel/cpu_setup_power.S              |   49 +-
 arch/powerpc/kernel/cputable.c                     |   31 +
 arch/powerpc/kernel/eeh.c                          |   39 +-
 arch/powerpc/kernel/eeh_cache.c                    |   11 +-
 arch/powerpc/kernel/eeh_dev.c                      |    1 +
 arch/powerpc/kernel/eeh_driver.c                   |  150 ++-
 arch/powerpc/kernel/eeh_pe.c                       |   38 +-
 arch/powerpc/kernel/entry_64.S                     |  196 +++-
 arch/powerpc/kernel/fpu.S                          |   25 +-
 arch/powerpc/kernel/ftrace.c                       |  132 ++-
 arch/powerpc/kernel/head_44x.S                     |    2 +-
 arch/powerpc/kernel/head_64.S                      |   98 ++
 arch/powerpc/kernel/head_8xx.S                     |  108 +-
 arch/powerpc/kernel/head_fsl_booke.S               |   74 --
 arch/powerpc/kernel/idle_power7.S                  |    2 +-
 arch/powerpc/kernel/kgdb.c                         |    4 +
 arch/powerpc/kernel/mce_power.c                    |   17 +-
 arch/powerpc/kernel/misc_32.S                      |  107 +-
 arch/powerpc/kernel/module.c                       |    5 +
 arch/powerpc/kernel/module_32.c                    |   20 +-
 arch/powerpc/kernel/module_64.c                    |  214 ++--
 arch/powerpc/kernel/paca.c                         |   11 +-
 arch/powerpc/kernel/pci-hotplug.c                  |    2 +-
 arch/powerpc/kernel/pci_dn.c                       |   19 +-
 arch/powerpc/kernel/ppc_ksyms.c                    |    6 +-
 arch/powerpc/kernel/ppc_ksyms_32.c                 |    1 -
 arch/powerpc/kernel/process.c                      |  168 ++-
 arch/powerpc/kernel/signal.c                       |    4 +-
 arch/powerpc/kernel/signal.h                       |    2 +-
 arch/powerpc/kernel/smp.c                          |    7 +-
 arch/powerpc/kernel/traps.c                        |   12 +-
 arch/powerpc/kernel/vector.S                       |   45 +-
 arch/powerpc/kvm/book3s_32_mmu_host.c              |    2 +-
 arch/powerpc/kvm/book3s_64_mmu.c                   |    2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c              |    2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |    2 +-
 arch/powerpc/kvm/book3s_64_vio.c                   |    2 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c                |    2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |    2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |    2 +-
 arch/powerpc/kvm/book3s_xics.c                     |    2 +-
 arch/powerpc/kvm/booke.c                           |    2 +-
 arch/powerpc/kvm/e500mc.c                          |    2 +-
 arch/powerpc/lib/Makefile                          |    7 +-
 arch/powerpc/lib/checksum_32.S                     |  398 ++++---
 arch/powerpc/lib/checksum_64.S                     |   31 +-
 ...{checksum_wrappers_64.c =3D> checksum_wrappers.c} |    0
 arch/powerpc/lib/ppc_ksyms.c                       |    4 +-
 arch/powerpc/mm/8xx_mmu.c                          |  141 +++
 arch/powerpc/mm/Makefile                           |    1 +
 arch/powerpc/mm/dma-noncoherent.c                  |    2 +-
 arch/powerpc/mm/fsl_booke_mmu.c                    |    6 +-
 arch/powerpc/mm/hash64_4k.c                        |    4 +-
 arch/powerpc/mm/hash64_64k.c                       |    7 +-
 arch/powerpc/mm/hash_utils_64.c                    |   87 +-
 arch/powerpc/mm/hugetlbpage-hash64.c               |    5 +-
 arch/powerpc/mm/hugetlbpage.c                      |    3 +-
 arch/powerpc/mm/init_32.c                          |   23 -
 arch/powerpc/mm/init_64.c                          |   68 +-
 arch/powerpc/mm/mem.c                              |   10 +-
 arch/powerpc/mm/mmu_decl.h                         |   29 +-
 arch/powerpc/mm/pgtable_32.c                       |   52 +-
 arch/powerpc/mm/pgtable_64.c                       |   11 +-
 arch/powerpc/mm/ppc_mmu_32.c                       |    4 +-
 arch/powerpc/mm/tlb_low_64e.S                      |    2 +-
 arch/powerpc/mm/tlb_nohash.c                       |    4 +-
 arch/powerpc/mm/tlb_nohash_low.S                   |    4 +-
 arch/powerpc/oprofile/op_model_cell.c              |    4 +-
 arch/powerpc/perf/core-book3s.c                    |    2 +-
 arch/powerpc/perf/hv-24x7.c                        |  225 ++--
 arch/powerpc/perf/hv-24x7.h                        |    3 +-
 arch/powerpc/perf/hv-gpci.c                        |   43 +-
 arch/powerpc/perf/power7-pmu.c                     |   18 +-
 arch/powerpc/perf/power8-events-list.h             |   51 +
 arch/powerpc/perf/power8-pmu.c                     |  112 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c          |    2 +-
 arch/powerpc/platforms/85xx/Kconfig                |    1 +
 arch/powerpc/platforms/85xx/Makefile               |    1 +
 arch/powerpc/platforms/85xx/common.c               |    3 +
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c       |  106 ++
 arch/powerpc/platforms/85xx/smp.c                  |  312 +++---
 arch/powerpc/platforms/85xx/smp.h                  |    1 +
 arch/powerpc/platforms/86xx/Makefile               |    2 +-
 arch/powerpc/platforms/86xx/common.c               |   43 +
 arch/powerpc/platforms/86xx/gef_ppc9a.c            |   32 +-
 arch/powerpc/platforms/86xx/gef_sbc310.c           |   32 +-
 arch/powerpc/platforms/86xx/gef_sbc610.c           |   32 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |   20 +-
 arch/powerpc/platforms/86xx/mpc86xx.h              |    2 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |   21 +-
 arch/powerpc/platforms/86xx/sbc8641d.c             |   32 +-
 arch/powerpc/platforms/embedded6xx/mpc10x.h        |   10 -
 arch/powerpc/platforms/powermac/Makefile           |    2 +-
 arch/powerpc/platforms/powermac/cache.S            |    2 +-
 arch/powerpc/platforms/powermac/feature.c          |    6 +-
 arch/powerpc/platforms/powernv/Makefile            |    2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |  298 ++++-
 arch/powerpc/platforms/powernv/idle.c              |    6 +-
 arch/powerpc/platforms/powernv/npu-dma.c           |    2 +-
 arch/powerpc/platforms/powernv/opal-msglog.c       |   34 +-
 arch/powerpc/platforms/powernv/opal.c              |    7 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  347 +++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c        |  271 -----
 arch/powerpc/platforms/powernv/pci.c               |   17 +-
 arch/powerpc/platforms/powernv/pci.h               |  152 ++-
 arch/powerpc/platforms/powernv/subcore.c           |    2 +-
 arch/powerpc/platforms/ps3/gelic_udbg.c            |   72 +-
 arch/powerpc/platforms/ps3/interrupt.c             |    2 +-
 arch/powerpc/platforms/pseries/hvconsole.c         |    2 +-
 arch/powerpc/platforms/pseries/lpar.c              |    9 +-
 arch/powerpc/platforms/pseries/setup.c             |    2 +-
 arch/powerpc/scripts/gcc-check-mprofile-kernel.sh  |   23 +
 arch/powerpc/sysdev/Kconfig                        |    5 +
 arch/powerpc/sysdev/Makefile                       |    1 +
 arch/powerpc/sysdev/cpm1.c                         |    5 +-
 arch/powerpc/sysdev/fsl_lbc.c                      |   49 +-
 arch/powerpc/sysdev/fsl_pci.c                      |    2 +-
 arch/powerpc/sysdev/fsl_rcpm.c                     |  386 +++++++
 arch/powerpc/sysdev/fsl_rmu.c                      |    2 +-
 arch/powerpc/sysdev/i8259.c                        |    2 +-
 arch/powerpc/sysdev/mpic.c                         |    4 +-
 arch/powerpc/xmon/xmon.c                           |  120 +-
 drivers/misc/cxl/Makefile                          |    1 +
 drivers/misc/cxl/api.c                             |   83 +-
 drivers/misc/cxl/base.c                            |   32 +
 drivers/misc/cxl/context.c                         |   11 +-
 drivers/misc/cxl/cxl.h                             |  288 +++--
 drivers/misc/cxl/debugfs.c                         |    4 +
 drivers/misc/cxl/fault.c                           |   25 +-
 drivers/misc/cxl/file.c                            |   28 +-
 drivers/misc/cxl/flash.c                           |  538 +++++++++
 drivers/misc/cxl/guest.c                           | 1177 ++++++++++++++++=
++++
 drivers/misc/cxl/hcalls.c                          |  647 +++++++++++
 drivers/misc/cxl/hcalls.h                          |  204 ++++
 drivers/misc/cxl/irq.c                             |  309 ++---
 drivers/misc/cxl/main.c                            |  122 +-
 drivers/misc/cxl/native.c                          |  469 ++++++--
 drivers/misc/cxl/of.c                              |  513 +++++++++
 drivers/misc/cxl/pci.c                             |  267 ++---
 drivers/misc/cxl/sysfs.c                           |  123 +-
 drivers/misc/cxl/trace.h                           |  193 ++++
 drivers/misc/cxl/vphb.c                            |  167 ++-
 drivers/pci/bus.c                                  |    3 +
 drivers/pci/iov.c                                  |   10 +-
 drivers/scsi/cxlflash/common.h                     |    1 -
 drivers/scsi/cxlflash/main.c                       |   18 +-
 drivers/soc/fsl/qe/qe_common.c                     |   66 +-
 drivers/soc/fsl/qe/qe_ic.c                         |   11 +-
 include/linux/atomic.h                             |   10 +
 include/linux/bug.h                                |    9 +
 include/linux/fsl/guts.h                           |  105 ++
 include/linux/huge_mm.h                            |    3 -
 include/linux/pci.h                                |    9 +
 include/misc/cxl.h                                 |    8 +-
 include/soc/fsl/qe/qe.h                            |    2 -
 include/uapi/misc/cxl.h                            |   24 +
 mm/huge_memory.c                                   |   17 +-
 tools/testing/selftests/powerpc/Makefile           |    5 +-
 tools/testing/selftests/powerpc/basic_asm.h        |   70 ++
 tools/testing/selftests/powerpc/math/.gitignore    |    6 +
 tools/testing/selftests/powerpc/math/Makefile      |   19 +
 tools/testing/selftests/powerpc/math/fpu_asm.S     |  198 ++++
 tools/testing/selftests/powerpc/math/fpu_preempt.c |  113 ++
 tools/testing/selftests/powerpc/math/fpu_signal.c  |  135 +++
 tools/testing/selftests/powerpc/math/fpu_syscall.c |   90 ++
 tools/testing/selftests/powerpc/math/vmx_asm.S     |  235 ++++
 tools/testing/selftests/powerpc/math/vmx_preempt.c |  112 ++
 tools/testing/selftests/powerpc/math/vmx_signal.c  |  156 +++
 tools/testing/selftests/powerpc/math/vmx_syscall.c |   91 ++
 .../selftests/powerpc/tm/tm-signal-msr-resv.c      |    2 +-
 324 files changed, 14760 insertions(+), 7155 deletions(-)

--=-oGM34Ph8IdpV2ZMnPKP5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJW6++CAAoJEFHr6jzI4aWAf4YQAJr8dhCeKsJ2mDR9BLRj2URf
egJ7M9dxQ+lkmE30gIzUgGC8wp7jg5mvrMYCE4ONAEhhewieHLOZaUruPLU095Mc
nfm6iCzy12bKEwl+kmLFlTFDQ/xartqLYidry2wzM3/V7bdtjMlUPWXqUwMK2wJM
H2iwGsGOrcBVprg4FSdV2W5OzCVs/KOnyyAw30OcXhIY6SLmYQFiSAqBU3CvRiGa
c/FUz4uKjU+9lJaMlugzdwq0UfhX+GWarjTBLYJ/EFVJGsyouSma/Sq/EFV6st6X
NzZZoDg2b1rhZJ0fDiZ0l9hIP0A2b3vCQluLrHbrzWtTuarVGb4o3wu2q1Yw4Szs
pomJtyX9aEgGDKThCH06qNPbmt298qQixLEfOtKDxCRjEsgx8cFpBYlb8ztkIYGr
VhJ5tEGqBVn8p0aic3VCUpO5oJYUrq1d1A9h00iNGI5h8GEV/DeT3/vwhaFpeNLo
1EbFVR8KpEfX7ZmYS/2PsMEsHOHioFMlcyd85JIxamMI7GMkq2/RwQ/BTgarhUn5
kTJUvXKoza6VcPPoXIY+WyotkazqhawHv2hPiA0FFuorhByYrENyNrY/vMVoAuJ8
n+kvivQQWGB4/nriWOxivaz08NBqf2kf5DJFZCl+RkyJWhmNZCjNScjL8JsPFFn1
Wl0dMujN90z1ukTZaAmW
=a6NA
-----END PGP SIGNATURE-----

--=-oGM34Ph8IdpV2ZMnPKP5--
