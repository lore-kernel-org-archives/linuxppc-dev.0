Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 560D81A0BC6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 17:59:20 +1000 (AEST)
Message-ID: <1429171159.3464.5.camel@ellerman.id.au>
Subject: [git pull] Please pull mpe/linux.git powerpc-4.1-1 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Apr 2015 17:59:19 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-L2hP6OocIcvNk/orhORB"
Mime-Version: 1.0
Cc: weiyang@linux.vnet.ibm.com, geert+renesas@glider.be, aik@ozlabs.ru,
 yguerrini@tomshardware.fr, Emilian.Medve@freescale.com,
 Shengzhou.Liu@freescale.com, bhelgaas@google.com, olson@cumulusnetworks.com,
 gkurz@linux.vnet.ibm.com, sshah@solarflare.com, hbathini@linux.vnet.ibm.com,
 afleming@gmail.com, elfring@users.sourceforge.net, pc+lkml@asdf.org,
 hegdevasant@linux.vnet.ibm.com, rickard_strandqvist@spectrumdigital.se,
 tomi.valkeinen@ti.com, scottwood@freescale.com, Igal.Liberman@freescale.com,
 clg@fr.ibm.com, Kyle.D.Moffett@boeing.com, mahesh@linux.vnet.ibm.com,
 neelegup@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 tyreld@linux.vnet.ibm.com, david@gibson.dropbear.id.au, cyrilbur@gmail.com,
 linux@roeck-us.net, mmarek@suse.cz, rric@kernel.org, alexinbeijing@gmail.com,
 sfr@canb.auug.org.au, hongtao.jia@freescale.com, gwshan@linux.vnet.ibm.com,
 fabf@skynet.be, Julia.Lawall@lip6.fr, anton@samba.org,
 stewart@linux.vnet.ibm.com, felix@linux.vnet.ibm.com,
 yanjiang.jin@windriver.com, dja@axtens.net, sukadev@linux.vnet.ibm.com,
 haokexin@gmail.com, preeti@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 geoff@infradead.org, nacc@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 Kanetkar.Shruti@gmail.com, tj@kernel.org, asolokha@kb.kras.ru, jk@ozlabs.org,
 madalin.bucur@freescale.com, joe@perches.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, jstancek@redhat.com, sam.bobroff@au1.ibm.com,
 bogdan.purcareata@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-L2hP6OocIcvNk/orhORB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc updates for 4.1:

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda=
:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git tags/powerpc-=
4.1-1

for you to fetch changes up to 2fe0753d49402aee325cc39c476b46fd51a8afec:

  powerpc/powermac: Fix build error seen with powermac smp builds (2015-04-=
15 15:52:59 +1000)


There are a couple of conflicts in this merge, nothing major, but FYI:

Anton's hard lockup detector commit c54b2bf1b5e9 "powerpc: Add ppc64 hard
lockup detector support", added a use of watchdog_enable_hardlockup_detecto=
r(),
which has been removed in 692297d8f968 "watchdog: introduce the
hardlockup_detector_disable() function". The obvious fix is to instead use
hardlockup_detector_disable().

The first conflict in tools/testing/selftests/powerpc/Makefile is caused by
commits 6faeeea44b84 "selftests: Add install support for the powerpc tests"=
 and
84f887bfb930 "selftests: Set CC using CROSS_COMPILE once in lib.mk" from th=
e
selftests tree, colliding with a908f5de3b10 "selftests/powerpc: Rename TARG=
ETS
in powerpc selftests makefile" and 4cd968ef4249 "selftests/powerpc: Add a t=
est
of the switch_endian() syscall" which came via my tree.

The second is in tools/testing/selftests/powerpc/tm/Makefile, caused by
6faeeea44b84 "selftests: Add install support for the powerpc tests" and
7fe924d9d71c "selftests/powerpc: Add transactional syscall test".

Just in case I've done the merge and left the result in a branch at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git merge

----------------------------------------------------------------
powerpc updates for 4.1

- Numerous minor fixes, cleanups etc.
- More EEH work from Gavin to remove its dependency on device_nodes.
- Memory hotplug implemented entirely in the kernel from Nathan Fontenot.
- Removal of redundant CONFIG_PPC_OF by Kevin Hao (most of the noise in dri=
vers/)
- Rewrite of VPHN parsing logic & tests from Greg Kurz.
- A fix from Nish Aravamudan to reduce memory usage by clamping
  nodes_possible_map.
- Support for pstore on powernv from Hari Bathini.
- Removal of old powerpc specific byte swap routines by David Gibson.
- Fix from Vasant Hegde to prevent the flash driver telling you it was flas=
hing
  your firmware when it wasn't.
- Patch from Ben Herrenschmidt to add an OPAL heartbeat driver.
- Fix for an oops causing get/put_cpu_var() imbalance in perf by Jan Stance=
k.
- Some fixes for migration from Tyrel Datwyler.
- A new syscall to switch the cpu endian by Michael Ellerman.
- Large series from Wei Yang to implement SRIOV, reviewed and acked by Bjor=
n.
- A fix for the OPAL sensor driver from C=C3=A9dric Le Goater.
- Fixes to get STRICT_MM_TYPECHECKS building again by Michael Ellerman.
- Large series from Daniel Axtens to make our PCI hooks per PHB rather than=
 per
  machine.
- Small patch from Sam Bobroff to explicitly abort non-suspended transactio=
ns
  on syscalls, plus a test to exercise it.
- Numerous reworks and fixes for the 24x7 PMU from Sukadev Bhattiprolu.
- Small patch to enable the hard lockup detector from Anton Blanchard.
- Fix from Dave Olson for missing L2 cache information on some CPUs.
- Some fixes from Michael Ellerman to get Cell machines booting again.
- Freescale updates from Scott: Highlights include BMan device tree nodes, =
an
  MSI erratum workaround, a couple minor performance improvements, config
  updates, and misc fixes/cleanup.

