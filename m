Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C9D9C2C00B9
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 16:38:10 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 00:38:07 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E4F3AC90040
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:01 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P5c5Hd1507828
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 05:38:05 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P5c4Y3018322
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:04 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/9] powerpc/eeh: Introduce eeh_pe_free()
Date: Tue, 25 Feb 2014 13:37:45 +0800
Message-Id: <1393306670-17435-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces eeh_pe_free() to replace original kfree(pe)
so that we could have more checks there and calls to platform
interface supplied by eeh_ops in future.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index f0c353f..2add834 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -60,6 +60,27 @@ static struct eeh_pe *eeh_pe_alloc(struct pci_controller *phb, int type)
 }
 
 /**
+ * eeh_pe_free - Free PE
+ * @pe: EEH PE
+ *
+ * Free PE instance dynamically
+ */
+static void eeh_pe_free(struct eeh_pe *pe)
+{
+	if (!pe)
+		return;
+
+	if (!list_empty(&pe->child_list) ||
+	    !list_empty(&pe->edevs)) {
+		pr_warn("%s: PHB#%x-PE#%x has child PE or EEH dev\n",
+			__func__, pe->phb->global_number, pe->addr);
+		return;
+	}
+
+	kfree(pe);
+}
+
+/**
  * eeh_phb_pe_create - Create PHB PE
  * @phb: PCI controller
  *
@@ -374,7 +395,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 			pr_err("%s: No PHB PE is found (PHB Domain=%d)\n",
 				__func__, edev->phb->global_number);
 			edev->pe = NULL;
-			kfree(pe);
+			eeh_pe_free(pe);
 			return -EEXIST;
 		}
 	}
@@ -433,7 +454,7 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 			if (list_empty(&pe->edevs) &&
 			    list_empty(&pe->child_list)) {
 				list_del(&pe->child);
-				kfree(pe);
+				eeh_pe_free(pe);
 			} else {
 				break;
 			}
-- 
1.7.10.4
