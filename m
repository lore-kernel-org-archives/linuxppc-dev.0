Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 470DADDF17
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 06:03:44 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78K3cRw010367
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 16:03:38 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78K3cCi267532
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:03:38 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78K3bax010974
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:03:37 -0600
Date: Wed, 8 Aug 2007 15:03:37 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/6] pseries: simplify rtasd initialization
Message-ID: <20070808200337.GC20134@austin.ibm.com>
References: <20070808195916.GA20055@austin.ibm.com>
	<20070808200115.GA20134@austin.ibm.com>
	<20070808200210.GB20134@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070808200210.GB20134@austin.ibm.com>
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


Simplify rtasd initialization code; this also fixes a buglet, 
where the /proc entries weren't being cleaned up in case of 
failure.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/rtasd.c |   53 +++++++++++----------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/platforms/pseries/rtasd.c	2007-08-08 12:19:47.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/platforms/pseries/rtasd.c	2007-08-08 12:20:44.000000000 -0500
@@ -64,8 +64,6 @@ volatile int error_log_cnt = 0;
  */
 static unsigned char logdata[RTAS_ERROR_LOG_MAX];
 
-static int get_eventscan_parms(void);
-
 static char *rtas_type[] = {
 	"Unknown", "Retry", "TCE Error", "Internal Device Failure",
 	"Timeout", "Data Parity", "Address Parity", "Cache Parity",
@@ -169,9 +167,9 @@ static int log_rtas_len(char * buf)
 		len += err->extended_log_length;
 	}
 
-	if (rtas_error_log_max == 0) {
-		get_eventscan_parms();
-	}
+	if (rtas_error_log_max == 0)
+		rtas_error_log_max = rtas_get_error_log_max();
+
 	if (len > rtas_error_log_max)
 		len = rtas_error_log_max;
 
@@ -359,22 +357,6 @@ static int enable_surveillance(int timeo
 	return -1;
 }
 
-static int get_eventscan_parms(void)
-{
-	rtas_event_scan_rate = rtas_token("rtas-event-scan-rate");
-	if (rtas_event_scan_rate == RTAS_UNKNOWN_SERVICE) {
-		printk(KERN_ERR "rtasd: no rtas-event-scan-rate\n");
-		return -1;
-	}
-	DEBUG("rtas-event-scan-rate %d\n", rtas_event_scan_rate);
-
-	/* Make room for the sequence number */
-	rtas_error_log_max = rtas_get_error_log_max();
-	rtas_error_log_buffer_max = rtas_error_log_max + sizeof(int);
-
-	return 0;
-}
-
 static void do_event_scan(void)
 {
 	int error;
@@ -424,22 +406,11 @@ static int rtasd(void *unused)
 
 	daemonize("rtasd");
 
-	if (get_eventscan_parms() == -1)
-		goto error;
-
-	rtas_log_buf = vmalloc(rtas_error_log_buffer_max*LOG_NUMBER);
-	if (!rtas_log_buf) {
-		printk(KERN_ERR "rtasd: no memory\n");
-		goto error;
-	}
-
 	printk(KERN_DEBUG "RTAS daemon started\n");
-
 	DEBUG("will sleep for %d milliseconds\n", (30000/rtas_event_scan_rate));
 
 	/* See if we have any error stored in NVRAM */
 	memset(logdata, 0, rtas_error_log_max);
-
 	rc = nvram_read_error_log(logdata, rtas_error_log_max, &err_type);
 
 	/* We can use rtas_log_buf now */
@@ -466,8 +437,6 @@ static int rtasd(void *unused)
 	for (;;)
 		do_event_scan_all_cpus(30000/rtas_event_scan_rate);
 
-error:
-	/* Should delete proc entries */
 	return -EINVAL;
 }
 
@@ -485,6 +454,22 @@ static int __init rtas_init(void)
 		return -ENODEV;
 	}
 
+	rtas_event_scan_rate = rtas_token("rtas-event-scan-rate");
+	if (rtas_event_scan_rate == RTAS_UNKNOWN_SERVICE) {
+		printk(KERN_ERR "rtasd: no rtas-event-scan-rate on system\n");
+		return -ENODEV;
+	}
+
+	/* Make room for the sequence number */
+	rtas_error_log_max = rtas_get_error_log_max();
+	rtas_error_log_buffer_max = rtas_error_log_max + sizeof(int);
+
+	rtas_log_buf = vmalloc(rtas_error_log_buffer_max*LOG_NUMBER);
+	if (!rtas_log_buf) {
+		printk(KERN_ERR "rtasd: no memory\n");
+		return -ENOMEM;
+	}
+
 	entry = create_proc_entry("ppc64/rtas/error_log", S_IRUSR, NULL);
 	if (entry)
 		entry->proc_fops = &proc_rtas_log_operations;
