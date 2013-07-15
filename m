Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8BBC52C0176
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 13:03:27 +1000 (EST)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r6F33KdH013377
 for <linuxppc-dev@ozlabs.org>; Sun, 14 Jul 2013 22:03:24 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/8] powerpc/powernv: Update opal.h to add new LPC and XSCOM
 functions
Date: Mon, 15 Jul 2013 13:03:09 +1000
Message-Id: <1373857395-2084-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
References: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h                | 23 +++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 029fe85..c701e2b 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -124,6 +124,10 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_PCI_POLL				62
 #define OPAL_PCI_MSI_EOI			63
 #define OPAL_PCI_GET_PHB_DIAG_DATA2		64
+#define OPAL_XSCOM_READ				65
+#define OPAL_XSCOM_WRITE			66
+#define OPAL_LPC_READ				67
+#define OPAL_LPC_WRITE				68
 
 #ifndef __ASSEMBLY__
 
@@ -337,6 +341,17 @@ enum OpalEpowStatus {
 	OPAL_EPOW_OVER_INTERNAL_TEMP = 3
 };
 
+/*
+ * Address cycle types for LPC accesses. These also correspond
+ * to the content of the first cell of the "reg" property for
+ * device nodes on the LPC bus
+ */
+enum OpalLPCAddressType {
+	OPAL_LPC_MEM	= 0,
+	OPAL_LPC_IO	= 1,
+	OPAL_LPC_FW	= 2,
+};
+
 struct opal_machine_check_event {
 	enum OpalMCE_Version	version:8;	/* 0x00 */
 	uint8_t			in_use;		/* 0x01 */
@@ -632,6 +647,14 @@ int64_t opal_pci_next_error(uint64_t phb_id, uint64_t *first_frozen_pe,
 			    uint16_t *pci_error_type, uint16_t *severity);
 int64_t opal_pci_poll(uint64_t phb_id);
 
+int64_t opal_xscom_read(uint32_t gcid, uint32_t pcb_addr, uint64_t *val);
+int64_t opal_xscom_write(uint32_t gcid, uint32_t pcb_addr, uint64_t val);
+
+int64_t opal_lpc_write(uint32_t chip_id, enum OpalLPCAddressType addr_type,
+		       uint32_t addr, uint32_t data, uint32_t sz);
+int64_t opal_lpc_read(uint32_t chip_id, enum OpalLPCAddressType addr_type,
+		      uint32_t addr, uint32_t *data, uint32_t sz);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
 
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index e88863f..42c06fb 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -111,3 +111,7 @@ OPAL_CALL(opal_pci_next_error,			OPAL_PCI_NEXT_ERROR);
 OPAL_CALL(opal_pci_poll,			OPAL_PCI_POLL);
 OPAL_CALL(opal_pci_msi_eoi,			OPAL_PCI_MSI_EOI);
 OPAL_CALL(opal_pci_get_phb_diag_data2,		OPAL_PCI_GET_PHB_DIAG_DATA2);
+OPAL_CALL(opal_xscom_read,			OPAL_XSCOM_READ);
+OPAL_CALL(opal_xscom_write,			OPAL_XSCOM_WRITE);
+OPAL_CALL(opal_lpc_read,			OPAL_LPC_READ);
+OPAL_CALL(opal_lpc_write,			OPAL_LPC_WRITE);
-- 
1.8.1.2
