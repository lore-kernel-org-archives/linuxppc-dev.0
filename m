Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0138.outbound.protection.outlook.com [65.55.169.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D5DF1A0D64
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 09:47:18 +1100 (AEDT)
Date: Thu, 2 Apr 2015 17:47:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Pull request: scottwood/linux.git next
Message-ID: <20150402224702.GA5064@home.buserror.net>
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

Highlights include BMan device tree nodes, an MSI erratum workaround, a
couple minor performance improvements, config updates, and misc
fixes/cleanup.

The following changes since commit 6eca8933d3ff17bff39d5f10a2a22366d8622fa6:

  powerpc/kernel: Rename copy_thread() 'arg' argument to 'kthread_arg' (2015-03-20 12:41:15 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to d41444daba1fd65e5a998c83398f44524f638d07:

  powerpc/corenet: enable CONFIG_I2C_MUX and CONFIG_I2C_MUX_PCA954x (2015-03-31 22:23:21 -0500)

----------------------------------------------------------------
Andy Fleming (1):
      powerpc/corenet: Enable muxing MDIO buses via GPIO

Benjamin Herrenschmidt (1):
      powerpc: Make corenet64_defconfig a bit more useful

Bogdan Purcareata (1):
      powerpc/mpic: Remove WHOAMI readback after EOI

Emil Medve (1):
      powerpc/dts: Remove B4860 emulator support

Hongtao Jia (4):
      powerpc/mpic: Add get_version API both for internal and external use
      powerpc/85xx: workaround for chips with MSI hardware errata
      powerpc: Enable thermal monitor feature in defconfig for supported platforms
      powerpc: Enable power monitor feature in defconfig for supported platforms

Igal Liberman (1):
      powerpc/mpc85xx: Add FMan platform support

Julia Lawall (1):
      powerpc: don't export static symbol

Kevin Hao (1):
      powerpc: book3e_64: fix the align size for paca_struct

Kumar Gala (1):
      powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support to device tree(s)

Madalin Bucur (1):
      powerpc/fsl-booke: Add T4080 SVR value

Shengzhou Liu (2):
      powerpc/t2080qds: fix rtc interrupt
      powerpc/corenet: enable CONFIG_I2C_MUX and CONFIG_I2C_MUX_PCA954x

Shruti Kanetkar (1):
      powerpc/corenet: Enable muxing MDIO buses via FPGA

Yanjiang Jin (1):
      powerpc/mpc85xx: call k(un)map_atomic rather than k(un)map

 arch/powerpc/boot/dts/b4860emu.dts            | 223 ----------------------
 arch/powerpc/boot/dts/b4qds.dtsi              |  17 +-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi   |  60 +++++-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi      |  89 ++++++++-
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi   |  37 +++-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi   |  11 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi   |  11 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi   |  11 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi   |  11 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi   |  11 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi   |  65 ++++++-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi   | 105 +++++++++-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi   | 265 +++++++++++++++++++++++++-
 arch/powerpc/boot/dts/kmcoge4.dts             |  15 ++
 arch/powerpc/boot/dts/oca4080.dts             |  15 ++
 arch/powerpc/boot/dts/p1023rdb.dts            |  18 +-
 arch/powerpc/boot/dts/p2041rdb.dts            |  17 +-
 arch/powerpc/boot/dts/p3041ds.dts             |  17 +-
 arch/powerpc/boot/dts/p4080ds.dts             |  17 +-
 arch/powerpc/boot/dts/p5020ds.dts             |  17 +-
 arch/powerpc/boot/dts/p5040ds.dts             |  17 +-
 arch/powerpc/boot/dts/t104xqds.dtsi           |  17 +-
 arch/powerpc/boot/dts/t104xrdb.dtsi           |  14 ++
 arch/powerpc/boot/dts/t208xqds.dtsi           |  19 +-
 arch/powerpc/boot/dts/t208xrdb.dtsi           |  15 ++
 arch/powerpc/boot/dts/t4240qds.dts            |  17 +-
 arch/powerpc/boot/dts/t4240rdb.dts            |  15 ++
 arch/powerpc/configs/corenet32_smp_defconfig  |   7 +-
 arch/powerpc/configs/corenet64_smp_defconfig  |  15 +-
 arch/powerpc/configs/mpc85xx_defconfig        |   3 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig    |   2 +-
 arch/powerpc/include/asm/mpc85xx.h            |   1 +
 arch/powerpc/include/asm/mpic.h               |   3 +
 arch/powerpc/include/asm/paca.h               |   4 +-
 arch/powerpc/platforms/85xx/common.c          |   1 +
 arch/powerpc/platforms/85xx/corenet_generic.c |  12 ++
 arch/powerpc/platforms/85xx/smp.c             |   4 +-
 arch/powerpc/sysdev/fsl_msi.c                 |  29 ++-
 arch/powerpc/sysdev/fsl_msi.h                 |   2 +
 arch/powerpc/sysdev/mpic.c                    |  11 +-
 arch/powerpc/sysdev/qe_lib/qe_io.c            |  25 ---
 41 files changed, 981 insertions(+), 284 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/b4860emu.dts