----------------------------------------------------------------
Alex Dowad (1):
      powerpc/kernel: Rename copy_thread() 'arg' argument to 'kthread_arg'

Alexey Kardashevskiy (1):
      powerpc/pseries: Fix compile of memory hotplug without CONFIG_MEMORY_=
HOTREMOVE

Andy Fleming (1):
      powerpc/corenet: Enable muxing MDIO buses via GPIO

Anton Blanchard (5):
      powerpc: Change vrX register defines to vX to match gcc and glibc
      powerpc: Change vsrX register defines to vsX to match gcc and glibc
      oprofile: Disable oprofile NMI timer on ppc64
      powerpc: Add ppc64 hard lockup detector support
      powerpc/perf: Cap 64bit userspace backtraces to PERF_MAX_STACK_DEPTH

Arseny Solokha (3):
      powerpc/boot: drop planetcore_set_serial_speed
      powerpc/qe: drop unused ucc_slow_poll_transmitter_now
      powerpc/mpic: remove unused functions

Benjamin Herrenschmidt (5):
      powerpc: Make corenet64_defconfig a bit more useful
      net/ethernet/sfc: Don't use of_node_to_eeh_dev()
      media/bt8xx: Remove old powerpc cruft
      powerpc/powernv: Support OPAL requested heartbeat
      Merge branch 'next-eeh' into next-sriov

Bjorn Helgaas (2):
      PCI: Print more info in sriov_enable() error message
      PCI: Index IOV resources in the conventional style

Bogdan Purcareata (1):
      powerpc/mpic: Remove WHOAMI readback after EOI

Cyril Bur (1):
      powerpc/powernv: Add interfaces for flash device access

C=C3=A9dric Le Goater (2):
      powerpc/powernv: convert codes returned by OPAL calls
      powerpc/powernv: handle OPAL_SUCCESS return in opal_sensor_read

Daniel Axtens (20):
      powerpc: move find_and_init_phbs() to pSeries specific code
      powerpc/powermac: move pmac_pci_probe_mode from setup.c to pci.c
      powerpc: pcibios_enable_device_hook: return bool rather than int
      powerpc: Create pci_controller_ops.dma_dev_setup and shim
      powerpc: Create pci_controller_ops.dma_bus_setup and shim
      powerpc: Create pci_controller_ops.probe_mode and shim
      powerpc: Create pci_controller_ops.enable_device_hook and shim
      powerpc: Create pci_controller_ops.window_alignment and shim
      powerpc: Create pci_controller_ops.reset_secondary_bus and shim
      powerpc: dart_iommu: optionally populate controller_ops on init
      powerpc/powermac: Move controller ops from ppc_md to controller_ops
      powerpc/pseries: Move controller ops from ppc_md to controller_ops
      powerpc/powernv: Move controller ops from ppc_md to controller_ops
      powerpc/pasemi: Move controller ops from ppc_md to controller_ops
      powerpc/maple: Move controller ops from ppc_md to controller_ops
      powerpc: fsl_pci, swiotlb: Move controller ops from ppc_md to control=
ler_ops
      powerpc/cell: Move controller ops from ppc_md to controller_ops
      powerpc: Remove shims for pci_controller_ops operations
      powerpc: dart_iommu: Remove check for controller_ops =3D=3D NULL case
      powerpc: Remove PPC32 code from pseries specific find_and_init_phbs()

Dave Olson (1):
      powerpc: Fix missing L2 cache size in /sys/devices/system/cpu

David Gibson (4):
      powerpc: Move Power Macintosh drivers to generic byteswappers
      powerpc: Remove arch specific byteswappers from the MXC MMC driver
      powerpc: Cleanup KVM emulated load/store endian handling
      powerpc: Remove unused st_le*() and ld_le* functions

Emil Medve (1):
      powerpc/dts: Remove B4860 emulator support

Fabian Frederick (2):
      powerpc: use kbuild generic-y where possible
      powerpc/pmac: replace current->state by set_current_state()

Gavin Shan (22):
      powerpc/eeh: Enhance pcibios_set_pcie_reset_state()
      powerpc/pci: Fix comments about ppc_md.pcibios_fixup
      powerpc/powernv: Shorten EEH function names
      powerpc/powernv: Drop PHB operation err_inject()
      powerpc/powernv: Drop PHB operation post_init()
      powerpc/powernv: Drop PHB operation get_log()
      powerpc/powernv: Drop PHB operation configure_bridge()
      powerpc/powernv: Drop PHB operation set_option()
      powerpc/powernv: Drop PHB operation get_state()
      powerpc/powernv: Drop PHB operation next_error()
      powerpc/powernv: Drop PHB operation reset()
      powerpc/powernv: Remove unused file
      powerpc/pci: Refactor pci_dn
      powerpc/powernv: Use pci_dn, not device_node, in PCI config accessor
      powerpc/pci: Trace more information from pci_dn
      powerpc/eeh: Create eeh_dev from pci_dn instead of device_node
      powerpc/eeh: Do probe on pci_dn
      powerpc/eeh: Replace device_node with pci_dn in eeh_ops
      powerpc/eeh: Remove device_node dependency
      powerpc/pci: Create pci_dn for VFs
      powerpc/eeh: Fix PE#0 check in eeh_add_to_parent_pe()
      powerpc/powernv: Don't map M64 segments using M32DT

Geert Uytterhoeven (3):
      powerpc: Spelling s/embeeded/embedded/
      powerpc/pmac: Fix DT refcount imbalance in pmac_pic_probe_oldstyle
      cpufreq/ppc: Add missing #include <asm/smp.h>

Greg Kurz (5):
      powerpc/vphn: clarify the H_HOME_NODE_ASSOCIATIVITY API
      powerpc/vphn: move endianness fixing to vphn_unpack_associativity()
      powerpc/vphn: move VPHN parsing logic to a separate file
      powerpc/vphn: parsing code rewrite
      selftests/powerpc: Add test for VPHN

