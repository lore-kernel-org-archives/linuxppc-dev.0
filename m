Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC41C100BC1
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 13:46:02 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/20] powerpc/powernv: Basic support for OPAL
Date: Tue, 20 Sep 2011 13:44:57 +1000
Message-Id: <1316490307-28030-10-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
References: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add definition of OPAL interfaces along with  the wrappers to call
into OPAL runtime and the early device-tree parsing hook to locate
the OPAL runtime firmware.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/firmware.h            |   10 +
 arch/powerpc/include/asm/opal.h                |  382 +++++++++++++++++++++++-
 arch/powerpc/kernel/prom.c                     |    7 +
 arch/powerpc/platforms/powernv/Kconfig         |    8 +-
 arch/powerpc/platforms/powernv/Makefile        |    2 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |  101 +++++++
 arch/powerpc/platforms/powernv/opal.c          |  154 ++++++++++
 arch/powerpc/platforms/powernv/setup.c         |    6 +
 arch/powerpc/platforms/powernv/smp.c           |   25 ++-
 9 files changed, 690 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-wrappers.S
 create mode 100644 arch/powerpc/platforms/powernv/opal.c

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 3a6c586..14db29b 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -48,6 +48,8 @@
 #define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
 #define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
 #define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
+#define FW_FEATURE_OPAL		ASM_CONST(0x0000000010000000)
+#define FW_FEATURE_OPALv2	ASM_CONST(0x0000000020000000)
 
 #ifndef __ASSEMBLY__
 
