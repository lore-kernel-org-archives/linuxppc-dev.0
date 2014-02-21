Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 586C92C0342
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 17:35:29 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: benh@kernel.crashing.org, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org,
 linux-usb@vger.kernel.org
Subject: [PATCH 0/7] IBM Akebono/PPC476GTR Support
Date: Fri, 21 Feb 2014 17:31:26 +1100
Message-Id: <1392964293-13687-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IBM Akebono board is a development board for the new PPC476GTR
system on chip (SoC).

This is just a resubmission of the previous patches rebased on kernel
v3.13. Ben H has indicated the subsystem specific changes should be
merged via the appropriate kernel trees.

Alistair Popple (7):
  IBM Akebono: Add a SDHCI platform driver
  IBM Akebono: Add support for a new PHY interface to the IBM emac
    driver
  IBM Akebono: Add support to the OHCI platform driver for PPC476GTR
  ECHI Platform: Merge ppc-of EHCI driver into the ehci-platform driver
  IBM Currituck: Clean up board specific code before adding Akebono
    code
  IBM Akebono: Add the Akebono platform
  powerpc: Added PCI MSI support using the HSTA module

 .../devicetree/bindings/powerpc/4xx/akebono.txt    |   54 +++
 .../devicetree/bindings/powerpc/4xx/emac.txt       |    9 +
 arch/powerpc/boot/Makefile                         |    3 +
 arch/powerpc/boot/dcr.h                            |    4 +
 arch/powerpc/boot/dts/akebono.dts                  |  415 ++++++++++++++++++++
 arch/powerpc/boot/treeboot-akebono.c               |  163 ++++++++
 arch/powerpc/boot/wrapper                          |    3 +
 arch/powerpc/configs/44x/akebono_defconfig         |  148 +++++++
 arch/powerpc/platforms/44x/Kconfig                 |   28 ++
 arch/powerpc/platforms/44x/Makefile                |    3 +-
 arch/powerpc/platforms/44x/currituck.c             |  233 -----------
 arch/powerpc/platforms/44x/ppc476.c                |  299 ++++++++++++++
 arch/powerpc/sysdev/Kconfig                        |    6 +
 arch/powerpc/sysdev/Makefile                       |    1 +
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c              |  215 ++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.c                   |   21 +-
 drivers/mmc/host/Kconfig                           |   12 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sdhci-of-476gtr.c                 |   60 +++
 drivers/net/ethernet/ibm/emac/Kconfig              |    4 +
 drivers/net/ethernet/ibm/emac/Makefile             |    1 +
 drivers/net/ethernet/ibm/emac/core.c               |   50 ++-
 drivers/net/ethernet/ibm/emac/core.h               |   12 +
 drivers/net/ethernet/ibm/emac/rgmii_wol.c          |  244 ++++++++++++
 drivers/net/ethernet/ibm/emac/rgmii_wol.h          |   62 +++
 drivers/usb/host/Kconfig                           |    7 +-
 drivers/usb/host/ehci-hcd.c                        |    5 -
 drivers/usb/host/ehci-platform.c                   |   87 +++-
 drivers/usb/host/ehci-ppc-of.c                     |  238 -----------
 drivers/usb/host/ohci-platform.c                   |   22 +-
 30 files changed, 1912 insertions(+), 498 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/4xx/akebono.txt
 create mode 100644 arch/powerpc/boot/dts/akebono.dts
 create mode 100644 arch/powerpc/boot/treeboot-akebono.c
 create mode 100644 arch/powerpc/configs/44x/akebono_defconfig
 delete mode 100644 arch/powerpc/platforms/44x/currituck.c
 create mode 100644 arch/powerpc/platforms/44x/ppc476.c
 create mode 100644 arch/powerpc/sysdev/ppc4xx_hsta_msi.c
 create mode 100644 drivers/mmc/host/sdhci-of-476gtr.c
 create mode 100644 drivers/net/ethernet/ibm/emac/rgmii_wol.c
 create mode 100644 drivers/net/ethernet/ibm/emac/rgmii_wol.h
 delete mode 100644 drivers/usb/host/ehci-ppc-of.c

-- 
1.7.10.4