Guenter Roeck (1):
      powerpc/powermac: Fix build error seen with powermac smp builds

Hari Bathini (4):
      powerpc/nvram: Move generic code for nvram and pstore
      pstore: Add pstore type id for PPC64 opal nvram partition
      powerpc/powernv: Add pstore support on powernv
      powerpc/rtas: Make timestamp related code y2038-safe

Hongtao Jia (4):
      powerpc/mpic: Add get_version API both for internal and external use
      powerpc/85xx: workaround for chips with MSI hardware errata
      powerpc: Enable thermal monitor feature in defconfig for supported pl=
atforms
      powerpc: Enable power monitor feature in defconfig for supported plat=
forms

Igal Liberman (1):
      powerpc/mpc85xx: Add FMan platform support

Jan Stancek (1):
      powerpc/perf: add missing put_cpu_var in power_pmu_event_init

Jeremy Kerr (5):
      powerpc/boot/fdt: Use unsigned long for pointer casts
      powerpc/boot/fdt: Add little-endian support to libfdt wrappers
      powerpc/boot/wrapper: use the pseries wrapper for zImage.epapr
      powerpc/boot: Fix stack corruption in epapr entry point
      powerpc/boot: don't clobber r6 and r7 in epapr boot

Joe Perches (1):
      powerpc: Use bool function return values of true/false not 1/0

Julia Lawall (1):
      powerpc: don't export static symbol

Kevin Hao (10):
      sata_svw: remove the dependency on PPC_OF
      fbdev: aty128fb: replace PPC_OF with PPC
      fbdev: radeon: replace PPC_OF with PPC
      fbdev: imsttfb: remove the dependency on PPC_OF
      fbdev: nvidia: remove the dependency on PPC_OF
      fbdev: riva: remove the dependency on PPC_OF
      fbdev: remove the unnecessary includes of ppc specific header files
      fbdev: kconfig: replace PPC_OF with PPC
      powerpc: kill PPC_OF
      powerpc: book3e_64: fix the align size for paca_struct

Kumar Gala (1):
      powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support to device tree(s)

Kyle Moffett (1):
      powerpc: Remove duplicate cacheable_memcpy/memzero functions

LEROY Christophe (1):
      powerpc32/chrp: fix section mismatch warning

Li Zhong (1):
      powerpc/perf/hv-24x7: Fail 24x7 initcall if create_events_from_catalo=
g() fails

Madalin Bucur (1):
      powerpc/fsl-booke: Add T4080 SVR value

Mahesh Salgaonkar (1):
      powerpc/book3s: Fix flush_tlb cpu_spec hook to take a generic argumen=
t.

Markus Elfring (2):
      powerpc: Delete unnecessary checks before kfree()
      drivers/macintosh: Delete an unnecessary check before the function ca=
ll "of_node_put"

Michael Ellerman (25):
      powerpc/powernv: Move OPAL API definitions to opal-api.h
      powerpc/powernv: Move opal-api.h closer to the Skiboot version
      powerpc/powernv: Remove unused definitions in opal-api.h
      selftests/powerpc: Build the copyloops with -maltivec
      selftests/powerpc: Rename TARGETS in powerpc selftests makefile
      Merge branch 'next-misc' of git://git.kernel.org/.../benh/powerpc int=
o test
      powerpc: Add a proper syscall for switching endianness
      selftests/powerpc: Add a test of the switch_endian() syscall
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into =
next
      Merge branch 'next-eeh' of git://git.kernel.org/.../benh/powerpc into=
 next
      Merge branch 'next-remove-ldst' of git://git.kernel.org/.../benh/powe=
rpc into next
      powerpc/powernv: Remove powernv RTAS support
      powerpc: Remove the celleb support
      powerpc/mm: Remove duplicate declaration of setbat()
      powerpc/mm: Change setbat() to take a pgprot_t rather than flags
      powerpc: Fix compile errors with STRICT_MM_TYPECHECKS enabled
      powerpc: Replace mem_init_done with slab_is_available()
      powerpc: Reword the "returning from prom_init" message
      powerpc/cell: Fix crash in iic_setup_cpu() after per_cpu changes
      powerpc/cell: Fix cell iommu after it_page_shift changes
      powerpc: Drop return value of smp_ops->probe()
      Merge branch 'next-dlpar' of git://git.kernel.org/.../benh/powerpc in=
to next
      Merge branch 'next-sriov' of git://git.kernel.org/.../benh/powerpc in=
to next
      powerpc/eeh: Fix crash in eeh_add_device_early() on Cell
      powerpc/cell: Fix iommu breakage caused by controller_ops change

Michal Marek (1):
      powerpc/boot: Makefile cleanup

Nathan Fontenot (6):
      powerpc/pseries: Define rtas hotplug event sections
      powerpc/pseries: Declare the acquire/release drc index routines
      powerpc/pseries: Create new device hotplug entry point
      powerpc/pseries: Implement memory hotplug add in the kernel
      powerpc/pseries: Implement memory hotplug remove in the kernel
      powerpc/pseries: Correct memory hotplug locking

Neelesh Gupta (2):
      powerpc/powernv: Fix the overflow of OPAL message notifiers head arra=
y
      powerpc/powernv: Add OPAL message notifier unregister function

Nishanth Aravamudan (1):
      powerpc/numa: Reset node_possible_map to only node_online_map

Paul Mackerras (1):
      powerpc/powernv: Fix return value from power7_nap() et al.

Phil Carmody (2):
      powerpc/via-pmu: fix error path in find_via_pmu()
      powerpc/via-pmu: fix OF node leak in Keylargo init

Philippe Bergheaud (1):
      cxl: Fix a typo in ABI documentation

Preeti U Murthy (1):
      powerpc/powernv: Avoid explicit endian conversions while parsing devi=
ce tree

Rickard Strandqvist (1):
      powerpc/powermac: Cleaning up missing null-terminate in conjunction w=
ith strncpy

