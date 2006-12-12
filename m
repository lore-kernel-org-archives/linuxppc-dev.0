Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BE1367C3C
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 14:23:50 +1100 (EST)
Date: Tue, 12 Dec 2006 12:23:44 +0900 (JST)
Message-Id: <200612120323.kBC3NjEW004119@toshiba.co.jp>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 4/15] celleb: interfaces to the hypervisor of Celleb
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h:1.1
--- /dev/null	Mon Dec 11 20:37:33 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h	Wed Dec  6 08:43:15 2006
@@ -0,0 +1,2072 @@
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
+#ifndef	BEAT_SYSMAC_syscall_H
+#define	BEAT_SYSMAC_syscall_H
+extern int64_t beat_errno;
+static inline int64_t beat_allocate_memory(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3,void** __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (0UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (void*)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_construct_virtual_address_space(uint64_t __in0, uint64_t __in1, uint64_t __in2,uint64_t* __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (2UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_destruct_virtual_address_space(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (10UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_virtual_address_space_id_of_ppe(uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (4UL);
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_query_logical_partition_address_region_info(uint64_t __in0, uint64_t __out[5]) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __sn __asm__("r11") = (6UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	__out[0] = (uint64_t)__reg1;
+	__out[1] = (uint64_t)__reg2;
+	__out[2] = (uint64_t)__reg3;
+	__out[3] = (uint64_t)__reg4;
+	__out[4] = (uint64_t)__reg5;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_release_memory(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (13UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_select_virtual_address_space(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (7UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_load_range_registers(uint64_t __in0, uint64_t __in1, uint64_t __in2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (68UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_ppe_l2cache_rmt_entry(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (70UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_ppe_tlb_rmt_entry(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (71UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_spe_tlb_rmt_entry(uint64_t __in0, uint64_t __in1, uint64_t __in2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (72UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_io_address_translation_fault_info(uint64_t* __out0,uint64_t* __out1,uint64_t* __out2,uint64_t* __out3) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (14UL);
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	*__out3 = (uint64_t)__reg4;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_iopte(uint64_t __in0, uint64_t __in1,void** __out0,uint64_t* __out1,uint64_t* __out2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (16UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (void*)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_preload_iopt_cache(uint64_t __in0, uint64_t __in1, uint64_t __in2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (17UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_put_iopte(uint64_t __in0, uint64_t __in1, void* __in2, uint64_t __in3, uint64_t __in4,void** __out0,uint64_t* __out1,uint64_t* __out2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (15UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (void*)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_connect_event_ports(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (21UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_construct_event_receive_port(uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (18UL);
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_destruct_event_receive_port(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (19UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_destruct_event_send_port(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (22UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_state_of_event_send_port(uint64_t __in0,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (25UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_request_to_connect_event_ports(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __sn __asm__("r11") = (20UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_send_event_externally(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (23UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_send_event_locally(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (24UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_construct_and_connect_irq_plug(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (28UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_destruct_irq_plug(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (29UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_detect_pending_interrupts(uint64_t __in0, uint64_t __out[4]) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (26UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	__out[0] = (uint64_t)__reg1;
+	__out[1] = (uint64_t)__reg2;
+	__out[2] = (uint64_t)__reg3;
+	__out[3] = (uint64_t)__reg4;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_end_of_interrupt(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (27UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_assign_control_signal_notification_port(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (45UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_end_of_control_signal_processing(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (48UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_control_signal(uint64_t* __out0,uint64_t* __out1,uint64_t* __out2,uint64_t* __out3,uint64_t* __out4,uint64_t* __out5,uint64_t* __out6) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __reg7 __asm__("r10");
+	register uint64_t __sn __asm__("r11") = (46UL);
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6), "=&r"(__reg7)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	*__out3 = (uint64_t)__reg4;
+	*__out4 = (uint64_t)__reg5;
+	*__out5 = (uint64_t)__reg6;
+	*__out6 = (uint64_t)__reg7;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_irq_mask_for_spe(uint64_t __in0, uint64_t __in1, uint64_t __in2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (61UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_shutdown_logical_partition(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (44UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_connect_message_ports(uint64_t __in0, uint64_t __in1,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (35UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_destruct_message_port(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (36UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_receive_message(uint64_t __in0,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2,uint64_t* __out3,uint64_t* __out4,uint64_t* __out5,uint64_t* __out6) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __reg7 __asm__("r10");
+	register uint64_t __sn __asm__("r11") = (37UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6), "=&r"(__reg7)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	*__out3 = (uint64_t)__reg4;
+	*__out4 = (uint64_t)__reg5;
+	*__out5 = (uint64_t)__reg6;
+	*__out6 = (uint64_t)__reg7;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_message_port_info(uint64_t __in0,uint64_t* __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (34UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_request_to_connect_message_ports(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __sn __asm__("r11") = (33UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_send_message(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5, uint64_t __in6) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __sn __asm__("r11") = (32UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__reg6 = (uint64_t)__in6;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5), "7"(__reg6)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_logical_ppe_id(uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (69UL);
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_pause(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (9UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_destruct_shared_memory_handle(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (51UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_shared_memory_info(uint64_t __in0,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (52UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_permit_sharing_memory(uint64_t __in0, void* __in1, uint64_t __in2, uint64_t __in3) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (50UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_request_to_attach_shared_memory(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5, uint64_t __in6,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __sn __asm__("r11") = (49UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__reg6 = (uint64_t)__in6;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5), "7"(__reg6)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_enable_logical_spe_execution(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (55UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_construct_logical_spe(uint64_t __in0, uint64_t __in1, uint64_t __out[4]) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (53UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	__out[0] = (uint64_t)__reg1;
+	__out[1] = (uint64_t)__reg2;
+	__out[2] = (uint64_t)__reg3;
+	__out[3] = (uint64_t)__reg4;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_disable_logical_spe_execution(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (56UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_destruct_logical_spe(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (54UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_sense_spe_execution_status(uint64_t __in0, uint64_t __in1,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (58UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_insert_htab_entry(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (101UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_read_htab_entries(uint64_t __in0, uint64_t __in1,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2,uint64_t* __out3,uint64_t* __out4) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __sn __asm__("r11") = (95UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	*__out3 = (uint64_t)__reg4;
+	*__out4 = (uint64_t)__reg5;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_write_htab_entry(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5,uint64_t* __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __sn __asm__("r11") = (94UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_assign_io_address_translation_fault_port(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (100UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_interrupt_mask(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (73UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_logical_partition_id(uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (74UL);
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_create_repository_node2(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __sn __asm__("r11") = (90UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_create_repository_node(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __sn __asm__("r11") = (90UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_repository_node_value2(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4,uint64_t* __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (91UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_repository_node_value(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4,uint64_t* __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (91UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_modify_repository_node_value2(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __sn __asm__("r11") = (92UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_modify_repository_node_value(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __sn __asm__("r11") = (92UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_remove_repository_node2(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (93UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_remove_repository_node(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (93UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_cancel_shared_memory(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (104UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_clear_interrupt_status_of_spe(uint64_t __in0, uint64_t __in1, uint64_t __in2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (206UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_construct_spe_irq_outlet(uint64_t __in0, uint64_t __in1,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (80UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_destruct_spe_irq_outlet(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (81UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_disconnect_ipspc_service(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (88UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_execute_ipspc_command(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5, uint64_t __in6) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __sn __asm__("r11") = (86UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__reg6 = (uint64_t)__in6;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5), "7"(__reg6)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_interrupt_status_of_spe(uint64_t __in0, uint64_t __in1,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (205UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_spe_privileged_state_1_registers(uint64_t __in0, uint64_t __in1,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (208UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_permit_use_of_ipspc_service(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5, uint64_t __in6, uint64_t __in7,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __reg7 __asm__("r10");
+	register uint64_t __sn __asm__("r11") = (85UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__reg6 = (uint64_t)__in6;
+	__reg7 = (uint64_t)__in7;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6), "=&r"(__reg7)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5), "7"(__reg6), "8"(__reg7)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_reinitialize_logical_spe(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (82UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_request_ipspc_service(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __sn __asm__("r11") = (84UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_stop_ipspc_command(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (87UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_spe_privileged_state_1_registers(uint64_t __in0, uint64_t __in1, uint64_t __in2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (204UL);
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_status_of_ipspc_service(uint64_t __in0,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (203UL);
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_put_characters_to_console(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (0x101UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_characters_from_console(uint64_t __in0,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (0x102UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_base_clock(uint64_t __in0,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x111UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_base_clock(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x112UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_frame_cycle(uint64_t __in0,uint64_t* __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (0x114UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_disable_console(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (0x115UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_disable_all_console(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (0x116UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_oneshot_timer(uint64_t __in0, uint64_t __in1, uint64_t __in2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (0x117UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_dabr(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x118UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_dabr(uint64_t* __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (0x119UL | (1UL << 60));
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_start_hv_stats(void) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (0x21cUL | (1UL << 60));
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_stop_hv_stats(void) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (0x21dUL | (1UL << 60));
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_hv_stats(uint64_t __in0,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2,uint64_t* __out3,uint64_t* __out4,uint64_t* __out5,uint64_t* __out6) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __reg7 __asm__("r10");
+	register uint64_t __sn __asm__("r11") = (0x21eUL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6), "=&r"(__reg7)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	*__out3 = (uint64_t)__reg4;
+	*__out4 = (uint64_t)__reg5;
+	*__out5 = (uint64_t)__reg6;
+	*__out6 = (uint64_t)__reg7;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_hv_error_stats(uint64_t __in0,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2,uint64_t* __out3) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (0x221UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	*__out3 = (uint64_t)__reg4;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_stats(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5, uint64_t __in6,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2,uint64_t* __out3,uint64_t* __out4,uint64_t* __out5,uint64_t* __out6) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __reg7 __asm__("r10");
+	register uint64_t __sn __asm__("r11") = (0x224UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__reg6 = (uint64_t)__in6;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6), "=&r"(__reg7)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5), "7"(__reg6)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	*__out3 = (uint64_t)__reg4;
+	*__out4 = (uint64_t)__reg5;
+	*__out5 = (uint64_t)__reg6;
+	*__out6 = (uint64_t)__reg7;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_heap_stats(uint64_t* __out0,uint64_t* __out1,uint64_t* __out2,uint64_t* __out3,uint64_t* __out4,uint64_t* __out5) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __sn __asm__("r11") = (0x225UL | (1UL << 60));
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	*__out3 = (uint64_t)__reg4;
+	*__out4 = (uint64_t)__reg5;
+	*__out5 = (uint64_t)__reg6;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_memory_stats(uint64_t __in0,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2,uint64_t* __out3,uint64_t* __out4,uint64_t* __out5) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __sn __asm__("r11") = (0x227UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	*__out3 = (uint64_t)__reg4;
+	*__out4 = (uint64_t)__reg5;
+	*__out5 = (uint64_t)__reg6;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_memory_detail(uint64_t* __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (0x228UL | (1UL << 60));
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_priority_of_irq_outlet(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x122UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_physical_spe_by_reservation_id(uint64_t __in0,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x128UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_spe_context(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __out[4]) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (0x129UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	__out[0] = (uint64_t)__reg1;
+	__out[1] = (uint64_t)__reg2;
+	__out[2] = (uint64_t)__reg3;
+	__out[3] = (uint64_t)__reg4;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_spe_context(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __out[6]) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __sn __asm__("r11") = (0x12aUL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	__out[0] = (uint64_t)__reg1;
+	__out[1] = (uint64_t)__reg2;
+	__out[2] = (uint64_t)__reg3;
+	__out[3] = (uint64_t)__reg4;
+	__out[4] = (uint64_t)__reg5;
+	__out[5] = (uint64_t)__reg6;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_downcount_of_interrupt(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (0x12eUL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_peek_spe_context(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __out[4]) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (0x12fUL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	__out[0] = (uint64_t)__reg1;
+	__out[1] = (uint64_t)__reg2;
+	__out[2] = (uint64_t)__reg3;
+	__out[3] = (uint64_t)__reg4;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_read_bpa_register(uint64_t __in0,uint64_t* __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (0x131UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_write_bpa_register(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (0x132UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_map_context_table_of_spe(uint64_t __in0,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x137UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_slb_for_logical_spe(uint64_t __in0, uint64_t __in1,uint64_t* __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (0x138UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_slb_for_logical_spe(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __sn __asm__("r11") = (0x139UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_init_pm(void) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (0x150UL | (1UL << 60));
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_pm_signal(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (0x151UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_pm_signal(uint64_t __in0,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (0x152UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_pm_config(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5, uint64_t __in6) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __sn __asm__("r11") = (0x153UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__reg6 = (uint64_t)__in6;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5), "7"(__reg6)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_pm_config(uint64_t __in0,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2,uint64_t* __out3,uint64_t* __out4,uint64_t* __out5) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __sn __asm__("r11") = (0x154UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	*__out3 = (uint64_t)__reg4;
+	*__out4 = (uint64_t)__reg5;
+	*__out5 = (uint64_t)__reg6;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_inner_trace_data(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3,uint64_t* __out0,uint64_t* __out1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (0x155UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_ext_trace_buffer(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (0x156UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_ext_trace_buffer(uint64_t __in0,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (0x157UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_pm_interrupt(uint64_t __in0, uint64_t __in1, uint64_t __in2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __sn __asm__("r11") = (0x158UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_pm_interrupt(uint64_t __in0,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __sn __asm__("r11") = (0x159UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_kick_pm(uint64_t __in0, uint64_t __in1,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x160UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_construct_pm_context(uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x164UL | (1UL << 60));
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_destruct_pm_context(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (0x165UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_be_slow(uint64_t __in0,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x170UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_assign_ipspc_server_connection_status_notification_port(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x173UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_get_raid_of_physical_spe(uint64_t __in0,uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x174UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_set_physical_spe_to_rag(uint64_t __in0, uint64_t __in1) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x175UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_release_physical_spe_from_rag(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (0x176UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_rtc_read(uint64_t* __out0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __sn __asm__("r11") = (0x190UL | (1UL << 60));
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1)
+	: "0"(__sn)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_rtc_write(uint64_t __in0) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __sn __asm__("r11") = (0x191UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0)
+	: "0"(__sn), "1"(__reg0)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_eeprom_read(uint64_t __in0, uint64_t __in1,uint64_t* __out0,uint64_t* __out1,uint64_t* __out2,uint64_t* __out3,uint64_t* __out4,uint64_t* __out5) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __sn __asm__("r11") = (0x192UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	*__out0 = (uint64_t)__reg1;
+	*__out1 = (uint64_t)__reg2;
+	*__out2 = (uint64_t)__reg3;
+	*__out3 = (uint64_t)__reg4;
+	*__out4 = (uint64_t)__reg5;
+	*__out5 = (uint64_t)__reg6;
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+static inline int64_t beat_eeprom_write(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3, uint64_t __in4, uint64_t __in5, uint64_t __in6, uint64_t __in7) {
+	register uint64_t __reg0 __asm__("r3");
+	register uint64_t __reg1 __asm__("r4");
+	register uint64_t __reg2 __asm__("r5");
+	register uint64_t __reg3 __asm__("r6");
+	register uint64_t __reg4 __asm__("r7");
+	register uint64_t __reg5 __asm__("r8");
+	register uint64_t __reg6 __asm__("r9");
+	register uint64_t __reg7 __asm__("r10");
+	register uint64_t __sn __asm__("r11") = (0x193UL | (1UL << 60));
+	__reg0 = (uint64_t)__in0;
+	__reg1 = (uint64_t)__in1;
+	__reg2 = (uint64_t)__in2;
+	__reg3 = (uint64_t)__in3;
+	__reg4 = (uint64_t)__in4;
+	__reg5 = (uint64_t)__in5;
+	__reg6 = (uint64_t)__in6;
+	__reg7 = (uint64_t)__in7;
+	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
+	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2), "=&r"(__reg3), "=&r"(__reg4), "=&r"(__reg5), "=&r"(__reg6), "=&r"(__reg7)
+	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2), "4"(__reg3), "5"(__reg4), "6"(__reg5), "7"(__reg6), "8"(__reg7)
+	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
+	if(__reg0) beat_errno = __reg0;
+	return __reg0;
+}
+
+#endif
