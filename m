Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3BC4C67A73
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 05:29:57 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5JJTp3C006989
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 15:29:51 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5JJU0lD117244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 13:30:00 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5JJTp4g004811
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 13:29:51 -0600
Date: Mon, 19 Jun 2006 14:29:50 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH]: powerpc: pseries: Print PCI slot location code on failure
Message-ID: <20060619192950.GB9200@austin.ibm.com>
References: <20060615221527.GD12389@austin.ibm.com>
	<17553.57932.127038.417630@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17553.57932.127038.417630@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 16, 2006 at 08:42:20AM +1000, Paul Mackerras wrote:
> Linas Vepstas writes:
> 
> > Resending an older patch (from 28 April) that seems to have fallen
> > through the cracks, its not in mailine, is not in -mm and its not
> > controversial (its mostly a printk change). Tested.
> 
> I don't like doing printk on things that might be NULL (i.e. the
> result of get_property).  Even though printk doesn't crash, it would
> be nicer for the user to see "location=unknown" or something rather
> than "location=<NULL>".

Right. Revised patch below.
--------------

[PATCH]: powerpc/pseries: Print PCI slot location code on failure

The PCI error recovery code will printk diagnostic info when
a PCI error event occurs. Change the messages to include the slot
location code, which is how most sysadmins will know the device.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |   35 +++++++++++++++++-----------
 1 files changed, 22 insertions(+), 13 deletions(-)

Index: linux-2.6.17-rc6-mm2/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-06-13 18:13:26.000000000 -0500
+++ linux-2.6.17-rc6-mm2/arch/powerpc/platforms/pseries/eeh_driver.c	2006-06-16 13:51:44.000000000 -0500
@@ -261,16 +261,22 @@ struct pci_dn * handle_eeh_events (struc
 	struct pci_bus *frozen_bus;
 	int rc = 0;
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
-	const char *pci_str, *drv_str;
+	const char *location, *pci_str, *drv_str;
 
 	frozen_dn = find_device_pe(event->dn);
 	frozen_bus = pcibios_find_pci_bus(frozen_dn);
 
 	if (!frozen_dn) {
-		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint for %s\n",
-		        pci_name(event->dev));
+
+		location = (char *) get_property(event->dn, "ibm,loc-code", NULL);
+		location = location ? location : "unknown"; 
+		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint "
+		                "for location=%s pci addr=%s\n",
+		        location, pci_name(event->dev));
 		return NULL;
 	}
+	location = (char *) get_property(frozen_dn, "ibm,loc-code", NULL);
+	location = location ? location : "unknown"; 
 
 	/* There are two different styles for coming up with the PE.
 	 * In the old style, it was the highest EEH-capable device
@@ -282,8 +288,9 @@ struct pci_dn * handle_eeh_events (struc
 		frozen_bus = pcibios_find_pci_bus (frozen_dn->parent);
 
 	if (!frozen_bus) {
-		printk(KERN_ERR "EEH: Cannot find PCI bus for %s\n",
-		        frozen_dn->full_name);
+		printk(KERN_ERR "EEH: Cannot find PCI bus "
+		        "for location=%s dn=%s\n",
+		        location, frozen_dn->full_name);
 		return NULL;
 	}
 
@@ -318,8 +325,9 @@ struct pci_dn * handle_eeh_events (struc
 
 	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
 	printk(KERN_WARNING
-	   "EEH: This PCI device has failed %d times since last reboot: %s - %s\n",
-		frozen_pdn->eeh_freeze_count, drv_str, pci_str);
+	   "EEH: This PCI device has failed %d times since last reboot: "
+		"location=%s driver=%s pci addr=%s\n",
+		frozen_pdn->eeh_freeze_count, location, drv_str, pci_str);
 
 	/* Walk the various device drivers attached to this slot through
 	 * a reset sequence, giving each an opportunity to do what it needs
@@ -368,17 +376,18 @@ excess_failures:
 	 * due to actual, failed cards.
 	 */
 	printk(KERN_ERR
-	   "EEH: PCI device %s - %s has failed %d times \n"
-	   "and has been permanently disabled.  Please try reseating\n"
-	   "this device or replacing it.\n",
-		drv_str, pci_str, frozen_pdn->eeh_freeze_count);
+	   "EEH: PCI device at location=%s driver=%s pci addr=%s \n"
+		"has failed %d times and has been permanently disabled. \n"
+		"Please try reseating this device or replacing it.\n",
+		location, drv_str, pci_str, frozen_pdn->eeh_freeze_count);
 	goto perm_error;
 
 hard_fail:
 	printk(KERN_ERR
-	   "EEH: Unable to recover from failure of PCI device %s - %s\n"
+	   "EEH: Unable to recover from failure of PCI device "
+	   "at location=%s driver=%s pci addr=%s \n"
 	   "Please try reseating this device or replacing it.\n",
-		drv_str, pci_str);
+		location, drv_str, pci_str);
 
 perm_error:
 	eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
