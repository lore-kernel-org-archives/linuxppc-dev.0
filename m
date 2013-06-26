Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 375E72C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 11:38:19 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 19:38:17 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 693E93E40040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:37:54 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5Q1cDef316868
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:38:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5Q1cDqf010366
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:38:13 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc/powernv: Replace variables with flags
Date: Wed, 26 Jun 2013 09:38:05 +0800
Message-Id: <1372210688-12214-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372210688-12214-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372210688-12214-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have 2 fields in "struct pnv_phb" to trace the states. The patch
replace the fields with one and introduces flags for that. The patch
doesn't impact the logic.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |    8 ++++----
 arch/powerpc/platforms/powernv/pci.c      |    4 ++--
 arch/powerpc/platforms/powernv/pci.h      |    7 +++++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 84f3036..85025d7 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -132,7 +132,7 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 					    &ioda_eeh_dbgfs_ops);
 #endif
 
-		phb->eeh_enabled = 1;
+		phb->eeh_state |= PNV_EEH_STATE_ENABLED;
 	}
 
 	return 0;
@@ -815,7 +815,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		 * removed, we needn't take care of it any more.
 		 */
 		phb = hose->private_data;
-		if (phb->removed)
+		if (phb->eeh_state & PNV_EEH_STATE_REMOVED)
 			continue;
 
 		rc = opal_pci_next_error(phb->opal_id,
@@ -850,7 +850,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				list_for_each_entry_safe(hose, tmp,
 						&hose_list, list_node) {
 					phb = hose->private_data;
-					phb->removed = 1;
+					phb->eeh_state |= PNV_EEH_STATE_REMOVED;
 				}
 
 				WARN(1, "EEH: dead IOC detected\n");
@@ -867,7 +867,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 
 				WARN(1, "EEH: dead PHB#%x detected\n",
 				     hose->global_number);
-				phb->removed = 1;
+				phb->eeh_state |= PNV_EEH_STATE_REMOVED;
 				ret = 3;
 				goto out;
 			} else if (severity == OPAL_EEH_SEV_PHB_FENCED) {
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 6d9a506..1f31826 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -308,7 +308,7 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 	if (phb_pe && (phb_pe->state & EEH_PE_ISOLATED))
 		return PCIBIOS_SUCCESSFUL;
 
-	if (phb->eeh_enabled) {
+	if (phb->eeh_state & PNV_EEH_STATE_ENABLED) {
 		if (*val == EEH_IO_ERROR_VALUE(size)) {
 			busdn = pci_bus_to_OF_node(bus);
 			for (dn = busdn->child; dn; dn = dn->sibling) {
@@ -358,7 +358,7 @@ static int pnv_pci_write_config(struct pci_bus *bus,
 
 	/* Check if the PHB got frozen due to an error (no response) */
 #ifdef CONFIG_EEH
-	if (!phb->eeh_enabled)
+	if (!(phb->eeh_state & PNV_EEH_STATE_ENABLED))
 		pnv_pci_config_check_eeh(phb, bus, bdfn);
 #else
 	pnv_pci_config_check_eeh(phb, bus, bdfn);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 43906e3..40bdf02 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -78,6 +78,10 @@ struct pnv_eeh_ops {
 	int (*configure_bridge)(struct eeh_pe *pe);
 	int (*next_error)(struct eeh_pe **pe);
 };
+
+#define PNV_EEH_STATE_ENABLED	(1 << 0)	/* EEH enabled	*/
+#define PNV_EEH_STATE_REMOVED	(1 << 1)	/* PHB removed	*/
+
 #endif /* CONFIG_EEH */
 
 struct pnv_phb {
@@ -92,8 +96,7 @@ struct pnv_phb {
 
 #ifdef CONFIG_EEH
 	struct pnv_eeh_ops	*eeh_ops;
-	int			eeh_enabled;
-	int			removed;
+	int			eeh_state;
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
1.7.5.4
