Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07784B7107
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 08:04:17 +1100 (EST)
Date: Tue, 15 Mar 2011 16:04:09 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1103151602560.19745@right.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following changes since commit 964a29962c278ddff8a199f23d7c9ef35152a0fe:

  powerpc/pseries: Disable MSI using new interface if possible (2011-03-11 14:18:24 +1100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Anatolij Gustschin (1):
      powerpc/mpc8xxx_gpio: simplify searching for 'fsl, qoriq-gpio' compatiable

Holger Brunck (3):
      powerpc/83xx: rename and update kmeter1
      powerpc/82xx: rename and update mgcoge board support
      powerpc/8xx: remove obsolete mgsuvd board

Julia Lawall (1):
      drivers/serial/ucc_uart.c: Add of_node_put to avoid memory leak

Kumar Gala (1):
      powerpc/85xx: Fix writing to spin table 'cpu-release-addr' on ppc64e

Liu Yu (1):
      powerpc/85xx: Workaroudn e500 CPU erratum A005

Prabhakar Kushwaha (1):
      powerpc/fsl_pci: Add support for FSL PCIe controllers v2.x

Scott Wood (1):
      powerpc/fsl_msi: Handle msi-available-ranges better

Shan Hai (1):
      powerpc/85xx: Fix SPE float to integer conversion failure

Stuart Yoder (1):
      powerpc/fsl: define binding for fsl mpic interrupt controllers

Vasiliy Kulikov (1):
      powerpc/85xx: Fix signedness bug in cache-sram

Vivek Mahajan (1):
      powerpc/fsl: 85xx: document cache sram bindings

Xulei (2):
      ATA: Add FSL sata v2 controller support
      powerpc/85xx: Update sata controller compatible for p1022ds board

 .../devicetree/bindings/powerpc/fsl/cache_sram.txt |   20 ++
 .../devicetree/bindings/powerpc/fsl/mpic.txt       |  253 ++++++++++++++++----
 .../devicetree/bindings/powerpc/fsl/msi-pic.txt    |    9 +-
 arch/powerpc/boot/dts/kmeter1.dts                  |   69 +++---
 arch/powerpc/boot/dts/mgcoge.dts                   |   47 ++--
 arch/powerpc/boot/dts/mgsuvd.dts                   |  163 -------------
 arch/powerpc/boot/dts/p1022ds.dts                  |    4 +-
 arch/powerpc/configs/83xx/kmeter1_defconfig        |    7 +-
 arch/powerpc/configs/mgcoge_defconfig              |    9 +-
 arch/powerpc/configs/mgsuvd_defconfig              |   81 -------
 arch/powerpc/include/asm/reg.h                     |    2 +
 arch/powerpc/math-emu/math_efp.c                   |   65 +++++-
 arch/powerpc/platforms/82xx/Makefile               |    2 +-
 arch/powerpc/platforms/82xx/{mgcoge.c => km82xx.c} |   62 ++++--
 arch/powerpc/platforms/83xx/Makefile               |    2 +-
 .../powerpc/platforms/83xx/{kmeter1.c => km83xx.c} |   46 +++--
 arch/powerpc/platforms/85xx/smp.c                  |    6 +-
 arch/powerpc/platforms/8xx/Kconfig                 |    6 -
 arch/powerpc/platforms/8xx/Makefile                |    1 -
 arch/powerpc/platforms/8xx/mgsuvd.c                |   92 -------
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c              |    4 +-
 arch/powerpc/sysdev/fsl_msi.c                      |   92 +++++---
 arch/powerpc/sysdev/fsl_pci.c                      |   15 +-
 arch/powerpc/sysdev/fsl_pci.h                      |   17 +-
 arch/powerpc/sysdev/mpc8xxx_gpio.c                 |    4 +-
 drivers/ata/sata_fsl.c                             |   25 ++-
 drivers/tty/serial/ucc_uart.c                      |   67 +++---
 27 files changed, 584 insertions(+), 586 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/cache_sram.txt
 delete mode 100644 arch/powerpc/boot/dts/mgsuvd.dts
 delete mode 100644 arch/powerpc/configs/mgsuvd_defconfig
 rename arch/powerpc/platforms/82xx/{mgcoge.c => km82xx.c} (69%)
 rename arch/powerpc/platforms/83xx/{kmeter1.c => km83xx.c} (80%)
 delete mode 100644 arch/powerpc/platforms/8xx/mgsuvd.c
