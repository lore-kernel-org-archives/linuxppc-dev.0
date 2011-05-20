Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4228B71CA
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 13:32:08 +1000 (EST)
Date: Thu, 19 May 2011 22:31:51 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [GIT PULL] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1105192230380.2641@right.am.freescale.net>
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

The following changes since commit f38aa708776aefd9e3ba7ec1211c07efe9fa3227:

  powerpc: Remove last piece of GEMINI (2011-05-19 17:32:29 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Bhaskar Upadhaya (1):
      powerpc: Adding bindings for flexcan controller

Dipen Dudhat (1):
      powerpc: Integrated Flash controller device tree bindings

Geert Uytterhoeven (1):
      powerpc/mpc8610_hpcd: Do not use "/" in interrupt names

Kumar Gala (1):
      powerpc/fsl-booke64: Add support for Debug Level exception handler

Prabhakar Kushwaha (4):
      powerpc/85xx: P1020 DTS : re-organize dts files
      powerpc/85xx: P2020 DTS: re-organize dts files
      powerpc/85xx: Fix PCIe IDSEL for Px020RDB
      powerpc/85xx: Create dts of each core in CAMP mode for P1020RDB

Scott Wood (7):
      powerpc/e5500: set non-base IVORs
      powerpc: Add fsl mpic timer binding
      powerpc/p1022ds: fix broken mpic timer node
      powerpc/mpic: parse 4-cell intspec types other than zero
      powerpc/mpic: add the mpic global timer support
      powerpc/e5500: add networking to defconfig
      powerpc/fsl: enable verbose bug output

Shengzhou Liu (1):
      powerpc/fsl_lbc: Add workaround for ELBC-A001 erratum

Timur Tabi (1):
      powerpc/86xx: don't pretend that we support 8-bit pixels on the MPC8610 HPCD

 .../devicetree/bindings/net/can/fsl-flexcan.txt    |   61 +++
 .../devicetree/bindings/powerpc/fsl/ifc.txt        |   76 ++++
 .../devicetree/bindings/powerpc/fsl/mpic-timer.txt |   38 ++
 .../devicetree/bindings/powerpc/fsl/mpic.txt       |    2 +-
 arch/powerpc/boot/dts/p1020rdb.dts                 |  332 +----------------
 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts      |  213 +++++++++++
 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts      |  148 ++++++++
 arch/powerpc/boot/dts/p1020si.dtsi                 |  377 +++++++++++++++++++
 arch/powerpc/boot/dts/p1022ds.dts                  |  106 +++---
 arch/powerpc/boot/dts/p2020ds.dts                  |  374 ++------------------
 arch/powerpc/boot/dts/p2020rdb.dts                 |  378 +++-----------------
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts      |  245 +++-----------
 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts      |  150 +++++---
 arch/powerpc/boot/dts/p2020si.dtsi                 |  382 ++++++++++++++++++++
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig    |    1 -
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig    |    1 -
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig    |    1 -
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig    |    1 -
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig    |    1 -
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig   |    1 -
 arch/powerpc/configs/e55xx_smp_defconfig           |   39 ++-
 arch/powerpc/configs/mpc85xx_defconfig             |    1 -
 arch/powerpc/configs/mpc85xx_smp_defconfig         |    1 -
 arch/powerpc/configs/mpc86xx_defconfig             |    1 -
 arch/powerpc/include/asm/cputable.h                |    4 +-
 arch/powerpc/include/asm/fsl_lbc.h                 |    2 +
 arch/powerpc/include/asm/mpic.h                    |    5 +-
 arch/powerpc/include/asm/reg_booke.h               |    4 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |    3 +
 arch/powerpc/kernel/exceptions-64e.S               |  112 ++++++-
 arch/powerpc/kernel/setup_64.c                     |    8 +
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |   99 ++++--
 arch/powerpc/sysdev/fsl_lbc.c                      |    9 +-
 arch/powerpc/sysdev/mpic.c                         |  129 +++++++-
 34 files changed, 1944 insertions(+), 1361 deletions(-)
 create mode 100755 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/ifc.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt
 create mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
 create mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts
 create mode 100644 arch/powerpc/boot/dts/p1020si.dtsi
 create mode 100644 arch/powerpc/boot/dts/p2020si.dtsi
