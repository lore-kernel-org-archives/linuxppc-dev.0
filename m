Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62BCB2C0100
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 15:21:13 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 26 Apr 2013 01:21:10 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9AEB96E803A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 01:21:04 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3Q5L7R9311106
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 01:21:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3Q5L6CQ004981
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 02:21:07 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/6] powerpc/powernv: PHB3 Support
Date: Fri, 26 Apr 2013 13:20:56 +0800
Message-Id: <1366953662-9473-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patchset includes minimal support for PHB3. Initially, flag "PNV_PHB_IODA2"
is introduced to differentiate IODA2 compliant PHB3 from other types of PHBs and
do initialization accordingly for PHB3. Besides, variable IODA2 tables reside in
system memory and we allocate them in kernel, then pass them to f/w and enable
the corresponding BARs through OPAL API. The P/Q bits of IVE should be handled
on PHB3 by software and the patchset intends to cover that as well.

NOTE: The first patch comes from Ben.

v3 -> v4
	* Remove the patch to retrieve IODA2 table address/length since
	  it's useless now
	* Introduce IRQ chip for individual PHB and patch the handlers
	  during MSI interrupt setup time according to Ben's suggestion
	* Pass HW IRQ to opal_pci_msi_eoi()
	* Remove "sysdata" from IOMMU table
v2 -> v3
	* Remove the unnecessary quirk. That's only useful with simics
	* Do MSI EOI in single OPAL API opal_pci_msi_eoi()
	* Use explicit branch to fully utilize CPU's prefetching engine
	  while doing TCE invalidation
	* Add one patch to fix invalid IOMMU table for PCI devices
v1 -> v2
	* Introduce CONFIG_POWERNV_MSI, which is similiar to CONFIG_PSERIES_MSI
	* Enable CONFIG_PPC_MSI_BITMAP while selecting CONFIG_POWERNV_MSI
	* Eleminate (struct pnv_phb::msi_count) since it has been removed in
	  linux-next
	* Replace (CONFIG_PPC_POWERNV && CONFIG_PCI_MSI) with CONFIG_POWERNV_MSI
	* Move declaration of pnv_pci_msi_eoi() to asm/xics.h
	* Remove unnecessary "#ifdef ... #endif" in icp-native.c
	* Add support to invalidate TCE
	* Let the IODA2 table allocated by firmware and kernel to retrieve them
	  through device-tree

---

arch/powerpc/include/asm/opal.h                |    7 +-
arch/powerpc/include/asm/xics.h                |    1 +
arch/powerpc/platforms/powernv/Kconfig         |    5 +
arch/powerpc/platforms/powernv/opal-wrappers.S |    1 +
arch/powerpc/platforms/powernv/pci-ioda.c      |  330 ++++++++++++++++++++----
arch/powerpc/platforms/powernv/pci-p5ioc2.c    |    4 +-
arch/powerpc/platforms/powernv/pci.c           |   56 +----
arch/powerpc/platforms/powernv/pci.h           |   35 ++-
arch/powerpc/sysdev/Kconfig                    |    1 +
arch/powerpc/sysdev/xics/icp-native.c          |    2 +-
10 files changed, 332 insertions(+), 110 deletions(-)

Thanks,
Gavin
