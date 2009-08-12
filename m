Return-Path: <CFRIESEN@nortel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 26EAFB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 04:03:04 +1000 (EST)
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4DBF0DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 04:03:02 +1000 (EST)
Message-ID: <4A8303C6.7070705@nortel.com>
Date: Wed, 12 Aug 2009 12:02:46 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	wim@iguana.be, Linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix book E watchdog to take WDIOC_SETTIMEOUT arg in seconds
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The WDIOC_SETTIMEOUT argument is supposed to be a "seconds" value.
However, the book E wdt currently treats it as a "period" which is
interpreted in a board-specific way.

This patch allows the user to pass in a "seconds" value and the driver
will set the smallest timeout that is at least as large as specified
by the user.  It's been tested on e500 hardware and works as
expected.

The patch only modifies the CONFIG_FSL_BOOKE case, the CONFIG_4xx case
is left unmodified as I don't have any hardware to test it on.

Signed-off-by: Chris Friesen <cfriesen@nortel.com>

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 225398f..f1a3617 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -22,6 +22,8 @@
 
 #include <asm/reg_booke.h>
 #include <asm/system.h>
+#include <asm/time.h>
+#include <asm/div64.h>
 
 /* If the kernel parameter wdt=1, the watchdog will be enabled at boot.
  * Also, the wdt_period sets the watchdog timer period timeout.
@@ -32,7 +34,7 @@
  */
 
 #ifdef	CONFIG_FSL_BOOKE
-#define WDT_PERIOD_DEFAULT 63	/* Ex. wdt_period=28 bus=333Mhz,reset=~40sec */
+#define WDT_PERIOD_DEFAULT 38	/* Ex. wdt_period=28 bus=333Mhz,reset=~40sec */
 #else
 #define WDT_PERIOD_DEFAULT 3	/* Refer to the PPC40x and PPC4xx manuals */
 #endif				/* for timing information */
@@ -41,7 +43,7 @@ u32 booke_wdt_enabled;
 u32 booke_wdt_period = WDT_PERIOD_DEFAULT;
 
 #ifdef	CONFIG_FSL_BOOKE
-#define WDTP(x)		((((63-x)&0x3)<<30)|(((63-x)&0x3c)<<15))
+#define WDTP(x)		((((x)&0x3)<<30)|(((x)&0x3c)<<15))
 #define WDTP_MASK	(WDTP(0))
 #else
 #define WDTP(x)		(TCR_WP(x))
@@ -50,6 +52,45 @@ u32 booke_wdt_period = WDT_PERIOD_DEFAULT;
 
 static DEFINE_SPINLOCK(booke_wdt_lock);
 
+/* For the specified period, determine the number of seconds
+ * corresponding to the reset time.  There will be a watchdog
+ * exception at approximately 3/5 of this time.
+ *
+ * The formula to calculate this is given by:
+ * 2.5 * (2^(63-period+1)) / timebase_freq
+ *
+ * In order to simplify things, we assume that period is
+ * at least 1.  This will still result in a very long timeout.
+ */
+static unsigned long long period_to_sec(unsigned int period)
+{
+	unsigned long long tmp = 1ULL << (64 - period);
+	unsigned long tmp2 = ppc_tb_freq;
+	
+	/* tmp may be a very large number and we don't want to overflow,
+	 * so divide the timebase freq instead of multiplying tmp
+	 */
+	tmp2 = tmp2 / 5 * 2;
+	
+	do_div(tmp, tmp2);
+	return tmp;
+}
+
+/*
+ * This procedure will find the highest period which will give a timeout
+ * greater than the one required. e.g. for a bus speed of 66666666 and 
+ * and a parameter of 2 secs, then this procedure will return a value of 38.
+ */
+static unsigned int sec_to_period(unsigned int secs)
+{
+	unsigned int period;
+	for (period = 63; period > 0; period--) {
+		if (period_to_sec(period) >= secs)
+			return period;
+	}
+	return 0;
+}
+
 static void __booke_wdt_ping(void *data)
 {
 	mtspr(SPRN_TSR, TSR_ENW|TSR_WIS);
@@ -93,7 +134,7 @@ static long booke_wdt_ioctl(struct file *file,
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		if (copy_to_user(arg, &ident, sizeof(struct watchdog_info)))
+		if (copy_to_user((void *)arg, &ident, sizeof(struct watchdog_info)))
 			return -EFAULT;
 	case WDIOC_GETSTATUS:
 		return put_user(ident.options, p);
@@ -115,8 +156,16 @@ static long booke_wdt_ioctl(struct file *file,
 		booke_wdt_ping();
 		return 0;
 	case WDIOC_SETTIMEOUT:
-		if (get_user(booke_wdt_period, p))
+		if (get_user(tmp, p))
 			return -EFAULT;
+#ifdef	CONFIG_FSL_BOOKE
+		/* period of 1 gives the largest possible timeout */
+		if (tmp > period_to_sec(1))
+			return -EINVAL;
+                booke_wdt_period = sec_to_period(tmp);
+#else
+		booke_wdt_period = tmp;
+#endif
 		mtspr(SPRN_TCR, (mfspr(SPRN_TCR) & ~WDTP_MASK) |
 						WDTP(booke_wdt_period));
 		return 0;