Sam bobroff (4):
      powerpc/tm: Abort syscalls in active transactions
      selftests/powerpc: Move get_auxv_entry() to harness.c
      selftests/powerpc: Add transactional syscall test
      powerpc/tm: Correct minor documentation typos

Scott Wood (1):
      powerpc/32: %pF is only for function pointers

Shengzhou Liu (2):
      powerpc/t2080qds: fix rtc interrupt
      powerpc/corenet: enable CONFIG_I2C_MUX and CONFIG_I2C_MUX_PCA954x

Shruti Kanetkar (1):
      powerpc/corenet: Enable muxing MDIO buses via FPGA

Stephen Rothwell (1):
      powerpc: Convert relocs_check to a shell script using grep

Stewart Smith (3):
      powerpc/powernv: only register log if OPAL supports doing so
      powerpc/powernv: only call OPAL_ELOG_RESEND if firmware supports it
      powerpc/powernv: only call OPAL_RESEND_DUMP if firmware supports it

Sukadev Bhattiprolu (11):
      powerpc/perf/hv-24x7: Modify definition of request and result buffers
      powerpc/perf/hv-24x7: Remove unnecessary parameter
      powerpc/perf/hv-24x7: Use pr_devel() to log message
      powerpc/perf/hv-24x7: Drop event_24x7_request()
      powerpc/perf/hv-24x7: Move debug prints to separate function
      powerpc/perf/hv-24x7: Rename hv_24x7_event_update
      powerpc/perf/hv-24x7: Define add_event_to_24x7_request()
      powerpc/perf/hv-24x7: Whitespace cleanup
      powerpc/perf/hv-24x7: Define update_event_count()
      powerpc/perf/hv-24x7: Break up single_24x7_request
      powerpc/perf/hv-24x7: Add missing put_cpu_var()

Tyrel Datwyler (2):
      powerpc/pseries: Introduce api_version to migration sysfs interface
      powerpc/pseries: Simplify check for suspendability during suspend/mig=
ration

Vasant Hegde (1):
      powerpc/powernv: Check image loaded or not before calling flash

Wei Yang (17):
      PCI: Print PF SR-IOV resource that contains all VF(n) BAR space
      PCI: Keep individual VF BAR size in struct pci_sriov
      PCI: Refresh First VF Offset and VF Stride when updating NumVFs
      PCI: Calculate maximum number of buses required for VFs
      PCI: Export pci_iov_virtfn_bus() and pci_iov_virtfn_devfn()
      PCI: Add pcibios_sriov_enable() and pcibios_sriov_disable()
      PCI: Add pcibios_iov_resource_alignment() interface
      PCI: Consider additional PF's IOV BAR alignment in sizing and assigni=
ng
      powerpc/pci: Don't unset PCI resources for VFs
      powerpc/powernv: Allocate struct pnv_ioda_pe iommu_table dynamically
      powerpc/powernv: Reserve additional space for IOV BAR according to th=
e number of total_pe
      powerpc/powernv: Implement pcibios_iov_resource_alignment() on powern=
v
      powerpc/powernv: Shift VF resource with an offset
      powerpc/powernv: Reserve additional space for IOV BAR, with m64_per_i=
ov supported
      powerpc/powernv: Group VF PE when IOV BAR is big on PHB3
      powerpc/pci: Remove unused struct pci_dn.pcidev field
      powerpc/pci: Add PCI resource alignment documentation

Yanjiang Jin (2):
      powerpc/mm: Free string after creating kmem cache
      powerpc/mpc85xx: call k(un)map_atomic rather than k(un)map

