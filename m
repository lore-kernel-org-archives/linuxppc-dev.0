Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BC91EDDF14
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 10:21:40 +1100 (EST)
Date: Tue, 20 Mar 2007 00:21:39 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/5] powerpc: generic time suspend/resume code
In-Reply-To: <1174342286.22561.25.camel@johannes.berg>
Message-ID: <Pine.LNX.4.60.0703200010570.10137@poirot.grange>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105357.964696000@sipsolutions.net>
	<1174315651.5044.4.camel@localhost.localdomain>
	<Pine.LNX.4.60.0703192236420.10137@poirot.grange>
	<1174342286.22561.25.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 19 Mar 2007, Johannes Berg wrote:

> It's not just the generic RTC suspend code that is relevant but also the
> ppc_md rtc hooks, ultimately they probably should be removed totally
> once powerpc completely migrates to genrtc everywhere. In the patch you
> showed me to this file you actually circumvented the ppc_md rtc hooks
> because you're already using genrtc, in that case the genrtc suspend
> code is obviously much more appropriate.

Just to make it easier for everyone to follow below is my patch I showed 
Johannes today on IRC. I use it atm on the top of his patch to save / 
restore system time. Notice, it is not thought for upstream in any way - 
just for reference.

Another point I forgot to mention in my first reply - why does this patch 
use a special mechanism to restore the time like saving the rtc time on 
suspend, re-reading it on resume, calculating the difference and adding it 
to the current timeofday, which is, presumably, equal to suspend time? 
Isn't re-using the same method as on poweron of setting the timeofday from 
rtc more logical? Which is exactly what David's patch does?

Thanks
Guennadi
---
Guennadi Liakhovetski

(not for inclusion, for reference only, hence no "Signed-off-by")

--- a/arch/powerpc/sysdev/timer.c	2007-03-19 22:26:12.000000000 +0100
+++ b/arch/powerpc/sysdev/timer.c	2007-03-03 01:19:01.000000000 +0100
@@ -11,6 +11,24 @@
 
 static unsigned long suspend_rtc_time;
 
+static int timer_get_rtc_time(struct rtc_time *time)
+{
+	int err = 0;
+
+	if (ppc_md.get_rtc_time)
+		get_rtc_time(time);
+	else {
+		struct class_device *class_dev = rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
+
+		WARN_ON(!class_dev);
+
+		err = rtc_read_time(class_dev, time);
+		rtc_class_close(class_dev);
+	}
+
+	return err;
+}
+
 /*
  * Reset the time after a sleep.
  */
@@ -20,9 +38,12 @@
 	struct timespec ts;
 	struct rtc_time cur_rtc_tm;
 	unsigned long cur_rtc_time, diff;
+	int err;
 
 	/* get current RTC time and convert to seconds */
-	get_rtc_time(&cur_rtc_tm);
+	err = timer_get_rtc_time(&cur_rtc_tm);
+	if (err)
+		return err;
 	rtc_tm_to_time(&cur_rtc_tm, &cur_rtc_time);
 
 	diff = cur_rtc_time - suspend_rtc_time;
@@ -40,9 +61,11 @@
 static int timer_suspend(struct sys_device *dev, pm_message_t state)
 {
 	struct rtc_time suspend_rtc_tm;
-	WARN_ON(!ppc_md.get_rtc_time);
+	int err;
 
-	get_rtc_time(&suspend_rtc_tm);
+	err = timer_get_rtc_time(&suspend_rtc_tm);
+	if (err)
+		return err;
 	rtc_tm_to_time(&suspend_rtc_tm, &suspend_rtc_time);
 
 	return 0;
