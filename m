Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 32978B6F7B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 15:22:54 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAU4Mob1016497
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 22:22:51 -0600
Message-ID: <1322626970.21641.25.camel@pasglop>
Subject: [PATCH 1/3] powerpc/powernv: Update OPAL interfaces
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 30 Nov 2011 15:22:50 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds some more interfaces for OPAL v2

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h                |  131 +++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S |    8 ++
 arch/powerpc/platforms/powernv/pci-ioda.c      |    4 +-
 3 files changed, 137 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 2893e8f..a4b28f1 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -109,6 +109,14 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_PCI_MAP_PE_DMA_WINDOW		44
 #define OPAL_PCI_MAP_PE_DMA_WINDOW_REAL		45
 #define OPAL_PCI_RESET				49
+#define OPAL_PCI_GET_HUB_DIAG_DATA		50
+#define OPAL_PCI_GET_PHB_DIAG_DATA		51
+#define OPAL_PCI_FENCE_PHB			52
+#define OPAL_PCI_REINIT				53
+#define OPAL_PCI_MASK_PE_ERROR			54
+#define OPAL_SET_SLOT_LED_STATUS		55
+#define OPAL_GET_EPOW_STATUS			56
+#define OPAL_SET_SYSTEM_ATTENTION_LED		57
 
 #ifndef __ASSEMBLY__
 
@@ -169,7 +177,11 @@ enum OpalPendingState {
 	OPAL_EVENT_NVRAM = 0x2,
 	OPAL_EVENT_RTC = 0x4,
 	OPAL_EVENT_CONSOLE_OUTPUT = 0x8,
-	OPAL_EVENT_CONSOLE_INPUT = 0x10
+	OPAL_EVENT_CONSOLE_INPUT = 0x10,
+	OPAL_EVENT_ERROR_LOG_AVAIL = 0x20,
+	OPAL_EVENT_ERROR_LOG = 0x40,
+	OPAL_EVENT_EPOW = 0x80,
+	OPAL_EVENT_LED_STATUS = 0x100
 };
 
 /* Machine check related definitions */
@@ -258,13 +270,49 @@ enum OpalPeAction {
 	OPAL_MAP_PE = 1
 };
 
+enum OpalPeltvAction {
+	OPAL_REMOVE_PE_FROM_DOMAIN = 0,
+	OPAL_ADD_PE_TO_DOMAIN = 1
+};
+
+enum OpalMveEnableAction {
+	OPAL_DISABLE_MVE = 0,
+	OPAL_ENABLE_MVE = 1
+};
+
 enum OpalPciResetAndReinitScope {
 	OPAL_PHB_COMPLETE = 1, OPAL_PCI_LINK = 2, OPAL_PHB_ERROR = 3,
 	OPAL_PCI_HOT_RESET = 4, OPAL_PCI_FUNDAMENTAL_RESET = 5,
-	OPAL_PCI_IODA_RESET = 6,
+	OPAL_PCI_IODA_TABLE_RESET = 6,
+};
+
+enum OpalPciResetState {
+	OPAL_DEASSERT_RESET = 0,
+	OPAL_ASSERT_RESET = 1
 };
 
-enum OpalPciResetState { OPAL_DEASSERT_RESET = 0, OPAL_ASSERT_RESET = 1 };
+enum OpalPciMaskAction {
+	OPAL_UNMASK_ERROR_TYPE = 0,
+	OPAL_MASK_ERROR_TYPE = 1
+};
+
+enum OpalSlotLedType {
+	OPAL_SLOT_LED_ID_TYPE = 0,
+	OPAL_SLOT_LED_FAULT_TYPE = 1
+};
+
+enum OpalLedAction {
+	OPAL_TURN_OFF_LED = 0,
+	OPAL_TURN_ON_LED = 1,
+	OPAL_QUERY_LED_STATE_AFTER_BUSY = 2
+};
+
+enum OpalEpowStatus {
+	OPAL_EPOW_NONE = 0,
+	OPAL_EPOW_UPS = 1,
+	OPAL_EPOW_OVER_AMBIENT_TEMP = 2,
+	OPAL_EPOW_OVER_INTERNAL_TEMP = 3
+};
 
 struct opal_machine_check_event {
 	enum OpalMCE_Version	version:8;	/* 0x00 */
@@ -314,8 +362,74 @@ struct opal_machine_check_event {
 	} u;
 };
 
