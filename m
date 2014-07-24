Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3334D1A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:22:34 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 16:22:27 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 775392CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:22:31 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6O65Ykb63832208
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:05:34 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6O6MUw3019857
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:22:31 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Subject: [PATCH V7 00/17] Enable SRIOV on POWER8
Date: Thu, 24 Jul 2014 14:22:10 +0800
Message-Id: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set enables the SRIOV on POWER8.

The gerneral idea is put each VF into one individual PE and allocate required
resources like DMA/MSI.

One thing special for VF PE is we use M64BT to cover the IOV BAR. M64BT is one
hardware on POWER platform to map MMIO address to PE. By using M64BT, we could
map one individual VF to a VF PE, which introduce more flexiblity to users.

To achieve this effect, we need to do some hack on pci devices's resources.
1. Expand the IOV BAR properly.
   Done by pnv_pci_ioda_fixup_iov_resources().
2. Shift the IOV BAR properly.
   Done by pnv_pci_vf_resource_shift().
3. IOV BAR alignment is the total size instead of an individual size on
   powernv platform.
   Done by pnv_pcibios_sriov_resource_alignment().
4. Take the IOV BAR alignment into consideration in the sizing and assigning.
   This is achieved by commit: "PCI: Take additional IOV BAR alignment in
   sizing and assigning"

Test Environment:
       The SRIOV device tested is Emulex Lancer and Mellanox ConnectX-3 on
       POWER8.

Examples on pass through a VF to guest through vfio:
	1. install necessary modules
	   modprobe vfio
	   modprobe vfio-pci
	2. retrieve the iommu_group the device belongs to
	   readlink /sys/bus/pci/devices/0000:06:0d.0/iommu_group
	   ../../../../kernel/iommu_groups/26
	   This means it belongs to group 26
	3. see how many devices under this iommu_group
	   ls /sys/kernel/iommu_groups/26/devices/
	4. unbind the original driver and bind to vfio-pci driver
	   echo 0000:06:0d.0 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
	   echo  1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
	   Note: this should be done for each device in the same iommu_group
	5. Start qemu and pass device through vfio
	   /home/ywywyang/git/qemu-impreza/ppc64-softmmu/qemu-system-ppc64 \
		   -M pseries -m 2048 -enable-kvm -nographic \
		   -drive file=/home/ywywyang/kvm/fc19.img \
		   -monitor telnet:localhost:5435,server,nowait -boot cd \
		   -device "spapr-pci-vfio-host-bridge,id=CXGB3,iommu=26,index=6"

Verify this is the exact VF response:
	1. ping from a machine in the same subnet(the broadcast domain)
	2. run arp -n on this machine
	   9.115.251.20             ether   00:00:c9:df:ed:bf   C eth0
	3. ifconfig in the guest
	   # ifconfig eth1
	   eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
	        inet 9.115.251.20  netmask 255.255.255.0  broadcast 9.115.251.255
		inet6 fe80::200:c9ff:fedf:edbf  prefixlen 64  scopeid 0x20<link>
	        ether 00:00:c9:df:ed:bf  txqueuelen 1000 (Ethernet)
	        RX packets 175  bytes 13278 (12.9 KiB)
	        RX errors 0  dropped 0  overruns 0  frame 0
		TX packets 58  bytes 9276 (9.0 KiB)
	        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
	4. They have the same MAC address

	Note: make sure you shutdown other network interfaces in guest.

---
v6 -> v7:
   1. add IORESOURCE_ARCH flag for IOV BAR on powernv platform.
   2. when IOV BAR has IORESOURCE_ARCH flag, the size is retrieved from
      hardware directly. If not, calculate as usual.
   3. reorder the patch set, group them by subsystem:
      PCI, powerpc, powernv
   4. rebase it on 3.16-rc6
v5 -> v6:
   1. remove pcibios_enable_sriov()/pcibios_disable_sriov() weak function
      similar function is moved to
      pnv_pci_enable_device_hook()/pnv_pci_disable_device_hook(). When PF is
      enabled, platform will try best to allocate resources for VFs.
   2. remove pcibios_sriov_resource_size weak function
   3. VF BAR size is retrieved from hardware directly in virtfn_add()
v4 -> v5:
   1. merge those SRIOV related platform functions in machdep_calls
      wrap them in one CONFIG_PCI_IOV marco
   2. define IODA_INVALID_M64 to replace (-1)
      use this value to represent the m64_wins is not used
   3. rename pnv_pci_release_dev_dma() to pnv_pci_ioda2_release_dma_pe()
      this function is a conterpart to pnv_pci_ioda2_setup_dma_pe()
   4. change dev_info() to dev_dgb() in pnv_pci_ioda_fixup_iov_resources()
      reduce some log in kernel
   5. release M64 window in pnv_pci_ioda2_release_dma_pe()
