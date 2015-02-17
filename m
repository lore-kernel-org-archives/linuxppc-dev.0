Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F1FF1A0DF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 20:02:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] powerpc/powernv: Move opal-api.h closer to the Skiboot
 version
Date: Tue, 17 Feb 2015 20:01:54 +1100
Message-Id: <1424163715-10370-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1424163715-10370-1-git-send-email-mpe@ellerman.id.au>
References: <1424163715-10370-1-git-send-email-mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, skiboot@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This commit gets opal-api.h to mostly match the version in Skiboot as of
commit ea7d806ab0ba.

The exceptions are things which are not (currently) used in Linux.

Most of this is just whitespace and a few things moving around. I think
the diff is readable.

Also OpalMessageType became opal_msg_type, requiring a change in the
Linux code.

Finally Skiboot and Linux disagree on CAPI vs CXL, because CAPI means
something else in Linux. To handle that we just point the Linux wrapper,
which is named "cxl" to the OPAL token OPAL_PCI_SET_PHB_CAPI_MODE.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/opal-api.h            | 158 ++++++++++++++-----------
 arch/powerpc/include/asm/opal.h                |   2 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +-
 arch/powerpc/platforms/powernv/opal.c          |   2 +-
 4 files changed, 90 insertions(+), 74 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index a90176a428ee..2984f486f3ba 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -1,7 +1,7 @@
 /*
- * PowerNV OPAL definitions.
+ * OPAL API definitions.
  *
- * Copyright 2011 IBM Corp.
+ * Copyright 2011-2015 IBM Corp.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -15,7 +15,7 @@
 /****** OPAL APIs ******/
 
 /* Return codes */
-#define OPAL_SUCCESS 		0
+#define OPAL_SUCCESS		0
 #define OPAL_PARAMETER		-1
 #define OPAL_BUSY		-2
 #define OPAL_PARTIAL		-3
@@ -31,6 +31,7 @@
 #define OPAL_HARDWARE_FROZEN	-13
 #define OPAL_WRONG_STATE	-14
 #define OPAL_ASYNC_COMPLETION	-15
+#define OPAL_EMPTY		-16
 #define OPAL_I2C_TIMEOUT	-17
 #define OPAL_I2C_INVALID_CMD	-18
 #define OPAL_I2C_LBUS_PARITY	-19
@@ -41,7 +42,8 @@
 #define OPAL_I2C_STOP_ERR	-24
 
 /* API Tokens (in r0) */
-#define OPAL_INVALID_CALL			-1
+#define OPAL_INVALID_CALL		       -1
+#define OPAL_TEST				0
 #define OPAL_CONSOLE_WRITE			1
 #define OPAL_CONSOLE_READ			2
 #define OPAL_RTC_READ				3
@@ -84,7 +86,7 @@
 #define OPAL_GET_MSI_64				40
 #define OPAL_START_CPU				41
 #define OPAL_QUERY_CPU_STATUS			42
-#define OPAL_WRITE_OPPANEL			43
+#define OPAL_WRITE_OPPANEL			43 /* unimplemented */
 #define OPAL_PCI_MAP_PE_DMA_WINDOW		44
 #define OPAL_PCI_MAP_PE_DMA_WINDOW_REAL		45
 #define OPAL_PCI_RESET				49
@@ -130,8 +132,10 @@
 #define OPAL_GET_PARAM				89
 #define OPAL_SET_PARAM				90
 #define OPAL_DUMP_RESEND			91
-#define OPAL_PCI_SET_PHB_CXL_MODE		93
+#define OPAL_ELOG_SEND				92	/* Deprecated */
+#define OPAL_PCI_SET_PHB_CAPI_MODE		93
 #define OPAL_DUMP_INFO2				94
+#define OPAL_WRITE_OPPANEL_ASYNC		95
 #define OPAL_PCI_ERR_INJECT			96
 #define OPAL_PCI_EEH_FREEZE_SET			97
 #define OPAL_HANDLE_HMI				98
@@ -141,19 +145,22 @@
 #define OPAL_UNREGISTER_DUMP_REGION		102
 #define OPAL_WRITE_TPO				103
 #define OPAL_READ_TPO				104
+#define OPAL_GET_DPO_STATUS			105
+#define OPAL_OLD_I2C_REQUEST			106	/* Deprecated */
 #define OPAL_IPMI_SEND				107
 #define OPAL_IPMI_RECV				108
 #define OPAL_I2C_REQUEST			109
