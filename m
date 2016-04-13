Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlG4Z2DBrzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 17:43:10 +1000 (AEST)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 13 Apr 2016 13:13:05 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3D7hGwH28246078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 13:13:18 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3D7gqRB015331
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 13:12:56 +0530
Date: Wed, 13 Apr 2016 17:42:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 00/45] powerpc/powernv: PCI hotplug support
Message-ID: <20160413074236.GA28853@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <570DF50F.6010805@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570DF50F.6010805@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2016 at 05:28:15PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:43 PM, Gavin Shan wrote:
>>This series of patches rebases on powerpc/next branch, plus below additional
>>patches:
>>
>>    <This series of patches>
>>    <Followup 3 patches from Gavin on SRIOV EEH, which aren't posted>
>>    https://patchwork.ozlabs.org/patch/581315/	(PATCH[1/9] Richard's SRIOV EEH)
>>    https://patchwork.ozlabs.org/patch/582639/	(PATCH[1/1] Gavin's EEH fix)
>>    https://patchwork.ozlabs.org/patch/582093/	(PATCH[1/1] Gavin's EEH fix)
>>    https://patchwork.ozlabs.org/patch/580626/	(PATCH[1/4] Gavin's PCI fix)
>>    https://patchwork.ozlabs.org/patch/580153/	(PATCH[1/1] Andrew's EEH minor fix)
>>    https://patchwork.ozlabs.org/patch/566827/	(PATCH[1/1] Russell's P5IOC2 removal)
>>    https://patchwork.ozlabs.org/patch/534154/	(PATCH[1/7] Richard's SRIOV rework)
>>    commit 388f7b1 ("Linux 4.5-rc3")
>>
>>The series of patches intend to support PCI slot for PowerPC PowerNV platform,
>>which is running on top of skiboot firmware. The patchset requires corresponding
>>changes from skiboot firmware, which is sent to skiboot@lists.ozlabs.org
>>for review. The PCI slots are exposed by skiboot with device node properties,
>>and kernel utilizes those properties to populated PCI slots accordingly.
>>
>>The original PCI infrastructure on PowerNV platform can't support hotplug
>>because the PE is assigned during PHB fixup time, which is called for once
>>during system boot time. For this, the PCI infrastructure on PowerNV platform
>>has been reworked for a lot. After that, the PE and its corresponding resources
>>(IODT, M32DT, M64 segments, DMA32 and bypass window) are assigned upon updating
>>PCI bridge's resources, which might decide PE# assigned to the PE (e.g. M64
>>resources, on P8 strictly speaking). Each PE will maintain a reference count,
>>which is (number of child PCI devices + 1). That indicates when last child PCI
>>device leaves the PE, the PE and its included resources will be relased and put
>>back into free pool again. With this design, the PE will be released when EEH PE
>>is released. PATCH[1 - 23] are related to this part.
>>
>> From skiboot perspective, PCI slot is providing (hot/fundamental/complete)
>>resets to EEH. The kernel gets to know if skiboot supports various reset on one
>>particular PCI slot through device-tree node. If it does, EEH will utilize the
>>functionality provided by skiboot. Besides, the device-tree nodes have to change
>>in order to support PCI hotplug. For example, when one PCI adapter inserted to
>>one slot, its device-tree node should be added to the system dynamically. Conversely,
>>the device-tree node should be removed from the system when the PCI adapter is going
>>to be offline. Since pci_dn and eeh_dev have same life cyle as PCI device nodes,
>>they should be added/removed accordingly during PCI hotplug. PATCH[24 - 39] are
>>doing the related work.
>>
>>The OF driver is changed to support unflattening FDT blob for sub-stree, which
>>is covered by PATCH[40 - 44].
>>
>>The last one, PATCH[45], is the standalone PCI hotplug driver for PowerPC PowerNV
>>platform.
>>
>>=======
>>Testing
>>=======
>>1. Unplug adapters behind non-empty slot, then plug them.
>>
>>    1.1 Check status
>>    # cat /sys/bus/pci/slots/C10/address
>>    0003:09:00
>>    # cat /sys/bus/pci/slots/C10/adapter
>>    1
>>    # cat /sys/bus/pci/slots/C10/power
>>    1
>>    # lspci
>>    0003:09:00.0 Ethernet controller: \
>>    Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
>>    0003:09:00.1 Ethernet controller: \
>>    Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
>>    0003:09:00.2 Ethernet controller: \
>>    Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
>>    0003:09:00.3 Ethernet controller: \
>>    Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
>>    # lspci -t
>>    # lspci -t
>>    -+-[0003:00]---00.0-[01-13]----00.0-[02-13]--+-01.0-[03]----00.0
>>     |                                           +-08.0-[04-08]--
>>     |                                           +-09.0-[09]--+-00.0
>>     |                                           |            +-00.1
>>     |                                           |            +-00.2
>>     |                                           |            \-00.3
>>     |                                           +-10.0-[0a-0e]--
>>     |                                           \-11.0-[0f-13]--
>>
>>    1.2 Unplug adapter 0003:09.00.x
>>    # echo 0 > /sys/bus/pci/slots/C10/power
>>    # lspci -t
>>    -+-[0003:00]---00.0-[01-13]----00.0-[02-13]--+-01.0-[03]----00.0
>>     |                                           +-08.0-[04-08]--
>>     |                                           +-09.0-[09]--
>>     |                                           +-10.0-[0a-0e]--
>>     |                                           \-11.0-[0f-13]--
>>
>>    1.3 Plug adapter 0003:09.00.x
>>    # echo 1 > /sys/bus/pci/slots/C10/power
>
>
>Do I understand correctly that the adapter was not physically moved in/out of
>the slot between 1.2 and 1.3?
>

