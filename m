Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A07631A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:30 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 19:27:28 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E731F19D8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 19:18:34 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1A2Rk8S42860590
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:46 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2ROLA017138
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:25 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 10/18] powerpc/powernv: move OPAL API prototypes to opal-api.h
Date: Tue, 10 Feb 2015 13:26:52 +1100
Message-Id: <1423535220-6322-11-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To further the cause of syncing opal.h between firmware and linux,
move the function prototypes that were in opal.h out to opal-api.h
and fix the associated includes.

There are still a few places where opal.h is adequate.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h                |  240 ++++++++++++++++++++
 arch/powerpc/include/asm/opal.h                    |  224 ------------------
 arch/powerpc/kernel/prom.c                         |    1 +
 arch/powerpc/platforms/powernv/eeh-ioda.c          |    1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c       |    1 +
 arch/powerpc/platforms/powernv/opal-async.c        |    1 +
 arch/powerpc/platforms/powernv/opal-dump.c         |    1 +
 arch/powerpc/platforms/powernv/opal-elog.c         |    1 +
 arch/powerpc/platforms/powernv/opal-flash.c        |    1 +
 arch/powerpc/platforms/powernv/opal-hmi.c          |    1 +
 arch/powerpc/platforms/powernv/opal-lpc.c          |    1 +
 .../powerpc/platforms/powernv/opal-memory-errors.c |    1 +
 arch/powerpc/platforms/powernv/opal-msglog.c       |    1 +
 arch/powerpc/platforms/powernv/opal-nvram.c        |    1 +
 arch/powerpc/platforms/powernv/opal-rtc.c          |    1 +
 arch/powerpc/platforms/powernv/opal-sensor.c       |    1 +
 arch/powerpc/platforms/powernv/opal-sysparam.c     |    1 +
 arch/powerpc/platforms/powernv/opal-xscom.c        |    1 +
 arch/powerpc/platforms/powernv/opal.c              |    1 +
 arch/powerpc/platforms/powernv/pci-ioda.c          |    1 +
 arch/powerpc/platforms/powernv/pci-p5ioc2.c        |    1 +
 arch/powerpc/platforms/powernv/pci.c               |    1 +
 arch/powerpc/platforms/powernv/setup.c             |    1 +
 arch/powerpc/platforms/powernv/smp.c               |    1 +
 arch/powerpc/platforms/powernv/subcore.c           |    1 +
 arch/powerpc/sysdev/xics/ics-opal.c                |    1 +
 drivers/char/ipmi/ipmi_powernv.c                   |    2 +-
 drivers/hwmon/ibmpowernv.c                         |    1 +
 drivers/i2c/busses/i2c-opal.c                      |    1 +
 drivers/rtc/rtc-opal.c                             |    1 +
 drivers/tty/hvc/hvc_opal.c                         |    1 +
 31 files changed, 269 insertions(+), 225 deletions(-)
 create mode 100644 arch/powerpc/include/asm/opal-api.h

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
new file mode 100644
index 0000000..c4009dd
--- /dev/null
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -0,0 +1,240 @@
+/*
+ * PowerNV OPAL definitions.
+ *
+ * Copyright 2011 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef __OPAL_API_H
+#define __OPAL_API_H
+
+/* Linux specific definitions for interfacing with OPAL */
+
+/* /sys/firmware/opal */
+extern struct kobject *opal_kobj;
+
+/* /ibm,opal */
+extern struct device_node *opal_node;
+
+/* API functions */
+int64_t opal_invalid_call(void);
+int64_t opal_console_write(int64_t term_number, __be64 *length,
+			   const uint8_t *buffer);
+int64_t opal_console_read(int64_t term_number, __be64 *length,
+			  uint8_t *buffer);
+int64_t opal_console_write_buffer_space(int64_t term_number,
+					__be64 *length);
+int64_t opal_rtc_read(__be32 *year_month_day,
+		      __be64 *hour_minute_second_millisecond);
+int64_t opal_rtc_write(uint32_t year_month_day,
+		       uint64_t hour_minute_second_millisecond);
+int64_t opal_tpo_read(uint64_t token, __be32 *year_mon_day, __be32 *hour_min);
+int64_t opal_tpo_write(uint64_t token, uint32_t year_mon_day,
+		       uint32_t hour_min);
+int64_t opal_cec_power_down(uint64_t request);
+int64_t opal_cec_reboot(void);
+int64_t opal_read_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
+int64_t opal_write_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
+int64_t opal_handle_interrupt(uint64_t isn, __be64 *outstanding_event_mask);
+int64_t opal_poll_events(__be64 *outstanding_event_mask);
+int64_t opal_pci_set_hub_tce_memory(uint64_t hub_id, uint64_t tce_mem_addr,
+				    uint64_t tce_mem_size);
+int64_t opal_pci_set_phb_tce_memory(uint64_t phb_id, uint64_t tce_mem_addr,
+				    uint64_t tce_mem_size);
+int64_t opal_pci_config_read_byte(uint64_t phb_id, uint64_t bus_dev_func,
+				  uint64_t offset, uint8_t *data);
+int64_t opal_pci_config_read_half_word(uint64_t phb_id, uint64_t bus_dev_func,
+				       uint64_t offset, __be16 *data);
+int64_t opal_pci_config_read_word(uint64_t phb_id, uint64_t bus_dev_func,
+				  uint64_t offset, __be32 *data);
+int64_t opal_pci_config_write_byte(uint64_t phb_id, uint64_t bus_dev_func,
+				   uint64_t offset, uint8_t data);
+int64_t opal_pci_config_write_half_word(uint64_t phb_id, uint64_t bus_dev_func,
+					uint64_t offset, uint16_t data);
+int64_t opal_pci_config_write_word(uint64_t phb_id, uint64_t bus_dev_func,
+				   uint64_t offset, uint32_t data);
+int64_t opal_set_xive(uint32_t isn, uint16_t server, uint8_t priority);
+int64_t opal_get_xive(uint32_t isn, __be16 *server, uint8_t *priority);
+int64_t opal_register_exception_handler(uint64_t opal_exception,
+					uint64_t handler_address,
+					uint64_t glue_cache_line);
+int64_t opal_pci_eeh_freeze_status(uint64_t phb_id, uint64_t pe_number,
+				   uint8_t *freeze_state,
+				   __be16 *pci_error_type,
+				   __be64 *phb_status);
+int64_t opal_pci_eeh_freeze_clear(uint64_t phb_id, uint64_t pe_number,
+				  uint64_t eeh_action_token);
+int64_t opal_pci_eeh_freeze_set(uint64_t phb_id, uint64_t pe_number,
+				uint64_t eeh_action_token);
+int64_t opal_pci_err_inject(uint64_t phb_id, uint32_t pe_no, uint32_t type,
+			    uint32_t func, uint64_t addr, uint64_t mask);
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
+				    uint64_t size);
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
+int64_t opal_pci_msi_eoi(uint64_t phb_id, uint32_t hw_irq);
+int64_t opal_pci_set_xive_pe(uint64_t phb_id, uint32_t pe_number,
+			     uint32_t xive_num);
+int64_t opal_get_xive_source(uint64_t phb_id, uint32_t xive_num,
+			     __be32 *interrupt_source_number);
+int64_t opal_get_msi_32(uint64_t phb_id, uint32_t mve_number, uint32_t xive_num,
+			uint8_t msi_range, __be32 *msi_address,
+			__be32 *message_data);
+int64_t opal_get_msi_64(uint64_t phb_id, uint32_t mve_number,
+			uint32_t xive_num, uint8_t msi_range,
+			__be64 *msi_address, __be32 *message_data);
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
+int64_t opal_pci_get_hub_diag_data(uint64_t hub_id, void *diag_buffer,
+				   uint64_t diag_buffer_len);
+int64_t opal_pci_get_phb_diag_data(uint64_t phb_id, void *diag_buffer,
+				   uint64_t diag_buffer_len);
+int64_t opal_pci_get_phb_diag_data2(uint64_t phb_id, void *diag_buffer,
+				    uint64_t diag_buffer_len);
+int64_t opal_pci_fence_phb(uint64_t phb_id);
+int64_t opal_pci_reinit(uint64_t phb_id, uint64_t reinit_scope, uint64_t data);
+int64_t opal_pci_mask_pe_error(uint64_t phb_id, uint16_t pe_number, uint8_t error_type, uint8_t mask_action);
+int64_t opal_set_slot_led_status(uint64_t phb_id, uint64_t slot_id, uint8_t led_type, uint8_t led_action);
+int64_t opal_get_epow_status(__be64 *status);
+int64_t opal_set_system_attention_led(uint8_t led_action);
+int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
+			    __be16 *pci_error_type, __be16 *severity);
+int64_t opal_pci_poll(uint64_t phb_id);
+int64_t opal_return_cpu(void);
+int64_t opal_check_token(uint64_t token);
+int64_t opal_reinit_cpus(uint64_t flags);
+
+int64_t opal_xscom_read(uint32_t gcid, uint64_t pcb_addr, __be64 *val);
+int64_t opal_xscom_write(uint32_t gcid, uint64_t pcb_addr, uint64_t val);
+
+int64_t opal_lpc_write(uint32_t chip_id, enum OpalLPCAddressType addr_type,
+		       uint32_t addr, uint32_t data, uint32_t sz);
+int64_t opal_lpc_read(uint32_t chip_id, enum OpalLPCAddressType addr_type,
+		      uint32_t addr, __be32 *data, uint32_t sz);
+
+int64_t opal_read_elog(uint64_t buffer, uint64_t size, uint64_t log_id);
+int64_t opal_get_elog_size(__be64 *log_id, __be64 *size, __be64 *elog_type);
+int64_t opal_write_elog(uint64_t buffer, uint64_t size, uint64_t offset);
+int64_t opal_send_ack_elog(uint64_t log_id);
+void opal_resend_pending_logs(void);
+
+int64_t opal_validate_flash(uint64_t buffer, uint32_t *size, uint32_t *result);
+int64_t opal_manage_flash(uint8_t op);
+int64_t opal_update_flash(uint64_t blk_list);
+int64_t opal_dump_init(uint8_t dump_type);
+int64_t opal_dump_info(__be32 *dump_id, __be32 *dump_size);
+int64_t opal_dump_info2(__be32 *dump_id, __be32 *dump_size, __be32 *dump_type);
+int64_t opal_dump_read(uint32_t dump_id, uint64_t buffer);
+int64_t opal_dump_ack(uint32_t dump_id);
+int64_t opal_dump_resend_notification(void);
+
+int64_t opal_get_msg(uint64_t buffer, uint64_t size);
+int64_t opal_check_completion(uint64_t buffer, uint64_t size, uint64_t token);
+int64_t opal_sync_host_reboot(void);
+int64_t opal_get_param(uint64_t token, uint32_t param_id, uint64_t buffer,
+		uint64_t length);
+int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
+		uint64_t length);
+int64_t opal_sensor_read(uint32_t sensor_hndl, int token, __be32 *sensor_data);
+int64_t opal_handle_hmi(void);
+int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
+int64_t opal_unregister_dump_region(uint32_t id);
+int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
+int64_t opal_pci_set_phb_capi_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
+int64_t opal_ipmi_send(uint64_t interface, struct opal_ipmi_msg *msg,
+		uint64_t msg_len);
+int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
+		uint64_t *msg_len);
+int64_t opal_i2c_request(uint64_t async_token, uint32_t bus_id,
+			 struct opal_i2c_request *oreq);
+
+/* Internal functions */
+extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
+				   int depth, void *data);
+extern int early_init_dt_scan_recoverable_ranges(unsigned long node,
+				 const char *uname, int depth, void *data);
+
+extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
+extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
+
+extern void hvc_opal_init_early(void);
+
+extern int opal_notifier_register(struct notifier_block *nb);
+extern int opal_notifier_unregister(struct notifier_block *nb);
+
+extern int opal_message_notifier_register(enum OpalMessageType msg_type,
+						struct notifier_block *nb);
+extern void opal_notifier_enable(void);
+extern void opal_notifier_disable(void);
+extern void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val);
+
+extern int __opal_async_get_token(void);
+extern int opal_async_get_token_interruptible(void);
+extern int __opal_async_release_token(int token);
+extern int opal_async_release_token(int token);
+extern int opal_async_wait_response(uint64_t token, struct opal_msg *msg);
+extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
+
+struct rtc_time;
+extern unsigned long opal_get_boot_time(void);
+extern void opal_nvram_init(void);
+extern void opal_flash_init(void);
+extern void opal_flash_term_callback(void);
+extern int opal_elog_init(void);
+extern void opal_platform_dump_init(void);
+extern void opal_sys_param_init(void);
+extern void opal_msglog_init(void);
+
+extern int opal_machine_check(struct pt_regs *regs);
+extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
+extern int opal_hmi_exception_early(struct pt_regs *regs);
+extern int opal_handle_hmi_exception(struct pt_regs *regs);
+
+extern void opal_shutdown(void);
+extern int opal_resync_timebase(void);
+
+extern void opal_lpc_init(void);
+
+struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
+					     unsigned long vmalloc_size);
+void opal_free_sg_list(struct opal_sg_list *sg);
+#endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 2deaadf..4373010 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -763,230 +763,6 @@ struct opal_i2c_request {
 	__be64 buffer_ra;		/* Buffer real address */
 };
 
