Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B2D7F1A0143
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 16:05:43 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so33000411pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2015 21:05:42 -0800 (PST)
Subject: Re: [PATCH V12 0/9] VF EEH on Power8
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au
References: <1446607732-4166-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56399221.30506@ozlabs.ru>
Date: Wed, 4 Nov 2015 16:05:37 +1100
MIME-Version: 1.0
In-Reply-To: <1446607732-4166-1-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2015 02:28 PM, Wei Yang wrote:
> This patchset enables EEH on SRIOV VFs. The general idea is to create proper
> VF edev and VF PE and handle them properly.
>
> Different from the Bus PE, VF PE just contain one VF. This introduces the
> difference of EEH error handling on a VF PE. Generally, it has several
> differences.
>
> First, the VF's removal and re-enumerate rely on its PF. VF has a tight
> relationship between its PF. This is not proper to enumerate a VF by usual
> scan procedure. That's why virtfn_add/virtfn_remove are exported in this patch
> set.
>
> Second, the reset/restore of a VF is done in kernel space. FW is not aware of
> the VF, this means the usual reset function done in FW will not work. One of
> the patch will imitate the reset/restore function in kernel space.
>
> Third, the VF may be removed during the PF's error_detected function. In this
> case, the original error_detected->slot_reset->resume sequence is not proper
> to those removed VFs, since they are re-created by PF in a fresh state. A flag
> in eeh_dev is introduce to mark the eeh_dev is in error state. By doing so, we
> track whether this device needs to be reset or not.
>
> This has been tested both on host and in guest on Power8 with latest kernel
> version.

With the small issues in 9/9 fixed,

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


>
> v12:
>     * rebased on v4.3
>     * Rephrase some commit log to make it more clear and specific
>     * move vf_index assignment in CONFIG_PPC_POWERNV
>     * merge "Cache VF index in pci_dn" with "Support error recovery for VF PE"
>     * check the return value after eeh_dev_init() for VF
>     * initialize the parameter before pass to read_config()
>     * make pnv_pci_fixup_vf_mps() a dedicated patch, which fixup and store mps
>       value in pci_dn
> v11:
>     * move vf_index assignment in marco CONFIG_PPC_POWERNV
>     * merge Patch "Cache VF index in pci_dn" into Patch "Support error recovery
>       for VF PE"
> v10:
>     * rebased on v4.2
>     * delete the last patch "powerpc/powernv: compound PE for VFs" since after
>       redesign of SRIOV, there is no compound PE for VFs now.
>     * add two patches which fix problems found during tests
>       powerpc/eeh: Support error recovery for VF PE
>       powerpc/eeh: Handle hot removed VF when PF is EEH aware
> v9:
>     * split pcibios_bus_add_device() into a separate patch
>     * Bjorn acked the PCI part and agreed this patch set to be merged from ppc
>       tree
>     * rebased on mpe/linux.git next branch
> v8:
>     * fix on checking the return value of pnv_eeh_do_flr()
>     * introduced a weak function pcibios_bus_add_device() to create PE for VFs
> v7:
>     * fix compile error when PCI_IOV is not set
> v6:
>     * code / commit log refactor by Gavin
> v5:
>     * remove the compound field, iterate on Master VF PE instead
>     * some code refine on PCI config restore and reset on VF
>       the wait time for assert and deassert
>       PCI device address format
>       check on edev->pcie_cap and edev->aer_cap before access them
> v4:
>     * refine the change logs, comment and code style
>     * change pnv_pci_fixup_vf_eeh() to pnv_eeh_vf_final_fixup() and remove the
>       CONFIG_PCI_IOV macro
>     * reorder patch 5/6 to make the logic more reasonable
>     * remove remove_dev_pci_data()
>     * remove the EEH_DEV_VF flag, use edev->physfn to identify a VF EEH DEV and
>       remove related CONFIG_PCI_IOV macro
>     * add the option for VF reset
>     * fix the pnv_eeh_cfg_blocked() logic
>     * replace pnv_pci_cfg_{read,write} with eeh_ops->{read,write}_config in
>       pnv_eeh_vf_restore_config()
>     * rename pnv_eeh_vf_restore_config() to pnv_eeh_restore_vf_config()
>     * rename pnv_pci_fixup_vf_caps() to pnv_pci_vf_header_fixup() and move it
>       to arch/powerpc/platforms/powernv/pci.c
>     * add a field compound in pnv_ioda_pe to link compound PEs
>     * handle compound PE for VF PEs
> v3:
>     * add back vf_index in pci_dn to track the VF's index
>     * rename ppdev in eeh_dev to physfn for consistency
>     * move edev->physfn assignment before dev->dev.archdata.edev is set
>     * move pnv_pci_fixup_vf_eeh() and pnv_pci_fixup_vf_caps() to eeh-powernv.c
>     * more clear and detail in commit log and comment in code
>     * merge eeh_rmv_virt_device() with eeh_rmv_device()
>     * move the cfg_blocked check logic from pnv_eeh_read/write_config() to
>       pnv_eeh_cfg_blocked()
>     * move the vf reset/restore logic into its own patch, two patches are
>       created.
>       powerpc/powernv: Support PCI config restore for VFs
>       powerpc/powernv: Support EEH reset for VFs
>     * simplify the vf reset logic
> v2:
>     * add prefix pci_iov_ to virtfn_add/virtfn_remove
>     * use EEH_DEV_VF as a flag for a VF's eeh_dev
>     * use eeh_dev instead of edev in change log
>     * remove vf_index in eeh_dev, calculate it from pdn->busno and devfn
>     * do eeh_add_device_late() and eeh_sysfs_add_device() both after pci_dev is
>       well initialized
>     * do FLR to reset a VF PE
>     * imitate the restore function in FW for VF
>     * remove the reverse order patch, since it is still under discussion
>
> Wei Yang (9):
>    PCI/IOV: Rename and export virtfn_add/virtfn_remove
>    PCI: Add pcibios_bus_add_device() weak function
>    powerpc/pci: Remove VFs prior to PF
>    powerpc/eeh: Cache only BARs, not windows or IOV BARs
>    powerpc/powernv: EEH device for VF
>    powerpc/eeh: Create PE for VFs
>    powerpc/powernv: Support EEH reset for VF PE
>    powerpc/powernv: Support PCI config restore for VFs
>    powerpc/eeh: Support error recovery for VF PE
>
>   arch/powerpc/include/asm/eeh.h               |  10 ++
>   arch/powerpc/include/asm/pci-bridge.h        |   2 +
>   arch/powerpc/kernel/eeh.c                    |  17 ++-
>   arch/powerpc/kernel/eeh_cache.c              |  11 +-
>   arch/powerpc/kernel/eeh_dev.c                |   1 +
>   arch/powerpc/kernel/eeh_driver.c             | 127 ++++++++++++----
>   arch/powerpc/kernel/eeh_pe.c                 |  13 +-
>   arch/powerpc/kernel/pci-hotplug.c            |   2 +-
>   arch/powerpc/kernel/pci_dn.c                 |  17 ++-
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 219 ++++++++++++++++++++++++++-
>   arch/powerpc/platforms/powernv/pci.c         |  18 +++
>   drivers/pci/bus.c                            |   3 +
>   drivers/pci/iov.c                            |  10 +-
>   include/linux/pci.h                          |   8 +
>   14 files changed, 411 insertions(+), 47 deletions(-)
>


-- 
Alexey
