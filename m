Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EB6E8DDFA5
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:34:20 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33HYGeW029223
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:34:16 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HXtcI305862
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:33:55 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HXscN031630
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:33:55 -0400
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 19/19] PCI: rpaphp: Remove semaphores
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403173354.8DD073A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:33:54 -0500 (CDT)
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


Remove the semaphores from the get routine. These do not 
appear to be protecting anything that I can make out, 
and they also do not seem to be required by the hotplug
driver.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp_core.c |   38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:47.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:51.000000000 -0500
@@ -39,7 +39,6 @@
 #include "rpaphp.h"
 
 int debug;
-static struct semaphore rpaphp_sem;
 LIST_HEAD(rpaphp_slot_head);
 
 #define DRIVER_VERSION	"0.1"
@@ -66,7 +65,6 @@ static int set_attention_status(struct h
 	int rc;
 	struct slot *slot = (struct slot *)hotplug_slot->private;
 
-	down(&rpaphp_sem);
 	switch (value) {
 	case 0:
 	case 1:
@@ -76,7 +74,6 @@ static int set_attention_status(struct h
 		value = 1;
 		break;
 	}
-	up(&rpaphp_sem);
 
 	rc = rtas_set_indicator(DR_INDICATOR, slot->index, value);
 	if (!rc)
@@ -95,11 +92,9 @@ static int get_power_status(struct hotpl
 	int retval, level;
 	struct slot *slot = (struct slot *)hotplug_slot->private;
 
-	down(&rpaphp_sem);
 	retval = rtas_get_power_level (slot->power_domain, &level);
 	if (!retval)
 		*value = level;
-	up(&rpaphp_sem);
 	return retval;
 }
 
@@ -118,9 +113,7 @@ static int get_adapter_status(struct hot
 	struct slot *slot = (struct slot *)hotplug_slot->private;
 	int rc, state;
 
-	down(&rpaphp_sem);
 	rc = rpaphp_get_sensor_state(slot, &state);
-	up(&rpaphp_sem);
 
 	*value = NOT_VALID;
 	if (rc)
@@ -138,7 +131,6 @@ static int get_max_bus_speed(struct hotp
 {
 	struct slot *slot = (struct slot *)hotplug_slot->private;
 
-	down(&rpaphp_sem);
 	switch (slot->type) {
 	case 1:
 	case 2:
@@ -169,7 +161,6 @@ static int get_max_bus_speed(struct hotp
 		break;
 
 	}
-	up(&rpaphp_sem);
 	return 0;
 }
 
@@ -374,7 +365,6 @@ static int __init rpaphp_init(void)
 	struct device_node *dn = NULL;
 
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
-	init_MUTEX(&rpaphp_sem);
 
 	while ((dn = of_find_node_by_name(dn, "pci")))
 		rpaphp_add_slot(dn);
@@ -387,8 +377,9 @@ static void __exit rpaphp_exit(void)
 	cleanup_slots();
 }
 
-static int __enable_slot(struct slot *slot)
+static int enable_slot(struct hotplug_slot *hotplug_slot)
 {
+	struct slot *slot = (struct slot *)hotplug_slot->private;
 	int state;
 	int retval;
 
@@ -412,20 +403,9 @@ static int __enable_slot(struct slot *sl
 	return 0;
 }
 
-static int enable_slot(struct hotplug_slot *hotplug_slot)
+static int disable_slot(struct hotplug_slot *hotplug_slot)
 {
-	int retval;
 	struct slot *slot = (struct slot *)hotplug_slot->private;
-
-	down(&rpaphp_sem);
-	retval = __enable_slot(slot);
-	up(&rpaphp_sem);
-
-	return retval;
-}
-
-static inline int __disable_slot(struct slot *slot)
-{
 	if (slot->state == NOT_CONFIGURED)
 		return -EINVAL;
 
@@ -434,18 +414,6 @@ static inline int __disable_slot(struct 
 	return 0;
 }
 
-static int disable_slot(struct hotplug_slot *hotplug_slot)
-{
-	struct slot *slot = (struct slot *)hotplug_slot->private;
-	int retval;
-
-	down(&rpaphp_sem);
-	retval = __disable_slot (slot);
-	up(&rpaphp_sem);
-
-	return retval;
-}
-
 struct hotplug_slot_ops rpaphp_hotplug_slot_ops = {
 	.owner = THIS_MODULE,
 	.enable_slot = enable_slot,
