Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1CD21A073F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:44:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 20 Mar 2015 15:44:25 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 09CE52CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:44:25 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2K5iGA138011070
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:44:25 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2K5hp7b000640
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:43:51 +1100
Date: Fri, 20 Mar 2015 16:43:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V14 00/21] Enable SRIOV on Power8
Message-ID: <20150320054327.GA8119@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, benh@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 20, 2015 at 11:06:16AM +0800, Wei Yang wrote:

[snip]

>---
>v14:
>   * call ppc_md.pcibios_fixup_sriov() in pcibios_add_device
>   * add more explanation in change log
>   * Following patches have been reordered to the beginning.
>     "EEH refactor to use pci_dn":
>     8ec20d6 powerpc/powernv: Use pci_dn, not device_node, in PCI config accessor
>     a3460fc powerpc/pci: Refactor pci_dn
>     These two patches will be modified to merge with other patches which are
>     under discussion/review in ppc mail list. Some changes may also be made in
>     other patches, which I didn't include them in this series, so that the
>     auto build robot could work on this.

The comment here isn't precise enough and not the things I suggested before.
Those 2 patches have been split into 3 patches (A/B/C). Some other EEH
cleanup/refactor patches depends on A/B and those patches would be merged
before your SRIOV patches to PowerPC tree. C, which I already sent to you,
need to be integrated to your patchset right after the following one:

powerpc/pci: Don't unset PCI resources for VFs

I guess you can move the patches around after checking if Bjorn has further
concerns/comments.

Thanks,
Gavin

