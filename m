Return-Path: <johnstul@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.129])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10B0767B85
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 08:05:56 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j5TM5riN203818
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 18:05:53 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j5TM5qcC156900
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 16:05:52 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	j5TM5qjL028041
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 16:05:52 -0600
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org,
	paulus@samba.org
Content-Type: text/plain
Date: Wed, 29 Jun 2005 15:05:51 -0700
Message-Id: <1120082751.24889.120.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] ppc misusing NTP's time_offset value
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey everyone,

	As part of my timeofday rework, I've been looking at the NTP code and I
noticed that the PPC architecture is apparently misusing the NTP's
time_offset (it is a terrible name!) value as some form of timezone
offset. This could cause problems when time_offset changed by the NTP
code.
	
	This patch changes the PPC code so it uses a more clear local variable:
timezone_offset.

Could a PPC maintainer verify this is correct?

Let me know if you have any comments or feedback.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c
+++ b/arch/ppc/kernel/time.c
@@ -90,6 +90,9 @@ unsigned long tb_to_ns_scale;
 
 extern unsigned long wall_jiffies;
 
+/* used for timezone offset */
+static long timezone_offset;
+
 DEFINE_SPINLOCK(rtc_lock);
 
 EXPORT_SYMBOL(rtc_lock);
@@ -171,7 +174,7 @@ void timer_interrupt(struct pt_regs * re
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs((xtime.tv_nsec / 1000) - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies - wall_jiffies == 1) {
-		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
+		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + timezone_offset) == 0)
 				last_rtc_update = xtime.tv_sec+1;
 			else
 				/* Try again one minute later */
@@ -284,7 +287,7 @@ void __init time_init(void)
 	unsigned old_stamp, stamp, elapsed;
 
         if (ppc_md.time_init != NULL)
-                time_offset = ppc_md.time_init();
+                timezone_offset = ppc_md.time_init();
 
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
@@ -329,10 +332,10 @@ void __init time_init(void)
 	set_dec(tb_ticks_per_jiffy);
 
 	/* If platform provided a timezone (pmac), we correct the time */
-        if (time_offset) {
-		sys_tz.tz_minuteswest = -time_offset / 60;
+        if (timezone_offset) {
+		sys_tz.tz_minuteswest = -timezone_offset / 60;
 		sys_tz.tz_dsttime = 0;
-		xtime.tv_sec -= time_offset;
+		xtime.tv_sec -= timezone_offset;
         }
         set_normalized_timespec(&wall_to_monotonic,
                                 -xtime.tv_sec, -xtime.tv_nsec);
