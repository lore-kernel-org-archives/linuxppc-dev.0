Return-Path: <B16395@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E943D2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 05:52:58 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <scottwood@freescale.com>, <stuart.yoder@freescale.com>
Subject: [PATCH 0/5 v9] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Thu, 14 Mar 2013 00:15:05 +0530
Message-ID: <1363200310-11513-1-git-send-email-Varun.Sethi@freescale.com>
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
1.  Make iova u64 in the iommu_iova_to_phys API.
2. Addition of new field in the device (powerpc) archdata structure for storing iommu domain information
   pointer.
3. Add window permission flags in the iommu_domain_window_enable API.
4. Add domain attributes for FSL PAMU driver.
5. PAMU driver and IOMMU API implementation.

This patch set is based on the master branch (3.9-rc2) of Linus Torvald's git tree.

Varun Sethi (5):
  Make iova u64 in the iommu_iova_to_phys API.
  Add iommu domain pointer to device archdata
  Add the window permission flag as a parameter to iommu_window_enable
  API.
  Add addition iommu attributes required by the PAMU driver.
  FSL PAMU driver.

 arch/powerpc/include/asm/device.h |    6 +
 arch/powerpc/sysdev/fsl_pci.h     |    5 +
 drivers/iommu/Kconfig             |    8 +
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/amd_iommu.c         |    2 +-
 drivers/iommu/exynos-iommu.c      |    2 +-
 drivers/iommu/fsl_pamu.c          | 1250 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu.h          |  405 ++++++++++++
 drivers/iommu/fsl_pamu_domain.c   | 1134 +++++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu_domain.h   |   85 +++
 drivers/iommu/intel-iommu.c       |    2 +-
 drivers/iommu/iommu.c             |    8 +-
 drivers/iommu/msm_iommu.c         |    2 +-
 drivers/iommu/omap-iommu.c        |    2 +-
 drivers/iommu/shmobile-iommu.c    |    2 +-
 drivers/iommu/tegra-gart.c        |    2 +-
 drivers/iommu/tegra-smmu.c        |    2 +-
 include/linux/iommu.h             |   51 ++-
 18 files changed, 2948 insertions(+), 21 deletions(-)
 create mode 100644 drivers/iommu/fsl_pamu.c
 create mode 100644 drivers/iommu/fsl_pamu.h
 create mode 100644 drivers/iommu/fsl_pamu_domain.c
 create mode 100644 drivers/iommu/fsl_pamu_domain.h

-- 
1.7.4.1
