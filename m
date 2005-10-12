Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43542684C5
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2005 11:43:51 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 11:39:33 +1000
Message-Id: <1129081173.17365.264.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: Fix timekeeping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Interestingly enough, ppc32 had broken timekeeping for ages... It
worked, but probably drifted a bit more than could be explained by the
actual bad precision of the timebase calibration. We discovered that
recently when somebody figured out that the common code was using
CLOCK_TICK_RATE to correct the timekeeing, and ppc32 had a completely
bogus value for it.

This patch turns it into something saner. Probably not as good as doing
something based on the actual timebase frequency precision but I'll
leave that sort of math to others. This at least makes it better for the
common HZ values.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Please get that one in 2.6.14

Index: linux-work/include/asm-powerpc/timex.h
===================================================================
--- linux-work.orig/include/asm-powerpc/timex.h	2005-09-22 14:07:27.000000000 +1000
+++ linux-work/include/asm-powerpc/timex.h	2005-10-06 11:53:51.000000000 +1000
@@ -10,7 +10,7 @@
 #include <linux/config.h>
 #include <asm/cputable.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define CLOCK_TICK_RATE	1024000 /* Underlying HZ */
 
 typedef unsigned long cycles_t;
 
