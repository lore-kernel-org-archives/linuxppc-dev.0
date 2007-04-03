Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 61690DE028
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:26:59 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l33HOiuX030496
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:24:44 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HQtST059526
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:26:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HQs7r022638
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:26:55 -0600
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 12/19] PCI: rpaphp: remove rpaphp_set_attention_status()
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403172654.336283A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:26:54 -0500 (CDT)
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


The rpaphp_set_attention_status() routine seems to be a wrapper
around a single rtas call. Abolish it.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp.h      |    1 -
 drivers/pci/hotplug/rpaphp_core.c |   21 ++++++++++-----------
 drivers/pci/hotplug/rpaphp_slot.c |   12 ------------
 3 files changed, 10 insertions(+), 24 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp.h
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp.h	2007-04-03 11:04:25.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp.h	2007-04-03 11:04:32.000000000 -0500
@@ -102,6 +102,5 @@ extern void dealloc_slot_struct(struct s
 extern struct slot *alloc_slot_struct(struct device_node *dn, int drc_index, char *drc_name, int power_domain);
 extern int rpaphp_register_slot(struct slot *slot);
 extern int rpaphp_deregister_slot(struct slot *slot);
-extern int rpaphp_set_attention_status(struct slot *slot, u8 status);
 	
 #endif				/* _PPC64PHP_H */
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:26.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:32.000000000 -0500
@@ -63,27 +63,26 @@ module_param(debug, bool, 0644);
  */
 static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
 {
-	int retval = 0;
+	int rc;
 	struct slot *slot = (struct slot *)hotplug_slot->private;
 
 	down(&rpaphp_sem);
 	switch (value) {
 	case 0:
-		retval = rpaphp_set_attention_status(slot, LED_OFF);
-		hotplug_slot->info->attention_status = 0;
-		break;
 	case 1:
-	default:
-		retval = rpaphp_set_attention_status(slot, LED_ON);
-		hotplug_slot->info->attention_status = 1;
-		break;
 	case 2:
-		retval = rpaphp_set_attention_status(slot, LED_ID);
-		hotplug_slot->info->attention_status = 2;
+		break;
+	default:
+		value = 1;
 		break;
 	}
 	up(&rpaphp_sem);
-	return retval;
+
+	rc = rtas_set_indicator(DR_INDICATOR, slot->index, value);
+	if (!rc)
+		hotplug_slot->info->attention_status = value;
+
+	return rc;
 }
 
 /**
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_slot.c	2007-04-03 11:04:23.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c	2007-04-03 11:04:32.000000000 -0500
@@ -184,15 +184,3 @@ sysfs_fail:
 	return retval;
 }
 
-int rpaphp_set_attention_status(struct slot *slot, u8 status)
-{
-	int rc;
-
-	/* status: LED_OFF or LED_ON */
-	rc = rtas_set_indicator(DR_INDICATOR, slot->index, status);
-	if (rc < 0)
-		err("slot(name=%s location=%s index=0x%x) set attention-status(%d) failed! rc=0x%x\n",
-		    slot->name, slot->location, slot->index, status, rc);
-
-	return rc;
-}
