Return-Path: <nfont@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B556DEA5A
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 04:27:09 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6PIR3B4025540
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 14:27:03 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6PIR3Ht170804
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 12:27:03 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6PIR37L011455
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 12:27:03 -0600
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m6PIR3PS011444
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 12:27:03 -0600
Received: from [9.53.40.161] (mudbug-009053040161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m6PIR2XS061968
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 13:27:02 -0500
Message-ID: <488A1AFA.3010901@austin.ibm.com>
Date: Fri, 25 Jul 2008 13:27:06 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Allow non-hcall return values for lparcfg writes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code to handle writes to /proc/ppc64/lparcfg incorrectly
assumes that the return code from the helper routines to update
processor or memory entitlement return a hcall return value. It
then assumes any non-hcall return value is bad and sets the return
code for the write to be -EIO.

The update_[mp]pp routines can return values other than a hcall
return value. This patch removes the automatic setting of any
return code that is not an hcall return value from these routines
to -EIO.

NOTE: This patch applies on top of the CMO patches and my previous
patch for lparcfg.c.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: linux-2.6.git/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/lparcfg.c	2008-07-23 13:40:50.000000000 -0500
+++ linux-2.6.git/arch/powerpc/kernel/lparcfg.c	2008-07-25 13:06:06.000000000 -0500
@@ -636,10 +636,6 @@
 		retval = -EIO;
 	} else if (retval == H_PARAMETER) {
 		retval = -EINVAL;
-	} else {
-		printk(KERN_WARNING "%s: received unknown hv return code %ld",
-		       __func__, retval);
-		retval = -EIO;
 	}
 
 	return retval;
