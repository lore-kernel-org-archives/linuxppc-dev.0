Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19FA41A02D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 12:44:09 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 61F76140140
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 11:44:04 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D68C62CE8055
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:01 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2H1hrBa49807514
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:01 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2H1hSQb013781
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:43:28 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/7] powerpc/eeh: Refactor to use pci_dn
Date: Tue, 17 Mar 2015 12:37:17 +1100
Message-Id: <1426556244-30066-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, EEH depends on device_node or pci_dev heavily. Unfortunately,
SRIOV VFs are supported depending on pci_dn heavily, which is conflicting
with EEH implementation. In order for better support EEH on SRIOV VF, the
EEH is better to be changed a bit to depend on pci_dn, which is exactly
what the patchset does.

The patchset is expected to merged after the patchset "EEH cleanup to
remove chip layer for PowerNV", before "SRIOV patchset". The first two
patches are extracted from SRIOV patchset to make this patchset
self-contained.

Gavin Shan (7):
  powerpc/pci: Refactor pci_dn
  powerpc/powernv: Use pci_dn, not device_node, in PCI config accessor
  powerpc/pci: Trace more information from pci_dn
  powerpc/eeh: Create eeh_dev from pci_dn instead of device_node
  powerpc/eeh: Do probe on pci_dn
  powerpc/eeh: Replace device_node with pci_dn in eeh_ops
  powerpc/eeh: Remove device_node dependency

 arch/powerpc/include/asm/device.h            |   3 +
 arch/powerpc/include/asm/eeh.h               |  28 ++-
 arch/powerpc/include/asm/pci-bridge.h        |  31 +--
 arch/powerpc/include/asm/ppc-pci.h           |   3 +
 arch/powerpc/kernel/eeh.c                    | 127 +++++-------
 arch/powerpc/kernel/eeh_cache.c              |  25 +--
 arch/powerpc/kernel/eeh_dev.c                |  14 +-
 arch/powerpc/kernel/eeh_driver.c             |  22 --
 arch/powerpc/kernel/eeh_pe.c                 | 116 ++++++-----
 arch/powerpc/kernel/of_platform.c            |   2 +-
 arch/powerpc/kernel/pci-hotplug.c            |   2 +-
 arch/powerpc/kernel/pci_dn.c                 | 295 ++++++++++++++++++++++++++-
 arch/powerpc/kernel/pci_of_scan.c            |   2 +-
 arch/powerpc/kernel/rtas_pci.c               |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 192 ++++++++++++-----
 arch/powerpc/platforms/powernv/pci-ioda.c    |  16 ++
 arch/powerpc/platforms/powernv/pci.c         |  69 +++----
 arch/powerpc/platforms/powernv/pci.h         |   4 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |  98 ++++-----
 arch/powerpc/platforms/pseries/msi.c         |   6 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c   |   2 +-
 arch/powerpc/platforms/pseries/setup.c       |   2 +-
 drivers/pci/hotplug/rpadlpar_core.c          |   2 +-
 23 files changed, 694 insertions(+), 369 deletions(-)

-- 
1.8.3.2
