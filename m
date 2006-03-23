Return-Path: <haren@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1422467AC7
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 16:18:37 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2N5IZPK006536
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 00:18:35 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2N5FXOa263772
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 22:15:33 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2N5IYJ3003645
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 22:18:35 -0700
Message-ID: <44222FA0.90902@us.ibm.com>
Date: Wed, 22 Mar 2006 21:18:24 -0800
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] kdump: clear and EOI IPI for kexec CPU
Content-Type: multipart/mixed; boundary="------------020100020604050304050102"
Cc: linuxppc-dev@ozlabs.org, ellerman@au1.ibm.com,
	Milton Miller <miltonm@bga.com>, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020100020604050304050102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Paul, Sorry, Please ignore the previous patch since it has one tab/space 
issue. Tested this one and kdump-dma-fault-fix.patch on P5, P4 
(non-lpar), JS21 and JS20.

Thanks
Haren

Some times, the kexec CPU is not reponding to an IPI during kdump boot. 
It is causing the system in xmon. Noticed on power-4 (non-lpar). This 
patch clears and EOI IPI for kexec CPU as well before the kdump boot 
started.

Signed-off-by: Haren Myneni <haren@us.ibm.com>


--------------020100020604050304050102
Content-Type: text/x-patch;
 name="kdump-clear-IPI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdump-clear-IPI.patch"

--- 2616-git5-k1/arch/powerpc/platforms/pseries/xics.c.orig	2006-04-04 19:27:24.000000000 -0700
+++ 2616-git5-k1/arch/powerpc/platforms/pseries/xics.c	2006-04-04 20:06:19.000000000 -0700
@@ -641,22 +641,27 @@ void xics_teardown_cpu(int secondary)
 	iosync();
 
 	/*
+	 * Clear IPI
+	 */
+	ops->qirr_info(cpu, 0xff);
+	/*
+	 * we need to EOI the IPI if we got here from kexec down IPI
+	 *
+	 * probably need to check all the other interrupts too
+	 * should we be flagging idle loop instead?
+	 * or creating some task to be scheduled?
+	 */
+	ops->xirr_info_set(cpu, XICS_IPI);
+
+	/*
 	 * Some machines need to have at least one cpu in the GIQ,
 	 * so leave the master cpu in the group.
 	 */
-	if (secondary) {
-		/*
-		 * we need to EOI the IPI if we got here from kexec down IPI
-		 *
-		 * probably need to check all the other interrupts too
-		 * should we be flagging idle loop instead?
-		 * or creating some task to be scheduled?
-		 */
-		ops->xirr_info_set(cpu, XICS_IPI);
+	if (secondary) 
 		rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
 			(1UL << interrupt_server_size) - 1 -
 			default_distrib_server, 0);
-	}
+	
 }
 
 #ifdef CONFIG_HOTPLUG_CPU

--------------020100020604050304050102--
