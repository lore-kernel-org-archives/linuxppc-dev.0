Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A593DDE38
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:34:43 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48NYehJ002414
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:34:40 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l48NYerR541012
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:34:40 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l48NYetX008630
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:34:40 -0400
Date: Tue, 8 May 2007 18:34:40 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/4] powerpc: EEH: Split up long error msg
Message-ID: <20070508233440.GQ4452@austin.ibm.com>
References: <20070508230952.GN4452@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508230952.GN4452@austin.ibm.com>
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


Make some minor adjustments to the EEH error messages.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.21-rc7-mm2.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-04-26 16:19:02.000000000 -0500
+++ linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh_driver.c	2007-04-26 16:19:23.000000000 -0500
@@ -362,9 +362,11 @@ struct pci_dn * handle_eeh_events (struc
 	}
 
 	printk(KERN_WARNING
-	   "EEH: This PCI device has failed %d times since last reboot: "
-		"location=%s driver=%s pci addr=%s\n",
-		frozen_pdn->eeh_freeze_count, location, drv_str, pci_str);
+	   "EEH: This PCI device has failed %d times in the last hour:\n",
+		frozen_pdn->eeh_freeze_count);
+	printk(KERN_WARNING
+		"EEH: location=%s driver=%s pci addr=%s\n",
+		location, drv_str, pci_str);
 
 	/* Walk the various device drivers attached to this slot through
 	 * a reset sequence, giving each an opportunity to do what it needs
