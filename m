Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD86E1A0004
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 10:52:07 +1000 (EST)
Date: Wed, 2 Jul 2014 19:51:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git next
Message-ID: <20140703005155.GA22007@home.buserror.net>
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

Highlights include MAINTAINERS updates, t4240rdb and t2080qds support,
removal of the long-broken mpc8xx pcmcia driver, and various minor fixes
and updates.

The following changes since commit 68986c9f0f4552c34c248501eb0c690553866d6e:

  Revert "offb: Add palette hack for little endian" (2014-06-16 19:45:45 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to cd1154770ba984f4c766cac5ea42c38880080b1d:

  powerpc/85xx: drop hypervisor specific board compatibles (2014-07-02 17:33:10 -0500)

----------------------------------------------------------------
Bharat Bhushan (1):
      booke/powerpc: define wimge shift mask to fix compilation error

Chunhe Lan (2):
      t4240/dts: Enable third elo3 DMA engine support
      powerpc/85xx: Add T4240RDB board support

Laurentiu TUDOR (1):
      powerpc/85xx: drop hypervisor specific board compatibles

Laurentiu Tudor (1):
      powerpc/booke64: wrap tlb lock and search in htw miss with FTR_SMT

Marcelo Tosatti (1):
      MAINTAINERS: Update PPC 8xx entry

Scott Wood (6):
      powerpc/e6500: hw tablewalk: clear TID in kernel indirect entries
      powerpc/e6500: hw tablewalk: fix recursive tlb lock on cpu 0
      powerpc/e500mc: Fix wrong value of MCSR_L2MMU_MHIT
      MAINTAINERS: Update Linux for Freescale PowerPC
      pcmcia: Remove m8xx_pcmcia driver
      powerpc/8xx: Remove empty asm/mpc8xx.h

Shengzhou Liu (3):
      powerpc/defconfig: update RTC support
      powerpc/fsl-booke: Add support for T2080/T2081 SoC
      powerpc/fsl-booke: Add initial T208x QDS board support

Valentin Longchamp (1):
      powerpc/mpc85xx: fix fsl/p2041-post.dtsi clockgen mux2

Wladislav Wiebe (1):
      powerpc/traps/e500: fix misleading error output

 MAINTAINERS                                      |    3 +-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi      |    1 +
 arch/powerpc/boot/dts/fsl/t2080si-post.dtsi      |   69 ++
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi      |  435 ++++++++
 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi       |   99 ++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi      |    1 +
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi       |    1 +
 arch/powerpc/boot/dts/t2080qds.dts               |   57 ++
 arch/powerpc/boot/dts/t2081qds.dts               |   46 +
 arch/powerpc/boot/dts/t208xqds.dtsi              |  239 +++++
 arch/powerpc/boot/dts/t4240rdb.dts               |  186 ++++
 arch/powerpc/configs/corenet32_smp_defconfig     |    3 +-
 arch/powerpc/configs/corenet64_smp_defconfig     |    4 +
 arch/powerpc/configs/mpc85xx_defconfig           |    3 +
 arch/powerpc/configs/mpc85xx_smp_defconfig       |    3 +
 arch/powerpc/include/asm/fs_pd.h                 |    1 -
 arch/powerpc/include/asm/mpc85xx.h               |    2 +
 arch/powerpc/include/asm/mpc8xx.h                |   12 -
 arch/powerpc/include/asm/pte-fsl-booke.h         |    2 +
 arch/powerpc/include/asm/reg_booke.h             |    2 +-
 arch/powerpc/kernel/traps.c                      |    2 +-
 arch/powerpc/mm/tlb_low_64e.S                    |   19 +-
 arch/powerpc/platforms/85xx/Kconfig              |    2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c    |   52 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c          |    3 -
 arch/powerpc/platforms/8xx/mpc885ads_setup.c     |   62 --
 arch/powerpc/platforms/8xx/tqm8xx_setup.c        |    1 -
 arch/powerpc/sysdev/micropatch.c                 |    1 -
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c |    1 -
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c |    1 -
 drivers/pcmcia/Kconfig                           |   10 -
 drivers/pcmcia/Makefile                          |    1 -
 drivers/pcmcia/m8xx_pcmcia.c                     | 1168 ----------------------
 33 files changed, 1189 insertions(+), 1303 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/t2080si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/t2080qds.dts
 create mode 100644 arch/powerpc/boot/dts/t2081qds.dts
 create mode 100644 arch/powerpc/boot/dts/t208xqds.dtsi
 create mode 100644 arch/powerpc/boot/dts/t4240rdb.dts
 delete mode 100644 arch/powerpc/include/asm/mpc8xx.h
 delete mode 100644 drivers/pcmcia/m8xx_pcmcia.c