+/**
+ * This structure defines the overlay which will be used to store PHB error
+ * data upon request.
+ */
+enum {
+	OPAL_P7IOC_NUM_PEST_REGS = 128,
+};
+
+struct OpalIoP7IOCPhbErrorData {
+	uint32_t brdgCtl;
+
+	// P7IOC utl regs
+	uint32_t portStatusReg;
+	uint32_t rootCmplxStatus;
+	uint32_t busAgentStatus;
+
+	// P7IOC cfg regs
+	uint32_t deviceStatus;
+	uint32_t slotStatus;
+	uint32_t linkStatus;
+	uint32_t devCmdStatus;
+	uint32_t devSecStatus;
+
+	// cfg AER regs
+	uint32_t rootErrorStatus;
+	uint32_t uncorrErrorStatus;
+	uint32_t corrErrorStatus;
+	uint32_t tlpHdr1;
+	uint32_t tlpHdr2;
+	uint32_t tlpHdr3;
+	uint32_t tlpHdr4;
+	uint32_t sourceId;
+
+	uint32_t rsv3;
+
+	// Record data about the call to allocate a buffer.
+	uint64_t errorClass;
+	uint64_t correlator;
+
+	//P7IOC MMIO Error Regs
+	uint64_t p7iocPlssr;                // n120
+	uint64_t p7iocCsr;                  // n110
+	uint64_t lemFir;                    // nC00
+	uint64_t lemErrorMask;              // nC18
+	uint64_t lemWOF;                    // nC40
+	uint64_t phbErrorStatus;            // nC80
+	uint64_t phbFirstErrorStatus;       // nC88
+	uint64_t phbErrorLog0;              // nCC0
+	uint64_t phbErrorLog1;              // nCC8
+	uint64_t mmioErrorStatus;           // nD00
+	uint64_t mmioFirstErrorStatus;      // nD08
+	uint64_t mmioErrorLog0;             // nD40
+	uint64_t mmioErrorLog1;             // nD48
+	uint64_t dma0ErrorStatus;           // nD80
+	uint64_t dma0FirstErrorStatus;      // nD88
+	uint64_t dma0ErrorLog0;             // nDC0
+	uint64_t dma0ErrorLog1;             // nDC8
+	uint64_t dma1ErrorStatus;           // nE00
+	uint64_t dma1FirstErrorStatus;      // nE08
+	uint64_t dma1ErrorLog0;             // nE40
+	uint64_t dma1ErrorLog1;             // nE48
+	uint64_t pestA[OPAL_P7IOC_NUM_PEST_REGS];
+	uint64_t pestB[OPAL_P7IOC_NUM_PEST_REGS];
+};
+
 typedef struct oppanel_line {
-	/* XXX */
+	const char * 	line;
+	uint64_t 	line_len;
 } oppanel_line_t;
 
 /* API functions */
@@ -413,6 +527,15 @@ int64_t opal_pci_map_pe_dma_window_real(uint64_t phb_id, uint16_t pe_number,
 					uint64_t pci_mem_size);
 int64_t opal_pci_reset(uint64_t phb_id, uint8_t reset_scope, uint8_t assert_state);
 
+int64_t opal_pci_get_hub_diag_data(uint64_t hub_id, void *diag_buffer, uint64_t diag_buffer_len);
+int64_t opal_pci_get_phb_diag_data(uint64_t phb_id, void *diag_buffer, uint64_t diag_buffer_len);
+int64_t opal_pci_fence_phb(uint64_t phb_id);
+int64_t opal_pci_reinit(uint64_t phb_id, uint8_t reinit_scope);
+int64_t opal_pci_mask_pe_error(uint64_t phb_id, uint16_t pe_number, uint8_t error_type, uint8_t mask_action);
+int64_t opal_set_slot_led_status(uint64_t phb_id, uint64_t slot_id, uint8_t led_type, uint8_t led_action);
+int64_t opal_get_epow_status(uint64_t *status);
+int64_t opal_set_system_attention_led(uint8_t led_action);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
 
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 4a3f46d..3bb07e5 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -99,3 +99,11 @@ OPAL_CALL(opal_write_oppanel,			OPAL_WRITE_OPPANEL);
 OPAL_CALL(opal_pci_map_pe_dma_window,		OPAL_PCI_MAP_PE_DMA_WINDOW);
 OPAL_CALL(opal_pci_map_pe_dma_window_real,	OPAL_PCI_MAP_PE_DMA_WINDOW_REAL);
 OPAL_CALL(opal_pci_reset,			OPAL_PCI_RESET);
+OPAL_CALL(opal_pci_get_hub_diag_data,		OPAL_PCI_GET_HUB_DIAG_DATA);
+OPAL_CALL(opal_pci_get_phb_diag_data,		OPAL_PCI_GET_PHB_DIAG_DATA);
+OPAL_CALL(opal_pci_fence_phb,			OPAL_PCI_FENCE_PHB);
+OPAL_CALL(opal_pci_reinit,			OPAL_PCI_REINIT);
+OPAL_CALL(opal_pci_mask_pe_error,		OPAL_PCI_MASK_PE_ERROR);
+OPAL_CALL(opal_set_slot_led_status,		OPAL_SET_SLOT_LED_STATUS);
+OPAL_CALL(opal_get_epow_status,			OPAL_GET_EPOW_STATUS);
+OPAL_CALL(opal_set_system_attention_led,	OPAL_SET_SYSTEM_ATTENTION_LED);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index cf89f30..425c2b2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1294,9 +1294,9 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
-	rc = opal_pci_reset(phb_id, OPAL_PCI_IODA_RESET, OPAL_ASSERT_RESET);
+	rc = opal_pci_reset(phb_id, OPAL_PCI_IODA_TABLE_RESET, OPAL_ASSERT_RESET);
 	if (rc)
-		pr_warning("  OPAL Error %ld performing IODA reset !\n", rc);
+		pr_warning("  OPAL Error %ld performing IODA table reset !\n", rc);
 	opal_pci_set_pe(phb_id, 0, 0, 7, 1, 1 , OPAL_MAP_PE);
 }
 
-- 
1.7.7.2
