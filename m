Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58D81DDFBE
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:24:05 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33HO0I7028364
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:24:00 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HNunj182280
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:23:56 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HNseQ027945
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:23:56 -0600
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 9/19] PCI: rpaphp: remove a call that does nothing but a
	pointer lookup
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403172354.0C35E3A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:23:54 -0500 (CDT)
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	pcihpd-discuss@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Delete another stovepipe: a call to a routine which does nothing.
Remove un-needed semaphore as well.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----

 drivers/pci/hotplug/rpaphp_core.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:25.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:26.000000000 -0500
@@ -54,11 +54,6 @@ MODULE_LICENSE("GPL");
 
 module_param(debug, bool, 0644);
 
-static int rpaphp_get_attention_status(struct slot *slot)
-{
-	return slot->hotplug_slot->info->attention_status;
-}
-
 /**
  * set_attention_status - set attention LED
  * echo 0 > attention -- set LED OFF
@@ -95,8 +90,6 @@ static int set_attention_status(struct h
  * get_power_status - get power status of a slot
  * @hotplug_slot: slot to get status
  * @value: pointer to store status
- *
- *
  */
 static int get_power_status(struct hotplug_slot *hotplug_slot, u8 * value)
 {
@@ -113,18 +106,12 @@ static int get_power_status(struct hotpl
 
 /**
  * get_attention_status - get attention LED status
- *
- *
  */
 static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 * value)
 {
-	int retval = 0;
 	struct slot *slot = (struct slot *)hotplug_slot->private;
-
-	down(&rpaphp_sem);
-	*value = rpaphp_get_attention_status(slot);
-	up(&rpaphp_sem);
-	return retval;
+	*value = slot->hotplug_slot->info->attention_status;
+	return 0;
 }
 
 static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 * value)
