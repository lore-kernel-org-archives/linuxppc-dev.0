Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C60851A0223
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Aug 2014 05:55:11 +1000 (EST)
Date: Fri, 1 Aug 2014 14:54:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git next
Message-ID: <20140801195455.GA3514@home.buserror.net>
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

Highlights include e6500 hardware threading support, an e6500 TLB erratum
workaround, corenet error reporting, support for a new board, and some
minor fixes.

The following changes since commit cd1154770ba984f4c766cac5ea42c38880080b1d:

  powerpc/85xx: drop hypervisor specific board compatibles (2014-07-02 17:33:10 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to 78eb9094ca08a40b8f9d3e113a2b88e0b7dbad1d:

  powerpc/t2080rdb: Add T2080RDB board support (2014-07-31 00:11:10 -0500)

----------------------------------------------------------------
Andy Fleming (1):
      powerpc/e6500: Add support for hardware threads

Himangi Saraogi (2):
      powerpc/mpic_msgr: Use kcalloc and correct the argument to sizeof
      powerpc/fsl-pci: Correct use of ! and &

Priyanka Jain (1):
      powerpc/85xx: Add binding for CPLD

Scott Wood (3):
      powerpc/booke: Define MSR bits the same way as reg.h
      powerpc/e6500: Work around erratum A-008139
      memory: Freescale CoreNet Coherency Fabric error reporting driver

Shengzhou Liu (1):
      powerpc/t2080rdb: Add T2080RDB board support

 .../devicetree/bindings/powerpc/fsl/board.txt      |  16 ++
 arch/powerpc/boot/dts/t2080rdb.dts                 |  57 +++++
 arch/powerpc/boot/dts/t208xrdb.dtsi                | 184 +++++++++++++++
 arch/powerpc/configs/corenet32_smp_defconfig       |   1 +
 arch/powerpc/configs/corenet64_smp_defconfig       |   1 +
 arch/powerpc/include/asm/cputable.h                |   2 +-
 arch/powerpc/include/asm/ppc-opcode.h              |   9 +
 arch/powerpc/include/asm/reg_booke.h               |  55 ++++-
 arch/powerpc/kernel/head_64.S                      |  22 ++
 arch/powerpc/kernel/prom.c                         |  10 +-
 arch/powerpc/kernel/setup-common.c                 |   6 +-
 arch/powerpc/kernel/setup_64.c                     |   6 +-
 arch/powerpc/mm/tlb_low_64e.S                      |  68 +++++-
 arch/powerpc/platforms/85xx/Kconfig                |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c      |   1 +
 arch/powerpc/platforms/85xx/smp.c                  |  44 ++++
 arch/powerpc/sysdev/fsl_pci.c                      |   4 +-
 arch/powerpc/sysdev/mpic_msgr.c                    |   2 +-
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/fsl-corenet-cf.c                    | 251 +++++++++++++++++++++
 21 files changed, 717 insertions(+), 35 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/t2080rdb.dts
 create mode 100644 arch/powerpc/boot/dts/t208xrdb.dtsi
 create mode 100644 drivers/memory/fsl-corenet-cf.c
