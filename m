Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 682971A0297
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jan 2016 08:39:03 +1100 (AEDT)
Date: Mon, 4 Jan 2016 15:38:55 -0600
From: Scott Wood <oss@buserror.net>
To: benh@kernel.crashing.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Message-ID: <20160104213855.GA19111@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Pull request: scottwood/linux.git next
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Highlights include moving QE code out of arch/powerpc (to be shared with
arm), device tree updates, and minor fixes.

Sorry for sending this in so late and not getting to everything in my
queue -- in addition to the holidays I've been slowed down by email
troubles and a broken arm.

The following changes since commit e9d764f803964a54ca7da4a67d124fe824ebd80a:

  powerpc/pseries: Enable kernel CPU dlpar from sysfs (2015-12-17 22:41:03 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to 44451d4d8f0e35153b3e7e3d40e198f2cf9ac36a:

  MAINTAINERS: Update Scott Wood's e-mail address (2015-12-31 12:57:26 -0600)

----------------------------------------------------------------
Daniel Walker (1):
      powerpc/85xx: mpc85xx ADS: remove pci exclude

Harninder Rai (2):
      powerpc/fsl: Add PCI node in device tree of bsc9132qds
      powerpc/85xx: Add PCIe controller support for bsc9132qds

Hongtao Jia (3):
      dt-bindings: Add QorIQ TMU thermal bindings
      powerpc/mpc85xx: Add TMU device tree support for T1040/T1042
      powerpc/mpc85xx: Add TMU device tree support for T1023/T1024

Igal Liberman (1):
      powerpc/mpc85xx: Update B4 FMan MURAM size

Raghav Dogra (1):
      powerpc/fsl_lbc: removal of dead code

Scott Wood (2):
      powerpc/e6500: add locking to hugetlb
      MAINTAINERS: Update Scott Wood's e-mail address

Zhao Qiang (7):
      genalloc:support memory-allocation with bytes-alignment to genalloc
      genalloc:support allocating specific region
      CPM/QE: use genalloc to manage CPM/QE muram
      QE/CPM: move muram management functions to qe_common
      QE: use subsys_initcall to init qe
      QE: Move QE from arch/powerpc to drivers/soc
      powerpc/p1010rdb: Update dts for pcie interrupt-map

li pengbo (1):
      powerpc/85xx: Enable TWR_P102x in mpc85xx_basic_defconfig

 .../devicetree/bindings/thermal/qoriq-thermal.txt  |  63 ++++++
 MAINTAINERS                                        |   7 +-
 arch/powerpc/Kconfig                               |   2 -
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |   5 +
 arch/powerpc/boot/dts/fsl/bsc9132qds.dts           |  15 ++
 arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi      |  28 +++
 arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi       |   1 +
 arch/powerpc/boot/dts/fsl/p1010rdb.dtsi            |  16 ++
 arch/powerpc/boot/dts/fsl/t1023rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |  86 ++++++++
 arch/powerpc/boot/dts/fsl/t1024qds.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1024rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1024si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |   2 +
 arch/powerpc/boot/dts/fsl/t1040d4rdb.dts           |   2 +-
 arch/powerpc/boot/dts/fsl/t1040qds.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1040rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  94 +++++++++
 arch/powerpc/boot/dts/fsl/t1042d4rdb.dts           |   2 +-
 arch/powerpc/boot/dts/fsl/t1042qds.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts          |   2 +-
 arch/powerpc/boot/dts/fsl/t1042si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         |   4 +
 arch/powerpc/configs/mpc85xx_basic_defconfig       |   1 +
 arch/powerpc/include/asm/cpm.h                     |  44 +---
 arch/powerpc/mm/hugetlbpage-book3e.c               |  46 ++++
 arch/powerpc/platforms/83xx/km83xx.c               |   6 +-
 arch/powerpc/platforms/83xx/misc.c                 |   2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |   6 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |   6 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |   6 +-
 arch/powerpc/platforms/83xx/mpc836x_rdk.c          |   7 +-
 arch/powerpc/platforms/85xx/bsc913x_qds.c          |   8 +-
 arch/powerpc/platforms/85xx/common.c               |   3 +-
 arch/powerpc/platforms/85xx/corenet_generic.c      |   2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |  15 --
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   4 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   4 +-
 arch/powerpc/platforms/85xx/twr_p102x.c            |   4 +-
 arch/powerpc/platforms/Kconfig                     |  13 +-
 arch/powerpc/sysdev/Makefile                       |   1 -
 arch/powerpc/sysdev/cpm_common.c                   | 158 +-------------
 arch/powerpc/sysdev/fsl_lbc.c                      |   2 -
 arch/powerpc/sysdev/fsl_pci.c                      |  13 ++
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |   2 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |   8 +-
 drivers/net/ethernet/freescale/ucc_geth.h          |   8 +-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/fsl/Makefile                           |   6 +
 .../sysdev/qe_lib => drivers/soc/fsl/qe}/Kconfig   |  11 +
 .../sysdev/qe_lib => drivers/soc/fsl/qe}/Makefile  |   4 +-
 .../sysdev/qe_lib => drivers/soc/fsl/qe}/gpio.c    |   2 +-
 .../sysdev/qe_lib => drivers/soc/fsl/qe}/qe.c      |  17 +-
 drivers/soc/fsl/qe/qe_common.c                     | 235 +++++++++++++++++++++
 .../sysdev/qe_lib => drivers/soc/fsl/qe}/qe_ic.c   |   5 +-
 .../sysdev/qe_lib => drivers/soc/fsl/qe}/qe_ic.h   |   4 +-
 .../sysdev/qe_lib => drivers/soc/fsl/qe}/qe_io.c   |   2 +-
 .../sysdev/qe_lib => drivers/soc/fsl/qe}/ucc.c     |   6 +-
 .../qe_lib => drivers/soc/fsl/qe}/ucc_fast.c       |   8 +-
 .../qe_lib => drivers/soc/fsl/qe}/ucc_slow.c       |   8 +-
 .../sysdev/qe_lib => drivers/soc/fsl/qe}/usb.c     |   4 +-
 drivers/spi/spi-fsl-cpm.c                          |   2 +-
 drivers/tty/serial/ucc_uart.c                      |   2 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                |   2 +-
 drivers/usb/host/fhci-hcd.c                        |   2 +-
 drivers/usb/host/fhci-hub.c                        |   2 +-
 drivers/usb/host/fhci-sched.c                      |   2 +-
 drivers/usb/host/fhci.h                            |   4 +-
 include/linux/genalloc.h                           |  38 +++-
 .../include/asm => include/soc/fsl/qe}/immap_qe.h  |   0
 .../include/asm => include/soc/fsl/qe}/qe.h        |  52 ++++-
 .../include/asm => include/soc/fsl/qe}/qe_ic.h     |   0
 .../include/asm => include/soc/fsl/qe}/ucc.h       |   4 +-
 .../include/asm => include/soc/fsl/qe}/ucc_fast.h  |   6 +-
 .../include/asm => include/soc/fsl/qe}/ucc_slow.h  |   6 +-
 lib/genalloc.c                                     |  93 +++++++-
 78 files changed, 907 insertions(+), 338 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
 create mode 100644 drivers/soc/fsl/Makefile
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/Kconfig (54%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/Makefile (69%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/gpio.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe.c (98%)
 create mode 100644 drivers/soc/fsl/qe/qe_common.c
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_ic.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_ic.h (97%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_io.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc.c (98%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc_fast.c (98%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc_slow.c (98%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/usb.c (96%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/immap_qe.h (100%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/qe.h (95%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/qe_ic.h (100%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc.h (96%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc_fast.h (98%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc_slow.h (99%)
