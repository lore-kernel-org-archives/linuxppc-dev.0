Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 883BA1A050C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 10:12:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 19 Nov 2014 09:12:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C88EF2CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 10:12:24 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAINBrwk39321812
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 10:12:02 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAINBp1u017156
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 10:11:52 +1100
Date: Wed, 19 Nov 2014 10:11:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V9 00/18] Enable SRIOV on PowerNV
Message-ID: <20141118231124.GA6212@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

On Sun, Nov 02, 2014 at 11:41:16PM +0800, Wei Yang wrote:

Hello Bjorn,

Did you have available bandwidth to review it? :-)

Thanks,
Gavin

>This patchset enables the SRIOV on POWER8.
>
>The gerneral idea is put each VF into one individual PE and allocate required
>resources like MMIO/DMA/MSI. The major difficulty comes from the MMIO
>allocation and adjustment for PF's IOV BAR.
>
>On P8, we use M64BT to cover a PF's IOV BAR, which could make an individual VF
>sit in its own PE. This gives more flexiblity, while at the mean time it
>brings on some restrictions on the PF's IOV BAR size and alignment.
>
>To achieve this effect, we need to do some hack on pci devices's resources.
>1. Expand the IOV BAR properly.
>   Done by pnv_pci_ioda_fixup_iov_resources().
>2. Shift the IOV BAR properly.
>   Done by pnv_pci_vf_resource_shift().
>3. IOV BAR alignment is calculated by arch dependent function instead of an
>   individual VF BAR size.
>   Done by pnv_pcibios_sriov_resource_alignment().
>4. Take the IOV BAR alignment into consideration in the sizing and assigning.
>   This is achieved by commit: "PCI: Take additional IOV BAR alignment in
>   sizing and assigning"
>
>Test Environment:
>       The SRIOV device tested is Emulex Lancer(10df:e220) and
>       Mellanox ConnectX-3(15b3:1003) on POWER8.
>
>Examples on pass through a VF to guest through vfio:
>	1. unbind the original driver and bind to vfio-pci driver
>	   echo 0000:06:0d.0 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
>	   echo  1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
>	   Note: this should be done for each device in the same iommu_group
>	2. Start qemu and pass device through vfio
>	   /home/ywywyang/git/qemu-impreza/ppc64-softmmu/qemu-system-ppc64 \
>		   -M pseries -m 2048 -enable-kvm -nographic \
>		   -drive file=/home/ywywyang/kvm/fc19.img \
>		   -monitor telnet:localhost:5435,server,nowait -boot cd \
>		   -device "spapr-pci-vfio-host-bridge,id=CXGB3,iommu=26,index=6"
>
>Verify this is the exact VF response:
>	1. ping from a machine in the same subnet(the broadcast domain)
>	2. run arp -n on this machine
>	   9.115.251.20             ether   00:00:c9:df:ed:bf   C eth0
>	3. ifconfig in the guest
>	   # ifconfig eth1
>	   eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>	        inet 9.115.251.20  netmask 255.255.255.0  broadcast 9.115.251.255
>		inet6 fe80::200:c9ff:fedf:edbf  prefixlen 64  scopeid 0x20<link>
>	        ether 00:00:c9:df:ed:bf  txqueuelen 1000 (Ethernet)
>	        RX packets 175  bytes 13278 (12.9 KiB)
>	        RX errors 0  dropped 0  overruns 0  frame 0
>		TX packets 58  bytes 9276 (9.0 KiB)
>	        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>	4. They have the same MAC address
>
>	Note: make sure you shutdown other network interfaces in guest.
>
>---
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
>Gavin Shan (1):
>  powrepc/pci: Refactor pci_dn
>
>Wei Yang (17):
>  PCI/IOV: Export interface for retrieve VF's BDF
>  PCI: Add weak pcibios_iov_resource_alignment() interface
>  PCI: Add weak pcibios_iov_resource_size() interface
>  PCI: Take additional PF's IOV BAR alignment in sizing and assigning
>  powerpc/pci: Add PCI resource alignment documentation
>  powerpc/pci: Don't unset pci resources for VFs
>  powerpc/pci: Define pcibios_disable_device() on powerpc
>  powerpc/pci: remove pci_dn->pcidev field
>  powerpc/powernv: Use pci_dn in PCI config accessor
>  powerpc/powernv: Allocate pe->iommu_table dynamically
>  powerpc/powernv: Expand VF resources according to the number of
>    total_pe
>  powerpc/powernv: Implement pcibios_iov_resource_alignment() on
>    powernv
>  powerpc/powernv: Implement pcibios_iov_resource_size() on powernv
>  powerpc/powernv: Shift VF resource with an offset
>  powerpc/powernv: Allocate VF PE
>  powerpc/powernv: Expanding IOV BAR, with m64_per_iov supported
>  powerpc/powernv: Group VF PE when IOV BAR is big on PHB3
>
> .../powerpc/pci_iov_resource_on_powernv.txt        |   75 ++
> arch/powerpc/include/asm/device.h                  |    3 +
> arch/powerpc/include/asm/iommu.h                   |    3 +
> arch/powerpc/include/asm/machdep.h                 |   13 +-
> arch/powerpc/include/asm/pci-bridge.h              |   24 +-
> arch/powerpc/kernel/pci-common.c                   |   39 +
> arch/powerpc/kernel/pci-hotplug.c                  |    3 +
> arch/powerpc/kernel/pci_dn.c                       |  257 ++++++-
> arch/powerpc/platforms/powernv/eeh-powernv.c       |   14 +-
> arch/powerpc/platforms/powernv/pci-ioda.c          |  744 +++++++++++++++++++-
> arch/powerpc/platforms/powernv/pci.c               |   87 +--
> arch/powerpc/platforms/powernv/pci.h               |   13 +-
> drivers/pci/iov.c                                  |   60 +-
> drivers/pci/setup-bus.c                            |   85 ++-
> include/linux/pci.h                                |   19 +
> 15 files changed, 1332 insertions(+), 107 deletions(-)
> create mode 100644 Documentation/powerpc/pci_iov_resource_on_powernv.txt
>
>-- 
>1.7.9.5
>
