Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6CFFDB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 17:12:27 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 10 Jun 2009 17:12:00 +1000
Subject: [PATCH] powerpc: Don't do generic calibrate_delay()
Message-Id: <20090610071227.586B5DDD0C@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we are wasting time calling the generic calibrate_delay()
function. We don't need it since our implementation of __delay() is
based on the CPU timebase. So instead, we use our own small
implementation that initializes loops_per_jiffy to something sensible
to make the few users like spinlock debug be happy

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/Kconfig       |    4 ----
 arch/powerpc/kernel/time.c |   10 ++++++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

--- linux-work.orig/arch/powerpc/Kconfig	2009-06-10 16:09:35.000000000 +1000
+++ linux-work/arch/powerpc/Kconfig	2009-06-10 16:13:00.000000000 +1000
@@ -93,10 +93,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
Index: linux-work/arch/powerpc/kernel/time.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/time.c	2009-06-10 16:09:35.000000000 +1000
+++ linux-work/arch/powerpc/kernel/time.c	2009-06-10 16:13:00.000000000 +1000
@@ -52,6 +52,7 @@
 #include <linux/jiffies.h>
 #include <linux/posix-timers.h>
 #include <linux/irq.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -1143,6 +1144,15 @@ void div128_by_32(u64 dividend_high, u64
 
 }
 
+/* We don't need to calibrate delay, we use the CPU timebase for that */
+void calibrate_delay(void)
+{
+	/* Some generic code (such as spinlock debug) use loops_per_jiffy
+	 * as the number of __delay(1) in a jiffy, so make it so
+	 */
+	loops_per_jiffy = tb_ticks_per_jiffy;
+}
+
 static int __init rtc_init(void)
 {
 	struct platform_device *pdev;
