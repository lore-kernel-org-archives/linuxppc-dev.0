Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB75BDE06E
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 09:12:04 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2AMC0kb002937
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 15:12:01 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v5] introduce macro spin_event_timeout()
Date: Tue, 10 Mar 2009 17:11:58 -0500
Message-Id: <1236723118-3577-1-git-send-email-timur@freescale.com>
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
or the timeout expires.  It returns zero if the timeout expires first, non-zero
otherwise.

This primary purpose of this macro is to poll on a hardware register until a
status bit changes.  The timeout ensures that the loop still terminates if the
bit doesn't change as expected.  This macro makes it easier for driver
developers to perform this kind of operation properly.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

v5: ported to arch/powerpc, made it powerpc-specific, eliminated udelay

v4: removed cpu_relax (redundant), changed timeout to unsigned long

v3: eliminated secondary evaluation of condition, replaced jiffies with udelay

v2: added cpu_relax and time_before

 arch/powerpc/include/asm/delay.h |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/delay.h b/arch/powerpc/include/asm/delay.h
index f9200a6..aadec70 100644
--- a/arch/powerpc/include/asm/delay.h
+++ b/arch/powerpc/include/asm/delay.h
@@ -2,6 +2,8 @@
 #define _ASM_POWERPC_DELAY_H
 #ifdef __KERNEL__
 
+#include <asm/time.h>
+
 /*
  * Copyright 1996, Paul Mackerras.
  *
@@ -30,5 +32,35 @@ extern void udelay(unsigned long usecs);
 #define mdelay(n)	udelay((n) * 1000)
 #endif
 
+/**
+ * spin_event_timeout - spin until a condition gets true or a timeout elapses
+ * @condition: a C expression to evalate
+ * @timeout: timeout, in microseconds
+ *
+ * The process spins until the @condition evaluates to true (non-zero) or
+ * the @timeout elapses.
+ *
+ * This primary purpose of this macro is to poll on a hardware register
+ * until a status bit changes.  The timeout ensures that the loop still
+ * terminates if the bit never changes.
+ *
+ * The return value is non-zero if the condition evaluates to true first, or
+ * zero if the timeout elapses first.
+ */
+#define spin_event_timeout(condition, timeout)			\
+({								\
+	unsigned long __start = get_tbl();			\
+	unsigned long __loops = tb_ticks_per_usec * timeout;	\
+	int __ret = 1;						\
+	while (!(condition)) {					\
+		if (tb_ticks_since(__start) > __loops) {	\
+			__ret = 0;				\
+			break;					\
+		}						\
+		cpu_relax();					\
+	}							\
+	__ret;							\
+})
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DELAY_H */
-- 
1.6.1.3
