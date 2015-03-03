Return-Path: <Bharat.Bhushan@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E35A91A0567
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 16:44:18 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0110.outbound.protection.outlook.com [157.56.111.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D54CE140146
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2015 16:44:17 +1100 (AEDT)
From: Bharat Bhushan <Bharat.Bhushan@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 0/4 RFC] fsl/msi: Add support for MSI bank partitioning
Date: Tue, 3 Mar 2015 10:48:55 +0530
Message-ID: <1425359935-31096-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <Bharat.Bhushan@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With this patchset we add MSI bank partitioning support. MSI bank
partitioning is required for supporting direct device assignment
of MSI capable PCI devices. One MSI bank will be allocated for
"kernel context". VFIO can allocate one MSI bank per "context".
And all devices in the context will share the MSI bank.

We have limited number of MSI banks (2-4). So to support large
number of context we need to allow sharing of MSI banks. This
patchset does not support sharing of MSI bank but will be done
soon once this patchset take a shape.

These changes are tested with both kernel owned PCI devices and
direct assigned devices using VFIO to guest.

Bharat Bhushan (4):
  fsl/msi: have msiir register address absolute rather than offset
  fsl/msi: Move fsl,msi mode specific MSI device search out of main loop
  fsl/msi: Add MSI bank allocation for kernel owned devices
  fsl/msi: Add interface to reserve/free msi bank

 arch/powerpc/include/asm/device.h  |   2 +
 arch/powerpc/include/asm/fsl_msi.h |  26 ++++
 arch/powerpc/sysdev/fsl_msi.c      | 249 +++++++++++++++++++++++++++++++++----
 arch/powerpc/sysdev/fsl_msi.h      |   7 +-
 4 files changed, 261 insertions(+), 23 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fsl_msi.h

-- 
1.9.3
