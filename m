Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id D34EE67B3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 07:37:11 +1000 (EST)
Message-ID: <42A0CF1C.6000900@mvista.com>
Date: Fri, 03 Jun 2005 14:43:56 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42A0CD46.60300@mvista.com>
In-Reply-To: <42A0CD46.60300@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Greg KH <greg@kroah.com>, sensors@stimpy.netroedge.com,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/2] Add support for Maxim/Dallas DS1374 Real-Time Clock Chip
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings,
  This is part 2 of the patch to add support for the DS1374 I2C RTC chip
from Maxim/Dallas.


		Randy Vinson



Add support for the I2C Real-Time Clock on the MPC8349ADS board.

This change provides support for the DS1374 Real-Time Clock chip present
on the MPC8349ADS board. It depends on a previous patch which adds I2C
support for the DS1374.

Signed-off-by: Randy Vinson <rvinson@mvista.com>

---
commit 07fb1bd27347f7f0df1309c40d09a2f1a9a98731
tree b3ac3ac93679372aa5111268b623c5dda4a5039e
parent f95cc4d276cc332225bd823a2ae3be553c119990
author Randy Vinson <rvinson@linuxbox.(none)> Fri, 03 Jun 2005 13:57:46 -0700
committer Randy Vinson <rvinson@linuxbox.(none)> Fri, 03 Jun 2005 13:57:46 -0700

 arch/ppc/platforms/83xx/mpc834x_sys.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
@@ -227,6 +227,26 @@ mpc834x_sys_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
+#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
+extern ulong	ds1374_get_rtc_time(void);
+extern int	ds1374_set_rtc_time(ulong);
+
+static int __init
+mpc834x_rtc_hookup(void)
+{
+	struct timespec	tv;
+
+	ppc_md.get_rtc_time = ds1374_get_rtc_time;
+	ppc_md.set_rtc_time = ds1374_set_rtc_time;
+
+	tv.tv_nsec = 0;
+	tv.tv_sec = (ppc_md.get_rtc_time)();
+	do_settimeofday(&tv);
+
+	return 0;
+}
+late_initcall(mpc834x_rtc_hookup);
+#endif
 static __inline__ void
 mpc834x_sys_set_bat(void)
 {
