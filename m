Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79A091A01EC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 17:08:34 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 4 May 2015 17:08:32 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E267E2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 17:08:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4478LA643974786
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 17:08:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4477vYJ031448
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 17:07:57 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: [PATCH V3 0/9] VF EEH on Power8
Date: Mon,  4 May 2015 15:07:29 +0800
Message-Id: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

Wei Yang (9):
  pci/iov: rename and export virtfn_add/virtfn_remove
  powerpc/pci_dn: cache vf_index in pci_dn
  powerpc/pci: remove PCI devices in reverse order
  powerpc/eeh: cache address range just for normal device
  powerpc/eeh: create EEH_PE_VF for VF PE
  powerpc/powernv: create/release eeh_dev for VF
  powerpc/powernv: Support EEH reset for VFs
  powerpc/powernv: Support PCI config restore for VFs
  powerpc/eeh: handle VF PE properly

 arch/powerpc/include/asm/eeh.h               |   10 ++
 arch/powerpc/include/asm/pci-bridge.h        |    2 +
 arch/powerpc/kernel/eeh.c                    |    5 +
 arch/powerpc/kernel/eeh_cache.c              |    2 +-
 arch/powerpc/kernel/eeh_dev.c                |   20 +++
 arch/powerpc/kernel/eeh_driver.c             |  108 +++++++++++---
 arch/powerpc/kernel/eeh_pe.c                 |   15 +-
 arch/powerpc/kernel/pci-hotplug.c            |    2 +-
 arch/powerpc/kernel/pci_dn.c                 |   12 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  200 +++++++++++++++++++++++++-
 drivers/pci/iov.c                            |   10 +-
 include/linux/pci.h                          |    2 +
 12 files changed, 352 insertions(+), 36 deletions(-)

-- 
1.7.9.5
