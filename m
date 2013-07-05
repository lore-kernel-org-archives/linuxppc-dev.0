Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 873B32C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 12:57:44 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 4 Jul 2013 22:57:40 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 17977C90045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:57:37 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r652vckT246182
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 22:57:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r652vbWW027745
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 23:57:37 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 0/8] EEH Followup Fixes (II) 
Date: Fri,  5 Jul 2013 10:57:26 +0800
Message-Id: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches bases on linux-poerpc-next and intends to resolve
the following problems:
 
	- On pSeries platform, the EEH doesn't work after PHB hotplug
	  with "drmgr". The root cause is that the EEH resources (
	  EEH devices, EEH caches) aren't released correctly. For the
	  problem, we add one hook (pcibios_stop_dev), which is called
	  on pci_stop_and_remove_device(). In pcibios_stop_dev(), we
	  release the EEH resources.
	- Another issue is that we need put the domain (PE or PHB) into
	  quite state while doing reset on that domain. However, some
	  deivces in the domain might not have EEH sensitive drivers, or
	  even don't have driver. Those deivces can't be put into quite
	  state and possibly keep issuing PCI-CFG or MMIO request during
	  resetting the domain. That possibly causes the failure of reset
	  and eventually failure of EEH recovery. For the issue, we introduces
	  so-called "partial hotplug". That means, those devices without driver or
	  without EEH sensitive driver are removed before doing reset, and
	  plugged (probed) into the system after reset.
	- We need traverse EEH devices of one specific PE with safe variant
	  of list tranverse function. The EEH device might be removed while
	  doing iteration.
	- When doing plug for PCI bus, we need check if we need reassign the
	  resources for subordinate devices (PCI_REASSIGN_ALL_RSRC) and do that
	  accordingly.

The patchset is verified on pSeires and PowerNV platforms:

pSeries Platform
-----------------

drmgr -c phb -r -s "PHB 513"
drmgr -c phb -a -s "PHB 513"
errinjct eeh -f 1 -s net/eth2

PowerNV Platform
-----------------

cd /sys/devices/pci0005:00/0005:00:00.0/0005:01:00.0/0005:02:08.0/0005:80:00.0/0005:90:01.0
while true; do od -x config > /dev/null; sleep 1; done
echo 1 > /sys/kernel/debug/powerpc/PCI0005/err_injct

---

arch/powerpc/include/asm/eeh.h        |   24 +++++--
arch/powerpc/include/asm/pci-bridge.h |    3 +-
arch/powerpc/include/asm/pci.h        |    2 +
arch/powerpc/kernel/eeh.c             |   56 ++++++---------
arch/powerpc/kernel/eeh_driver.c      |  106 ++++++++++++++++++++++++++-
arch/powerpc/kernel/eeh_pe.c          |   43 ++++++-----
arch/powerpc/kernel/pci-common.c      |    8 ++-
arch/powerpc/kernel/pci-hotplug.c     |  129 +++++++++++++++++++++++++++------
arch/powerpc/kernel/pci_of_scan.c     |   43 ++++++++---
drivers/pci/hotplug/rpadlpar_core.c   |    1 -
drivers/pci/probe.c                   |    4 +
drivers/pci/remove.c                  |    2 +
include/linux/pci.h                   |    1 +
13 files changed, 322 insertions(+), 100 deletions(-)

Thanks,
Gavin
