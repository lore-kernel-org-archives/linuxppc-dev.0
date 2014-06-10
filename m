Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88EE41A00D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:56:56 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Jun 2014 11:56:54 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AA8112BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:56:50 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5A1YoK152101142
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:34:51 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5A1unvi024218
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:56:49 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Subject: [RFC PATCH V3 00/17] Enable SRIOV on POWER8
Date: Tue, 10 Jun 2014 09:56:22 +0800
Message-Id: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com, bhelgaas@google.com,
 yan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set enable the SRIOV on POWER8. This is not the final version, some
patches rely on un-merged patches.

The gerneral idea is put each VF in their own PE and allocated necessary
resources, like DMA/IOMMU_TABLE.

One thing special for VF PE is we use M64BT to cover the IOV BAR. This means
we need to do some hack on pci devices's resources.
1. Expand the IOV BAR properly.
2. Shift the IOV BAR properly.
3. IOV BAR alignment is the total size instead of an individual size.
4. Take the IOV BAR alignment into consideration in the sizing and assigning.

Test Environment:
       The SRIOV device tested is Emulex Lancer and Mellanox ConnectX-3.

Examples on pass through a VF to guest through vfio:
	1. install necessary modules
	   modprobe vfio
	   modprobe vfio-pci
	2. retrieve the iommu_group the device belongs to
	   readlink /sys/bus/pci/devices/0000:06:0d.0/iommu_group
	   ../../../../kernel/iommu_groups/26
	   This means it belongs to group 26
	3. see how many devices under this iommu_group
	   ls ls /sys/kernel/iommu_groups/26/devices/
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
   1. Improve the change log for
      "PCI: Add weak __pci_sriov_resource_size() interface"
      "PCI: Add weak __pci_sriov_resource_alignment() interface"
      "PCI: take additional IOV BAR alignment in sizing and assigning"
   2. Wrap VF PE code in CONFIG_PCI_IOV
   3. Did regression test on P7.

Wei Yang (17):
  pci/iov: Export interface for retrieve VF's BDF
  pci/of: Match PCI VFs to dev-tree nodes dynamically
  ppc/pci: don't unset pci resources for VFs
  PCI: SRIOV: add VF enable/disable hook
  ppc/pnv: user macro to define the TCE size
  ppc/pnv: allocate pe->iommu_table dynamically
  ppc/pnv: Add function to deconfig a PE
  PCI: Add weak pcibios_sriov_resource_size() interface
  PCI: Add weak pcibios_sriov_resource_alignment() interface
  PCI: take additional IOV BAR alignment in sizing and assigning
  ppc/pnv: Expand VF resources according to the number of total_pe
  powerpc/powernv: implement pcibios_sriov_resource_alignment on
    powernv
  powerpc/powernv: shift VF resource with an offset
  ppc/pci: create/release dev-tree node for VFs
  powerpc/powernv: allocate VF PE
  ppc/pci: Expanding IOV BAR, with m64_per_iov supported
  ppc/pnv: Group VF PE when IOV BAR is big on PHB3

 arch/powerpc/include/asm/iommu.h          |    3 +
 arch/powerpc/include/asm/machdep.h        |    7 +
 arch/powerpc/include/asm/pci-bridge.h     |    7 +
 arch/powerpc/include/asm/tce.h            |    3 +-
 arch/powerpc/kernel/pci-common.c          |   29 +
 arch/powerpc/platforms/powernv/Kconfig    |    1 +
 arch/powerpc/platforms/powernv/pci-ioda.c |  824 +++++++++++++++++++++++++++--
 arch/powerpc/platforms/powernv/pci.c      |   22 +-
 arch/powerpc/platforms/powernv/pci.h      |   17 +-
 drivers/pci/iov.c                         |   84 ++-
 drivers/pci/pci.h                         |   21 -
 drivers/pci/setup-bus.c                   |   66 ++-
 include/linux/pci.h                       |   46 ++
 13 files changed, 1041 insertions(+), 89 deletions(-)

-- 
1.7.9.5
