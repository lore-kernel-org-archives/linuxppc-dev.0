Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E0EE2C00D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 13:35:17 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 14 May 2013 23:35:14 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7F37638C8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 23:35:11 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4F3ZBpZ327214
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 23:35:11 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4F3ZBOn006584
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 00:35:11 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/22] powerpc/eeh: Sync OPAL API with firmware
Date: Wed, 15 May 2013 11:34:47 +0800
Message-Id: <1368588898-16224-12-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch synchronizes OPAL APIs between kernel and firmware.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                |  110 +++++++++++++++++++----
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 +
 2 files changed, 93 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index b6c8b58..ebebac7 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -117,6 +117,11 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_SET_SLOT_LED_STATUS		55
 #define OPAL_GET_EPOW_STATUS			56
 #define OPAL_SET_SYSTEM_ATTENTION_LED		57
+#define OPAL_RESERVED1				58
+#define OPAL_RESERVED2				59
+#define OPAL_PCI_NEXT_ERROR			60
+#define OPAL_PCI_EEH_FREEZE_STATUS2		61
+#define OPAL_PCI_POLL				62
 #define OPAL_PCI_MSI_EOI			63
 
 #ifndef __ASSEMBLY__
@@ -125,6 +130,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 enum OpalVendorApiTokens {
 	OPAL_START_VENDOR_API_RANGE = 1000, OPAL_END_VENDOR_API_RANGE = 1999
 };
+
 enum OpalFreezeState {
 	OPAL_EEH_STOPPED_NOT_FROZEN = 0,
 	OPAL_EEH_STOPPED_MMIO_FREEZE = 1,
@@ -134,55 +140,69 @@ enum OpalFreezeState {
 	OPAL_EEH_STOPPED_TEMP_UNAVAIL = 5,
 	OPAL_EEH_STOPPED_PERM_UNAVAIL = 6
 };
+
 enum OpalEehFreezeActionToken {
 	OPAL_EEH_ACTION_CLEAR_FREEZE_MMIO = 1,
 	OPAL_EEH_ACTION_CLEAR_FREEZE_DMA = 2,
 	OPAL_EEH_ACTION_CLEAR_FREEZE_ALL = 3
 };
+
 enum OpalPciStatusToken {
-	OPAL_EEH_PHB_NO_ERROR = 0,
-	OPAL_EEH_PHB_FATAL = 1,
-	OPAL_EEH_PHB_RECOVERABLE = 2,
-	OPAL_EEH_PHB_BUS_ERROR = 3,
-	OPAL_EEH_PCI_NO_DEVSEL = 4,
-	OPAL_EEH_PCI_TA = 5,
-	OPAL_EEH_PCIEX_UR = 6,
-	OPAL_EEH_PCIEX_CA = 7,
-	OPAL_EEH_PCI_MMIO_ERROR = 8,
-	OPAL_EEH_PCI_DMA_ERROR = 9
+	OPAL_EEH_NO_ERROR	= 0,
+	OPAL_EEH_IOC_ERROR	= 1,
+	OPAL_EEH_PHB_ERROR	= 2,
+	OPAL_EEH_PE_ERROR	= 3,
+	OPAL_EEH_PE_MMIO_ERROR	= 4,
+	OPAL_EEH_PE_DMA_ERROR	= 5
 };
+
+enum OpalPciErrorSeverity {
+	OPAL_EEH_SEV_NO_ERROR	= 0,
+	OPAL_EEH_SEV_IOC_DEAD	= 1,
+	OPAL_EEH_SEV_PHB_DEAD	= 2,
+	OPAL_EEH_SEV_PHB_FENCED	= 3,
+	OPAL_EEH_SEV_PE_ER	= 4,
+	OPAL_EEH_SEV_INF	= 5
+};
+
 enum OpalShpcAction {
 	OPAL_SHPC_GET_LINK_STATE = 0,
 	OPAL_SHPC_GET_SLOT_STATE = 1
 };
+
 enum OpalShpcLinkState {
 	OPAL_SHPC_LINK_DOWN = 0,
 	OPAL_SHPC_LINK_UP = 1
 };
+
 enum OpalMmioWindowType {
 	OPAL_M32_WINDOW_TYPE = 1,
 	OPAL_M64_WINDOW_TYPE = 2,
 	OPAL_IO_WINDOW_TYPE = 3
 };
+
 enum OpalShpcSlotState {
 	OPAL_SHPC_DEV_NOT_PRESENT = 0,
 	OPAL_SHPC_DEV_PRESENT = 1
 };
+
 enum OpalExceptionHandler {
 	OPAL_MACHINE_CHECK_HANDLER = 1,
 	OPAL_HYPERVISOR_MAINTENANCE_HANDLER = 2,
 	OPAL_SOFTPATCH_HANDLER = 3
 };
+
 enum OpalPendingState {
-	OPAL_EVENT_OPAL_INTERNAL = 0x1,
-	OPAL_EVENT_NVRAM = 0x2,
-	OPAL_EVENT_RTC = 0x4,
-	OPAL_EVENT_CONSOLE_OUTPUT = 0x8,
-	OPAL_EVENT_CONSOLE_INPUT = 0x10,
-	OPAL_EVENT_ERROR_LOG_AVAIL = 0x20,
-	OPAL_EVENT_ERROR_LOG = 0x40,
-	OPAL_EVENT_EPOW = 0x80,
-	OPAL_EVENT_LED_STATUS = 0x100
+	OPAL_EVENT_OPAL_INTERNAL	= 0x1,
+	OPAL_EVENT_NVRAM		= 0x2,
+	OPAL_EVENT_RTC			= 0x4,
+	OPAL_EVENT_CONSOLE_OUTPUT	= 0x8,
+	OPAL_EVENT_CONSOLE_INPUT	= 0x10,
+	OPAL_EVENT_ERROR_LOG_AVAIL	= 0x20,
+	OPAL_EVENT_ERROR_LOG		= 0x40,
+	OPAL_EVENT_EPOW			= 0x80,
+	OPAL_EVENT_LED_STATUS		= 0x100,
+	OPAL_EVENT_PCI_ERROR		= 0x200
 };
 
 /* Machine check related definitions */
@@ -363,6 +383,55 @@ struct opal_machine_check_event {
 	} u;
 };
 
