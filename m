Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 81F4DDDDE4
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:33:37 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48NXT65003424
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:33:29 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l48NXTlo179058
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 17:33:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l48NXTP6009406
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 17:33:29 -0600
Date: Tue, 8 May 2007 18:33:29 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/4] powerpc: EEH: log error only after driver notification.
Message-ID: <20070508233329.GP4452@austin.ibm.com>
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


It turns out many/most versions of firmware enable MMIO when
the slto-error-detail rtas call is made (in violation of the
architecture). Thus, it would be best to call slot-error-detail
only after notifying device drivers of a freeze, as otherwise,
a variety of strange and unexpected things may happen.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.21-rc7-mm2.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-05-08 17:55:43.000000000 -0500
+++ linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh_driver.c	2007-05-08 17:56:42.000000000 -0500
@@ -361,7 +361,6 @@ struct pci_dn * handle_eeh_events (struc
 		goto hard_fail;
 	}
 
-	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
 	printk(KERN_WARNING
 	   "EEH: This PCI device has failed %d times since last reboot: "
 		"location=%s driver=%s pci addr=%s\n",
@@ -375,6 +374,11 @@ struct pci_dn * handle_eeh_events (struc
 	 */
 	pci_walk_bus(frozen_bus, eeh_report_error, &result);
 
+	/* Since rtas may enable MMIO when posting the error log,
+	 * don't post the error log until after all dev drivers
+	 * have been informed. */
+	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
+
 	/* If all device drivers were EEH-unaware, then shut
 	 * down all of the device drivers, and hope they
 	 * go down willingly, without panicing the system.