-/* /sys/firmware/opal */
-extern struct kobject *opal_kobj;
-
-/* /ibm,opal */
-extern struct device_node *opal_node;
-
-/* API functions */
-int64_t opal_invalid_call(void);
-int64_t opal_console_write(int64_t term_number, __be64 *length,
-			   const uint8_t *buffer);
-int64_t opal_console_read(int64_t term_number, __be64 *length,
-			  uint8_t *buffer);
-int64_t opal_console_write_buffer_space(int64_t term_number,
-					__be64 *length);
-int64_t opal_rtc_read(__be32 *year_month_day,
-		      __be64 *hour_minute_second_millisecond);
-int64_t opal_rtc_write(uint32_t year_month_day,
-		       uint64_t hour_minute_second_millisecond);
-int64_t opal_tpo_read(uint64_t token, __be32 *year_mon_day, __be32 *hour_min);
-int64_t opal_tpo_write(uint64_t token, uint32_t year_mon_day,
-		       uint32_t hour_min);
-int64_t opal_cec_power_down(uint64_t request);
-int64_t opal_cec_reboot(void);
-int64_t opal_read_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
-int64_t opal_write_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
-int64_t opal_handle_interrupt(uint64_t isn, __be64 *outstanding_event_mask);
-int64_t opal_poll_events(__be64 *outstanding_event_mask);
-int64_t opal_pci_set_hub_tce_memory(uint64_t hub_id, uint64_t tce_mem_addr,
-				    uint64_t tce_mem_size);
-int64_t opal_pci_set_phb_tce_memory(uint64_t phb_id, uint64_t tce_mem_addr,
-				    uint64_t tce_mem_size);
-int64_t opal_pci_config_read_byte(uint64_t phb_id, uint64_t bus_dev_func,
-				  uint64_t offset, uint8_t *data);
-int64_t opal_pci_config_read_half_word(uint64_t phb_id, uint64_t bus_dev_func,
-				       uint64_t offset, __be16 *data);
-int64_t opal_pci_config_read_word(uint64_t phb_id, uint64_t bus_dev_func,
-				  uint64_t offset, __be32 *data);
-int64_t opal_pci_config_write_byte(uint64_t phb_id, uint64_t bus_dev_func,
-				   uint64_t offset, uint8_t data);
-int64_t opal_pci_config_write_half_word(uint64_t phb_id, uint64_t bus_dev_func,
-					uint64_t offset, uint16_t data);
-int64_t opal_pci_config_write_word(uint64_t phb_id, uint64_t bus_dev_func,
-				   uint64_t offset, uint32_t data);
-int64_t opal_set_xive(uint32_t isn, uint16_t server, uint8_t priority);
-int64_t opal_get_xive(uint32_t isn, __be16 *server, uint8_t *priority);
-int64_t opal_register_exception_handler(uint64_t opal_exception,
-					uint64_t handler_address,
-					uint64_t glue_cache_line);
-int64_t opal_pci_eeh_freeze_status(uint64_t phb_id, uint64_t pe_number,
-				   uint8_t *freeze_state,
-				   __be16 *pci_error_type,
-				   __be64 *phb_status);
-int64_t opal_pci_eeh_freeze_clear(uint64_t phb_id, uint64_t pe_number,
-				  uint64_t eeh_action_token);
-int64_t opal_pci_eeh_freeze_set(uint64_t phb_id, uint64_t pe_number,
-				uint64_t eeh_action_token);
-int64_t opal_pci_err_inject(uint64_t phb_id, uint32_t pe_no, uint32_t type,
-			    uint32_t func, uint64_t addr, uint64_t mask);
-int64_t opal_pci_shpc(uint64_t phb_id, uint64_t shpc_action, uint8_t *state);
-
-
-
-int64_t opal_pci_phb_mmio_enable(uint64_t phb_id, uint16_t window_type,
-				 uint16_t window_num, uint16_t enable);
-int64_t opal_pci_set_phb_mem_window(uint64_t phb_id, uint16_t window_type,
-				    uint16_t window_num,
-				    uint64_t starting_real_address,
-				    uint64_t starting_pci_address,
-				    uint64_t size);
-int64_t opal_pci_map_pe_mmio_window(uint64_t phb_id, uint16_t pe_number,
-				    uint16_t window_type, uint16_t window_num,
-				    uint16_t segment_num);
-int64_t opal_pci_set_phb_table_memory(uint64_t phb_id, uint64_t rtt_addr,
-				      uint64_t ivt_addr, uint64_t ivt_len,
-				      uint64_t reject_array_addr,
-				      uint64_t peltv_addr);
-int64_t opal_pci_set_pe(uint64_t phb_id, uint64_t pe_number, uint64_t bus_dev_func,
-			uint8_t bus_compare, uint8_t dev_compare, uint8_t func_compare,
-			uint8_t pe_action);
-int64_t opal_pci_set_peltv(uint64_t phb_id, uint32_t parent_pe, uint32_t child_pe,
-			   uint8_t state);
-int64_t opal_pci_set_mve(uint64_t phb_id, uint32_t mve_number, uint32_t pe_number);
-int64_t opal_pci_set_mve_enable(uint64_t phb_id, uint32_t mve_number,
-				uint32_t state);
-int64_t opal_pci_get_xive_reissue(uint64_t phb_id, uint32_t xive_number,
-				  uint8_t *p_bit, uint8_t *q_bit);
-int64_t opal_pci_set_xive_reissue(uint64_t phb_id, uint32_t xive_number,
-				  uint8_t p_bit, uint8_t q_bit);
-int64_t opal_pci_msi_eoi(uint64_t phb_id, uint32_t hw_irq);
-int64_t opal_pci_set_xive_pe(uint64_t phb_id, uint32_t pe_number,
-			     uint32_t xive_num);
-int64_t opal_get_xive_source(uint64_t phb_id, uint32_t xive_num,
-			     __be32 *interrupt_source_number);
-int64_t opal_get_msi_32(uint64_t phb_id, uint32_t mve_number, uint32_t xive_num,
-			uint8_t msi_range, __be32 *msi_address,
-			__be32 *message_data);
-int64_t opal_get_msi_64(uint64_t phb_id, uint32_t mve_number,
-			uint32_t xive_num, uint8_t msi_range,
-			__be64 *msi_address, __be32 *message_data);
-int64_t opal_start_cpu(uint64_t thread_number, uint64_t start_address);
-int64_t opal_query_cpu_status(uint64_t thread_number, uint8_t *thread_status);
-int64_t opal_write_oppanel(oppanel_line_t *lines, uint64_t num_lines);
-int64_t opal_pci_map_pe_dma_window(uint64_t phb_id, uint16_t pe_number, uint16_t window_id,
-				   uint16_t tce_levels, uint64_t tce_table_addr,
-				   uint64_t tce_table_size, uint64_t tce_page_size);
-int64_t opal_pci_map_pe_dma_window_real(uint64_t phb_id, uint16_t pe_number,
-					uint16_t dma_window_number, uint64_t pci_start_addr,
-					uint64_t pci_mem_size);
-int64_t opal_pci_reset(uint64_t phb_id, uint8_t reset_scope, uint8_t assert_state);
-
-int64_t opal_pci_get_hub_diag_data(uint64_t hub_id, void *diag_buffer,
-				   uint64_t diag_buffer_len);
-int64_t opal_pci_get_phb_diag_data(uint64_t phb_id, void *diag_buffer,
-				   uint64_t diag_buffer_len);
-int64_t opal_pci_get_phb_diag_data2(uint64_t phb_id, void *diag_buffer,
-				    uint64_t diag_buffer_len);
-int64_t opal_pci_fence_phb(uint64_t phb_id);
-int64_t opal_pci_reinit(uint64_t phb_id, uint64_t reinit_scope, uint64_t data);
-int64_t opal_pci_mask_pe_error(uint64_t phb_id, uint16_t pe_number, uint8_t error_type, uint8_t mask_action);
-int64_t opal_set_slot_led_status(uint64_t phb_id, uint64_t slot_id, uint8_t led_type, uint8_t led_action);
-int64_t opal_get_epow_status(__be64 *status);
-int64_t opal_set_system_attention_led(uint8_t led_action);
-int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
-			    __be16 *pci_error_type, __be16 *severity);
-int64_t opal_pci_poll(uint64_t phb_id);
-int64_t opal_return_cpu(void);
-int64_t opal_check_token(uint64_t token);
-int64_t opal_reinit_cpus(uint64_t flags);
-
-int64_t opal_xscom_read(uint32_t gcid, uint64_t pcb_addr, __be64 *val);
-int64_t opal_xscom_write(uint32_t gcid, uint64_t pcb_addr, uint64_t val);
-
-int64_t opal_lpc_write(uint32_t chip_id, enum OpalLPCAddressType addr_type,
-		       uint32_t addr, uint32_t data, uint32_t sz);
-int64_t opal_lpc_read(uint32_t chip_id, enum OpalLPCAddressType addr_type,
-		      uint32_t addr, __be32 *data, uint32_t sz);
-
-int64_t opal_read_elog(uint64_t buffer, uint64_t size, uint64_t log_id);
-int64_t opal_get_elog_size(__be64 *log_id, __be64 *size, __be64 *elog_type);
-int64_t opal_write_elog(uint64_t buffer, uint64_t size, uint64_t offset);
-int64_t opal_send_ack_elog(uint64_t log_id);
-void opal_resend_pending_logs(void);
-
-int64_t opal_validate_flash(uint64_t buffer, uint32_t *size, uint32_t *result);
-int64_t opal_manage_flash(uint8_t op);
-int64_t opal_update_flash(uint64_t blk_list);
-int64_t opal_dump_init(uint8_t dump_type);
-int64_t opal_dump_info(__be32 *dump_id, __be32 *dump_size);
-int64_t opal_dump_info2(__be32 *dump_id, __be32 *dump_size, __be32 *dump_type);
-int64_t opal_dump_read(uint32_t dump_id, uint64_t buffer);
-int64_t opal_dump_ack(uint32_t dump_id);
-int64_t opal_dump_resend_notification(void);
-
-int64_t opal_get_msg(uint64_t buffer, uint64_t size);
-int64_t opal_check_completion(uint64_t buffer, uint64_t size, uint64_t token);
-int64_t opal_sync_host_reboot(void);
-int64_t opal_get_param(uint64_t token, uint32_t param_id, uint64_t buffer,
-		uint64_t length);
-int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
-		uint64_t length);
-int64_t opal_sensor_read(uint32_t sensor_hndl, int token, __be32 *sensor_data);
-int64_t opal_handle_hmi(void);
-int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
-int64_t opal_unregister_dump_region(uint32_t id);
-int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
-int64_t opal_pci_set_phb_capi_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
-int64_t opal_ipmi_send(uint64_t interface, struct opal_ipmi_msg *msg,
-		uint64_t msg_len);
-int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
-		uint64_t *msg_len);
-int64_t opal_i2c_request(uint64_t async_token, uint32_t bus_id,
-			 struct opal_i2c_request *oreq);
-
-/* Internal functions */
-extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
-				   int depth, void *data);
-extern int early_init_dt_scan_recoverable_ranges(unsigned long node,
-				 const char *uname, int depth, void *data);
-
-extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
-extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
-
-extern void hvc_opal_init_early(void);
-
-extern int opal_notifier_register(struct notifier_block *nb);
-extern int opal_notifier_unregister(struct notifier_block *nb);
-
-extern int opal_message_notifier_register(enum OpalMessageType msg_type,
-						struct notifier_block *nb);
-extern void opal_notifier_enable(void);
-extern void opal_notifier_disable(void);
-extern void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val);
-
-extern int __opal_async_get_token(void);
-extern int opal_async_get_token_interruptible(void);
-extern int __opal_async_release_token(int token);
-extern int opal_async_release_token(int token);
-extern int opal_async_wait_response(uint64_t token, struct opal_msg *msg);
-extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
-
-struct rtc_time;
-extern unsigned long opal_get_boot_time(void);
-extern void opal_nvram_init(void);
-extern void opal_flash_init(void);
-extern void opal_flash_term_callback(void);
-extern int opal_elog_init(void);
-extern void opal_platform_dump_init(void);
-extern void opal_sys_param_init(void);
-extern void opal_msglog_init(void);
-
-extern int opal_machine_check(struct pt_regs *regs);
-extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
-extern int opal_hmi_exception_early(struct pt_regs *regs);
-extern int opal_handle_hmi_exception(struct pt_regs *regs);
-
-extern void opal_shutdown(void);
-extern int opal_resync_timebase(void);
-
-extern void opal_lpc_init(void);
-
-struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
-					     unsigned long vmalloc_size);
-void opal_free_sg_list(struct opal_sg_list *sg);
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_H */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 6a799b3..18bce9b 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -54,6 +54,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/kexec.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/fadump.h>
 #include <asm/debug.h>
 
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 2809c98..c619ecc 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -27,6 +27,7 @@
 #include <asm/iommu.h>
 #include <asm/msi_bitmap.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
 #include <asm/tce.h>
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 1d19e79..8de102c 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -33,6 +33,7 @@
 #include <asm/machdep.h>
 #include <asm/msi_bitmap.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/ppc-pci.h>
 
 #include "powernv.h"
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index 693b6cd..9bfad37 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <asm/machdep.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 
 #define N_ASYNC_COMPLETIONS	64
 
diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 23260f7..d8b4c25 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 
 #define DUMP_TYPE_FSP	0x01
 
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 518fe95..63d12c3 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -19,6 +19,7 @@
 #include <linux/kobject.h>
 #include <asm/uaccess.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 
 struct elog_obj {
 	struct kobject kobj;
diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index 5c21d9c..94846aa 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 
 /* FLASH status codes */
 #define FLASH_NO_OP		-1099	/* No operation initiated by user */
diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index b322bfb..3658a36 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/cputable.h>
 #include <asm/machdep.h>
 
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index e4169d6..40c7115 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -20,6 +20,7 @@
 #include <asm/firmware.h>
 #include <asm/xics.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/prom.h>
 #include <asm/uaccess.h>
 #include <asm/debug.h>
diff --git a/arch/powerpc/platforms/powernv/opal-memory-errors.c b/arch/powerpc/platforms/powernv/opal-memory-errors.c
index 43db213..027988a 100644
--- a/arch/powerpc/platforms/powernv/opal-memory-errors.c
+++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
@@ -29,6 +29,7 @@
 
 #include <asm/machdep.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/cputable.h>
 
 static int opal_mem_err_nb_init;
diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 44ed78a..4cb0f29 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -11,6 +11,7 @@
 
 #include <asm/io.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <linux/debugfs.h>
 #include <linux/of.h>
 #include <linux/types.h>
diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c
index f9896fd..c26084c 100644
--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/machdep.h>
 
 static unsigned int nvram_size;
diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
index 37dbee1..21f8f9b 100644
--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/firmware.h>
 #include <asm/machdep.h>
 
diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
index 4ab67ef..7a41921 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -22,6 +22,7 @@
 #include <linux/mutex.h>
 #include <linux/of_platform.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/machdep.h>
 
 static DEFINE_MUTEX(opal_sensor_mutex);
diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index 9d1acf2..2d1c486 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -25,6 +25,7 @@
 #include <linux/gfp.h>
 #include <linux/stat.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 
 #define MAX_PARAM_DATA_LEN	64
 
diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 7634d1c..ce5642a 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -18,6 +18,7 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/scom.h>
 
 /*
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f10b9ec..2925cf0 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -26,6 +26,7 @@
 
 #include <asm/machdep.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3bc5917..28810bc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -32,6 +32,7 @@
 #include <asm/msi_bitmap.h>
 #include <asm/ppc-pci.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
 #include <asm/xics.h>
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 6ef6d4d..7261eb8e 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -29,6 +29,7 @@
 #include <asm/msi_bitmap.h>
 #include <asm/ppc-pci.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4945e87..c8a035a 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -29,6 +29,7 @@
 #include <asm/msi_bitmap.h>
 #include <asm/ppc-pci.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
 #include <asm/firmware.h>
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d2de7d5..9fe6fe3 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -34,6 +34,7 @@
 #include <asm/xics.h>
 #include <asm/rtas.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/kexec.h>
 #include <asm/smp.h>
 #include <asm/cputhreads.h>
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index fc34025..94d8ca0 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -30,6 +30,7 @@
 #include <asm/cputhreads.h>
 #include <asm/xics.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/runlatch.h>
 #include <asm/code-patching.h>
 #include <asm/dbell.h>
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index f60f80a..1a1d59d 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -21,6 +21,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/machdep.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/smp.h>
 
 #include "subcore.h"
diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
index 4ba554e..983b6f4 100644
--- a/arch/powerpc/sysdev/xics/ics-opal.c
+++ b/arch/powerpc/sysdev/xics/ics-opal.c
@@ -29,6 +29,7 @@
 #include <asm/errno.h>
 #include <asm/xics.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/firmware.h>
 
 static int ics_opal_mangle_server(int server)
diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
index 79524ed..86f17f2 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -17,7 +17,7 @@
 #include <linux/of.h>
 
 #include <asm/opal.h>
-
+#include <asm/opal-api.h>
 
 struct ipmi_smi_powernv {
 	u64			interface_id;
diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index febe817..fb5ae1b 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -29,6 +29,7 @@
 
 #include <linux/platform_device.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <linux/err.h>
 
 #define MAX_ATTR_LEN	32
diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
index 16f90b1..dec8892 100644
--- a/drivers/i2c/busses/i2c-opal.c
+++ b/drivers/i2c/busses/i2c-opal.c
@@ -27,6 +27,7 @@
 
 #include <asm/firmware.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 
 static int i2c_opal_translate_error(int rc)
 {
diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 95f6521..5b82541 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/firmware.h>
 
 static void opal_to_tm(u32 y_m_d, u64 h_m_s_ms, struct rtc_time *tm)
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 071551b..8d4a91d 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -36,6 +36,7 @@
 #include <asm/hvsi.h>
 #include <asm/udbg.h>
 #include <asm/opal.h>
+#include <asm/opal-api.h>
 
 #include "hvc_console.h"
 
-- 
1.7.10.4
