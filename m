Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53BE42C00FA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 11:00:20 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 5 Sep 2013 21:00:18 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9D0346E803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 21:00:14 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8610Ebh35979382
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Sep 2013 01:00:14 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8610EJp001479
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 22:00:14 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/6] powerpc/powernv: Enable EEH for PHB3
Date: Fri,  6 Sep 2013 09:00:00 +0800
Message-Id: <1378429205-16248-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EEH isn't enabled for PHB3 and the patch intends to enable it.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c    |   26 +++++++++++---------------
 arch/powerpc/platforms/powernv/eeh-powernv.c |    5 +----
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 0cd1c4a..855c1d5 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -113,27 +113,23 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 		ioda_eeh_nb_init = 1;
 	}
 
-	/* FIXME: Enable it for PHB3 later */
-	if (phb->type == PNV_PHB_IODA1) {
+	/* We needn't HUB diag-data on PHB3 */
+	if (phb->type == PNV_PHB_IODA1 && !hub_diag) {
+		hub_diag = (char *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 		if (!hub_diag) {
-			hub_diag = (char *)__get_free_page(GFP_KERNEL |
-							   __GFP_ZERO);
-			if (!hub_diag) {
-				pr_err("%s: Out of memory !\n",
-				       __func__);
-				return -ENOMEM;
-			}
+			pr_err("%s: Out of memory !\n", __func__);
+			return -ENOMEM;
 		}
+	}
 
 #ifdef CONFIG_DEBUG_FS
-		if (phb->dbgfs)
-			debugfs_create_file("err_injct", 0600,
-					    phb->dbgfs, hose,
-					    &ioda_eeh_dbgfs_ops);
+	if (phb->dbgfs)
+		debugfs_create_file("err_injct", 0600,
+				    phb->dbgfs, hose,
+				    &ioda_eeh_dbgfs_ops);
 #endif
 
-		phb->eeh_state |= PNV_EEH_STATE_ENABLED;
-	}
+	phb->eeh_state |= PNV_EEH_STATE_ENABLED;
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 79663d2..73b9814 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -144,11 +144,8 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	/*
 	 * Enable EEH explicitly so that we will do EEH check
 	 * while accessing I/O stuff
-	 *
-	 * FIXME: Enable that for PHB3 later
 	 */
-	if (phb->type == PNV_PHB_IODA1)
-		eeh_subsystem_enabled = 1;
+	eeh_subsystem_enabled = 1;
 
 	/* Save memory bars */
 	eeh_save_bars(edev);
-- 
1.7.5.4