@@ -65,6 +67,8 @@ enum {
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_ISERIES_POSSIBLE = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
 	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
+	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv2,
+	FW_FEATURE_POWERNV_ALWAYS = 0,
 	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_CELLEB_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_BEAT,
@@ -78,6 +82,9 @@ enum {
 #ifdef CONFIG_PPC_ISERIES
 		FW_FEATURE_ISERIES_POSSIBLE |
 #endif
+#ifdef CONFIG_PPC_POWERNV
+		FW_FEATURE_POWERNV_POSSIBLE |
+#endif
 #ifdef CONFIG_PPC_PS3
 		FW_FEATURE_PS3_POSSIBLE |
 #endif
@@ -95,6 +102,9 @@ enum {
 #ifdef CONFIG_PPC_ISERIES
 		FW_FEATURE_ISERIES_ALWAYS &
 #endif
+#ifdef CONFIG_PPC_POWERNV
+		FW_FEATURE_POWERNV_ALWAYS &
+#endif
 #ifdef CONFIG_PPC_PS3
 		FW_FEATURE_PS3_ALWAYS &
 #endif
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ecdb283..53cda41 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -37,14 +37,394 @@ extern long opal_query_takeover(u64 *hal_size, u64 *hal_align);
 
 extern long opal_do_takeover(struct opal_takeover_args *args);
 
+struct rtas_args;
 extern int opal_enter_rtas(struct rtas_args *args,
 			   unsigned long data,
 			   unsigned long entry);
 
-
 #endif /* __ASSEMBLY__ */
 
 /****** OPAL APIs ******/
 
+/* Return codes */
+#define OPAL_SUCCESS 		0
+#define OPAL_PARAMETER		-1
+#define OPAL_BUSY		-2
+#define OPAL_PARTIAL		-3
+#define OPAL_CONSTRAINED	-4
+#define OPAL_CLOSED		-5
+#define OPAL_HARDWARE		-6
+#define OPAL_UNSUPPORTED	-7
+#define OPAL_PERMISSION		-8
+#define OPAL_NO_MEM		-9
+#define OPAL_RESOURCE		-10
+#define OPAL_INTERNAL_ERROR	-11
+#define OPAL_BUSY_EVENT		-12
+#define OPAL_HARDWARE_FROZEN	-13
+
+/* API Tokens (in r0) */
+#define OPAL_CONSOLE_WRITE			1
+#define OPAL_CONSOLE_READ			2
+#define OPAL_RTC_READ				3
+#define OPAL_RTC_WRITE				4
+#define OPAL_CEC_POWER_DOWN			5
+#define OPAL_CEC_REBOOT				6
+#define OPAL_READ_NVRAM				7
+#define OPAL_WRITE_NVRAM			8
+#define OPAL_HANDLE_INTERRUPT			9
+#define OPAL_POLL_EVENTS			10
+#define OPAL_PCI_SET_HUB_TCE_MEMORY		11
+#define OPAL_PCI_SET_PHB_TCE_MEMORY		12
+#define OPAL_PCI_CONFIG_READ_BYTE		13
+#define OPAL_PCI_CONFIG_READ_HALF_WORD  	14
+#define OPAL_PCI_CONFIG_READ_WORD		15
+#define OPAL_PCI_CONFIG_WRITE_BYTE		16
+#define OPAL_PCI_CONFIG_WRITE_HALF_WORD		17
+#define OPAL_PCI_CONFIG_WRITE_WORD		18
+#define OPAL_SET_XIVE				19
+#define OPAL_GET_XIVE				20
+#define OPAL_GET_COMPLETION_TOKEN_STATUS	21 /* obsolete */
+#define OPAL_REGISTER_OPAL_EXCEPTION_HANDLER	22
+#define OPAL_PCI_EEH_FREEZE_STATUS		23
+#define OPAL_PCI_SHPC				24
+#define OPAL_CONSOLE_WRITE_BUFFER_SPACE		25
+#define OPAL_PCI_EEH_FREEZE_CLEAR		26
+#define OPAL_PCI_PHB_MMIO_ENABLE		27
+#define OPAL_PCI_SET_PHB_MEM_WINDOW		28
+#define OPAL_PCI_MAP_PE_MMIO_WINDOW		29
+#define OPAL_PCI_SET_PHB_TABLE_MEMORY		30
+#define OPAL_PCI_SET_PE				31
+#define OPAL_PCI_SET_PELTV			32
+#define OPAL_PCI_SET_MVE			33
+#define OPAL_PCI_SET_MVE_ENABLE			34
+#define OPAL_PCI_GET_XIVE_REISSUE		35
+#define OPAL_PCI_SET_XIVE_REISSUE		36
+#define OPAL_PCI_SET_XIVE_PE			37
+#define OPAL_GET_XIVE_SOURCE			38
+#define OPAL_GET_MSI_32				39
+#define OPAL_GET_MSI_64				40
+#define OPAL_START_CPU				41
+#define OPAL_QUERY_CPU_STATUS			42
+#define OPAL_WRITE_OPPANEL			43
+#define OPAL_PCI_MAP_PE_DMA_WINDOW		44
+#define OPAL_PCI_MAP_PE_DMA_WINDOW_REAL		45
+#define OPAL_PCI_RESET				49
+
+#ifndef __ASSEMBLY__
+
+/* Other enums */
+enum OpalVendorApiTokens {
+	OPAL_START_VENDOR_API_RANGE = 1000, OPAL_END_VENDOR_API_RANGE = 1999
+};
+enum OpalFreezeState {
+	OPAL_EEH_STOPPED_NOT_FROZEN = 0,
+	OPAL_EEH_STOPPED_MMIO_FREEZE = 1,
+	OPAL_EEH_STOPPED_DMA_FREEZE = 2,
+	OPAL_EEH_STOPPED_MMIO_DMA_FREEZE = 3,
+	OPAL_EEH_STOPPED_RESET = 4,
+	OPAL_EEH_STOPPED_TEMP_UNAVAIL = 5,
+	OPAL_EEH_STOPPED_PERM_UNAVAIL = 6
+};
+enum OpalEehFreezeActionToken {
+	OPAL_EEH_ACTION_CLEAR_FREEZE_MMIO = 1,
+	OPAL_EEH_ACTION_CLEAR_FREEZE_DMA = 2,
+	OPAL_EEH_ACTION_CLEAR_FREEZE_ALL = 3
+};
+enum OpalPciStatusToken {
+	OPAL_EEH_PHB_NO_ERROR = 0,
+	OPAL_EEH_PHB_FATAL = 1,
+	OPAL_EEH_PHB_RECOVERABLE = 2,
+	OPAL_EEH_PHB_BUS_ERROR = 3,
+	OPAL_EEH_PCI_NO_DEVSEL = 4,
+	OPAL_EEH_PCI_TA = 5,
+	OPAL_EEH_PCIEX_UR = 6,
+	OPAL_EEH_PCIEX_CA = 7,
+	OPAL_EEH_PCI_MMIO_ERROR = 8,
+	OPAL_EEH_PCI_DMA_ERROR = 9
+};
+enum OpalShpcAction {
+	OPAL_SHPC_GET_LINK_STATE = 0,
+	OPAL_SHPC_GET_SLOT_STATE = 1
+};
+enum OpalShpcLinkState {
+	OPAL_SHPC_LINK_DOWN = 0,
+	OPAL_SHPC_LINK_UP = 1
+};
+enum OpalMmioWindowType {
+	OPAL_M32_WINDOW_TYPE = 1,
+	OPAL_M64_WINDOW_TYPE = 2,
+	OPAL_IO_WINDOW_TYPE = 3
+};
+enum OpalShpcSlotState {
+	OPAL_SHPC_DEV_NOT_PRESENT = 0,
+	OPAL_SHPC_DEV_PRESENT = 1
+};
+enum OpalExceptionHandler {
+	OPAL_MACHINE_CHECK_HANDLER = 1,
+	OPAL_HYPERVISOR_MAINTENANCE_HANDLER = 2,
+	OPAL_SOFTPATCH_HANDLER = 3
+};
+enum OpalPendingState {
+	OPAL_EVENT_OPAL_INTERNAL = 0x1,
+	OPAL_EVENT_NVRAM = 0x2,
+	OPAL_EVENT_RTC = 0x4,
+	OPAL_EVENT_CONSOLE_OUTPUT = 0x8,
+	OPAL_EVENT_CONSOLE_INPUT = 0x10
+};
+
+/* Machine check related definitions */
+enum OpalMCE_Version {
+	OpalMCE_V1 = 1,
+};
+
+enum OpalMCE_Severity {
+	OpalMCE_SEV_NO_ERROR = 0,
+	OpalMCE_SEV_WARNING = 1,
+	OpalMCE_SEV_ERROR_SYNC = 2,
+	OpalMCE_SEV_FATAL = 3,
+};
+
+enum OpalMCE_Disposition {
+	OpalMCE_DISPOSITION_RECOVERED = 0,
+	OpalMCE_DISPOSITION_NOT_RECOVERED = 1,
+};
+
+enum OpalMCE_Initiator {
+	OpalMCE_INITIATOR_UNKNOWN = 0,
+	OpalMCE_INITIATOR_CPU = 1,
+};
+
+enum OpalMCE_ErrorType {
+	OpalMCE_ERROR_TYPE_UNKNOWN = 0,
+	OpalMCE_ERROR_TYPE_UE = 1,
+	OpalMCE_ERROR_TYPE_SLB = 2,
+	OpalMCE_ERROR_TYPE_ERAT = 3,
+	OpalMCE_ERROR_TYPE_TLB = 4,
+};
+
+enum OpalMCE_UeErrorType {
+	OpalMCE_UE_ERROR_INDETERMINATE = 0,
+	OpalMCE_UE_ERROR_IFETCH = 1,
+	OpalMCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH = 2,
+	OpalMCE_UE_ERROR_LOAD_STORE = 3,
+	OpalMCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE = 4,
+};
+
+enum OpalMCE_SlbErrorType {
+	OpalMCE_SLB_ERROR_INDETERMINATE = 0,
+	OpalMCE_SLB_ERROR_PARITY = 1,
+	OpalMCE_SLB_ERROR_MULTIHIT = 2,
+};
+
+enum OpalMCE_EratErrorType {
+	OpalMCE_ERAT_ERROR_INDETERMINATE = 0,
+	OpalMCE_ERAT_ERROR_PARITY = 1,
+	OpalMCE_ERAT_ERROR_MULTIHIT = 2,
+};
+
+enum OpalMCE_TlbErrorType {
+	OpalMCE_TLB_ERROR_INDETERMINATE = 0,
+	OpalMCE_TLB_ERROR_PARITY = 1,
+	OpalMCE_TLB_ERROR_MULTIHIT = 2,
+};
+
+enum OpalThreadStatus {
+	OPAL_THREAD_INACTIVE = 0x0,
+	OPAL_THREAD_STARTED = 0x1
+};
+
+enum OpalPciBusCompare {
+	OpalPciBusAny	= 0,	/* Any bus number match */
+	OpalPciBus3Bits	= 2,	/* Match top 3 bits of bus number */
+	OpalPciBus4Bits	= 3,	/* Match top 4 bits of bus number */
+	OpalPciBus5Bits	= 4,	/* Match top 5 bits of bus number */
+	OpalPciBus6Bits	= 5,	/* Match top 6 bits of bus number */
+	OpalPciBus7Bits	= 6,	/* Match top 7 bits of bus number */
+	OpalPciBusAll	= 7,	/* Match bus number exactly */
+};
+
+enum OpalDeviceCompare {
+	OPAL_IGNORE_RID_DEVICE_NUMBER = 0,
+	OPAL_COMPARE_RID_DEVICE_NUMBER = 1
+};
+
+enum OpalFuncCompare {
+	OPAL_IGNORE_RID_FUNCTION_NUMBER = 0,
+	OPAL_COMPARE_RID_FUNCTION_NUMBER = 1
+};
+
+enum OpalPeAction {
+	OPAL_UNMAP_PE = 0,
+	OPAL_MAP_PE = 1
+};
+
+enum OpalPciResetAndReinitScope { 
+	OPAL_PHB_COMPLETE = 1, OPAL_PCI_LINK = 2, OPAL_PHB_ERROR = 3,
+	OPAL_PCI_HOT_RESET = 4, OPAL_PCI_FUNDAMENTAL_RESET = 5,
+	OPAL_PCI_IODA_RESET = 6,
+};
+
+enum OpalPciResetState { OPAL_DEASSERT_RESET = 0, OPAL_ASSERT_RESET = 1 };
+
+struct opal_machine_check_event {
+	enum OpalMCE_Version	version:8;	/* 0x00 */
+	uint8_t			in_use;		/* 0x01 */
+	enum OpalMCE_Severity	severity:8;	/* 0x02 */
+	enum OpalMCE_Initiator	initiator:8;	/* 0x03 */
+	enum OpalMCE_ErrorType	error_type:8;	/* 0x04 */
+	enum OpalMCE_Disposition disposition:8; /* 0x05 */
+	uint8_t			reserved_1[2];	/* 0x06 */
+	uint64_t		gpr3;		/* 0x08 */
+	uint64_t		srr0;		/* 0x10 */
+	uint64_t		srr1;		/* 0x18 */
+	union {					/* 0x20 */
+		struct {
+			enum OpalMCE_UeErrorType ue_error_type:8;
+			uint8_t		effective_address_provided;
+			uint8_t		physical_address_provided;
+			uint8_t		reserved_1[5];
+			uint64_t	effective_address;
+			uint64_t	physical_address;
+			uint8_t		reserved_2[8];
+		} ue_error;
+
+		struct {
+			enum OpalMCE_SlbErrorType slb_error_type:8;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} slb_error;
+
+		struct {
+			enum OpalMCE_EratErrorType erat_error_type:8;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} erat_error;
+
+		struct {
+			enum OpalMCE_TlbErrorType tlb_error_type:8;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} tlb_error;
+	} u;
+};
+
+typedef struct oppanel_line {
+	/* XXX */
+} oppanel_line_t;
+
+/* API functions */
+int64_t opal_console_write(int64_t term_number, int64_t *length,
+			   const uint8_t *buffer);
+int64_t opal_console_read(int64_t term_number, int64_t *length,
+			  uint8_t *buffer);
+int64_t opal_console_write_buffer_space(int64_t term_number,
+					int64_t *length);
+int64_t opal_rtc_read(uint32_t *year_month_day,
+		      uint64_t *hour_minute_second_millisecond);
+int64_t opal_rtc_write(uint32_t year_month_day,
+		       uint64_t hour_minute_second_millisecond);
+int64_t opal_cec_power_down(uint64_t request);
+int64_t opal_cec_reboot(void);
+int64_t opal_read_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
+int64_t opal_write_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
+int64_t opal_handle_interrupt(uint64_t isn, uint64_t *outstanding_event_mask);
+int64_t opal_poll_events(uint64_t *outstanding_event_mask);
+int64_t opal_pci_set_hub_tce_memory(uint64_t hub_id, uint64_t tce_mem_addr,
+				    uint64_t tce_mem_size);
+int64_t opal_pci_set_phb_tce_memory(uint64_t phb_id, uint64_t tce_mem_addr,
+				    uint64_t tce_mem_size);
+int64_t opal_pci_config_read_byte(uint64_t phb_id, uint64_t bus_dev_func,
+				  uint64_t offset, uint8_t *data);
+int64_t opal_pci_config_read_half_word(uint64_t phb_id, uint64_t bus_dev_func,
+				       uint64_t offset, uint16_t *data);
+int64_t opal_pci_config_read_word(uint64_t phb_id, uint64_t bus_dev_func,
+				  uint64_t offset, uint32_t *data);
+int64_t opal_pci_config_write_byte(uint64_t phb_id, uint64_t bus_dev_func,
+				   uint64_t offset, uint8_t data);
+int64_t opal_pci_config_write_half_word(uint64_t phb_id, uint64_t bus_dev_func,
+					uint64_t offset, uint16_t data);
+int64_t opal_pci_config_write_word(uint64_t phb_id, uint64_t bus_dev_func,
+				   uint64_t offset, uint32_t data);
+int64_t opal_set_xive(uint32_t isn, uint16_t server, uint8_t priority);
+int64_t opal_get_xive(uint32_t isn, uint16_t *server, uint8_t *priority);
+int64_t opal_register_exception_handler(uint64_t opal_exception,
+					uint64_t handler_address,
+					uint64_t glue_cache_line);
+int64_t opal_pci_eeh_freeze_status(uint64_t phb_id, uint64_t pe_number,
+				   uint8_t *freeze_state,
+				   uint16_t *pci_error_type,
+				   uint64_t *phb_status);
+int64_t opal_pci_eeh_freeze_clear(uint64_t phb_id, uint64_t pe_number,
+				  uint64_t eeh_action_token);
+int64_t opal_pci_shpc(uint64_t phb_id, uint64_t shpc_action, uint8_t *state);
+
+
+
+int64_t opal_pci_phb_mmio_enable(uint64_t phb_id, uint16_t window_type,
+				 uint16_t window_num, uint16_t enable);
+int64_t opal_pci_set_phb_mem_window(uint64_t phb_id, uint16_t window_type,
+				    uint16_t window_num,
+				    uint64_t starting_real_address,
+				    uint64_t starting_pci_address,
+				    uint16_t segment_size);
+int64_t opal_pci_map_pe_mmio_window(uint64_t phb_id, uint16_t pe_number,
+				    uint16_t window_type, uint16_t window_num,
+				    uint16_t segment_num);
+int64_t opal_pci_set_phb_table_memory(uint64_t phb_id, uint64_t rtt_addr,
+				      uint64_t ivt_addr, uint64_t ivt_len,
+				      uint64_t reject_array_addr,
+				      uint64_t peltv_addr);
+int64_t opal_pci_set_pe(uint64_t phb_id, uint64_t pe_number, uint64_t bus_dev_func,
+			uint8_t bus_compare, uint8_t dev_compare, uint8_t func_compare,
+			uint8_t pe_action);
+int64_t opal_pci_set_peltv(uint64_t phb_id, uint32_t parent_pe, uint32_t child_pe,
+			   uint8_t state);
+int64_t opal_pci_set_mve(uint64_t phb_id, uint32_t mve_number, uint32_t pe_number);
+int64_t opal_pci_set_mve_enable(uint64_t phb_id, uint32_t mve_number,
+				uint32_t state);
+int64_t opal_pci_get_xive_reissue(uint64_t phb_id, uint32_t xive_number,
+				  uint8_t *p_bit, uint8_t *q_bit);
+int64_t opal_pci_set_xive_reissue(uint64_t phb_id, uint32_t xive_number,
+				  uint8_t p_bit, uint8_t q_bit);
+int64_t opal_pci_set_xive_pe(uint64_t phb_id, uint32_t pe_number,
+			     uint32_t xive_num);
+int64_t opal_get_xive_source(uint64_t phb_id, uint32_t xive_num,
+			     int32_t *interrupt_source_number);
+int64_t opal_get_msi_32(uint64_t phb_id, uint32_t mve_number, uint32_t xive_num,
+			uint8_t msi_range, uint32_t *msi_address,
+			uint32_t *message_data);
+int64_t opal_get_msi_64(uint64_t phb_id, uint32_t mve_number,
+			uint32_t xive_num, uint8_t msi_range,
+			uint64_t *msi_address, uint32_t *message_data);
+int64_t opal_start_cpu(uint64_t thread_number, uint64_t start_address);
+int64_t opal_query_cpu_status(uint64_t thread_number, uint8_t *thread_status);
+int64_t opal_write_oppanel(oppanel_line_t *lines, uint64_t num_lines);
+int64_t opal_pci_map_pe_dma_window(uint64_t phb_id, uint16_t pe_number, uint16_t window_id,
+				   uint16_t tce_levels, uint64_t tce_table_addr,
+				   uint64_t tce_table_size, uint64_t tce_page_size);
+int64_t opal_pci_map_pe_dma_window_real(uint64_t phb_id, uint16_t pe_number,
+					uint16_t dma_window_number, uint64_t pci_start_addr,
+					uint64_t pci_mem_size);
+int64_t opal_pci_reset(uint64_t phb_id, uint8_t reset_scope, uint8_t assert_state);
+
+/* Internal functions */
+extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
+
+extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
+extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
+
+extern void hvc_opal_init_early(void);
+
+/* Internal functions */
+extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
+				   int depth, void *data);
+
+#endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_H */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 7b90c56..831a201 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -54,6 +54,8 @@
 #include <asm/pci-bridge.h>
 #include <asm/phyp_dump.h>
 #include <asm/kexec.h>
+#include <asm/opal.h>
+
 #include <mm/mmu_decl.h>
 
 #ifdef DEBUG
@@ -707,6 +709,11 @@ void __init early_init_devtree(void *params)
 	of_scan_flat_dt(early_init_dt_scan_rtas, NULL);
 #endif
 
+#ifdef CONFIG_PPC_POWERNV
+	/* Some machines might need OPAL info for debugging, grab it now. */
+	of_scan_flat_dt(early_init_dt_scan_opal, NULL);
+#endif
+
 #ifdef CONFIG_PHYP_DUMP
 	/* scan tree to see if dump occurred during last boot */
 	of_scan_flat_dt(early_init_dt_scan_phyp_dump, NULL);
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 5cd04f5..268cadb 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -1,12 +1,16 @@
 config PPC_POWERNV
 	depends on PPC64 && PPC_BOOK3S
 	bool "IBM PowerNV (Non-Virtualized) platform support"	
-	select PPC_RTAS
 	select PPC_NATIVE
 	select PPC_XICS
 	select PPC_ICP_NATIVE
-	select PPC_ICS_RTAS
 	select PPC_P7_NAP
 	select PPC_PCI_CHOICE if EMBEDDED
 	default y
 
+config PPC_POWERNV_RTAS
+	depends on PPC_POWERNV
+	bool "Support for RTAS based PowerNV platforms such as BML"
+	default y
+	select PPC_ICS_RTAS
+	select PPC_RTAS
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 4971330..8f69c0d 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,2 +1,2 @@
-obj-y			+= setup.o opal-takeover.o
+obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o
 obj-$(CONFIG_SMP)	+= smp.o
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
new file mode 100644
index 0000000..4a3f46d
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -0,0 +1,101 @@
+/*
+ * PowerNV OPAL API wrappers
+ *
+ * Copyright 2011 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/hvcall.h>
+#include <asm/asm-offsets.h>
+#include <asm/opal.h>
+
+/* TODO:
+ *
+ * - Trace irqs in/off (needs saving/restoring all args, argh...)
+ * - Get r11 feed up by Dave so I can have better register usage
+ */
+#define OPAL_CALL(name, token)		\
+ _GLOBAL(name);				\
+	mflr	r0;			\
+	mfcr	r12;			\
+	std	r0,16(r1);		\
+	std	r12,8(r1);		\
+	std	r1,PACAR1(r13);		\
+	li	r0,0;			\
+	mfmsr	r12;			\
+	ori	r0,r0,MSR_EE;		\
+	std	r12,PACASAVEDMSR(r13);	\
+	andc	r12,r12,r0;		\
+	mtmsrd	r12,1;			\
+	LOAD_REG_ADDR(r0,.opal_return);	\
+	mtlr	r0;			\
+	li	r0,MSR_DR|MSR_IR;	\
+	andc	r12,r12,r0;		\
+	li	r0,token;		\
+	mtspr	SPRN_HSRR1,r12;		\
+	LOAD_REG_ADDR(r11,opal);	\
+	ld	r12,8(r11);		\
+	ld	r2,0(r11);		\
+	mtspr	SPRN_HSRR0,r12;		\
+	hrfid
+
+_STATIC(opal_return)
+	ld	r2,PACATOC(r13);
+	ld	r4,8(r1);
+	ld	r5,16(r1);
+	ld	r6,PACASAVEDMSR(r13);
+	mtspr	SPRN_SRR0,r5;
+	mtspr	SPRN_SRR1,r6;
+	mtcr	r4;
+	rfid
+
+OPAL_CALL(opal_console_write,			OPAL_CONSOLE_WRITE);
+OPAL_CALL(opal_console_read,			OPAL_CONSOLE_READ);
+OPAL_CALL(opal_console_write_buffer_space,	OPAL_CONSOLE_WRITE_BUFFER_SPACE);
+OPAL_CALL(opal_rtc_read,			OPAL_RTC_READ);
+OPAL_CALL(opal_rtc_write,			OPAL_RTC_WRITE);
+OPAL_CALL(opal_cec_power_down,			OPAL_CEC_POWER_DOWN);
+OPAL_CALL(opal_cec_reboot,			OPAL_CEC_REBOOT);
+OPAL_CALL(opal_read_nvram,			OPAL_READ_NVRAM);
+OPAL_CALL(opal_write_nvram,			OPAL_WRITE_NVRAM);
+OPAL_CALL(opal_handle_interrupt,		OPAL_HANDLE_INTERRUPT);
+OPAL_CALL(opal_poll_events,			OPAL_POLL_EVENTS);
+OPAL_CALL(opal_pci_set_hub_tce_memory,		OPAL_PCI_SET_HUB_TCE_MEMORY);
+OPAL_CALL(opal_pci_set_phb_tce_memory,		OPAL_PCI_SET_PHB_TCE_MEMORY);
+OPAL_CALL(opal_pci_config_read_byte,		OPAL_PCI_CONFIG_READ_BYTE);
+OPAL_CALL(opal_pci_config_read_half_word,	OPAL_PCI_CONFIG_READ_HALF_WORD);
+OPAL_CALL(opal_pci_config_read_word,		OPAL_PCI_CONFIG_READ_WORD);
+OPAL_CALL(opal_pci_config_write_byte,		OPAL_PCI_CONFIG_WRITE_BYTE);
+OPAL_CALL(opal_pci_config_write_half_word,	OPAL_PCI_CONFIG_WRITE_HALF_WORD);
+OPAL_CALL(opal_pci_config_write_word,		OPAL_PCI_CONFIG_WRITE_WORD);
+OPAL_CALL(opal_set_xive,			OPAL_SET_XIVE);
+OPAL_CALL(opal_get_xive,			OPAL_GET_XIVE);
+OPAL_CALL(opal_register_exception_handler,	OPAL_REGISTER_OPAL_EXCEPTION_HANDLER);
+OPAL_CALL(opal_pci_eeh_freeze_status,		OPAL_PCI_EEH_FREEZE_STATUS);
+OPAL_CALL(opal_pci_eeh_freeze_clear,		OPAL_PCI_EEH_FREEZE_CLEAR);
+OPAL_CALL(opal_pci_shpc,			OPAL_PCI_SHPC);
+OPAL_CALL(opal_pci_phb_mmio_enable,		OPAL_PCI_PHB_MMIO_ENABLE);
+OPAL_CALL(opal_pci_set_phb_mem_window,		OPAL_PCI_SET_PHB_MEM_WINDOW);
+OPAL_CALL(opal_pci_map_pe_mmio_window,		OPAL_PCI_MAP_PE_MMIO_WINDOW);
+OPAL_CALL(opal_pci_set_phb_table_memory,	OPAL_PCI_SET_PHB_TABLE_MEMORY);
+OPAL_CALL(opal_pci_set_pe,			OPAL_PCI_SET_PE);
+OPAL_CALL(opal_pci_set_peltv,			OPAL_PCI_SET_PELTV);
+OPAL_CALL(opal_pci_set_mve,			OPAL_PCI_SET_MVE);
+OPAL_CALL(opal_pci_set_mve_enable,		OPAL_PCI_SET_MVE_ENABLE);
+OPAL_CALL(opal_pci_get_xive_reissue,		OPAL_PCI_GET_XIVE_REISSUE);
+OPAL_CALL(opal_pci_set_xive_reissue,		OPAL_PCI_SET_XIVE_REISSUE);
+OPAL_CALL(opal_pci_set_xive_pe,			OPAL_PCI_SET_XIVE_PE);
+OPAL_CALL(opal_get_xive_source,			OPAL_GET_XIVE_SOURCE);
+OPAL_CALL(opal_get_msi_32,			OPAL_GET_MSI_32);
+OPAL_CALL(opal_get_msi_64,			OPAL_GET_MSI_64);
+OPAL_CALL(opal_start_cpu,			OPAL_START_CPU);
+OPAL_CALL(opal_query_cpu_status,		OPAL_QUERY_CPU_STATUS);
+OPAL_CALL(opal_write_oppanel,			OPAL_WRITE_OPPANEL);
+OPAL_CALL(opal_pci_map_pe_dma_window,		OPAL_PCI_MAP_PE_DMA_WINDOW);
+OPAL_CALL(opal_pci_map_pe_dma_window_real,	OPAL_PCI_MAP_PE_DMA_WINDOW_REAL);
+OPAL_CALL(opal_pci_reset,			OPAL_PCI_RESET);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
new file mode 100644
index 0000000..8d55107
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -0,0 +1,154 @@
+/*
+ * PowerNV OPAL high level interfaces
+ *
+ * Copyright 2011 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#undef DEBUG
+
+#include <linux/types.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <asm/opal.h>
+#include <asm/firmware.h>
+
+#include "powernv.h"
+
+struct opal {
+	u64 base;
+	u64 entry;
+} opal;
+
+static struct device_node *opal_node;
+static DEFINE_SPINLOCK(opal_write_lock);
+
+int __init early_init_dt_scan_opal(unsigned long node,
+				   const char *uname, int depth, void *data)
+{
+	const void *basep, *entryp;
+	unsigned long basesz, entrysz;
+
+	if (depth != 1 || strcmp(uname, "ibm,opal") != 0)
+		return 0;
+
+	basep  = of_get_flat_dt_prop(node, "opal-base-address", &basesz);
+	entryp = of_get_flat_dt_prop(node, "opal-entry-address", &entrysz);
+
+	if (!basep || !entryp)
+		return 1;
+
+	opal.base = of_read_number(basep, basesz/4);
+	opal.entry = of_read_number(entryp, entrysz/4);
+
+	pr_debug("OPAL Base  = 0x%llx (basep=%p basesz=%ld)\n",
+		 opal.base, basep, basesz);
+	pr_debug("OPAL Entry = 0x%llx (entryp=%p basesz=%ld)\n",
+		 opal.entry, entryp, entrysz);
+
+	powerpc_firmware_features |= FW_FEATURE_OPAL;
+	if (of_flat_dt_is_compatible(node, "ibm,opal-v2")) {
+		powerpc_firmware_features |= FW_FEATURE_OPALv2;
+		printk("OPAL V2 detected !\n");
+	} else {
+		printk("OPAL V1 detected !\n");
+	}
+
+	return 1;
+}
+
+int opal_get_chars(uint32_t vtermno, char *buf, int count)
+{
+	s64 len, rc;
+	u64 evt;
+
+	if (!opal.entry)
+		return 0;
+	opal_poll_events(&evt);
+	if ((evt & OPAL_EVENT_CONSOLE_INPUT) == 0)
+		return 0;
+	len = count;
+	rc = opal_console_read(vtermno, &len, buf);
+	if (rc == OPAL_SUCCESS)
+		return len;
+	return 0;
+}
+
+int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
+{
+	int written = 0;
+	s64 len, rc = OPAL_BUSY;
+	unsigned long flags;
+	u64 evt;
+
+	if (!opal.entry)
+		return 0;
+
+	/* We want put_chars to be atomic to avoid mangling of hvsi
+	 * packets. To do that, we first test for room and return
+	 * -EAGAIN if there isn't enough
+	 */
+	spin_lock_irqsave(&opal_write_lock, flags);
+	rc = opal_console_write_buffer_space(vtermno, &len);
+	if (rc || len < total_len) {
+		spin_unlock_irqrestore(&opal_write_lock, flags);
+		/* Closed -> drop characters */
+		if (rc)
+			return total_len;
+		opal_poll_events(&evt);
+		return -EAGAIN;
+	}
+
+	/* We still try to handle partial completions, though they
+	 * should no longer happen.
+	 */
+	while(total_len > 0 && (rc == OPAL_BUSY ||
+				rc == OPAL_BUSY_EVENT || rc == OPAL_SUCCESS)) {
+		len = total_len;
+		rc = opal_console_write(vtermno, &len, data);
+		if (rc == OPAL_SUCCESS) {
+			total_len -= len;
+			data += len;
+			written += len;
+		}
+		/* This is a bit nasty but we need that for the console to
+		 * flush when there aren't any interrupts. We will clean
+		 * things a bit later to limit that to synchronous path
+		 * such as the kernel console and xmon/udbg
+		 */
+		do
+			opal_poll_events(&evt);
+		while(rc == OPAL_SUCCESS && (evt & OPAL_EVENT_CONSOLE_OUTPUT));
+	}
+	spin_unlock_irqrestore(&opal_write_lock, flags);
+	return written;
+}
+
+static int __init opal_init(void)
+{
+	struct device_node *np, *consoles;
+
+	opal_node = of_find_node_by_path("/ibm,opal");
+	if (!opal_node) {
+		pr_warn("opal: Node not found\n");
+		return -ENODEV;
+	}
+	if (firmware_has_feature(FW_FEATURE_OPALv2))
+		consoles = of_find_node_by_path("/ibm,opal/consoles");
+	else
+		consoles = of_node_get(opal_node);
+
+	/* Register serial ports */
+	for_each_child_of_node(consoles, np) {
+		if (strcmp(np->name, "serial"))
+			continue;
+		of_platform_device_create(np, NULL, NULL);
+	}
+	of_node_put(consoles);
+	return 0;
+}
+subsys_initcall(opal_init);
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 569f9cc..b6e5ff8 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -74,6 +74,12 @@ static void pnv_show_cpuinfo(struct seq_file *m)
 	if (root)
 		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: PowerNV %s\n", model);
+	if (firmware_has_feature(FW_FEATURE_OPALv2))
+		seq_printf(m, "firmware\t: OPAL v2\n");
+	else if (firmware_has_feature(FW_FEATURE_OPAL))
+		seq_printf(m, "firmware\t: OPAL v1\n");
+	else
+		seq_printf(m, "firmware\t: BML\n");
 	of_node_put(root);
 }
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 4f4ec37..e877366 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -30,6 +30,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/cputhreads.h>
 #include <asm/xics.h>
