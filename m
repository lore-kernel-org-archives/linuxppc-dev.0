Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 582A9DDF04
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 06:02:14 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78K2BCx031438
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 16:02:11 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78K2AWh530000
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 16:02:10 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78K2AWI030193
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 16:02:10 -0400
Date: Wed, 8 Aug 2007 15:02:10 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/6] pseries: use rtas_token instead of hand-rolled code
Message-ID: <20070808200210.GB20134@austin.ibm.com>
References: <20070808195916.GA20055@austin.ibm.com>
	<20070808200115.GA20134@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070808200115.GA20134@austin.ibm.com>
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


The rtas_token() call does the same thing as this hand-rolled code.
This makes the code easier to read.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/rtasd.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/platforms/pseries/rtasd.c	2007-08-07 17:57:13.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/platforms/pseries/rtasd.c	2007-08-07 17:57:49.000000000 -0500
@@ -361,26 +361,17 @@ static int enable_surveillance(int timeo
 
 static int get_eventscan_parms(void)
 {
-	struct device_node *node;
-	const int *ip;
-
-	node = of_find_node_by_path("/rtas");
-
-	ip = of_get_property(node, "rtas-event-scan-rate", NULL);
-	if (ip == NULL) {
+	rtas_event_scan_rate = rtas_token("rtas-event-scan-rate");
+	if (rtas_event_scan_rate == RTAS_UNKNOWN_SERVICE) {
 		printk(KERN_ERR "rtasd: no rtas-event-scan-rate\n");
-		of_node_put(node);
 		return -1;
 	}
-	rtas_event_scan_rate = *ip;
 	DEBUG("rtas-event-scan-rate %d\n", rtas_event_scan_rate);
 
 	/* Make room for the sequence number */
 	rtas_error_log_max = rtas_get_error_log_max();
 	rtas_error_log_buffer_max = rtas_error_log_max + sizeof(int);
 
-	of_node_put(node);
-
 	return 0;
 }
 