+enum {
+	OPAL_P7IOC_DIAG_TYPE_NONE	= 0,
+	OPAL_P7IOC_DIAG_TYPE_RGC	= 1,
+	OPAL_P7IOC_DIAG_TYPE_BI		= 2,
+	OPAL_P7IOC_DIAG_TYPE_CI		= 3,
+	OPAL_P7IOC_DIAG_TYPE_MISC	= 4,
+	OPAL_P7IOC_DIAG_TYPE_I2C	= 5,
+	OPAL_P7IOC_DIAG_TYPE_LAST	= 6
+};
+
+struct OpalIoP7IOCErrorData {
+	uint16_t type;
+
+	/* GEM */
+	uint64_t gemXfir;
+	uint64_t gemRfir;
+	uint64_t gemRirqfir;
+	uint64_t gemMask;
+	uint64_t gemRwof;
+
+	/* LEM */
+	uint64_t lemFir;
+	uint64_t lemErrMask;
+	uint64_t lemAction0;
+	uint64_t lemAction1;
+	uint64_t lemWof;
+
+	union {
+		struct OpalIoP7IOCRgcErrorData {
+			uint64_t rgcStatus;		/* 3E1C10 */
+			uint64_t rgcLdcp;		/* 3E1C18 */
+		}rgc;
+		struct OpalIoP7IOCBiErrorData {
+			uint64_t biLdcp0;		/* 3C0100, 3C0118 */
+			uint64_t biLdcp1;		/* 3C0108, 3C0120 */
+			uint64_t biLdcp2;		/* 3C0110, 3C0128 */
+			uint64_t biFenceStatus;		/* 3C0130, 3C0130 */
+
+			uint8_t  biDownbound;		/* BI Downbound or Upbound */
+		}bi;
+		struct OpalIoP7IOCCiErrorData {
+			uint64_t ciPortStatus;		/* 3Dn008 */
+			uint64_t ciPortLdcp;		/* 3Dn010 */
+
+			uint8_t	 ciPort;		/* Index of CI port: 0/1 */
+		}ci;
+	};
+};
+
 /**
  * This structure defines the overlay which will be used to store PHB error
  * data upon request.
@@ -537,6 +606,9 @@ int64_t opal_pci_mask_pe_error(uint64_t phb_id, uint16_t pe_number, uint8_t erro
 int64_t opal_set_slot_led_status(uint64_t phb_id, uint64_t slot_id, uint8_t led_type, uint8_t led_action);
 int64_t opal_get_epow_status(uint64_t *status);
 int64_t opal_set_system_attention_led(uint8_t led_action);
+int64_t opal_pci_next_error(uint64_t phb_id, uint64_t *first_frozen_pe,
+			    uint16_t *pci_error_type, uint16_t *severity);
+int64_t opal_pci_poll(uint64_t phb_id);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 6fabe92..2704c28 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -107,4 +107,6 @@ OPAL_CALL(opal_pci_mask_pe_error,		OPAL_PCI_MASK_PE_ERROR);
 OPAL_CALL(opal_set_slot_led_status,		OPAL_SET_SLOT_LED_STATUS);
 OPAL_CALL(opal_get_epow_status,			OPAL_GET_EPOW_STATUS);
 OPAL_CALL(opal_set_system_attention_led,	OPAL_SET_SYSTEM_ATTENTION_LED);
+OPAL_CALL(opal_pci_next_error,			OPAL_PCI_NEXT_ERROR);
+OPAL_CALL(opal_pci_poll,			OPAL_PCI_POLL);
 OPAL_CALL(opal_pci_msi_eoi,			OPAL_PCI_MSI_EOI);
-- 
1.7.5.4
