Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C611B2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 19:03:37 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 15 Jun 2013 05:03:35 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 8439BC90026
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:31 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5F93WEq339502
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:32 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5F93Vgd015570
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 06:03:32 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/27] powerpc/eeh: I/O chip PE log and bridge setup
Date: Sat, 15 Jun 2013 17:03:08 +0800
Message-Id: <1371286998-2842-18-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds backends to retrieve error log and configure p2p
bridges for the indicated PE.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   57 ++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index f552e23..95f7d96 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -444,11 +444,64 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 	return ret;
 }
 
+/**
+ * ioda_eeh_get_log - Retrieve error log
+ * @pe: EEH PE
+ * @severity: Severity level of the log
+ * @drv_log: buffer to store the log
+ * @len: space of the log buffer
+ *
+ * The function is used to retrieve error log from P7IOC.
+ */
+static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
+		char *drv_log, unsigned long len)
+{
+	s64 ret;
+	unsigned long flags;
+	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
+
+	spin_lock_irqsave(&phb->lock, flags);
+
+	ret = opal_pci_get_phb_diag_data2(phb->opal_id,
+			phb->diag.blob, PNV_PCI_DIAG_BUF_SIZE);
+	if (ret) {
+		spin_unlock_irqrestore(&phb->lock, flags);
+		pr_warning("%s: Failed to retrieve log for PHB#%x-PE#%x\n",
+			__func__, hose->global_number, pe->addr);
+		return -EIO;
+	}
+
+	/*
+	 * FIXME: We probably need log the error in somewhere.
+	 * Lets make it up in future.
+	 */
+	/* pr_info("%s", phb->diag.blob); */
+
+	spin_unlock_irqrestore(&phb->lock, flags);
+
+	return 0;
+}
+
+/**
+ * ioda_eeh_configure_bridge - Configure the PCI bridges for the indicated PE
+ * @pe: EEH PE
+ *
+ * For particular PE, it might have included PCI bridges. In order
+ * to make the PE work properly, those PCI bridges should be configured
+ * correctly. However, we need do nothing on P7IOC since the reset
+ * function will do everything that should be covered by the function.
+ */
+static int ioda_eeh_configure_bridge(struct eeh_pe *pe)
+{
+	return 0;
+}
+
 struct pnv_eeh_ops ioda_eeh_ops = {
 	.post_init		= ioda_eeh_post_init,
 	.set_option		= ioda_eeh_set_option,
 	.get_state		= ioda_eeh_get_state,
 	.reset			= ioda_eeh_reset,
-	.get_log		= NULL,
-	.configure_bridge	= NULL
+	.get_log		= ioda_eeh_get_log,
+	.configure_bridge	= ioda_eeh_configure_bridge
 };
-- 
1.7.5.4
