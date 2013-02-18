Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F5812C1C34
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:59:25 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <iommu@lists.linux-foundation.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <scottwood@freescale.com>, <joro@8bytes.org>,
 <stuart.yoder@freescale.com>
Subject: [PATCH 0/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Mon, 18 Feb 2013 18:22:13 +0530
Message-ID: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset provides the Freescale PAMU (Peripheral Access Management Unit) driver
and the corresponding IOMMU API implementation. PAMU is the IOMMU present on Freescale
QorIQ platforms. PAMU can authorize memory access, remap the memory address, and remap 
the I/O transaction type.

This set consists of the following patches:
1. Addition of new field in the device (powerpc) archdata structure for storing iommu domain information
   pointer. This pointer is stored when the device is attached to a particular iommu domain.
2. Store PCI controller platform device information in the PCI controller structure.
3. Add defines for FSL PCI controller BRR1 register.
4. Add window permission flags in the iommu_domain_window_enable API.
5. Add domain attributes for FSL PAMU driver.
6. PAMU driver and IOMMU API implementation.

This patch set is based on the next branch of the iommu git tree maintained by Joerg.

Varun Sethi (6):
  Store iommu domain information in the device structure.
  Store the platform device information corresponding to the pci
    controller.
  Added defines for the FSL PCI controller BRR1 register.
  Add window permission flags for iommu_domain_window_enable API.
  Add addtional attributes specific to the PAMU driver.
  FSL PAMU driver and IOMMU API implementation.

 arch/powerpc/include/asm/device.h     |    4 +
 arch/powerpc/include/asm/pci-bridge.h |    4 +
 arch/powerpc/sysdev/fsl_pci.c         |    9 +-
 arch/powerpc/sysdev/fsl_pci.h         |    2 +-
 drivers/iommu/Kconfig                 |    8 +
 drivers/iommu/Makefile                |    1 +
 drivers/iommu/fsl_pamu.c              | 1260 +++++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu.h              |  398 +++++++++++
 drivers/iommu/fsl_pamu_domain.c       | 1135 +++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu_domain.h       |   89 +++
 drivers/iommu/iommu.c                 |    5 +-
 include/linux/iommu.h                 |   40 +-
 12 files changed, 2947 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iommu/fsl_pamu.c
 create mode 100644 drivers/iommu/fsl_pamu.h
 create mode 100644 drivers/iommu/fsl_pamu_domain.c
 create mode 100644 drivers/iommu/fsl_pamu_domain.h

-- 
1.7.4.1
