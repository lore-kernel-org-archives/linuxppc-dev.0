Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AF391A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 23:38:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 15 May 2015 23:37:58 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EC4712CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 23:37:56 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4FDbmJ120578390
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 23:37:57 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4FDbNNv009864
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 23:37:24 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: [PATCH V5 00/10] VF EEH on Power8
Date: Fri, 15 May 2015 21:36:54 +0800
Message-Id: <1431697024-5710-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset enables EEH on SRIOV VFs. The general idea is to create proper
VF edev and VF PE and handle them properly.

Different from the Bus PE, VF PE just contain one VF. This introduces the
difference of EEH error handling on a VF PE. Generally, it has several
differences.

First, the VF's removal and re-enumerate rely on its PF. VF has a tight
relationship between its PF. This is not proper to enumerate a VF by usual
scan procedure. That's why virtfn_add/virtfn_remove are exported in this patch
set.

Second, the reset/restore of a VF is done in kernel space. FW is not aware of
the VF, this means the usual reset function done in FW will not work. One of
the patch will imitate the reset/restore function in kernel space.

Third, the VF may be removed during the PF's error_detected function. In this
case, the original error_detected->slot_reset->resume sequence is not proper
to those removed VFs, since they are re-created by PF in a fresh state. A flag
in eeh_dev is introduce to mark the eeh_dev is in error state. By doing so, we
track whether this device needs to be reset or not.

This has been tested both on host and in guest on Power8 with latest kernel
version.

v5:
   * remove the compound field, iterate on Master VF PE instead
   * some code refine on PCI config restore and reset on VF
     the wait time for assert and deassert
     PCI device address format
     check on edev->pcie_cap and edev->aer_cap before access them
v4:
   * refine the change logs, comment and code style
   * change pnv_pci_fixup_vf_eeh() to pnv_eeh_vf_final_fixup() and remove the
     CONFIG_PCI_IOV macro
   * reorder patch 5/6 to make the logic more reasonable
   * remove remove_dev_pci_data()
   * remove the EEH_DEV_VF flag, use edev->physfn to identify a VF EEH DEV and
     remove related CONFIG_PCI_IOV macro
   * add the option for VF reset
   * fix the pnv_eeh_cfg_blocked() logic
   * replace pnv_pci_cfg_{read,write} with eeh_ops->{read,write}_config in
     pnv_eeh_vf_restore_config()
   * rename pnv_eeh_vf_restore_config() to pnv_eeh_restore_vf_config()
   * rename pnv_pci_fixup_vf_caps() to pnv_pci_vf_header_fixup() and move it
     to arch/powerpc/platforms/powernv/pci.c
   * add a field compound in pnv_ioda_pe to link compound PEs
   * handle compound PE for VF PEs
v3:
   * add back vf_index in pci_dn to track the VF's index
   * rename ppdev in eeh_dev to physfn for consistency
   * move edev->physfn assignment before dev->dev.archdata.edev is set
   * move pnv_pci_fixup_vf_eeh() and pnv_pci_fixup_vf_caps() to eeh-powernv.c
   * more clear and detail in commit log and comment in code
   * merge eeh_rmv_virt_device() with eeh_rmv_device()
   * move the cfg_blocked check logic from pnv_eeh_read/write_config() to
     pnv_eeh_cfg_blocked()
   * move the vf reset/restore logic into its own patch, two patches are
     created.
     powerpc/powernv: Support PCI config restore for VFs
     powerpc/powernv: Support EEH reset for VFs
   * simplify the vf reset logic
v2:
   * add prefix pci_iov_ to virtfn_add/virtfn_remove
   * use EEH_DEV_VF as a flag for a VF's eeh_dev
   * use eeh_dev instead of edev in change log
   * remove vf_index in eeh_dev, calculate it from pdn->busno and devfn
   * do eeh_add_device_late() and eeh_sysfs_add_device() both after pci_dev is
     well initialized
   * do FLR to reset a VF PE
   * imitate the restore function in FW for VF
   * remove the reverse order patch, since it is still under discussion

Wei Yang (10):
  pci/iov: rename and export virtfn_add/virtfn_remove
  powerpc/pci_dn: cache vf_index in pci_dn
  powerpc/pci: remove PCI devices in reverse order
  powerpc/eeh: cache address range just for normal device
  powerpc/powernv: create/release eeh_dev for VF
  powerpc/eeh: create EEH_PE_VF for VF PE
  powerpc/powernv: Support EEH reset for VFs
  powerpc/powernv: Support PCI config restore for VFs
  powerpc/eeh: handle VF PE properly
  powerpc/powernv: compound PE for VFs

 arch/powerpc/include/asm/eeh.h               |    4 +
 arch/powerpc/include/asm/pci-bridge.h        |    2 +
 arch/powerpc/kernel/eeh.c                    |   13 ++
 arch/powerpc/kernel/eeh_cache.c              |    2 +-
 arch/powerpc/kernel/eeh_driver.c             |  105 ++++++++++---
 arch/powerpc/kernel/eeh_pe.c                 |   13 +-
 arch/powerpc/kernel/pci-hotplug.c            |    2 +-
 arch/powerpc/kernel/pci_dn.c                 |   13 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  216 +++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci-ioda.c    |   50 +++++-
 arch/powerpc/platforms/powernv/pci.c         |   33 +++-
 drivers/pci/iov.c                            |   10 +-
 include/linux/pci.h                          |    2 +
 13 files changed, 424 insertions(+), 41 deletions(-)

-- 
1.7.9.5
