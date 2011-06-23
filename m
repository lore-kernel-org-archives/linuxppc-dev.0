Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 037E5B6F57
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 20:29:30 +1000 (EST)
Date: Thu, 23 Jun 2011 05:29:21 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1106222141510.2926@right.am.freescale.net>
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

The following changes since commit dc28518f7d7dfd93cd44edb44f9b8e961f5a5c1b:

  powerpc: Fix doorbell type shift (2011-06-20 11:21:48 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Ashish Kalra (2):
      powerpc/85xx: Save scratch registers to thread info instead of using SPRGs.
      powerpc: introduce the ePAPR embedded hypervisor vmpic driver

Baruch Siach (1):
      MAINTAINERS: add arch/powerpc/platforms/85xx/ to the 85xx entry

Dmitry Eremin-Solenikov (2):
      powerpc/85xx: tqm8540 - add description for onboard flash
      powerpc/85xx: specify interrupt for pq3-localbus devices

Kumar Gala (10):
      powerpc: Rename e55xx_smp_defconfig to corenet64_smp_defconfig
      powerpc: Add a defconfig for 'corenet' 32-bit platforms
      powerpc/85xx: Add P5020DS device tree
      powerpc/85xx: Add P3041DS device tree
      powerpc/85xx: Updates to P4080DS device tree
      powerpc/85xx: Cleanup PCIe support on corenet_ds boards
      powerpc/fsl_pci: Simplify matching logic for PCI_FIXUP_HEADER
      powerpc/pci: Move FSL fixup from 32-bit to common
      powerpc/85xx: Add PCI support in 64-bit mode on P5020DS
      powerpc/qe: Limit QE support to ppc32

Lei Xu (2):
      powerpc/85xx: Update device tree to add nand info for p5020ds
      powerpc/85xx: Update device tree to add nand info for p3041ds

Prabhakar Kushwaha (1):
      powerpc/85xx: Add host-pci(e) bridge only for RC

Roy Zang (1):
      powerpc/85xx: Add basic P1023RDS board support

Scott Wood (1):
      powerpc/85xx: Set up doorbells even with no mpic

Stuart Yoder (1):
      powerpc: make irq_choose_cpu() available to all PIC drivers

Timur Tabi (4):
      powerpc: introduce ePAPR embedded hypervisor hcall interface
      powerpc: add Freescale hypervisor partition control functions
      powerpc/85xx: add board support for the Freescale hypervisor
      powerpc/p1022ds: add missing iounmap calls to platform file

 MAINTAINERS                                        |    1 +
 arch/powerpc/boot/dts/mpc8568mds.dts               |    2 +
 arch/powerpc/boot/dts/p1023rds.dts                 |  546 ++++++++++++++
 arch/powerpc/boot/dts/p3041ds.dts                  |  791 ++++++++++++++++++++
 arch/powerpc/boot/dts/p4080ds.dts                  |  329 ++++++---
 arch/powerpc/boot/dts/p5020ds.dts                  |  784 +++++++++++++++++++
 arch/powerpc/boot/dts/socrates.dts                 |    2 +
 arch/powerpc/boot/dts/tqm8540.dts                  |   42 +
 arch/powerpc/boot/dts/tqm8548-bigflash.dts         |    2 +
 arch/powerpc/boot/dts/tqm8548.dts                  |    2 +
 arch/powerpc/boot/dts/tqm8560.dts                  |    2 +
 arch/powerpc/boot/dts/xpedite5200.dts              |    2 +
 arch/powerpc/boot/dts/xpedite5200_xmon.dts         |    2 +
 arch/powerpc/configs/85xx/p1023rds_defconfig       |  173 +++++
 arch/powerpc/configs/corenet32_smp_defconfig       |  183 +++++
 ...e55xx_smp_defconfig => corenet64_smp_defconfig} |    0
 arch/powerpc/configs/mpc85xx_defconfig             |    7 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig         |    6 +-
 arch/powerpc/include/asm/ehv_pic.h                 |   40 +
 arch/powerpc/include/asm/epapr_hcalls.h            |  502 +++++++++++++
 arch/powerpc/include/asm/fsl_hcalls.h              |  655 ++++++++++++++++
 arch/powerpc/include/asm/irq.h                     |    2 +
 arch/powerpc/include/asm/processor.h               |    5 +
 arch/powerpc/include/asm/reg.h                     |    4 +-
 arch/powerpc/kernel/asm-offsets.c                  |    3 +
 arch/powerpc/kernel/head_booke.h                   |   42 +-
 arch/powerpc/kernel/head_fsl_booke.S               |   49 +-
 arch/powerpc/kernel/irq.c                          |   35 +
 arch/powerpc/kernel/pci-common.c                   |   18 +
 arch/powerpc/kernel/pci_32.c                       |   19 -
 arch/powerpc/platforms/85xx/Kconfig                |    9 +
 arch/powerpc/platforms/85xx/Makefile               |    1 +
 arch/powerpc/platforms/85xx/corenet_ds.c           |   41 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |   11 +-
 arch/powerpc/platforms/85xx/p1023_rds.c            |  162 ++++
 arch/powerpc/platforms/85xx/p3041_ds.c             |   16 +-
 arch/powerpc/platforms/85xx/p4080_ds.c             |   28 +-
 arch/powerpc/platforms/85xx/p5020_ds.c             |   16 +-
 arch/powerpc/platforms/85xx/smp.c                  |   21 +-
 arch/powerpc/platforms/Kconfig                     |    6 +-
 arch/powerpc/sysdev/Makefile                       |    1 +
 arch/powerpc/sysdev/ehv_pic.c                      |  302 ++++++++
 arch/powerpc/sysdev/fsl_pci.c                      |   84 +--
 arch/powerpc/sysdev/fsl_soc.c                      |   27 +
 arch/powerpc/sysdev/fsl_soc.h                      |    3 +
 arch/powerpc/sysdev/mpic.c                         |   36 -
 46 files changed, 4699 insertions(+), 315 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1023rds.dts
 create mode 100644 arch/powerpc/boot/dts/p3041ds.dts
 create mode 100644 arch/powerpc/boot/dts/p5020ds.dts
 create mode 100644 arch/powerpc/configs/85xx/p1023rds_defconfig
 create mode 100644 arch/powerpc/configs/corenet32_smp_defconfig
 rename arch/powerpc/configs/{e55xx_smp_defconfig => corenet64_smp_defconfig} (100%)
 create mode 100644 arch/powerpc/include/asm/ehv_pic.h
 create mode 100644 arch/powerpc/include/asm/epapr_hcalls.h
 create mode 100644 arch/powerpc/include/asm/fsl_hcalls.h
 create mode 100644 arch/powerpc/platforms/85xx/p1023_rds.c
 create mode 100644 arch/powerpc/sysdev/ehv_pic.c