v3 -> v4:
   1. code format fix, eg. not exceed 80 chars
   2. in commit "ppc/pnv: Add function to deconfig a PE"
      check the bus has a bridge before print the name
      remove a PE from its own PELTV
   3. change the function name for sriov resource size/alignment
   4. rebase on 3.16-rc3
   5. VFs will not rely on device node
      As Grant Likely's comments, kernel should have the ability to handle the
      lack of device_node gracefully. Gavin restructure the pci_dn, which
      makes the VF will have pci_dn even when VF's device_node is not provided
      by firmware.
   6. clean all the patch title to make them comply with one style
   7. fix return value for pci_iov_virtfn_bus/pci_iov_virtfn_devfn
v2 -> v3:
   1. change the return type of virtfn_bus/virtfn_devfn to int
      change the name of these two functions to pci_iov_virtfn_bus/pci_iov_virtfn_devfn
   2. reduce the second parameter or pcibios_sriov_disable()
   3. use data instead of pe in "ppc/pnv: allocate pe->iommu_table dynamically"
   4. rename __pci_sriov_resource_size to pcibios_sriov_resource_size
   5. rename __pci_sriov_resource_alignment to pcibios_sriov_resource_alignment
v1 -> v2:
   1. change the return value of virtfn_bus/virtfn_devfn to 0
   2. move some TCE related marco definition to
      arch/powerpc/platforms/powernv/pci.h
   3. fix the __pci_sriov_resource_alignment on powernv platform
      During the sizing stage, the IOV BAR is truncated to 0, which will
      effect the order of allocation. Fix this, so that make sure BAR will be
      allocated ordered by their alignment.
v0 -> v1:
   1. improve the change log for
      "PCI: Add weak __pci_sriov_resource_size() interface"
      "PCI: Add weak __pci_sriov_resource_alignment() interface"
      "PCI: take additional IOV BAR alignment in sizing and assigning"
   2. wrap VF PE code in CONFIG_PCI_IOV
   3. did regression test on P7.

Gavin Shan (2):
  powrepc/pci: Refactor pci_dn
  powerpc/powernv: Use pci_dn in PCI config accessor

Wei Yang (15):
  PCI/IOV: Export interface for retrieve VF's BDF
  PCI/IOV: Get VF BAR size from hardware directly when platform needs
  PCI: Add weak pcibios_sriov_resource_alignment() interface
  PCI: Take additional IOV BAR alignment in sizing and assigning
  powerpc/pci: Don't unset pci resources for VFs
  powerpc/pci: Define pcibios_disable_device() on powerpc
  powerpc/powernv: mark IOV BAR with IORESOURCE_ARCH
  powerpc/powernv: Allocate pe->iommu_table dynamically
  powerpc/powernv: Add function to deconfig a PE
  powerpc/powernv: Expand VF resources according to the number of
    total_pe
  powerpc/powernv: Implement pcibios_sriov_resource_alignment on
    powernv
  powerpc/powernv: Shift VF resource with an offset
  powerpc/powernv: Allocate VF PE
  powerpc/powernv: Expanding IOV BAR, with m64_per_iov supported
  powerpc/powernv: Group VF PE when IOV BAR is big on PHB3

 arch/powerpc/include/asm/device.h            |    3 +
 arch/powerpc/include/asm/iommu.h             |    3 +
 arch/powerpc/include/asm/machdep.h           |   12 +-
 arch/powerpc/include/asm/pci-bridge.h        |   23 +-
 arch/powerpc/kernel/pci-common.c             |   31 ++
 arch/powerpc/kernel/pci-hotplug.c            |    3 +
 arch/powerpc/kernel/pci_dn.c                 |  248 ++++++++-
 arch/powerpc/platforms/powernv/eeh-powernv.c |   24 +-
 arch/powerpc/platforms/powernv/pci-ioda.c    |  772 +++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.c         |  107 ++--
 arch/powerpc/platforms/powernv/pci.h         |   15 +-
 drivers/pci/iov.c                            |   65 ++-
 drivers/pci/pci.h                            |   19 -
 drivers/pci/setup-bus.c                      |   68 ++-
 include/linux/ioport.h                       |    1 +
 include/linux/pci.h                          |   47 ++
 16 files changed, 1311 insertions(+), 130 deletions(-)

-- 
1.7.9.5
