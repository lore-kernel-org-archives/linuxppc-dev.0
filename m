Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 178F8DE060
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:50 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:39 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-10@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 10/16] xics: make printk formats fit on one line
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Several printks were broken at word boundaries for line length.   Some
even referred to old function names.   Using __func__ and changing the
text slightly for the format allows these printk formats to fit on one
line.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-10-04 21:56:17.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.c	2008-10-04 21:56:30.000000000 -0500
@@ -201,17 +201,17 @@ static void xics_unmask_irq(unsigned int
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
 	if (call_status != 0) {
-		printk(KERN_ERR "xics_enable_irq: irq=%u: ibm_set_xive "
-		       "returned %d\n", irq, call_status);
-		printk("set_xive %x, server %x\n", ibm_set_xive, server);
+		printk(KERN_ERR
+			"%s: ibm_set_xive irq %u server %x returned %d\n",
+			__func__, irq, server, call_status);
 		return;
 	}
 
 	/* Now unmask the interrupt (often a no-op) */
 	call_status = rtas_call(ibm_int_on, 1, 1, NULL, irq);
 	if (call_status != 0) {
-		printk(KERN_ERR "xics_enable_irq: irq=%u: ibm_int_on "
-		       "returned %d\n", irq, call_status);
+		printk(KERN_ERR "%s: ibm_int_on irq=%u returned %d\n",
+			__func__, irq, call_status);
 		return;
 	}
 }
@@ -232,8 +232,8 @@ static void xics_mask_real_irq(unsigned 
 
 	call_status = rtas_call(ibm_int_off, 1, 1, NULL, irq);
 	if (call_status != 0) {
-		printk(KERN_ERR "xics_disable_real_irq: irq=%u: "
-		       "ibm_int_off returned %d\n", irq, call_status);
+		printk(KERN_ERR "%s: ibm_int_off irq=%u returned %d\n",
+			__func__, irq, call_status);
 		return;
 	}
 
@@ -241,8 +241,8 @@ static void xics_mask_real_irq(unsigned 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq,
 				default_server, 0xff);
 	if (call_status != 0) {
-		printk(KERN_ERR "xics_disable_irq: irq=%u: ibm_set_xive(0xff)"
-		       " returned %d\n", irq, call_status);
+		printk(KERN_ERR "%s: ibm_set_xive(0xff) irq=%u returned %d\n",
+			__func__, irq, call_status);
 		return;
 	}
 }
@@ -346,8 +346,8 @@ static void xics_set_affinity(unsigned i
 	status = rtas_call(ibm_get_xive, 1, 3, xics_status, irq);
 
 	if (status) {
-		printk(KERN_ERR "xics_set_affinity: irq=%u ibm,get-xive "
-		       "returns %d\n", irq, status);
+		printk(KERN_ERR "%s: ibm,get-xive irq=%u returns %d\n",
+			__func__, irq, status);
 		return;
 	}
 
@@ -359,8 +359,9 @@ static void xics_set_affinity(unsigned i
 	if (irq_server == -1) {
 		char cpulist[128];
 		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
-		printk(KERN_WARNING "xics_set_affinity: No online cpus in "
-				"the mask %s for irq %d\n", cpulist, virq);
+		printk(KERN_WARNING
+			"%s: No online cpus in the mask %s for irq %d\n",
+			__func__, cpulist, virq);
 		return;
 	}
 
@@ -368,8 +369,8 @@ static void xics_set_affinity(unsigned i
 				irq, irq_server, xics_status[1]);
 
 	if (status) {
-		printk(KERN_ERR "xics_set_affinity: irq=%u ibm,set-xive "
-		       "returns %d\n", irq, status);
+		printk(KERN_ERR "%s: ibm,set-xive irq=%u returns %d\n",
+			__func__, irq, status);
 		return;
 	}
 }
@@ -829,9 +830,8 @@ void xics_migrate_irqs_away(void)
 
 		status = rtas_call(ibm_get_xive, 1, 3, xics_status, irq);
 		if (status) {
-			printk(KERN_ERR "migrate_irqs_away: irq=%u "
-					"ibm,get-xive returns %d\n",
-					virq, status);
+			printk(KERN_ERR "%s: ibm,get-xive irq=%u returns %d\n",
+					__func__, irq, status);
 			goto unlock;
 		}
 
