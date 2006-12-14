Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E558767C5C
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 13:34:16 +1100 (EST)
Date: Thu, 14 Dec 2006 11:34:06 +0900 (JST)
Message-Id: <200612140234.kBE2Y89L017576@toshiba.co.jp>
Subject: [PATCH 8/19] powerpc: interfaces to the hypervisor of Celleb
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

This patch creates Celleb platform dependent file which adds interfaces
to call hypervisor.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/hvCall_macro.S
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/hvCall_macro.S:1.2
--- /dev/null	Wed Dec 13 21:32:01 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/hvCall_macro.S	Wed Dec 13 18:37:14 2006
@@ -0,0 +1,208 @@
+/*
+ * Beat hypervisor call I/F
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
+#include <asm/ppc_asm.h>
+
+#define	HCALL_MEDIUM	or 	2,2,2
+#define	HVSC	.long	0x44000022
+#define	LOAD_CONST64(r, const)					\
+	lis	r, ((const)>>48)&0xFFFF;			\
+	ori	r, r, ((const)>>32)&0xFFFF;			\
+	rldicr	r, r, 32, 31;					\
+	oris	r, r, ((const)>>16)&0xFFFF;			\
+	ori	r, r, ((const)>>0)&0xFFFF
+
+#define	STK_PARM(i)	(48 + ((i)-3)*8)
+#define	HCALL_INST_PRECALL
+#define	HCALL_INST_POSTCALL
+
+#define	__define_beat_callup_handler_NOOUTS(name, id)		\
+_GLOBAL(beat_##name)						\
+	HCALL_MEDIUM;						\
+	mflr	r0;						\
+	std	r0, 16(r1);					\
+	HCALL_INST_PRECALL;					\
+	LOAD_CONST64(r11,id);					\
+	HVSC;							\
+	HCALL_INST_POSTCALL;					\
+	ld	r0, 16(r1);					\
+	mtlr	r0;						\
+	blr
+
+#define	__define_beat_callup_handler_OUT1(ins, name, id)	\
+_GLOBAL(beat_##name)						\
+	HCALL_MEDIUM;						\
+	mflr	r0;						\
+	std	r0, 16(r1);					\
+	std	r3+ins,STK_PARM(r3+ins)(r1);			\
+	LOAD_CONST64(r11,id);					\
+	HVSC;							\
+	ld	r11, STK_PARM(r3+ins)(r1);			\
+	std	r4, 0(r1);					\
+	ld	r0, 16(r1);					\
+	mtlr	r0;						\
+	blr
+
+#define	__define_beat_callup_handler_OUT2(ins, name, id)	\
+_GLOBAL(beat_##name)						\
+	HCALL_MEDIUM;						\
+	mflr	r0;						\
+	std	r0, 16(r1);					\
+	std	r3+ins,STK_PARM(r3+ins)(r1);			\
+	std	r4+ins,STK_PARM(r4+ins)(r1);			\
+	LOAD_CONST64(r11,id);					\
+	HVSC;							\
+	ld	r11, STK_PARM(r3+ins)(r1);			\
+	std	r4, 0(r11);					\
+	ld	r11, STK_PARM(r4+ins)(r1);			\
+	std	r5, 0(r11);					\
+	ld	r0, 16(r1);					\
+	mtlr	r0;						\
+	blr
+
+#define	__define_beat_callup_handler_OUT3(ins, name, id)	\
+_GLOBAL(beat_##name)						\
+	HCALL_MEDIUM;						\
+	mflr	r0;						\
+	std	r0, 16(r1);					\
+	std	r3+ins,STK_PARM(r3+ins)(r1);			\
+	std	r4+ins,STK_PARM(r4+ins)(r1);			\
+	std	r5+ins,STK_PARM(r5+ins)(r1);			\
+	LOAD_CONST64(r11,id);					\
+	HVSC;							\
+	ld	r11, STK_PARM(r3+ins)(r1);			\
+	std	r4, 0(r11);					\
+	ld	r11, STK_PARM(r4+ins)(r1);			\
+	std	r5, 0(r11);					\
+	ld	r11, STK_PARM(r5+ins)(r1);			\
+	std	r6, 0(r11);					\
+	ld	r0, 16(r1);					\
+	mtlr	r0;						\
+	blr
+
+#define	__define_beat_callup_handler_OUT4(ins, name, id)	\
+_GLOBAL(beat_##name)						\
+	HCALL_MEDIUM;						\
+	mflr	r0;						\
+	std	r0, 16(r1);					\
+	std	r3+ins,STK_PARM(r3+ins)(r1);			\
+	std	r4+ins,STK_PARM(r4+ins)(r1);			\
+	std	r5+ins,STK_PARM(r5+ins)(r1);			\
+	std	r6+ins,STK_PARM(r6+ins)(r1);			\
+	LOAD_CONST64(r11,id);					\
+	HVSC;							\
+	ld	r11, STK_PARM(r3+ins)(r1);			\
+	std	r4, 0(r11);					\
+	ld	r11, STK_PARM(r4+ins)(r1);			\
+	std	r5, 0(r11);					\
+	ld	r11, STK_PARM(r5+ins)(r1);			\
+	std	r6, 0(r11);					\
+	ld	r11, STK_PARM(r6+ins)(r1);			\
+	std	r7, 0(r11);					\
+	ld	r0, 16(r1);					\
+	mtlr	r0;						\
+	blr
+
+#define	__define_beat_callup_handler_OUT5(ins, name, id)	\
+_GLOBAL(beat_##name)						\
+	HCALL_MEDIUM;						\
+	mflr	r0;						\
+	std	r0, 16(r1);					\
+	std	r3+ins,STK_PARM(r3+ins)(r1);			\
+	std	r4+ins,STK_PARM(r4+ins)(r1);			\
+	std	r5+ins,STK_PARM(r5+ins)(r1);			\
+	std	r6+ins,STK_PARM(r6+ins)(r1);			\
+	std	r7+ins,STK_PARM(r7+ins)(r1);			\
+	LOAD_CONST64(r11,id);					\
+	HVSC;							\
+	ld	r11, STK_PARM(r3+ins)(r1);			\
+	std	r4, 0(r11);					\
+	ld	r11, STK_PARM(r4+ins)(r1);			\
+	std	r5, 0(r11);					\
+	ld	r11, STK_PARM(r5+ins)(r1);			\
+	std	r6, 0(r11);					\
+	ld	r11, STK_PARM(r6+ins)(r1);			\
+	std	r7, 0(r11);					\
+	ld	r11, STK_PARM(r7+ins)(r1);			\
+	std	r8, 0(r11);					\
+	ld	r0, 16(r1);					\
+	mtlr	r0;						\
+	blr
+
+#define	__define_beat_callup_handler_OUT6(ins, name, id)	\
+_GLOBAL(beat_##name)						\
+	HCALL_MEDIUM;						\
+	mflr	r0;						\
+	std	r0, 16(r1);					\
+	std	r3+ins,STK_PARM(r3+ins)(r1);			\
+	std	r4+ins,STK_PARM(r4+ins)(r1);			\
+	std	r5+ins,STK_PARM(r5+ins)(r1);			\
+	std	r6+ins,STK_PARM(r6+ins)(r1);			\
+	std	r7+ins,STK_PARM(r7+ins)(r1);			\
+	std	r8+ins,STK_PARM(r8+ins)(r1);			\
+	LOAD_CONST64(r11,id);					\
+	HVSC;							\
+	ld	r11, STK_PARM(r3+ins)(r1);			\
+	std	r4, 0(r11);					\
+	ld	r11, STK_PARM(r4+ins)(r1);			\
+	std	r5, 0(r11);					\
+	ld	r11, STK_PARM(r5+ins)(r1);			\
+	std	r6, 0(r11);					\
+	ld	r11, STK_PARM(r6+ins)(r1);			\
+	std	r7, 0(r11);					\
+	ld	r11, STK_PARM(r7+ins)(r1);			\
+	std	r8, 0(r11);					\
+	ld	r11, STK_PARM(r8+ins)(r1);			\
+	std	r9, 0(r11);					\
+	ld	r0, 16(r1);					\
+	mtlr	r0;						\
+	blr
+
+#define	__define_beat_callup_handler_OUT7(ins, name, id)	\
+_GLOBAL(beat_##name)						\
+	HCALL_MEDIUM;						\
+	mflr	r0;						\
+	std	r0, 16(r1);					\
+	std	r3+ins,STK_PARM(r3+ins)(r1);			\
+	std	r4+ins,STK_PARM(r4+ins)(r1);			\
+	std	r5+ins,STK_PARM(r5+ins)(r1);			\
+	std	r6+ins,STK_PARM(r6+ins)(r1);			\
+	std	r7+ins,STK_PARM(r7+ins)(r1);			\
+	std	r8+ins,STK_PARM(r8+ins)(r1);			\
+	std	r9+ins,STK_PARM(r9+ins)(r1);			\
+	LOAD_CONST64(r11,id);					\
+	HVSC;							\
+	ld	r11, STK_PARM(r3+ins)(r1);			\
+	std	r4, 0(r11);					\
+	ld	r11, STK_PARM(r4+ins)(r1);			\
+	std	r5, 0(r11);					\
+	ld	r11, STK_PARM(r5+ins)(r1);			\
+	std	r6, 0(r11);					\
+	ld	r11, STK_PARM(r6+ins)(r1);			\
+	std	r7, 0(r11);					\
+	ld	r11, STK_PARM(r7+ins)(r1);			\
+	std	r8, 0(r11);					\
+	ld	r11, STK_PARM(r8+ins)(r1);			\
+	std	r9, 0(r11);					\
+	ld	r11, STK_PARM(r9+ins)(r1);			\
+	std	r10, 0(r11);					\
+	ld	r0, 16(r1);					\
+	mtlr	r0;						\
+	blr
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/hvCall.S
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/hvCall.S:1.2
--- /dev/null	Wed Dec 13 21:32:02 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/hvCall.S	Wed Dec 13 18:37:14 2006
@@ -0,0 +1,196 @@
+/* This file is automatically generated, dont touch
+ * Beat hypervisor call I/F
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
+#ifndef	BEAT_SYSMAC__ASSEMBLY_H
+#define	BEAT_SYSMAC__ASSEMBLY_H
+#include <asm/ppc_asm.h>
+#include "hvCall_macro.S"
+__define_beat_callup_handler_OUT2(4, allocate_memory, (0))
+__define_beat_callup_handler_OUT2(3, construct_virtual_address_space, (2))
+__define_beat_callup_handler_NOOUTS(destruct_virtual_address_space, (10))
+__define_beat_callup_handler_OUT1(0, get_virtual_address_space_id_of_ppe, (4))
+__define_beat_callup_handler_OUT5(1, query_logical_partition_address_region_info, (6))
+__define_beat_callup_handler_NOOUTS(release_memory, (13))
+__define_beat_callup_handler_NOOUTS(select_virtual_address_space, (7))
+__define_beat_callup_handler_NOOUTS(load_range_registers, (68))
+__define_beat_callup_handler_NOOUTS(set_ppe_l2cache_rmt_entry, (70))
+__define_beat_callup_handler_NOOUTS(set_ppe_tlb_rmt_entry, (71))
+__define_beat_callup_handler_NOOUTS(set_spe_tlb_rmt_entry, (72))
+__define_beat_callup_handler_OUT4(0, get_io_address_translation_fault_info, (14))
+__define_beat_callup_handler_OUT3(2, get_iopte, (16))
+__define_beat_callup_handler_NOOUTS(preload_iopt_cache, (17))
+__define_beat_callup_handler_OUT3(5, put_iopte, (15))
+__define_beat_callup_handler_NOOUTS(connect_event_ports, (21))
+__define_beat_callup_handler_OUT1(0, construct_event_receive_port, (18))
+__define_beat_callup_handler_NOOUTS(destruct_event_receive_port, (19))
+__define_beat_callup_handler_NOOUTS(destruct_event_send_port, (22))
+__define_beat_callup_handler_OUT1(1, get_state_of_event_send_port, (25))
+__define_beat_callup_handler_OUT1(6, request_to_connect_event_ports, (20))
+__define_beat_callup_handler_NOOUTS(send_event_externally, (23))
+__define_beat_callup_handler_NOOUTS(send_event_locally, (24))
+__define_beat_callup_handler_NOOUTS(construct_and_connect_irq_plug, (28))
+__define_beat_callup_handler_NOOUTS(destruct_irq_plug, (29))
+__define_beat_callup_handler_OUT4(1, detect_pending_interrupts, (26))
+__define_beat_callup_handler_NOOUTS(end_of_interrupt, (27))
+__define_beat_callup_handler_NOOUTS(assign_control_signal_notification_port, (45))
+__define_beat_callup_handler_NOOUTS(end_of_control_signal_processing, (48))
+__define_beat_callup_handler_OUT7(0, get_control_signal, (46))
+__define_beat_callup_handler_OUT1(1, get_resource_limit, (47))
+__define_beat_callup_handler_NOOUTS(set_irq_mask_for_spe, (61))
+__define_beat_callup_handler_NOOUTS(shutdown_logical_partition, (44))
+__define_beat_callup_handler_OUT1(2, connect_message_ports, (35))
+__define_beat_callup_handler_NOOUTS(destruct_message_port, (36))
+__define_beat_callup_handler_OUT7(1, receive_message, (37))
+__define_beat_callup_handler_OUT2(1, get_message_port_info, (34))
+__define_beat_callup_handler_OUT1(6, request_to_connect_message_ports, (33))
+__define_beat_callup_handler_NOOUTS(send_message, (32))
+__define_beat_callup_handler_OUT1(0, get_logical_ppe_id, (69))
+__define_beat_callup_handler_OUT1(0, get_total_execution_time, (103))
+__define_beat_callup_handler_NOOUTS(pause, (9))
+__define_beat_callup_handler_NOOUTS(destruct_shared_memory_handle, (51))
+__define_beat_callup_handler_OUT3(1, get_shared_memory_info, (52))
+__define_beat_callup_handler_NOOUTS(permit_sharing_memory, (50))
+__define_beat_callup_handler_OUT1(7, request_to_attach_shared_memory, (49))
+__define_beat_callup_handler_NOOUTS(enable_logical_spe_execution, (55))
+__define_beat_callup_handler_OUT4(2, construct_logical_spe, (53))
+__define_beat_callup_handler_NOOUTS(disable_logical_spe_execution, (56))
+__define_beat_callup_handler_NOOUTS(destruct_logical_spe, (54))
+__define_beat_callup_handler_OUT2(2, obsolete_get_slb_for_logical_spe, (63))
+__define_beat_callup_handler_OUT1(2, sense_spe_execution_status, (58))
+__define_beat_callup_handler_NOOUTS(obsolete_set_slb_for_logical_spe, (62))
+__define_beat_callup_handler_OUT3(5, insert_htab_entry, (101))
+__define_beat_callup_handler_OUT5(2, read_htab_entries, (95))
+__define_beat_callup_handler_OUT2(6, write_htab_entry, (94))
+__define_beat_callup_handler_NOOUTS(assign_io_address_translation_fault_port, (100))
+__define_beat_callup_handler_NOOUTS(enable_fast_get_total_execution_time, (75))
+__define_beat_callup_handler_NOOUTS(set_interrupt_mask, (73))
+__define_beat_callup_handler_OUT1(0, get_logical_partition_id, (74))
+__define_beat_callup_handler_NOOUTS(create_repository_node2, (90))
+__define_beat_callup_handler_NOOUTS(create_repository_node, (90))
+__define_beat_callup_handler_OUT2(5, get_repository_node_value2, (91))
+__define_beat_callup_handler_OUT2(5, get_repository_node_value, (91))
+__define_beat_callup_handler_NOOUTS(modify_repository_node_value2, (92))
+__define_beat_callup_handler_NOOUTS(modify_repository_node_value, (92))
+__define_beat_callup_handler_NOOUTS(remove_repository_node2, (93))
+__define_beat_callup_handler_NOOUTS(remove_repository_node, (93))
+__define_beat_callup_handler_NOOUTS(cancel_shared_memory, (104))
+__define_beat_callup_handler_NOOUTS(clear_interrupt_status_of_spe, (206))
+__define_beat_callup_handler_OUT1(2, construct_spe_irq_outlet, (80))
+__define_beat_callup_handler_NOOUTS(destruct_spe_irq_outlet, (81))
+__define_beat_callup_handler_NOOUTS(disconnect_ipspc_service, (88))
+__define_beat_callup_handler_NOOUTS(execute_ipspc_command, (86))
+__define_beat_callup_handler_OUT1(2, get_interrupt_status_of_spe, (205))
+__define_beat_callup_handler_OUT1(2, get_spe_privileged_state_1_registers, (208))
+__define_beat_callup_handler_OUT1(8, permit_use_of_ipspc_service, (85))
+__define_beat_callup_handler_NOOUTS(reinitialize_logical_spe, (82))
+__define_beat_callup_handler_OUT1(6, request_ipspc_service, (84))
+__define_beat_callup_handler_NOOUTS(stop_ipspc_command, (87))
+__define_beat_callup_handler_NOOUTS(set_spe_privileged_state_1_registers, (204))
+__define_beat_callup_handler_OUT1(1, get_status_of_ipspc_service, (203))
+__define_beat_callup_handler_NOOUTS(put_characters_to_console, (0x101 | (1 << 60)))
+__define_beat_callup_handler_OUT3(1, get_characters_from_console, (0x102 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(send_resresrv_req, (0x110 | (1 << 60)))
+__define_beat_callup_handler_OUT1(1, get_base_clock, (0x111 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(set_base_clock, (0x112 | (1 << 60)))
+__define_beat_callup_handler_OUT2(1, get_frame_cycle, (0x114 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(disable_console, (0x115 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(disable_all_console, (0x116 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(oneshot_timer, (0x117 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(set_dabr, (0x118 | (1 << 60)))
+__define_beat_callup_handler_OUT2(0, get_dabr, (0x119 | (1 << 60)))
+__define_beat_callup_handler_OUT4(2, debug_read_htab_entry, (0x181 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_view_evtq, (0x184 | (1 << 60)))
+__define_beat_callup_handler_OUT1(3, debug_dmesg, (0x185 | (1 << 60)))
+__define_beat_callup_handler_OUT1(1, debug_dmesg_get_size, (0x186 | (1 << 60)))
+__define_beat_callup_handler_OUT1(1, debug_get_dma_address, (0x18c | (1 << 60)))
+__define_beat_callup_handler_OUT7(8, debug_mem_check, (0x201 | (1 << 60)))
+__define_beat_callup_handler_OUT1(5, debug_allocate_io_segment, (0x202 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_release_io_segment, (0x203 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_assign_ioid_user_partition, (0x204 | (1 << 60)))
+__define_beat_callup_handler_OUT5(2, debug_query_io_address_region_info, (0x205 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_disp_reverse_map, (0x206 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_atc_log, (0x214 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_iopt_log, (0x215 | (1 << 60)))
+__define_beat_callup_handler_OUT7(8, debug_iopt_check, (0x216 | (1 << 60)))
+__define_beat_callup_handler_OUT4(1, debug_read_iopt_cache, (0x217 | (1 << 60)))
+__define_beat_callup_handler_OUT1(1, debug_translate_physical_to_logical_partition_address, (0x218 | (1 << 60)))
+__define_beat_callup_handler_OUT1(1, debug_translate_logical_partition_to_physical_address, (0x219 | (1 << 60)))
+__define_beat_callup_handler_OUT1(3, debug_map_physical_address_region, (0x21a | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_unmap_physical_address_region, (0x21b | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(start_hv_stats, (0x21c | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(stop_hv_stats, (0x21d | (1 << 60)))
+__define_beat_callup_handler_OUT7(1, get_hv_stats, (0x21e | (1 << 60)))
+__define_beat_callup_handler_OUT4(1, get_hv_error_stats, (0x221 | (1 << 60)))
+__define_beat_callup_handler_OUT7(7, get_stats, (0x224 | (1 << 60)))
+__define_beat_callup_handler_OUT6(0, get_heap_stats, (0x225 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_dump_all_flags, (0x21f | (1 << 60)))
+__define_beat_callup_handler_OUT1(6, debug_get_flag, (0x220 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_set_flag, (0x222 | (1 << 60)))
+__define_beat_callup_handler_OUT2(0, get_comm_buff_info, (0x226 | (1 << 60)))
+__define_beat_callup_handler_OUT6(1, get_memory_stats, (0x227 | (1 << 60)))
+__define_beat_callup_handler_OUT2(0, get_memory_detail, (0x228 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(nop, (0x300 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(set_priority_of_irq_outlet, (0x122 | (1 << 60)))
+__define_beat_callup_handler_OUT4(1, debug_get_interrupt_mask, (0x125 | (1 << 60)))
+__define_beat_callup_handler_OUT1(1, debug_get_priority_of_ppe, (0x126 | (1 << 60)))
+__define_beat_callup_handler_OUT4(4, debug_get_resresrv_info, (0x127 | (1 << 60)))
+__define_beat_callup_handler_OUT1(1, get_physical_spe_by_reservation_id, (0x128 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_put_bgtask, (0x3fe | (1 << 60)))
+__define_beat_callup_handler_OUT4(4, get_spe_context, (0x129 | (1 << 60)))
+__define_beat_callup_handler_OUT6(4, set_spe_context, (0x12a | (1 << 60)))
+__define_beat_callup_handler_OUT1(2, get_spe_execution_time, (0x12b | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(clear_spe_execution_time, (0x12c | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(downcount_of_interrupt, (0x12e | (1 << 60)))
+__define_beat_callup_handler_OUT4(4, peek_spe_context, (0x12f | (1 << 60)))
+__define_beat_callup_handler_OUT2(1, read_bpa_register, (0x131 | (1 << 60)))
+__define_beat_callup_handler_OUT1(4, write_bpa_register, (0x132 | (1 << 60)))
+__define_beat_callup_handler_OUT1(1, map_context_table_of_spe, (0x137 | (1 << 60)))
+__define_beat_callup_handler_OUT2(2, get_slb_for_logical_spe, (0x138 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(set_slb_for_logical_spe, (0x139 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(init_pm, (0x150 | (1 << 60)))
+__define_beat_callup_handler_OUT3(4, set_pm_signal, (0x151 | (1 << 60)))
+__define_beat_callup_handler_OUT3(1, get_pm_signal, (0x152 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(set_pm_config, (0x153 | (1 << 60)))
+__define_beat_callup_handler_OUT6(1, get_pm_config, (0x154 | (1 << 60)))
+__define_beat_callup_handler_OUT2(4, get_inner_trace_data, (0x155 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(set_ext_trace_buffer, (0x156 | (1 << 60)))
+__define_beat_callup_handler_OUT3(1, get_ext_trace_buffer, (0x157 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(set_pm_interrupt, (0x158 | (1 << 60)))
+__define_beat_callup_handler_OUT3(1, get_pm_interrupt, (0x159 | (1 << 60)))
+__define_beat_callup_handler_OUT1(2, kick_pm, (0x160 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_view_command_queue, (0x163 | (1 << 60)))
+__define_beat_callup_handler_OUT1(0, construct_pm_context, (0x164 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(destruct_pm_context, (0x165 | (1 << 60)))
+__define_beat_callup_handler_OUT1(1, be_slow, (0x170 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(assign_ipspc_server_connection_status_notification_port, (0x173 | (1 << 60)))
+__define_beat_callup_handler_OUT1(1, get_raid_of_physical_spe, (0x174 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(set_physical_spe_to_rag, (0x175 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(release_physical_spe_from_rag, (0x176 | (1 << 60)))
+__define_beat_callup_handler_OUT4(1, read_version_from_eeprom, (0x177 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(write_version_to_eeprom, (0x178 | (1 << 60)))
+__define_beat_callup_handler_OUT6(2, debug_eeprom_read, (0x179 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(debug_eeprom_write, (0x180 | (1 << 60)))
+__define_beat_callup_handler_OUT1(0, rtc_read, (0x190 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(rtc_write, (0x191 | (1 << 60)))
+__define_beat_callup_handler_OUT6(2, eeprom_read, (0x192 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(eeprom_write, (0x193 | (1 << 60)))
+__define_beat_callup_handler_NOOUTS(convert_error_to_event, (0x194 | (1 << 60)))
+
+#endif
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h:1.3
--- /dev/null	Wed Dec 13 21:32:02 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h	Wed Dec 13 18:37:14 2006
@@ -0,0 +1,335 @@
+/* This file is automatically generated, dont touch
+ * Beat hypervisor call I/F
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
+#ifndef	BEAT_SYSMAC__H
+#define	BEAT_SYSMAC__H
+#ifndef	__BEAT_SYSMAC_H__
+#define	__BEAT_SYSMAC_H__
+
+#define	__define_beat_input_args0
+#define	__define_beat_input_args1	\
+	uint64_t __argt1
+#define	__define_beat_input_args2	\
+	__define_beat_input_args1,	\
+	uint64_t __argt2
+#define	__define_beat_input_args3	\
+	__define_beat_input_args2,	\
+	uint64_t __argt3
+#define	__define_beat_input_args4	\
+	__define_beat_input_args3,	\
+	uint64_t __argt4
+#define	__define_beat_input_args5	\
+	__define_beat_input_args4,	\
+	uint64_t __argt5
+#define	__define_beat_input_args6	\
+	__define_beat_input_args5,	\
+	uint64_t __argt6
+#define	__define_beat_input_args7	\
+	__define_beat_input_args6,	\
+	uint64_t __argt7
+#define	__define_beat_input_args8	\
+	__define_beat_input_args7,	\
+	uint64_t __argt8
+
+#define	__define_beat_output_args0
+#define	__define_beat_output_args1	\
+	uint64_t *__arge1
+#define	__define_beat_output_args2	\
+	__define_beat_output_args1,	\
+	uint64_t *__arge2
+#define	__define_beat_output_args3	\
+	__define_beat_output_args2,	\
+	uint64_t *__arge3
+#define	__define_beat_output_args4	\
+	__define_beat_output_args3,	\
+	uint64_t *__arge4
+#define	__define_beat_output_args5	\
+	__define_beat_output_args4,	\
+	uint64_t *__arge5
+#define	__define_beat_output_args6	\
+	__define_beat_output_args5,	\
+	uint64_t *__arge6
+#define	__define_beat_output_args7	\
+	__define_beat_output_args6,	\
+	uint64_t *__arge7
+
+#define	__define_beat_assign_input0
+#define	__define_beat_assign_input1	\
+	__define_beat_assign_input0	\
+	__arg1 = __argt1;
+#define	__define_beat_assign_input2	\
+	__define_beat_assign_input1	\
+	__arg2 = __argt2;
+#define	__define_beat_assign_input3	\
+	__define_beat_assign_input2	\
+	__arg3 = __argt3;
+#define	__define_beat_assign_input4	\
+	__define_beat_assign_input3	\
+	__arg4 = __argt4;
+#define	__define_beat_assign_input5	\
+	__define_beat_assign_input4	\
+	__arg5 = __argt5;
+#define	__define_beat_assign_input6	\
+	__define_beat_assign_input5	\
+	__arg6 = __argt6;
+#define	__define_beat_assign_input7	\
+	__define_beat_assign_input6	\
+	__arg7 = __argt7;
+#define	__define_beat_assign_input8	\
+	__define_beat_assign_input7	\
+	__arg8 = __argt8;
+
+#define	__define_beat_assign_output0
+#define	__define_beat_assign_output1	\
+	__define_beat_assign_output0	\
+	*__arge1 = __arg2;
+#define	__define_beat_assign_output2	\
+	__define_beat_assign_output1	\
+	*__arge2 = __arg3;
+#define	__define_beat_assign_output3	\
+	__define_beat_assign_output2	\
+	*__arge3 = __arg4;
+#define	__define_beat_assign_output4	\
+	__define_beat_assign_output3	\
+	*__arge4 = __arg5;
+#define	__define_beat_assign_output5	\
+	__define_beat_assign_output4	\
+	*__arge5 = __arg6;
+#define	__define_beat_assign_output6	\
+	__define_beat_assign_output5	\
+	*__arge6 = __arg7;
+#define	__define_beat_assign_output7	\
+	__define_beat_assign_output6	\
+	*__arge7 = __arg8;
+
+#define	__define_beat_callup_handler_BODY(in, out, name, id)	\
+{								\
+	register uint64_t __arg1 __asm__("r3");			\
+	register uint64_t __arg2 __asm__("r4");			\
+	register uint64_t __arg3 __asm__("r5");			\
+	register uint64_t __arg4 __asm__("r6");			\
+	register uint64_t __arg5 __asm__("r7");			\
+	register uint64_t __arg6 __asm__("r8");			\
+	register uint64_t __arg7 __asm__("r9");			\
+	register uint64_t __arg8 __asm__("r10");		\
+	register uint64_t __sn __asm__("r11") = id;		\
+	__define_beat_assign_input##in				\
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"	\
+		: "=&r"(__sn),					\
+		"=&r"(__arg1), "=&r"(__arg2), "=&r"(__arg3), "=&r"(__arg4), \
+		"=&r"(__arg5), "=&r"(__arg6), "=&r"(__arg7), "=&r"(__arg8) \
+		: "0"(__sn),					\
+		"1"(__arg1), "2"(__arg2), "3"(__arg3), "4"(__arg4),	\
+		"5"(__arg5), "6"(__arg6), "7"(__arg7), "8"(__arg8)	\
+		: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");	\
+	__define_beat_assign_output##out			\
+	return __arg1;						\
+}
+
+#define	__define_beat_callup_handler_NOPARAM(name, id)		\
+static inline int64_t beat_##name(void)				\
+	__define_beat_callup_handler_BODY(0, 0, name, id)
+#define	__define_beat_callup_handler_IN_ONLY(in, name, id)	\
+static inline int64_t beat_##name(				\
+	__define_beat_input_args##in) 				\
+	__define_beat_callup_handler_BODY(in, 0, name, id)
+#define	__define_beat_callup_handler_OUT_ONLY(out, name, id)	\
+static inline int64_t beat_##name(				\
+	__define_beat_output_args##out)				\
+	__define_beat_callup_handler_BODY(0, out, name, id)
+#define	__define_beat_callup_handler_BOTH(in, out, name, id)	\
+static inline int64_t beat_##name(				\
+	__define_beat_input_args##in, 				\
+	__define_beat_output_args##out)				\
+	__define_beat_callup_handler_BODY(in, out, name, id)
+
+#endif
+__define_beat_callup_handler_BOTH(4, 2, allocate_memory, (0UL))
+__define_beat_callup_handler_BOTH(3, 2, construct_virtual_address_space, (2UL))
+__define_beat_callup_handler_IN_ONLY(1, destruct_virtual_address_space, (10UL))
+__define_beat_callup_handler_OUT_ONLY(1, get_virtual_address_space_id_of_ppe, (4UL))
+__define_beat_callup_handler_BOTH(1, 5, query_logical_partition_address_region_info, (6UL))
+__define_beat_callup_handler_IN_ONLY(1, release_memory, (13UL))
+__define_beat_callup_handler_IN_ONLY(1, select_virtual_address_space, (7UL))
+__define_beat_callup_handler_IN_ONLY(3, load_range_registers, (68UL))
+__define_beat_callup_handler_IN_ONLY(2, set_ppe_l2cache_rmt_entry, (70UL))
+__define_beat_callup_handler_IN_ONLY(2, set_ppe_tlb_rmt_entry, (71UL))
+__define_beat_callup_handler_IN_ONLY(3, set_spe_tlb_rmt_entry, (72UL))
+__define_beat_callup_handler_OUT_ONLY(4, get_io_address_translation_fault_info, (14UL))
+__define_beat_callup_handler_BOTH(2, 3, get_iopte, (16UL))
+__define_beat_callup_handler_IN_ONLY(3, preload_iopt_cache, (17UL))
+__define_beat_callup_handler_BOTH(5, 3, put_iopte, (15UL))
+__define_beat_callup_handler_IN_ONLY(2, connect_event_ports, (21UL))
+__define_beat_callup_handler_OUT_ONLY(1, construct_event_receive_port, (18UL))
+__define_beat_callup_handler_IN_ONLY(1, destruct_event_receive_port, (19UL))
+__define_beat_callup_handler_IN_ONLY(1, destruct_event_send_port, (22UL))
+__define_beat_callup_handler_BOTH(1, 1, get_state_of_event_send_port, (25UL))
+__define_beat_callup_handler_BOTH(6, 1, request_to_connect_event_ports, (20UL))
+__define_beat_callup_handler_IN_ONLY(1, send_event_externally, (23UL))
+__define_beat_callup_handler_IN_ONLY(1, send_event_locally, (24UL))
+__define_beat_callup_handler_IN_ONLY(2, construct_and_connect_irq_plug, (28UL))
+__define_beat_callup_handler_IN_ONLY(1, destruct_irq_plug, (29UL))
+__define_beat_callup_handler_BOTH(1, 4, detect_pending_interrupts, (26UL))
+__define_beat_callup_handler_IN_ONLY(1, end_of_interrupt, (27UL))
+__define_beat_callup_handler_IN_ONLY(1, assign_control_signal_notification_port, (45UL))
+__define_beat_callup_handler_IN_ONLY(1, end_of_control_signal_processing, (48UL))
+__define_beat_callup_handler_OUT_ONLY(7, get_control_signal, (46UL))
+__define_beat_callup_handler_BOTH(1, 1, get_resource_limit, (47UL))
+__define_beat_callup_handler_IN_ONLY(3, set_irq_mask_for_spe, (61UL))
+__define_beat_callup_handler_IN_ONLY(1, shutdown_logical_partition, (44UL))
+__define_beat_callup_handler_BOTH(2, 1, connect_message_ports, (35UL))
+__define_beat_callup_handler_IN_ONLY(1, destruct_message_port, (36UL))
+__define_beat_callup_handler_BOTH(1, 7, receive_message, (37UL))
+__define_beat_callup_handler_BOTH(1, 2, get_message_port_info, (34UL))
+__define_beat_callup_handler_BOTH(6, 1, request_to_connect_message_ports, (33UL))
+__define_beat_callup_handler_IN_ONLY(7, send_message, (32UL))
+__define_beat_callup_handler_OUT_ONLY(1, get_logical_ppe_id, (69UL))
+__define_beat_callup_handler_OUT_ONLY(1, get_total_execution_time, (103UL))
+__define_beat_callup_handler_IN_ONLY(1, pause, (9UL))
+__define_beat_callup_handler_IN_ONLY(1, destruct_shared_memory_handle, (51UL))
+__define_beat_callup_handler_BOTH(1, 3, get_shared_memory_info, (52UL))
+__define_beat_callup_handler_IN_ONLY(4, permit_sharing_memory, (50UL))
+__define_beat_callup_handler_BOTH(7, 1, request_to_attach_shared_memory, (49UL))
+__define_beat_callup_handler_IN_ONLY(2, enable_logical_spe_execution, (55UL))
+__define_beat_callup_handler_BOTH(2, 4, construct_logical_spe, (53UL))
+__define_beat_callup_handler_IN_ONLY(1, disable_logical_spe_execution, (56UL))
+__define_beat_callup_handler_IN_ONLY(1, destruct_logical_spe, (54UL))
+__define_beat_callup_handler_BOTH(2, 2, obsolete_get_slb_for_logical_spe, (63UL))
+__define_beat_callup_handler_BOTH(2, 1, sense_spe_execution_status, (58UL))
+__define_beat_callup_handler_IN_ONLY(5, obsolete_set_slb_for_logical_spe, (62UL))
+__define_beat_callup_handler_BOTH(5, 3, insert_htab_entry, (101UL))
+__define_beat_callup_handler_BOTH(2, 5, read_htab_entries, (95UL))
+__define_beat_callup_handler_BOTH(6, 2, write_htab_entry, (94UL))
+__define_beat_callup_handler_IN_ONLY(1, assign_io_address_translation_fault_port, (100UL))
+__define_beat_callup_handler_NOPARAM(enable_fast_get_total_execution_time, (75UL))
+__define_beat_callup_handler_IN_ONLY(5, set_interrupt_mask, (73UL))
+__define_beat_callup_handler_OUT_ONLY(1, get_logical_partition_id, (74UL))
+__define_beat_callup_handler_IN_ONLY(6, create_repository_node2, (90UL))
+__define_beat_callup_handler_IN_ONLY(6, create_repository_node, (90UL))
+__define_beat_callup_handler_BOTH(5, 2, get_repository_node_value2, (91UL))
+__define_beat_callup_handler_BOTH(5, 2, get_repository_node_value, (91UL))
+__define_beat_callup_handler_IN_ONLY(6, modify_repository_node_value2, (92UL))
+__define_beat_callup_handler_IN_ONLY(6, modify_repository_node_value, (92UL))
+__define_beat_callup_handler_IN_ONLY(4, remove_repository_node2, (93UL))
+__define_beat_callup_handler_IN_ONLY(4, remove_repository_node, (93UL))
+__define_beat_callup_handler_IN_ONLY(2, cancel_shared_memory, (104UL))
+__define_beat_callup_handler_IN_ONLY(3, clear_interrupt_status_of_spe, (206UL))
+__define_beat_callup_handler_BOTH(2, 1, construct_spe_irq_outlet, (80UL))
+__define_beat_callup_handler_IN_ONLY(1, destruct_spe_irq_outlet, (81UL))
+__define_beat_callup_handler_IN_ONLY(2, disconnect_ipspc_service, (88UL))
+__define_beat_callup_handler_IN_ONLY(7, execute_ipspc_command, (86UL))
+__define_beat_callup_handler_BOTH(2, 1, get_interrupt_status_of_spe, (205UL))
+__define_beat_callup_handler_BOTH(2, 1, get_spe_privileged_state_1_registers, (208UL))
+__define_beat_callup_handler_BOTH(8, 1, permit_use_of_ipspc_service, (85UL))
+__define_beat_callup_handler_IN_ONLY(1, reinitialize_logical_spe, (82UL))
+__define_beat_callup_handler_BOTH(6, 1, request_ipspc_service, (84UL))
+__define_beat_callup_handler_IN_ONLY(1, stop_ipspc_command, (87UL))
+__define_beat_callup_handler_IN_ONLY(3, set_spe_privileged_state_1_registers, (204UL))
+__define_beat_callup_handler_BOTH(1, 1, get_status_of_ipspc_service, (203UL))
+__define_beat_callup_handler_IN_ONLY(4, put_characters_to_console, (0x101UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 3, get_characters_from_console, (0x102UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(2, send_resresrv_req, (0x110UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 1, get_base_clock, (0x111UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(2, set_base_clock, (0x112UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 2, get_frame_cycle, (0x114UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(1, disable_console, (0x115UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(1, disable_all_console, (0x116UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(3, oneshot_timer, (0x117UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(2, set_dabr, (0x118UL | (1UL << 60)))
+__define_beat_callup_handler_OUT_ONLY(2, get_dabr, (0x119UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(2, 4, debug_read_htab_entry, (0x181UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(7, debug_view_evtq, (0x184UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(3, 1, debug_dmesg, (0x185UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 1, debug_dmesg_get_size, (0x186UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 1, debug_get_dma_address, (0x18cUL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(8, 7, debug_mem_check, (0x201UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(5, 1, debug_allocate_io_segment, (0x202UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(2, debug_release_io_segment, (0x203UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(2, debug_assign_ioid_user_partition, (0x204UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(2, 5, debug_query_io_address_region_info, (0x205UL | (1UL << 60)))
+__define_beat_callup_handler_NOPARAM(debug_disp_reverse_map, (0x206UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(1, debug_atc_log, (0x214UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(1, debug_iopt_log, (0x215UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(8, 7, debug_iopt_check, (0x216UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 4, debug_read_iopt_cache, (0x217UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 1, debug_translate_physical_to_logical_partition_address, (0x218UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 1, debug_translate_logical_partition_to_physical_address, (0x219UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(3, 1, debug_map_physical_address_region, (0x21aUL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(1, debug_unmap_physical_address_region, (0x21bUL | (1UL << 60)))
+__define_beat_callup_handler_NOPARAM(start_hv_stats, (0x21cUL | (1UL << 60)))
+__define_beat_callup_handler_NOPARAM(stop_hv_stats, (0x21dUL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 7, get_hv_stats, (0x21eUL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 4, get_hv_error_stats, (0x221UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(7, 7, get_stats, (0x224UL | (1UL << 60)))
+__define_beat_callup_handler_OUT_ONLY(6, get_heap_stats, (0x225UL | (1UL << 60)))
+__define_beat_callup_handler_NOPARAM(debug_dump_all_flags, (0x21fUL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(6, 1, debug_get_flag, (0x220UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(7, debug_set_flag, (0x222UL | (1UL << 60)))
+__define_beat_callup_handler_OUT_ONLY(2, get_comm_buff_info, (0x226UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 6, get_memory_stats, (0x227UL | (1UL << 60)))
+__define_beat_callup_handler_OUT_ONLY(2, get_memory_detail, (0x228UL | (1UL << 60)))
+__define_beat_callup_handler_NOPARAM(nop, (0x300UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(2, set_priority_of_irq_outlet, (0x122UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 4, debug_get_interrupt_mask, (0x125UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 1, debug_get_priority_of_ppe, (0x126UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(4, 4, debug_get_resresrv_info, (0x127UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 1, get_physical_spe_by_reservation_id, (0x128UL | (1UL << 60)))
+__define_beat_callup_handler_NOPARAM(debug_put_bgtask, (0x3feUL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(4, 4, get_spe_context, (0x129UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(4, 6, set_spe_context, (0x12aUL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(2, 1, get_spe_execution_time, (0x12bUL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(2, clear_spe_execution_time, (0x12cUL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(1, downcount_of_interrupt, (0x12eUL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(4, 4, peek_spe_context, (0x12fUL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 2, read_bpa_register, (0x131UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(4, 1, write_bpa_register, (0x132UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 1, map_context_table_of_spe, (0x137UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(2, 2, get_slb_for_logical_spe, (0x138UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(5, set_slb_for_logical_spe, (0x139UL | (1UL << 60)))
+__define_beat_callup_handler_NOPARAM(init_pm, (0x150UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(4, 3, set_pm_signal, (0x151UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 3, get_pm_signal, (0x152UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(7, set_pm_config, (0x153UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 6, get_pm_config, (0x154UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(4, 2, get_inner_trace_data, (0x155UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(4, set_ext_trace_buffer, (0x156UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 3, get_ext_trace_buffer, (0x157UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(3, set_pm_interrupt, (0x158UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 3, get_pm_interrupt, (0x159UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(2, 1, kick_pm, (0x160UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(1, debug_view_command_queue, (0x163UL | (1UL << 60)))
+__define_beat_callup_handler_OUT_ONLY(1, construct_pm_context, (0x164UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(1, destruct_pm_context, (0x165UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 1, be_slow, (0x170UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(2, assign_ipspc_server_connection_status_notification_port, (0x173UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 1, get_raid_of_physical_spe, (0x174UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(2, set_physical_spe_to_rag, (0x175UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(1, release_physical_spe_from_rag, (0x176UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(1, 4, read_version_from_eeprom, (0x177UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(5, write_version_to_eeprom, (0x178UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(2, 6, debug_eeprom_read, (0x179UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(8, debug_eeprom_write, (0x180UL | (1UL << 60)))
+__define_beat_callup_handler_OUT_ONLY(1, rtc_read, (0x190UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(1, rtc_write, (0x191UL | (1UL << 60)))
+__define_beat_callup_handler_BOTH(2, 6, eeprom_read, (0x192UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(8, eeprom_write, (0x193UL | (1UL << 60)))
+__define_beat_callup_handler_IN_ONLY(1, convert_error_to_event, (0x194UL | (1UL << 60)))
+
+#endif
