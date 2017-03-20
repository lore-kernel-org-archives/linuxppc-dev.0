Return-Path: <srs0=i+vg=25=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmmlr3RGnzDqbY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:50:00 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vmmlr2tgFz8t4P
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:50:00 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vmmlp5XDpz9s2s
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2017 17:49:58 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 02/12] powerpc: Sync opal-api.h
Date: Mon, 20 Mar 2017 17:49:04 +1100
Message-Id: <20170320064914.4437-2-benh@kernel.crashing.org>
In-Reply-To: <20170320064914.4437-1-benh@kernel.crashing.org>
References: <20170320064914.4437-1-benh@kernel.crashing.org>
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
 arch/powerpc/include/asm/opal-api.h            | 302 ++++++++++++++++++++-----
 arch/powerpc/include/asm/opal.h                |  36 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  15 ++
 3 files changed, 302 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index a0aa285..a6053a6 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -40,6 +40,16 @@
 #define OPAL_I2C_ARBT_LOST	-22
 #define OPAL_I2C_NACK_RCVD	-23
 #define OPAL_I2C_STOP_ERR	-24
+#define OPAL_XSCOM_BUSY		OPAL_BUSY
+#define OPAL_XSCOM_CHIPLET_OFF	OPAL_WRONG_STATE
+#define OPAL_XSCOM_PARTIAL_GOOD	-25
+#define OPAL_XSCOM_ADDR_ERROR	-26
+#define OPAL_XSCOM_CLOCK_ERROR	-27
+#define OPAL_XSCOM_PARITY_ERROR	-28
+#define OPAL_XSCOM_TIMEOUT	-29
+#define OPAL_XSCOM_CTR_OFFLINED	-30
+#define OPAL_XIVE_PROVISIONING	-31
+#define OPAL_XIVE_FREE_ACTIVE	-32
 
 /* API Tokens (in r0) */
 #define OPAL_INVALID_CALL		       -1
@@ -168,7 +178,24 @@
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
 #define OPAL_NMMU_SET_PTCR			127
-#define OPAL_LAST				127
+#define OPAL_XIVE_RESET				128
+#define OPAL_XIVE_GET_IRQ_INFO			129
+#define OPAL_XIVE_GET_IRQ_CONFIG		130
+#define OPAL_XIVE_SET_IRQ_CONFIG		131
+#define OPAL_XIVE_GET_QUEUE_INFO		132
+#define OPAL_XIVE_SET_QUEUE_INFO		133
+#define OPAL_XIVE_DONATE_PAGE			134
+#define OPAL_XIVE_ALLOCATE_VP_BLOCK		135
+#define OPAL_XIVE_FREE_VP_BLOCK			136
+#define OPAL_XIVE_GET_VP_INFO			137
+#define OPAL_XIVE_SET_VP_INFO			138
+#define OPAL_XIVE_ALLOCATE_IRQ			139
+#define OPAL_XIVE_FREE_IRQ			140
+#define OPAL_XIVE_SYNC				141
+#define OPAL_XIVE_DUMP				142
+#define OPAL_XIVE_RESERVED3			143
+#define OPAL_XIVE_RESERVED4			144
+#define OPAL_LAST				144
 
 /* Device tree flags */
 
@@ -176,14 +203,34 @@
  * Flags set in power-mgmt nodes in device tree describing
  * idle states that are supported in the platform.
  */
-
-#define OPAL_PM_TIMEBASE_STOP		0x00000002
-#define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000
+#define OPAL_PM_DEC_STOP		0x00000001 /* Decrementer would stop */
+#define OPAL_PM_TIMEBASE_STOP		0x00000002 /* Needs timebase restore */
+#define OPAL_PM_LOSE_USER_CONTEXT	0x00001000 /* Restore GPRs like nap */
+#define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000 /* Restore hypervisor
+						  resource from PACA pointer */
 #define OPAL_PM_LOSE_FULL_CONTEXT	0x00004000
 #define OPAL_PM_NAP_ENABLED		0x00010000
 #define OPAL_PM_SLEEP_ENABLED		0x00020000
 #define OPAL_PM_WINKLE_ENABLED		0x00040000
 #define OPAL_PM_SLEEP_ENABLED_ER1	0x00080000 /* with workaround */
