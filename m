Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 86BC82C0175
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 21:04:07 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 07:04:04 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id EAEBAC90028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 07:04:00 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3NB40n5293956
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 07:04:01 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3NB40CM025980
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 08:04:00 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/5] powerpc/powernv: PHB3 Support
Date: Tue, 23 Apr 2013 19:03:49 +0800
Message-Id: <1366715034-24594-1-git-send-email-shangw@linux.vnet.ibm.com>
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

arch/powerpc/include/asm/iommu.h            |    1 +
arch/powerpc/include/asm/opal.h             |    5 +-
arch/powerpc/include/asm/xics.h             |    3 +
arch/powerpc/platforms/powernv/Kconfig      |    5 +
arch/powerpc/platforms/powernv/pci-ioda.c   |  209 +++++++++++++++++++++++----
arch/powerpc/platforms/powernv/pci-p5ioc2.c |    2 +
arch/powerpc/platforms/powernv/pci.c        |   74 ++++------
arch/powerpc/platforms/powernv/pci.h        |   24 +++-
arch/powerpc/sysdev/Kconfig                 |    1 +
arch/powerpc/sysdev/xics/icp-native.c       |   27 ++++-
10 files changed, 267 insertions(+), 84 deletions(-)

Thanks,
Gavin
