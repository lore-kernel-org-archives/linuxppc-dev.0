Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59470DDE3B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jul 2007 19:34:37 +1000 (EST)
Subject: [PATCH] arch/powerpc/kernel/sysfs.c: move NUMA exports
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 05 Jul 2007 11:35:33 +0200
Message-Id: <1183628133.3818.28.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With !CONFIG_NUMA, these are static inlines in the header file so don't
generate exports for them then.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 arch/powerpc/kernel/sysfs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- wireless-dev.orig/arch/powerpc/kernel/sysfs.c	2007-07-05 11:33:33.135640003 +0200
+++ wireless-dev/arch/powerpc/kernel/sysfs.c	2007-07-05 11:34:04.125640003 +0200
@@ -442,12 +442,14 @@ int sysfs_add_device_to_node(struct sys_
 	return sysfs_create_link(&node->sysdev.kobj, &dev->kobj,
 			kobject_name(&dev->kobj));
 }
+EXPORT_SYMBOL_GPL(sysfs_add_device_to_node);
 
 void sysfs_remove_device_from_node(struct sys_device *dev, int nid)
 {
 	struct node *node = &node_devices[nid];
 	sysfs_remove_link(&node->sysdev.kobj, kobject_name(&dev->kobj));
 }
+EXPORT_SYMBOL_GPL(sysfs_remove_device_from_node);
 
 #else
 static void register_nodes(void)
@@ -457,9 +459,6 @@ static void register_nodes(void)
 
 #endif
 
-EXPORT_SYMBOL_GPL(sysfs_add_device_to_node);
-EXPORT_SYMBOL_GPL(sysfs_remove_device_from_node);
-
 /* Only valid if CPU is present. */
 static ssize_t show_physical_id(struct sys_device *dev, char *buf)
 {
