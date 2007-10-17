Return-Path: <pbadari@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36689DDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 09:06:22 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9HN6JSo014624
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 19:06:19 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9HN6IIe362690
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 17:06:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9HN6ITf016624
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 17:06:18 -0600
Subject: [PATCH] Move _rtc_time() routines under CONFIG_ADB_CUDA
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 17 Oct 2007 16:09:38 -0700
Message-Id: <1192662578.14504.11.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix to clean up compile warnings (against 2.6.23-git12)

Thanks,
Badari

to_rtc_time() and from_rtc_time() seems to be used only if CONFIG_ADB_CUDA
defined. Moving them under that ifdef.

arch/powerpc/platforms/powermac/time.c:88: warning: `to_rtc_time' defined but not used
arch/powerpc/platforms/powermac/time.c:95: warning: `from_rtc_time' defined but not used

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
---
 arch/powerpc/platforms/powermac/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.23/arch/powerpc/platforms/powermac/time.c
===================================================================
--- linux-2.6.23.orig/arch/powerpc/platforms/powermac/time.c	2007-10-09 13:31:38.000000000 -0700
+++ linux-2.6.23/arch/powerpc/platforms/powermac/time.c	2007-10-17 15:59:56.000000000 -0700
@@ -84,6 +84,7 @@ long __init pmac_time_init(void)
 	return delta;
 }
 
+#ifdef CONFIG_ADB_CUDA
 static void to_rtc_time(unsigned long now, struct rtc_time *tm)
 {
 	to_tm(now, tm);
@@ -97,7 +98,6 @@ static unsigned long from_rtc_time(struc
 		      tm->tm_hour, tm->tm_min, tm->tm_sec);
 }
 
-#ifdef CONFIG_ADB_CUDA
 static unsigned long cuda_get_time(void)
 {
 	struct adb_request req;
