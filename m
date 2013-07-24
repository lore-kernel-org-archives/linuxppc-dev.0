Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 762802C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 12:25:12 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 20:25:09 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 683EB3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:24:45 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6O2P602155242
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:25:07 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6O2P6IB014639
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:25:06 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/11] EEH Followup Fixes (II) 
Date: Wed, 24 Jul 2013 10:24:50 +0800
Message-Id: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
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

v3 -> v4:
	* Add some comments to explain why we needn't check the return
	  value of pci_scan_slot() in pcibios_add_pci_devices().
	* Check PCI_PROBE_ONLY while assigning those unassigned resources
	  in pcibios_finish_adding_to_bus().
v2 -> v3:
	* Make pcibios_add_pci_devices() to support "partial" hotplug
	  according to Ben's comments. arch/powerpc/kernel/pci_of_scan.c
	  has been adjusted for that.
	* Use pcibios_add_pci_devices() to do "partial" hotplug inside
	  eeh_reset_device().
	* Introduce flag EEH_DEV_SYSFS to trace the state of sysfs entries
	  of the EEH device (then PCI device) to avoid race condition during
	  "partial" hotplug.
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

arch/powerpc/include/asm/eeh.h               |   30 ++++++++--
arch/powerpc/include/asm/pci-bridge.h        |    1 -
arch/powerpc/kernel/eeh.c                    |   70 +++++++++++------------
arch/powerpc/kernel/eeh_cache.c              |   18 ++----
arch/powerpc/kernel/eeh_driver.c             |   77 +++++++++++++++++++++++++-
arch/powerpc/kernel/eeh_pe.c                 |   58 ++++++++-----------
arch/powerpc/kernel/eeh_sysfs.c              |   21 +++++++
arch/powerpc/kernel/pci-common.c             |    2 +
arch/powerpc/kernel/pci-hotplug.c            |   49 ++++++++--------
arch/powerpc/kernel/pci_of_scan.c            |   56 +++++++++++++-----
arch/powerpc/platforms/powernv/eeh-powernv.c |   17 +++++-
arch/powerpc/platforms/pseries/eeh_pseries.c |   67 +++++++++++++++++++++-
drivers/pci/hotplug/rpadlpar_core.c          |    1 -
13 files changed, 327 insertions(+), 140 deletions(-)

Thanks,
Gavin
