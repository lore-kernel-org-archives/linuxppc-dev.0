Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC2D71A077F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:17 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:39:14 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1CBBE2BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2Kr9G66650350
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:20:54 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dC5q007740
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:12 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/21] powerpc/eeh: Freeze PE before PE reset
Date: Tue, 30 Sep 2014 12:38:52 +1000
Message-Id: <1412044750-24460-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds one more option (EEH_OPT_FREEZE_PE) to set_option()
method to proactively freeze PE, which will be issued before resetting
pass-throughed PE to drop MMIO access during reset because it's
always contributing to recursive EEH error.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  1 +
 arch/powerpc/kernel/eeh.c                    |  7 +++++
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 43 +++++++++++++++++++++-------
 arch/powerpc/platforms/pseries/eeh_pseries.c |  4 ++-
 4 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index adcddb1..f98b1b5 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -167,6 +167,7 @@ enum {
 #define EEH_OPT_ENABLE		1	/* EEH enable	*/
 #define EEH_OPT_THAW_MMIO	2	/* MMIO enable	*/
 #define EEH_OPT_THAW_DMA	3	/* DMA enable	*/
+#define EEH_OPT_FREEZE_PE	4	/* Freeze PE	*/
 #define EEH_STATE_UNAVAILABLE	(1 << 0)	/* State unavailable	*/
 #define EEH_STATE_NOT_SUPPORT	(1 << 1)	/* EEH not supported	*/
 #define EEH_STATE_RESET_ACTIVE	(1 << 2)	/* Active reset		*/
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 17cf52ba..898c75f 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1382,6 +1382,13 @@ int eeh_pe_reset(struct eeh_pe *pe, int option)
 		break;
 	case EEH_RESET_HOT:
 	case EEH_RESET_FUNDAMENTAL:
+		/*
+		 * Proactively freeze the PE to drop all MMIO access
+		 * during reset, which should be banned as it's always
+		 * cause recursive EEH error.
+		 */
+		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
+
 		ret = eeh_ops->reset(pe, option);
 		break;
 	default:
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index c945bed..f3027b9 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -189,6 +189,7 @@ static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
+	bool freeze_pe = false;
 	int enable, ret = 0;
 	s64 rc;
 
@@ -212,6 +213,10 @@ static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
 	case EEH_OPT_THAW_DMA:
 		enable = OPAL_EEH_ACTION_CLEAR_FREEZE_DMA;
 		break;
+	case EEH_OPT_FREEZE_PE:
+		freeze_pe = true;
+		enable = OPAL_EEH_ACTION_SET_FREEZE_ALL;
+		break;
 	default:
 		pr_warn("%s: Invalid option %d\n",
 			__func__, option);
@@ -219,17 +224,35 @@ static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
 	}
 
 	/* If PHB supports compound PE, to handle it */
-	if (phb->unfreeze_pe) {
-		ret = phb->unfreeze_pe(phb, pe->addr, enable);
+	if (freeze_pe) {
+		if (phb->freeze_pe) {
+			phb->freeze_pe(phb, pe->addr);
+		} else {
+			rc = opal_pci_eeh_freeze_set(phb->opal_id,
+						     pe->addr,
+						     enable);
+			if (rc != OPAL_SUCCESS) {
+				pr_warn("%s: Failure %lld freezing "
+					"PHB#%x-PE#%x\n",
+					__func__, rc,
+					phb->hose->global_number, pe->addr);
+				ret = -EIO;
+			}
+		}
 	} else {
-		rc = opal_pci_eeh_freeze_clear(phb->opal_id,
-					       pe->addr,
-					       enable);
-		if (rc != OPAL_SUCCESS) {
-			pr_warn("%s: Failure %lld enable %d for PHB#%x-PE#%x\n",
-				__func__, rc, option, phb->hose->global_number,
-				pe->addr);
-			ret = -EIO;
+		if (phb->unfreeze_pe) {
+			ret = phb->unfreeze_pe(phb, pe->addr, enable);
+		} else {
+			rc = opal_pci_eeh_freeze_clear(phb->opal_id,
+						       pe->addr,
+						       enable);
+			if (rc != OPAL_SUCCESS) {
+				pr_warn("%s: Failure %lld enable %d "
+					"for PHB#%x-PE#%x\n",
+					__func__, rc, option,
+					phb->hose->global_number, pe->addr);
+				ret = -EIO;
+			}
 		}
 	}
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index b080538..b645dc6 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -349,7 +349,9 @@ static int pseries_eeh_set_option(struct eeh_pe *pe, int option)
 		if (pe->addr)
 			config_addr = pe->addr;
 		break;
-
+	case EEH_OPT_FREEZE_PE:
+		/* Not support */
+		return 0;
 	default:
 		pr_err("%s: Invalid option %d\n",
 			__func__, option);
-- 
1.8.3.2