Yannick Guerrini (1):
      ps3: Fix trivial typos in comment and debug message

 Documentation/ABI/testing/sysfs-class-cxl          |    2 +-
 .../powerpc/pci_iov_resource_on_powernv.txt        |  301 +++++
 Documentation/powerpc/transactional_memory.txt     |   36 +-
 arch/Kconfig                                       |    2 +-
 arch/powerpc/Kconfig                               |    4 +-
 arch/powerpc/Kconfig.debug                         |    9 +-
 arch/powerpc/Makefile                              |    4 +-
 arch/powerpc/boot/Makefile                         |    4 +-
 arch/powerpc/boot/crt0.S                           |   26 +-
 arch/powerpc/boot/dts/b4860emu.dts                 |  223 ----
 arch/powerpc/boot/dts/b4qds.dtsi                   |   17 +-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |   60 +-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |   89 +-
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi        |   37 +-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   11 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   11 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   11 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |   11 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   11 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   65 +-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |  105 +-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  265 +++-
 arch/powerpc/boot/dts/kmcoge4.dts                  |   15 +
 arch/powerpc/boot/dts/oca4080.dts                  |   15 +
 arch/powerpc/boot/dts/p1023rdb.dts                 |   18 +-
 arch/powerpc/boot/dts/p2041rdb.dts                 |   17 +-
 arch/powerpc/boot/dts/p3041ds.dts                  |   17 +-
 arch/powerpc/boot/dts/p4080ds.dts                  |   17 +-
 arch/powerpc/boot/dts/p5020ds.dts                  |   17 +-
 arch/powerpc/boot/dts/p5040ds.dts                  |   17 +-
 arch/powerpc/boot/dts/t104xqds.dtsi                |   17 +-
 arch/powerpc/boot/dts/t104xrdb.dtsi                |   14 +
 arch/powerpc/boot/dts/t208xqds.dtsi                |   19 +-
 arch/powerpc/boot/dts/t208xrdb.dtsi                |   15 +
 arch/powerpc/boot/dts/t4240qds.dts                 |   17 +-
 arch/powerpc/boot/dts/t4240rdb.dts                 |   15 +
 arch/powerpc/boot/libfdt-wrapper.c                 |    6 +-
 arch/powerpc/boot/libfdt_env.h                     |   14 +-
 arch/powerpc/boot/of.h                             |    8 +
 arch/powerpc/boot/planetcore.c                     |   33 -
 arch/powerpc/boot/planetcore.h                     |    3 -
 arch/powerpc/boot/wrapper                          |    2 +-
 arch/powerpc/configs/cell_defconfig                |    3 -
 arch/powerpc/configs/celleb_defconfig              |  152 ---
 arch/powerpc/configs/corenet32_smp_defconfig       |    7 +-
 arch/powerpc/configs/corenet64_smp_defconfig       |   15 +-
 arch/powerpc/configs/mpc85xx_defconfig             |    3 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig         |    2 +-
 arch/powerpc/configs/ppc64_defconfig               |    3 -
 arch/powerpc/include/asm/Kbuild                    |    4 +-
 arch/powerpc/include/asm/cache.h                   |    3 -
 arch/powerpc/include/asm/cputable.h                |    8 +-
 arch/powerpc/include/asm/dbdma.h                   |   12 +-
 arch/powerpc/include/asm/dcr-native.h              |    2 +-
 arch/powerpc/include/asm/device.h                  |    6 +
 arch/powerpc/include/asm/div64.h                   |    1 -
 arch/powerpc/include/asm/dma-mapping.h             |    4 +-
 arch/powerpc/include/asm/eeh.h                     |   29 +-
 arch/powerpc/include/asm/firmware.h                |   10 +-
 arch/powerpc/include/asm/iommu.h                   |    6 +-
 arch/powerpc/include/asm/irq_regs.h                |    2 -
 arch/powerpc/include/asm/kvm_book3s_64.h           |   16 +-
 arch/powerpc/include/asm/kvm_host.h                |    2 +-
 arch/powerpc/include/asm/local64.h                 |    1 -
 arch/powerpc/include/asm/machdep.h                 |   19 +-
 arch/powerpc/include/asm/mmu-hash64.h              |    1 +
 arch/powerpc/include/asm/mpc85xx.h                 |    1 +
 arch/powerpc/include/asm/mpic.h                    |   17 -
 arch/powerpc/include/asm/nmi.h                     |    4 +
 arch/powerpc/include/asm/nvram.h                   |   50 +-
 arch/powerpc/include/asm/opal-api.h                |  735 +++++++++++
 arch/powerpc/include/asm/opal.h                    |  770 +-----------
 arch/powerpc/include/asm/paca.h                    |    4 +-
 arch/powerpc/include/asm/pci-bridge.h              |   60 +-
 arch/powerpc/include/asm/pci.h                     |    2 +-
 arch/powerpc/include/asm/ppc-pci.h                 |    8 +-
 arch/powerpc/include/asm/ppc_asm.h                 |  192 +--
 arch/powerpc/include/asm/rtas.h                    |   33 +-
 arch/powerpc/include/asm/setup.h                   |    1 -
 arch/powerpc/include/asm/smp.h                     |    5 +-
 arch/powerpc/include/asm/swab.h                    |   26 -
 arch/powerpc/include/asm/systbl.h                  |    1 +
 arch/powerpc/include/asm/ucc_slow.h                |   13 -
 arch/powerpc/include/asm/unistd.h                  |    2 +-
 arch/powerpc/include/asm/vga.h                     |    4 +-
 arch/powerpc/include/asm/xics.h                    |    2 +-
 arch/powerpc/include/uapi/asm/ptrace.h             |    2 +-
 arch/powerpc/include/uapi/asm/tm.h                 |    2 +-
 arch/powerpc/include/uapi/asm/unistd.h             |    1 +
 arch/powerpc/kernel/Makefile                       |    4 +-
 arch/powerpc/kernel/cacheinfo.c                    |   44 +-
 arch/powerpc/kernel/cpu_setup_power.S              |   10 +-
 arch/powerpc/kernel/cputable.c                     |    4 +-
 arch/powerpc/kernel/dma-swiotlb.c                  |   11 +-
 arch/powerpc/kernel/eeh.c                          |  176 ++-
 arch/powerpc/kernel/eeh_cache.c                    |   25 +-
 arch/powerpc/kernel/eeh_dev.c                      |   14 +-
 arch/powerpc/kernel/eeh_driver.c                   |   22 -
 arch/powerpc/kernel/eeh_pe.c                       |  129 +-
 arch/powerpc/kernel/entry_64.S                     |   24 +
 arch/powerpc/kernel/idle_power7.S                  |    1 +
 arch/powerpc/kernel/mce_power.c                    |   53 +-
 arch/powerpc/kernel/nvram_64.c                     |  677 ++++++++++
 arch/powerpc/kernel/of_platform.c                  |    2 +-
 arch/powerpc/kernel/pci-common.c                   |   57 +-
 arch/powerpc/kernel/pci-hotplug.c                  |    9 +-
 arch/powerpc/kernel/pci_dn.c                       |  309 ++++-
 arch/powerpc/kernel/pci_of_scan.c                  |    9 +-
 arch/powerpc/kernel/process.c                      |    9 +-
 arch/powerpc/kernel/prom_init.c                    |    4 +-
 arch/powerpc/kernel/rtas.c                         |   30 +-
 arch/powerpc/kernel/rtas_pci.c                     |   49 +-
 arch/powerpc/kernel/setup_64.c                     |   20 +
 arch/powerpc/kernel/syscalls.c                     |   17 +
 arch/powerpc/kernel/systbl.S                       |    2 +
 arch/powerpc/kernel/systbl_chk.c                   |    2 +
 arch/powerpc/kernel/tm.S                           |    8 +-
 arch/powerpc/kernel/udbg.c                         |    2 -
 arch/powerpc/kernel/vector.S                       |   24 +-
 arch/powerpc/kvm/book3s_hv_ras.c                   |    4 +-
 arch/powerpc/kvm/powerpc.c                         |   38 +-
 arch/powerpc/lib/alloc.c                           |    2 +-
 arch/powerpc/lib/copy_32.S                         |  127 --
 arch/powerpc/lib/copypage_power7.S                 |   32 +-
 arch/powerpc/lib/copyuser_power7.S                 |  226 ++--
 arch/powerpc/lib/crtsavres.S                       |   96 +-
 arch/powerpc/lib/ldstfp.S                          |   32 +-
 arch/powerpc/lib/locks.c                           |    1 +
 arch/powerpc/lib/memcpy_power7.S                   |  226 ++--
 arch/powerpc/lib/ppc_ksyms.c                       |    4 -
 arch/powerpc/lib/rheap.c                           |    2 +-
 arch/powerpc/mm/Makefile                           |    1 +
 arch/powerpc/mm/dma-noncoherent.c                  |    2 +-
 arch/powerpc/mm/fsl_booke_mmu.c                    |    2 +-
 arch/powerpc/mm/hugepage-hash64.c                  |    2 +-
 arch/powerpc/mm/hugetlbpage.c                      |    4 +-
 arch/powerpc/mm/init_64.c                          |    1 +
 arch/powerpc/mm/mem.c                              |    3 -
 arch/powerpc/mm/mmu_decl.h                         |    2 +-
 arch/powerpc/mm/numa.c                             |   62 +-
 arch/powerpc/mm/pgtable_32.c                       |   18 +-
 arch/powerpc/mm/pgtable_64.c                       |    6 +-
 arch/powerpc/mm/ppc_mmu_32.c                       |    5 +-
 arch/powerpc/mm/tlb_hash64.c                       |    2 +-
 arch/powerpc/mm/vphn.c                             |   70 ++
 arch/powerpc/mm/vphn.h                             |   16 +
 arch/powerpc/perf/callchain.c                      |    2 +-
 arch/powerpc/perf/core-book3s.c                    |    4 +-
 arch/powerpc/perf/hv-24x7.c                        |  251 ++--
 arch/powerpc/perf/hv-24x7.h                        |    8 +-
 arch/powerpc/platforms/85xx/common.c               |    1 +
 arch/powerpc/platforms/85xx/corenet_generic.c      |   12 +
 arch/powerpc/platforms/85xx/smp.c                  |    4 +-
 arch/powerpc/platforms/Kconfig                     |    5 -
 arch/powerpc/platforms/Kconfig.cputype             |    3 +-
 arch/powerpc/platforms/cell/Kconfig                |   11 -
 arch/powerpc/platforms/cell/Makefile               |   15 -
 arch/powerpc/platforms/cell/beat.c                 |  264 ----
 arch/powerpc/platforms/cell/beat.h                 |   39 -
 arch/powerpc/platforms/cell/beat_htab.c            |  445 -------
 arch/powerpc/platforms/cell/beat_hvCall.S          |  285 -----
 arch/powerpc/platforms/cell/beat_interrupt.c       |  253 ----
 arch/powerpc/platforms/cell/beat_interrupt.h       |   30 -
 arch/powerpc/platforms/cell/beat_iommu.c           |  115 --
 arch/powerpc/platforms/cell/beat_spu_priv1.c       |  205 ---
 arch/powerpc/platforms/cell/beat_syscall.h         |  164 ---
 arch/powerpc/platforms/cell/beat_udbg.c            |   98 --
 arch/powerpc/platforms/cell/beat_wrapper.h         |  290 -----
 arch/powerpc/platforms/cell/cell.h                 |   24 +
 arch/powerpc/platforms/cell/celleb_pci.c           |  500 --------
 arch/powerpc/platforms/cell/celleb_pci.h           |   46 -
 arch/powerpc/platforms/cell/celleb_scc.h           |  232 ----
 arch/powerpc/platforms/cell/celleb_scc_epci.c      |  428 -------
 arch/powerpc/platforms/cell/celleb_scc_pciex.c     |  538 --------
 arch/powerpc/platforms/cell/celleb_scc_sio.c       |   99 --
 arch/powerpc/platforms/cell/celleb_scc_uhc.c       |   95 --
 arch/powerpc/platforms/cell/celleb_setup.c         |  243 ----
 arch/powerpc/platforms/cell/interrupt.c            |    2 +-
 arch/powerpc/platforms/cell/iommu.c                |   11 +-
 arch/powerpc/platforms/cell/setup.c                |    5 +
 arch/powerpc/platforms/cell/smp.c                  |    9 +-
 arch/powerpc/platforms/cell/spu_callbacks.c        |    1 +
 arch/powerpc/platforms/chrp/setup.c                |    2 +-
 arch/powerpc/platforms/maple/maple.h               |    2 +
 arch/powerpc/platforms/maple/pci.c                 |    4 +
 arch/powerpc/platforms/maple/setup.c               |    2 +-
 arch/powerpc/platforms/pasemi/iommu.c              |    6 +-
 arch/powerpc/platforms/pasemi/pasemi.h             |    1 +
 arch/powerpc/platforms/pasemi/pci.c                |    5 +
 arch/powerpc/platforms/powermac/bootx_init.c       |    2 +-
 arch/powerpc/platforms/powermac/pci.c              |   38 +-
 arch/powerpc/platforms/powermac/pic.c              |    3 +
 arch/powerpc/platforms/powermac/pmac.h             |    3 +-
 arch/powerpc/platforms/powermac/setup.c            |   22 +-
 arch/powerpc/platforms/powermac/smp.c              |   18 +-
 arch/powerpc/platforms/powernv/Kconfig             |    7 -
 arch/powerpc/platforms/powernv/Makefile            |    2 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c          | 1149 ----------------=
