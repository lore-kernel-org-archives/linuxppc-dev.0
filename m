Message-Id: <v03110700b50123f3f40f@[129.100.29.243]>
In-Reply-To: <Pine.LNX.4.10.10003231730190.10447-200000@shell.unixbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 24 Mar 2000 09:03:23 -0500
To: Ani Joshi <ajoshi@shell.unixbox.com>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: proper regw and regrw16?
Cc: linuxppc-dev@lists.linuxppc.org, bh40@calva.net
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ani and Ben,

I asked about the "correct" form for regr and regw to the list a while back
(and it generated a big discussion!) and I put in the "best" suggested form
but it obviously impacts something.

So exactly what in the generated code is different about these two cases
that makes such a big difference in performance?  I need to understand why
the "output constraint" approach has such a bad performance impact?


--- r128_reg.h.orig	Thu Mar 23 18:10:17 2000
+++ r128_reg.h	Thu Mar 23 18:15:43 2000
@@ -50,9 +50,7 @@

 static inline void regw(volatile unsigned long base_addr, unsigned long
regindex, unsigned long regdata)
 {
- asm volatile ("stwbrx %1,%2,%3; eieio"
-          : "=m" (*(volatile unsigned *)(base_addr+regindex))
-          : "r" (regdata), "b" (regindex), "r" (base_addr));
+	asm volatile ("stwbrx %0,%1,%2; eieio" : : "r"(regdata), "b"
(regindex), "r"(base_addr) : "memory");
 }

Could you post the assembler (.S) file that each of these makes?

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
