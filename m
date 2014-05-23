Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA7141A007D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 07:21:29 +1000 (EST)
Date: Fri, 23 May 2014 16:21:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git
Message-ID: <20140523212116.GA21705@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Highlights include a few new boards, a device tree binding for CCF
(including backwards-compatible device tree updates to distinguish
incompatible versions), and some fixes.

The following changes since commit f6869e7fe657bd977e72954cd78c5871a6a4f71d:

  Merge remote-tracking branch 'anton/abiv2' into next (2014-05-05 20:57:12 +1000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to e83eb028bb980cecc85b050aa626df384723aff2:

  powerpc/fsl: Add fsl,portid-mapping to corenet1-cf chips (2014-05-22 18:10:42 -0500)

----------------------------------------------------------------
Alexander Graf (1):
      PPC: ePAPR: Fix hypercall on LE guest

Diana Craciun (3):
      powerpc/fsl: Added binding for Freescale CoreNet coherency fabric (CCF)
      powerpc/fsl: Updated device trees for platforms with corenet version 2
      powerpc/fsl: Updated corenet-cf compatible string for corenet1-cf chips

Lijun Pan (1):
      powerpc/mpc85xx: Remove P1023 RDS support

Liu Gang (1):
      powerpc/rmu: Fix the error memory free parameters

Martijn de Gouw (1):
      powerpc/85xx: Add OCA4080 board support

Prabhakar Kushwaha (2):
      powerpc/mpc85xx:Add initial device tree support of T104x
      powerpc/fsl-booke: Add initial T104x_QDS board support

Scott Wood (6):
      powerpc/fsl-rio: Fix fsl_rio_setup error paths and use-after-unmap
      powerpc/fsl-booke64: Set vmemmap_psize to 4K
      powerpc: fix build of epapr_paravirt on 64-bit book3s
      powerpc: Fix unused variable warning for epapr_has_idle
      powerpc/mpic: Don't init the fsl error int until after mpic init
      powerpc/fsl: Add fsl,portid-mapping to corenet1-cf chips

Stuart Yoder (1):
      powerpc: move epapr paravirt init of power_save to an initcall

Tang Yuantian (1):
      clk: qoriq: Update the clock bindings

Valentin Longchamp (3):
      devicetree: bindings: add Zarlink to the vendor prefixes
      devcietree: bindings: add some MFD Keymile FPGAs
      powerpc/mpc85xx: add support for Keymile's kmcoge4 board

Wang Dongsheng (1):
      fsl/pci: fix RC cannot detect PME message coming

harninder rai (1):
      powerpc/mpc85xx: Add BSC9132 QDS Support

 .../clock/{corenet-clock.txt => qoriq-clock.txt}   |  10 +-
 Documentation/devicetree/bindings/mfd/bfticu.txt   |  25 ++
 Documentation/devicetree/bindings/mfd/qriox.txt    |  17 +
 .../devicetree/bindings/powerpc/fsl/board.txt      |  17 +
 .../devicetree/bindings/powerpc/fsl/ccf.txt        |  46 +++
 .../devicetree/bindings/powerpc/fsl/cpus.txt       |  11 +
 .../devicetree/bindings/powerpc/fsl/pamu.txt       |  10 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/powerpc/boot/dts/b4860emu.dts                 |   7 +-
 arch/powerpc/boot/dts/bsc9132qds.dts               |  35 ++
 arch/powerpc/boot/dts/bsc9132qds.dtsi              | 101 +++++
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |   4 -
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   2 +
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |   4 -
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   4 +
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |   3 +-
 arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi      | 185 +++++++++
 arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi       |  66 ++++
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   3 +-
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   4 +
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   3 +-
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   4 +
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   3 +-
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |   8 +
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |   3 +-
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   2 +
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   3 +-
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   4 +
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        | 430 +++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1042si-post.dtsi        |  37 ++
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         | 104 +++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |   3 +-
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |  12 +
 arch/powerpc/boot/dts/kmcoge4.dts                  | 152 ++++++++
 arch/powerpc/boot/dts/oca4080.dts                  | 118 ++++++
 arch/powerpc/boot/dts/p1023rds.dts                 | 219 -----------
 arch/powerpc/boot/dts/t1040qds.dts                 |  46 +++
 arch/powerpc/boot/dts/t1042qds.dts                 |  46 +++
 arch/powerpc/boot/dts/t104xqds.dtsi                | 166 ++++++++
 arch/powerpc/boot/dts/t4240emu.dts                 |  15 +-
 arch/powerpc/configs/85xx/kmp204x_defconfig        | 225 +++++++++++
 arch/powerpc/configs/corenet32_smp_defconfig       |   1 +
 arch/powerpc/configs/mpc85xx_defconfig             |   1 -
 arch/powerpc/configs/mpc85xx_smp_defconfig         |   1 -
 arch/powerpc/kernel/epapr_paravirt.c               |  19 +-
 arch/powerpc/mm/tlb_nohash.c                       |   7 +-
 arch/powerpc/platforms/85xx/Kconfig                |  19 +-
 arch/powerpc/platforms/85xx/Makefile               |   3 +-
 arch/powerpc/platforms/85xx/bsc913x_qds.c          |  74 ++++
 arch/powerpc/platforms/85xx/corenet_generic.c      |   9 +-
 .../platforms/85xx/{p1023_rds.c => p1023_rdb.c}    |  36 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   3 +-
 arch/powerpc/sysdev/fsl_rio.c                      |  10 +-
 arch/powerpc/sysdev/fsl_rmu.c                      |   6 +-
 arch/powerpc/sysdev/mpic.c                         |   8 +-
 55 files changed, 2065 insertions(+), 290 deletions(-)
 rename Documentation/devicetree/bindings/clock/{corenet-clock.txt => qoriq-clock.txt} (95%)
 create mode 100644 Documentation/devicetree/bindings/mfd/bfticu.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/qriox.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
 create mode 100644 arch/powerpc/boot/dts/bsc9132qds.dts
 create mode 100644 arch/powerpc/boot/dts/bsc9132qds.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/kmcoge4.dts
 create mode 100644 arch/powerpc/boot/dts/oca4080.dts
 delete mode 100644 arch/powerpc/boot/dts/p1023rds.dts
 create mode 100644 arch/powerpc/boot/dts/t1040qds.dts
 create mode 100644 arch/powerpc/boot/dts/t1042qds.dts
 create mode 100644 arch/powerpc/boot/dts/t104xqds.dtsi
 create mode 100644 arch/powerpc/configs/85xx/kmp204x_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/bsc913x_qds.c
 rename arch/powerpc/platforms/85xx/{p1023_rds.c => p1023_rdb.c} (75%)
