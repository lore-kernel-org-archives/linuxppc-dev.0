Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 489F12C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 19:59:07 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 25 Dec 2013 01:59:04 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A852E3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 01:59:01 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBP8x1h09175448
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 09:59:01 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBP8x1ko000374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 01:59:01 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/eeh: Cache AER capability in EEH dev
Date: Wed, 25 Dec 2013 16:58:54 +0800
Message-Id: <1387961936-20451-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1387961936-20451-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1387961936-20451-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When fixing AER registers on PowerNV platform, we need the position
of AER capability for each PCI device. The patch caches that to
EEH device during probe time. Also, the patch figures the EEH device
is associated with the upstream port of PCIe bridge or not, which
is useful while fixing AER registers on PowerNV platform.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    8 +++++---
 arch/powerpc/platforms/powernv/eeh-powernv.c |    5 ++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 4b709bf..92c2ec6 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -86,9 +86,10 @@ struct eeh_pe {
  */
 #define EEH_DEV_BRIDGE		(1 << 0)	/* PCI bridge		*/
 #define EEH_DEV_ROOT_PORT	(1 << 1)	/* PCIe root port	*/
-#define EEH_DEV_DS_PORT		(1 << 2)	/* Downstream port	*/
-#define EEH_DEV_IRQ_DISABLED	(1 << 3)	/* Interrupt disabled	*/
-#define EEH_DEV_DISCONNECTED	(1 << 4)	/* Removing from PE	*/
+#define EEH_DEV_US_PORT		(1 << 2)	/* Upstream port	*/
+#define EEH_DEV_DS_PORT		(1 << 3)	/* Downstream port	*/
+#define EEH_DEV_IRQ_DISABLED	(1 << 4)	/* Interrupt disabled	*/
+#define EEH_DEV_DISCONNECTED	(1 << 5)	/* Removing from PE	*/
 
 #define EEH_DEV_SYSFS		(1 << 8)	/* Sysfs created        */
 
@@ -99,6 +100,7 @@ struct eeh_dev {
 	int pe_config_addr;		/* PE config address		*/
 	u32 config_space[16];		/* Saved PCI config space	*/
 	u8 pcie_cap;			/* Saved PCIe capability	*/
+	int aer_cap;			/* Saved AER capability		*/
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head list;		/* Form link list in the PE	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 73b9814..df54b76 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -128,9 +128,12 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 		edev->mode |= EEH_DEV_BRIDGE;
 	if (pci_is_pcie(dev)) {
 		edev->pcie_cap = pci_pcie_cap(dev);
-
+		edev->aer_cap = pci_find_ext_capability(dev,
+						PCI_EXT_CAP_ID_ERR);
 		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
 			edev->mode |= EEH_DEV_ROOT_PORT;
+		else if (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
+			edev->mode |= EEH_DEV_US_PORT;
 		else if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)
 			edev->mode |= EEH_DEV_DS_PORT;
 	}
-- 
1.7.10.4
