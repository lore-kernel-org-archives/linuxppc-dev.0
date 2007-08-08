Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1789DDEEF
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 06:06:27 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78K6OSL012378
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 16:06:24 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78K6GUh171246
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:06:17 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78K6GGq002728
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:06:16 -0600
Date: Wed, 8 Aug 2007 15:06:15 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/6] pseries: fix jumbled no_logging flag.
Message-ID: <20070808200615.GE20134@austin.ibm.com>
References: <20070808195916.GA20055@austin.ibm.com>
	<20070808200115.GA20134@austin.ibm.com>
	<20070808200210.GB20134@austin.ibm.com>
	<20070808200337.GC20134@austin.ibm.com>
	<20070808200448.GD20134@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070808200448.GD20134@austin.ibm.com>
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


Get rid of the jumbled usage of the no_logging flag. Its use 
spans several directories, and is incorrectly/misleadingly
documented. Instead, two changes:
1) nvram will accept error log as soon as its ready.
2) logging to nvram stops on the first fatal error reported.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/kernel/nvram_64.c         |    8 --------
 arch/powerpc/platforms/pseries/rtasd.c |   14 ++++++--------
 2 files changed, 6 insertions(+), 16 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/kernel/nvram_64.c	2007-08-08 12:21:05.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/kernel/nvram_64.c	2007-08-08 12:21:16.000000000 -0500
@@ -38,10 +38,6 @@ static struct nvram_partition * nvram_pa
 static long nvram_error_log_index = -1;
 static long nvram_error_log_size = 0;
 
-int no_logging = 1; 	/* Until we initialize everything,
-			 * make sure we don't try logging
-			 * anything */
-
 extern volatile int error_log_cnt;
 
 struct err_log_info {
@@ -637,10 +633,6 @@ int nvram_write_error_log(char * buff, i
 	loff_t tmp_index;
 	struct err_log_info info;
 	
-	if (no_logging) {
-		return -EPERM;
-	}
-
 	if (nvram_error_log_index == -1) {
 		return -ESPIPE;
 	}
Index: linux-2.6.22-git2/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/platforms/pseries/rtasd.c	2007-08-08 12:20:44.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/platforms/pseries/rtasd.c	2007-08-08 12:21:16.000000000 -0500
@@ -53,7 +53,8 @@ static unsigned int rtas_event_scan_rate
 
 static int full_rtas_msgs = 0;
 
-extern int no_logging;
+/* Stop logging to nvram after first fatal error */
+static int no_more_logging;
 
 volatile int error_log_cnt = 0;
 
@@ -216,7 +217,7 @@ void pSeries_log_error(char *buf, unsign
 	}
 
 	/* Write error to NVRAM */
-	if (!no_logging && !(err_type & ERR_FLAG_BOOT))
+	if (!no_more_logging && !(err_type & ERR_FLAG_BOOT))
 		nvram_write_error_log(buf, len, err_type);
 
 	/*
@@ -228,8 +229,8 @@ void pSeries_log_error(char *buf, unsign
 		printk_log_rtas(buf, len);
 
 	/* Check to see if we need to or have stopped logging */
-	if (fatal || no_logging) {
-		no_logging = 1;
+	if (fatal || no_more_logging) {
+		no_more_logging = 1;
 		spin_unlock_irqrestore(&rtasd_log_lock, s);
 		return;
 	}
@@ -301,7 +302,7 @@ static ssize_t rtas_log_read(struct file
 
 	spin_lock_irqsave(&rtasd_log_lock, s);
 	/* if it's 0, then we know we got the last one (the one in NVRAM) */
-	if (rtas_log_size == 0 && !no_logging)
+	if (rtas_log_size == 0 && !no_more_logging)
 		nvram_clear_error_log();
 	spin_unlock_irqrestore(&rtasd_log_lock, s);
 
@@ -413,9 +414,6 @@ static int rtasd(void *unused)
 	memset(logdata, 0, rtas_error_log_max);
 	rc = nvram_read_error_log(logdata, rtas_error_log_max, &err_type);
 
-	/* We can use rtas_log_buf now */
-	no_logging = 0;
-
 	if (!rc) {
 		if (err_type != ERR_FLAG_ALREADY_LOGGED) {
 			pSeries_log_error(logdata, err_type | ERR_FLAG_BOOT, 0);
