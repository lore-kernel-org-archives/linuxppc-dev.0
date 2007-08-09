Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2D7C2DDEE9
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 09:28:14 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l79NSBhK021610
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 19:28:11 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l79NSBNB217004
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 17:28:11 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l79NSBup011562
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 17:28:11 -0600
Date: Thu, 9 Aug 2007 18:28:11 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/2] pseries: remove dead eeh video code
Message-ID: <20070809232811.GA416@austin.ibm.com>
References: <20070809232700.GY25995@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070809232700.GY25995@austin.ibm.com>
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


Remove dead code, and a misleading comment about EEH checking
for video devices.  The removed code is a left-over from the
olden days where there was concern over how video devices 
worked in Linux. We are never going to go that way again, 
so kill this.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |   17 -----------------
 1 file changed, 17 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/platforms/pseries/eeh.c	2007-08-09 18:03:14.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/platforms/pseries/eeh.c	2007-08-09 18:06:45.000000000 -0500
@@ -969,23 +969,6 @@ static void *early_enable_eeh(struct dev
 	}
 	pdn->class_code = *class_code;
 
-	/*
-	 * Now decide if we are going to "Disable" EEH checking
-	 * for this device.  We still run with the EEH hardware active,
-	 * but we won't be checking for ff's.  This means a driver
-	 * could return bad data (very bad!), an interrupt handler could
-	 * hang waiting on status bits that won't change, etc.
-	 * But there are a few cases like display devices that make sense.
-	 */
-	enable = 1;	/* i.e. we will do checking */
-#if 0
-	if ((*class_code >> 16) == PCI_BASE_CLASS_DISPLAY)
-		enable = 0;
-#endif
-
-	if (!enable)
-		pdn->eeh_mode |= EEH_MODE_NOCHECK;
-
 	/* Ok... see if this device supports EEH.  Some do, some don't,
 	 * and the only way to find out is to check each and every one. */
 	regs = of_get_property(dn, "reg", NULL);
