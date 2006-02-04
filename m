Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B665689C0
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Feb 2006 21:05:39 +1100 (EST)
Date: Sat, 4 Feb 2006 11:05:33 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] restore clock speed in /proc/cpuinfo
Message-ID: <20060204100533.GA16878@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Use generic_calibrate_decr to restore missing clock: speed in /proc/cpuinfo

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/platforms/chrp/chrp.h  |    1 -
 arch/powerpc/platforms/chrp/setup.c |    2 +-
 arch/powerpc/platforms/chrp/time.c  |   21 ---------------------
 3 files changed, 1 insertion(+), 23 deletions(-)

Index: linux-2.6.16-rc2-olh/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/chrp/setup.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/chrp/setup.c
@@ -506,7 +506,7 @@ void __init chrp_init(void)
 	ppc_md.halt           = rtas_halt;
 
 	ppc_md.time_init      = chrp_time_init;
-	ppc_md.calibrate_decr = chrp_calibrate_decr;
+	ppc_md.calibrate_decr = generic_calibrate_decr;
 
 	/* this may get overridden with rtas routines later... */
 	ppc_md.set_rtc_time   = chrp_set_rtc_time;
Index: linux-2.6.16-rc2-olh/arch/powerpc/platforms/chrp/time.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/chrp/time.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/chrp/time.c
@@ -167,24 +167,3 @@ void chrp_get_rtc_time(struct rtc_time *
 	tm->tm_mon = mon;
 	tm->tm_year = year;
 }
-
-
-void __init chrp_calibrate_decr(void)
-{
-	struct device_node *cpu;
-	unsigned int freq, *fp;
-
-	/*
-	 * The cpu node should have a timebase-frequency property
-	 * to tell us the rate at which the decrementer counts.
-	 */
-	freq = 16666000;		/* hardcoded default */
-	cpu = find_type_devices("cpu");
-	if (cpu != 0) {
-		fp = (unsigned int *)
-			get_property(cpu, "timebase-frequency", NULL);
-		if (fp != 0)
-			freq = *fp;
-	}
-	ppc_tb_freq = freq;
-}
Index: linux-2.6.16-rc2-olh/arch/powerpc/platforms/chrp/chrp.h
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/chrp/chrp.h
+++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/chrp/chrp.h
@@ -5,7 +5,6 @@
 extern void chrp_nvram_init(void);
 extern void chrp_get_rtc_time(struct rtc_time *);
 extern int chrp_set_rtc_time(struct rtc_time *);
-extern void chrp_calibrate_decr(void);
 extern long chrp_time_init(void);
 
 extern void chrp_find_bridges(void);
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
