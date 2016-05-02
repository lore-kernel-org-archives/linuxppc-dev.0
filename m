Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qywNP0jrjzDqCQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 17:07:16 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 2 May 2016 17:07:14 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 347013578058
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 17:07:11 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u42773Rg7209252
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 17:07:11 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4276dir003193
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 17:06:39 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH kernel v2] powerpc/powernv: Fix debug macro
Date: Mon,  2 May 2016 17:06:12 +1000
Message-Id: <1462172772-38161-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When cfg_dbg() is enabled (i.e. mapped to printk()), gcc produces
errors as the __func__ parameter is missing (pnv_pci_cfg_read() has one);
this adds the missing parameter. Since cfg_dbg() is used not just for
config space access, this replaces it with well-known pr_devel().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* s/cfg_dbg/pr_devel/

---
 arch/powerpc/platforms/powernv/pci.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 73c8dc2..0db20ae 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -39,9 +39,6 @@
 /* Delay in usec */
 #define PCI_RESET_DELAY_US	3000000
 
-#define cfg_dbg(fmt...)	do { } while(0)
-//#define cfg_dbg(fmt...)	printk(fmt)
-
 #ifdef CONFIG_PCI_MSI
 int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
@@ -402,8 +399,8 @@ static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
 		}
 	}
 
-	cfg_dbg(" -> EEH check, bdfn=%04x PE#%d fstate=%x\n",
-		(pdn->busno << 8) | (pdn->devfn), pe_no, fstate);
+	pr_devel(" -> EEH check, bdfn=%04x PE#%d fstate=%x\n",
+		 (pdn->busno << 8) | (pdn->devfn), pe_no, fstate);
 
 	/* Clear the frozen state if applicable */
 	if (fstate == OPAL_EEH_STOPPED_MMIO_FREEZE ||
@@ -451,8 +448,8 @@ int pnv_pci_cfg_read(struct pci_dn *pdn,
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
 
-	cfg_dbg("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
-		__func__, pdn->busno, pdn->devfn, where, size, *val);
+	pr_devel("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
+		 __func__, pdn->busno, pdn->devfn, where, size, *val);
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -462,8 +459,8 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
 	struct pnv_phb *phb = pdn->phb->private_data;
 	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
 
-	cfg_dbg("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
-		pdn->busno, pdn->devfn, where, size, val);
+	pr_devel("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
+		 __func__, pdn->busno, pdn->devfn, where, size, val);
 	switch (size) {
 	case 1:
 		opal_pci_config_write_byte(phb->opal_id, bdfn, where, val);
-- 
2.5.0.rc3