-
 arch/powerpc/platforms/powernv/eeh-powernv.c       | 1300 ++++++++++++++++=
+---
 arch/powerpc/platforms/powernv/opal-dump.c         |    3 +-
 arch/powerpc/platforms/powernv/opal-elog.c         |    3 +-
 arch/powerpc/platforms/powernv/opal-flash.c        |    8 +-
 arch/powerpc/platforms/powernv/opal-nvram.c        |   10 +
 arch/powerpc/platforms/powernv/opal-sensor.c       |   30 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S     |    5 +-
 arch/powerpc/platforms/powernv/opal.c              |   92 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  797 +++++++++++-
 arch/powerpc/platforms/powernv/pci-p5ioc2.c        |    1 +
 arch/powerpc/platforms/powernv/pci.c               |  190 +--
 arch/powerpc/platforms/powernv/pci.h               |   38 +-
 arch/powerpc/platforms/powernv/powernv.h           |    2 +
 arch/powerpc/platforms/powernv/setup.c             |   54 +-
 arch/powerpc/platforms/powernv/smp.c               |   13 -
 arch/powerpc/platforms/ps3/smp.c                   |    4 +-
 arch/powerpc/platforms/pseries/Kconfig             |    1 -
 arch/powerpc/platforms/pseries/dlpar.c             |  118 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c       |   98 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c    |  489 ++++++++
 arch/powerpc/platforms/pseries/iommu.c             |    9 +-
 arch/powerpc/platforms/pseries/mobility.c          |   26 +-
 arch/powerpc/platforms/pseries/msi.c               |    6 +-
 arch/powerpc/platforms/pseries/nvram.c             |  674 +---------
 arch/powerpc/platforms/pseries/pci_dlpar.c         |    5 +-
 arch/powerpc/platforms/pseries/pseries.h           |   14 +
 arch/powerpc/platforms/pseries/setup.c             |   48 +-
 arch/powerpc/platforms/pseries/smp.c               |    6 +-
 arch/powerpc/relocs_check.pl                       |   66 -
 arch/powerpc/relocs_check.sh                       |   59 +
 arch/powerpc/sysdev/dart_iommu.c                   |   10 +-
 arch/powerpc/sysdev/dcr.c                          |    2 +-
 arch/powerpc/sysdev/fsl_msi.c                      |   29 +-
 arch/powerpc/sysdev/fsl_msi.h                      |    2 +
 arch/powerpc/sysdev/fsl_pci.c                      |   15 +
 arch/powerpc/sysdev/mpic.c                         |   30 +-
 arch/powerpc/sysdev/qe_lib/qe_io.c                 |   25 -
 arch/powerpc/sysdev/qe_lib/ucc_slow.c              |    5 -
 arch/powerpc/sysdev/xics/xics-common.c             |    4 +-
 drivers/ata/pata_macio.c                           |   10 +-
 drivers/ata/sata_svw.c                             |   11 +-
 drivers/block/swim3.c                              |   12 +-
 drivers/ide/pmac.c                                 |   10 +-
 drivers/macintosh/rack-meter.c                     |   30 +-
 drivers/macintosh/smu.c                            |    3 +-
 drivers/macintosh/via-pmu.c                        |   25 +-
 drivers/media/pci/bt8xx/bt878.c                    |   12 -
 drivers/media/pci/bt8xx/bt878.h                    |   11 -
 drivers/mmc/host/mxcmmc.c                          |    2 +-
 drivers/net/ethernet/apple/bmac.c                  |   30 +-
 drivers/net/ethernet/apple/mace.c                  |   44 +-
 drivers/net/ethernet/ibm/emac/core.c               |   12 +-
 drivers/net/ethernet/sfc/efx.c                     |    4 +-
 drivers/net/ethernet/sfc/siena.c                   |    3 +-
 drivers/pci/hotplug/rpadlpar_core.c                |    2 +-
 drivers/pci/iov.c                                  |  155 ++-
 drivers/pci/pci.h                                  |    2 +
 drivers/pci/setup-bus.c                            |   95 +-
 drivers/ps3/ps3-lpm.c                              |    4 +-
 drivers/scsi/mac53c94.c                            |   10 +-
 drivers/scsi/mesh.c                                |   14 +-
 drivers/video/fbdev/Kconfig                        |    4 +-
 drivers/video/fbdev/aty/aty128fb.c                 |    4 +-
 drivers/video/fbdev/aty/radeon_base.c              |   24 +-
 drivers/video/fbdev/aty/radeon_monitor.c           |   20 +-
 drivers/video/fbdev/aty/radeon_pm.c                |   16 +-
 drivers/video/fbdev/aty/radeonfb.h                 |    4 +-
 drivers/video/fbdev/controlfb.c                    |    2 +-
 drivers/video/fbdev/core/fbmon.c                   |    4 -
 drivers/video/fbdev/imsttfb.c                      |    6 +-
 drivers/video/fbdev/nvidia/Makefile                |    3 +-
 drivers/video/fbdev/nvidia/nv_of.c                 |    3 -
 drivers/video/fbdev/nvidia/nv_proto.h              |    8 -
 drivers/video/fbdev/nvidia/nvidia.c                |    4 -
 drivers/video/fbdev/platinumfb.c                   |    2 +-
 drivers/video/fbdev/riva/fbdev.c                   |   17 +-
 fs/pstore/inode.c                                  |    3 +
 include/linux/pci.h                                |   15 +
 include/linux/pstore.h                             |    1 +
 sound/ppc/pmac.c                                   |   58 +-
 tools/testing/selftests/powerpc/Makefile           |   12 +-
 tools/testing/selftests/powerpc/copyloops/Makefile |    1 +
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |   33 -
 tools/testing/selftests/powerpc/harness.c          |   47 +
 tools/testing/selftests/powerpc/pmu/lib.c          |   47 -
 tools/testing/selftests/powerpc/pmu/lib.h          |    1 -
 .../selftests/powerpc/switch_endian/.gitignore     |    2 +
 .../selftests/powerpc/switch_endian/Makefile       |   24 +
 .../selftests/powerpc/switch_endian/check.S        |  100 ++
 .../selftests/powerpc/switch_endian/common.h       |    6 +
 .../powerpc/switch_endian/switch_endian_test.S     |   81 ++
 tools/testing/selftests/powerpc/tm/.gitignore      |    1 +
 tools/testing/selftests/powerpc/tm/Makefile        |    5 +-
 .../testing/selftests/powerpc/tm/tm-syscall-asm.S  |   27 +
 tools/testing/selftests/powerpc/tm/tm-syscall.c    |  121 ++
 tools/testing/selftests/powerpc/utils.h            |    3 +-
 tools/testing/selftests/powerpc/vphn/.gitignore    |    1 +
 tools/testing/selftests/powerpc/vphn/Makefile      |   15 +
 tools/testing/selftests/powerpc/vphn/test-vphn.c   |  410 ++++++
 tools/testing/selftests/powerpc/vphn/vphn.c        |    1 +
 tools/testing/selftests/powerpc/vphn/vphn.h        |    1 +
 299 files changed, 8753 insertions(+), 9758 deletions(-)
 create mode 100644 Documentation/powerpc/pci_iov_resource_on_powernv.txt
 delete mode 100644 arch/powerpc/boot/dts/b4860emu.dts
 delete mode 100644 arch/powerpc/configs/celleb_defconfig
 delete mode 100644 arch/powerpc/include/asm/div64.h
 delete mode 100644 arch/powerpc/include/asm/irq_regs.h
 delete mode 100644 arch/powerpc/include/asm/local64.h
 create mode 100644 arch/powerpc/include/asm/nmi.h
 create mode 100644 arch/powerpc/include/asm/opal-api.h
 create mode 100644 arch/powerpc/mm/vphn.c
 create mode 100644 arch/powerpc/mm/vphn.h
 delete mode 100644 arch/powerpc/platforms/cell/beat.c
 delete mode 100644 arch/powerpc/platforms/cell/beat.h
 delete mode 100644 arch/powerpc/platforms/cell/beat_htab.c
 delete mode 100644 arch/powerpc/platforms/cell/beat_hvCall.S
 delete mode 100644 arch/powerpc/platforms/cell/beat_interrupt.c
 delete mode 100644 arch/powerpc/platforms/cell/beat_interrupt.h
 delete mode 100644 arch/powerpc/platforms/cell/beat_iommu.c
 delete mode 100644 arch/powerpc/platforms/cell/beat_spu_priv1.c
 delete mode 100644 arch/powerpc/platforms/cell/beat_syscall.h
 delete mode 100644 arch/powerpc/platforms/cell/beat_udbg.c
 delete mode 100644 arch/powerpc/platforms/cell/beat_wrapper.h
 create mode 100644 arch/powerpc/platforms/cell/cell.h
 delete mode 100644 arch/powerpc/platforms/cell/celleb_pci.c
 delete mode 100644 arch/powerpc/platforms/cell/celleb_pci.h
 delete mode 100644 arch/powerpc/platforms/cell/celleb_scc.h
 delete mode 100644 arch/powerpc/platforms/cell/celleb_scc_epci.c
 delete mode 100644 arch/powerpc/platforms/cell/celleb_scc_pciex.c
 delete mode 100644 arch/powerpc/platforms/cell/celleb_scc_sio.c
 delete mode 100644 arch/powerpc/platforms/cell/celleb_scc_uhc.c
 delete mode 100644 arch/powerpc/platforms/cell/celleb_setup.c
 delete mode 100644 arch/powerpc/platforms/powernv/eeh-ioda.c
 delete mode 100755 arch/powerpc/relocs_check.pl
 create mode 100755 arch/powerpc/relocs_check.sh
 create mode 100644 tools/testing/selftests/powerpc/switch_endian/.gitignor=
