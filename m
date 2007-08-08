Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 031DADDEEB
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 06:01:22 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78K1J0q008453
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 16:01:19 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78K1ILQ027332
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:01:18 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78K1Isn000919
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:01:18 -0600
Date: Wed, 8 Aug 2007 15:01:15 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/6] pseries: avoid excess rtas calls
Message-ID: <20070808200115.GA20134@austin.ibm.com>
References: <20070808195916.GA20055@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070808195916.GA20055@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We don't need to look up the rtas event token once per 
cpu per second. This avoids some misc string ops and 
rtas calls and provides some minor performance improvement.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/rtasd.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/platforms/pseries/rtasd.c	2007-07-08 18:32:17.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/platforms/pseries/rtasd.c	2007-08-07 17:57:13.000000000 -0500
@@ -44,10 +44,13 @@ static unsigned long rtas_log_start;
 static unsigned long rtas_log_size;
 
 static int surveillance_timeout = -1;
-static unsigned int rtas_event_scan_rate;
 static unsigned int rtas_error_log_max;
 static unsigned int rtas_error_log_buffer_max;
 
+/* RTAS service tokens */
+static unsigned int event_scan;
+static unsigned int rtas_event_scan_rate;
+
 static int full_rtas_msgs = 0;
 
 extern int no_logging;
@@ -381,7 +384,7 @@ static int get_eventscan_parms(void)
 	return 0;
 }
 
-static void do_event_scan(int event_scan)
+static void do_event_scan(void)
 {
 	int error;
 	do {
@@ -408,7 +411,7 @@ static void do_event_scan_all_cpus(long 
 	cpu = first_cpu(cpu_online_map);
 	for (;;) {
 		set_cpus_allowed(current, cpumask_of_cpu(cpu));
-		do_event_scan(rtas_token("event-scan"));
+		do_event_scan();
 		set_cpus_allowed(current, CPU_MASK_ALL);
 
 		/* Drop hotplug lock, and sleep for the specified delay */
@@ -426,12 +429,11 @@ static void do_event_scan_all_cpus(long 
 static int rtasd(void *unused)
 {
 	unsigned int err_type;
-	int event_scan = rtas_token("event-scan");
 	int rc;
 
 	daemonize("rtasd");
 
-	if (event_scan == RTAS_UNKNOWN_SERVICE || get_eventscan_parms() == -1)
+	if (get_eventscan_parms() == -1)
 		goto error;
 
 	rtas_log_buf = vmalloc(rtas_error_log_buffer_max*LOG_NUMBER);
@@ -486,7 +488,8 @@ static int __init rtas_init(void)
 		return 0;
 
 	/* No RTAS */
-	if (rtas_token("event-scan") == RTAS_UNKNOWN_SERVICE) {
+	event_scan = rtas_token("event-scan");
+	if (event_scan == RTAS_UNKNOWN_SERVICE) {
 		printk(KERN_DEBUG "rtasd: no event-scan on system\n");
 		return -ENODEV;
 	}
