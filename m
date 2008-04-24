Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA7A7DDF48
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 19:27:53 +1000 (EST)
Date: Thu, 24 Apr 2008 18:27:32 +0900 (JST)
Message-Id: <20080424.182732.-345492894.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 5/9] celleb: move files for Beat hvcall interfaces
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves files for Beat hvcall interfaces into platforms/cell/.
All files in this patch are used by celleb-beat only.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/Makefile         |    3 
 arch/powerpc/platforms/cell/beat_hvCall.S    |  287 ++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/beat_syscall.h   |  164 +++++++++++++++
 arch/powerpc/platforms/cell/beat_wrapper.h   |  289 +++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/celleb_setup.c   |    2 
 arch/powerpc/platforms/celleb/Makefile       |    2 
 arch/powerpc/platforms/celleb/beat.c         |    2 
 arch/powerpc/platforms/celleb/beat_syscall.h |  164 ---------------
 arch/powerpc/platforms/celleb/beat_wrapper.h |  289 ---------------------------
 arch/powerpc/platforms/celleb/htab.c         |    2 
 arch/powerpc/platforms/celleb/hvCall.S       |  287 --------------------------
 arch/powerpc/platforms/celleb/interrupt.c    |    2 
 arch/powerpc/platforms/celleb/iommu.c        |    2 
 arch/powerpc/platforms/celleb/spu_priv1.c    |    2 
 14 files changed, 749 insertions(+), 748 deletions(-)

