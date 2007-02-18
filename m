Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ED981DDF27
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 12:17:14 +1100 (EST)
Received: from outbound3-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound3-blu-R.bigfish.com (Postfix) with ESMTP id 729C37B2310
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:11 +0000 (UTC)
Received: from mail75-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound3-blu.bigfish.com (Postfix) with ESMTP id 59F1E84004C
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:11 +0000 (UTC)
Received: from mail75-blu (localhost.localdomain [127.0.0.1])
	by mail75-blu-R.bigfish.com (Postfix) with ESMTP id 3AC91B901E8
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:11 +0000 (UTC)
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail75-blu.bigfish.com (Postfix) with ESMTP id DF0EA1A60053
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:10 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com
	[43.130.1.111])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id l1I1H9hk014908
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:09 GMT
Received: from USSDIXIM01.am.sony.com (ussdixim01.am.sony.com [43.130.140.33])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id
	l1I1H9b2001206
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:09 GMT
Message-ID: <45D7A914.4040000@am.sony.com>
Date: Sat, 17 Feb 2007 17:17:08 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [RFC 3/3] zImage: Exception vector support
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add SMP exception vector support to the powerpc zImage bootwrapper.  For
platforms which have entry points in the vector table.  This implements
SMP entry via the system reset vector.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/boot/head.S       |   96 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/zImage.lds.S |    2 
 2 files changed, 98 insertions(+)

--- /dev/null
+++ ps3-linux-dev/arch/powerpc/boot/head.S
@@ -0,0 +1,96 @@
+/*
+ *  zImage exception vector entry.
+ *
+ *  Copyright (C) 2007 Sony Computer Entertainment Inc.
+ *  Copyright 2007 Sony Corp.
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
+#include "ppc_asm.h"
+
+/*
+ * __system_reset_entry - For platforms entering at the reset vector.
+ *
+ * __system_reset_entry runs the bootwrapper code on cpu 0 to prepare the
+ * wrapped kernel image.  Cpu 0 then enters the kernel at the end of the
+ * bootwrapper code.  .secondary_start sends secondary cpus to
+ * smp_secondary_hold() to wait until the bootwrapper code is finished
+ * running.  When signled, secondary cpus enter the kernel directly from
+ * smp_secondary_hold().
+ *
+ * This implementation supports only one secondary cpu.
+ *
+ * For the PS3 first stage entry the MMU is off and the bootwrapper image
+ * has been loaded to lpar address zero.  The bootwrapper is entered at
+ * 0x100 (system reset) by both proceesor threads.
+ */
+
+	.section .vectors,"ax"
+	. = 0x100
+	.globl __system_reset_entry
+__system_reset_entry:
+
+	/* switch to 32-bit mode */
+
+	mfmsr	r9
+	clrldi	r9,r9,1
+	mtmsrd	r9
+	nop
+
+	/* test thread number and branch */
+
+	mfspr	r3, 0x88
+	cntlzw.	r3, r3
+	beq	__primary_start
+
+__secondary_start:
+
+	/* setup secondary's stack */
+
+	lis	r1, __wrapper_stack_1@ha
+	addi	r1, r1, __wrapper_stack_1@l
+	subi	r1, r1, 16
+
+	xor	r4, r4, r4
+	xor	r5, r5, r5
+	b	smp_secondary_hold
+
+__primary_start:
+
+	/* setup primary's stack */
+
+	lis	r1, __wrapper_stack_0@ha
+	addi	r1, r1, __wrapper_stack_0@l
+	subi	r1, r1, 16
+
+	xor	r3, r3, r3
+	xor	r4, r4, r4
+	xor	r5, r5, r5
+	b	_zimage_start
+
+	.section .bss
+	.align 16;
+	. = . + 4096
+__wrapper_stack_0:
+
+/*
+ * The bss is cleared in crt0, so put a tiny stack in the data
+ * section for the secondary cpu.
+ */
+
+	.section .data
+	.align 16;
+	. = . + 128
+__wrapper_stack_1:
--- ps3-linux-dev.orig/arch/powerpc/boot/zImage.lds.S
+++ ps3-linux-dev/arch/powerpc/boot/zImage.lds.S
@@ -2,6 +2,8 @@ OUTPUT_ARCH(powerpc:common)
 ENTRY(_zimage_start)
 SECTIONS
 {
+  .vectors 0 : { *(.vectors) }
+
   . = (4*1024*1024);
   _start = .;
   .text      :
