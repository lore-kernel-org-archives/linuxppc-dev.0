Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzFdS0nhczDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Sep 2017 00:06:19 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8ME5BXx052721
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 10:06:17 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d53mfhv1q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 10:06:16 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Fri, 22 Sep 2017 08:06:16 -0600
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] Prepartion for SR-IOV PowerVM Enablement
Date: Fri, 22 Sep 2017 09:06:06 -0500
Message-Id: <20170922140608.47665-1-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series is to prepare for enabling SR-IOV
on pseries. It separates the calls to be machine dependent
and does not change any current functionality.

This patch which is currently in review is a dependency:
https://patchwork.kernel.org/patch/9882915/

Bryant G. Ly (2):
  powerpc/kernel: Separate SR-IOV Calls
  pseries/eeh: Add Pseries pcibios_bus_add_device

 arch/powerpc/include/asm/machdep.h           |  7 ++++++
 arch/powerpc/include/asm/pci-bridge.h        |  4 +---
 arch/powerpc/kernel/eeh_driver.c             |  4 ++--
 arch/powerpc/kernel/pci-common.c             | 23 +++++++++++++++++++
 arch/powerpc/kernel/pci_dn.c                 |  6 -----
 arch/powerpc/platforms/powernv/eeh-powernv.c | 34 +++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++--
 arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++
 8 files changed, 79 insertions(+), 29 deletions(-)

-- 
2.11.0 (Apple Git-81)
