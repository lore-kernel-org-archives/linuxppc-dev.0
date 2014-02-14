Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 15B342C00A0
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Feb 2014 17:16:42 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 13 Feb 2014 23:16:40 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 25CA519D8036
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Feb 2014 23:16:36 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1E4DtAQ7078224
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Feb 2014 05:14:01 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1E6GGUM015451
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Feb 2014 23:16:16 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/eeh: Prefetch PHB diag-data
Date: Fri, 14 Feb 2014 14:15:45 +0800
Message-Id: <1392358545-21780-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PHB diag-data is useful information to locate the root cause for
frozen PE. Unfortunately, we cleared part of that by wrongly zapping
LEM registers before collecting PHB diag-data. The patch fixes it
by prefetching that with extended eeh_ops->get_log() for PowerNV
platform.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    3 ++-
 arch/powerpc/kernel/eeh.c                    |    2 +-
 arch/powerpc/kernel/eeh_driver.c             |    4 ++++
 arch/powerpc/platforms/powernv/eeh-ioda.c    |   11 +++++++----
 arch/powerpc/platforms/powernv/eeh-powernv.c |    6 ++++--
 arch/powerpc/platforms/powernv/pci.h         |    2 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |   10 ++++++++--
 7 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index d4dd41f..b0bce0b 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -163,7 +163,8 @@ struct eeh_ops {
 	int (*get_state)(struct eeh_pe *pe, int *state);
 	int (*reset)(struct eeh_pe *pe, int option);
 	int (*wait_state)(struct eeh_pe *pe, int max_wait);
-	int (*get_log)(struct eeh_pe *pe, int severity, char *drv_log, unsigned long len);
+	int (*get_log)(struct eeh_pe *pe, int severity,
+		       char *drv_log, unsigned long len, bool prefetch);
 	int (*configure_bridge)(struct eeh_pe *pe);
 	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
 	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index e7b76a6..d409d9d 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -257,7 +257,7 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 		}
 	}
 
-	eeh_ops->get_log(pe, severity, pci_regs_buf, loglen);
+	eeh_ops->get_log(pe, severity, pci_regs_buf, loglen, false);
 }
 
 /**
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7bb30dc..7a9123a 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -502,6 +502,10 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	pr_warning("EEH: This PCI device has failed %d times in the last hour\n",
 		pe->freeze_count);
 
+	/* Prefetch PHB diag-data if applicable */
+	if (eeh_ops->get_log)
+		eeh_ops->get_log(pe, EEH_LOG_TEMP, NULL, 0, true);
+
 	/* Walk the various device drivers attached to this slot through
 	 * a reset sequence, giving each an opportunity to do what it needs
 	 * to accomplish the reset.  Each child gets a report of the
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index f514743..46fc394 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -539,7 +539,7 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
  * The function is used to retrieve error log from P7IOC.
  */
 static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
-			    char *drv_log, unsigned long len)
+			    char *drv_log, unsigned long len, bool prefetch)
 {
 	s64 ret;
 	unsigned long flags;
@@ -548,6 +548,12 @@ static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
 
 	spin_lock_irqsave(&phb->lock, flags);
 
+	if (!prefetch) {
+		pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
+		spin_unlock_irqrestore(&phb->lock, flags);
+		return 0;
+	}
+
 	ret = opal_pci_get_phb_diag_data2(phb->opal_id,
 			phb->diag.blob, PNV_PCI_DIAG_BUF_SIZE);
 	if (ret) {
@@ -557,9 +563,6 @@ static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
 		return -EIO;
 	}
 
-	/* The PHB diag-data is always indicative */
-	pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
-
 	spin_unlock_irqrestore(&phb->lock, flags);
 
 	return 0;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index a59788e..df1b73f 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -290,14 +290,16 @@ static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
  * Retrieve the temporary or permanent error from the PE.
  */
 static int powernv_eeh_get_log(struct eeh_pe *pe, int severity,
-			char *drv_log, unsigned long len)
+			       char *drv_log, unsigned long len,
+			       bool prefetch)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
 	int ret = -EEXIST;
 
 	if (phb->eeh_ops && phb->eeh_ops->get_log)
-		ret = phb->eeh_ops->get_log(pe, severity, drv_log, len);
+		ret = phb->eeh_ops->get_log(pe, severity,
+					    drv_log, len, prefetch);
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 13f1942..f1a9c2a 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -75,7 +75,7 @@ struct pnv_eeh_ops {
 	int (*get_state)(struct eeh_pe *pe);
 	int (*reset)(struct eeh_pe *pe, int option);
 	int (*get_log)(struct eeh_pe *pe, int severity,
-		       char *drv_log, unsigned long len);
+		       char *drv_log, unsigned long len, bool prefetch);
 	int (*configure_bridge)(struct eeh_pe *pe);
 	int (*next_error)(struct eeh_pe **pe);
 };
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 8a8f047..d38e1ba 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -576,11 +576,17 @@ static int pseries_eeh_wait_state(struct eeh_pe *pe, int max_wait)
  * Actually, the error will be retrieved through the dedicated
  * RTAS call.
  */
-static int pseries_eeh_get_log(struct eeh_pe *pe, int severity, char *drv_log, unsigned long len)
+static int pseries_eeh_get_log(struct eeh_pe *pe, int severity,
+			       char *drv_log, unsigned long len,
+			       bool prefetch)
 {
 	int config_addr;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
+
+	/* We needn't do prefetch stuff */
+	if (prefetch)
+		return ret;
 
 	spin_lock_irqsave(&slot_errbuf_lock, flags);
 	memset(slot_errbuf, 0, eeh_error_buf_size);
-- 
1.7.10.4