e
 create mode 100644 tools/testing/selftests/powerpc/switch_endian/Makefile
 create mode 100644 tools/testing/selftests/powerpc/switch_endian/check.S
 create mode 100644 tools/testing/selftests/powerpc/switch_endian/common.h
 create mode 100644 tools/testing/selftests/powerpc/switch_endian/switch_en=
dian_test.S
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall.c
 create mode 100644 tools/testing/selftests/powerpc/vphn/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/vphn/Makefile
 create mode 100644 tools/testing/selftests/powerpc/vphn/test-vphn.c
 create mode 120000 tools/testing/selftests/powerpc/vphn/vphn.c
 create mode 120000 tools/testing/selftests/powerpc/vphn/vphn.h



--=-L2hP6OocIcvNk/orhORB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJVL2vXAAoJEFHr6jzI4aWAoVoP/0noR0fMShAn73HiPxvNR32g
VYgJpX+8c1VCuoReTleBx9+LjQOlxV+QNSitUrhqvvgP6Iv7T/BXDBKZf2Srm9Nn
bUqFjZzBvsGkyyx++BNsKAxy+v1uWnNoCdl6lx99D1jFFV9xo5ZyfH8/IHFkXWAb
wLHkbszAW0MOJexQ9t5JI/reJQXR6mwlgP6nNQWAPUmXy5a9AKAp+9bDVlm9Tj3Z
ZTp6RFiBAcS0MYiZeZ7omwRXemZyn3HMr5jVaoz41o5wSmJpUWIEesGT9yPdxvFY
DHVFWyjyWEk+FQG9ui1NECoqfTYMTJs16rtJjkJnO8A9txIYgY90BFRsx7PJIVgz
5xoFHXLDNqCUScdi6E4/EUuGXJg6LaPzrQnbRFlc8ycWABb3uIZKeM1mY+kIsIFX
i6irvTDC+4gna+CTCQF0NltB3xC9aAOfyTCjr/fgBqtumOJ7hORdRP5ZT6np4u0j
T9ZTPZSdnslDqSvy/sMSYxITEuTNR0K/DjENK3TtiAnkKH+LLRQHZu7IW7Ccy8UV
Dh1PUNfOPZSry0dxSvQxX3N6ceL6Jq9v20r5Wq+R3gExFbYRPlM0XdSjBrvMYGg1
aN2xp2obY8kv32kieLFZIqx6A6OxpJFfRJ4Tj7AeiqaOojXSBrpdMqOKaTDQ1GEV
n/ChMigjkVD8M1tpMfTw
=FhZ3
-----END PGP SIGNATURE-----

--=-L2hP6OocIcvNk/orhORB--
