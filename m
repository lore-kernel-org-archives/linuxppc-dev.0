Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E954DDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 11:48:47 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1H0mfC6010135
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 19:48:41 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1H0mfJu301958
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 19:48:41 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1H0mfXU009617
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 19:48:41 -0500
Date: Fri, 16 Feb 2007 18:48:40 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc64: modify order of EEH state checking
Message-ID: <20070217004840.GN923@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,
Please apply to your ppc64 tree. 
--linas

Change the order in which pci error state is examined;
the "capabilites" is not valid if "reset state" is 5.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.20-git4/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.20-git4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-02-16 17:32:12.000000000 -0600
+++ linux-2.6.20-git4/arch/powerpc/platforms/pseries/eeh.c	2007-02-16 18:45:58.000000000 -0600
@@ -367,6 +367,14 @@ int eeh_dn_check_failure(struct device_n
 		goto dn_unlock;
 	}
 
+	/* Note that config-io to empty slots may fail;
+	 * they are empty when they don't have children. */
+	if ((rets[0] == 5) && (dn->child == NULL)) {
+		false_positives++;
+		rc = 0;
+		goto dn_unlock;
+	}
+
 	/* If EEH is not supported on this device, punt. */
 	if (rets[1] != 1) {
 		printk(KERN_WARNING "EEH: event on unsupported device, rc=%d dn=%s\n",
@@ -383,14 +391,6 @@ int eeh_dn_check_failure(struct device_n
 		goto dn_unlock;
 	}
 
-	/* Note that config-io to empty slots may fail;
-	 * we recognize empty because they don't have children. */
-	if ((rets[0] == 5) && (dn->child == NULL)) {
-		false_positives++;
-		rc = 0;
-		goto dn_unlock;
-	}
-
 	slot_resets++;
  
 	/* Avoid repeated reports of this failure, including problems
