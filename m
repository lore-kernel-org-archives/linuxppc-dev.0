Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45FBADDECD
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 09:27:05 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l79NR10F001682
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 19:27:01 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l79NR1hb263604
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 17:27:01 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l79NR1iR003625
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 17:27:01 -0600
Date: Thu, 9 Aug 2007 18:27:00 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/2] pseries: device node status can be "ok" or "okay"
Message-ID: <20070809232700.GY25995@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


It seems that some versions of firmware will report a device
node status as the string "okay". As we are not expecting this
string, the device node will be ignored by the EEH subsystem.
Which means EEH will not be enabled. 

When EEH is not enabled, PCI errors will be converted into 
Machine Check exceptions, and we'll have a very unhappy system. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----

Paul,

This is a bug with serious reprecussions ... but appearently 
affects only a few systems, so far.  I've never seen it before. 
Your pick as to whether to jam this into 2.6.23 or wait until 
later.

--linas

 arch/powerpc/platforms/pseries/eeh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.22-git2/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/platforms/pseries/eeh.c	2007-08-09 18:00:09.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/platforms/pseries/eeh.c	2007-08-09 18:03:14.000000000 -0500
@@ -955,7 +955,7 @@ static void *early_enable_eeh(struct dev
 	pdn->eeh_freeze_count = 0;
 	pdn->eeh_false_positives = 0;
 
-	if (status && strcmp(status, "ok") != 0)
+	if (status && strncmp(status, "ok", 2) != 0)
 		return NULL;	/* ignore devices with bad status */
 
 	/* Ignore bad nodes. */
