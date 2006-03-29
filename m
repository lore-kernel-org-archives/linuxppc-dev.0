Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 163B8679F6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 08:31:09 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2TLV5mZ016123
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 16:31:05 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2TLYCMk163780
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 14:34:12 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2TLV4ke002964
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 14:31:04 -0700
Date: Wed, 29 Mar 2006 15:31:04 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH]: powerpc/pseries: print message if EEH recovery fails
Message-ID: <20060329213104.GK2172@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,
Pleae review/apply/forward upstream.

--linas

[PATCH]: powerpc/pseries: print message if EEH recovery fails

The current code prints an ambiguous message if the recovery
of a failed PCI device fails. Give this special case its own
unique message.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

Index: linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.16-git6.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-29 14:45:42.000000000 -0600
+++ linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-29 15:02:19.648928196 -0600
@@ -301,7 +301,7 @@ void handle_eeh_events (struct eeh_event
 	}
 	
 	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
-		goto hard_fail;
+		goto excess_failures;
 
 	/* If the reset state is a '5' and the time to reset is 0 (infinity)
 	 * or is more then 15 seconds, then mark this as a permanent failure.
@@ -356,7 +356,7 @@ void handle_eeh_events (struct eeh_event
 
 	return;
 	
-hard_fail:
+excess_failures:
 	/*
 	 * About 90% of all real-life EEH failures in the field
 	 * are due to poorly seated PCI cards. Only 10% or so are
@@ -367,7 +367,15 @@ hard_fail:
 	   "and has been permanently disabled.  Please try reseating\n"
 	   "this device or replacing it.\n",
 		drv_str, pci_str, frozen_pdn->eeh_freeze_count);
+	goto perm_error;
+
+hard_fail:
+	printk(KERN_ERR
+	   "EEH: Unable to recover from failure of PCI device %s - %s\n"
+	   "Please try reseating this device or replacing it.\n",
+		drv_str, pci_str);
 
+perm_error:
 	eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
 
 	/* Notify all devices that they're about to go down. */
