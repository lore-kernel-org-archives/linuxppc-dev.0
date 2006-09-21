Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A53867BE1
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 09:25:59 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8LNPuWL018631
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 19:25:56 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8LNPukK233106
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 17:25:56 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8LNPuSN032351
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 17:25:56 -0600
Date: Thu, 21 Sep 2006 18:25:56 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH]: PowerPC: EEH: Power4 systems sometimes need multiple resets.
Message-ID: <20060921232556.GX29167@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul, 

Please apply and forward upsteam.
This is a non-urgent fix that can be queued for later.
--linas

On detection of an EEH error, some Power4 systems seem to occasionally
want to be reset twice before they report themselves as fully recovered.
This patch re-arranges the code to attempt additional resets if the first
one doesn't take. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |   36 +++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

Index: linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.18-rc7-git1.orig/arch/powerpc/platforms/pseries/eeh.c	2006-09-21 18:22:51.000000000 -0500
+++ linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh.c	2006-09-21 18:23:00.000000000 -0500
@@ -485,7 +485,7 @@ eeh_slot_availability(struct pci_dn *pdn
 
 	printk (KERN_ERR "EEH: Slot unavailable: rc=%d, rets=%d %d %d\n",
 		rc, rets[0], rets[1], rets[2]);
-	return -1;
+	return -2;
 }
 
 /**
@@ -553,11 +553,10 @@ rtas_pci_slot_reset(struct pci_dn *pdn, 
 	               BUID_HI(pdn->phb->buid),
 	               BUID_LO(pdn->phb->buid),
 	               state);
-	if (rc) {
-		printk (KERN_WARNING "EEH: Unable to reset the failed slot, (%d) #RST=%d dn=%s\n", 
+	if (rc)
+		printk (KERN_WARNING "EEH: Unable to reset the failed slot,"
+		        " (%d) #RST=%d dn=%s\n",
 		        rc, state, pdn->node->full_name);
-		return;
-	}
 }
 
 /**
@@ -567,11 +566,8 @@ rtas_pci_slot_reset(struct pci_dn *pdn, 
  *  Return 0 if success, else a non-zero value.
  */
 
-int
-rtas_set_slot_reset(struct pci_dn *pdn)
+static void __rtas_set_slot_reset(struct pci_dn *pdn)
 {
-	int i, rc;
-
 	rtas_pci_slot_reset (pdn, 1);
 
 	/* The PCI bus requires that the reset be held high for at least
@@ -592,17 +588,33 @@ rtas_set_slot_reset(struct pci_dn *pdn)
 	 * up traffic. */
 #define PCI_BUS_SETTLE_TIME_MSEC 1800
 	msleep (PCI_BUS_SETTLE_TIME_MSEC);
+}
+
+int rtas_set_slot_reset(struct pci_dn *pdn)
+{
+	int i, rc;
+
+	__rtas_set_slot_reset(pdn);
 
 	/* Now double check with the firmware to make sure the device is
 	 * ready to be used; if not, wait for recovery. */
 	for (i=0; i<10; i++) {
 		rc = eeh_slot_availability (pdn);
-		if (rc < 0)
-			printk (KERN_ERR "EEH: failed (%d) to reset slot %s\n", rc, pdn->node->full_name);
 		if (rc == 0)
 			return 0;
-		if (rc < 0)
+
+		if (rc == -2) {
+			printk (KERN_ERR "EEH: failed (%d) to reset slot %s\n",
+			        i, pdn->node->full_name);
+			__rtas_set_slot_reset(pdn);
+			continue;
+		}
+
+		if (rc < 0) {
+			printk (KERN_ERR "EEH: unrecoverable slot failure %s\n",
+			        pdn->node->full_name);
 			return -1;
+		}
 
 		msleep (rc+100);
 	}
