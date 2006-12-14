Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62D9C67D34
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 13:30:33 +1100 (EST)
Date: Thu, 14 Dec 2006 11:30:28 +0900 (JST)
Message-Id: <200612140230.kBE2UT9R014367@toshiba.co.jp>
Subject: [PATCH 7/19] powerpc: hypervisor call numbers for Celleb
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch creates Celleb platform dependent file to define Beat
hypervisor call numbers.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat_syscall.h
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/beat_syscall.h:1.1
--- /dev/null	Wed Dec 13 21:32:01 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat_syscall.h	Wed Dec  6 08:43:15 2006
@@ -0,0 +1,159 @@
+/*
+ * Beat hypervisor call numbers
+ *
+ * (C) Copyright 2004-2006 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef BEAT_BEAT_syscall_H
+#define BEAT_BEAT_syscall_H
+
+#ifdef	__ASSEMBLY__
+#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((__v)<<60|(__x))
+#elif defined(__powerpc64__)
+#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((unsigned long)(__v)<<60|(__x))
+#else
+#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((unsigned long long)(__v)<<60|(__x))
+#endif
+#define HV_allocate_memory (0)
+#define HV_construct_virtual_address_space (2)
+#define HV_destruct_virtual_address_space (10)
+#define HV_get_virtual_address_space_id_of_ppe (4)
+#define HV_query_logical_partition_address_region_info (6)
+#define HV_release_memory (13)
+#define HV_select_virtual_address_space (7)
+#define HV_load_range_registers (68)
+#define HV_set_ppe_l2cache_rmt_entry (70)
+#define HV_set_ppe_tlb_rmt_entry (71)
+#define HV_set_spe_tlb_rmt_entry (72)
+#define HV_get_io_address_translation_fault_info (14)
+#define HV_get_iopte (16)
+#define HV_preload_iopt_cache (17)
+#define HV_put_iopte (15)
+#define HV_connect_event_ports (21)
+#define HV_construct_event_receive_port (18)
+#define HV_destruct_event_receive_port (19)
+#define HV_destruct_event_send_port (22)
+#define HV_get_state_of_event_send_port (25)
+#define HV_request_to_connect_event_ports (20)
+#define HV_send_event_externally (23)
+#define HV_send_event_locally (24)
+#define HV_construct_and_connect_irq_plug (28)
+#define HV_destruct_irq_plug (29)
+#define HV_detect_pending_interrupts (26)
+#define HV_end_of_interrupt (27)
+#define HV_assign_control_signal_notification_port (45)
+#define HV_end_of_control_signal_processing (48)
+#define HV_get_control_signal (46)
+#define HV_set_irq_mask_for_spe (61)
+#define HV_shutdown_logical_partition (44)
+#define HV_connect_message_ports (35)
+#define HV_destruct_message_port (36)
+#define HV_receive_message (37)
+#define HV_get_message_port_info (34)
+#define HV_request_to_connect_message_ports (33)
+#define HV_send_message (32)
+#define HV_get_logical_ppe_id (69)
+#define HV_pause (9)
+#define HV_destruct_shared_memory_handle (51)
+#define HV_get_shared_memory_info (52)
+#define HV_permit_sharing_memory (50)
+#define HV_request_to_attach_shared_memory (49)
+#define HV_enable_logical_spe_execution (55)
+#define HV_construct_logical_spe (53)
+#define HV_disable_logical_spe_execution (56)
+#define HV_destruct_logical_spe (54)
+#define HV_sense_spe_execution_status (58)
+#define HV_insert_htab_entry (101)
+#define HV_read_htab_entries (95)
+#define HV_write_htab_entry (94)
+#define HV_assign_io_address_translation_fault_port (100)
+#define HV_set_interrupt_mask (73)
+#define HV_get_logical_partition_id (74)
+#define HV_create_repository_node2 (90)
+#define HV_create_repository_node (90)	/* alias */
+#define HV_get_repository_node_value2 (91)
+#define HV_get_repository_node_value (91)	/* alias */
+#define HV_modify_repository_node_value2 (92)
+#define HV_modify_repository_node_value (92)	/* alias */
+#define HV_remove_repository_node2 (93)
+#define HV_remove_repository_node (93)	/* alias */
+#define HV_cancel_shared_memory (104)
+#define HV_clear_interrupt_status_of_spe (206)
+#define HV_construct_spe_irq_outlet (80)
+#define HV_destruct_spe_irq_outlet (81)
+#define HV_disconnect_ipspc_service (88)
+#define HV_execute_ipspc_command (86)
+#define HV_get_interrupt_status_of_spe (205)
+#define HV_get_spe_privileged_state_1_registers (208)
+#define HV_permit_use_of_ipspc_service (85)
+#define HV_reinitialize_logical_spe (82)
+#define HV_request_ipspc_service (84)
+#define HV_stop_ipspc_command (87)
+#define HV_set_spe_privileged_state_1_registers (204)
+#define HV_get_status_of_ipspc_service (203)
+#define HV_put_characters_to_console __BEAT_ADD_VENDOR_ID(0x101, 1)
+#define HV_get_characters_from_console __BEAT_ADD_VENDOR_ID(0x102, 1)
+#define HV_get_base_clock __BEAT_ADD_VENDOR_ID(0x111, 1)
+#define HV_set_base_clock __BEAT_ADD_VENDOR_ID(0x112, 1)
+#define HV_get_frame_cycle __BEAT_ADD_VENDOR_ID(0x114, 1)
+#define HV_disable_console __BEAT_ADD_VENDOR_ID(0x115, 1)
+#define HV_disable_all_console __BEAT_ADD_VENDOR_ID(0x116, 1)
+#define HV_oneshot_timer __BEAT_ADD_VENDOR_ID(0x117, 1)
+#define HV_set_dabr __BEAT_ADD_VENDOR_ID(0x118, 1)
+#define HV_get_dabr __BEAT_ADD_VENDOR_ID(0x119, 1)
+#define HV_start_hv_stats __BEAT_ADD_VENDOR_ID(0x21c, 1)
+#define HV_stop_hv_stats __BEAT_ADD_VENDOR_ID(0x21d, 1)
+#define HV_get_hv_stats __BEAT_ADD_VENDOR_ID(0x21e, 1)
+#define HV_get_hv_error_stats __BEAT_ADD_VENDOR_ID(0x221, 1)
+#define HV_get_stats __BEAT_ADD_VENDOR_ID(0x224, 1)
+#define HV_get_heap_stats __BEAT_ADD_VENDOR_ID(0x225, 1)
+#define HV_get_memory_stats __BEAT_ADD_VENDOR_ID(0x227, 1)
+#define HV_get_memory_detail __BEAT_ADD_VENDOR_ID(0x228, 1)
+#define HV_set_priority_of_irq_outlet __BEAT_ADD_VENDOR_ID(0x122, 1)
+#define HV_get_physical_spe_by_reservation_id __BEAT_ADD_VENDOR_ID(0x128, 1)
+#define HV_get_spe_context __BEAT_ADD_VENDOR_ID(0x129, 1)
+#define HV_set_spe_context __BEAT_ADD_VENDOR_ID(0x12a, 1)
+#define HV_downcount_of_interrupt __BEAT_ADD_VENDOR_ID(0x12e, 1)
+#define HV_peek_spe_context __BEAT_ADD_VENDOR_ID(0x12f, 1)
+#define HV_read_bpa_register __BEAT_ADD_VENDOR_ID(0x131, 1)
+#define HV_write_bpa_register __BEAT_ADD_VENDOR_ID(0x132, 1)
+#define HV_map_context_table_of_spe __BEAT_ADD_VENDOR_ID(0x137, 1)
+#define HV_get_slb_for_logical_spe __BEAT_ADD_VENDOR_ID(0x138, 1)
+#define HV_set_slb_for_logical_spe __BEAT_ADD_VENDOR_ID(0x139, 1)
+#define HV_init_pm __BEAT_ADD_VENDOR_ID(0x150, 1)
+#define HV_set_pm_signal __BEAT_ADD_VENDOR_ID(0x151, 1)
+#define HV_get_pm_signal __BEAT_ADD_VENDOR_ID(0x152, 1)
+#define HV_set_pm_config __BEAT_ADD_VENDOR_ID(0x153, 1)
+#define HV_get_pm_config __BEAT_ADD_VENDOR_ID(0x154, 1)
+#define HV_get_inner_trace_data __BEAT_ADD_VENDOR_ID(0x155, 1)
+#define HV_set_ext_trace_buffer __BEAT_ADD_VENDOR_ID(0x156, 1)
+#define HV_get_ext_trace_buffer __BEAT_ADD_VENDOR_ID(0x157, 1)
+#define HV_set_pm_interrupt __BEAT_ADD_VENDOR_ID(0x158, 1)
+#define HV_get_pm_interrupt __BEAT_ADD_VENDOR_ID(0x159, 1)
+#define HV_kick_pm __BEAT_ADD_VENDOR_ID(0x160, 1)
+#define HV_construct_pm_context __BEAT_ADD_VENDOR_ID(0x164, 1)
+#define HV_destruct_pm_context __BEAT_ADD_VENDOR_ID(0x165, 1)
+#define HV_be_slow __BEAT_ADD_VENDOR_ID(0x170, 1)
+#define HV_assign_ipspc_server_connection_status_notification_port __BEAT_ADD_VENDOR_ID(0x173, 1)
+#define HV_get_raid_of_physical_spe __BEAT_ADD_VENDOR_ID(0x174, 1)
+#define HV_set_physical_spe_to_rag __BEAT_ADD_VENDOR_ID(0x175, 1)
+#define HV_release_physical_spe_from_rag __BEAT_ADD_VENDOR_ID(0x176, 1)
+#define HV_rtc_read __BEAT_ADD_VENDOR_ID(0x190, 1)
+#define HV_rtc_write __BEAT_ADD_VENDOR_ID(0x191, 1)
+#define HV_eeprom_read __BEAT_ADD_VENDOR_ID(0x192, 1)
+#define HV_eeprom_write __BEAT_ADD_VENDOR_ID(0x193, 1)
+#endif
