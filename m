Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D708F1A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 17:09:13 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 4 May 2015 17:09:12 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F19A9357804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 17:09:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t44791sF16122046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 17:09:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4478beV032334
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 17:08:37 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: [PATCH V3 2/9] powerpc/pci_dn: cache vf_index in pci_dn
Date: Mon,  4 May 2015 15:07:31 +0800
Message-Id: <1430723258-21299-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

This patch caches the index of a VF in its PF in pci_dn.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h |    1 +
 arch/powerpc/kernel/pci_dn.c          |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 1811c44..9582aa2 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -199,6 +199,7 @@ struct pci_dn {
 #ifdef CONFIG_PCI_IOV
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
+	int     vf_index;		/* Index to PF for VF dev */
 	int     offset;			/* PE# for the first VF PE */
 #define M64_PER_IOV 4
 	int     m64_per_iov;
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index b3b4df9..bf0fb873 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -138,7 +138,7 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 
 #ifdef CONFIG_PCI_IOV
 static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
-					   struct pci_dev *pdev,
+					   struct pci_dev *pdev, int vf_index,
 					   int busno, int devfn)
 {
 	struct pci_dn *pdn;
@@ -157,6 +157,7 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 	pdn->parent = parent;
 	pdn->busno = busno;
 	pdn->devfn = devfn;
+	pdn->vf_index = vf_index;
 #ifdef CONFIG_PPC_POWERNV
 	pdn->pe_number = IODA_INVALID_PE;
 #endif
@@ -196,7 +197,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 		return NULL;
 
 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
-		pdn = add_one_dev_pci_data(parent, NULL,
+		pdn = add_one_dev_pci_data(parent, NULL, i,
 					   pci_iov_virtfn_bus(pdev, i),
 					   pci_iov_virtfn_devfn(pdev, i));
 		if (!pdn) {
-- 
1.7.9.5
