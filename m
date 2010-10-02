Return-Path: <acahalan@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id EAA57B70D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  3 Oct 2010 05:17:00 +1100 (EST)
Received: by fxm2 with SMTP id 2so2845202fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 02 Oct 2010 11:16:57 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 2 Oct 2010 14:16:57 -0400
Message-ID: <AANLkTinC-DiZNZ4GsWM2+xk+mp=AN1Q82uLAekNB=_FT@mail.gmail.com>
Subject: arch/powerpc/*/div64.S
From: Albert Cahalan <acahalan@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This looks like duplicated code getting out of sync.

$ diff -Naurd arch/powerpc/lib/div64.S arch/powerpc/boot/div64.S
--- arch/powerpc/lib/div64.S    2009-09-09 18:13:59.000000000 -0400
+++ arch/powerpc/boot/div64.S   2009-09-09 18:13:59.000000000 -0400
@@ -13,10 +13,10 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-#include <asm/ppc_asm.h>
-#include <asm/processor.h>
+#include "ppc_asm.h"

-_GLOBAL(__div64_32)
+       .globl __div64_32
+__div64_32:
        lwz     r5,0(r3)        # get the dividend into r5/r6
        lwz     r6,4(r3)
        cmplw   r5,r4
@@ -33,10 +33,9 @@
        cntlzw  r0,r5           # we are shifting the dividend right
        li      r10,-1          # to make it < 2^32, and shifting
        srw     r10,r10,r0      # the divisor right the same amount,
-       addc    r9,r4,r10       # rounding up (so the estimate cannot
+       add     r9,r4,r10       # rounding up (so the estimate cannot
        andc    r11,r6,r10      # ever be too large, only too small)
        andc    r9,r9,r10
-       addze   r9,r9
        or      r11,r5,r11
        rotlw   r9,r9,r0
        rotlw   r11,r11,r0
