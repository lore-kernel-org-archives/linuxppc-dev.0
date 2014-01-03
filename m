Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6C90C2C00A6
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Jan 2014 20:47:25 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 3 Jan 2014 02:47:22 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 20F9019D803E
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Jan 2014 02:47:11 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s039lCNo10617280
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Jan 2014 10:47:12 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s039lIUM030981
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Jan 2014 02:47:19 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 2/2] powerpc/eeh: Reinit error reporting
Date: Fri,  3 Jan 2014 17:47:13 +0800
Message-Id: <1388742433-7328-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1388742433-7328-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1388742433-7328-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch implements the EEH operation backend restore_config()
for PowerNV platform. That relies on OPAL API opal_pci_reinit()
where we reinitialize the error reporting properly after PE or
PHB reset. The patch also extends opal_pci_reinit() to have one
additional parameter to carry more information like PCI device
address.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h              |    8 ++++++--
 arch/powerpc/platforms/powernv/eeh-powernv.c |   23 ++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 7bdcf34..25f6454 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -311,12 +311,16 @@ enum OpalMveEnableAction {
 	OPAL_ENABLE_MVE = 1
 };
 
-enum OpalPciResetAndReinitScope {
+enum OpalPciResetScope {
 	OPAL_PHB_COMPLETE = 1, OPAL_PCI_LINK = 2, OPAL_PHB_ERROR = 3,
 	OPAL_PCI_HOT_RESET = 4, OPAL_PCI_FUNDAMENTAL_RESET = 5,
 	OPAL_PCI_IODA_TABLE_RESET = 6,
 };
 
+enum OpalPciReinitScope {
+	OPAL_PCI_DEV = 1
+};
+
 enum OpalPciResetState {
 	OPAL_DEASSERT_RESET = 0,
 	OPAL_ASSERT_RESET = 1
@@ -710,7 +714,7 @@ int64_t opal_pci_get_phb_diag_data(uint64_t phb_id, void *diag_buffer,
 int64_t opal_pci_get_phb_diag_data2(uint64_t phb_id, void *diag_buffer,
 				    uint64_t diag_buffer_len);
 int64_t opal_pci_fence_phb(uint64_t phb_id);
-int64_t opal_pci_reinit(uint64_t phb_id, uint8_t reinit_scope);
+int64_t opal_pci_reinit(uint64_t phb_id, uint8_t reinit_scope, uint32_t data);
 int64_t opal_pci_mask_pe_error(uint64_t phb_id, uint16_t pe_number, uint8_t error_type, uint8_t mask_action);
 int64_t opal_set_slot_led_status(uint64_t phb_id, uint64_t slot_id, uint8_t led_type, uint8_t led_action);
 int64_t opal_get_epow_status(__be64 *status);
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index ab91e6a..a0d4d9a 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -344,6 +344,27 @@ static int powernv_eeh_next_error(struct eeh_pe **pe)
 	return -EEXIST;
 }
 
+static int powernv_eeh_restore_config(struct device_node *dn)
+{
+	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	struct pnv_phb *phb;
+	s64 ret;
+
+	if (!edev)
+		return -EEXIST;
+
+	phb = edev->phb->private_data;
+	ret = opal_pci_reinit(phb->opal_id,
+			      OPAL_PCI_DEV, edev->config_addr);
+	if (ret) {
+		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
+			__func__, edev->config_addr, ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static struct eeh_ops powernv_eeh_ops = {
 	.name                   = "powernv",
 	.init                   = powernv_eeh_init,
@@ -360,7 +381,7 @@ static struct eeh_ops powernv_eeh_ops = {
 	.read_config            = pnv_pci_cfg_read,
 	.write_config           = pnv_pci_cfg_write,
 	.next_error		= powernv_eeh_next_error,
-	.restore_config		= NULL
+	.restore_config		= powernv_eeh_restore_config
 };
 
 /**
-- 
1.7.10.4
