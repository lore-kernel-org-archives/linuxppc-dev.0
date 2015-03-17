Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CA0F1A0BD1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 16:16:11 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6C5BE14011D
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:11 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 15:16:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6226D2BB0040
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:07 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2H5FxR614024756
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:07 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2H5FXwl008466
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:15:33 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/7] powerpc/eeh: Refactor to use pci_dn
Date: Tue, 17 Mar 2015 16:15:01 +1100
Message-Id: <1426569308-9470-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/eeh: Refactor to use pci_dn

Currently, EEH depends on device_node or pci_dev heavily. Unfortunately,
SRIOV VFs are supported depending on pci_dn heavily, which is conflicting
with EEH implementation. In order for better support EEH on SRIOV VF, the
EEH is better to be changed a bit to depend on pci_dn, which is exactly
what the patchset does.

The patchset is expected to merged after the patchset "EEH cleanup to
remove chip layer for PowerNV", before "SRIOV patchset". The first two
patches are extracted from SRIOV patchset to make this patchset
self-contained.

Changelog
=========
v1 -> v2:
	* Remove SRIOV PF/VFs related logics in pci_dn.c and the flag for
          VF's pci_dn in pci-bridge.h;
	* Dereference "struct pci_dn *pci_data", not "void *firmware_data"
	  from "struct dev_archdata" and "struct pci_controller";
	* Move changes to eeh_restore_dev_state() from PATCH[7/7] to
	  PATCH[6/7] to avoid build error caused by PATCH[6/7];

Gavin Shan (7):
  powerpc/pci: Refactor pci_dn
  powerpc/powernv: Use pci_dn, not device_node, in PCI config accessor
  powerpc/pci: Trace more information from pci_dn
  powerpc/eeh: Create eeh_dev from pci_dn instead of device_node
  powerpc/eeh: Do probe on pci_dn
  powerpc/eeh: Replace device_node with pci_dn in eeh_ops
  powerpc/eeh: Remove device_node dependency

 arch/powerpc/include/asm/device.h            |   6 +
 arch/powerpc/include/asm/eeh.h               |  28 ++--
 arch/powerpc/include/asm/pci-bridge.h        |  28 ++--
 arch/powerpc/include/asm/ppc-pci.h           |   3 +
 arch/powerpc/kernel/eeh.c                    | 127 ++++++++----------
 arch/powerpc/kernel/eeh_cache.c              |  25 ++--
 arch/powerpc/kernel/eeh_dev.c                |  14 +-
 arch/powerpc/kernel/eeh_driver.c             |  22 ---
 arch/powerpc/kernel/eeh_pe.c                 | 116 +++++++++-------
 arch/powerpc/kernel/of_platform.c            |   2 +-
 arch/powerpc/kernel/pci-hotplug.c            |   2 +-
 arch/powerpc/kernel/pci_dn.c                 | 180 ++++++++++++++++++++++++-
 arch/powerpc/kernel/pci_of_scan.c            |   2 +-
 arch/powerpc/kernel/rtas_pci.c               |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 192 +++++++++++++++++++--------
 arch/powerpc/platforms/powernv/pci.c         |  69 ++++------
 arch/powerpc/platforms/powernv/pci.h         |   4 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |  98 +++++---------
 arch/powerpc/platforms/pseries/msi.c         |   6 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c   |   2 +-
 arch/powerpc/platforms/pseries/setup.c       |   2 +-
 drivers/pci/hotplug/rpadlpar_core.c          |   2 +-
 22 files changed, 563 insertions(+), 369 deletions(-)

-- 
1.8.3.2
