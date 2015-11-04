Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D78FC1A0BC6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 14:31:01 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 09:00:59 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E2933E0058
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 09:01:13 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA43UrRR27590826
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 09:00:54 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA43Ur7x027398
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 09:00:53 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
 aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V12 6/9] powerpc/eeh: Create PE for VFs
Date: Wed,  4 Nov 2015 11:28:49 +0800
Message-Id: <1446607732-4166-7-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1446607732-4166-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1446607732-4166-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch creates PEs for VFs in the weak function
pcibios_bus_add_device(). Those PEs for VFs are identified with newly
introduced flag EEH_PE_VF so that we handle them differently during EEH
recovery.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  1 +
 arch/powerpc/kernel/eeh_pe.c                 | 10 ++++++++--
 arch/powerpc/platforms/powernv/eeh-powernv.c | 16 ++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 6c383ad..ec21f8f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -72,6 +72,7 @@ struct pci_dn;
 #define EEH_PE_PHB	(1 << 1)	/* PHB PE    */
 #define EEH_PE_DEVICE 	(1 << 2)	/* Device PE */
 #define EEH_PE_BUS	(1 << 3)	/* Bus PE    */
+#define EEH_PE_VF	(1 << 4)	/* VF PE     */
 
 #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
 #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 8654cb1..29240ad 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -299,7 +299,10 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
 	 * EEH device already having associated PE, but
 	 * the direct parent EEH device doesn't have yet.
 	 */
-	pdn = pdn ? pdn->parent : NULL;
+	if (edev->physfn)
+		pdn = pci_get_pdn(edev->physfn);
+	else
+		pdn = pdn ? pdn->parent : NULL;
 	while (pdn) {
 		/* We're poking out of PCI territory */
 		parent = pdn_to_eeh_dev(pdn);
@@ -382,7 +385,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	}
 
 	/* Create a new EEH PE */
-	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
+	if (edev->physfn)
+		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
+	else
+		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
 	if (!pe) {
 		pr_err("%s: out of memory!\n", __func__);
 		return -ENOMEM;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 3bb6acb..131c7d0 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1532,6 +1532,22 @@ static struct eeh_ops pnv_eeh_ops = {
 	.restore_config		= pnv_eeh_restore_config
 };
 
+void pcibios_bus_add_device(struct pci_dev *pdev)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+
+	if (!pdev->is_virtfn)
+		return;
+
+	/*
+	 * The following operations will fail if VF's sysfs files
+	 * aren't created or its resources aren't finalized.
+	 */
+	eeh_add_device_early(pdn);
+	eeh_add_device_late(pdev);
+	eeh_sysfs_add_device(pdev);
+}
+
 /**
  * eeh_powernv_init - Register platform dependent EEH operations
  *
-- 
2.5.0
