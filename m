Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 53DFFDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 13:09:27 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAL29NXd020078
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 21:09:23 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAL29NPj110036
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 21:09:23 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAL29Npt014962
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 21:09:23 -0500
Date: Tue, 20 Nov 2007 20:09:22 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc/pseries: tell phyp to auto-restart
Message-ID: <20071121020922.GA4374@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The pseries hypervisor attempts to detect and prevent an 
infinite loop of kernel crashes and auto-reboots. It does 
so by refusing to auto-reboot unless we indicate that the
current boot was sucessful.  So, indicate success late in
the boot sequence.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
Sigh. This is a side-effect of the patch I sent yesterday.
Its supposed to simplify the management large numbers of 
partitions. 

 arch/powerpc/platforms/pseries/setup.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

Index: linux-2.6.24-rc3-git1/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6.24-rc3-git1.orig/arch/powerpc/platforms/pseries/setup.c	2007-11-20 18:37:14.000000000 -0600
+++ linux-2.6.24-rc3-git1/arch/powerpc/platforms/pseries/setup.c	2007-11-20 19:08:12.000000000 -0600
@@ -491,6 +491,37 @@ void pSeries_power_off(void)
 	for (;;);
 }
 
+/**
+ * pSeries_auto_restart - tell hypervisor that boot succeeded.
+ *
+ * The pseries hypervisor attempts to detect and prevent an
+ * infinite loop of kernel crashes and auto-reboots. It does
+ * so by refusing to auto-reboot unless we indicate that the
+ * current boot was sucessful.  So, indicate success late in
+ * the boot sequence.
+ */
+static int __init pSeries_auto_restart(void)
+{
+	static char buff[3]; /* static so that its in RMO region */
+	int rc;
+	int token = rtas_token("ibm,set-system-parameter");
+	if (!token)
+		return 0;
+
+	/* partition_auto_restart is 21; set to to 1 to auto-restart the OS. */
+	buff[0] = 0;
+	buff[1] = 1; /* length */
+	buff[2] = 1; /* value */
+	do {
+		rc = rtas_call (token, 2, 1, NULL, 21, buff);
+	} while (rtas_busy_delay(rc));
+	if (rc)
+		printk(KERN_INFO "pSeries_auto_restart(): "
+		       "unable to setup autorestart, rc=%d\n", rc);
+	return 0;
+}
+late_initcall(pSeries_auto_restart);
+
 #ifndef CONFIG_PCI
 void pSeries_final_fixup(void) { }
 #endif
