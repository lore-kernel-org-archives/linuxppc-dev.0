Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05837DDF9B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 00:25:28 +1000 (EST)
Subject: [PATCH] powerpc timer sysdev: use mktime
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17976.5964.593278.752595@cargo.ozlabs.ibm.com>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<1170357390.4036.9.camel@johannes.berg>
	<17976.5964.593278.752595@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 02 May 2007 16:25:42 +0200
Message-Id: <1178115942.13233.61.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes the timer sysdev use mktime instead of rtc_tm_to_time
by simply copying the function to avoid using rtc-lib.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- wireless-dev.orig/arch/powerpc/sysdev/timer.c	2007-05-02 16:16:52.639177080 +0200
+++ wireless-dev/arch/powerpc/sysdev/timer.c	2007-05-02 16:21:56.429177080 +0200
@@ -24,7 +24,12 @@ static int timer_resume(struct sys_devic
 
 	/* get current RTC time and convert to seconds */
 	get_rtc_time(&cur_rtc_tm);
-	rtc_tm_to_time(&cur_rtc_tm, &cur_rtc_time);
+	cur_rtc_time = mktime(cur_rtc_tm.tm_year + 1900,
+			      cur_rtc_tm.tm_mon + 1,
+			      cur_rtc_tm.tm_mday,
+			      cur_rtc_tm.tm_hour,
+			      cur_rtc_tm.tm_min,
+			      cur_rtc_tm.tm_sec);
 
 	diff = cur_rtc_time - suspend_rtc_time;
 
@@ -44,7 +49,12 @@ static int timer_suspend(struct sys_devi
 	WARN_ON(!ppc_md.get_rtc_time);
 
 	get_rtc_time(&suspend_rtc_tm);
-	rtc_tm_to_time(&suspend_rtc_tm, &suspend_rtc_time);
+	suspend_rtc_time = mktime(suspend_rtc_tm.tm_year + 1900,
+				  suspend_rtc_tm.tm_mon + 1,
+				  suspend_rtc_tm.tm_mday,
+				  suspend_rtc_tm.tm_hour,
+				  suspend_rtc_tm.tm_min,
+				  suspend_rtc_tm.tm_sec);
 
 	return 0;
 }
--- wireless-dev.orig/arch/powerpc/Kconfig	2007-05-02 16:22:07.619177080 +0200
+++ wireless-dev/arch/powerpc/Kconfig	2007-05-02 16:22:12.759177080 +0200
@@ -11,11 +11,6 @@ config PPC64
 	  This option selects whether a 32-bit or a 64-bit kernel
 	  will be built.
 
-config PPC_PM_NEEDS_RTC_LIB
-	bool
-	select RTC_LIB
-	default y if PM
-
 config PPC32
 	bool
 	default y if !PPC64
