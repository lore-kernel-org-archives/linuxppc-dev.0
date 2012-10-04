Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BBDA2C0371
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 22:00:31 +1000 (EST)
Received: from mail110-co1 (localhost [127.0.0.1])	by
 mail110-co1-R.bigfish.com (Postfix) with ESMTP id 2788A3A00E8	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 12:00:25 +0000 (UTC)
Received: from CO1EHSMHS020.bigfish.com (unknown [10.243.78.237])	by
 mail110-co1.bigfish.com (Postfix) with ESMTP id CEF87C80019	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 12:00:22 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q94C0H3x019811	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Oct 2012 05:00:18 -0700
From: <b16395@freescale.com>
To: <joerg.roedel@amd.com>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3 v2] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Thu, 4 Oct 2012 17:26:45 +0530
Message-ID: <1349351808-7156-1-git-send-email-b16395@freescale.com>
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

From: Varun Sethi <Varun.Sethi@freescale.com>

This patchset provides the Freescale PAMU (Peripheral Access Management Unit) driver
and the corresponding IOMMU API implementation. PAMU is the IOMMU present on Freescale
QorIQ platforms. PAMU can authorize memory access, remap the memory address, and remap 
the I/O transaction type.

This set consists of the following patches:
1. Addition of new field in the device (powerpc) archdata structure for storing iommu domain information
   pointer. This pointer is stored when the device is attached to a particular iommu domain.
2. Addition of domain attributes required by the PAMU driver IOMMU API.
3. PAMU driver and IOMMU API implementation.

This patch set is based on the next branch of the iommu git tree maintained by Joerg.

Varun Sethi (3):
  Store iommu domain information pointer in archdata.
  Add iommu domain attributes required by fsl PAMU driver.
  FSL PAMU driver and IOMMU API implementation.

 arch/powerpc/include/asm/device.h |    4 +
 drivers/iommu/Kconfig             |    7 +
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/fsl_pamu.c          | 1033 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu.h          |  377 ++++++++++++++
 drivers/iommu/fsl_pamu_domain.c   |  990 +++++++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu_domain.h   |   94 ++++
 drivers/iommu/fsl_pamu_proto.h    |   49 ++
 include/linux/iommu.h             |   30 ++
 9 files changed, 2585 insertions(+), 0 deletions(-)
 create mode 100644 drivers/iommu/fsl_pamu.c
 create mode 100644 drivers/iommu/fsl_pamu.h
 create mode 100644 drivers/iommu/fsl_pamu_domain.c
 create mode 100644 drivers/iommu/fsl_pamu_domain.h
 create mode 100644 drivers/iommu/fsl_pamu_proto.h

-- 
1.7.4.1
