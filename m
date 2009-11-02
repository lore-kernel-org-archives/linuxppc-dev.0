Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BCDBB7C11
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  2 Nov 2009 16:11:11 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nA25B4pH025531
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Nov 2009 23:11:05 -0600
Subject: [PATCH] powerpc: Avoid giving out RTC dates below EPOCH
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Nov 2009 16:11:03 +1100
Message-ID: <1257138663.7907.32.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Doing so causes xtime to be negative which crashes the timekeeping
code in funny ways when doing suspend/resume

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 92dc844..6a7ce0e 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -777,7 +777,7 @@ int update_persistent_clock(struct timespec now)
 	return ppc_md.set_rtc_time(&tm);
 }
 
-void read_persistent_clock(struct timespec *ts)
+static void __read_persistent_clock(struct timespec *ts)
 {
 	struct rtc_time tm;
 	static int first = 1;
@@ -800,10 +800,23 @@ void read_persistent_clock(struct timespec *ts)
 		return;
 	}
 	ppc_md.get_rtc_time(&tm);
+
 	ts->tv_sec = mktime(tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday,
 			    tm.tm_hour, tm.tm_min, tm.tm_sec);
 }
 
+void read_persistent_clock(struct timespec *ts)
+{
+	__read_persistent_clock(&ts);
+
+	/* Sanitize it in case real time clock is set below EPOCH */
+	if (ts->tv_sec < 0) {
+		ts->tv_sec = 0;
+		ts->tv_nsec = 0;
+	}
+		
+}
+
 /* clocksource code */
 static cycle_t rtc_read(struct clocksource *cs)
 {
