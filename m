Return-Path: <geoffrey.levand@am.sony.com>
Received: from ns6.sony.co.jp (NS6.Sony.CO.JP [137.153.0.32])
	by ozlabs.org (Postfix) with ESMTP id 9AEEC68205
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 07:02:39 +1100 (EST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id kAAK2bbC019391
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:02:37 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail3.sony.co.jp (R8/Sony) with SMTP id kAAK2bl5019341
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:02:37 +0900 (JST)
Message-ID: <4554DAD7.2090709@am.sony.com>
Date: Fri, 10 Nov 2006 12:02:31 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 8/16] powerpc: add ps3 platform hvcalls
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adds the ps3pf hvcalls.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3pf/exports.c |   27 +
 arch/powerpc/platforms/ps3pf/hvcall.S  |  804 +++++++++++++++++++++++++++++++++
 include/asm-powerpc/lv1call.h          |  345 ++++++++++++++
 3 files changed, 1176 insertions(+)

Index: cell--common--6/arch/powerpc/platforms/ps3pf/exports.c
===================================================================
--- /dev/null
+++ cell--common--6/arch/powerpc/platforms/ps3pf/exports.c
@@ -0,0 +1,27 @@
+/*
+ * exports.c - PS3 Platform HV call exports for modules.
+ *
+ *  Copyright (C) 2006 Sony Computer Entertainment Inc.
+ *  Copyright 2006 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+
+#define LV1_CALL(name, in, out, num)                          \
+  extern s64 _lv1_##name(LV1_##in##_IN_##out##_OUT_ARG_DECL); \
+  EXPORT_SYMBOL(_lv1_##name);
+
+#include <asm/lv1call.h>
Index: cell--common--6/arch/powerpc/platforms/ps3pf/hvcall.S
===================================================================
--- /dev/null
+++ cell--common--6/arch/powerpc/platforms/ps3pf/hvcall.S
@@ -0,0 +1,804 @@
+/*
+ * lv1call.S - PS3 Platform HV call interface.
+ *
+ *  Copyright (C) 2006 Sony Computer Entertainment Inc.
+ *  Copyright 2006 Sony Corp.
+ *  Copyright 2003, 2004 (c) MontaVista Software, Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+
+#define lv1call .long 0x44000022; extsw r3, r3
+
+#define LV1_N_IN_0_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_0_IN_0_OUT LV1_N_IN_0_OUT
+#define LV1_1_IN_0_OUT LV1_N_IN_0_OUT
+#define LV1_2_IN_0_OUT LV1_N_IN_0_OUT
+#define LV1_3_IN_0_OUT LV1_N_IN_0_OUT
+#define LV1_4_IN_0_OUT LV1_N_IN_0_OUT
+#define LV1_5_IN_0_OUT LV1_N_IN_0_OUT
+#define LV1_6_IN_0_OUT LV1_N_IN_0_OUT
+#define LV1_7_IN_0_OUT LV1_N_IN_0_OUT
+
+#define LV1_0_IN_1_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	stdu    r3, -8(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 8;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_0_IN_2_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r3, -8(r1);			\
+	stdu	r4, -16(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 16;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_0_IN_3_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r3, -8(r1);			\
+	std	r4, -16(r1);			\
+	stdu	r5, -24(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 24;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_0_IN_7_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r3, -8(r1);			\
+	std	r4, -16(r1);			\
+	std	r5, -24(r1);			\
+	std	r6, -32(r1);			\
+	std	r7, -40(r1);			\
+	std	r8, -48(r1);			\
+	stdu	r9, -56(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 56;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+	ld	r11, -32(r1);			\
+	std	r7, 0(r11);			\
+	ld	r11, -40(r1);			\
+	std	r8, 0(r11);			\
+	ld	r11, -48(r1);			\
+	std	r9, 0(r11);			\
+	ld	r11, -56(r1);			\
+	std	r10, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_1_IN_1_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	stdu    r4, -8(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 8;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_1_IN_2_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r4, -8(r1);			\
+	stdu	r5, -16(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 16;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_1_IN_3_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r4, -8(r1);			\
+	std	r5, -16(r1);			\
+	stdu	r6, -24(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 24;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_1_IN_4_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r4, -8(r1);			\
+	std	r5, -16(r1);			\
+	std	r6, -24(r1);			\
+	stdu	r7, -32(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 32;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+	ld	r11, -32(r1);			\
+	std	r7, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_1_IN_5_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r4, -8(r1);			\
+	std	r5, -16(r1);			\
+	std	r6, -24(r1);			\
+	std	r7, -32(r1);			\
+	stdu	r8, -40(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 40;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+	ld	r11, -32(r1);			\
+	std	r7, 0(r11);			\
+	ld	r11, -40(r1);			\
+	std	r8, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_1_IN_6_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r4, -8(r1);			\
+	std	r5, -16(r1);			\
+	std	r6, -24(r1);			\
+	std	r7, -32(r1);			\
+	std	r8, -40(r1);			\
+	stdu	r9, -48(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 48;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+	ld	r11, -32(r1);			\
+	std	r7, 0(r11);			\
+	ld	r11, -40(r1);			\
+	std	r8, 0(r11);			\
+	ld	r11, -48(r1);			\
+	std	r9, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_1_IN_7_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r4, -8(r1);			\
+	std	r5, -16(r1);			\
+	std	r6, -24(r1);			\
+	std	r7, -32(r1);			\
+	std	r8, -40(r1);			\
+	std	r9, -48(r1);			\
+	stdu	r10, -56(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 56;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+	ld	r11, -32(r1);			\
+	std	r7, 0(r11);			\
+	ld	r11, -40(r1);			\
+	std	r8, 0(r11);			\
+	ld	r11, -48(r1);			\
+	std	r9, 0(r11);			\
+	ld	r11, -56(r1);			\
+	std	r10, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_2_IN_1_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	stdu	r5, -8(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 8;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_2_IN_2_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r5, -8(r1);			\
+	stdu	r6, -16(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 16;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_2_IN_3_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r5, -8(r1);			\
+	std	r6, -16(r1);			\
+	stdu	r7, -24(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 24;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_2_IN_4_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r5, -8(r1);			\
+	std	r6, -16(r1);			\
+	std	r7, -24(r1);			\
+	stdu	r8, -32(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 32;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+	ld	r11, -32(r1);			\
+	std	r7, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_2_IN_5_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r5, -8(r1);			\
+	std	r6, -16(r1);			\
+	std	r7, -24(r1);			\
+	std	r8, -32(r1);			\
+	stdu	r9, -40(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 40;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+	ld	r11, -32(r1);			\
+	std	r7, 0(r11);			\
+	ld	r11, -40(r1);			\
+	std	r8, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_3_IN_1_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	stdu	r6, -8(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 8;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_3_IN_2_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r6, -8(r1);			\
+	stdu	r7, -16(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 16;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_3_IN_3_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r6, -8(r1);			\
+	std	r7, -16(r1);			\
+	stdu	r8, -24(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 24;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_4_IN_1_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	stdu    r7, -8(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 8;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_4_IN_2_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r7, -8(r1);			\
+	stdu	r8, -16(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 16;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_4_IN_3_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r7, -8(r1);			\
+	std	r8, -16(r1);			\
+	stdu	r9, -24(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 24;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_5_IN_1_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	stdu    r8, -8(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 8;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_5_IN_2_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r8, -8(r1);			\
+	stdu	r9, -16(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 16;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_5_IN_3_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r8, -8(r1);			\
+	std	r9, -16(r1);			\
+	stdu	r10, -24(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 24;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, -24(r1);			\
+	std	r6, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_6_IN_1_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	stdu    r9, -8(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 8;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_6_IN_2_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r9, -8(r1);			\
+	stdu    r10, -16(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 16;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_6_IN_3_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std     r9, -8(r1);			\
+	stdu    r10, -16(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 16;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+	ld	r11, -16(r1);			\
+	std	r5, 0(r11);			\
+	ld	r11, 48+8*8(r1);		\
+	std	r6, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_7_IN_1_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	stdu    r10, -8(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	addi	r1, r1, 8;			\
+	ld	r11, -8(r1);			\
+	std	r4, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_7_IN_6_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	std	r10, 48+8*7(r1);		\
+						\
+	li	r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	ld	r11, 48+8*7(r1);		\
+	std	r4, 0(r11);			\
+	ld	r11, 48+8*8(r1);		\
+	std	r5, 0(r11);			\
+	ld	r11, 48+8*9(r1);		\
+	std	r6, 0(r11);			\
+	ld	r11, 48+8*10(r1);		\
+	std	r7, 0(r11);			\
+	ld	r11, 48+8*11(r1);		\
+	std	r8, 0(r11);			\
+	ld	r11, 48+8*12(r1);		\
+	std	r9, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+#define LV1_8_IN_1_OUT(API_NAME, API_NUMBER)	\
+_GLOBAL(_##API_NAME)				\
+						\
+	mflr	r0;				\
+	std	r0, 16(r1);			\
+						\
+	li      r11, API_NUMBER;		\
+	lv1call;				\
+						\
+	ld	r11, 48+8*8(r1);		\
+	std	r4, 0(r11);			\
+						\
+	ld	r0, 16(r1);			\
+	mtlr	r0;				\
+	blr
+
+	.text
+
+/* the lv1 underscored call definitions expand here */
+
+#define LV1_CALL(name, in, out, num) LV1_##in##_IN_##out##_OUT(lv1_##name, num)
+#include <asm/lv1call.h>
Index: cell--common--6/include/asm-powerpc/lv1call.h
===================================================================
--- /dev/null
+++ cell--common--6/include/asm-powerpc/lv1call.h
@@ -0,0 +1,345 @@
+/*
+ * lv1call.h - PS3 Platform HV call interface.
+ *
+ *  Copyright (C) 2006 Sony Computer Entertainment Inc.
+ *  Copyright 2006 Sony Corp.
+ *  Copyright 2003, 2004 (c) MontaVista Software, Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#if !defined(_8DE1E4A7_DB2B_4F40_B9CB_8A6EC9645057)
+#define _8DE1E4A7_DB2B_4F40_B9CB_8A6EC9645057
+
+#if !defined(__ASSEMBLY__)
+
+#include <linux/types.h>
+
+/* lv1 call declaration macros */
+
+#define LV1_1_IN_ARG_DECL u64 in_1
+#define LV1_2_IN_ARG_DECL LV1_1_IN_ARG_DECL, u64 in_2
+#define LV1_3_IN_ARG_DECL LV1_2_IN_ARG_DECL, u64 in_3
+#define LV1_4_IN_ARG_DECL LV1_3_IN_ARG_DECL, u64 in_4
+#define LV1_5_IN_ARG_DECL LV1_4_IN_ARG_DECL, u64 in_5
+#define LV1_6_IN_ARG_DECL LV1_5_IN_ARG_DECL, u64 in_6
+#define LV1_7_IN_ARG_DECL LV1_6_IN_ARG_DECL, u64 in_7
+#define LV1_8_IN_ARG_DECL LV1_7_IN_ARG_DECL, u64 in_8
+#define LV1_1_OUT_ARG_DECL u64 *out_1
+#define LV1_2_OUT_ARG_DECL LV1_1_OUT_ARG_DECL, u64 *out_2
+#define LV1_3_OUT_ARG_DECL LV1_2_OUT_ARG_DECL, u64 *out_3
+#define LV1_4_OUT_ARG_DECL LV1_3_OUT_ARG_DECL, u64 *out_4
+#define LV1_5_OUT_ARG_DECL LV1_4_OUT_ARG_DECL, u64 *out_5
+#define LV1_6_OUT_ARG_DECL LV1_5_OUT_ARG_DECL, u64 *out_6
+#define LV1_7_OUT_ARG_DECL LV1_6_OUT_ARG_DECL, u64 *out_7
+
+#define LV1_0_IN_0_OUT_ARG_DECL void
+#define LV1_1_IN_0_OUT_ARG_DECL LV1_1_IN_ARG_DECL
+#define LV1_2_IN_0_OUT_ARG_DECL LV1_2_IN_ARG_DECL
+#define LV1_3_IN_0_OUT_ARG_DECL LV1_3_IN_ARG_DECL
+#define LV1_4_IN_0_OUT_ARG_DECL LV1_4_IN_ARG_DECL
+#define LV1_5_IN_0_OUT_ARG_DECL LV1_5_IN_ARG_DECL
+#define LV1_6_IN_0_OUT_ARG_DECL LV1_6_IN_ARG_DECL
+#define LV1_7_IN_0_OUT_ARG_DECL LV1_7_IN_ARG_DECL
+
+#define LV1_0_IN_1_OUT_ARG_DECL                    LV1_1_OUT_ARG_DECL
+#define LV1_1_IN_1_OUT_ARG_DECL LV1_1_IN_ARG_DECL, LV1_1_OUT_ARG_DECL
+#define LV1_2_IN_1_OUT_ARG_DECL LV1_2_IN_ARG_DECL, LV1_1_OUT_ARG_DECL
+#define LV1_3_IN_1_OUT_ARG_DECL LV1_3_IN_ARG_DECL, LV1_1_OUT_ARG_DECL
+#define LV1_4_IN_1_OUT_ARG_DECL LV1_4_IN_ARG_DECL, LV1_1_OUT_ARG_DECL
+#define LV1_5_IN_1_OUT_ARG_DECL LV1_5_IN_ARG_DECL, LV1_1_OUT_ARG_DECL
+#define LV1_6_IN_1_OUT_ARG_DECL LV1_6_IN_ARG_DECL, LV1_1_OUT_ARG_DECL
+#define LV1_7_IN_1_OUT_ARG_DECL LV1_7_IN_ARG_DECL, LV1_1_OUT_ARG_DECL
+#define LV1_8_IN_1_OUT_ARG_DECL LV1_8_IN_ARG_DECL, LV1_1_OUT_ARG_DECL
+
+#define LV1_0_IN_2_OUT_ARG_DECL                    LV1_2_OUT_ARG_DECL
+#define LV1_1_IN_2_OUT_ARG_DECL LV1_1_IN_ARG_DECL, LV1_2_OUT_ARG_DECL
+#define LV1_2_IN_2_OUT_ARG_DECL LV1_2_IN_ARG_DECL, LV1_2_OUT_ARG_DECL
+#define LV1_3_IN_2_OUT_ARG_DECL LV1_3_IN_ARG_DECL, LV1_2_OUT_ARG_DECL
+#define LV1_4_IN_2_OUT_ARG_DECL LV1_4_IN_ARG_DECL, LV1_2_OUT_ARG_DECL
+#define LV1_5_IN_2_OUT_ARG_DECL LV1_5_IN_ARG_DECL, LV1_2_OUT_ARG_DECL
+#define LV1_6_IN_2_OUT_ARG_DECL LV1_6_IN_ARG_DECL, LV1_2_OUT_ARG_DECL
+#define LV1_7_IN_2_OUT_ARG_DECL LV1_7_IN_ARG_DECL, LV1_2_OUT_ARG_DECL
+
+#define LV1_0_IN_3_OUT_ARG_DECL                    LV1_3_OUT_ARG_DECL
+#define LV1_1_IN_3_OUT_ARG_DECL LV1_1_IN_ARG_DECL, LV1_3_OUT_ARG_DECL
+#define LV1_2_IN_3_OUT_ARG_DECL LV1_2_IN_ARG_DECL, LV1_3_OUT_ARG_DECL
+#define LV1_3_IN_3_OUT_ARG_DECL LV1_3_IN_ARG_DECL, LV1_3_OUT_ARG_DECL
+#define LV1_4_IN_3_OUT_ARG_DECL LV1_4_IN_ARG_DECL, LV1_3_OUT_ARG_DECL
+#define LV1_5_IN_3_OUT_ARG_DECL LV1_5_IN_ARG_DECL, LV1_3_OUT_ARG_DECL
+#define LV1_6_IN_3_OUT_ARG_DECL LV1_6_IN_ARG_DECL, LV1_3_OUT_ARG_DECL
+#define LV1_7_IN_3_OUT_ARG_DECL LV1_7_IN_ARG_DECL, LV1_3_OUT_ARG_DECL
+
+#define LV1_0_IN_4_OUT_ARG_DECL                    LV1_4_OUT_ARG_DECL
+#define LV1_1_IN_4_OUT_ARG_DECL LV1_1_IN_ARG_DECL, LV1_4_OUT_ARG_DECL
+#define LV1_2_IN_4_OUT_ARG_DECL LV1_2_IN_ARG_DECL, LV1_4_OUT_ARG_DECL
+#define LV1_3_IN_4_OUT_ARG_DECL LV1_3_IN_ARG_DECL, LV1_4_OUT_ARG_DECL
+#define LV1_4_IN_4_OUT_ARG_DECL LV1_4_IN_ARG_DECL, LV1_4_OUT_ARG_DECL
+#define LV1_5_IN_4_OUT_ARG_DECL LV1_5_IN_ARG_DECL, LV1_4_OUT_ARG_DECL
+#define LV1_6_IN_4_OUT_ARG_DECL LV1_6_IN_ARG_DECL, LV1_4_OUT_ARG_DECL
+#define LV1_7_IN_4_OUT_ARG_DECL LV1_7_IN_ARG_DECL, LV1_4_OUT_ARG_DECL
+
+#define LV1_0_IN_5_OUT_ARG_DECL                    LV1_5_OUT_ARG_DECL
+#define LV1_1_IN_5_OUT_ARG_DECL LV1_1_IN_ARG_DECL, LV1_5_OUT_ARG_DECL
+#define LV1_2_IN_5_OUT_ARG_DECL LV1_2_IN_ARG_DECL, LV1_5_OUT_ARG_DECL
+#define LV1_3_IN_5_OUT_ARG_DECL LV1_3_IN_ARG_DECL, LV1_5_OUT_ARG_DECL
+#define LV1_4_IN_5_OUT_ARG_DECL LV1_4_IN_ARG_DECL, LV1_5_OUT_ARG_DECL
+#define LV1_5_IN_5_OUT_ARG_DECL LV1_5_IN_ARG_DECL, LV1_5_OUT_ARG_DECL
+#define LV1_6_IN_5_OUT_ARG_DECL LV1_6_IN_ARG_DECL, LV1_5_OUT_ARG_DECL
+#define LV1_7_IN_5_OUT_ARG_DECL LV1_7_IN_ARG_DECL, LV1_5_OUT_ARG_DECL
+
+#define LV1_0_IN_6_OUT_ARG_DECL                    LV1_6_OUT_ARG_DECL
+#define LV1_1_IN_6_OUT_ARG_DECL LV1_1_IN_ARG_DECL, LV1_6_OUT_ARG_DECL
+#define LV1_2_IN_6_OUT_ARG_DECL LV1_2_IN_ARG_DECL, LV1_6_OUT_ARG_DECL
+#define LV1_3_IN_6_OUT_ARG_DECL LV1_3_IN_ARG_DECL, LV1_6_OUT_ARG_DECL
+#define LV1_4_IN_6_OUT_ARG_DECL LV1_4_IN_ARG_DECL, LV1_6_OUT_ARG_DECL
+#define LV1_5_IN_6_OUT_ARG_DECL LV1_5_IN_ARG_DECL, LV1_6_OUT_ARG_DECL
+#define LV1_6_IN_6_OUT_ARG_DECL LV1_6_IN_ARG_DECL, LV1_6_OUT_ARG_DECL
+#define LV1_7_IN_6_OUT_ARG_DECL LV1_7_IN_ARG_DECL, LV1_6_OUT_ARG_DECL
+
+#define LV1_0_IN_7_OUT_ARG_DECL                    LV1_7_OUT_ARG_DECL
+#define LV1_1_IN_7_OUT_ARG_DECL LV1_1_IN_ARG_DECL, LV1_7_OUT_ARG_DECL
+#define LV1_2_IN_7_OUT_ARG_DECL LV1_2_IN_ARG_DECL, LV1_7_OUT_ARG_DECL
+#define LV1_3_IN_7_OUT_ARG_DECL LV1_3_IN_ARG_DECL, LV1_7_OUT_ARG_DECL
+#define LV1_4_IN_7_OUT_ARG_DECL LV1_4_IN_ARG_DECL, LV1_7_OUT_ARG_DECL
+#define LV1_5_IN_7_OUT_ARG_DECL LV1_5_IN_ARG_DECL, LV1_7_OUT_ARG_DECL
+#define LV1_6_IN_7_OUT_ARG_DECL LV1_6_IN_ARG_DECL, LV1_7_OUT_ARG_DECL
+#define LV1_7_IN_7_OUT_ARG_DECL LV1_7_IN_ARG_DECL, LV1_7_OUT_ARG_DECL
+
+#define LV1_1_IN_ARGS in_1
+#define LV1_2_IN_ARGS LV1_1_IN_ARGS, in_2
+#define LV1_3_IN_ARGS LV1_2_IN_ARGS, in_3
+#define LV1_4_IN_ARGS LV1_3_IN_ARGS, in_4
+#define LV1_5_IN_ARGS LV1_4_IN_ARGS, in_5
+#define LV1_6_IN_ARGS LV1_5_IN_ARGS, in_6
+#define LV1_7_IN_ARGS LV1_6_IN_ARGS, in_7
+#define LV1_8_IN_ARGS LV1_7_IN_ARGS, in_8
+
+#define LV1_1_OUT_ARGS out_1
+#define LV1_2_OUT_ARGS LV1_1_OUT_ARGS, out_2
+#define LV1_3_OUT_ARGS LV1_2_OUT_ARGS, out_3
+#define LV1_4_OUT_ARGS LV1_3_OUT_ARGS, out_4
+#define LV1_5_OUT_ARGS LV1_4_OUT_ARGS, out_5
+#define LV1_6_OUT_ARGS LV1_5_OUT_ARGS, out_6
+#define LV1_7_OUT_ARGS LV1_6_OUT_ARGS, out_7
+
+#define LV1_0_IN_0_OUT_ARGS
+#define LV1_1_IN_0_OUT_ARGS LV1_1_IN_ARGS
+#define LV1_2_IN_0_OUT_ARGS LV1_2_IN_ARGS
+#define LV1_3_IN_0_OUT_ARGS LV1_3_IN_ARGS
+#define LV1_4_IN_0_OUT_ARGS LV1_4_IN_ARGS
+#define LV1_5_IN_0_OUT_ARGS LV1_5_IN_ARGS
+#define LV1_6_IN_0_OUT_ARGS LV1_6_IN_ARGS
+#define LV1_7_IN_0_OUT_ARGS LV1_7_IN_ARGS
+
+#define LV1_0_IN_1_OUT_ARGS                LV1_1_OUT_ARGS
+#define LV1_1_IN_1_OUT_ARGS LV1_1_IN_ARGS, LV1_1_OUT_ARGS
+#define LV1_2_IN_1_OUT_ARGS LV1_2_IN_ARGS, LV1_1_OUT_ARGS
+#define LV1_3_IN_1_OUT_ARGS LV1_3_IN_ARGS, LV1_1_OUT_ARGS
+#define LV1_4_IN_1_OUT_ARGS LV1_4_IN_ARGS, LV1_1_OUT_ARGS
+#define LV1_5_IN_1_OUT_ARGS LV1_5_IN_ARGS, LV1_1_OUT_ARGS
+#define LV1_6_IN_1_OUT_ARGS LV1_6_IN_ARGS, LV1_1_OUT_ARGS
+#define LV1_7_IN_1_OUT_ARGS LV1_7_IN_ARGS, LV1_1_OUT_ARGS
+#define LV1_8_IN_1_OUT_ARGS LV1_8_IN_ARGS, LV1_1_OUT_ARGS
+
+#define LV1_0_IN_2_OUT_ARGS                LV1_2_OUT_ARGS
+#define LV1_1_IN_2_OUT_ARGS LV1_1_IN_ARGS, LV1_2_OUT_ARGS
+#define LV1_2_IN_2_OUT_ARGS LV1_2_IN_ARGS, LV1_2_OUT_ARGS
+#define LV1_3_IN_2_OUT_ARGS LV1_3_IN_ARGS, LV1_2_OUT_ARGS
+#define LV1_4_IN_2_OUT_ARGS LV1_4_IN_ARGS, LV1_2_OUT_ARGS
+#define LV1_5_IN_2_OUT_ARGS LV1_5_IN_ARGS, LV1_2_OUT_ARGS
+#define LV1_6_IN_2_OUT_ARGS LV1_6_IN_ARGS, LV1_2_OUT_ARGS
+#define LV1_7_IN_2_OUT_ARGS LV1_7_IN_ARGS, LV1_2_OUT_ARGS
+
+#define LV1_0_IN_3_OUT_ARGS                LV1_3_OUT_ARGS
+#define LV1_1_IN_3_OUT_ARGS LV1_1_IN_ARGS, LV1_3_OUT_ARGS
+#define LV1_2_IN_3_OUT_ARGS LV1_2_IN_ARGS, LV1_3_OUT_ARGS
+#define LV1_3_IN_3_OUT_ARGS LV1_3_IN_ARGS, LV1_3_OUT_ARGS
+#define LV1_4_IN_3_OUT_ARGS LV1_4_IN_ARGS, LV1_3_OUT_ARGS
+#define LV1_5_IN_3_OUT_ARGS LV1_5_IN_ARGS, LV1_3_OUT_ARGS
+#define LV1_6_IN_3_OUT_ARGS LV1_6_IN_ARGS, LV1_3_OUT_ARGS
+#define LV1_7_IN_3_OUT_ARGS LV1_7_IN_ARGS, LV1_3_OUT_ARGS
+
+#define LV1_0_IN_4_OUT_ARGS                LV1_4_OUT_ARGS
+#define LV1_1_IN_4_OUT_ARGS LV1_1_IN_ARGS, LV1_4_OUT_ARGS
+#define LV1_2_IN_4_OUT_ARGS LV1_2_IN_ARGS, LV1_4_OUT_ARGS
+#define LV1_3_IN_4_OUT_ARGS LV1_3_IN_ARGS, LV1_4_OUT_ARGS
+#define LV1_4_IN_4_OUT_ARGS LV1_4_IN_ARGS, LV1_4_OUT_ARGS
+#define LV1_5_IN_4_OUT_ARGS LV1_5_IN_ARGS, LV1_4_OUT_ARGS
+#define LV1_6_IN_4_OUT_ARGS LV1_6_IN_ARGS, LV1_4_OUT_ARGS
+#define LV1_7_IN_4_OUT_ARGS LV1_7_IN_ARGS, LV1_4_OUT_ARGS
+
+#define LV1_0_IN_5_OUT_ARGS                LV1_5_OUT_ARGS
+#define LV1_1_IN_5_OUT_ARGS LV1_1_IN_ARGS, LV1_5_OUT_ARGS
+#define LV1_2_IN_5_OUT_ARGS LV1_2_IN_ARGS, LV1_5_OUT_ARGS
+#define LV1_3_IN_5_OUT_ARGS LV1_3_IN_ARGS, LV1_5_OUT_ARGS
+#define LV1_4_IN_5_OUT_ARGS LV1_4_IN_ARGS, LV1_5_OUT_ARGS
+#define LV1_5_IN_5_OUT_ARGS LV1_5_IN_ARGS, LV1_5_OUT_ARGS
+#define LV1_6_IN_5_OUT_ARGS LV1_6_IN_ARGS, LV1_5_OUT_ARGS
+#define LV1_7_IN_5_OUT_ARGS LV1_7_IN_ARGS, LV1_5_OUT_ARGS
+
+#define LV1_0_IN_6_OUT_ARGS                LV1_6_OUT_ARGS
+#define LV1_1_IN_6_OUT_ARGS LV1_1_IN_ARGS, LV1_6_OUT_ARGS
+#define LV1_2_IN_6_OUT_ARGS LV1_2_IN_ARGS, LV1_6_OUT_ARGS
+#define LV1_3_IN_6_OUT_ARGS LV1_3_IN_ARGS, LV1_6_OUT_ARGS
+#define LV1_4_IN_6_OUT_ARGS LV1_4_IN_ARGS, LV1_6_OUT_ARGS
+#define LV1_5_IN_6_OUT_ARGS LV1_5_IN_ARGS, LV1_6_OUT_ARGS
+#define LV1_6_IN_6_OUT_ARGS LV1_6_IN_ARGS, LV1_6_OUT_ARGS
+#define LV1_7_IN_6_OUT_ARGS LV1_7_IN_ARGS, LV1_6_OUT_ARGS
+
+#define LV1_0_IN_7_OUT_ARGS                LV1_7_OUT_ARGS
+#define LV1_1_IN_7_OUT_ARGS LV1_1_IN_ARGS, LV1_7_OUT_ARGS
+#define LV1_2_IN_7_OUT_ARGS LV1_2_IN_ARGS, LV1_7_OUT_ARGS
+#define LV1_3_IN_7_OUT_ARGS LV1_3_IN_ARGS, LV1_7_OUT_ARGS
+#define LV1_4_IN_7_OUT_ARGS LV1_4_IN_ARGS, LV1_7_OUT_ARGS
+#define LV1_5_IN_7_OUT_ARGS LV1_5_IN_ARGS, LV1_7_OUT_ARGS
+#define LV1_6_IN_7_OUT_ARGS LV1_6_IN_ARGS, LV1_7_OUT_ARGS
+#define LV1_7_IN_7_OUT_ARGS LV1_7_IN_ARGS, LV1_7_OUT_ARGS
+
+/*
+ * This LV1_CALL() macro is for use by callers.  It expands into an
+ * inline call wrapper and an underscored HV call declaration.  The
+ * wrapper can be used to instrument the lv1 call interface.  The
+ * file lv1call.S defines its own LV1_CALL() macro to expand into
+ * the actual underscored call definition.
+ */
+
+#if !defined(LV1_CALL)
+#define LV1_CALL(name, in, out, num)                               \
+  extern s64 _lv1_##name(LV1_##in##_IN_##out##_OUT_ARG_DECL);      \
+  static inline int lv1_##name(LV1_##in##_IN_##out##_OUT_ARG_DECL) \
+    {return _lv1_##name(LV1_##in##_IN_##out##_OUT_ARGS);}
+#endif
+
+#endif /* !defined(__ASSEMBLY__) */
+
+/* lv1 call table */
+
+LV1_CALL(allocate_memory,                               4, 2,   0 )
+LV1_CALL(write_htab_entry,                              4, 0,   1 )
+LV1_CALL(construct_virtual_address_space,               3, 2,   2 )
+LV1_CALL(invalidate_htab_entries,                       5, 0,   3 )
+LV1_CALL(get_virtual_address_space_id_of_ppe,           1, 1,   4 )
+LV1_CALL(query_logical_partition_address_region_info,   1, 5,   6 )
+LV1_CALL(select_virtual_address_space,                  1, 0,   7 )
+LV1_CALL(pause,                                         1, 0,   9 )
+LV1_CALL(destruct_virtual_address_space,                1, 0,  10 )
+LV1_CALL(configure_irq_state_bitmap,                    3, 0,  11 )
+LV1_CALL(connect_irq_plug_ext,                          5, 0,  12 )
+LV1_CALL(release_memory,                                1, 0,  13 )
+LV1_CALL(disconnect_irq_plug_ext,                       3, 0,  17 )
+LV1_CALL(construct_event_receive_port,                  0, 1,  18 )
+LV1_CALL(destruct_event_receive_port,                   1, 0,  19 )
+LV1_CALL(send_event_locally,                            1, 0,  24 )
+LV1_CALL(end_of_interrupt,                              1, 0,  27 )
+LV1_CALL(connect_irq_plug,                              2, 0,  28 )
+LV1_CALL(disconnect_irq_plug,                           1, 0,  29 )
+LV1_CALL(end_of_interrupt_ext,                          3, 0,  30 )
+LV1_CALL(did_update_interrupt_mask,                     2, 0,  31 )
+LV1_CALL(shutdown_logical_partition,                    1, 0,  44 )
+LV1_CALL(destruct_logical_spe,                          1, 0,  54 )
+LV1_CALL(construct_logical_spe,                         7, 6,  57 )
+LV1_CALL(set_spe_interrupt_mask,                        3, 0,  61 )
+LV1_CALL(set_spe_transition_notifier,                   3, 0,  64 )
+LV1_CALL(disable_logical_spe,                           2, 0,  65 )
+LV1_CALL(clear_spe_interrupt_status,                    4, 0,  66 )
+LV1_CALL(get_spe_interrupt_status,                      2, 1,  67 )
+LV1_CALL(get_logical_ppe_id,                            0, 1,  69 )
+LV1_CALL(set_interrupt_mask,                            5, 0,  73 )
+LV1_CALL(get_logical_partition_id,                      0, 1,  74 )
+LV1_CALL(configure_execution_time_variable,             1, 0,  77 )
+LV1_CALL(get_spe_irq_outlet,                            2, 1,  78 )
+LV1_CALL(set_spe_privilege_state_area_1_register,       3, 0,  79 )
+LV1_CALL(create_repository_node,                        6, 0,  90 )
+LV1_CALL(get_repository_node_value,                     5, 2,  91 )
+LV1_CALL(modify_repository_node_value,                  6, 0,  92 )
+LV1_CALL(remove_repository_node,                        4, 0,  93 )
+LV1_CALL(read_htab_entries,                             2, 5,  95 )
+LV1_CALL(set_dabr,                                      2, 0,  96 )
+LV1_CALL(get_total_execution_time,                      2, 1, 103 )
+LV1_CALL(construct_io_irq_outlet,                       1, 1, 120 )
+LV1_CALL(destruct_io_irq_outlet,                        1, 0, 121 )
+LV1_CALL(map_htab,                                      1, 1, 122 )
+LV1_CALL(unmap_htab,                                    1, 0, 123 )
+LV1_CALL(get_version_info,                              0, 1, 127 )
+LV1_CALL(insert_htab_entry,                             6, 3, 158 )
+LV1_CALL(read_virtual_uart,                             3, 1, 162 )
+LV1_CALL(write_virtual_uart,                            3, 1, 163 )
+LV1_CALL(set_virtual_uart_param,                        3, 0, 164 )
+LV1_CALL(get_virtual_uart_param,                        2, 1, 165 )
+LV1_CALL(configure_virtual_uart_irq,                    1, 1, 166 )
+LV1_CALL(open_device,                                   3, 0, 170 )
+LV1_CALL(close_device,                                  2, 0, 171 )
+LV1_CALL(map_device_mmio_region,                        5, 1, 172 )
+LV1_CALL(unmap_device_mmio_region,                      3, 0, 173 )
+LV1_CALL(allocate_device_dma_region,                    5, 1, 174 )
+LV1_CALL(free_device_dma_region,                        3, 0, 175 )
+LV1_CALL(map_device_dma_region,                         6, 0, 176 )
+LV1_CALL(unmap_device_dma_region,                       4, 0, 177 )
+LV1_CALL(net_add_multicast_address,                     4, 0, 185 )
+LV1_CALL(net_remove_multicast_address,                  4, 0, 186 )
+LV1_CALL(net_start_tx_dma,                              4, 0, 187 )
+LV1_CALL(net_stop_tx_dma,                               3, 0, 188 )
+LV1_CALL(net_start_rx_dma,                              4, 0, 189 )
+LV1_CALL(net_stop_rx_dma,                               3, 0, 190 )
+LV1_CALL(net_set_interrupt_status_indicator,            4, 0, 191 )
+LV1_CALL(net_set_interrupt_mask,                        4, 0, 193 )
+LV1_CALL(net_control,                                   6, 2, 194 )
+LV1_CALL(connect_interrupt_event_receive_port,          4, 0, 197 )
+LV1_CALL(disconnect_interrupt_event_receive_port,       4, 0, 198 )
+LV1_CALL(get_spe_all_interrupt_statuses,                1, 1, 199 )
+LV1_CALL(deconfigure_virtual_uart_irq,                  0, 0, 202 )
+LV1_CALL(enable_logical_spe,                            2, 0, 207 )
+LV1_CALL(gpu_open,                                      1, 0, 210 )
+LV1_CALL(gpu_close,                                     0, 0, 211 )
+LV1_CALL(gpu_device_map,                                1, 2, 212 )
+LV1_CALL(gpu_device_unmap,                              1, 0, 213 )
+LV1_CALL(gpu_memory_allocate,                           5, 2, 214 )
+LV1_CALL(gpu_memory_free,                               1, 0, 216 )
+LV1_CALL(gpu_context_allocate,                          2, 5, 217 )
+LV1_CALL(gpu_context_free,                              1, 0, 218 )
+LV1_CALL(gpu_context_iomap,                             5, 0, 221 )
+LV1_CALL(gpu_context_attribute,                         6, 0, 225 )
+LV1_CALL(gpu_context_intr,                              1, 1, 227 )
+LV1_CALL(gpu_attribute,                                 5, 0, 228 )
+LV1_CALL(get_rtc,                                       0, 2, 232 )
+LV1_CALL(set_ppe_periodic_tracer_frequency,             1, 0, 240 )
+LV1_CALL(start_ppe_periodic_tracer,                     5, 0, 241 )
+LV1_CALL(stop_ppe_periodic_tracer,                      1, 1, 242 )
+LV1_CALL(storage_read,                                  6, 1, 245 )
+LV1_CALL(storage_write,                                 6, 1, 246 )
+LV1_CALL(storage_send_device_command,                   6, 1, 248 )
+LV1_CALL(storage_get_async_status,                      1, 2, 249 )
+LV1_CALL(storage_check_async_status,                    2, 1, 254 )
+LV1_CALL(panic,                                         1, 0, 255 )
+LV1_CALL(construct_lpm,                                 6, 3, 140 )
+LV1_CALL(destruct_lpm,                                  1, 0, 141 )
+LV1_CALL(start_lpm,                                     1, 0, 142 )
+LV1_CALL(stop_lpm,                                      1, 1, 143 )
+LV1_CALL(copy_lpm_trace_buffer,                         3, 1, 144 )
+LV1_CALL(add_lpm_event_bookmark,                        5, 0, 145 )
+LV1_CALL(delete_lpm_event_bookmark,                     3, 0, 146 )
+LV1_CALL(set_lpm_interrupt_mask,                        3, 1, 147 )
+LV1_CALL(get_lpm_interrupt_status,                      1, 1, 148 )
+LV1_CALL(set_lpm_general_control,                       5, 2, 149 )
+LV1_CALL(set_lpm_interval,                              3, 1, 150 )
+LV1_CALL(set_lpm_trigger_control,                       3, 1, 151 )
+LV1_CALL(set_lpm_counter_control,                       4, 1, 152 )
+LV1_CALL(set_lpm_group_control,                         3, 1, 153 )
+LV1_CALL(set_lpm_debug_bus_control,                     3, 1, 154 )
+LV1_CALL(set_lpm_counter,                               5, 2, 155 )
+LV1_CALL(set_lpm_signal,                                7, 0, 156 )
+LV1_CALL(set_lpm_spr_trigger,                           2, 0, 157 )
+
+#endif
