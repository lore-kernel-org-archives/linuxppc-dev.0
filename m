Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9DCC2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2012 00:57:21 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joerg.roedel@amd.com>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <timur@freescale.com>, <scottwood@freescale.com>
Subject: [PATCH 0/4] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Fri, 14 Dec 2012 19:21:51 +0530
Message-ID: <1355493114-21776-1-git-send-email-Varun.Sethi@freescale.com>
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
2. Add PAMU bypass enable register to the ccsr_guts structure.
3. Addition of domain attributes required by the PAMU driver IOMMU API.
4. PAMU driver and IOMMU API implementation.

This patch set is based on the next branch of the iommu git tree maintained by Joerg.

Varun Sethi (4):
  store iommu domain info in device arch data.
  add pamu bypass enable register to guts.
  Add iommu attributes for PAMU
  FSL PAMU driver.

 arch/powerpc/include/asm/device.h   |    4 +
 arch/powerpc/include/asm/fsl_guts.h |    4 +-
 drivers/iommu/Kconfig               |    8 +
 drivers/iommu/Makefile              |    1 +
 drivers/iommu/fsl_pamu.c            | 1152 +++++++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu.h            |  398 ++++++++++++
 drivers/iommu/fsl_pamu_domain.c     | 1033 +++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu_domain.h     |   96 +++
 include/linux/iommu.h               |   49 ++
 9 files changed, 2744 insertions(+), 1 deletions(-)
 create mode 100644 drivers/iommu/fsl_pamu.c
 create mode 100644 drivers/iommu/fsl_pamu.h
 create mode 100644 drivers/iommu/fsl_pamu_domain.c
 create mode 100644 drivers/iommu/fsl_pamu_domain.h

-- 
1.7.4.1
