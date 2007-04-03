Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 242ADDDF6B
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:21:58 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33HLtAg027899
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:21:55 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HLtnH161530
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:21:55 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HLs7p002329
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:21:54 -0600
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 7/19] PCI: rpaphp: Remve another call that is a wrapper
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403172153.E452D3A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:21:53 -0500 (CDT)
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


Remove another stovepipe: a call which wraps another call, and
just adds printks.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp.h      |    1 -
 drivers/pci/hotplug/rpaphp_core.c |    6 ++++--
 drivers/pci/hotplug/rpaphp_pci.c  |    7 ++++++-
 drivers/pci/hotplug/rpaphp_slot.c |   18 ------------------
 4 files changed, 10 insertions(+), 22 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:21.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:23.000000000 -0500
@@ -183,9 +183,14 @@ exit_rc:
 
 int rpaphp_register_pci_slot(struct slot *slot)
 {
+	int rc, level;
 	struct hotplug_slot_info *info = slot->hotplug_slot->info;
 
-	rpaphp_get_power_status(slot, &info->power_status);
+	rc = rtas_get_power_level(slot->power_domain, &level);
+	if (rc)
+		return rc;
+	info->power_status = level;
+
 	rpaphp_get_pci_adapter_status(slot, 1, &info->adapter_status);
 
 	if (info->adapter_status == NOT_VALID) {
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp.h
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp.h	2007-04-03 11:04:08.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp.h	2007-04-03 11:04:23.000000000 -0500
@@ -103,7 +103,6 @@ extern void dealloc_slot_struct(struct s
 extern struct slot *alloc_slot_struct(struct device_node *dn, int drc_index, char *drc_name, int power_domain);
 extern int rpaphp_register_slot(struct slot *slot);
 extern int rpaphp_deregister_slot(struct slot *slot);
-extern int rpaphp_get_power_status(struct slot *slot, u8 * value);
 extern int rpaphp_set_attention_status(struct slot *slot, u8 status);
 	
 #endif				/* _PPC64PHP_H */
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:16.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:23.000000000 -0500
@@ -100,11 +100,13 @@ static int set_attention_status(struct h
  */
 static int get_power_status(struct hotplug_slot *hotplug_slot, u8 * value)
 {
-	int retval;
+	int retval, level;
 	struct slot *slot = (struct slot *)hotplug_slot->private;
 
 	down(&rpaphp_sem);
-	retval = rpaphp_get_power_status(slot, value);
+	retval = rtas_get_power_level (slot->power_domain, &level);
+	if (!retval)
+		*value = level;
 	up(&rpaphp_sem);
 	return retval;
 }
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_slot.c	2007-04-03 11:04:19.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c	2007-04-03 11:04:23.000000000 -0500
@@ -184,24 +184,6 @@ sysfs_fail:
 	return retval;
 }
 
-int rpaphp_get_power_status(struct slot *slot, u8 * value)
-{
-	int rc = 0, level;
-	
-	rc = rtas_get_power_level(slot->power_domain, &level);
-	if (rc < 0) {
-		err("failed to get power-level for slot(%s), rc=0x%x\n",
-			slot->location, rc);
-		return rc;
-	}
-
-	dbg("%s the power level of slot %s(pwd-domain:0x%x) is %d\n",
-		__FUNCTION__, slot->name, slot->power_domain, level);
-	*value = level;
-
-	return rc;
-}
-
 int rpaphp_set_attention_status(struct slot *slot, u8 status)
 {
 	int rc;