Correct.

>
>
>>    # lspci -t
>>    -+-[0003:00]---00.0-[01-13]----00.0-[02-13]--+-01.0-[03]----00.0
>>     |                                           +-08.0-[04-08]--
>>     |                                           +-09.0-[09]--+-00.0
>>     |                                           |            +-00.1
>>     |                                           |            +-00.2
>>     |                                           |            \-00.3
>>     |                                           +-10.0-[0a-0e]--
>>     |                                           \-11.0-[0f-13]--
>>
>>
>>    1.4 Inject EEH error to adapter 0003:09:00.x, which is recovered.
>
>I am confused - why is this needed to test hotplug?
>

Without the series, the EEH reset is always done by kenrel. With the
series applied, the EEH reset could be done in skiboot. That's the
major change introduced by the series from EEH's perspective. Also,
the EEH code was touched.

>>    # cat /sys/bus/pci/devices/0003:09:00.0/eeh_pe_config_addr
>>    0x1
>>    # echo 1:0:4:0:0 > /sys/kernel/debug/powerpc/PCI0003/err_injct
>>    # lspci -ns 0003:09:00.0
>>    # dmesg | grep EEH
>>    EEH: Frozen PHB#3-PE#1 detected
>>    EEH: PE location: U78C9.001.WZS00CF-P1-C10, PHB location: N/A
>>    EEH: Detected PCI bus error on PHB#3-PE#1
>>    EEH: This PCI device has failed 1 times in the last hour
>>    EEH: Notify device drivers to shutdown
>>    EEH: Collect temporary log
>>    EEH: Reset without hotplug activity
>>    EEH: Notify device drivers the completion of reset
>>    EEH: Notify device driver to resume
>>
>>2. Plug adapter and then unplug it. This requires hack in skiboot
>>    to skip probing the adapters behind the target (C12 in the
>>    testing) for once.
>>
>>    2.1 Check status
>>    # cat /sys/bus/pci/slots/C12/address
>>    0001:06
>>    # cat /sys/bus/pci/slots/C12/power
>>    0
>>    # cat /sys/bus/pci/slots/C12/adapter
>>    1
>>    # lspci -t
>>    +-[0001:00]---00.0-[01-0a]----00.0-[02-0a]--+-01.0-[03-04]----00.0-[04]----00.0
>>                                                +-08.0-[05]----00.0
>>                                                \-09.0-[06-0a]--
>>
>>    2.2 Plug adapter 0001:06:00.x
>>    # echo 1 > /sys/bus/pci/slots/C12/power
>>    # lspci -t
>>    +-[0001:00]---00.0-[01-0a]----00.0-[02-0a]--+-01.0-[03-04]----00.0-[04]----00.0
>>                                                +-08.0-[05]----00.0
>>                                                \-09.0-[06-0a]--+-00.0
>>                                                                \-00.1
>>    # lspci
>>    0001:06:00.0 Ethernet controller: \
>>    Broadcom Corporation NetXtreme II BCM57810 10 Gigabit Ethernet (rev 10)
>>    0001:06:00.1 Ethernet controller: \
>>    Broadcom Corporation NetXtreme II BCM57810 10 Gigabit Ethernet (rev 10)
>>
>>    2.3 Inject EEH error to adapter 0001:06:00.x, which is recovered
>>    # cat /sys/bus/pci/devices/0001:06:00.0/eeh_pe_config_addr
>>    0x2
>>    # echo 2:0:4:0:0 > /sys/kernel/debug/powerpc/PCI0001/err_injct
>>    # dmesg | grep EEH
>>    EEH: Frozen PHB#1-PE#2 detected
>>    EEH: PE location: U78C9.001.WZS00CF-P1-C12, PHB location: N/A
>>    EEH: Detected PCI bus error on PHB#1-PE#2
>>    EEH: This PCI device has failed 1 times in the last hour
>>    EEH: Notify device drivers to shutdown
>>    EEH: Collect temporary log
>>    EEH: Reset without hotplug activity
>>    EEH: Notify device drivers the completion of reset
>>    EEH: Notify device driver to resume
>>
>>    2.4 Unplug adapter 0001:06:00.x
>>    # echo 0 > /sys/bus/pci/slots/C12/power
>>    # lspci -t
>>    +-[0001:00]---00.0-[01-0a]----00.0-[02-0a]--+-01.0-[03-04]----00.0-[04]----00.0
>>                                                +-08.0-[05]----00.0
>>                                                \-09.0-[06-0a]--
>>
>>=========
>>Changelog
>>=========
>>v8:
>>    * Rebased to linux-powerpc next branch.
>>    * Resolve comments from Alexey and Daniel on PCI part
>>    * Resolve comments from Rob on fdt.c
>>    * Retested (refer to the "Testing section")
>>v7:
>>    * Reworked revision to some extent.
>>    * Rebased to powerpc/next repository.
>>    * Reorder/split/merge/drop according - Alexey.
>>    * Defined macros and use array to track IO/M32/M64/DMA32 segments - Alexey.
>>    * Merged 3 files to one for the hotplug driver - Alexey.
>>    * As part of OPAL API, defined macros for PCI slot power state, hotplug
>>      message type. Defined macros for PCI slot power confirmed state in
>>      hotplug driver.
>>    * Misc comments from Alexey.
>>    * Reworked unflatten_dt_node() to avoid recursive function calls.
>>    * Use EXPORT_SYMBOL_GPL() and document function's input/output - Rob/Frank.
>>v6:
>>    * Patch reorder, split, squash - Alexey.
>>    * Minor coding style - Alexey.
>>    * Better function names for pcibios_{add,remove}_pci_devices - Bjorn
>>    * Replace pr_warn() with dev_warn() in PowerNV hotplug driver - Bjorn
>>    * Concurrent depth as parameter passed to __unflatten_dt_node() - Grant / Alexey
>>    * Replace overlay with of_changeset - Grant
>>v5:
>>    * Rebased to 4.1.rc6 and some unmerged patches as below:
>>      Alexey's DDW patchset (v11);
>>      Gavin's EEH error injection support (in mpe's next branch);
>>      Richard's EEH cleanup patches (in mpe's next branch);
>>      Richard's EEH support for VF (v7);
>>      Gavin's misc EEH fixes for 4.2;
>>    * The revision bases on skiboot corresponding patches (v7):
>>      https://patchwork.ozlabs.org/patch/480437/
>>    * Utilize OF overlay to update device-tree with help of newly introduced
>>      OPAL API opal_get_overlay_dt().
>>    * Split patches for easy review according to aik's comments.
>>    * Fix coding style from checkpatchc.pl as pointed by aik.
>>    * Code cleanup and misc fixup according to aik's input.
>>v4:
>>    * Rebased to 4.1.RC1
>>    * Added API to unflatten FDT blob to device node sub-tree, which is attached
>>      the indicated parent device node. The original mechanism based on formatted
>>      string stream has been dropped.
>>    * The PATCH[v3 09/21] ("powerpc/eeh: Delay probing EEH device during hotplug")
>>      was picked up sent to linux-ppc@ separately for review as Richard's "VF EEH
>>      Support" depends on that.
>>v3:
>>    * Rebased to 4.1.RC0
>>    * PowerNV PCI infrasturcture is total refactored in order to support PCI
>>      hotplug. The PowerNV hotplug driver is also reworked a lot because of
>>      the changes in skiboot in order to support PCI hotplug.
>>
>>Gavin Shan (45):
>>   PCI: Add pcibios_setup_bridge()
>>   powerpc/pci: Override pcibios_setup_bridge()
>>   powerpc/pci: Cleanup on struct pci_controller_ops
>>   powerpc/powernv: Cleanup on pci_controller_ops instances
>>   powerpc/powernv: Drop phb->bdfn_to_pe()
>>   powerpc/powernv: Reorder fields in struct pnv_phb
>>   powerpc/powernv: Rename PE# fields in struct pnv_phb
>>   powerpc/powernv: Fix initial IO and M32 segmap
>>   powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
>>   powerpc/powernv: IO and M32 mapping based on PCI device resources
>>   powerpc/powernv: Track M64 segment consumption
>>   powerpc/powernv: Rename M64 related functions
>>   powerpc/powernv/ioda1: M64 support on P7IOC
>>   powerpc/powernv/ioda1: Rename pnv_pci_ioda_setup_dma_pe()
>>   powerpc/powernv/ioda1: Introduce PNV_IODA1_DMA32_SEGSIZE
>>   powerpc/powernv: Remove DMA32 PE list
>>   powerpc/powernv/ioda1: Improve DMA32 segment track
>>   powerpc/powernv: Increase PE# capacity
>>   powerpc/powernv: Use PE instead of number during setup and release
>>   powerpc/powernv: Allocate PE# in reverse order
>>   powerpc/powernv: Create PEs at PCI hot plugging time
>>   powerpc/powernv/ioda1: Support releasing IODA1 TCE table
>>   powerpc/powernv: Dynamically release PEs
>>   powerpc/pci: Rename pcibios_{add,remove}_pci_devices()
>>   powerpc/pci: Rename pcibios_find_pci_bus()
>>   powerpc/pci: Move pci_find_bus_by_node() around
>>   powerpc/pci: Export pci_add_device_node_info()
>>   powerpc/pci: Introduce pci_remove_device_node_info()
>>   powerpc/pci: Export pci_traverse_device_nodes()
>>   powerpc/pci: Delay populating pdn
>>   powerpc/pci: Don't scan empty slot
>>   powerpc/pci: Update bridge windows on PCI plug
>>   powerpc/powernv: Simplify pnv_eeh_reset()
>>   powerpc/powernv: Exclude root bus in pnv_pci_reset_secondary_bus()
>>   powerpc/powernv: Fundamental reset in pnv_pci_reset_secondary_bus()
>>   powerpc/powernv: Support PCI slot ID
>>   powerpc/powernv: Use firmware PCI slot reset infrastructure
>>   powerpc/powernv: Functions to get/set PCI slot status
>>   powerpc/powernv: Select OF_DYNAMIC
>>   drivers/of: Split unflatten_dt_node()
>>   drivers/of: Avoid recursively calling unflatten_dt_node()
>>   drivers/of: Rename unflatten_dt_node()
>>   drivers/of: Specify parent node in of_fdt_unflatten_tree()
>>   drivers/of: Return allocated memory from of_fdt_unflatten_tree()
>>   PCI/hotplug: PowerPC PowerNV PCI hotplug driver
>>
>>  arch/powerpc/include/asm/eeh.h                 |    2 +-
>>  arch/powerpc/include/asm/opal-api.h            |   17 +-
>>  arch/powerpc/include/asm/opal.h                |    8 +-
>>  arch/powerpc/include/asm/pci-bridge.h          |   25 +-
>>  arch/powerpc/include/asm/pnv-pci.h             |    7 +
>>  arch/powerpc/include/asm/ppc-pci.h             |    8 +-
>>  arch/powerpc/kernel/eeh_dev.c                  |   17 +-
>>  arch/powerpc/kernel/eeh_driver.c               |   12 +-
>>  arch/powerpc/kernel/pci-common.c               |   16 +-
>>  arch/powerpc/kernel/pci-hotplug.c              |   47 +-
>>  arch/powerpc/kernel/pci_dn.c                   |   89 +-
>>  arch/powerpc/platforms/maple/pci.c             |   34 +-
>>  arch/powerpc/platforms/pasemi/pci.c            |    3 -
>>  arch/powerpc/platforms/powermac/pci.c          |   38 +-
>>  arch/powerpc/platforms/powernv/Kconfig         |    1 +
>>  arch/powerpc/platforms/powernv/eeh-powernv.c   |  179 ++--
>>  arch/powerpc/platforms/powernv/opal-wrappers.S |    4 +
>>  arch/powerpc/platforms/powernv/pci-ioda.c      | 1243 +++++++++++++++---------
>>  arch/powerpc/platforms/powernv/pci.c           |   92 +-
>>  arch/powerpc/platforms/powernv/pci.h           |   60 +-
>>  arch/powerpc/platforms/pseries/msi.c           |    4 +-
>>  arch/powerpc/platforms/pseries/pci_dlpar.c     |   32 -
>>  arch/powerpc/platforms/pseries/setup.c         |    8 +-
>>  drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c   |    2 +-
>>  drivers/of/fdt.c                               |  372 ++++---
>>  drivers/of/unittest.c                          |    2 +-
>>  drivers/pci/hotplug/Kconfig                    |   12 +
>>  drivers/pci/hotplug/Makefile                   |    3 +
>>  drivers/pci/hotplug/pnv_php.c                  |  870 +++++++++++++++++
>>  drivers/pci/hotplug/rpadlpar_core.c            |    8 +-
>>  drivers/pci/hotplug/rpaphp_core.c              |    4 +-
>>  drivers/pci/hotplug/rpaphp_pci.c               |    4 +-
>>  drivers/pci/setup-bus.c                        |    5 +
>>  include/linux/of_fdt.h                         |    5 +-
>>  include/linux/pci.h                            |    1 +
>>  35 files changed, 2360 insertions(+), 874 deletions(-)
>>  create mode 100644 drivers/pci/hotplug/pnv_php.c
>>
>
>
>-- 
>Alexey
>
