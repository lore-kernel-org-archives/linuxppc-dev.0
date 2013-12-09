Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E85F52C0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 03:41:21 +1100 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Mon, 9 Dec 2013 14:41:15 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 5C41F3520089
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 11:41:04 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB9GekI051118332
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Dec 2013 14:40:46 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB9Gf3Zw010526
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Dec 2013 14:41:04 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powernv: fix VFIO support with PHB3
Date: Mon,  9 Dec 2013 14:41:01 -0200
Message-Id: <1386607261-18200-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: shangw@linux.vnet.ibm.com, aik@ozlabs.ru, linux-kernel@vger.kernel.org,
 paulus@samba.org, Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have recently found out that no iommu_groups could be found under
/sys/ on a P8. That prevents PCI passthrough from working.

During my investigation, I found out there seems to be a missing
iommu_register_group for PHB3. The following patch seems to fix the
problem. After applying it, I see iommu_groups under
/sys/kernel/iommu_groups/, and can also bind vfio-pci to an adapter,
which gives me a device at /dev/vfio/.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---

This is now applied on top of benh's tree, branch next.

Alexey, is this now OK for you?

Thanks.
Cascardo.

---
 arch/powerpc/platforms/powernv/pci-ioda.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 614356c..f0e6871 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -720,6 +720,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
 	}
 	iommu_init_table(tbl, phb->hose->node);
+	iommu_register_group(tbl, pci_domain_nr(pe->pbus), pe->pe_number);
 
 	if (pe->pdev)
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
-- 
1.7.1
