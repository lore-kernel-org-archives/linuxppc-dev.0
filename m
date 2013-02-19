Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 25EA12C008D
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2013 04:18:40 +1100 (EST)
Date: Tue, 19 Feb 2013 11:18:26 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1302191116560.6955@right.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mostly misc code cleanups in various board ports and adding support for a
new MPC85xx board - ppa8548.

- k

The following changes since commit 2468dcf641e4f3e1b0153e3e11ca20740b2f4ce8:
  Ian Munsie (1):
        powerpc: Add support for context switching the TAR register

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Gerlando Falauto (2):
      powerpc/83xx: refactor mpc8360e quirk for kmeter1
      powerpc/83xx: apply mpc8360e quirk for kmeter1 only when par_io is present

Harninder Rai (2):
      powerpc/85xx: bsc9131 - Correct typo in SDHC device node
      powerpc/85xx: l2sram - Add compatible string for BSC9131 platform

Holger Brunck (3):
      powerpc/82xx: fix checkpatch warnings for km82xx.c
      powerpc/83xx: fix checkpatch warnings for km83xx.c
      powerpc/83xx: update kmeter1_defconfig

Julia Lawall (1):
      arch/powerpc/platforms/85xx/p1022_ds.c: adjust duplicate test

Kim Phillips (4):
      powerpc/fsl: lbc: sparse fixes
      powerpc/fsl: fsl_soc: sparse fixes
      powerpc/fsl: ifc: sparse fixes
      powerpc/fsl: msi: sparse fixes

Paul Gortmaker (4):
      powerpc/85xx: split sbc8548 dts file into pre and post chunks
      powerpc/85xx: update sbc8548 flash information to match recent u-boot
      powerpc/85xx: add alternate dts file for sbc8548 boot via SODIMM
      powerpc/85xx: enable MTD options in sbc8548 defconfig

Po Liu (1):
      powerpc/85xx: dts - add ranges property for SEC

Scott Wood (2):
      powerpc/mpic: allow coreint to be determined by MPIC version
      powerpc/e500/qemu-e500: enable coreint

Stef van Os (1):
      powerpc/85xx: Board support for ppa8548

Timur Tabi (3):
      powerpc/85xx: describe the PAMU topology in the device tree
      powerpc/85xx: fix various PCI node compatible strings
      powerpc/fsl: remove extraneous DIU platform functions

Vakul Garg (1):
      crypto: caam - Added property fsl, sec-era in SEC4.0 device tree binding.

Varun Sethi (1):
      powerpc/fsl_pci: Store the pci ctlr device ptr in the pci ctlr struct

Wei Yongjun (1):
      powerpc/85xx: use for_each_compatible_node() macro

 .../devicetree/bindings/crypto/fsl-sec4.txt        |   12 +-
 .../devicetree/bindings/powerpc/fsl/guts.txt       |   13 +-
 .../devicetree/bindings/powerpc/fsl/pamu.txt       |  140 ++++++++
 arch/powerpc/boot/dts/bsc9131rdb.dtsi              |    2 +-
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi        |    4 +-
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi        |    6 +-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   87 ++++-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   87 ++++-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   74 +++-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |   92 ++++-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   92 ++++-
 arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi        |    1 +
 arch/powerpc/boot/dts/ppa8548.dts                  |  166 +++++++++
 arch/powerpc/boot/dts/sbc8548-altflash.dts         |  115 +++++++
 arch/powerpc/boot/dts/sbc8548-post.dtsi            |  295 ++++++++++++++++
 arch/powerpc/boot/dts/sbc8548-pre.dtsi             |   52 +++
 arch/powerpc/boot/dts/sbc8548.dts                  |  356 ++------------------
 arch/powerpc/configs/83xx/kmeter1_defconfig        |    6 +-
 arch/powerpc/configs/85xx/ppa8548_defconfig        |   65 ++++
 arch/powerpc/configs/85xx/sbc8548_defconfig        |   19 ++
 arch/powerpc/platforms/512x/mpc512x_shared.c       |    5 -
 arch/powerpc/platforms/82xx/km82xx.c               |    6 +-
 arch/powerpc/platforms/83xx/km83xx.c               |  161 ++++-----
 arch/powerpc/platforms/85xx/Kconfig                |    7 +
 arch/powerpc/platforms/85xx/Makefile               |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |    4 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |   40 +--
 arch/powerpc/platforms/85xx/p1022_rdk.c            |   12 -
 arch/powerpc/platforms/85xx/ppa8548.c              |   98 ++++++
 arch/powerpc/platforms/85xx/qemu_e500.c            |    7 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c              |    1 +
 arch/powerpc/sysdev/fsl_ifc.c                      |    2 +-
 arch/powerpc/sysdev/fsl_lbc.c                      |    6 +-
 arch/powerpc/sysdev/fsl_msi.c                      |    4 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   24 +-
 arch/powerpc/sysdev/fsl_pci.h                      |    2 +-
 arch/powerpc/sysdev/fsl_soc.c                      |    4 +-
 arch/powerpc/sysdev/mpic.c                         |   26 +-
 38 files changed, 1530 insertions(+), 564 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/pamu.txt
 create mode 100644 arch/powerpc/boot/dts/ppa8548.dts
 create mode 100644 arch/powerpc/boot/dts/sbc8548-altflash.dts
 create mode 100644 arch/powerpc/boot/dts/sbc8548-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/sbc8548-pre.dtsi
 create mode 100644 arch/powerpc/configs/85xx/ppa8548_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/ppa8548.c
