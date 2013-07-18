Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B58A62C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 12:14:31 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 17 Jul 2013 22:14:28 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 78C1D6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 22:14:21 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6I2EPKa167022
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 22:14:25 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6I2EPrx012751
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 23:14:25 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/10] EEH Followup Fixes (II) 
Date: Thu, 18 Jul 2013 10:14:10 +0800
Message-Id: <1374113660-15347-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches bases on linux-poerpc-next initially and intends to resolve
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

pSeries Platform:

drmgr -c phb -r -s "PHB 513"
drmgr -c phb -a -s "PHB 513"
errinjct eeh -f 1 -s net/eth2

PowerNV Platform:

cd /sys/devices/pci0005:00/0005:00:00.0/0005:01:00.0/0005:02:08.0/0005:80:00.0/0005:90:01.0
while true; do od -x config > /dev/null; sleep 1; done
echo 1 > /sys/kernel/debug/powerpc/PCI0005/err_injct

---

v1 -> v2:
	* Rebase to 3.11.rc1 in order to use pcibios_release_device().
	* Use pcibios_release_device() to release EEH cache and detach
	  EEH device from PCI device.
	* Remove reference to PCI device in EEH cache since we're relying
	  on pcibios_release_device().
	* PCI device instance (struct pci_dev) isn't available during BAR
	  restore and avoid use the instance that time.
	* Fix unbalanced enable for IRQ in eeh_driver.c
	* Retest the series of patches on Firebird-L/VPL3/VPL4

---

arch/powerpc/include/asm/eeh.h               |   28 +++++-
arch/powerpc/include/asm/pci-bridge.h        |    3 +-
arch/powerpc/include/asm/pci.h               |    2 +
arch/powerpc/kernel/eeh.c                    |   68 +++++++-------
arch/powerpc/kernel/eeh_cache.c              |   18 +---
arch/powerpc/kernel/eeh_driver.c             |  109 +++++++++++++++++++++-
arch/powerpc/kernel/eeh_pe.c                 |   58 +++++-------
arch/powerpc/kernel/eeh_sysfs.c              |    7 ++
arch/powerpc/kernel/pci-common.c             |    8 +-
arch/powerpc/kernel/pci-hotplug.c            |  127 ++++++++++++++++++++++----
arch/powerpc/kernel/pci_of_scan.c            |   43 ++++++---
arch/powerpc/platforms/powernv/eeh-powernv.c |   11 ++
arch/powerpc/platforms/pseries/eeh_pseries.c |   63 +++++++++++++-
drivers/pci/hotplug/rpadlpar_core.c          |    1 -
14 files changed, 417 insertions(+), 129 deletions(-)

Thanks,
Gavin
