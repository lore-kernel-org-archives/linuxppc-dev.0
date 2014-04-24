Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3299A14011F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:23 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BE5962BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O806QO8847810
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:07 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80KSM003855
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 00/25] EEH Enhancement and bug fixes
Date: Thu, 24 Apr 2014 18:00:06 +1000
Message-Id: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches enhances EEH to block I/O and PCI-CFG access during
PE reset. Besides, it includes various bug fixes regarding EEH.

Gavin Shan (25):
  powerpc/eeh: Remove EEH_PE_PHB_DEAD
  powerpc/powernv: Remove PNV_EEH_STATE_REMOVED
  powerpc/powernv: Move PNV_EEH_STATE_ENABLED around
  powerpc/powernv: Remove fields in PHB diag-data dump
  powerpc/eeh: EEH_PE_ISOLATED not reflect HW state
  powerpc/eeh: Block PCI-CFG access during PE reset
  powerpc/powernv: Use EEH PCI config accessors
  powerpc/eeh: Avoid I/O access during PE reset
  powerpc/eeh: Cleanup eeh_gather_pci_data()
  powerpc/eeh: Use cached capability for log dump
  powerpc/eeh: Cleanup EEH subsystem variables
  powerpc/eeh: Allow to disable EEH
  powerpc/eeh: No hotplug on permanently removed dev
  powerpc/powernv: Fix endless reporting frozen PE
  powerpc/pseries: Fix overwritten PE state
  powerpc/powernv: Reset root port in firmware
  powerpc/eeh: Make the delay for PE reset unified
  powerpc/pci: Mask linkDown on resetting PCI bus
  powrpc/powernv: Reset PHB in kdump kernel
  powerpc/eeh: Can't recover from non-PE-reset case
  powerpc/powernv: Fundamental reset on PLX ports
  powerpc/powernv: Missed IOMMU table type
  powerpc/powernv: pci_domain_nr() not reliable
  PCI: Fix return value from pci_user_{read,write}_config_*()
  powerpc/prom: Stop scanning dev-tree for fdump early

 arch/powerpc/include/asm/eeh.h               |  47 +++-
 arch/powerpc/include/asm/machdep.h           |   3 +
 arch/powerpc/include/asm/ppc-pci.h           |   1 +
 arch/powerpc/kernel/eeh.c                    | 211 +++++++++-------
 arch/powerpc/kernel/eeh_driver.c             | 118 +++++++--
 arch/powerpc/kernel/eeh_pe.c                 |  47 +++-
 arch/powerpc/kernel/fadump.c                 |   5 +-
 arch/powerpc/kernel/pci-common.c             |  20 ++
 arch/powerpc/kernel/pci_of_scan.c            |   9 +
 arch/powerpc/kernel/rtas_pci.c               |  66 +++--
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 349 +++++++++++++++++----------
 arch/powerpc/platforms/powernv/eeh-powernv.c |   4 +
 arch/powerpc/platforms/powernv/pci-ioda.c    |  26 +-
 arch/powerpc/platforms/powernv/pci.c         | 202 +++++++++-------
 arch/powerpc/platforms/powernv/pci.h         |  11 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |  43 +++-
 drivers/pci/access.c                         |  12 +-
 drivers/pci/pci.c                            |  21 +-
 include/linux/pci.h                          |   6 +-
 19 files changed, 811 insertions(+), 390 deletions(-)

Thanks,
Gavin