>     There may have several changes in powerpc arch, which not effect the pci
>     core. So after this patch set pass the review in pci community, I would
>     rebase this series on ppc brach and send out for comment.
>   * use add_res->min_align as the alignment in reassign_resources_sorted()
>   * some cleanup in Document
>v13:
>   * fix error in pcibios_iov_resource_alignment(), use pdev instead of dev
>   * rename vf_num to num_vfs in pcibios_sriov_enable(),
>     pnv_pci_vf_resource_shift(), pnv_pci_sriov_disable(),
>     pnv_pci_sriov_enable(), pnv_pci_ioda2_setup_dma_pe()
>   * add more explanation in commit "powerpc/pci: Don't unset PCI resources
>     for VFs"
>   * fix IOV BAR in hotplug path as well, and don't fixup an already added
>     device
>   * use roundup_pow_of_two() instead of __roundup_pow_of_two()
>   * this is based on v4.0-rc1
>v12:
>   * remove "align" parameter from pcibios_iov_resource_alignment()
>     default version returns pci_iov_resource_size() instead of the
>     "align" parameter
>   * in powerpc pcibios_iov_resource_alignment(), return
>     pci_iov_resource_size() if there's no ppc_md function pointer
>   * in pci_sriov_resource_alignment(), don't re-read base, since we
>     saved the required alignment when reading it the first time
>   * remove "vf_num" parameter from add_dev_pci_info() and
>     remove_dev_pci_info(); use pci_sriov_get_totalvfs() instead
>   * use dev_warn() instead of pr_warn() when possible
>   * check to be sure IOV BAR is still in range after shifting, change
>     pnv_pci_vf_resource_shift() from void to int
>   * improve sriov_enable() error message
>   * improve SR-IOV BAR sizing message
>   * index IOV resources in conventional style
>   * include preamble patches (refresh offset/stride when updating numVFs,
>     calculate max buses required
>   * restructure pci_iov_max_bus_range() to return value instead of updating
>     internally, rename to virtfn_max_buses()
>   * fix typos & formatting
>   * expand documentation
>v11:
>   * fix some compile warning
>v10:
>   * remove weak function pcibios_iov_resource_size()
>     the VF BAR size is stored in pci_sriov structure and retrieved from
>     pci_iov_resource_size()
>   * Use "Reserve additional" instead of "Expand" to be more acurate in the
>     change log
>   * add log message to show the PF's IOV BAR final size
>   * add pcibios_sriov_enable/disable() weak funcion in sriov_enable/disable()
>     for arch setup before enable VFs. Like the arch could fix up the BDF for
>     VFs, since the change of NumVFs would affect the BDF of VFs.
>   * Add some explanation of PE on Power arch in the documentation
>v9:
>   * make the change log consistent in the terminology
>     PF's IOV BAR -> the SRIOV BAR in PF
>     VF's BAR -> the normal BAR in VF's view
>   * rename all newly introduced function from _sriov_ to _iov_
>   * rename the document to Documentation/powerpc/pci_iov_resource_on_powernv.txt
>   * add the vendor id and device id of the tested devices
>   * change return value from EINVAL to ENOSYS for pci_iov_virtfn_bus() and
>     pci_iov_virtfn_devfn() when it is called on PF or SRIOV is not configured
>   * rebase on 3.18-rc2 and tested
>v8:
>   * use weak funcion pcibios_sriov_resource_size() instead of some flag to
>     retrieve the IOV BAR size.
>   * add a document Documentation/powerpc/pci_resource.txt to explain the
>     design.
>   * make pci_iov_virtfn_bus()/pci_iov_virtfn_devfn() not inline.
>   * extract a function res_to_dev_res(), so that it is more general to get
>     additional size and alignment
>   * fix one contention which is introduced in "powrepc/pci: Refactor pci_dn".
>     the root cause is pci_get_slot() takes pci_bus_sem and leads to dead
>     lock.
>v7:
>   * add IORESOURCE_ARCH flag for IOV BAR on powernv platform.
>   * when IOV BAR has IORESOURCE_ARCH flag, the size is retrieved from
>     hardware directly. If not, calculate as usual.
>   * reorder the patch set, group them by subsystem:
>     PCI, powerpc, powernv
>   * rebase it on 3.16-rc6
>v6:
>   * remove pcibios_enable_sriov()/pcibios_disable_sriov() weak function
>     similar function is moved to
>     pnv_pci_enable_device_hook()/pnv_pci_disable_device_hook(). When PF is
>     enabled, platform will try best to allocate resources for VFs.
>   * remove pcibios_sriov_resource_size weak function
>   * VF BAR size is retrieved from hardware directly in virtfn_add()
>v5:
>   * merge those SRIOV related platform functions in machdep_calls
>     wrap them in one CONFIG_PCI_IOV marco
>   * define IODA_INVALID_M64 to replace (-1)
>     use this value to represent the m64_wins is not used
>   * rename pnv_pci_release_dev_dma() to pnv_pci_ioda2_release_dma_pe()
>     this function is a conterpart to pnv_pci_ioda2_setup_dma_pe()
>   * change dev_info() to dev_dgb() in pnv_pci_ioda_fixup_iov_resources()
>     reduce some log in kernel
>   * release M64 window in pnv_pci_ioda2_release_dma_pe()
>v4:
>   * code format fix, eg. not exceed 80 chars
>   * in commit "ppc/pnv: Add function to deconfig a PE"
>     check the bus has a bridge before print the name
>     remove a PE from its own PELTV
>   * change the function name for sriov resource size/alignment
>   * rebase on 3.16-rc3
>   * VFs will not rely on device node
>     As Grant Likely's comments, kernel should have the ability to handle the
>     lack of device_node gracefully. Gavin restructure the pci_dn, which
>     makes the VF will have pci_dn even when VF's device_node is not provided
>     by firmware.
>   * clean all the patch title to make them comply with one style
>   * fix return value for pci_iov_virtfn_bus/pci_iov_virtfn_devfn
>v3:
>   * change the return type of virtfn_bus/virtfn_devfn to int
>     change the name of these two functions to pci_iov_virtfn_bus/pci_iov_virtfn_devfn
>   * reduce the second parameter or pcibios_sriov_disable()
>   * use data instead of pe in "ppc/pnv: allocate pe->iommu_table dynamically"
>   * rename __pci_sriov_resource_size to pcibios_sriov_resource_size
>   * rename __pci_sriov_resource_alignment to pcibios_sriov_resource_alignment
>v2:
>   * change the return value of virtfn_bus/virtfn_devfn to 0
>   * move some TCE related marco definition to
>     arch/powerpc/platforms/powernv/pci.h
>   * fix the __pci_sriov_resource_alignment on powernv platform
>     During the sizing stage, the IOV BAR is truncated to 0, which will
>     effect the order of allocation. Fix this, so that make sure BAR will be
>     allocated ordered by their alignment.
>v1:
>   * improve the change log for
>     "PCI: Add weak __pci_sriov_resource_size() interface"
>     "PCI: Add weak __pci_sriov_resource_alignment() interface"
>     "PCI: take additional IOV BAR alignment in sizing and assigning"
>   * wrap VF PE code in CONFIG_PCI_IOV
>   * did regression test on P7.
>
>Bjorn Helgaas (2):
>  PCI: Print more info in sriov_enable() error message
>  PCI: Index IOV resources in the conventional style
>
>Gavin Shan (1):
>  powerpc/pci: Refactor pci_dn
>
>Wei Yang (18):
>  powerpc/powernv: Use pci_dn, not device_node, in PCI config accessor
>  PCI: Print PF SR-IOV resource that contains all VF(n) BAR space
>  PCI: Keep individual VF BAR size in struct pci_sriov
>  PCI: Refresh First VF Offset and VF Stride when updating NumVFs
>  PCI: Calculate maximum number of buses required for VFs
>  PCI: Export pci_iov_virtfn_bus() and pci_iov_virtfn_devfn()
>  PCI: Add pcibios_sriov_enable() and pcibios_sriov_disable()
>  PCI: Add pcibios_iov_resource_alignment() interface
>  PCI: Consider additional PF's IOV BAR alignment in sizing and
>    assigning
>  powerpc/pci: Don't unset PCI resources for VFs
>  powerpc/powernv: Allocate struct pnv_ioda_pe iommu_table dynamically
>  powerpc/powernv: Reserve additional space for IOV BAR according to
>    the number of total_pe
>  powerpc/powernv: Implement pcibios_iov_resource_alignment() on
>    powernv
>  powerpc/powernv: Shift VF resource with an offset
>  powerpc/powernv: Reserve additional space for IOV BAR, with
>    m64_per_iov supported
>  powerpc/powernv: Group VF PE when IOV BAR is big on PHB3
>  powerpc/pci: Remove unused struct pci_dn.pcidev field
>  powerpc/pci: Add PCI resource alignment documentation
>
> .../powerpc/pci_iov_resource_on_powernv.txt        |  301 ++++++++
> arch/powerpc/include/asm/device.h                  |    3 +
> arch/powerpc/include/asm/iommu.h                   |    3 +
> arch/powerpc/include/asm/machdep.h                 |    5 +
> arch/powerpc/include/asm/pci-bridge.h              |   24 +-
> arch/powerpc/kernel/pci-common.c                   |   20 +
> arch/powerpc/kernel/pci_dn.c                       |  258 ++++++-
> arch/powerpc/platforms/powernv/eeh-powernv.c       |   14 +-
> arch/powerpc/platforms/powernv/pci-ioda.c          |  766 +++++++++++++++++++-
> arch/powerpc/platforms/powernv/pci.c               |   87 +--
> arch/powerpc/platforms/powernv/pci.h               |   13 +-
> drivers/pci/iov.c                                  |  155 ++--
> drivers/pci/pci.h                                  |    2 +
> drivers/pci/setup-bus.c                            |   95 ++-
> include/linux/pci.h                                |   15 +
> 15 files changed, 1619 insertions(+), 142 deletions(-)
> create mode 100644 Documentation/powerpc/pci_iov_resource_on_powernv.txt
>
>-- 
>1.7.9.5
>
