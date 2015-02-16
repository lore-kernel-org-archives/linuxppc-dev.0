Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D37511A08D2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 14:47:03 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A47C4140213
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:03 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 13:47:03 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 673802CE8040
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:00 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G3kpRC5046446
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:00 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G3kPF5030523
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:26 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/10] powerpc/powernv: Drop PHB operation err_inject()
Date: Mon, 16 Feb 2015 14:45:40 +1100
Message-Id: <1424058348-28951-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch drops PHB EEH operation err_inject() and merge its logic
to eeh_ops::err_inject().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 49 ++--------------------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 38 ++++++++++++++++++---
 arch/powerpc/platforms/powernv/pci.h         |  2 --
 3 files changed, 36 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 2809c98..dd154cf 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -70,7 +70,6 @@ static ssize_t ioda_eeh_ei_write(struct file *filp,
 				 size_t count, loff_t *ppos)
 {
 	struct pci_controller *hose = filp->private_data;
-	struct pnv_phb *phb = hose->private_data;
 	struct eeh_dev *edev;
 	struct eeh_pe *pe;
 	int pe_no, type, func;
@@ -78,7 +77,7 @@ static ssize_t ioda_eeh_ei_write(struct file *filp,
 	char buf[50];
 	int ret;
 
-	if (!phb->eeh_ops || !phb->eeh_ops->err_inject)
+	if (!eeh_ops || !eeh_ops->err_inject)
 		return -ENXIO;
 
 	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
@@ -103,7 +102,7 @@ static ssize_t ioda_eeh_ei_write(struct file *filp,
 		return -ENODEV;
 
 	/* Do error injection */
-	ret = phb->eeh_ops->err_inject(pe, type, func, addr, mask);
+	ret = eeh_ops->err_inject(pe, type, func, addr, mask);
 	return ret < 0 ? ret : count;
 }
 
@@ -756,49 +755,6 @@ static int ioda_eeh_configure_bridge(struct eeh_pe *pe)
 	return 0;
 }
 
-static int ioda_eeh_err_inject(struct eeh_pe *pe, int type, int func,
-			       unsigned long addr, unsigned long mask)
-{
-	struct pci_controller *hose = pe->phb;
-	struct pnv_phb *phb = hose->private_data;
-	s64 ret;
-
-	/* Sanity check on error type */
-	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
-	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
-		pr_warn("%s: Invalid error type %d\n",
-			__func__, type);
-		return -ERANGE;
-	}
-
-	if (func < OPAL_ERR_INJECT_FUNC_IOA_LD_MEM_ADDR ||
-	    func > OPAL_ERR_INJECT_FUNC_IOA_DMA_WR_TARGET) {
-		pr_warn("%s: Invalid error function %d\n",
-			__func__, func);
-		return -ERANGE;
-	}
-
-	/* Firmware supports error injection ? */
-	if (!opal_check_token(OPAL_PCI_ERR_INJECT)) {
-		pr_warn("%s: Firmware doesn't support error injection\n",
-			__func__);
-		return -ENXIO;
-	}
-
-	/* Do error injection */
-	ret = opal_pci_err_inject(phb->opal_id, pe->addr,
-				  type, func, addr, mask);
-	if (ret != OPAL_SUCCESS) {
-		pr_warn("%s: Failure %lld injecting error "
-			"%d-%d to PHB#%x-PE#%x\n",
-			__func__, ret, type, func,
-			hose->global_number, pe->addr);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static void ioda_eeh_hub_diag_common(struct OpalIoP7IOCErrorData *data)
 {
 	/* GEM */
@@ -1144,6 +1100,5 @@ struct pnv_eeh_ops ioda_eeh_ops = {
 	.reset			= ioda_eeh_reset,
 	.get_log		= ioda_eeh_get_log,
 	.configure_bridge	= ioda_eeh_configure_bridge,
-	.err_inject		= ioda_eeh_err_inject,
 	.next_error		= ioda_eeh_next_error
 };
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index f562dd1..df33daa 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -406,12 +406,42 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
-	int ret = -EEXIST;
+	s64 rc;
+
+	/* Sanity check on error type */
+	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
+	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
+		pr_warn("%s: Invalid error type %d\n",
+			__func__, type);
+		return -ERANGE;
+	}
 
-	if (phb->eeh_ops && phb->eeh_ops->err_inject)
-		ret = phb->eeh_ops->err_inject(pe, type, func, addr, mask);
+	if (func < OPAL_ERR_INJECT_FUNC_IOA_LD_MEM_ADDR ||
+	    func > OPAL_ERR_INJECT_FUNC_IOA_DMA_WR_TARGET) {
+		pr_warn("%s: Invalid error function %d\n",
+			__func__, func);
+		return -ERANGE;
+	}
 
-	return ret;
+	/* Firmware supports error injection ? */
+	if (!opal_check_token(OPAL_PCI_ERR_INJECT)) {
+		pr_warn("%s: Firmware doesn't support error injection\n",
+			__func__);
+		return -ENXIO;
+	}
+
+	/* Do error injection */
+	rc = opal_pci_err_inject(phb->opal_id, pe->addr,
+				 type, func, addr, mask);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: Failure %lld injecting error "
+			"%d-%d to PHB#%x-PE#%x\n",
+			__func__, rc, type, func,
+			hose->global_number, pe->addr);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static inline bool pnv_eeh_cfg_blocked(struct device_node *dn)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 6c02ff8..a9f2362 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -85,8 +85,6 @@ struct pnv_eeh_ops {
 	int (*get_log)(struct eeh_pe *pe, int severity,
 		       char *drv_log, unsigned long len);
 	int (*configure_bridge)(struct eeh_pe *pe);
-	int (*err_inject)(struct eeh_pe *pe, int type, int func,
-			  unsigned long addr, unsigned long mask);
 	int (*next_error)(struct eeh_pe **pe);
 };
 #endif /* CONFIG_EEH */
-- 
1.8.3.2