Index: b/arch/powerpc/platforms/cell/beat_hvCall.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/beat_hvCall.S	2008-04-23 21:38:14.000000000 +0900
@@ -0,0 +1,287 @@
+/*
+ * Beat hypervisor call I/F
+ *
+ * (C) Copyright 2007 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/pseries/hvCall.S.
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
+#include <asm/ppc_asm.h>
+
+#define	STK_PARM(i)	(48 + ((i)-3)*8)
+
+/* Not implemented on Beat, now */
+#define	HCALL_INST_PRECALL
+#define	HCALL_INST_POSTCALL
+
+	.text
+
+#define	HVSC	.long	0x44000022
+
+/* Note: takes only 7 input parameters at maximum */
+_GLOBAL(beat_hcall_norets)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	HCALL_INST_PRECALL
+
+	mr	r11,r3
+	mr	r3,r4
+	mr	r4,r5
+	mr	r5,r6
+	mr	r6,r7
+	mr	r7,r8
+	mr	r8,r9
+
+	HVSC				/* invoke the hypervisor */
+
+	HCALL_INST_POSTCALL
+
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
+
+/* Note: takes 8 input parameters at maximum */
+_GLOBAL(beat_hcall_norets8)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	HCALL_INST_PRECALL
+
+	mr	r11,r3
+	mr	r3,r4
+	mr	r4,r5
+	mr	r5,r6
+	mr	r6,r7
+	mr	r7,r8
+	mr	r8,r9
+	ld	r10,STK_PARM(r10)(r1)
+
+	HVSC				/* invoke the hypervisor */
+
+	HCALL_INST_POSTCALL
+
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
+
+/* Note: takes only 6 input parameters, 1 output parameters at maximum */
+_GLOBAL(beat_hcall1)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	HCALL_INST_PRECALL
+
+	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+
+	mr	r11,r3
+	mr	r3,r5
+	mr	r4,r6
+	mr	r5,r7
+	mr	r6,r8
+	mr	r7,r9
+	mr	r8,r10
+
+	HVSC				/* invoke the hypervisor */
+
+	HCALL_INST_POSTCALL
+
+	ld	r12,STK_PARM(r4)(r1)
+	std	r4,  0(r12)
+
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
+
+/* Note: takes only 6 input parameters, 2 output parameters at maximum */
+_GLOBAL(beat_hcall2)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	HCALL_INST_PRECALL
+
+	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+
+	mr	r11,r3
+	mr	r3,r5
+	mr	r4,r6
+	mr	r5,r7
+	mr	r6,r8
+	mr	r7,r9
+	mr	r8,r10
+
+	HVSC				/* invoke the hypervisor */
+
+	HCALL_INST_POSTCALL
+
+	ld	r12,STK_PARM(r4)(r1)
+	std	r4,  0(r12)
+	std	r5,  8(r12)
+
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
+
+/* Note: takes only 6 input parameters, 3 output parameters at maximum */
+_GLOBAL(beat_hcall3)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	HCALL_INST_PRECALL
+
+	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+
+	mr	r11,r3
+	mr	r3,r5
+	mr	r4,r6
+	mr	r5,r7
+	mr	r6,r8
+	mr	r7,r9
+	mr	r8,r10
+
+	HVSC				/* invoke the hypervisor */
+
+	HCALL_INST_POSTCALL
+
+	ld	r12,STK_PARM(r4)(r1)
+	std	r4,  0(r12)
+	std	r5,  8(r12)
+	std	r6, 16(r12)
+
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
+
+/* Note: takes only 6 input parameters, 4 output parameters at maximum */
+_GLOBAL(beat_hcall4)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	HCALL_INST_PRECALL
+
+	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+
+	mr	r11,r3
+	mr	r3,r5
+	mr	r4,r6
+	mr	r5,r7
+	mr	r6,r8
+	mr	r7,r9
+	mr	r8,r10
+
+	HVSC				/* invoke the hypervisor */
+
+	HCALL_INST_POSTCALL
+
+	ld	r12,STK_PARM(r4)(r1)
+	std	r4,  0(r12)
+	std	r5,  8(r12)
+	std	r6, 16(r12)
+	std	r7, 24(r12)
+
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
+
+/* Note: takes only 6 input parameters, 5 output parameters at maximum */
+_GLOBAL(beat_hcall5)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	HCALL_INST_PRECALL
+
+	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+
+	mr	r11,r3
+	mr	r3,r5
+	mr	r4,r6
+	mr	r5,r7
+	mr	r6,r8
+	mr	r7,r9
+	mr	r8,r10
+
+	HVSC				/* invoke the hypervisor */
+
+	HCALL_INST_POSTCALL
+
+	ld	r12,STK_PARM(r4)(r1)
+	std	r4,  0(r12)
+	std	r5,  8(r12)
+	std	r6, 16(r12)
+	std	r7, 24(r12)
+	std	r8, 32(r12)
+
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
+
+/* Note: takes only 6 input parameters, 6 output parameters at maximum */
+_GLOBAL(beat_hcall6)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	HCALL_INST_PRECALL
+
+	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+
+	mr	r11,r3
+	mr	r3,r5
+	mr	r4,r6
+	mr	r5,r7
+	mr	r6,r8
+	mr	r7,r9
+	mr	r8,r10
+
+	HVSC				/* invoke the hypervisor */
+
+	HCALL_INST_POSTCALL
+
+	ld	r12,STK_PARM(r4)(r1)
+	std	r4,  0(r12)
+	std	r5,  8(r12)
+	std	r6, 16(r12)
+	std	r7, 24(r12)
+	std	r8, 32(r12)
+	std	r9, 40(r12)
+
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
Index: b/arch/powerpc/platforms/cell/beat_syscall.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/beat_syscall.h	2008-04-23 21:38:14.000000000 +0900
@@ -0,0 +1,164 @@
+/*
+ * Beat hypervisor call numbers
+ *
+ * (C) Copyright 2004-2007 TOSHIBA CORPORATION
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
+#else
+#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((u64)(__v)<<60|(__x))
+#endif
+#define HV_allocate_memory __BEAT_ADD_VENDOR_ID(0, 0)
+#define HV_construct_virtual_address_space __BEAT_ADD_VENDOR_ID(2, 0)
+#define HV_destruct_virtual_address_space __BEAT_ADD_VENDOR_ID(10, 0)
+#define HV_get_virtual_address_space_id_of_ppe __BEAT_ADD_VENDOR_ID(4, 0)
+#define HV_query_logical_partition_address_region_info 			\
+						__BEAT_ADD_VENDOR_ID(6, 0)
+#define HV_release_memory __BEAT_ADD_VENDOR_ID(13, 0)
+#define HV_select_virtual_address_space __BEAT_ADD_VENDOR_ID(7, 0)
+#define HV_load_range_registers __BEAT_ADD_VENDOR_ID(68, 0)
+#define HV_set_ppe_l2cache_rmt_entry __BEAT_ADD_VENDOR_ID(70, 0)
+#define HV_set_ppe_tlb_rmt_entry __BEAT_ADD_VENDOR_ID(71, 0)
+#define HV_set_spe_tlb_rmt_entry __BEAT_ADD_VENDOR_ID(72, 0)
+#define HV_get_io_address_translation_fault_info __BEAT_ADD_VENDOR_ID(14, 0)
+#define HV_get_iopte __BEAT_ADD_VENDOR_ID(16, 0)
+#define HV_preload_iopt_cache __BEAT_ADD_VENDOR_ID(17, 0)
+#define HV_put_iopte __BEAT_ADD_VENDOR_ID(15, 0)
+#define HV_connect_event_ports __BEAT_ADD_VENDOR_ID(21, 0)
+#define HV_construct_event_receive_port __BEAT_ADD_VENDOR_ID(18, 0)
+#define HV_destruct_event_receive_port __BEAT_ADD_VENDOR_ID(19, 0)
+#define HV_destruct_event_send_port __BEAT_ADD_VENDOR_ID(22, 0)
+#define HV_get_state_of_event_send_port __BEAT_ADD_VENDOR_ID(25, 0)
+#define HV_request_to_connect_event_ports __BEAT_ADD_VENDOR_ID(20, 0)
+#define HV_send_event_externally __BEAT_ADD_VENDOR_ID(23, 0)
+#define HV_send_event_locally __BEAT_ADD_VENDOR_ID(24, 0)
+#define HV_construct_and_connect_irq_plug __BEAT_ADD_VENDOR_ID(28, 0)
+#define HV_destruct_irq_plug __BEAT_ADD_VENDOR_ID(29, 0)
+#define HV_detect_pending_interrupts __BEAT_ADD_VENDOR_ID(26, 0)
+#define HV_end_of_interrupt __BEAT_ADD_VENDOR_ID(27, 0)
+#define HV_assign_control_signal_notification_port __BEAT_ADD_VENDOR_ID(45, 0)
+#define HV_end_of_control_signal_processing __BEAT_ADD_VENDOR_ID(48, 0)
+#define HV_get_control_signal __BEAT_ADD_VENDOR_ID(46, 0)
+#define HV_set_irq_mask_for_spe __BEAT_ADD_VENDOR_ID(61, 0)
+#define HV_shutdown_logical_partition __BEAT_ADD_VENDOR_ID(44, 0)
+#define HV_connect_message_ports __BEAT_ADD_VENDOR_ID(35, 0)
+#define HV_destruct_message_port __BEAT_ADD_VENDOR_ID(36, 0)
+#define HV_receive_message __BEAT_ADD_VENDOR_ID(37, 0)
+#define HV_get_message_port_info __BEAT_ADD_VENDOR_ID(34, 0)
+#define HV_request_to_connect_message_ports __BEAT_ADD_VENDOR_ID(33, 0)
+#define HV_send_message __BEAT_ADD_VENDOR_ID(32, 0)
+#define HV_get_logical_ppe_id __BEAT_ADD_VENDOR_ID(69, 0)
+#define HV_pause __BEAT_ADD_VENDOR_ID(9, 0)
+#define HV_destruct_shared_memory_handle __BEAT_ADD_VENDOR_ID(51, 0)
+#define HV_get_shared_memory_info __BEAT_ADD_VENDOR_ID(52, 0)
+#define HV_permit_sharing_memory __BEAT_ADD_VENDOR_ID(50, 0)
+#define HV_request_to_attach_shared_memory __BEAT_ADD_VENDOR_ID(49, 0)
+#define HV_enable_logical_spe_execution __BEAT_ADD_VENDOR_ID(55, 0)
+#define HV_construct_logical_spe __BEAT_ADD_VENDOR_ID(53, 0)
+#define HV_disable_logical_spe_execution __BEAT_ADD_VENDOR_ID(56, 0)
+#define HV_destruct_logical_spe __BEAT_ADD_VENDOR_ID(54, 0)
+#define HV_sense_spe_execution_status __BEAT_ADD_VENDOR_ID(58, 0)
+#define HV_insert_htab_entry __BEAT_ADD_VENDOR_ID(101, 0)
+#define HV_read_htab_entries __BEAT_ADD_VENDOR_ID(95, 0)
+#define HV_write_htab_entry __BEAT_ADD_VENDOR_ID(94, 0)
+#define HV_assign_io_address_translation_fault_port 			\
+						__BEAT_ADD_VENDOR_ID(100, 0)
+#define HV_set_interrupt_mask __BEAT_ADD_VENDOR_ID(73, 0)
+#define HV_get_logical_partition_id __BEAT_ADD_VENDOR_ID(74, 0)
+#define HV_create_repository_node2 __BEAT_ADD_VENDOR_ID(90, 0)
+#define HV_create_repository_node __BEAT_ADD_VENDOR_ID(90, 0) /* alias */
+#define HV_get_repository_node_value2 __BEAT_ADD_VENDOR_ID(91, 0)
+#define HV_get_repository_node_value __BEAT_ADD_VENDOR_ID(91, 0) /* alias */
+#define HV_modify_repository_node_value2 __BEAT_ADD_VENDOR_ID(92, 0)
+#define HV_modify_repository_node_value __BEAT_ADD_VENDOR_ID(92, 0) /* alias */
+#define HV_remove_repository_node2 __BEAT_ADD_VENDOR_ID(93, 0)
+#define HV_remove_repository_node __BEAT_ADD_VENDOR_ID(93, 0) /* alias */
+#define HV_cancel_shared_memory __BEAT_ADD_VENDOR_ID(104, 0)
+#define HV_clear_interrupt_status_of_spe __BEAT_ADD_VENDOR_ID(206, 0)
+#define HV_construct_spe_irq_outlet __BEAT_ADD_VENDOR_ID(80, 0)
+#define HV_destruct_spe_irq_outlet __BEAT_ADD_VENDOR_ID(81, 0)
+#define HV_disconnect_ipspc_service __BEAT_ADD_VENDOR_ID(88, 0)
+#define HV_execute_ipspc_command __BEAT_ADD_VENDOR_ID(86, 0)
+#define HV_get_interrupt_status_of_spe __BEAT_ADD_VENDOR_ID(205, 0)
+#define HV_get_spe_privileged_state_1_registers __BEAT_ADD_VENDOR_ID(208, 0)
+#define HV_permit_use_of_ipspc_service __BEAT_ADD_VENDOR_ID(85, 0)
+#define HV_reinitialize_logical_spe __BEAT_ADD_VENDOR_ID(82, 0)
+#define HV_request_ipspc_service __BEAT_ADD_VENDOR_ID(84, 0)
+#define HV_stop_ipspc_command __BEAT_ADD_VENDOR_ID(87, 0)
+#define HV_set_spe_privileged_state_1_registers __BEAT_ADD_VENDOR_ID(204, 0)
+#define HV_get_status_of_ipspc_service __BEAT_ADD_VENDOR_ID(203, 0)
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
+#define HV_assign_ipspc_server_connection_status_notification_port 	\
+						__BEAT_ADD_VENDOR_ID(0x173, 1)
+#define HV_get_raid_of_physical_spe __BEAT_ADD_VENDOR_ID(0x174, 1)
+#define HV_set_physical_spe_to_rag __BEAT_ADD_VENDOR_ID(0x175, 1)
+#define HV_release_physical_spe_from_rag __BEAT_ADD_VENDOR_ID(0x176, 1)
+#define HV_rtc_read __BEAT_ADD_VENDOR_ID(0x190, 1)
+#define HV_rtc_write __BEAT_ADD_VENDOR_ID(0x191, 1)
+#define HV_eeprom_read __BEAT_ADD_VENDOR_ID(0x192, 1)
+#define HV_eeprom_write __BEAT_ADD_VENDOR_ID(0x193, 1)
+#define HV_insert_htab_entry3 __BEAT_ADD_VENDOR_ID(0x104, 1)
+#define HV_invalidate_htab_entry3 __BEAT_ADD_VENDOR_ID(0x105, 1)
+#define HV_update_htab_permission3 __BEAT_ADD_VENDOR_ID(0x106, 1)
+#define HV_clear_htab3 __BEAT_ADD_VENDOR_ID(0x107, 1)
+#endif
Index: b/arch/powerpc/platforms/cell/beat_wrapper.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/beat_wrapper.h	2008-04-23 21:38:14.000000000 +0900
@@ -0,0 +1,289 @@
+/*
+ * Beat hypervisor call I/F
+ *
+ * (C) Copyright 2007 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/pseries/plpar_wrapper.h.
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
+#ifndef BEAT_HCALL
+#include "beat_syscall.h"
+
+/* defined in hvCall.S */
+extern s64 beat_hcall_norets(u64 opcode, ...);
+extern s64 beat_hcall_norets8(u64 opcode, u64 arg1, u64 arg2, u64 arg3,
+	u64 arg4, u64 arg5, u64 arg6, u64 arg7, u64 arg8);
+extern s64 beat_hcall1(u64 opcode, u64 retbuf[1], ...);
+extern s64 beat_hcall2(u64 opcode, u64 retbuf[2], ...);
+extern s64 beat_hcall3(u64 opcode, u64 retbuf[3], ...);
+extern s64 beat_hcall4(u64 opcode, u64 retbuf[4], ...);
+extern s64 beat_hcall5(u64 opcode, u64 retbuf[5], ...);
+extern s64 beat_hcall6(u64 opcode, u64 retbuf[6], ...);
+
+static inline s64 beat_downcount_of_interrupt(u64 plug_id)
+{
+	return beat_hcall_norets(HV_downcount_of_interrupt, plug_id);
+}
+
+static inline s64 beat_set_interrupt_mask(u64 index,
+	u64 val0, u64 val1, u64 val2, u64 val3)
+{
+	return beat_hcall_norets(HV_set_interrupt_mask, index,
+	       val0, val1, val2, val3);
+}
+
+static inline s64 beat_destruct_irq_plug(u64 plug_id)
+{
+	return beat_hcall_norets(HV_destruct_irq_plug, plug_id);
+}
+
+static inline s64 beat_construct_and_connect_irq_plug(u64 plug_id,
+	u64 outlet_id)
+{
+	return beat_hcall_norets(HV_construct_and_connect_irq_plug, plug_id,
+	       outlet_id);
+}
+
+static inline s64 beat_detect_pending_interrupts(u64 index, u64 *retbuf)
+{
+	return beat_hcall4(HV_detect_pending_interrupts, retbuf, index);
+}
+
+static inline s64 beat_pause(u64 style)
+{
+	return beat_hcall_norets(HV_pause, style);
+}
+
+static inline s64 beat_read_htab_entries(u64 htab_id, u64 index, u64 *retbuf)
+{
+	return beat_hcall5(HV_read_htab_entries, retbuf, htab_id, index);
+}
+
+static inline s64 beat_insert_htab_entry(u64 htab_id, u64 group,
+	u64 bitmask, u64 hpte_v, u64 hpte_r, u64 *slot)
+{
+	u64 dummy[3];
+	s64 ret;
+
+	ret = beat_hcall3(HV_insert_htab_entry, dummy, htab_id, group,
+		bitmask, hpte_v, hpte_r);
+	*slot = dummy[0];
+	return ret;
+}
+
+static inline s64 beat_write_htab_entry(u64 htab_id, u64 slot,
+	u64 hpte_v, u64 hpte_r, u64 mask_v, u64 mask_r,
+	u64 *ret_v, u64 *ret_r)
+{
+	u64 dummy[2];
+	s64 ret;
+
+	ret = beat_hcall2(HV_write_htab_entry, dummy, htab_id, slot,
+		hpte_v, hpte_r, mask_v, mask_r);
+	*ret_v = dummy[0];
+	*ret_r = dummy[1];
+	return ret;
+}
+
+static inline s64 beat_insert_htab_entry3(u64 htab_id, u64 group,
+	u64 hpte_v, u64 hpte_r, u64 mask_v, u64 value_v, u64 *slot)
+{
+	u64 dummy[1];
+	s64 ret;
+
+	ret = beat_hcall1(HV_insert_htab_entry3, dummy, htab_id, group,
+		hpte_v, hpte_r, mask_v, value_v);
+	*slot = dummy[0];
+	return ret;
+}
+
+static inline s64 beat_invalidate_htab_entry3(u64 htab_id, u64 group,
+	u64 va, u64 pss)
+{
+	return beat_hcall_norets(HV_invalidate_htab_entry3,
+		htab_id, group, va, pss);
+}
+
+static inline s64 beat_update_htab_permission3(u64 htab_id, u64 group,
+	u64 va, u64 pss, u64 ptel_mask, u64 ptel_value)
+{
+	return beat_hcall_norets(HV_update_htab_permission3,
+		htab_id, group, va, pss, ptel_mask, ptel_value);
+}
+
+static inline s64 beat_clear_htab3(u64 htab_id)
+{
+	return beat_hcall_norets(HV_clear_htab3, htab_id);
+}
+
+static inline void beat_shutdown_logical_partition(u64 code)
+{
+	(void)beat_hcall_norets(HV_shutdown_logical_partition, code);
+}
+
+static inline s64 beat_rtc_write(u64 time_from_epoch)
+{
+	return beat_hcall_norets(HV_rtc_write, time_from_epoch);
+}
+
+static inline s64 beat_rtc_read(u64 *time_from_epoch)
+{
+	u64 dummy[1];
+	s64 ret;
+
+	ret = beat_hcall1(HV_rtc_read, dummy);
+	*time_from_epoch = dummy[0];
+	return ret;
+}
+
+#define	BEAT_NVRW_CNT	(sizeof(u64) * 6)
+
+static inline s64 beat_eeprom_write(u64 index, u64 length, u8 *buffer)
+{
+	u64	b[6];
+
+	if (length > BEAT_NVRW_CNT)
+		return -1;
+	memcpy(b, buffer, sizeof(b));
+	return beat_hcall_norets8(HV_eeprom_write, index, length,
+		b[0], b[1], b[2], b[3], b[4], b[5]);
+}
+
+static inline s64 beat_eeprom_read(u64 index, u64 length, u8 *buffer)
+{
+	u64	b[6];
+	s64	ret;
+
+	if (length > BEAT_NVRW_CNT)
+		return -1;
+	ret = beat_hcall6(HV_eeprom_read, b, index, length);
+	memcpy(buffer, b, length);
+	return ret;
+}
+
+static inline s64 beat_set_dabr(u64 value, u64 style)
+{
+	return beat_hcall_norets(HV_set_dabr, value, style);
+}
+
+static inline s64 beat_get_characters_from_console(u64 termno, u64 *len,
+	u8 *buffer)
+{
+	u64 dummy[3];
+	s64 ret;
+
+	ret = beat_hcall3(HV_get_characters_from_console, dummy, termno, len);
+	*len = dummy[0];
+	memcpy(buffer, dummy + 1, *len);
+	return ret;
+}
+
+static inline s64 beat_put_characters_to_console(u64 termno, u64 len,
+	u8 *buffer)
+{
+	u64 b[2];
+
+	memcpy(b, buffer, len);
+	return beat_hcall_norets(HV_put_characters_to_console, termno, len,
+		b[0], b[1]);
+}
+
+static inline s64 beat_get_spe_privileged_state_1_registers(
+		u64 id, u64 offsetof, u64 *value)
+{
+	u64 dummy[1];
+	s64 ret;
+
+	ret = beat_hcall1(HV_get_spe_privileged_state_1_registers, dummy, id,
+		offsetof);
+	*value = dummy[0];
+	return ret;
+}
+
+static inline s64 beat_set_irq_mask_for_spe(u64 id, u64 class, u64 mask)
+{
+	return beat_hcall_norets(HV_set_irq_mask_for_spe, id, class, mask);
+}
+
+static inline s64 beat_clear_interrupt_status_of_spe(u64 id, u64 class,
+	u64 mask)
+{
+	return beat_hcall_norets(HV_clear_interrupt_status_of_spe,
+		id, class, mask);
+}
+
+static inline s64 beat_set_spe_privileged_state_1_registers(
+		u64 id, u64 offsetof, u64 value)
+{
+	return beat_hcall_norets(HV_set_spe_privileged_state_1_registers,
+		id, offsetof, value);
+}
+
+static inline s64 beat_get_interrupt_status_of_spe(u64 id, u64 class, u64 *val)
+{
+	u64 dummy[1];
+	s64 ret;
+
+	ret = beat_hcall1(HV_get_interrupt_status_of_spe, dummy, id, class);
+	*val = dummy[0];
+	return ret;
+}
+
+static inline s64 beat_put_iopte(u64 ioas_id, u64 io_addr, u64 real_addr,
+	u64 ioid, u64 flags)
+{
+	return beat_hcall_norets(HV_put_iopte, ioas_id, io_addr, real_addr,
+		ioid, flags);
+}
+
+static inline s64 beat_construct_event_receive_port(u64 *port)
+{
+	u64 dummy[1];
+	s64 ret;
+
+	ret = beat_hcall1(HV_construct_event_receive_port, dummy);
+	*port = dummy[0];
+	return ret;
+}
+
+static inline s64 beat_destruct_event_receive_port(u64 port)
+{
+	s64 ret;
+
+	ret = beat_hcall_norets(HV_destruct_event_receive_port, port);
+	return ret;
+}
+
+static inline s64 beat_create_repository_node(u64 path[4], u64 data[2])
+{
+	s64 ret;
+
+	ret = beat_hcall_norets(HV_create_repository_node2,
+		path[0], path[1], path[2], path[3], data[0], data[1]);
+	return ret;
+}
+
+static inline s64 beat_get_repository_node_value(u64 lpid, u64 path[4],
+	u64 data[2])
+{
+	s64 ret;
+
+	ret = beat_hcall2(HV_get_repository_node_value2, data,
+		lpid, path[0], path[1], path[2], path[3]);
+	return ret;
+}
+
+#endif
Index: b/arch/powerpc/platforms/celleb/beat_syscall.h
===================================================================
--- a/arch/powerpc/platforms/celleb/beat_syscall.h	2008-04-23 21:10:12.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,164 +0,0 @@
-/*
- * Beat hypervisor call numbers
- *
- * (C) Copyright 2004-2007 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef BEAT_BEAT_syscall_H
-#define BEAT_BEAT_syscall_H
-
-#ifdef	__ASSEMBLY__
-#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((__v)<<60|(__x))
-#else
-#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((u64)(__v)<<60|(__x))
-#endif
-#define HV_allocate_memory __BEAT_ADD_VENDOR_ID(0, 0)
-#define HV_construct_virtual_address_space __BEAT_ADD_VENDOR_ID(2, 0)
-#define HV_destruct_virtual_address_space __BEAT_ADD_VENDOR_ID(10, 0)
-#define HV_get_virtual_address_space_id_of_ppe __BEAT_ADD_VENDOR_ID(4, 0)
-#define HV_query_logical_partition_address_region_info 			\
-						__BEAT_ADD_VENDOR_ID(6, 0)
-#define HV_release_memory __BEAT_ADD_VENDOR_ID(13, 0)
-#define HV_select_virtual_address_space __BEAT_ADD_VENDOR_ID(7, 0)
-#define HV_load_range_registers __BEAT_ADD_VENDOR_ID(68, 0)
-#define HV_set_ppe_l2cache_rmt_entry __BEAT_ADD_VENDOR_ID(70, 0)
-#define HV_set_ppe_tlb_rmt_entry __BEAT_ADD_VENDOR_ID(71, 0)
-#define HV_set_spe_tlb_rmt_entry __BEAT_ADD_VENDOR_ID(72, 0)
-#define HV_get_io_address_translation_fault_info __BEAT_ADD_VENDOR_ID(14, 0)
-#define HV_get_iopte __BEAT_ADD_VENDOR_ID(16, 0)
-#define HV_preload_iopt_cache __BEAT_ADD_VENDOR_ID(17, 0)
-#define HV_put_iopte __BEAT_ADD_VENDOR_ID(15, 0)
-#define HV_connect_event_ports __BEAT_ADD_VENDOR_ID(21, 0)
-#define HV_construct_event_receive_port __BEAT_ADD_VENDOR_ID(18, 0)
-#define HV_destruct_event_receive_port __BEAT_ADD_VENDOR_ID(19, 0)
-#define HV_destruct_event_send_port __BEAT_ADD_VENDOR_ID(22, 0)
-#define HV_get_state_of_event_send_port __BEAT_ADD_VENDOR_ID(25, 0)
-#define HV_request_to_connect_event_ports __BEAT_ADD_VENDOR_ID(20, 0)
-#define HV_send_event_externally __BEAT_ADD_VENDOR_ID(23, 0)
-#define HV_send_event_locally __BEAT_ADD_VENDOR_ID(24, 0)
-#define HV_construct_and_connect_irq_plug __BEAT_ADD_VENDOR_ID(28, 0)
-#define HV_destruct_irq_plug __BEAT_ADD_VENDOR_ID(29, 0)
-#define HV_detect_pending_interrupts __BEAT_ADD_VENDOR_ID(26, 0)
-#define HV_end_of_interrupt __BEAT_ADD_VENDOR_ID(27, 0)
-#define HV_assign_control_signal_notification_port __BEAT_ADD_VENDOR_ID(45, 0)
-#define HV_end_of_control_signal_processing __BEAT_ADD_VENDOR_ID(48, 0)
-#define HV_get_control_signal __BEAT_ADD_VENDOR_ID(46, 0)
-#define HV_set_irq_mask_for_spe __BEAT_ADD_VENDOR_ID(61, 0)
-#define HV_shutdown_logical_partition __BEAT_ADD_VENDOR_ID(44, 0)
-#define HV_connect_message_ports __BEAT_ADD_VENDOR_ID(35, 0)
-#define HV_destruct_message_port __BEAT_ADD_VENDOR_ID(36, 0)
-#define HV_receive_message __BEAT_ADD_VENDOR_ID(37, 0)
-#define HV_get_message_port_info __BEAT_ADD_VENDOR_ID(34, 0)
-#define HV_request_to_connect_message_ports __BEAT_ADD_VENDOR_ID(33, 0)
-#define HV_send_message __BEAT_ADD_VENDOR_ID(32, 0)
-#define HV_get_logical_ppe_id __BEAT_ADD_VENDOR_ID(69, 0)
-#define HV_pause __BEAT_ADD_VENDOR_ID(9, 0)
-#define HV_destruct_shared_memory_handle __BEAT_ADD_VENDOR_ID(51, 0)
-#define HV_get_shared_memory_info __BEAT_ADD_VENDOR_ID(52, 0)
-#define HV_permit_sharing_memory __BEAT_ADD_VENDOR_ID(50, 0)
-#define HV_request_to_attach_shared_memory __BEAT_ADD_VENDOR_ID(49, 0)
-#define HV_enable_logical_spe_execution __BEAT_ADD_VENDOR_ID(55, 0)
-#define HV_construct_logical_spe __BEAT_ADD_VENDOR_ID(53, 0)
-#define HV_disable_logical_spe_execution __BEAT_ADD_VENDOR_ID(56, 0)
-#define HV_destruct_logical_spe __BEAT_ADD_VENDOR_ID(54, 0)
-#define HV_sense_spe_execution_status __BEAT_ADD_VENDOR_ID(58, 0)
-#define HV_insert_htab_entry __BEAT_ADD_VENDOR_ID(101, 0)
-#define HV_read_htab_entries __BEAT_ADD_VENDOR_ID(95, 0)
-#define HV_write_htab_entry __BEAT_ADD_VENDOR_ID(94, 0)
-#define HV_assign_io_address_translation_fault_port 			\
-						__BEAT_ADD_VENDOR_ID(100, 0)
-#define HV_set_interrupt_mask __BEAT_ADD_VENDOR_ID(73, 0)
-#define HV_get_logical_partition_id __BEAT_ADD_VENDOR_ID(74, 0)
-#define HV_create_repository_node2 __BEAT_ADD_VENDOR_ID(90, 0)
-#define HV_create_repository_node __BEAT_ADD_VENDOR_ID(90, 0) /* alias */
-#define HV_get_repository_node_value2 __BEAT_ADD_VENDOR_ID(91, 0)
-#define HV_get_repository_node_value __BEAT_ADD_VENDOR_ID(91, 0) /* alias */
-#define HV_modify_repository_node_value2 __BEAT_ADD_VENDOR_ID(92, 0)
-#define HV_modify_repository_node_value __BEAT_ADD_VENDOR_ID(92, 0) /* alias */
-#define HV_remove_repository_node2 __BEAT_ADD_VENDOR_ID(93, 0)
-#define HV_remove_repository_node __BEAT_ADD_VENDOR_ID(93, 0) /* alias */
-#define HV_cancel_shared_memory __BEAT_ADD_VENDOR_ID(104, 0)
-#define HV_clear_interrupt_status_of_spe __BEAT_ADD_VENDOR_ID(206, 0)
-#define HV_construct_spe_irq_outlet __BEAT_ADD_VENDOR_ID(80, 0)
-#define HV_destruct_spe_irq_outlet __BEAT_ADD_VENDOR_ID(81, 0)
-#define HV_disconnect_ipspc_service __BEAT_ADD_VENDOR_ID(88, 0)
-#define HV_execute_ipspc_command __BEAT_ADD_VENDOR_ID(86, 0)
-#define HV_get_interrupt_status_of_spe __BEAT_ADD_VENDOR_ID(205, 0)
-#define HV_get_spe_privileged_state_1_registers __BEAT_ADD_VENDOR_ID(208, 0)
-#define HV_permit_use_of_ipspc_service __BEAT_ADD_VENDOR_ID(85, 0)
-#define HV_reinitialize_logical_spe __BEAT_ADD_VENDOR_ID(82, 0)
-#define HV_request_ipspc_service __BEAT_ADD_VENDOR_ID(84, 0)
-#define HV_stop_ipspc_command __BEAT_ADD_VENDOR_ID(87, 0)
-#define HV_set_spe_privileged_state_1_registers __BEAT_ADD_VENDOR_ID(204, 0)
-#define HV_get_status_of_ipspc_service __BEAT_ADD_VENDOR_ID(203, 0)
-#define HV_put_characters_to_console __BEAT_ADD_VENDOR_ID(0x101, 1)
-#define HV_get_characters_from_console __BEAT_ADD_VENDOR_ID(0x102, 1)
-#define HV_get_base_clock __BEAT_ADD_VENDOR_ID(0x111, 1)
-#define HV_set_base_clock __BEAT_ADD_VENDOR_ID(0x112, 1)
-#define HV_get_frame_cycle __BEAT_ADD_VENDOR_ID(0x114, 1)
-#define HV_disable_console __BEAT_ADD_VENDOR_ID(0x115, 1)
-#define HV_disable_all_console __BEAT_ADD_VENDOR_ID(0x116, 1)
-#define HV_oneshot_timer __BEAT_ADD_VENDOR_ID(0x117, 1)
-#define HV_set_dabr __BEAT_ADD_VENDOR_ID(0x118, 1)
-#define HV_get_dabr __BEAT_ADD_VENDOR_ID(0x119, 1)
-#define HV_start_hv_stats __BEAT_ADD_VENDOR_ID(0x21c, 1)
-#define HV_stop_hv_stats __BEAT_ADD_VENDOR_ID(0x21d, 1)
-#define HV_get_hv_stats __BEAT_ADD_VENDOR_ID(0x21e, 1)
-#define HV_get_hv_error_stats __BEAT_ADD_VENDOR_ID(0x221, 1)
-#define HV_get_stats __BEAT_ADD_VENDOR_ID(0x224, 1)
-#define HV_get_heap_stats __BEAT_ADD_VENDOR_ID(0x225, 1)
-#define HV_get_memory_stats __BEAT_ADD_VENDOR_ID(0x227, 1)
-#define HV_get_memory_detail __BEAT_ADD_VENDOR_ID(0x228, 1)
-#define HV_set_priority_of_irq_outlet __BEAT_ADD_VENDOR_ID(0x122, 1)
-#define HV_get_physical_spe_by_reservation_id __BEAT_ADD_VENDOR_ID(0x128, 1)
-#define HV_get_spe_context __BEAT_ADD_VENDOR_ID(0x129, 1)
-#define HV_set_spe_context __BEAT_ADD_VENDOR_ID(0x12a, 1)
-#define HV_downcount_of_interrupt __BEAT_ADD_VENDOR_ID(0x12e, 1)
-#define HV_peek_spe_context __BEAT_ADD_VENDOR_ID(0x12f, 1)
-#define HV_read_bpa_register __BEAT_ADD_VENDOR_ID(0x131, 1)
-#define HV_write_bpa_register __BEAT_ADD_VENDOR_ID(0x132, 1)
-#define HV_map_context_table_of_spe __BEAT_ADD_VENDOR_ID(0x137, 1)
-#define HV_get_slb_for_logical_spe __BEAT_ADD_VENDOR_ID(0x138, 1)
-#define HV_set_slb_for_logical_spe __BEAT_ADD_VENDOR_ID(0x139, 1)
-#define HV_init_pm __BEAT_ADD_VENDOR_ID(0x150, 1)
-#define HV_set_pm_signal __BEAT_ADD_VENDOR_ID(0x151, 1)
-#define HV_get_pm_signal __BEAT_ADD_VENDOR_ID(0x152, 1)
-#define HV_set_pm_config __BEAT_ADD_VENDOR_ID(0x153, 1)
-#define HV_get_pm_config __BEAT_ADD_VENDOR_ID(0x154, 1)
-#define HV_get_inner_trace_data __BEAT_ADD_VENDOR_ID(0x155, 1)
-#define HV_set_ext_trace_buffer __BEAT_ADD_VENDOR_ID(0x156, 1)
-#define HV_get_ext_trace_buffer __BEAT_ADD_VENDOR_ID(0x157, 1)
-#define HV_set_pm_interrupt __BEAT_ADD_VENDOR_ID(0x158, 1)
-#define HV_get_pm_interrupt __BEAT_ADD_VENDOR_ID(0x159, 1)
-#define HV_kick_pm __BEAT_ADD_VENDOR_ID(0x160, 1)
-#define HV_construct_pm_context __BEAT_ADD_VENDOR_ID(0x164, 1)
-#define HV_destruct_pm_context __BEAT_ADD_VENDOR_ID(0x165, 1)
-#define HV_be_slow __BEAT_ADD_VENDOR_ID(0x170, 1)
-#define HV_assign_ipspc_server_connection_status_notification_port 	\
-						__BEAT_ADD_VENDOR_ID(0x173, 1)
-#define HV_get_raid_of_physical_spe __BEAT_ADD_VENDOR_ID(0x174, 1)
-#define HV_set_physical_spe_to_rag __BEAT_ADD_VENDOR_ID(0x175, 1)
-#define HV_release_physical_spe_from_rag __BEAT_ADD_VENDOR_ID(0x176, 1)
-#define HV_rtc_read __BEAT_ADD_VENDOR_ID(0x190, 1)
-#define HV_rtc_write __BEAT_ADD_VENDOR_ID(0x191, 1)
-#define HV_eeprom_read __BEAT_ADD_VENDOR_ID(0x192, 1)
-#define HV_eeprom_write __BEAT_ADD_VENDOR_ID(0x193, 1)
-#define HV_insert_htab_entry3 __BEAT_ADD_VENDOR_ID(0x104, 1)
-#define HV_invalidate_htab_entry3 __BEAT_ADD_VENDOR_ID(0x105, 1)
-#define HV_update_htab_permission3 __BEAT_ADD_VENDOR_ID(0x106, 1)
-#define HV_clear_htab3 __BEAT_ADD_VENDOR_ID(0x107, 1)
-#endif
Index: b/arch/powerpc/platforms/celleb/beat_wrapper.h
===================================================================
--- a/arch/powerpc/platforms/celleb/beat_wrapper.h	2008-04-23 21:10:12.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,289 +0,0 @@
-/*
- * Beat hypervisor call I/F
- *
- * (C) Copyright 2007 TOSHIBA CORPORATION
- *
- * This code is based on arch/powerpc/platforms/pseries/plpar_wrapper.h.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-#ifndef BEAT_HCALL
-#include "beat_syscall.h"
-
-/* defined in hvCall.S */
-extern s64 beat_hcall_norets(u64 opcode, ...);
-extern s64 beat_hcall_norets8(u64 opcode, u64 arg1, u64 arg2, u64 arg3,
-	u64 arg4, u64 arg5, u64 arg6, u64 arg7, u64 arg8);
-extern s64 beat_hcall1(u64 opcode, u64 retbuf[1], ...);
-extern s64 beat_hcall2(u64 opcode, u64 retbuf[2], ...);
-extern s64 beat_hcall3(u64 opcode, u64 retbuf[3], ...);
-extern s64 beat_hcall4(u64 opcode, u64 retbuf[4], ...);
-extern s64 beat_hcall5(u64 opcode, u64 retbuf[5], ...);
-extern s64 beat_hcall6(u64 opcode, u64 retbuf[6], ...);
-
-static inline s64 beat_downcount_of_interrupt(u64 plug_id)
-{
-	return beat_hcall_norets(HV_downcount_of_interrupt, plug_id);
-}
-
-static inline s64 beat_set_interrupt_mask(u64 index,
-	u64 val0, u64 val1, u64 val2, u64 val3)
-{
-	return beat_hcall_norets(HV_set_interrupt_mask, index,
-	       val0, val1, val2, val3);
-}
-
-static inline s64 beat_destruct_irq_plug(u64 plug_id)
-{
-	return beat_hcall_norets(HV_destruct_irq_plug, plug_id);
-}
-
-static inline s64 beat_construct_and_connect_irq_plug(u64 plug_id,
-	u64 outlet_id)
-{
-	return beat_hcall_norets(HV_construct_and_connect_irq_plug, plug_id,
-	       outlet_id);
-}
-
-static inline s64 beat_detect_pending_interrupts(u64 index, u64 *retbuf)
-{
-	return beat_hcall4(HV_detect_pending_interrupts, retbuf, index);
-}
-
-static inline s64 beat_pause(u64 style)
-{
-	return beat_hcall_norets(HV_pause, style);
-}
-
-static inline s64 beat_read_htab_entries(u64 htab_id, u64 index, u64 *retbuf)
-{
-	return beat_hcall5(HV_read_htab_entries, retbuf, htab_id, index);
-}
-
-static inline s64 beat_insert_htab_entry(u64 htab_id, u64 group,
-	u64 bitmask, u64 hpte_v, u64 hpte_r, u64 *slot)
-{
-	u64 dummy[3];
-	s64 ret;
-
-	ret = beat_hcall3(HV_insert_htab_entry, dummy, htab_id, group,
-		bitmask, hpte_v, hpte_r);
-	*slot = dummy[0];
-	return ret;
-}
-
-static inline s64 beat_write_htab_entry(u64 htab_id, u64 slot,
-	u64 hpte_v, u64 hpte_r, u64 mask_v, u64 mask_r,
-	u64 *ret_v, u64 *ret_r)
-{
-	u64 dummy[2];
-	s64 ret;
-
-	ret = beat_hcall2(HV_write_htab_entry, dummy, htab_id, slot,
-		hpte_v, hpte_r, mask_v, mask_r);
-	*ret_v = dummy[0];
-	*ret_r = dummy[1];
-	return ret;
-}
-
-static inline s64 beat_insert_htab_entry3(u64 htab_id, u64 group,
-	u64 hpte_v, u64 hpte_r, u64 mask_v, u64 value_v, u64 *slot)
-{
-	u64 dummy[1];
-	s64 ret;
-
-	ret = beat_hcall1(HV_insert_htab_entry3, dummy, htab_id, group,
-		hpte_v, hpte_r, mask_v, value_v);
-	*slot = dummy[0];
-	return ret;
-}
-
-static inline s64 beat_invalidate_htab_entry3(u64 htab_id, u64 group,
-	u64 va, u64 pss)
-{
-	return beat_hcall_norets(HV_invalidate_htab_entry3,
-		htab_id, group, va, pss);
-}
-
-static inline s64 beat_update_htab_permission3(u64 htab_id, u64 group,
-	u64 va, u64 pss, u64 ptel_mask, u64 ptel_value)
-{
-	return beat_hcall_norets(HV_update_htab_permission3,
-		htab_id, group, va, pss, ptel_mask, ptel_value);
-}
-
-static inline s64 beat_clear_htab3(u64 htab_id)
-{
-	return beat_hcall_norets(HV_clear_htab3, htab_id);
-}
-
-static inline void beat_shutdown_logical_partition(u64 code)
-{
-	(void)beat_hcall_norets(HV_shutdown_logical_partition, code);
-}
-
-static inline s64 beat_rtc_write(u64 time_from_epoch)
-{
-	return beat_hcall_norets(HV_rtc_write, time_from_epoch);
-}
-
-static inline s64 beat_rtc_read(u64 *time_from_epoch)
-{
-	u64 dummy[1];
-	s64 ret;
-
-	ret = beat_hcall1(HV_rtc_read, dummy);
-	*time_from_epoch = dummy[0];
-	return ret;
-}
-
-#define	BEAT_NVRW_CNT	(sizeof(u64) * 6)
-
-static inline s64 beat_eeprom_write(u64 index, u64 length, u8 *buffer)
-{
-	u64	b[6];
-
-	if (length > BEAT_NVRW_CNT)
-		return -1;
-	memcpy(b, buffer, sizeof(b));
-	return beat_hcall_norets8(HV_eeprom_write, index, length,
-		b[0], b[1], b[2], b[3], b[4], b[5]);
-}
-
-static inline s64 beat_eeprom_read(u64 index, u64 length, u8 *buffer)
-{
-	u64	b[6];
-	s64	ret;
-
-	if (length > BEAT_NVRW_CNT)
-		return -1;
-	ret = beat_hcall6(HV_eeprom_read, b, index, length);
-	memcpy(buffer, b, length);
-	return ret;
-}
-
-static inline s64 beat_set_dabr(u64 value, u64 style)
-{
-	return beat_hcall_norets(HV_set_dabr, value, style);
-}
-
-static inline s64 beat_get_characters_from_console(u64 termno, u64 *len,
-	u8 *buffer)
-{
-	u64 dummy[3];
-	s64 ret;
-
-	ret = beat_hcall3(HV_get_characters_from_console, dummy, termno, len);
-	*len = dummy[0];
-	memcpy(buffer, dummy + 1, *len);
-	return ret;
-}
-
-static inline s64 beat_put_characters_to_console(u64 termno, u64 len,
-	u8 *buffer)
-{
-	u64 b[2];
-
-	memcpy(b, buffer, len);
-	return beat_hcall_norets(HV_put_characters_to_console, termno, len,
-		b[0], b[1]);
-}
-
-static inline s64 beat_get_spe_privileged_state_1_registers(
-		u64 id, u64 offsetof, u64 *value)
-{
-	u64 dummy[1];
-	s64 ret;
-
-	ret = beat_hcall1(HV_get_spe_privileged_state_1_registers, dummy, id,
-		offsetof);
-	*value = dummy[0];
-	return ret;
-}
-
-static inline s64 beat_set_irq_mask_for_spe(u64 id, u64 class, u64 mask)
-{
-	return beat_hcall_norets(HV_set_irq_mask_for_spe, id, class, mask);
-}
-
-static inline s64 beat_clear_interrupt_status_of_spe(u64 id, u64 class,
-	u64 mask)
-{
-	return beat_hcall_norets(HV_clear_interrupt_status_of_spe,
-		id, class, mask);
-}
-
-static inline s64 beat_set_spe_privileged_state_1_registers(
-		u64 id, u64 offsetof, u64 value)
-{
-	return beat_hcall_norets(HV_set_spe_privileged_state_1_registers,
-		id, offsetof, value);
-}
-
-static inline s64 beat_get_interrupt_status_of_spe(u64 id, u64 class, u64 *val)
-{
-	u64 dummy[1];
-	s64 ret;
-
-	ret = beat_hcall1(HV_get_interrupt_status_of_spe, dummy, id, class);
-	*val = dummy[0];
-	return ret;
-}
-
-static inline s64 beat_put_iopte(u64 ioas_id, u64 io_addr, u64 real_addr,
-	u64 ioid, u64 flags)
-{
-	return beat_hcall_norets(HV_put_iopte, ioas_id, io_addr, real_addr,
-		ioid, flags);
-}
-
-static inline s64 beat_construct_event_receive_port(u64 *port)
-{
-	u64 dummy[1];
-	s64 ret;
-
-	ret = beat_hcall1(HV_construct_event_receive_port, dummy);
-	*port = dummy[0];
-	return ret;
-}
-
-static inline s64 beat_destruct_event_receive_port(u64 port)
-{
-	s64 ret;
-
-	ret = beat_hcall_norets(HV_destruct_event_receive_port, port);
-	return ret;
-}
-
-static inline s64 beat_create_repository_node(u64 path[4], u64 data[2])
-{
-	s64 ret;
-
-	ret = beat_hcall_norets(HV_create_repository_node2,
-		path[0], path[1], path[2], path[3], data[0], data[1]);
-	return ret;
-}
-
-static inline s64 beat_get_repository_node_value(u64 lpid, u64 path[4],
-	u64 data[2])
-{
-	s64 ret;
-
-	ret = beat_hcall2(HV_get_repository_node_value2, data,
-		lpid, path[0], path[1], path[2], path[3]);
-	return ret;
-}
-
-#endif
Index: b/arch/powerpc/platforms/celleb/hvCall.S
===================================================================
--- a/arch/powerpc/platforms/celleb/hvCall.S	2008-04-23 21:10:12.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,287 +0,0 @@
-/*
- * Beat hypervisor call I/F
- *
- * (C) Copyright 2007 TOSHIBA CORPORATION
- *
- * This code is based on arch/powerpc/platforms/pseries/hvCall.S.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <asm/ppc_asm.h>
-
-#define	STK_PARM(i)	(48 + ((i)-3)*8)
-
-/* Not implemented on Beat, now */
-#define	HCALL_INST_PRECALL
-#define	HCALL_INST_POSTCALL
-
-	.text
-
-#define	HVSC	.long	0x44000022
-
-/* Note: takes only 7 input parameters at maximum */
-_GLOBAL(beat_hcall_norets)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL
-
-	mr	r11,r3
-	mr	r3,r4
-	mr	r4,r5
-	mr	r5,r6
-	mr	r6,r7
-	mr	r7,r8
-	mr	r8,r9
-
-	HVSC				/* invoke the hypervisor */
-
-	HCALL_INST_POSTCALL
-
-	lwz	r0,8(r1)
-	mtcrf	0xff,r0
-
-	blr				/* return r3 = status */
-
-/* Note: takes 8 input parameters at maximum */
-_GLOBAL(beat_hcall_norets8)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL
-
-	mr	r11,r3
-	mr	r3,r4
-	mr	r4,r5
-	mr	r5,r6
-	mr	r6,r7
-	mr	r7,r8
-	mr	r8,r9
-	ld	r10,STK_PARM(r10)(r1)
-
-	HVSC				/* invoke the hypervisor */
-
-	HCALL_INST_POSTCALL
-
-	lwz	r0,8(r1)
-	mtcrf	0xff,r0
-
-	blr				/* return r3 = status */
-
-/* Note: takes only 6 input parameters, 1 output parameters at maximum */
-_GLOBAL(beat_hcall1)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL
-
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
-
-	mr	r11,r3
-	mr	r3,r5
-	mr	r4,r6
-	mr	r5,r7
-	mr	r6,r8
-	mr	r7,r9
-	mr	r8,r10
-
-	HVSC				/* invoke the hypervisor */
-
-	HCALL_INST_POSTCALL
-
-	ld	r12,STK_PARM(r4)(r1)
-	std	r4,  0(r12)
-
-	lwz	r0,8(r1)
-	mtcrf	0xff,r0
-
-	blr				/* return r3 = status */
-
-/* Note: takes only 6 input parameters, 2 output parameters at maximum */
-_GLOBAL(beat_hcall2)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL
-
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
-
-	mr	r11,r3
-	mr	r3,r5
-	mr	r4,r6
-	mr	r5,r7
-	mr	r6,r8
-	mr	r7,r9
-	mr	r8,r10
-
-	HVSC				/* invoke the hypervisor */
-
-	HCALL_INST_POSTCALL
-
-	ld	r12,STK_PARM(r4)(r1)
-	std	r4,  0(r12)
-	std	r5,  8(r12)
-
-	lwz	r0,8(r1)
-	mtcrf	0xff,r0
-
-	blr				/* return r3 = status */
-
-/* Note: takes only 6 input parameters, 3 output parameters at maximum */
-_GLOBAL(beat_hcall3)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL
-
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
-
-	mr	r11,r3
-	mr	r3,r5
-	mr	r4,r6
-	mr	r5,r7
-	mr	r6,r8
-	mr	r7,r9
-	mr	r8,r10
-
-	HVSC				/* invoke the hypervisor */
-
-	HCALL_INST_POSTCALL
-
-	ld	r12,STK_PARM(r4)(r1)
-	std	r4,  0(r12)
-	std	r5,  8(r12)
-	std	r6, 16(r12)
-
-	lwz	r0,8(r1)
-	mtcrf	0xff,r0
-
-	blr				/* return r3 = status */
-
-/* Note: takes only 6 input parameters, 4 output parameters at maximum */
-_GLOBAL(beat_hcall4)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL
-
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
-
-	mr	r11,r3
-	mr	r3,r5
-	mr	r4,r6
-	mr	r5,r7
-	mr	r6,r8
-	mr	r7,r9
-	mr	r8,r10
-
-	HVSC				/* invoke the hypervisor */
-
-	HCALL_INST_POSTCALL
-
-	ld	r12,STK_PARM(r4)(r1)
-	std	r4,  0(r12)
-	std	r5,  8(r12)
-	std	r6, 16(r12)
-	std	r7, 24(r12)
-
-	lwz	r0,8(r1)
-	mtcrf	0xff,r0
-
-	blr				/* return r3 = status */
-
-/* Note: takes only 6 input parameters, 5 output parameters at maximum */
-_GLOBAL(beat_hcall5)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL
-
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
-
-	mr	r11,r3
-	mr	r3,r5
-	mr	r4,r6
-	mr	r5,r7
-	mr	r6,r8
-	mr	r7,r9
-	mr	r8,r10
-
-	HVSC				/* invoke the hypervisor */
-
-	HCALL_INST_POSTCALL
-
-	ld	r12,STK_PARM(r4)(r1)
-	std	r4,  0(r12)
-	std	r5,  8(r12)
-	std	r6, 16(r12)
-	std	r7, 24(r12)
-	std	r8, 32(r12)
-
-	lwz	r0,8(r1)
-	mtcrf	0xff,r0
-
-	blr				/* return r3 = status */
-
-/* Note: takes only 6 input parameters, 6 output parameters at maximum */
-_GLOBAL(beat_hcall6)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL
-
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
-
-	mr	r11,r3
-	mr	r3,r5
-	mr	r4,r6
-	mr	r5,r7
-	mr	r6,r8
-	mr	r7,r9
-	mr	r8,r10
-
-	HVSC				/* invoke the hypervisor */
-
-	HCALL_INST_POSTCALL
-
-	ld	r12,STK_PARM(r4)(r1)
-	std	r4,  0(r12)
-	std	r5,  8(r12)
-	std	r6, 16(r12)
-	std	r7, 24(r12)
-	std	r8, 32(r12)
-	std	r9, 40(r12)
-
-	lwz	r0,8(r1)
-	mtcrf	0xff,r0
-
-	blr				/* return r3 = status */
Index: b/arch/powerpc/platforms/cell/Makefile
===================================================================
--- a/arch/powerpc/platforms/cell/Makefile	2008-04-23 21:37:36.000000000 +0900
+++ b/arch/powerpc/platforms/cell/Makefile	2008-04-23 21:38:14.000000000 +0900
@@ -34,7 +34,8 @@
 obj-y					+= celleb_setup.o \
 					   celleb_pci.o celleb_scc_epci.o \
 					   celleb_scc_uhc.o \
