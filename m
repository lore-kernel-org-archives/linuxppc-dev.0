Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC5592C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 23:20:36 +1000 (EST)
Received: from mail3-ch1 (localhost [127.0.0.1])	by mail3-ch1-R.bigfish.com
 (Postfix) with ESMTP id 5D0933C0165	for <linuxppc-dev@lists.ozlabs.org>; Wed,
 19 Sep 2012 13:20:27 +0000 (UTC)
Received: from CH1EHSMHS031.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.237])	by mail3-ch1.bigfish.com (Postfix) with ESMTP id
 456C64C005E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 13:20:24 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q8JDKJeO001866	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 06:20:20 -0700
From: <b16395@freescale.com>
To: <iommu@lists.linux-foundation.org>, <joerg.roedel@amd.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC][PATCH 0/3] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Wed, 19 Sep 2012 18:47:09 +0530
Message-ID: <1348060632-12997-1-git-send-email-b16395@freescale.com>
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
