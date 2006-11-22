Return-Path: <SRS0+0ad9d235d7a363f6c08f+1186+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FD6567BCD
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 19:00:22 +1100 (EST)
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1Gmn1k-0003Dr-3w
	for linuxppc-dev@ozlabs.org; Wed, 22 Nov 2006 03:00:19 -0500
Subject: [RFC] Firefox/PPC64 support
From: David Woodhouse <dwmw2@infradead.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 22 Nov 2006 08:00:13 +0000
Message-Id: <1164182413.19448.108.camel@pmac.infradead.org>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My understanding of the PPC64 C++ ABI is largely empirical. Could
someone else glance over the attached patch which adds ppc64 support to
firefox?

Two functions are provided. The first (XPTC_InvokeByIndex) invokes a
virtual method of a C++ object. It's given the index of the method in
the vtable, and a list of { type, value } tuples which must be dumped
into the appropriate registers (or stack slots) as parameters.

The second (SharedStub) performs the opposite function -- it's called
from C++ and fills in the { type, value } tuples from the register file
and the stack, before dispatching to the called function.

Questions I asked myself as I was doing it (other than the obvious 'why
in hell am I doing this?') were along the lines of...

1. Do my stored under the stack in SharedStub() fit in the red zone?
   That's 288 bytes, isn't it?

2. How do I make gdb accept that SharedStub() and XPTC_InvokeByIndex()
   are actually functions and not do stuff like this...

	(gdb) disass XPTC_InvokeByIndex
	No function contains specified address.
	(gdb) disass &XPTC_InvokeByIndex
	Dump of assembler code for function XPTC_InvokeByIndex:
	0x000004000026bed8 <XPTC_InvokeByIndex+0>:      .long 0x400
	0x000004000026bedc <XPTC_InvokeByIndex+4>:      .long 0x205e68
	0x000004000026bee0 <XPTC_InvokeByIndex+8>:      .long 0x400
	0x000004000026bee4 <XPTC_InvokeByIndex+12>:     .long 0x275e80

3. Did I get the argument placing right? It seems work correctly with
   the test program in the Mozilla build tree, and firefox itself seems
   to work, but is there an esoteric case I screwed up?

   Am I right in thinking that it goes like this...
	Arg1-8 in registers r3-r10 or f1-f8 as appropriate.
 	Arg 9 at 112(r1) or in f9
	 ...
	Arg 13 at 152(r1) or in f13 
        Arg 14 at 160(r1) (or 164(r1) if it's float)
	Arg 15 at 168(r1) (or 172, etc.)

   As far as I can tell my implementation ought to be off-by-one in the
   use of fp regs, but seems to be working correctly and args come out
   in the right place. That isn't because a bug in my SharedStub
   complements a bug in my XPTC_InvokeByIndex -- the test case only uses
   the latter.


diff -uNr --exclude '*~' --exclude '*.ii' --exclude 'foo*' --exclude '*.o' --exclude '*tmp*' --exclude '*.ppc64' mozilla.orig/xpcom/reflect/xptcall/src/md/unix/Makefile.in mozilla/xpcom/reflect/xptcall/src/md/unix/Makefile.in
--- mozilla.orig/xpcom/reflect/xptcall/src/md/unix/Makefile.in	2006-11-21 17:09:28.000000000 +0000
+++ mozilla/xpcom/reflect/xptcall/src/md/unix/Makefile.in	2006-11-20 10:13:38.000000000 +0000
@@ -267,6 +267,11 @@
 ASFILES		:= xptcinvoke_asm_ppc_linux.s xptcstubs_asm_ppc_linux.s
 AS		:= $(CC) -c -x assembler-with-cpp
 endif
+ifeq ($(OS_ARCH)$(OS_TEST),Linuxppc64)
+CPPSRCS		:= xptcinvoke_ppc64_linux.cpp xptcstubs_ppc64_linux.cpp
+ASFILES		:= xptcinvoke_asm_ppc64_linux.s xptcstubs_asm_ppc64_linux.s
+AS		:= $(CC) -c -x assembler-with-cpp
+endif
 
 #
 # NetBSD/PPC
diff -uNr --exclude '*~' --exclude '*.ii' --exclude 'foo*' --exclude '*.o' --exclude '*tmp*' --exclude '*.ppc64' mozilla.orig/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_asm_ppc64_linux.s mozilla/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_asm_ppc64_linux.s
--- mozilla.orig/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_asm_ppc64_linux.s	1970-01-01 01:00:00.000000000 +0100
+++ mozilla/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_asm_ppc64_linux.s	2006-11-21 14:01:45.000000000 +0000
@@ -0,0 +1,148 @@
+// -*- Mode: Asm -*-
+//
+// The contents of this file are subject to the Netscape Public
+// License Version 1.1 (the "License"); you may not use this file
+// except in compliance with the License. You may obtain a copy of
+// the License at http://www.mozilla.org/NPL/
+//
+// Software distributed under the License is distributed on an "AS
+// IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
+// implied. See the License for the specific language governing
+// rights and limitations under the License.
+//
+// The Original Code is mozilla.org code.
+//
+// The Initial Developer of the Original Code is Netscape
+// Communications Corporation.  Portions created by Netscape are
+// Copyright (C) 1999 Netscape Communications Corporation. All
+// Rights Reserved.
+//
+// Contributor(s):
+//   Franz.Sirl-kernel@lauterbach.com (Franz Sirl)
+//   beard@netscape.com (Patrick Beard)
+//   waterson@netscape.com (Chris Waterson)
+//
+
+.set r0,0; .set r1,1; .set r2,2; .set r3,3; .set r4,4
+.set r5,5; .set r6,6; .set r7,7; .set r8,8; .set r9,9
+.set r10,10; .set r11,11; .set r12,12; .set r13,13; .set r14,14
+.set r15,15; .set r16,16; .set r17,17; .set r18,18; .set r19,19
+.set r20,20; .set r21,21; .set r22,22; .set r23,23; .set r24,24
+.set r25,25; .set r26,26; .set r27,27; .set r28,28; .set r29,29
+.set r30,30; .set r31,31
+.set f0,0; .set f1,1; .set f2,2; .set f3,3; .set f4,4
+.set f5,5; .set f6,6; .set f7,7; .set f8,8; .set f9,9
+.set f10,10; .set f11,11; .set f12,12; .set f13,13; .set f14,14
+.set f15,15; .set f16,16; .set f17,17; .set f18,18; .set f19,19
+.set f20,20; .set f21,21; .set f22,22; .set f23,23; .set f24,24
+.set f25,25; .set f26,26; .set f27,27; .set f28,28; .set f29,29
+.set f30,30; .set f31,31
+
+
+//
+// XPTC_InvokeByIndex(nsISupports* that, PRUint32 methodIndex,
+//                    PRUint32 paramCount, nsXPTCVariant* params)
+//
+
+	.section ".toc","aw"
+        .section ".text"
+	.align 2
+	.globl XPTC_InvokeByIndex
+	.section ".opd","aw"
+	.align 3
+XPTC_InvokeByIndex:
+	.quad   .XPTC_InvokeByIndex,.TOC.@tocbase
+	.previous
+	.type  XPTC_InvokeByIndex,@function
+.XPTC_InvokeByIndex:
+        mflr	0
+	std	0,16(r1)
+	
+        std	r28,-32(r1)
+        std	r29,-24(r1)
+	std	r30,-16(r1)
+        std	r31,-8(r1)
+
+	mr	r29,r3			// Save 'that' in r29
+	mr	r30,r4			// Save 'methodIndex' in r30
+	mr	r31,r1			// Save old frame
+
+	// Allocate stack frame with space for params
+	
+	sldi	r28,r5,3		// Max. 8 bytes per parameter
+	addi	r28,r28,128+(24*8)	// Standard frame, 15 dwords for GP/FP, 4 for r28-r31
+	neg	r28,r28
+	stdux	r1,r1,r28
+
+	
+	addi	r28,r1,112		// Stack parameter area.
+
+
+	// Call invoke_copy_to_stack(PRUint64* gpregs, double* fpregs,
+        //			     PRUint32 paramCount, nsXPTCVariant* s, 
+        //			     PRUint64* d))
+	
+	// r5, r6 are passed through intact (paramCount, params)
+	// r7 (d) has to be r1+112 -- where parameters are passed on the stack.
+	// r3, r4 are above that, easier to address from r31 than from r1
+
+	subi	r3,r31,(24*8)
+	subi	r4,r31,(17*8)
+	addi	r7,r1,112
+        bl	invoke_copy_to_stack
+
+	// Set up to invoke function
+	
+        ld	r9,0(r29)		// vtable (r29 is 'that')
+        mr	r3,r29		// self is first arg, obviously
+
+	sldi	r30,r30,3	// Find function descriptor 
+	add	r9,r9,r30
+        ld	r9,0(r9)
+	
+        ld	r0,0(r9)	// Actual address from fd.
+        std	r2,40(r1)	// Save r2 (TOC pointer)
+
+        mtctr	0
+        ld	r11,16(r9)	// Environment pointer from fd.
+        ld	r2,8(r9)	// TOC pointer from fd.
+
+	// Load FP and GP registers as required
+        ld	r4, -(24*8)(r31) 
+        ld	r5, -(23*8)(r31) 
+        ld	r6, -(22*8)(r31) 
+        ld	r7, -(21*8)(r31) 
+        ld	r8, -(20*8)(r31) 
+        ld	r9, -(19*8)(r31) 
+        ld	r10, -(18*8)(r31) 
+
+        lfd	f1, -(17*8)(r31)
+        lfd	f2, -(16*8)(r31)
+        lfd	f3, -(15*8)(r31)
+        lfd	f4, -(14*8)(r31)
+        lfd	f5, -(13*8)(r31)
+        lfd	f6, -(12*8)(r31)
+        lfd	f7, -(11*8)(r31)
+        lfd	f8, -(10*8)(r31)
+        lfd	f9, -(9*8)(r31)
+        lfd	f10, -(8*8)(r31)
+        lfd	f11, -(7*8)(r31)
+        lfd	f12, -(6*8)(r31)
+        lfd	f13, -(5*8)(r31)
+
+        bctrl			// Do it
+
+        ld	r2,40(r1)	// Load our own TOC pointer
+        ld	r1,0(r1)	// Revert stack frame
+        ld	0,16(r1)	// Reload lr
+        ld	28,-32(r1)	// Restore NVGPRS
+        ld	29,-24(r1)
+        ld	30,-16(r1)
+        ld	31,-8(r1)
+        mtlr	0
+        blr
+
+	.size   XPTC_InvokeByIndex,.-.XPTC_InvokeByIndex
+
+	/* Magic indicating no need for an executable stack */
+	.section .note.GNU-stack, "", @progbits ; .previous
diff -uNr --exclude '*~' --exclude '*.ii' --exclude 'foo*' --exclude '*.o' --exclude '*tmp*' --exclude '*.ppc64' mozilla.orig/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_ppc64_linux.cpp mozilla/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_ppc64_linux.cpp
--- mozilla.orig/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_ppc64_linux.cpp	1970-01-01 01:00:00.000000000 +0100
+++ mozilla/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_ppc64_linux.cpp	2006-11-21 17:00:06.000000000 +0000
@@ -0,0 +1,132 @@
+/* -*- Mode: C; tab-width: 8; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
+/* ***** BEGIN LICENSE BLOCK *****
+ * Version: MPL 1.1/GPL 2.0/LGPL 2.1
+ *
+ * The contents of this file are subject to the Mozilla Public License Version
+ * 1.1 (the "License"); you may not use this file except in compliance with
+ * the License. You may obtain a copy of the License at
+ * http://www.mozilla.org/MPL/
+ *
+ * Software distributed under the License is distributed on an "AS IS" basis,
+ * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
+ * for the specific language governing rights and limitations under the
+ * License.
+ *
+ * The Original Code is mozilla.org code.
+ *
+ * The Initial Developer of the Original Code is
+ * Netscape Communications Corporation.
+ * Portions created by the Initial Developer are Copyright (C) 1998
+ * the Initial Developer. All Rights Reserved.
+ *
+ * Contributor(s):
+ *   dwmw2@infradead.org (David Woodhouse)
+ *   Franz.Sirl-kernel@lauterbach.com (Franz Sirl)
+ *   beard@netscape.com (Patrick Beard)
+ *   waterson@netscape.com (Chris Waterson)
+ *
+ * Alternatively, the contents of this file may be used under the terms of
+ * either of the GNU General Public License Version 2 or later (the "GPL"),
+ * or the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
+ * in which case the provisions of the GPL or the LGPL are applicable instead
+ * of those above. If you wish to allow use of your version of this file only
+ * under the terms of either the GPL or the LGPL, and not to allow others to
+ * use your version of this file under the terms of the MPL, indicate your
+ * decision by deleting the provisions above and replace them with the notice
+ * and other provisions required by the GPL or the LGPL. If you do not delete
+ * the provisions above, a recipient may use your version of this file under
+ * the terms of any one of the MPL, the GPL or the LGPL.
+ *
+ * ***** END LICENSE BLOCK ***** */
+
+// Platform specific code to invoke XPCOM methods on native objects
+
+// The purpose of XPTC_InvokeByIndex() is to map a platform
+// independent call to the platform ABI. To do that,
+// XPTC_InvokeByIndex() has to determine the method to call via vtable
+// access. The parameters for the method are read from the
+// nsXPTCVariant* and prepared for the native ABI.
+
+#include <stdio.h>
+#include "xptcprivate.h"
+
+// 8 integral parameters are passed in registers, not including 'that'
+#define GPR_COUNT     7
+
+// 8 floating point parameters are passed in registers, floats are
+// promoted to doubles when passed in registers
+#define FPR_COUNT     13
+
+extern "C" PRUint32
+invoke_count_words(PRUint32 paramCount, nsXPTCVariant* s)
+{
+  return PRUint32(((paramCount * 2) + 3) & ~3);
+}
+
+extern "C" void
+invoke_copy_to_stack(PRUint64* gpregs,
+                     double* fpregs,
+                     PRUint32 paramCount,
+                     nsXPTCVariant* s, 
+                     PRUint64* d)
+{
+    PRUint64 gpr = 0;
+    PRUint64 fpr = 0;
+    PRUint64 tempu64;
+    PRUint64* od = d;
+    memset(gpregs, 0x5a, 8 * GPR_COUNT);
+    memset(fpregs, 0xa5, 8 * FPR_COUNT);
+    memset(d, 0, 6*8);
+    for(uint32 i = 0; i < paramCount; i++, s++) {
+        if(s->IsPtrData())
+            tempu64 = (PRUint64) s->ptr;
+        else {
+            switch(s->type) {
+            case nsXPTType::T_FLOAT:                                  break;
+            case nsXPTType::T_DOUBLE:                                 break;
+            case nsXPTType::T_I8:     tempu64 = s->val.i8;            break;
+            case nsXPTType::T_I16:    tempu64 = s->val.i16;           break;
+            case nsXPTType::T_I32:    tempu64 = s->val.i32;           break;
+            case nsXPTType::T_I64:    tempu64 = s->val.i64;           break;
+            case nsXPTType::T_U8:     tempu64 = s->val.u8;            break;
+            case nsXPTType::T_U16:    tempu64 = s->val.u16;           break;
+            case nsXPTType::T_U32:    tempu64 = s->val.u32;           break;
+            case nsXPTType::T_U64:    tempu64 = s->val.u64;           break;
+            case nsXPTType::T_BOOL:   tempu64 = s->val.b;             break;
+            case nsXPTType::T_CHAR:   tempu64 = s->val.c;             break;
+            case nsXPTType::T_WCHAR:  tempu64 = s->val.wc;            break;
+            default:                  tempu64 = (PRUint64) s->val.p;  break;
+            }
+        }
+
+        if (!s->IsPtrData() && s->type == nsXPTType::T_DOUBLE) {
+            if (i < FPR_COUNT)
+                fpregs[i]    = s->val.d;
+            else
+                *(double *)d = s->val.d;
+        }
+        else if (!s->IsPtrData() && s->type == nsXPTType::T_FLOAT) {
+            if (i < FPR_COUNT) {
+                fpregs[i]   = s->val.f; // if passed in registers, floats are promoted to doubles
+            } else {
+                float *p = (float *)d;
+                p++;
+                *p = s->val.f;
+            }
+        }
+        else {
+            if (i < GPR_COUNT)
+                gpregs[i] = tempu64;
+            else
+                *d          = tempu64;
+        }
+        if (i >= 7)
+            d++;
+    }
+}
+
+extern "C"
+XPTC_PUBLIC_API(nsresult)
+XPTC_InvokeByIndex(nsISupports* that, PRUint32 methodIndex,
+                   PRUint32 paramCount, nsXPTCVariant* params);
+
diff -uNr --exclude '*~' --exclude '*.ii' --exclude 'foo*' --exclude '*.o' --exclude '*tmp*' --exclude '*.ppc64' mozilla.orig/xpcom/reflect/xptcall/src/md/unix/xptcstubs_asm_ppc64_linux.s mozilla/xpcom/reflect/xptcall/src/md/unix/xptcstubs_asm_ppc64_linux.s
--- mozilla.orig/xpcom/reflect/xptcall/src/md/unix/xptcstubs_asm_ppc64_linux.s	1970-01-01 01:00:00.000000000 +0100
+++ mozilla/xpcom/reflect/xptcall/src/md/unix/xptcstubs_asm_ppc64_linux.s	2006-11-21 16:38:52.000000000 +0000
@@ -0,0 +1,104 @@
+// -*- Mode: Asm -*-
+//
+// The contents of this file are subject to the Netscape Public
+// License Version 1.1 (the "License"); you may not use this file
+// except in compliance with the License. You may obtain a copy of
+// the License at http://www.mozilla.org/NPL/
+//
+// Software distributed under the License is distributed on an "AS
+// IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
+// implied. See the License for the specific language governing
+// rights and limitations under the License.
+//
+// The Original Code is mozilla.org code.
+//
+// The Initial Developer of the Original Code is Netscape
+// Communications Corporation.  Portions created by Netscape are
+// Copyright (C) 1999 Netscape Communications Corporation. All
+// Rights Reserved.
+//
+// Contributor(s): 
+//   Franz.Sirl-kernel@lauterbach.com (Franz Sirl)
+//   beard@netscape.com (Patrick Beard)
+//   waterson@netscape.com (Chris Waterson)
+//
+
+.set r0,0; .set r1,1; .set RTOC,2; .set r3,3; .set r4,4
+.set r5,5; .set r6,6; .set r7,7; .set r8,8; .set r9,9
+.set r10,10; .set r11,11; .set r12,12; .set r13,13; .set r14,14
+.set r15,15; .set r16,16; .set r17,17; .set r18,18; .set r19,19
+.set r20,20; .set r21,21; .set r22,22; .set r23,23; .set r24,24
+.set r25,25; .set r26,26; .set r27,27; .set r28,28; .set r29,29
+.set r30,30; .set r31,31
+.set f0,0; .set f1,1; .set f2,2; .set f3,3; .set f4,4
+.set f5,5; .set f6,6; .set f7,7; .set f8,8; .set f9,9
+.set f10,10; .set f11,11; .set f12,12; .set f13,13; .set f14,14
+.set f15,15; .set f16,16; .set f17,17; .set f18,18; .set f19,19
+.set f20,20; .set f21,21; .set f22,22; .set f23,23; .set f24,24
+.set f25,25; .set f26,26; .set f27,27; .set f28,28; .set f29,29
+.set f30,30; .set f31,31
+
+        .section ".text"
+        .align 2
+	.globl SharedStub
+        .section        ".opd","aw"
+        .align 3
+
+SharedStub:
+        .quad   .SharedStub,.TOC.@tocbase
+        .previous
+      	.type  SharedStub,@function
+
+.SharedStub:
+	mflr	r0
+
+	std	r4, -56(r1)
+	std	r5, -48(r1)
+	std	r6, -40(r1)
+	std	r7, -32(r1)
+	std	r8, -24(r1)
+	std	r9, -16(r1)
+	std	r10, -8(r1)
+
+	stfd	f13, -64(r1)
+	stfd	f12, -72(r1)
+	stfd	f11, -80(r1)
+	stfd	f10, -88(r1)
+	stfd	f9, -96(r1)
+	stfd	f8, -104(r1)
+	stfd	f7, -112(r1)
+	stfd	f6, -120(r1)
+	stfd	f5, -128(r1)
+	stfd	f4, -136(r1)
+	stfd	f3, -144(r1)
+	stfd	f2, -152(r1)
+	stfd	f1, -160(r1)
+
+	subi	r6,r1,56			// r6 --> gprData
+	subi	r7,r1,160			// r7 --> fprData
+	addi	r5,r1,112			// r5 <= pointer to callers args area,
+						// beyond r3-r10/f1-f8 mapped range
+
+	std	r0, 16(r1)
+	
+	stdu	r1,-288(r1)
+
+	
+						// r3 has the 'self' pointer already
+	
+	mr      r4,r11				// r4 <= methodIndex selector, passed
+						// via r11 in the nsXPTCStubBase::StubXX() call
+	
+	
+	bl	PrepareAndDispatch	// Go!
+
+	ld	1,0(r1)				// restore stack
+	ld	r0,16(r1)			// restore LR
+	mtlr	r0
+	blr
+
+	.size   SharedStub,.-.SharedStub
+
+
+/* Magic indicating no need for an executable stack */
+.section .note.GNU-stack, "", @progbits ; .previous
diff -uNr --exclude '*~' --exclude '*.ii' --exclude 'foo*' --exclude '*.o' --exclude '*tmp*' --exclude '*.ppc64' mozilla.orig/xpcom/reflect/xptcall/src/md/unix/xptcstubs_ppc64_linux.cpp mozilla/xpcom/reflect/xptcall/src/md/unix/xptcstubs_ppc64_linux.cpp
--- mozilla.orig/xpcom/reflect/xptcall/src/md/unix/xptcstubs_ppc64_linux.cpp	1970-01-01 01:00:00.000000000 +0100
+++ mozilla/xpcom/reflect/xptcall/src/md/unix/xptcstubs_ppc64_linux.cpp	2006-11-21 16:59:46.000000000 +0000
@@ -0,0 +1,247 @@
+/* -*- Mode: C; tab-width: 8; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
+/* ***** BEGIN LICENSE BLOCK *****
+ * Version: MPL 1.1/GPL 2.0/LGPL 2.1
+ *
+ * The contents of this file are subject to the Mozilla Public License Version
+ * 1.1 (the "License"); you may not use this file except in compliance with
+ * the License. You may obtain a copy of the License at
+ * http://www.mozilla.org/MPL/
+ *
+ * Software distributed under the License is distributed on an "AS IS" basis,
+ * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
+ * for the specific language governing rights and limitations under the
+ * License.
+ *
+ * The Original Code is mozilla.org code.
+ *
+ * The Initial Developer of the Original Code is
+ * Netscape Communications Corporation.
+ * Portions created by the Initial Developer are Copyright (C) 1999
+ * the Initial Developer. All Rights Reserved.
+ *
+ * Contributor(s):
+ *   dwmw2@infradead.org (David Woodhouse)
+ *   Franz.Sirl-kernel@lauterbach.com (Franz Sirl)
+ *   beard@netscape.com (Patrick Beard)
+ *   waterson@netscape.com (Chris Waterson)
+ *
+ * Alternatively, the contents of this file may be used under the terms of
+ * either of the GNU General Public License Version 2 or later (the "GPL"),
+ * or the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
+ * in which case the provisions of the GPL or the LGPL are applicable instead
+ * of those above. If you wish to allow use of your version of this file only
+ * under the terms of either the GPL or the LGPL, and not to allow others to
+ * use your version of this file under the terms of the MPL, indicate your
+ * decision by deleting the provisions above and replace them with the notice
+ * and other provisions required by the GPL or the LGPL. If you do not delete
+ * the provisions above, a recipient may use your version of this file under
+ * the terms of any one of the MPL, the GPL or the LGPL.
+ *
+ * ***** END LICENSE BLOCK ***** */
+
+// Implement shared vtbl methods.
+
+#include "xptcprivate.h"
+
+// The Linux/PPC ABI (aka PPC/SYSV ABI) passes the first 8 integral
+// parameters and the first 13 floating point parameters in registers
+// (r3-r10 and f1-f13), no stack space is allocated for these by the
+// caller.  The rest of the parameters are passed in the callers stack
+// area. The stack pointer has to retain 16-byte alignment, longlongs
+// and doubles are aligned on 8-byte boundaries.
+
+#define PARAM_BUFFER_COUNT     16
+#define GPR_COUNT               7
+#define FPR_COUNT               13
+
+// PrepareAndDispatch() is called by SharedStub() and calls the actual method.
+//
+// - 'args[]' contains the arguments passed on stack
+// - 'gprData[]' contains the arguments passed in integer registers
+// - 'fprData[]' contains the arguments passed in floating point registers
+// 
+// The parameters are mapped into an array of type 'nsXPTCMiniVariant'
+// and then the method gets called.
+#include <stdio.h>
+extern "C" nsresult
+PrepareAndDispatch(nsXPTCStubBase* self,
+                   PRUint64 methodIndex,
+                   PRUint64* args,
+                   PRUint64 *gprData,
+                   double *fprData)
+{
+    nsXPTCMiniVariant paramBuffer[PARAM_BUFFER_COUNT];
+    nsXPTCMiniVariant* dispatchParams = NULL;
+    nsIInterfaceInfo* iface_info = NULL;
+    const nsXPTMethodInfo* info;
+    PRUint32 paramCount;
+    PRUint32 i;
+    nsresult result = NS_ERROR_FAILURE;
+
+    NS_ASSERTION(self,"no self");
+
+    self->GetInterfaceInfo(&iface_info);
+    NS_ASSERTION(iface_info,"no interface info");
+    if (! iface_info)
+        return NS_ERROR_UNEXPECTED;
+
+    iface_info->GetMethodInfo(PRUint16(methodIndex), &info);
+    NS_ASSERTION(info,"no method info");
+    if (! info)
+        return NS_ERROR_UNEXPECTED;
+
+    paramCount = info->GetParamCount();
+
+    // setup variant array pointer
+    if(paramCount > PARAM_BUFFER_COUNT)
+        dispatchParams = new nsXPTCMiniVariant[paramCount];
+    else
+        dispatchParams = paramBuffer;
+
+    NS_ASSERTION(dispatchParams,"no place for params");
+    if (! dispatchParams)
+        return NS_ERROR_OUT_OF_MEMORY;
+
+    PRUint64* ap = args;
+    PRUint64 tempu64;
+
+    for(i = 0; i < paramCount; i++) {
+        const nsXPTParamInfo& param = info->GetParam(i);
+        const nsXPTType& type = param.GetType();
+        nsXPTCMiniVariant* dp = &dispatchParams[i];
+	
+        if (!param.IsOut() && type == nsXPTType::T_DOUBLE) {
+            if (i < FPR_COUNT)
+                dp->val.d = fprData[i];
+            else
+                dp->val.d = *(double*) ap;
+        } else if (!param.IsOut() && type == nsXPTType::T_FLOAT) {
+            if (i < FPR_COUNT)
+                dp->val.f = (float) fprData[i]; // in registers floats are passed as doubles
+            else {
+                float *p = (float *)ap;
+                p++;
+                dp->val.f = *p;
+            }
+        } else { /* integer type or pointer */
+            if (i < GPR_COUNT)
+                tempu64 = gprData[i];
+            else
+                tempu64 = *ap;
+
+            if (param.IsOut() || !type.IsArithmetic())
+                dp->val.p = (void*) tempu64;
+            else if (type ==nsXPTType::T_I8)
+                dp->val.i8  = (PRInt8)   tempu64;
+            else if (type ==nsXPTType::T_I16)
+                dp->val.i16 = (PRInt16)  tempu64;
+            else if (type ==nsXPTType::T_I32)
+                dp->val.i32 = (PRInt32)  tempu64;
+            else if (type ==nsXPTType::T_I64)
+                dp->val.i64 = (PRInt64)  tempu64;
+            else if (type ==nsXPTType::T_U8)
+                dp->val.u8  = (PRUint8)  tempu64;
+            else if (type ==nsXPTType::T_U16)
+                dp->val.u16 = (PRUint16) tempu64;
+            else if (type ==nsXPTType::T_U32)
+                dp->val.u32 = (PRUint32) tempu64;
+            else if (type ==nsXPTType::T_U64)
+                dp->val.u64 = (PRUint64) tempu64;
+            else if (type ==nsXPTType::T_BOOL)
+                dp->val.b   = (PRBool)   tempu64;
+            else if (type ==nsXPTType::T_CHAR)
+                dp->val.c   = (char)     tempu64;
+            else if (type ==nsXPTType::T_WCHAR)
+                dp->val.wc  = (wchar_t)  tempu64;
+            else
+                NS_ASSERTION(0, "bad type");
+        }
+
+        if (i >= 7)
+            ap++;
+    }
+
+    result = self->CallMethod((PRUint16) methodIndex, info, dispatchParams);
+
+    NS_RELEASE(iface_info);
+
+    if (dispatchParams != paramBuffer)
+        delete [] dispatchParams;
+
+    return result;
+}
+
+// Load r11 with the constant 'n' and branch to SharedStub().
+//
+// XXX Yes, it's ugly that we're relying on gcc's name-mangling here;
+// however, it's quick, dirty, and'll break when the ABI changes on
+// us, which is what we want ;-).
+
+#if __GXX_ABI_VERSION < 100
+#error Prehistoric GCC not supported here
+#else
+// gcc-3 version
+//
+// As G++3 ABI contains the length of the functionname in the mangled
+// name, it is difficult to get a generic assembler mechanism like
+// in the G++ 2.95 case.
+// Create names would be like:
+// _ZN14nsXPTCStubBase5Stub1Ev
+// _ZN14nsXPTCStubBase6Stub12Ev
+// _ZN14nsXPTCStubBase7Stub123Ev
+// _ZN14nsXPTCStubBase8Stub1234Ev
+// etc.
+// Use assembler directives to get the names right...
+
+# define STUB_ENTRY(n)							\
+__asm__ (								\
+        ".section \".toc\",\"aw\" \n\t"                                 \
+        ".section \".text\" \n\t"                                       \
+	".align	2 \n\t"							\
+	".if	"#n" < 10 \n\t"						\
+	".globl	_ZN14nsXPTCStubBase5Stub"#n"Ev \n\t"			\
+        ".section \".opd\",\"aw\" \n\t"                                 \
+	".align	3 \n\t"							\
+"_ZN14nsXPTCStubBase5Stub"#n"Ev: \n\t"					\
+        ".quad  ._ZN14nsXPTCStubBase5Stub"#n"Ev,.TOC.@tocbase \n\t"     \
+	".previous \n\t"						\
+	".type	_ZN14nsXPTCStubBase5Stub"#n"Ev,@function \n\n"		\
+"._ZN14nsXPTCStubBase5Stub"#n"Ev: \n\t"					\
+									\
+	".elseif "#n" < 100 \n\t"					\
+	".globl	_ZN14nsXPTCStubBase6Stub"#n"Ev \n\t"			\
+        ".section \".opd\",\"aw\" \n\t"                                 \
+	".align	3 \n\t"							\
+"_ZN14nsXPTCStubBase6Stub"#n"Ev: \n\t"					\
+        ".quad  ._ZN14nsXPTCStubBase6Stub"#n"Ev,.TOC.@tocbase \n\t"     \
+	".previous \n\t"						\
+	".type	_ZN14nsXPTCStubBase6Stub"#n"Ev,@function \n\n"		\
+"._ZN14nsXPTCStubBase6Stub"#n"Ev: \n\t"					\
+									\
+	".elseif "#n" < 1000 \n\t"					\
+	".globl	_ZN14nsXPTCStubBase7Stub"#n"Ev \n\t"			\
+        ".section \".opd\",\"aw\" \n\t"                                 \
+	".align	3 \n\t"							\
+"_ZN14nsXPTCStubBase7Stub"#n"Ev: \n\t"					\
+        ".quad  ._ZN14nsXPTCStubBase7Stub"#n"Ev,.TOC.@tocbase \n\t"     \
+	".previous \n\t"						\
+	".type	_ZN14nsXPTCStubBase7Stub"#n"Ev,@function \n\n"		\
+"._ZN14nsXPTCStubBase7Stub"#n"Ev: \n\t"					\
+									\
+	".else \n\t"							\
+	".err	\"stub number "#n" >= 1000 not yet supported\"\n"	\
+	".endif \n\t"							\
+									\
+	"li	11,"#n" \n\t"						\
+	"b	SharedStub \n"					\
+);
+#endif
+
+#define SENTINEL_ENTRY(n)                            \
+nsresult nsXPTCStubBase::Sentinel##n()               \
+{                                                    \
+  NS_ASSERTION(0,"nsXPTCStubBase::Sentinel called"); \
+  return NS_ERROR_NOT_IMPLEMENTED;                   \
+}
+
+#include "xptcstubsdef.inc"


-- 
dwmw2