-					   io-workarounds.o spider-pci.o
+					   io-workarounds.o spider-pci.o \
+					   beat_hvCall.o
 
 obj-$(CONFIG_SERIAL_TXX9)		+= celleb_scc_sio.o
 endif
Index: b/arch/powerpc/platforms/celleb/Makefile
===================================================================
--- a/arch/powerpc/platforms/celleb/Makefile	2008-04-23 21:37:36.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/Makefile	2008-04-23 21:38:14.000000000 +0900
@@ -1,5 +1,5 @@
 obj-y				+= interrupt.o iommu.o \
-				   htab.o beat.o hvCall.o
+				   htab.o beat.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
Index: b/arch/powerpc/platforms/cell/celleb_setup.c
===================================================================
--- a/arch/powerpc/platforms/cell/celleb_setup.c	2008-04-23 21:36:14.000000000 +0900
+++ b/arch/powerpc/platforms/cell/celleb_setup.c	2008-04-23 21:38:14.000000000 +0900
@@ -57,7 +57,7 @@
 #include <asm/cell-regs.h>
 
 #include "../celleb/interrupt.h"
-#include "../celleb/beat_wrapper.h"
+#include "beat_wrapper.h"
 #include "../celleb/beat.h"
 #include "celleb_pci.h"
 #include "interrupt.h"
