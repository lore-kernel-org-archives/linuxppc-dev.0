Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 716831A08EF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:51:55 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:51:53 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8E1B33578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:51:51 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JAphDE19071220
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:51:51 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JApIrE030864
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:51:19 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: [PATCH V7 02/10] powerpc/pci: Cache VF index in pci_dn
Date: Tue, 19 May 2015 18:50:04 +0800
Message-Id: <1432032612-21701-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch caches the VF index in pci_dn, which can be used to calculate
VF's bus, device and function number. Those information helps to locate
the VF's PCI device instance when doing hotplug during EEH recovery if
necessary.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h |    1 +
 arch/powerpc/kernel/pci_dn.c          |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 1811c44..c324882 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -196,6 +196,7 @@ struct pci_dn {
 #define IODA_INVALID_PE		(-1)
 #ifdef CONFIG_PPC_POWERNV
 	int	pe_number;
+	int     vf_index;		/* VF index in the PF */
 #ifdef CONFIG_PCI_IOV
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index b3b4df9..f771130 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -139,6 +139,7 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 #ifdef CONFIG_PCI_IOV
 static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 					   struct pci_dev *pdev,
+					   int vf_index,
 					   int busno, int devfn)
 {
 	struct pci_dn *pdn;
@@ -157,6 +158,7 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 	pdn->parent = parent;
 	pdn->busno = busno;
 	pdn->devfn = devfn;
+	pdn->vf_index = vf_index;
 #ifdef CONFIG_PPC_POWERNV
 	pdn->pe_number = IODA_INVALID_PE;
 #endif
@@ -196,7 +198,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 		return NULL;
 
 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
-		pdn = add_one_dev_pci_data(parent, NULL,
+		pdn = add_one_dev_pci_data(parent, NULL, i,
 					   pci_iov_virtfn_bus(pdev, i),
 					   pci_iov_virtfn_devfn(pdev, i));
 		if (!pdn) {
-- 
1.7.9.5
