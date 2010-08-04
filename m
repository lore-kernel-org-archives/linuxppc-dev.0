Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 664A0B70D2
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 08:35:19 +1000 (EST)
Date: Wed, 4 Aug 2010 17:35:09 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <Pine.LNX.4.64.1008041734370.11290@localhost.localdomain>
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

The following changes since commit e8e5c2155b0035b6e04f29be67f6444bc914005b:
  Matt Evans (1):
        powerpc/kexec: Fix orphaned offline CPUs across kexec

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Anton Vorontsov (3):
      powerpc/85xx: Fix SWIOTLB initalization for MPC85xxMDS boards
      powerpc/85xx: Fix booting for P1021MDS boards
      powerpc/85xx: Cleanup QE initialization for MPC85xxMDS boards

Bradley Hughes (2):
      powerpc/85xx: Change deprecated binding for 85xx-based boards
      powerpc/85xx: Adding DTS for the STx GP3-SSA MPC8555 board

Dmitry Eremin-Solenikov (2):
      powerpc/tqm85xx: update PCI interrupt-map attribute
      powerpc/tqm85xx: add a quirk for ti1520 PCMCIA bridge

Heiko Schocher (1):
      powerpc/8xx: Add support for the MPC8xx based boards from TQC

Ilya Yanok (2):
      powerpc/fsl_pci: add quirk for mpc8308 pcie bridge
      powerpc/mpc8308rdb: support for MPC8308RDB board from Freescale

Matthew McClintock (1):
      powerpc/85xx: kexec for SMP 85xx BookE systems

Timur Tabi (1):
      powerpc/85xx: Introduce support for the Freescale P1022DS reference board

 arch/powerpc/Kconfig                       |   10 +-
 arch/powerpc/boot/dts/mpc8308rdb.dts       |  303 +++++++++
 arch/powerpc/boot/dts/mpc8540ads.dts       |    4 +-
 arch/powerpc/boot/dts/mpc8541cds.dts       |    4 +-
 arch/powerpc/boot/dts/mpc8544ds.dts        |    4 +-
 arch/powerpc/boot/dts/mpc8548cds.dts       |    4 +-
 arch/powerpc/boot/dts/mpc8555cds.dts       |    4 +-
 arch/powerpc/boot/dts/mpc8560ads.dts       |    4 +-
 arch/powerpc/boot/dts/mpc8568mds.dts       |    4 +-
 arch/powerpc/boot/dts/p1021mds.dts         |    1 +
 arch/powerpc/boot/dts/p1022ds.dts          |  633 +++++++++++++++++++
 arch/powerpc/boot/dts/stxssa8555.dts       |  380 +++++++++++
 arch/powerpc/boot/dts/tqm8540.dts          |    9 +-
 arch/powerpc/boot/dts/tqm8541.dts          |    9 +-
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    9 +-
 arch/powerpc/boot/dts/tqm8548.dts          |    9 +-
 arch/powerpc/boot/dts/tqm8555.dts          |    9 +-
 arch/powerpc/boot/dts/tqm8560.dts          |    9 +-
 arch/powerpc/boot/dts/tqm8xx.dts           |  172 +++++
 arch/powerpc/configs/mpc85xx_defconfig     |   34 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig |   34 +-
 arch/powerpc/configs/tqm8xx_defconfig      |  934 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/Kconfig        |    8 +
 arch/powerpc/platforms/83xx/Makefile       |    1 +
 arch/powerpc/platforms/83xx/mpc830x_rdb.c  |   94 +++
 arch/powerpc/platforms/85xx/Kconfig        |    8 +
 arch/powerpc/platforms/85xx/Makefile       |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |  279 +++++----
 arch/powerpc/platforms/85xx/p1022_ds.c     |  148 +++++
 arch/powerpc/platforms/85xx/smp.c          |   63 ++
 arch/powerpc/platforms/85xx/tqm85xx.c      |   21 +
 arch/powerpc/platforms/8xx/Kconfig         |    6 +
 arch/powerpc/platforms/8xx/Makefile        |    1 +
 arch/powerpc/platforms/8xx/tqm8xx_setup.c  |  156 +++++
 arch/powerpc/sysdev/fsl_pci.c              |    1 +
 include/linux/pci_ids.h                    |    1 +
 36 files changed, 3185 insertions(+), 186 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8308rdb.dts
 create mode 100644 arch/powerpc/boot/dts/p1022ds.dts
 create mode 100644 arch/powerpc/boot/dts/stxssa8555.dts
 create mode 100644 arch/powerpc/boot/dts/tqm8xx.dts
 create mode 100644 arch/powerpc/configs/tqm8xx_defconfig
 create mode 100644 arch/powerpc/platforms/83xx/mpc830x_rdb.c
 create mode 100644 arch/powerpc/platforms/85xx/p1022_ds.c
 create mode 100644 arch/powerpc/platforms/8xx/tqm8xx_setup.c
