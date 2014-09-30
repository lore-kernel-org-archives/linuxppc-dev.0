Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C3061A1840
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:40:13 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:40:12 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CCE0A2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:40:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2fb1233489136
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:41:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dbWq016099
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/21] powerpc/eeh: Introduce eeh_ops::err_inject
Date: Tue, 30 Sep 2014 12:38:56 +1000
Message-Id: <1412044750-24460-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces eeh_ops::err_inject(), which allows to inject
specified errors to indicated PE for testing purpose. The functionality
isn't support on pSeries platform. On PowerNV, the functionality
relies on OPAL API opal_pci_err_inject().

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  2 ++
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 44 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/eeh-powernv.c | 26 ++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h         |  2 ++
 arch/powerpc/platforms/pseries/eeh_pseries.c |  1 +
 5 files changed, 75 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index f98b1b5..ae8c441 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -199,6 +199,8 @@ struct eeh_ops {
 	int (*wait_state)(struct eeh_pe *pe, int max_wait);
 	int (*get_log)(struct eeh_pe *pe, int severity, char *drv_log, unsigned long len);
 	int (*configure_bridge)(struct eeh_pe *pe);
+	int (*err_inject)(struct eeh_pe *pe, int type, int func,
+			  unsigned long addr, unsigned long mask);
 	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
 	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
 	int (*next_error)(struct eeh_pe **pe);
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index f3027b9..ddb38cc 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -673,6 +673,49 @@ static int ioda_eeh_configure_bridge(struct eeh_pe *pe)
 	return 0;
 }
 
+static int ioda_eeh_err_inject(struct eeh_pe *pe, int type, int func,
+			       unsigned long addr, unsigned long mask)
+{
+	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
+	s64 ret;
+
+	/* Sanity check on error type */
+	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
+	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
+		pr_warn("%s: Invalid error type %d\n",
+			__func__, type);
+		return -ERANGE;
+	}
+
+	if (func < OPAL_ERR_INJECT_FUNC_IOA_LD_MEM_ADDR ||
+	    func > OPAL_ERR_INJECT_FUNC_IOA_DMA_WR_TARGET) {
+		pr_warn("%s: Invalid error function %d\n",
+			__func__, func);
+		return -ERANGE;
+	}
+
+	/* Firmware supports error injection ? */
+	if (!opal_check_token(OPAL_PCI_ERR_INJECT)) {
+		pr_warn("%s: Firmware doesn't support error injection\n",
+			__func__);
+		return -ENXIO;
+	}
+
+	/* Do error injection */
+	ret = opal_pci_err_inject(phb->opal_id, pe->addr,
+				  type, func, addr, mask);
+	if (ret != OPAL_SUCCESS) {
+		pr_warn("%s: Failure %lld injecting error "
+			"%d-%d to PHB#%x-PE#%x\n",
+			__func__, ret, type, func,
+			hose->global_number, pe->addr);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static void ioda_eeh_hub_diag_common(struct OpalIoP7IOCErrorData *data)
 {
 	/* GEM */
@@ -994,5 +1037,6 @@ struct pnv_eeh_ops ioda_eeh_ops = {
 	.reset			= ioda_eeh_reset,
 	.get_log		= ioda_eeh_get_log,
 	.configure_bridge	= ioda_eeh_configure_bridge,
+	.err_inject		= ioda_eeh_err_inject,
 	.next_error		= ioda_eeh_next_error
 };
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index fd7a16f..3e89cbf 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -359,6 +359,31 @@ static int powernv_eeh_configure_bridge(struct eeh_pe *pe)
 }
 
 /**
+ * powernv_pe_err_inject - Inject specified error to the indicated PE
+ * @pe: the indicated PE
+ * @type: error type
+ * @func: specific error type
+ * @addr: address
+ * @mask: address mask
+ *
+ * The routine is called to inject specified error, which is
+ * determined by @type and @func, to the indicated PE for
+ * testing purpose.
+ */
+static int powernv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
+				  unsigned long addr, unsigned long mask)
+{
+	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
+	int ret = -EEXIST;
+
+	if (phb->eeh_ops && phb->eeh_ops->err_inject)
+		ret = phb->eeh_ops->err_inject(pe, type, func, addr, mask);
+
+	return ret;
+}
+
+/**
  * powernv_eeh_next_error - Retrieve next EEH error to handle
  * @pe: Affected PE
  *
@@ -414,6 +439,7 @@ static struct eeh_ops powernv_eeh_ops = {
 	.wait_state             = powernv_eeh_wait_state,
 	.get_log                = powernv_eeh_get_log,
 	.configure_bridge       = powernv_eeh_configure_bridge,
+	.err_inject		= powernv_eeh_err_inject,
 	.read_config            = pnv_pci_cfg_read,
 	.write_config           = pnv_pci_cfg_write,
 	.next_error		= powernv_eeh_next_error,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 48494d4..27594cf 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -85,6 +85,8 @@ struct pnv_eeh_ops {
 	int (*get_log)(struct eeh_pe *pe, int severity,
 		       char *drv_log, unsigned long len);
 	int (*configure_bridge)(struct eeh_pe *pe);
+	int (*err_inject)(struct eeh_pe *pe, int type, int func,
+			  unsigned long addr, unsigned long mask);
 	int (*next_error)(struct eeh_pe **pe);
 };
 #endif /* CONFIG_EEH */
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index b645dc6..4fc5ff9 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -731,6 +731,7 @@ static struct eeh_ops pseries_eeh_ops = {
 	.wait_state		= pseries_eeh_wait_state,
 	.get_log		= pseries_eeh_get_log,
 	.configure_bridge       = pseries_eeh_configure_bridge,
+	.err_inject		= NULL,
 	.read_config		= pseries_eeh_read_config,
 	.write_config		= pseries_eeh_write_config,
 	.next_error		= NULL,
-- 
1.8.3.2
