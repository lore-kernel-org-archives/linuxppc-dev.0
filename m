Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18698.58333.886594.707909@cargo.ozlabs.ibm.com>
Date: Fri, 31 Oct 2008 21:54:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please pull from the 'merge' branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a collection of fixes for various regressions, compile failures
and oops-causing bugs on powerpc, plus some defconfig updates (which
form the bulk of the lines changed).

The 3 commits from Milton Miller partially revert some changes we did
since 2.6.27 to the way the kernel is invoked and the way it invokes a
kexec/kdump kernel, and subsequently decided was a bad idea.  I put
them in so that we didn't end up having one kernel release with odd
interface conventions.

I'm sending this pull request rather than Ben because Ben's wife just
had a baby and Ben is otherwise occupied. :)

Thanks,
Paul.

 arch/powerpc/boot/dts/mpc8313erdb.dts            |   39 -------
 arch/powerpc/boot/libfdt/fdt_ro.c                |    9 +-
 arch/powerpc/boot/main.c                         |    2=20
 arch/powerpc/configs/40x/acadia_defconfig        |   59 +++++++---
 arch/powerpc/configs/40x/ep405_defconfig         |   83 ++++++++++----=
-
 arch/powerpc/configs/40x/hcu4_defconfig          |  125 ++++++++++++++=
++------
 arch/powerpc/configs/40x/kilauea_defconfig       |   69 ++++++++----
 arch/powerpc/configs/40x/makalu_defconfig        |   69 ++++++++----
 arch/powerpc/configs/40x/walnut_defconfig        |   77 ++++++++++----=

 arch/powerpc/configs/44x/arches_defconfig        |   51 ++++++---
 arch/powerpc/configs/44x/bamboo_defconfig        |   77 ++++++++++----=

 arch/powerpc/configs/44x/canyonlands_defconfig   |   61 +++++++----
 arch/powerpc/configs/44x/ebony_defconfig         |   77 ++++++++++----=

 arch/powerpc/configs/44x/katmai_defconfig        |   77 ++++++++++----=

 arch/powerpc/configs/44x/rainier_defconfig       |   73 +++++++++----
 arch/powerpc/configs/44x/sam440ep_defconfig      |  110 ++++++++++++++=
-----
 arch/powerpc/configs/44x/sequoia_defconfig       |   78 ++++++++++----=

 arch/powerpc/configs/44x/taishan_defconfig       |   77 ++++++++++----=

 arch/powerpc/configs/44x/warp_defconfig          |   82 ++++++++++----=

 arch/powerpc/configs/linkstation_defconfig       |   11 +-
 arch/powerpc/configs/ppc40x_defconfig            |  106 ++++++++++++++=
+----
 arch/powerpc/configs/ppc44x_defconfig            |  125 ++++++++++++++=
+++-----
 arch/powerpc/include/asm/iommu.h                 |   15 +--
 arch/powerpc/include/asm/kdump.h                 |    8 -
 arch/powerpc/include/asm/mpic.h                  |    2=20
 arch/powerpc/include/asm/pci.h                   |    2=20
 arch/powerpc/kernel/dma-iommu.c                  |   34 +++---
 arch/powerpc/kernel/head_64.S                    |   30 +++--
 arch/powerpc/kernel/ibmebus.c                    |   27 ++---
 arch/powerpc/kernel/iommu.c                      |   25 ++--
 arch/powerpc/kernel/machine_kexec_64.c           |    9 --
 arch/powerpc/kernel/misc_64.S                    |    9 +-
 arch/powerpc/kernel/of_device.c                  |    1=20
 arch/powerpc/kernel/pci-common.c                 |  110 ++++++++++----=
-----
 arch/powerpc/kernel/pci_64.c                     |    2=20
 arch/powerpc/kernel/setup_64.c                   |    6 +
 arch/powerpc/kernel/signal_32.c                  |   36 +++---
 arch/powerpc/kernel/signal_64.c                  |   33 +++---
 arch/powerpc/kernel/vio.c                        |   25 ++--
 arch/powerpc/kernel/vmlinux.lds.S                |    2=20
 arch/powerpc/oprofile/op_model_cell.c            |   13 ++
 arch/powerpc/platforms/40x/Kconfig               |    2=20
 arch/powerpc/platforms/85xx/mpc85xx_ds.c         |    3 -
 arch/powerpc/platforms/86xx/pic.c                |    3 -
 arch/powerpc/platforms/cell/iommu.c              |   37 +++----
 arch/powerpc/platforms/cell/ras.c                |    6 +
 arch/powerpc/platforms/embedded6xx/linkstation.c |   14 ++
 arch/powerpc/platforms/iseries/iommu.c           |    7 +
 arch/powerpc/platforms/ps3/system-bus.c          |   36 +++---
 arch/powerpc/platforms/pseries/iommu.c           |    4 -
 arch/powerpc/platforms/pseries/pci_dlpar.c       |    2=20
 arch/powerpc/sysdev/mpic.c                       |   59 ++++++++++
 arch/powerpc/xmon/xmon.c                         |    2=20
 drivers/of/device.c                              |   11 ++
 54 files changed, 1392 insertions(+), 720 deletions(-)

Benjamin Herrenschmidt (1):
      powerpc/pci: Fix unmapping of IO space on 64-bit

Carl Love (1):
      powerpc/cell/OProfile: Fix on-stack array size in activate spu pr=
ofiling function

David Gibson (1):
      powerpc: Fix bug in kernel copy of libfdt's fdt_subnode_offset_na=
melen()

Guennadi Liakhovetski (1):
      powerpc: fix i2c on PPC linkstation / kurobox machines

Jeremy Kerr (1):
      OF-device: Don't overwrite numa_node in device registration

Jon Smirl (1):
      powerpc: Fix format string warning in arch/powerpc/boot/main.c

Josh Boyer (3):
      powerpc/40x: Don't enable HCU4 board by default
      powerpc/40x: Update 40x defconfigs
      powerpc/44x: Update 44x defconfigs

Kumar Gala (1):
      powerpc/mpic: Fix regression caused by change of default IRQ affi=
nity

Mark Nelson (1):
      powerpc: Update remaining dma_mapping_ops to use map/unmap_page

Michael Neuling (2):
      powerpc: Fix compiler warning for the relocatable kernel
      powerpc: Fix swapcontext system for VSX + old ucontext size

Mike Dyer (1):
      powerpc: Remove duplicate DMA entry from mpc8313erdb device tree

Milton Miller (3):
      powerpc: Kexec exit should not use magic numbers
      powerpc: Use is_kdump_kernel()
      powerpc/ppc64/kdump: Better flag for running relocatable

Nathan Fontenot (1):
      powerpc/pci: Properly allocate bus resources for hotplug PHBs

Paul Mackerras (2):
      powerpc: Work around ld bug in older binutils
      powerpc: Fix compile errors with CONFIG_BUG=3Dn

Rog=E9rio Brito (2):
      powerpc: compile kernel for linkstations optimized for size
      powerpc: enable heap randomization for linkstations