+#include <asm/opal.h>
 
 #include "powernv.h"
 
@@ -62,6 +63,28 @@ static int pnv_smp_cpu_bootable(unsigned int nr)
 	return 1;
 }
 
+int __devinit pnv_smp_kick_cpu(int nr)
+{
+	unsigned int pcpu = get_hard_smp_processor_id(nr);
+	unsigned long start_here = __pa(*((unsigned long *)
+					  generic_secondary_smp_init));
+	long rc;
+
+	BUG_ON(nr < 0 || nr >= NR_CPUS);
+
+	/* On OPAL v2 the CPU are still spinning inside OPAL itself,
+	 * get them back now
+	 */
+	if (firmware_has_feature(FW_FEATURE_OPALv2)) {
+		pr_devel("OPAL: Starting CPU %d (HW 0x%x)...\n", nr, pcpu);
+		rc = opal_start_cpu(pcpu, start_here);
+		if (rc != OPAL_SUCCESS)
+			pr_warn("OPAL Error %ld starting CPU %d\n",
+				rc, nr);
+	}
+	return smp_generic_kick_cpu(nr);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 
 static int pnv_smp_cpu_disable(void)
@@ -127,7 +150,7 @@ static struct smp_ops_t pnv_smp_ops = {
 	.message_pass	= smp_muxed_ipi_message_pass,
 	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
 	.probe		= xics_smp_probe,
-	.kick_cpu	= smp_generic_kick_cpu,
+	.kick_cpu	= pnv_smp_kick_cpu,
 	.setup_cpu	= pnv_smp_setup_cpu,
 	.cpu_bootable	= pnv_smp_cpu_bootable,
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.7.4.1
