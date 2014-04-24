Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B69EC140122
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:29 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:27 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8EC0C3578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:26 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dWA224772760
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:32 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80Pkw023242
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:26 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 03/25] powerpc/powernv: Move PNV_EEH_STATE_ENABLED around
Date: Thu, 24 Apr 2014 18:00:09 +1000
Message-Id: <1398326431-24305-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The flag PNV_EEH_STATE_ENABLED is put into pnv_phb::eeh_state,
which is protected by CONFIG_EEH. We needn't that. Instead, we
can have pnv_phb::flags and maintain all flags there, which is
the purpose of the patch. The patch also renames PNV_EEH_STATE_ENABLED
to PNV_PHB_FLAG_EEH.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 2 +-
 arch/powerpc/platforms/powernv/pci.c      | 8 ++------
 arch/powerpc/platforms/powernv/pci.h      | 7 +++----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 5432598..9ff7b2d 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -154,7 +154,7 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 	}
 #endif
 
-	phb->eeh_state |= PNV_EEH_STATE_ENABLED;
+	phb->flags |= PNV_PHB_FLAG_EEH;
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 8518817..114e1a7 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -426,7 +426,7 @@ int pnv_pci_cfg_read(struct device_node *dn,
 	if (phb_pe && (phb_pe->state & EEH_PE_ISOLATED))
 		return PCIBIOS_SUCCESSFUL;
 
-	if (phb->eeh_state & PNV_EEH_STATE_ENABLED) {
+	if (phb->flags & PNV_PHB_FLAG_EEH) {
 		if (*val == EEH_IO_ERROR_VALUE(size) &&
 		    eeh_dev_check_failure(of_node_to_eeh_dev(dn)))
 			return PCIBIOS_DEVICE_NOT_FOUND;
@@ -464,12 +464,8 @@ int pnv_pci_cfg_write(struct device_node *dn,
 	}
 
 	/* Check if the PHB got frozen due to an error (no response) */
-#ifdef CONFIG_EEH
-	if (!(phb->eeh_state & PNV_EEH_STATE_ENABLED))
+	if (!(phb->flags & PNV_PHB_FLAG_EEH))
 		pnv_pci_config_check_eeh(phb, dn);
-#else
-	pnv_pci_config_check_eeh(phb, dn);
-#endif
 
 	return PCIBIOS_SUCCESSFUL;
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 6870f60..94e3495 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -81,24 +81,23 @@ struct pnv_eeh_ops {
 	int (*configure_bridge)(struct eeh_pe *pe);
 	int (*next_error)(struct eeh_pe **pe);
 };
-
-#define PNV_EEH_STATE_ENABLED	(1 << 0)	/* EEH enabled	*/
-
 #endif /* CONFIG_EEH */
 
+#define PNV_PHB_FLAG_EEH	(1 << 0)
+
 struct pnv_phb {
 	struct pci_controller	*hose;
 	enum pnv_phb_type	type;
 	enum pnv_phb_model	model;
 	u64			hub_id;
 	u64			opal_id;
+	int			flags;
 	void __iomem		*regs;
 	int			initialized;
 	spinlock_t		lock;
 
 #ifdef CONFIG_EEH
 	struct pnv_eeh_ops	*eeh_ops;
-	int			eeh_state;
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
1.8.3.2