+#define OPAL_USE_PMICR			0x00800000 /* Use SPR PMICR instruction */
+
+#define OPAL_PM_FASTSLEEP_PMICR		0x0000002000000000UL
+#define OPAL_PM_DEEPSLEEP_PMICR		0x0000003000000000UL
+#define OPAL_PM_SLEEP_PMICR_MASK	0x0000003000000000UL
+
+#define OPAL_PM_FASTWINKLE_PMICR	0x0000000000200000UL
+#define OPAL_PM_DEEPWINKLE_PMICR	0x0000000000300000UL
+#define OPAL_PM_WINKLE_PMICR_MASK	0x0000000000300000UL
+
+
+/*
+ * Flags for stop states. Use 2 bits to distinguish between
+ * deep and fast states. Deep states result in full context
+ * loss thereby requiring slw to partially restore state
+ * whereas fast state can function without the presence of
+ * slw.
+ */
 #define OPAL_PM_STOP_INST_FAST		0x00100000
 #define OPAL_PM_STOP_INST_DEEP		0x00200000
 
@@ -197,6 +244,10 @@
 #ifndef __ASSEMBLY__
 
 /* Other enums */
+enum OpalVendorApiTokens {
+	OPAL_START_VENDOR_API_RANGE = 1000, OPAL_END_VENDOR_API_RANGE = 1999
+};
+
 enum OpalFreezeState {
 	OPAL_EEH_STOPPED_NOT_FROZEN = 0,
 	OPAL_EEH_STOPPED_MMIO_FREEZE = 1,
@@ -264,12 +315,36 @@ enum OpalErrinjectFunc {
 	OPAL_ERR_INJECT_FUNC_IOA_DMA_WR_TARGET	= 19,
 };
 
+enum OpalShpcAction {
+	OPAL_SHPC_GET_LINK_STATE = 0,
+	OPAL_SHPC_GET_SLOT_STATE = 1
+};
+
+enum OpalShpcLinkState {
+	OPAL_SHPC_LINK_DOWN	  = 0,
+	OPAL_SHPC_LINK_UP_x1	  = 1,
+	OPAL_SHPC_LINK_UP_x2	  = 2,
+	OPAL_SHPC_LINK_UP_x4	  = 4,
+	OPAL_SHPC_LINK_UP_x8	  = 8,
+	OPAL_SHPC_LINK_UP_x16	  = 16,
+	OPAL_SHPC_LINK_UP_x32	  = 32
+};
+
 enum OpalMmioWindowType {
 	OPAL_M32_WINDOW_TYPE = 1,
 	OPAL_M64_WINDOW_TYPE = 2,
 	OPAL_IO_WINDOW_TYPE  = 3
 };
 
+enum OpalShpcSlotState {
+	OPAL_SHPC_DEV_NOT_PRESENT = 0,
+	OPAL_SHPC_DEV_PRESENT	  = 1
+};
+enum OpalShpcPowerState {
+	OPAL_SHPC_POWER_OFF	  = 0,
+	OPAL_SHPC_POWER_ON	  = 1
+};
+
 enum OpalExceptionHandler {
 	OPAL_MACHINE_CHECK_HANDLER	    = 1,
 	OPAL_HYPERVISOR_MAINTENANCE_HANDLER = 2,
@@ -361,6 +436,11 @@ enum OpalPciResetState {
 	OPAL_ASSERT_RESET   = 1
 };
 
+enum OpalPciMaskAction {
+	OPAL_UNMASK_ERROR_TYPE = 0,
+	OPAL_MASK_ERROR_TYPE = 1
+};
+
 enum OpalPciSlotPresence {
 	OPAL_PCI_SLOT_EMPTY	= 0,
 	OPAL_PCI_SLOT_PRESENT	= 1
@@ -385,6 +465,18 @@ enum OpalSlotLedState {
 	OPAL_SLOT_LED_STATE_ON = 1	/* LED is ON */
 };
 
+enum OpalEpowStatus {
+	OPAL_EPOW_NONE = 0,
+	OPAL_EPOW_UPS = 1,
+	OPAL_EPOW_OVER_AMBIENT_TEMP = 2,
+	OPAL_EPOW_OVER_INTERNAL_TEMP = 3
+};
+
+enum OpalCheckTokenStatus {
+	OPAL_TOKEN_ABSENT = 0,
+	OPAL_TOKEN_PRESENT = 1
+};
+
 /*
  * Address cycle types for LPC accesses. These also correspond
  * to the content of the first cell of the "reg" property for
@@ -434,6 +526,46 @@ struct opal_ipmi_msg {
 	uint8_t data[];
 };
 
+/*
+ * EPOW status sharing (OPAL and the host)
+ *
+ * The host will pass on OPAL, a buffer of length OPAL_SYSEPOW_MAX
+ * with individual elements being 16 bits wide to fetch the system
+ * wide EPOW status. Each element in the buffer will contain the
+ * EPOW status in it's bit representation for a particular EPOW sub
+ * class as defined here. So multiple detailed EPOW status bits
+ * specific for any sub class can be represented in a single buffer
+ * element as it's bit representation.
+ */
+
+/* System EPOW type */
+enum OpalSysEpow {
+	OPAL_SYSEPOW_POWER	= 0,	/* Power EPOW */
+	OPAL_SYSEPOW_TEMP	= 1,	/* Temperature EPOW */
+	OPAL_SYSEPOW_COOLING	= 2,	/* Cooling EPOW */
+	OPAL_SYSEPOW_MAX	= 3,	/* Max EPOW categories */
+};
+
+/* Power EPOW */
+enum OpalSysPower {
+	OPAL_SYSPOWER_UPS	= 0x0001, /* System on UPS power */
+	OPAL_SYSPOWER_CHNG	= 0x0002, /* System power configuration change */
+	OPAL_SYSPOWER_FAIL	= 0x0004, /* System impending power failure */
+	OPAL_SYSPOWER_INCL	= 0x0008, /* System incomplete power */
+};
+
+/* Temperature EPOW */
+enum OpalSysTemp {
+	OPAL_SYSTEMP_AMB	= 0x0001, /* System over ambient temperature */
+	OPAL_SYSTEMP_INT	= 0x0002, /* System over internal temperature */
+	OPAL_SYSTEMP_HMD	= 0x0004, /* System over ambient humidity */
+};
+
+/* Cooling EPOW */
+enum OpalSysCooling {
+	OPAL_SYSCOOL_INSF	= 0x0001, /* System insufficient cooling */
+};
+
 /* FSP memory errors handling */
 enum OpalMemErr_Version {
 	OpalMemErr_V1 = 1,
@@ -456,6 +588,11 @@ enum OpalMemErr_DynErrType {
 	OPAL_MEM_DYNAMIC_DEALLOC	= 0,
 };
 
+/* OpalMemoryErrorData->flags */
+#define OPAL_MEM_CORRECTED_ERROR	0x0001
+#define OPAL_MEM_THRESHOLD_EXCEEDED	0x0002
+#define OPAL_MEM_ACK_REQUIRED		0x8000
+
 struct OpalMemoryErrorData {
 	enum OpalMemErr_Version	version:8;	/* 0x00 */
 	enum OpalMemErrType	type:8;		/* 0x01 */
@@ -518,6 +655,7 @@ enum OpalHMI_XstopType {
 	CHECKSTOP_TYPE_UNKNOWN	=	0,
 	CHECKSTOP_TYPE_CORE	=	1,
 	CHECKSTOP_TYPE_NX	=	2,
+	CHECKSTOP_TYPE_NPU	=	3
 };
 
 enum OpalHMI_CoreXstopReason {
@@ -577,10 +715,10 @@ struct OpalHMIEvent {
 		struct {
 			uint8_t	xstop_type;	/* enum OpalHMI_XstopType */
 			uint8_t reserved_1[3];
-			__be32  xstop_reason;
+			__be32 xstop_reason;
 			union {
-				__be32 pir;	/* for CHECKSTOP_TYPE_CORE */
-				__be32 chip_id;	/* for CHECKSTOP_TYPE_NX */
+				__be32 pir;	  /* for CHECKSTOP_TYPE_CORE */
+				__be32 chip_id; /* for CHECKSTOP_TYPE_NX */
 			} u;
 		} xstop_error;
 	} u;
@@ -645,7 +783,8 @@ enum {
 
 enum {
 	OPAL_PHB_ERROR_DATA_TYPE_P7IOC = 1,
-	OPAL_PHB_ERROR_DATA_TYPE_PHB3 = 2
+	OPAL_PHB_ERROR_DATA_TYPE_PHB3 = 2,
+	OPAL_PHB_ERROR_DATA_TYPE_PHB4 = 3
 };
 
 enum {
@@ -780,6 +919,11 @@ struct OpalIoPhb3ErrorData {
 	__be64 pestB[OPAL_PHB3_NUM_PEST_REGS];
 };
 
+struct OpalIoPhb4ErrorData {
+	struct OpalIoPhbErrorCommon common;
+	// FIXME add phb4 specific stuff
+};
+
 enum {
 	OPAL_REINIT_CPUS_HILE_BE	= (1 << 0),
 	OPAL_REINIT_CPUS_HILE_LE	= (1 << 1),
@@ -797,6 +941,7 @@ enum opal_prd_msg_type {
 	OPAL_PRD_MSG_TYPE_ATTN_ACK,	/* HBRT --> OPAL */
 	OPAL_PRD_MSG_TYPE_OCC_ERROR,	/* HBRT <-- OPAL */
 	OPAL_PRD_MSG_TYPE_OCC_RESET,	/* HBRT <-- OPAL */
+	OPAL_PRD_MSG_TYPE_OCC_RESET_NOTIFY, /* HBRT --> OPAL */
 };
 
 struct opal_prd_msg_header {
@@ -805,13 +950,50 @@ struct opal_prd_msg_header {
 	__be16		size;
 };
 
-struct opal_prd_msg;
-
-#define OCC_RESET                       0
-#define OCC_LOAD                        1
-#define OCC_THROTTLE                    2
-#define OCC_MAX_THROTTLE_STATUS         5
+struct opal_prd_msg {
+	struct opal_prd_msg_header hdr;
+	__be32		token;
+	union {
+		struct {
+			__be64	version;
+			__be64	ipoll;
+		} init;
+		struct {
+			__be64	proc;
+			__be64	ipoll_status;
+			__be64	ipoll_mask;
+		} attn;
+		struct {
+			__be64	proc;
+			__be64	ipoll_ack;
+		} attn_ack;
+		struct {
+			__be64	chip;
+		} occ_error;
+		struct {
+			__be64	chip;
+		} occ_reset;
+	};
+};
 
+#define OCC_RESET			0
+#define OCC_LOAD			1
+#define OCC_THROTTLE			2
+#define OCC_MAX_THROTTLE_STATUS		5
+/*
+ * struct opal_occ_msg:
+ * type: OCC_RESET, OCC_LOAD, OCC_THROTTLE
+ * chip: chip id
+ * throttle status: indicates the reason why OCC may have limited
+ * the max Pstate of the chip.
+ * 0x00 = No throttle
+ * 0x01 = Power Cap
+ * 0x02 = Processor Over Temperature
+ * 0x03 = Power Supply Failure (currently not used)
+ * 0x04 = Over current (currently not used)
+ * 0x05 = OCC Reset (not reliable as some failures will not allow for
+ * OCC to update throttle status)
+ */
 struct opal_occ_msg {
 	__be64 type;
 	__be64 chip;
@@ -857,6 +1039,10 @@ enum {
 	OPAL_PHB_CAPI_MODE_DMA		= 4,
 };
 
+/* CAPI feature flags (in device-tree) */
+#define OPAL_PHB_CAPI_FLAG_SNOOP_CONTROL	0x00000001
+#define OPAL_PHB_CAPI_FLAG_REVERT_TO_PCIE	0x00000002
+
 /* OPAL I2C request */
 struct opal_i2c_request {
 	uint8_t	type;
@@ -875,59 +1061,73 @@ struct opal_i2c_request {
 	__be64 buffer_ra;		/* Buffer real address */
 };
 
-/*
- * EPOW status sharing (OPAL and the host)
- *
- * The host will pass on OPAL, a buffer of length OPAL_SYSEPOW_MAX
- * with individual elements being 16 bits wide to fetch the system
- * wide EPOW status. Each element in the buffer will contain the
- * EPOW status in it's bit representation for a particular EPOW sub
- * class as defined here. So multiple detailed EPOW status bits
- * specific for any sub class can be represented in a single buffer
- * element as it's bit representation.
+/* Argument to OPAL_CEC_REBOOT2() */
+enum {
+	OPAL_REBOOT_NORMAL = 0,
+	OPAL_REBOOT_PLATFORM_ERROR,
+};
+
+/* Argument to OPAL_PCI_TCE_KILL */
+enum {
+	OPAL_PCI_TCE_KILL_PAGES,
+	OPAL_PCI_TCE_KILL_PE,
+	OPAL_PCI_TCE_KILL_ALL,
+};
+
+/* The xive operation mode indicates the active "API" and
+ * corresponds to the "mode" parameter of the opal_xive_reset()
+ * call
  */
+enum {
+	OPAL_XIVE_MODE_EMU	= 0,
+	OPAL_XIVE_MODE_EXPL	= 1,
+};
 
-/* System EPOW type */
-enum OpalSysEpow {
-	OPAL_SYSEPOW_POWER	= 0,	/* Power EPOW */
-	OPAL_SYSEPOW_TEMP	= 1,	/* Temperature EPOW */
-	OPAL_SYSEPOW_COOLING	= 2,	/* Cooling EPOW */
-	OPAL_SYSEPOW_MAX	= 3,	/* Max EPOW categories */
+/* Flags for OPAL_XIVE_GET_IRQ_INFO */
+enum {
+	OPAL_XIVE_IRQ_TRIGGER_PAGE	= 0x00000001,
+	OPAL_XIVE_IRQ_STORE_EOI		= 0x00000002,
+	OPAL_XIVE_IRQ_LSI		= 0x00000004,
+	OPAL_XIVE_IRQ_SHIFT_BUG		= 0x00000008,
+	OPAL_XIVE_IRQ_MASK_VIA_FW	= 0x00000010,
+	OPAL_XIVE_IRQ_EOI_VIA_FW	= 0x00000020,
 };
 
-/* Power EPOW */
-enum OpalSysPower {
-	OPAL_SYSPOWER_UPS	= 0x0001, /* System on UPS power */
-	OPAL_SYSPOWER_CHNG	= 0x0002, /* System power config change */
-	OPAL_SYSPOWER_FAIL	= 0x0004, /* System impending power failure */
-	OPAL_SYSPOWER_INCL	= 0x0008, /* System incomplete power */
+/* Flags for OPAL_XIVE_GET/SET_QUEUE_INFO */
+enum {
+	OPAL_XIVE_EQ_ENABLED		= 0x00000001,
+	OPAL_XIVE_EQ_ALWAYS_NOTIFY	= 0x00000002,
+	OPAL_XIVE_EQ_ESCALATE		= 0x00000004,
 };
 
-/* Temperature EPOW */
-enum OpalSysTemp {
-	OPAL_SYSTEMP_AMB	= 0x0001, /* System over ambient temperature */
-	OPAL_SYSTEMP_INT	= 0x0002, /* System over internal temperature */
-	OPAL_SYSTEMP_HMD	= 0x0004, /* System over ambient humidity */
+/* Flags for OPAL_XIVE_GET/SET_VP_INFO */
+enum {
+	OPAL_XIVE_VP_ENABLED		= 0x00000001,
 };
 
-/* Cooling EPOW */
-enum OpalSysCooling {
-	OPAL_SYSCOOL_INSF	= 0x0001, /* System insufficient cooling */
+/* "Any chip" replacement for chip ID for allocation functions */
+enum {
+	OPAL_XIVE_ANY_CHIP		= 0xffffffff,
 };
 
-/* Argument to OPAL_CEC_REBOOT2() */
+/* Xive sync options */
 enum {
-	OPAL_REBOOT_NORMAL		= 0,
-	OPAL_REBOOT_PLATFORM_ERROR	= 1,
+	/* This bits are cumulative, arg is a girq */
+	XIVE_SYNC_EAS			= 0x00000001, /* Sync irq source */
+	XIVE_SYNC_QUEUE			= 0x00000002, /* Sync irq target */
 };
 
-/* Argument to OPAL_PCI_TCE_KILL */
+/* Dump options */
 enum {
-	OPAL_PCI_TCE_KILL_PAGES,
-	OPAL_PCI_TCE_KILL_PE,
-	OPAL_PCI_TCE_KILL_ALL,
+	XIVE_DUMP_TM_HYP	= 0,
+	XIVE_DUMP_TM_POOL	= 1,
+	XIVE_DUMP_TM_OS		= 2,
+	XIVE_DUMP_TM_USER	= 3,
+	XIVE_DUMP_VP		= 4,
+	XIVE_DUMP_EMU_STATE	= 5,
 };
 
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
+
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 1ff03a6..cb7d607 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -226,6 +226,42 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			  uint32_t pe_num, uint32_t tce_size,
 			  uint64_t dma_addr, uint32_t npages);
 int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);
+int64_t opal_xive_reset(uint64_t version);
+int64_t opal_xive_get_irq_info(uint32_t girq,
+			       __be64 *out_flags,
+			       __be64 *out_eoi_page,
+			       __be64 *out_trig_page,
+			       __be32 *out_esb_shift,
+			       __be32 *out_src_chip);
+int64_t opal_xive_get_irq_config(uint32_t girq, __be64 *out_vp,
+				 uint8_t *out_prio, __be32 *out_lirq);
+int64_t opal_xive_set_irq_config(uint32_t girq, uint64_t vp, uint8_t prio,
+				 uint32_t lirq);
+int64_t opal_xive_get_queue_info(uint64_t vp, uint32_t prio,
+				 __be64 *out_qpage,
+				 __be64 *out_qsize,
+				 __be64 *out_qeoi_page,
+				 __be32 *out_escalate_irq,
+				 __be64 *out_qflags);
+int64_t opal_xive_set_queue_info(uint64_t vp, uint32_t prio,
+				 uint64_t qpage,
+				 uint64_t qsize,
+				 uint64_t qflags);
+int64_t opal_xive_donate_page(uint32_t chip_id, uint64_t addr);
+int64_t opal_xive_alloc_vp_block(uint32_t alloc_order);
+int64_t opal_xive_free_vp_block(uint64_t vp);
+int64_t opal_xive_get_vp_info(uint64_t vp,
+			      __be64 *out_flags,
+			      __be64 *out_cam_value,
+			      __be64 *out_report_cl_pair,
+			      __be32 *out_chip_id);
+int64_t opal_xive_set_vp_info(uint64_t vp,
+			      uint64_t flags,
+			      uint64_t report_cl_pair);
+int64_t opal_xive_allocate_irq(uint32_t chip_id);
+int64_t opal_xive_free_irq(uint32_t girq);
+int64_t opal_xive_sync(uint32_t type, uint32_t id);
+int64_t opal_xive_dump(uint32_t type, uint32_t id);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index da8a0f7..085605a 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -301,3 +301,18 @@ OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
+OPAL_CALL(opal_xive_reset,			OPAL_XIVE_RESET);
+OPAL_CALL(opal_xive_get_irq_info,		OPAL_XIVE_GET_IRQ_INFO);
+OPAL_CALL(opal_xive_get_irq_config,		OPAL_XIVE_GET_IRQ_CONFIG);
+OPAL_CALL(opal_xive_set_irq_config,		OPAL_XIVE_SET_IRQ_CONFIG);
+OPAL_CALL(opal_xive_get_queue_info,		OPAL_XIVE_GET_QUEUE_INFO);
+OPAL_CALL(opal_xive_set_queue_info,		OPAL_XIVE_SET_QUEUE_INFO);
+OPAL_CALL(opal_xive_donate_page,		OPAL_XIVE_DONATE_PAGE);
+OPAL_CALL(opal_xive_alloc_vp_block,		OPAL_XIVE_ALLOCATE_VP_BLOCK);
+OPAL_CALL(opal_xive_free_vp_block,		OPAL_XIVE_FREE_VP_BLOCK);
+OPAL_CALL(opal_xive_allocate_irq,		OPAL_XIVE_ALLOCATE_IRQ);
+OPAL_CALL(opal_xive_free_irq,			OPAL_XIVE_FREE_IRQ);
+OPAL_CALL(opal_xive_get_vp_info,		OPAL_XIVE_GET_VP_INFO);
+OPAL_CALL(opal_xive_set_vp_info,		OPAL_XIVE_SET_VP_INFO);
+OPAL_CALL(opal_xive_sync,			OPAL_XIVE_SYNC);
+OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
-- 
2.9.3