Index: b/arch/powerpc/platforms/celleb/beat.c
===================================================================
--- a/arch/powerpc/platforms/celleb/beat.c	2008-04-23 21:10:12.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/beat.c	2008-04-23 21:38:14.000000000 +0900
@@ -31,7 +31,7 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 
-#include "beat_wrapper.h"
+#include "../cell/beat_wrapper.h"
 #include "beat.h"
 #include "interrupt.h"
 
Index: b/arch/powerpc/platforms/celleb/htab.c
===================================================================
--- a/arch/powerpc/platforms/celleb/htab.c	2008-04-23 21:10:12.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/htab.c	2008-04-23 21:38:14.000000000 +0900
@@ -32,7 +32,7 @@
 #include <asm/machdep.h>
 #include <asm/udbg.h>
 
-#include "beat_wrapper.h"
+#include "../cell/beat_wrapper.h"
 
 #ifdef DEBUG_LOW
 #define DBG_LOW(fmt...) do { udbg_printf(fmt); } while (0)
Index: b/arch/powerpc/platforms/celleb/interrupt.c
===================================================================
--- a/arch/powerpc/platforms/celleb/interrupt.c	2008-04-23 21:10:12.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/interrupt.c	2008-04-23 21:38:14.000000000 +0900
@@ -27,7 +27,7 @@
 #include <asm/machdep.h>
 
 #include "interrupt.h"
-#include "beat_wrapper.h"
+#include "../cell/beat_wrapper.h"
 
 #define	MAX_IRQS	NR_IRQS
 static DEFINE_SPINLOCK(beatic_irq_mask_lock);
Index: b/arch/powerpc/platforms/celleb/iommu.c
===================================================================
--- a/arch/powerpc/platforms/celleb/iommu.c	2008-04-23 21:10:12.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/iommu.c	2008-04-23 21:38:14.000000000 +0900
@@ -26,7 +26,7 @@
 
 #include <asm/machdep.h>
 
-#include "beat_wrapper.h"
+#include "../cell/beat_wrapper.h"
 
 #define DMA_FLAGS 0xf800000000000000UL	/* r/w permitted, coherency required,
 					   strongest order */
Index: b/arch/powerpc/platforms/celleb/spu_priv1.c
===================================================================
--- a/arch/powerpc/platforms/celleb/spu_priv1.c	2008-04-23 21:10:12.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/spu_priv1.c	2008-04-23 21:38:14.000000000 +0900
@@ -24,7 +24,7 @@
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
 
-#include "beat_wrapper.h"
+#include "../cell/beat_wrapper.h"
 
 static inline void _int_mask_set(struct spu *spu, int class, u64 mask)
 {