+#define OPAL_LAST				109
 
 /* Device tree flags */
 
 /* Flags set in power-mgmt nodes in device tree if
  * respective idle states are supported in the platform.
  */
-#define OPAL_PM_NAP_ENABLED	0x00010000
-#define OPAL_PM_SLEEP_ENABLED	0x00020000
-#define OPAL_PM_WINKLE_ENABLED	0x00040000
-#define OPAL_PM_SLEEP_ENABLED_ER1	0x00080000
+#define OPAL_PM_NAP_ENABLED		0x00010000
+#define OPAL_PM_SLEEP_ENABLED		0x00020000
+#define OPAL_PM_WINKLE_ENABLED		0x00040000
+#define OPAL_PM_SLEEP_ENABLED_ER1	0x00080000 /* with workaround */
 
 #ifndef __ASSEMBLY__
 
@@ -242,7 +249,7 @@ enum OpalShpcLinkState {
 enum OpalMmioWindowType {
 	OPAL_M32_WINDOW_TYPE = 1,
 	OPAL_M64_WINDOW_TYPE = 2,
-	OPAL_IO_WINDOW_TYPE = 3
+	OPAL_IO_WINDOW_TYPE  = 3
 };
 
 enum OpalShpcSlotState {
@@ -251,35 +258,24 @@ enum OpalShpcSlotState {
 };
 
 enum OpalExceptionHandler {
-	OPAL_MACHINE_CHECK_HANDLER = 1,
+	OPAL_MACHINE_CHECK_HANDLER	    = 1,
 	OPAL_HYPERVISOR_MAINTENANCE_HANDLER = 2,
-	OPAL_SOFTPATCH_HANDLER = 3
+	OPAL_SOFTPATCH_HANDLER		    = 3
 };
 
 enum OpalPendingState {
-	OPAL_EVENT_OPAL_INTERNAL	= 0x1,
-	OPAL_EVENT_NVRAM		= 0x2,
-	OPAL_EVENT_RTC			= 0x4,
-	OPAL_EVENT_CONSOLE_OUTPUT	= 0x8,
-	OPAL_EVENT_CONSOLE_INPUT	= 0x10,
-	OPAL_EVENT_ERROR_LOG_AVAIL	= 0x20,
-	OPAL_EVENT_ERROR_LOG		= 0x40,
-	OPAL_EVENT_EPOW			= 0x80,
-	OPAL_EVENT_LED_STATUS		= 0x100,
-	OPAL_EVENT_PCI_ERROR		= 0x200,
-	OPAL_EVENT_DUMP_AVAIL		= 0x400,
-	OPAL_EVENT_MSG_PENDING		= 0x800,
-};
-
-enum OpalMessageType {
-	OPAL_MSG_ASYNC_COMP = 0,	/* params[0] = token, params[1] = rc,
-					 * additional params function-specific
-					 */
-	OPAL_MSG_MEM_ERR,
-	OPAL_MSG_EPOW,
-	OPAL_MSG_SHUTDOWN,		/* params[0] = 1 reboot, 0 shutdown */
-	OPAL_MSG_HMI_EVT,
-	OPAL_MSG_TYPE_MAX,
+	OPAL_EVENT_OPAL_INTERNAL   = 0x1,
+	OPAL_EVENT_NVRAM	   = 0x2,
+	OPAL_EVENT_RTC		   = 0x4,
+	OPAL_EVENT_CONSOLE_OUTPUT  = 0x8,
+	OPAL_EVENT_CONSOLE_INPUT   = 0x10,
+	OPAL_EVENT_ERROR_LOG_AVAIL = 0x20,
+	OPAL_EVENT_ERROR_LOG	   = 0x40,
+	OPAL_EVENT_EPOW		   = 0x80,
+	OPAL_EVENT_LED_STATUS	   = 0x100,
+	OPAL_EVENT_PCI_ERROR	   = 0x200,
+	OPAL_EVENT_DUMP_AVAIL	   = 0x400,
+	OPAL_EVENT_MSG_PENDING	   = 0x800,
 };
 
 enum OpalThreadStatus {
@@ -323,7 +319,7 @@ enum OpalMveEnableAction {
 	OPAL_ENABLE_MVE = 1
 };
 
-enum OpalM64EnableAction {
+enum OpalM64Action {
 	OPAL_DISABLE_M64 = 0,
 	OPAL_ENABLE_M64_SPLIT = 1,
 	OPAL_ENABLE_M64_NON_SPLIT = 2
@@ -339,12 +335,17 @@ enum OpalPciResetScope {
 };
 
 enum OpalPciReinitScope {
+	/*
+	 * Note: we chose values that do not overlap
+	 * OpalPciResetScope as OPAL v2 used the same
+	 * enum for both
+	 */
 	OPAL_REINIT_PCI_DEV = 1000
 };
 
 enum OpalPciResetState {
 	OPAL_DEASSERT_RESET = 0,
-	OPAL_ASSERT_RESET = 1
+	OPAL_ASSERT_RESET   = 1
 };
 
 enum OpalPciMaskAction {
@@ -381,11 +382,16 @@ enum OpalLPCAddressType {
 	OPAL_LPC_FW	= 2,
 };
 
-/* System parameter permission */
-enum OpalSysparamPerm {
-	OPAL_SYSPARAM_READ      = 0x1,
-	OPAL_SYSPARAM_WRITE     = 0x2,
-	OPAL_SYSPARAM_RW        = (OPAL_SYSPARAM_READ | OPAL_SYSPARAM_WRITE),
+enum opal_msg_type {
+	OPAL_MSG_ASYNC_COMP = 0,	/* params[0] = token, params[1] = rc,
+					 * additional params function-specific
+					 */
+	OPAL_MSG_MEM_ERR,
+	OPAL_MSG_EPOW,
+	OPAL_MSG_SHUTDOWN,		/* params[0] = 1 reboot, 0 shutdown */
+	OPAL_MSG_HMI_EVT,
+	OPAL_MSG_DPO,
+	OPAL_MSG_TYPE_MAX,
 };
 
 struct opal_msg {
@@ -394,15 +400,22 @@ struct opal_msg {
 	__be64 params[8];
 };
 
+/* System parameter permission */
+enum OpalSysparamPerm {
+	OPAL_SYSPARAM_READ  = 0x1,
+	OPAL_SYSPARAM_WRITE = 0x2,
+	OPAL_SYSPARAM_RW    = (OPAL_SYSPARAM_READ | OPAL_SYSPARAM_WRITE),
+};
+
 enum {
 	OPAL_IPMI_MSG_FORMAT_VERSION_1 = 1,
 };
 
 struct opal_ipmi_msg {
-	uint8_t		version;
-	uint8_t		netfn;
-	uint8_t		cmd;
-	uint8_t		data[];
+	uint8_t version;
+	uint8_t netfn;
+	uint8_t cmd;
+	uint8_t data[];
 };
 
 /* FSP memory errors handling */
@@ -413,7 +426,6 @@ enum OpalMemErr_Version {
 enum OpalMemErrType {
 	OPAL_MEM_ERR_TYPE_RESILIENCE	= 0,
 	OPAL_MEM_ERR_TYPE_DYN_DALLOC,
-	OPAL_MEM_ERR_TYPE_SCRUB,
 };
 
 /* Memory Reilience error type */
@@ -442,17 +454,17 @@ struct OpalMemoryErrorData {
 	union {
 		/* Memory Resilience corrected/uncorrected error info */
 		struct {
-			enum OpalMemErr_ResilErrType resil_err_type:8;
-			uint8_t		reserved_1[7];
-			__be64		physical_address_start;
-			__be64		physical_address_end;
+			enum OpalMemErr_ResilErrType	resil_err_type:8;
+			uint8_t				reserved_1[7];
+			__be64				physical_address_start;
+			__be64				physical_address_end;
 		} resilience;
 		/* Dynamic memory deallocation error info */
 		struct {
-			enum OpalMemErr_DynErrType dyn_err_type:8;
-			uint8_t		reserved_1[7];
-			__be64		physical_address_start;
-			__be64		physical_address_end;
+			enum OpalMemErr_DynErrType	dyn_err_type:8;
+			uint8_t				reserved_1[7];
+			__be64				physical_address_start;
+			__be64				physical_address_end;
 		} dyn_dealloc;
 	} u;
 };
@@ -487,6 +499,7 @@ enum OpalHMI_ErrType {
 	OpalHMI_ERROR_SCOM_FIR,
 	OpalHMI_ERROR_DEBUG_TRIG_FIR,
 	OpalHMI_ERROR_HYP_RESOURCE,
+	OpalHMI_ERROR_CAPP_RECOVERY,
 };
 
 struct OpalHMIEvent {
@@ -539,13 +552,13 @@ struct OpalIoP7IOCErrorData {
 			__be64 biLdcp2;		/* 3C0110, 3C0128 */
 			__be64 biFenceStatus;	/* 3C0130, 3C0130 */
 
-			    u8 biDownbound;	/* BI Downbound or Upbound */
+			uint8_t biDownbound;	/* BI Downbound or Upbound */
 		}bi;
 		struct OpalIoP7IOCCiErrorData {
 			__be64 ciPortStatus;	/* 3Dn008 */
 			__be64 ciPortLdcp;	/* 3Dn010 */
 
-			    u8 ciPort;		/* Index of CI port: 0/1 */
+			uint8_t ciPort;		/* Index of CI port: 0/1 */
 		}ci;
 	};
 };
@@ -568,14 +581,6 @@ enum {
 	OPAL_PHB3_NUM_PEST_REGS = 256
 };
 
-/* CAPI modes for PHB */
-enum {
-	OPAL_PHB_CAPI_MODE_PCIE         = 0,
-	OPAL_PHB_CAPI_MODE_CAPI         = 1,
-	OPAL_PHB_CAPI_MODE_SNOOP_OFF    = 2,
-	OPAL_PHB_CAPI_MODE_SNOOP_ON     = 3,
-};
-
 struct OpalIoPhbErrorCommon {
 	__be32 version;
 	__be32 ioType;
@@ -674,11 +679,10 @@ struct OpalIoPhb3ErrorData {
 	__be64 errorClass;
 	__be64 correlator;
 
+	/* PHB3 MMIO Error Regs */
 	__be64 nFir;			/* 000 */
 	__be64 nFirMask;		/* 003 */
 	__be64 nFirWOF;		/* 008 */
-
-	/* PHB3 MMIO Error Regs */
 	__be64 phbPlssr;		/* 120 */
 	__be64 phbCsr;		/* 110 */
 	__be64 lemFir;		/* C00 */
@@ -710,8 +714,8 @@ enum {
 };
 
 typedef struct oppanel_line {
-	const char * 	line;
-	uint64_t 	line_len;
+	__be64 line;
+	__be64 line_len;
 } oppanel_line_t;
 
 /*
@@ -726,7 +730,11 @@ struct opal_sg_entry {
 	__be64 length;
 };
 
-/* SG list */
+/*
+ * Candiate image SG list.
+ *
+ * length = VER | length
+ */
 struct opal_sg_list {
 	__be64 length;
 	__be64 next;
@@ -740,6 +748,14 @@ struct opal_sg_list {
 #define OPAL_DUMP_REGION_LOG_BUF		0x80
 #define OPAL_DUMP_REGION_HOST_END		0xFF
 
+/* CAPI modes for PHB */
+enum {
+	OPAL_PHB_CAPI_MODE_PCIE		= 0,
+	OPAL_PHB_CAPI_MODE_CAPI		= 1,
+	OPAL_PHB_CAPI_MODE_SNOOP_OFF    = 2,
+	OPAL_PHB_CAPI_MODE_SNOOP_ON	= 3,
+};
+
 /* OPAL I2C request */
 struct opal_i2c_request {
 	uint8_t	type;
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 65c89dd2f604..0ef0fd660ac6 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -208,7 +208,7 @@ extern void hvc_opal_init_early(void);
 extern int opal_notifier_register(struct notifier_block *nb);
 extern int opal_notifier_unregister(struct notifier_block *nb);
 
-extern int opal_message_notifier_register(enum OpalMessageType msg_type,
+extern int opal_message_notifier_register(enum opal_msg_type msg_type,
 						struct notifier_block *nb);
 extern void opal_notifier_enable(void);
 extern void opal_notifier_disable(void);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 0509bca5e830..b23fe7c4bf12 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -286,7 +286,7 @@ OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
 OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
-OPAL_CALL(opal_pci_set_phb_cxl_mode,		OPAL_PCI_SET_PHB_CXL_MODE);
+OPAL_CALL(opal_pci_set_phb_cxl_mode,		OPAL_PCI_SET_PHB_CAPI_MODE);
 OPAL_CALL(opal_tpo_write,			OPAL_WRITE_TPO);
 OPAL_CALL(opal_tpo_read,			OPAL_READ_TPO);
 OPAL_CALL(opal_ipmi_send,			OPAL_IPMI_SEND);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 18fd4e71c9c1..d8a7dd80d32e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -302,7 +302,7 @@ void opal_notifier_disable(void)
  * Opal message notifier based on message type. Allow subscribers to get
  * notified for specific messgae type.
  */
-int opal_message_notifier_register(enum OpalMessageType msg_type,
+int opal_message_notifier_register(enum opal_msg_type msg_type,
 					struct notifier_block *nb)
 {
 	if (!nb) {
-- 
2.1.0
