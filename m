Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F386B2C0227
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 18:28:56 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 00:28:54 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 278061FF003E
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:28:51 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P7SPuo61145102
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 08:28:25 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P7Sop2005432
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:28:51 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc/powernv: Move PNV_EEH_STATE_ENABLED around
Date: Tue, 25 Feb 2014 15:28:36 +0800
Message-Id: <1393313318-6341-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1393313318-6341-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393313318-6341-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
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

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |    2 +-
 arch/powerpc/platforms/powernv/pci.c      |    8 ++------
 arch/powerpc/platforms/powernv/pci.h      |    7 +++----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 0d1d424..04b4710 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -153,7 +153,7 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 	}
 #endif
 
-	phb->eeh_state |= PNV_EEH_STATE_ENABLED;
+	phb->flags |= PNV_PHB_FLAG_EEH;
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 95633d7..3955fc0 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -396,7 +396,7 @@ int pnv_pci_cfg_read(struct device_node *dn,
 	if (phb_pe && (phb_pe->state & EEH_PE_ISOLATED))
 		return PCIBIOS_SUCCESSFUL;
 
-	if (phb->eeh_state & PNV_EEH_STATE_ENABLED) {
+	if (phb->flags & PNV_PHB_FLAG_EEH) {
 		if (*val == EEH_IO_ERROR_VALUE(size) &&
 		    eeh_dev_check_failure(of_node_to_eeh_dev(dn)))
 			return PCIBIOS_DEVICE_NOT_FOUND;
@@ -434,12 +434,8 @@ int pnv_pci_cfg_write(struct device_node *dn,
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
1.7.10.4
