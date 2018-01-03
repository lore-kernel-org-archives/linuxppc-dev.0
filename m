Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBczb2sfGzDqgs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jan 2018 04:16:42 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 w03Gw8ii115241
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jan 2018 12:16:40 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2f8yvxswpf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jan 2018 12:16:40 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Wed, 3 Jan 2018 10:16:39 -0700
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v3 0/7] SR-IOV Enablement on PowerVM
Date: Wed,  3 Jan 2018 11:16:26 -0600
Message-Id: <20180103171633.94499-1-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series will enable SR-IOV on PowerVM. A specific set of
lids for PFW/PHYP is required. They are planned to release with
920 at the moment.

For IBM internal testers let me know of a system you want to test on
and we can put on the lids required or we can provide a system to run
the tests.

This patch depends on the three patches:
988fc3ba5653278a8c14d6ccf687371775930d2b
dae7253f9f78a731755ca20c66b2d2c40b86baea
608c0d8804ef3ca4cda8ec6ad914e47deb283d7b

v1 - Initial Patch
v2 - Addressed Alexey and Russell's comments
v3 - Unify the call of .error_detected()

Bryant G. Ly (7):
  platform/pseries: Update VF config space after EEH
  powerpc/kernel: Add uevents in EEH error/resume
  platforms/pseries: Set eeh_pe of EEH_PE_VF type
  powerpc/kernel Add EEH operations to notify resume
  powerpc/kernel: Add EEH notify resume sysfs
  pseries/pci: Associate PEs to VFs in configure SR-IOV
  pseries/setup: Add Initialization of VF Bars

 arch/powerpc/include/asm/eeh.h               |   2 +
 arch/powerpc/include/asm/pci-bridge.h        |   5 +-
 arch/powerpc/include/asm/pci.h               |   2 +
 arch/powerpc/kernel/eeh.c                    |  59 ++++++++++
 arch/powerpc/kernel/eeh_driver.c             |   8 +-
 arch/powerpc/kernel/eeh_sysfs.c              |  46 +++++++-
 arch/powerpc/kernel/pci_of_scan.c            |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  68 +----------
 arch/powerpc/platforms/pseries/eeh_pseries.c | 132 ++++++++++++++++++++-
 arch/powerpc/platforms/pseries/pci.c         | 151 +++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/setup.c       | 164 +++++++++++++++++++++++++++
 drivers/pci/pcie/aer/aerdrv_core.c           |   3 +
 include/linux/pci.h                          |  36 ++++++
 13 files changed, 605 insertions(+), 73 deletions(-)

-- 
2.14.3 (Apple Git-98)
