Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4EE2E2C030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 18:24:31 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 30 May 2013 04:24:27 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 70AF36E8028
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:20 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4U8ON1p64946184
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:23 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4U8OMHA013268
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 05:24:23 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/23] powerpc/eeh: I/O chip PE log and bridge setup
Date: Thu, 30 May 2013 16:23:59 +0800
Message-Id: <1369902245-5886-18-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/eeh-ioda.c |   59 ++++++++++++++++++++++++++++-
 1 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index be2c336..ec5c524 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -456,11 +456,66 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
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
+	u8 extra_log = !!(pe->type & EEH_PE_PHB);
+	unsigned long flags;
+	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
+
+	spin_lock_irqsave(&phb->lock, flags);
+
+	ret = opal_pci_get_phb_diag_data(phb->opal_id,
+			phb->diag.blob, PNV_PCI_DIAG_BUF_SIZE,
+			!extra_log);
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
