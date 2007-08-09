Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A403FDDF15
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 06:56:46 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l79KufJO016086
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 16:56:41 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l79KufbL161860
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 14:56:41 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l79KufFQ017786
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 14:56:41 -0600
Date: Thu, 9 Aug 2007 15:56:41 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/6 v2] pseries: eliminate global var
Message-ID: <20070809205641.GW25995@austin.ibm.com>
References: <20070808195916.GA20055@austin.ibm.com>
	<20070808200115.GA20134@austin.ibm.com>
	<20070808200210.GB20134@austin.ibm.com>
	<20070808200337.GC20134@austin.ibm.com>
	<20070808200448.GD20134@austin.ibm.com>
	<20070808200615.GE20134@austin.ibm.com>
	<20070808200713.GF20134@austin.ibm.com>
	<20070808215714.GB10114@localdomain>
	<20070808222223.GH25995@austin.ibm.com>
	<20070809010224.GE10114@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070809010224.GE10114@localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Eliminate the use of error_log_cnt as a global var shared across
differnt directories. Pass it as a subroutine arg instead.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----

Respin of earlier patch, with the CONFIG_PSERIES junk removed from the
header file.

 arch/powerpc/kernel/nvram_64.c         |   10 +++++-----
 arch/powerpc/platforms/pseries/rtasd.c |    7 ++++---
 include/asm-powerpc/nvram.h            |    6 ++++--
 3 files changed, 13 insertions(+), 10 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/kernel/nvram_64.c	2007-08-08 12:21:16.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/kernel/nvram_64.c	2007-08-08 12:24:01.000000000 -0500
@@ -38,8 +38,6 @@ static struct nvram_partition * nvram_pa
 static long nvram_error_log_index = -1;
 static long nvram_error_log_size = 0;
 
-extern volatile int error_log_cnt;
-
 struct err_log_info {
 	int error_type;
 	unsigned int seq_num;
@@ -627,7 +625,8 @@ void __exit nvram_cleanup(void)
  * sequence #: The unique sequence # for each event. (until it wraps)
  * error log: The error log from event_scan
  */
-int nvram_write_error_log(char * buff, int length, unsigned int err_type)
+int nvram_write_error_log(char * buff, int length,
+                          unsigned int err_type, unsigned int error_log_cnt)
 {
 	int rc;
 	loff_t tmp_index;
@@ -665,7 +664,8 @@ int nvram_write_error_log(char * buff, i
  *
  * Reads nvram for error log for at most 'length'
  */
-int nvram_read_error_log(char * buff, int length, unsigned int * err_type)
+int nvram_read_error_log(char * buff, int length,
+                         unsigned int * err_type, unsigned int * error_log_cnt)
 {
 	int rc;
 	loff_t tmp_index;
@@ -691,7 +691,7 @@ int nvram_read_error_log(char * buff, in
 		return rc;
 	}
 
-	error_log_cnt = info.seq_num;
+	*error_log_cnt = info.seq_num;
 	*err_type = info.error_type;
 
 	return 0;
Index: linux-2.6.22-git2/include/asm-powerpc/nvram.h
===================================================================
--- linux-2.6.22-git2.orig/include/asm-powerpc/nvram.h	2007-07-08 18:32:17.000000000 -0500
+++ linux-2.6.22-git2/include/asm-powerpc/nvram.h	2007-08-09 15:41:43.000000000 -0500
@@ -63,8 +63,10 @@ struct nvram_partition {
 };
 
 
-extern int nvram_write_error_log(char * buff, int length, unsigned int err_type);
-extern int nvram_read_error_log(char * buff, int length, unsigned int * err_type);
+extern int nvram_write_error_log(char * buff, int length,
+					 unsigned int err_type, unsigned int err_seq);
+extern int nvram_read_error_log(char * buff, int length,
+					 unsigned int * err_type, unsigned int *err_seq);
 extern int nvram_clear_error_log(void);
 extern struct nvram_partition *nvram_find_partition(int sig, const char *name);
 
Index: linux-2.6.22-git2/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/platforms/pseries/rtasd.c	2007-08-08 12:21:16.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/platforms/pseries/rtasd.c	2007-08-08 12:50:40.000000000 -0500
@@ -56,7 +56,7 @@ static int full_rtas_msgs = 0;
 /* Stop logging to nvram after first fatal error */
 static int no_more_logging;
 
-volatile int error_log_cnt = 0;
+static int error_log_cnt;
 
 /*
  * Since we use 32 bit RTAS, the physical address of this must be below
@@ -218,7 +218,7 @@ void pSeries_log_error(char *buf, unsign
 
 	/* Write error to NVRAM */
 	if (!no_more_logging && !(err_type & ERR_FLAG_BOOT))
-		nvram_write_error_log(buf, len, err_type);
+		nvram_write_error_log(buf, len, err_type, error_log_cnt);
 
 	/*
 	 * rtas errors can occur during boot, and we do want to capture
@@ -412,7 +412,8 @@ static int rtasd(void *unused)
 
 	/* See if we have any error stored in NVRAM */
 	memset(logdata, 0, rtas_error_log_max);
-	rc = nvram_read_error_log(logdata, rtas_error_log_max, &err_type);
+	rc = nvram_read_error_log(logdata, rtas_error_log_max,
+	                          &err_type, &error_log_cnt);
 
 	if (!rc) {
 		if (err_type != ERR_FLAG_ALREADY_LOGGED) {
