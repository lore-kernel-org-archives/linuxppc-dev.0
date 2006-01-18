Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 414E2689D5
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 07:24:02 +1100 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 084E5EE93
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2006 21:23:58 +0100 (CET)
Date: Wed, 18 Jan 2006 21:23:57 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: clock speed gone from cpuinfo
Message-ID: <20060118202357.GA341@suse.de>
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


2.6.16 on 32bit doesnt report the cpu speed anymore, but it still has
the bogomips..
chrp_calibrate_decr doesnt seem to set ppc_proc_freq.

lemon:~ # cat /proc/cpuinfo
processor       : 0
cpu             : 604r
revision        : 49.2 (pvr 0009 3102)
bogomips        : 41.47
timebase        : 20781060
machine         : CHRP IBM,7046-B50
lemon:~ # dmesg | grep freq
time_init: decrementer frequency = 20.781060 MHz
time_init: processor frequency   = 0.000000 MHz





While looking at generic_calibrate_decr(), cpu and fp are pointers.

 arch/powerpc/kernel/time.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.16-rc1-olh/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.16-rc1-olh.orig/arch/powerpc/kernel/time.c
+++ linux-2.6.16-rc1-olh/arch/powerpc/kernel/time.c
@@ -612,10 +612,10 @@ void __init generic_calibrate_decr(void)
 
 	ppc_tb_freq = DEFAULT_TB_FREQ;		/* hardcoded default */
 	node_found = 0;
-	if (cpu != 0) {
+	if (cpu) {
 		fp = (unsigned int *)get_property(cpu, "timebase-frequency",
 						  NULL);
-		if (fp != 0) {
+		if (fp) {
 			node_found = 1;
 			ppc_tb_freq = *fp;
 		}
@@ -626,10 +626,10 @@ void __init generic_calibrate_decr(void)
 
 	ppc_proc_freq = DEFAULT_PROC_FREQ;
 	node_found = 0;
-	if (cpu != 0) {
+	if (cpu) {
 		fp = (unsigned int *)get_property(cpu, "clock-frequency",
 						  NULL);
-		if (fp != 0) {
+		if (fp) {
 			node_found = 1;
 			ppc_proc_freq = *fp;
 		}

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
