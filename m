Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 698E0DE11D
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 01:23:27 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	benh@kernel.crashing.org, jonsmirl@gmail.com, arnd@arndb.de,
	geert.uytterhoeven@sonycom.com
Subject: [PATCH 1/2] [PATCH 1/2 v9] powerpc: introduce macro
	spin_event_timeout()
Date: Tue, 26 May 2009 10:21:41 -0500
Message-Id: <1243351302-32062-2-git-send-email-timur@freescale.com>
In-Reply-To: <1243351302-32062-1-git-send-email-timur@freescale.com>
References: <1243351302-32062-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The macro spin_event_timeout() takes a condition and timeout value
(in microseconds) as parameters.  It spins until either the condition is true
or the timeout expires.  It returns the result of the condition when the loop
was terminated.

This primary purpose of this macro is to poll on a hardware register until a
status bit changes.  The timeout ensures that the loop still terminates if the
bit doesn't change as expected.  This macro makes it easier for driver
developers to perform this kind of operation properly.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

v9: changed the macro to return the value, instead of having it passed in

 arch/powerpc/include/asm/delay.h |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/delay.h b/arch/powerpc/include/asm/delay.h
index f9200a6..1e2eb41 100644
--- a/arch/powerpc/include/asm/delay.h
+++ b/arch/powerpc/include/asm/delay.h
@@ -2,8 +2,11 @@
 #define _ASM_POWERPC_DELAY_H
 #ifdef __KERNEL__
 
+#include <asm/time.h>
+
 /*
  * Copyright 1996, Paul Mackerras.
+ * Copyright (C) 2009 Freescale Semiconductor, Inc. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -30,5 +33,38 @@ extern void udelay(unsigned long usecs);
 #define mdelay(n)	udelay((n) * 1000)
 #endif
 
+/**
+ * spin_event_timeout - spin until a condition gets true or a timeout elapses
+ * @condition: a C expression to evalate
+ * @timeout: timeout, in microseconds
+ * @delay: the number of microseconds to delay between each evaluation of
+ *         @condition
+ *
+ * The process spins until the condition evaluates to true (non-zero) or the
+ * timeout elapses.  The return value of this macro is the value of
+ * @condition when the loop terminates. This allows you to determine the cause
+ * of the loop terminates.  If the return value is zero, then you know a
+ * timeout has occurred.
+ *
+ * This primary purpose of this macro is to poll on a hardware register
+ * until a status bit changes.  The timeout ensures that the loop still
+ * terminates even if the bit never changes.  The delay is for devices that
+ * need a delay in between successive reads.
+ *
+ * gcc will optimize out the if-statement if @delay is a constant.
+ */
+#define spin_event_timeout(condition, timeout, delay)                          \
+({                                                                             \
+	typeof(condition) __ret;                                               \
+	unsigned long __loops = tb_ticks_per_usec * timeout;                   \
+	unsigned long __start = get_tbl();                                     \
+	while (!(__ret = (condition)) && (tb_ticks_since(__start) <= __loops)) \
+		if (delay)                                                     \
+			udelay(delay);                                         \
+		else                                                           \
+			cpu_relax();                                           \
+	__ret;		                                                       \
+})
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DELAY_H */
-- 
1.6.0.6
