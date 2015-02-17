Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E2641A09C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 18:14:28 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0066514029C
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:14:26 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7B4392BB0055
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:24 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1H7EGIL45285620
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:24 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1H7DoMv011083
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:13:51 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RESEND v2 6/7] powerpc/powernv: Functions to retrieve PCI slot
 status
Date: Tue, 17 Feb 2015 18:13:22 +1100
Message-Id: <1424157203-691-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch exports two functions, which base on corresponding OPAL
APIs to retrieve PCI slot status. Those functions are going to be
used by PCI hotplug module in subsequent patches:

   pnv_pci_get_power_status()     opal_pci_get_power_status()
   pnv_pci_get_presence_status()  opal_pci_get_presence_status()

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                |  5 +++++
 arch/powerpc/include/asm/pnv-pci.h             |  3 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  2 ++
 arch/powerpc/platforms/powernv/pci.c           | 24 ++++++++++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ceec756..b3fcf07 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -169,6 +169,8 @@ struct opal_sg_list {
 #define OPAL_IPMI_SEND				107
 #define OPAL_IPMI_RECV				108
 #define OPAL_I2C_REQUEST			109
+#define OPAL_PCI_GET_POWER_STATUS		110
+#define OPAL_PCI_GET_PRESENCE_STATUS		111
 
 /* Device tree flags */
 
@@ -926,6 +928,9 @@ int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
 		uint64_t *msg_len);
 int64_t opal_i2c_request(uint64_t async_token, uint32_t bus_id,
 			 struct opal_i2c_request *oreq);
+int64_t opal_pci_get_power_status(uint64_t id, uint8_t *status);
+int64_t opal_pci_get_presence_status(uint64_t id, uint8_t *status);
+
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index f9b4982..6a19b50 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -13,6 +13,9 @@
 #include <linux/pci.h>
 #include <misc/cxl.h>
 
+extern int pnv_pci_get_power_status(uint64_t id, uint8_t *status);
+extern int pnv_pci_get_presence_status(uint64_t id, uint8_t *status);
+
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 			   unsigned int virq);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 0509bca..35e513e 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -292,3 +292,5 @@ OPAL_CALL(opal_tpo_read,			OPAL_READ_TPO);
 OPAL_CALL(opal_ipmi_send,			OPAL_IPMI_SEND);
 OPAL_CALL(opal_ipmi_recv,			OPAL_IPMI_RECV);
 OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
+OPAL_CALL(opal_pci_get_power_status,		OPAL_PCI_GET_POWER_STATUS);
+OPAL_CALL(opal_pci_get_presence_status,		OPAL_PCI_GET_PRESENCE_STATUS);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index a0ffae2..bee6798 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -63,6 +63,30 @@ int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval)
 	return rval ? -EIO : 0;
 }
 
+int pnv_pci_get_power_status(uint64_t id, uint8_t *status)
+{
+	long rc;
+
+	if (!opal_check_token(OPAL_PCI_GET_POWER_STATUS))
+		return -ENXIO;
+
+	rc = opal_pci_get_power_status(id, status);
+	return pnv_pci_poll(id, rc, status);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_power_status);
+
+int pnv_pci_get_presence_status(uint64_t id, uint8_t *status)
+{
+	long rc;
+
+	if (!opal_check_token(OPAL_PCI_GET_PRESENCE_STATUS))
+		return -ENXIO;
+
+	rc = opal_pci_get_presence_status(id, status);
+	return pnv_pci_poll(id, rc, status);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_presence_status);
+
 #ifdef CONFIG_PCI_MSI
 static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-- 
1.8.3.2
