Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FBE61A115F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:59:42 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 09:59:42 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BAE663578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:59:39 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u23NxV7B14680304
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:59:39 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u23Nx7RX009984
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:59:07 +1100
Date: Fri, 4 Mar 2016 10:58:42 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru, ruscur@russell.cc
Subject: Re: [PATCH v14 0/9] EEH Support for SRIOV VFs
Message-ID: <20160303235842.GA7162@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 10, 2016 at 05:02:48PM +1100, Gavin Shan wrote:

In this series, there're some issues on attempt to recover errors on
pass-throu VFs. Updated series (v15) with more patches sent to address
the issues:

So please ignore this series and look at v15.

Thanks,
Gavin

>This applies to linux-powerpc-next and additional unmerged patches:
>
>[v2,1/4] powerpc/eeh: Fix stale cached primary bus
>powerpc/eeh: fix incorrect function name in comment
>[V2] powerpc/powernv: Remove support for p5ioc2
>[V7,1/6] powerpc/powernv: don't enable SRIOV when VF BAR has non 64bit-prefetchable BAR
>92e963f Linux 4.5-rc1 - Linux powerpc next branch
>
>This patchset enables EEH on SRIOV VFs. The general idea is to create proper
>VF edev and VF PE and handle them properly.
>
>Different from the Bus PE, VF PE just contain one VF. This introduces the
>difference of EEH error handling on a VF PE. Generally, it has several
>differences.
>
>First, the VF's removal and re-enumerate rely on its PF. VF has a tight
>relationship between its PF. This is not proper to enumerate a VF by usual
>scan procedure. That's why virtfn_add/virtfn_remove are exported in this patch
>set.
>
>Second, the reset/restore of a VF is done in kernel space. FW is not aware of
>the VF, this means the usual reset function done in FW will not work. One of
>the patch will imitate the reset/restore function in kernel space.
>
>Third, the VF may be removed during the PF's error_detected function. In this
>case, the original error_detected->slot_reset->resume sequence is not proper
>to those removed VFs, since they are re-created by PF in a fresh state. A flag
>in eeh_dev is introduce to mark the eeh_dev is in error state. By doing so, we
>track whether this device needs to be reset or not.
>
>This has been tested both on host and in guest on Power8 with latest kernel
>version.
>
>Changelog
>=========
>v14:
>   * Rebased to linux-powerpc-next branch, plus additional patches related to
>     powerpc/pci and powerpc/eeh subsystems.
>   * Minor code changes
>   * Fix build error on pSeries reported by mpe
>v13:
>   * move eeh_rmv_data{} to eeh_driver.c
>v12:
>   * Rephrase some commit log to make it more clear and specific
>   * move vf_index assignment in CONFIG_PPC_POWERNV
>   * merge "Cache VF index in pci_dn" with "Support error recovery for VF PE"
>   * check the return value after eeh_dev_init() for VF
>   * initialize the parameter before pass to read_config()
>   * make pnv_pci_fixup_vf_mps() a dedicated patch, which fixup and store mps
>     value in pci_dn
>v11:
>   * move vf_index assignment in marco CONFIG_PPC_POWERNV
>   * merge Patch "Cache VF index in pci_dn" into Patch "Support error recovery
>     for VF PE"
>v10:
>   * rebased on v4.2
>   * delete the last patch "powerpc/powernv: compound PE for VFs" since after
>     redesign of SRIOV, there is no compound PE for VFs now.
>   * add two patches which fix problems found during tests
>     powerpc/eeh: Support error recovery for VF PE
>     powerpc/eeh: Handle hot removed VF when PF is EEH aware
>v9:
>   * split pcibios_bus_add_device() into a separate patch
>   * Bjorn acked the PCI part and agreed this patch set to be merged from ppc
>     tree
>   * rebased on mpe/linux.git next branch
>v8:
>   * fix on checking the return value of pnv_eeh_do_flr()
>   * introduced a weak function pcibios_bus_add_device() to create PE for VFs
>v7:
>   * fix compile error when PCI_IOV is not set
>v6:
>   * code / commit log refactor by Gavin
>v5:
>   * remove the compound field, iterate on Master VF PE instead
>   * some code refine on PCI config restore and reset on VF
>     the wait time for assert and deassert
>     PCI device address format
>     check on edev->pcie_cap and edev->aer_cap before access them
>v4:
>   * refine the change logs, comment and code style
>   * change pnv_pci_fixup_vf_eeh() to pnv_eeh_vf_final_fixup() and remove the
>     CONFIG_PCI_IOV macro
>   * reorder patch 5/6 to make the logic more reasonable
>   * remove remove_dev_pci_data()
>   * remove the EEH_DEV_VF flag, use edev->physfn to identify a VF EEH DEV and
>     remove related CONFIG_PCI_IOV macro
>   * add the option for VF reset
>   * fix the pnv_eeh_cfg_blocked() logic
>   * replace pnv_pci_cfg_{read,write} with eeh_ops->{read,write}_config in
>     pnv_eeh_vf_restore_config()
>   * rename pnv_eeh_vf_restore_config() to pnv_eeh_restore_vf_config()
>   * rename pnv_pci_fixup_vf_caps() to pnv_pci_vf_header_fixup() and move it
>     to arch/powerpc/platforms/powernv/pci.c
>   * add a field compound in pnv_ioda_pe to link compound PEs
>   * handle compound PE for VF PEs
>v3:
>   * add back vf_index in pci_dn to track the VF's index
>   * rename ppdev in eeh_dev to physfn for consistency
>   * move edev->physfn assignment before dev->dev.archdata.edev is set
>   * move pnv_pci_fixup_vf_eeh() and pnv_pci_fixup_vf_caps() to eeh-powernv.c
>   * more clear and detail in commit log and comment in code
>   * merge eeh_rmv_virt_device() with eeh_rmv_device()
>   * move the cfg_blocked check logic from pnv_eeh_read/write_config() to
>     pnv_eeh_cfg_blocked()
>   * move the vf reset/restore logic into its own patch, two patches are
>     created.
>     powerpc/powernv: Support PCI config restore for VFs
>     powerpc/powernv: Support EEH reset for VFs
>   * simplify the vf reset logic
>v2:
>   * add prefix pci_iov_ to virtfn_add/virtfn_remove
>   * use EEH_DEV_VF as a flag for a VF's eeh_dev
>   * use eeh_dev instead of edev in change log
>   * remove vf_index in eeh_dev, calculate it from pdn->busno and devfn
>   * do eeh_add_device_late() and eeh_sysfs_add_device() both after pci_dev is
>     well initialized
>   * do FLR to reset a VF PE
>   * imitate the restore function in FW for VF
>   * remove the reverse order patch, since it is still under discussion
>
>Wei Yang (9):
>  PCI/IOV: Rename and export virtfn_{add, remove}
>  PCI: Add pcibios_bus_add_device() weak function
>  powerpc/pci: Remove VFs prior to PF
>  powerpc/eeh: Cache normal BARs, not windows or IOV BARs
>  powerpc/eeh: EEH device for VF
>  powerpc/eeh: Create PE for VFs
>  powerpc/powernv: Support EEH reset for VF PE
>  powerpc/powernv: Support PCI config restore for VFs
>  powerpc/eeh: powerpc/eeh: Support error recovery for VF PE
>
> arch/powerpc/include/asm/eeh.h               |   5 +
> arch/powerpc/include/asm/pci-bridge.h        |   2 +
> arch/powerpc/kernel/eeh.c                    |  17 +-
> arch/powerpc/kernel/eeh_cache.c              |  11 +-
> arch/powerpc/kernel/eeh_dev.c                |   1 +
> arch/powerpc/kernel/eeh_driver.c             | 137 ++++++++++++---
> arch/powerpc/kernel/eeh_pe.c                 |  10 +-
> arch/powerpc/kernel/pci-hotplug.c            |   2 +-
> arch/powerpc/kernel/pci_dn.c                 |  19 ++-
> arch/powerpc/platforms/powernv/eeh-powernv.c | 238 ++++++++++++++++++++++++++-
> drivers/pci/bus.c                            |   3 +
> drivers/pci/iov.c                            |  10 +-
> include/linux/pci.h                          |   9 +
> 13 files changed, 417 insertions(+), 47 deletions(-)
>
>-- 
>2.1.0
>
