Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F9521A0CC9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:14:00 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:13:59 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2F5E42CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:56 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDl7s63832112
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:56 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDM0o030528
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:23 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 40/50] powerpc/powernv: Support PCI slot ID
Date: Thu,  5 Nov 2015 00:12:40 +1100
Message-Id: <1446642770-4681-41-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerNV platforms runs on top of skiboot firmware that includes
changes to support PCI slots. PCI slots are identified by PHB's
ID or the combo of that and PCI slot ID.

This changes the EEH PowerNV backend to support PCI slots:

   * Rename arguments of opal_pci_reset() and opal_pci_poll().
   * One more argument (PCI slot's state) added to opal_pci_poll().
   * Drop pnv_eeh_phb_poll() and introduce a enhanced similar
     function pnv_pci_poll() that will be used by PowerNV hotplug
     backends.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h              |  4 +--
 arch/powerpc/platforms/powernv/eeh-powernv.c | 42 ++++++----------------------
 arch/powerpc/platforms/powernv/pci.c         | 21 ++++++++++++++
 arch/powerpc/platforms/powernv/pci.h         |  1 +
 4 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 8001159..11ee20e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -130,7 +130,7 @@ int64_t opal_pci_map_pe_dma_window(uint64_t phb_id, uint16_t pe_number, uint16_t
 int64_t opal_pci_map_pe_dma_window_real(uint64_t phb_id, uint16_t pe_number,
 					uint16_t dma_window_number, uint64_t pci_start_addr,
 					uint64_t pci_mem_size);
-int64_t opal_pci_reset(uint64_t phb_id, uint8_t reset_scope, uint8_t assert_state);
+int64_t opal_pci_reset(uint64_t id, uint8_t reset_scope, uint8_t assert_state);
 
 int64_t opal_pci_get_hub_diag_data(uint64_t hub_id, void *diag_buffer,
 				   uint64_t diag_buffer_len);
@@ -147,7 +147,7 @@ int64_t opal_get_dpo_status(__be64 *dpo_timeout);
 int64_t opal_set_system_attention_led(uint8_t led_action);
 int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
 			    __be16 *pci_error_type, __be16 *severity);
-int64_t opal_pci_poll(uint64_t phb_id);
+int64_t opal_pci_poll(uint64_t id, uint8_t *state);
 int64_t opal_return_cpu(void);
 int64_t opal_check_token(uint64_t token);
 int64_t opal_reinit_cpus(uint64_t flags);
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index ab8b93e..e533535 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -729,28 +729,11 @@ static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
 	return ret;
 }
 
-static s64 pnv_eeh_phb_poll(struct pnv_phb *phb)
-{
-	s64 rc = OPAL_HARDWARE;
-
-	while (1) {
-		rc = opal_pci_poll(phb->opal_id);
-		if (rc <= 0)
-			break;
-
-		if (system_state < SYSTEM_RUNNING)
-			udelay(1000 * rc);
-		else
-			msleep(rc);
-	}
-
-	return rc;
-}
-
 int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 {
 	struct pnv_phb *phb = hose->private_data;
 	s64 rc = OPAL_HARDWARE;
+	int ret;
 
 	pr_debug("%s: Reset PHB#%x, option=%d\n",
 		 __func__, hose->global_number, option);
@@ -765,8 +748,6 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 		rc = opal_pci_reset(phb->opal_id,
 				    OPAL_RESET_PHB_COMPLETE,
 				    OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
 
 	/*
 	 * Poll state of the PHB until the request is done
@@ -774,24 +755,22 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 	 * reset followed by hot reset on root bus. So we also
 	 * need the PCI bus settlement delay.
 	 */
-	rc = pnv_eeh_phb_poll(phb);
-	if (option == EEH_RESET_DEACTIVATE) {
+	ret = pnv_pci_poll(phb->opal_id, rc, NULL);
+	if (option == EEH_RESET_DEACTIVATE && !ret) {
 		if (system_state < SYSTEM_RUNNING)
 			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
 		else
 			msleep(EEH_PE_RST_SETTLE_TIME);
 	}
-out:
-	if (rc != OPAL_SUCCESS)
-		return -EIO;
 
-	return 0;
+	return ret;
 }
 
 static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
 {
 	struct pnv_phb *phb = hose->private_data;
 	s64 rc = OPAL_HARDWARE;
+	int ret;
 
 	pr_debug("%s: Reset PHB#%x, option=%d\n",
 		 __func__, hose->global_number, option);
@@ -813,18 +792,13 @@ static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
 		rc = opal_pci_reset(phb->opal_id,
 				    OPAL_RESET_PCI_HOT,
 				    OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
 
 	/* Poll state of the PHB until the request is done */
-	rc = pnv_eeh_phb_poll(phb);
-	if (option == EEH_RESET_DEACTIVATE)
+	ret = pnv_pci_poll(phb->opal_id, rc, NULL);
+	if (option == EEH_RESET_DEACTIVATE && !ret)
 		msleep(EEH_PE_RST_SETTLE_TIME);
-out:
-	if (rc != OPAL_SUCCESS)
-		return -EIO;
 
-	return 0;
+	return ret;
 }
 
 static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index d8832ea..ae0f0c1 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -44,6 +44,27 @@
 #define cfg_dbg(fmt...)	do { } while(0)
 //#define cfg_dbg(fmt...)	printk(fmt)
 
+int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *state)
+{
+	while (rval > 0) {
+		if (system_state < SYSTEM_RUNNING)
+			udelay(1000 * rval);
+		else
+			msleep(rval);
+
+		rval = opal_pci_poll(id, state);
+	}
+
+	/*
+	 * The caller expects to retrieve additional
+	 * information if the last argument isn't NULL.
+	 */
+	if (rval == OPAL_SUCCESS && state)
+		rval = opal_pci_poll(id, state);
+
+	return (rval == OPAL_SUCCESS) ? 0 : -EIO;
+}
+
 #ifdef CONFIG_PCI_MSI
 int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 3bb10de..30b0bfc 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -195,6 +195,7 @@ extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
 		unsigned long *hpa, enum dma_data_direction *direction);
 extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
 
+int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *state);
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
 				unsigned char *log_buff);
 int pnv_pci_cfg_read(struct pci_dn *pdn,
-- 
2.1.0
