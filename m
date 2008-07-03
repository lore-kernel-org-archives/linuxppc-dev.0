Return-Path: <nfont@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A38DADDED9
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 13:22:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m633MZTw016779
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 23:22:35 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m633MYpX177228
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 21:22:34 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m633MYlK013533
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 21:22:34 -0600
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m633MYp2013527
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 21:22:34 -0600
Received: from [9.65.174.195] (sig-9-65-174-195.mts.ibm.com [9.65.174.195])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m633MXeb050336
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 22:22:33 -0500
Message-ID: <486C45FF.5030407@austin.ibm.com>
Date: Wed, 02 Jul 2008 22:22:39 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5 v2] Update the device tree correctly for drconf memory
	add/remove
References: <486C4462.4010004@austin.ibm.com>
In-Reply-To: <486C4462.4010004@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch updates the device tree manipulation routines so that memory
add/remove of lmbs represented under the
ibm,dynamic-reconfiguration-memory node of the device tree invokes the
hotplug notifier chain.

This change is needed because of the change in the way memory is
represented under the ibm,dynamic-reconfiguration-memory node.  All lmbs
are described in the ibm,dynamic-memory property instead of having a
separate node for each lmb as in previous device tree layouts.  This
requires the update_node() routine to check for updates to the
ibm,dynamic-memory property and invoke the hotplug notifier chain.

This also updates the pseries hotplug notifier to be able to gather information
for lmbs represented under the ibm,dynamic-reconfiguration-memory node and
have the lmbs added/removed.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   95 +++++++++++++++++-------
 arch/powerpc/platforms/pseries/reconfig.c       |   36 ++++++++-
 include/asm-powerpc/pSeries_reconfig.h          |    6 +
 3 files changed, 104 insertions(+), 33 deletions(-)

Index: linux-2.6.git/include/asm-powerpc/pSeries_reconfig.h
===================================================================
--- linux-2.6.git.orig/include/asm-powerpc/pSeries_reconfig.h	2008-07-01 09:38:19.000000000 -0500
+++ linux-2.6.git/include/asm-powerpc/pSeries_reconfig.h	2008-07-01 09:38:54.000000000 -0500
@@ -9,8 +9,10 @@
  * added or removed on pSeries systems.
  */
 
-#define PSERIES_RECONFIG_ADD    0x0001
-#define PSERIES_RECONFIG_REMOVE 0x0002
+#define PSERIES_RECONFIG_ADD		0x0001
+#define PSERIES_RECONFIG_REMOVE		0x0002
+#define PSERIES_DRCONF_MEM_ADD		0x0003
+#define PSERIES_DRCONF_MEM_REMOVE	0x0004
 
 #ifdef CONFIG_PPC_PSERIES
 extern int pSeries_reconfig_notifier_register(struct notifier_block *);
Index: linux-2.6.git/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/pseries/reconfig.c	2008-07-01 09:38:26.000000000 -0500
+++ linux-2.6.git/arch/powerpc/platforms/pseries/reconfig.c	2008-07-01 09:38:54.000000000 -0500
@@ -422,8 +422,8 @@
 {
 	struct device_node *np;
 	unsigned char *value;
-	char *name, *end;
-	int length;
+	char *name, *end, *next_prop;
+	int rc, length;
 	struct property *newprop, *oldprop;
 	buf = parse_node(buf, bufsize, &np);
 	end = buf + bufsize;
@@ -431,7 +431,8 @@
 	if (!np)
 		return -ENODEV;
 
-	if (parse_next_property(buf, end, &name, &length, &value) == NULL)
+	next_prop = parse_next_property(buf, end, &name, &length, &value);
+	if (!next_prop)
 		return -EINVAL;
 
 	newprop = new_property(name, length, value, NULL);
@@ -442,7 +443,34 @@
 	if (!oldprop)
 		return -ENODEV;
 
-	return prom_update_property(np, newprop, oldprop);
+	rc = prom_update_property(np, newprop, oldprop);
+ 	if (rc)
+ 		return rc;
+
+ 	/* For memory under the ibm,dynamic-reconfiguration-memory node
+ 	 * of the device tree, adding and removing memory is just an update
+ 	 * to the ibm,dynamic-memory property instead of adding/removing a
+ 	 * memory node in the device tree.  For these cases we still need to
+ 	 * involve the notifier chain.
+ 	 */
+ 	if (!strcmp(name, "ibm,dynamic-memory")) {
+ 		int action;
+
+ 		next_prop = parse_next_property(next_prop, end, &name,
+ 						&length, &value);
+ 		if (!next_prop)
+ 			return -EINVAL;
+
+ 		if (!strcmp(name, "add"))
+ 			action = PSERIES_DRCONF_MEM_ADD;
+ 		else
+ 			action = PSERIES_DRCONF_MEM_REMOVE;
+
+ 		blocking_notifier_call_chain(&pSeries_reconfig_chain,
+ 					     action, value);
+ 	}
+
+ 	return 0;
 }
 
 /**
Index: linux-2.6.git/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-07-01 09:38:49.000000000 -0500
+++ linux-2.6.git/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-07-01 18:43:33.000000000 -0500
@@ -15,32 +15,11 @@
 #include <asm/machdep.h>
 #include <asm/pSeries_reconfig.h>
 
-static int pseries_remove_memory(struct device_node *np)
+static int pseries_remove_lmb(unsigned long base, unsigned int lmb_size)
 {
-	const char *type;
-	const unsigned int *regs;
-	unsigned long base;
-	unsigned int lmb_size;
-	u64 start_pfn, start;
+	unsigned long start, start_pfn;
 	struct zone *zone;
-	int ret = -EINVAL;
-
-	/*
-	 * Check to see if we are actually removing memory
-	 */
-	type = of_get_property(np, "device_type", NULL);
-	if (type == NULL || strcmp(type, "memory") != 0)
-		return 0;
-
-	/*
-	 * Find the bae address and size of the lmb
-	 */
-	regs = of_get_property(np, "reg", NULL);
-	if (!regs)
-		return ret;
-
-	base = *(unsigned long *)regs;
-	lmb_size = regs[3];
+	int ret;
 
 	start_pfn = base >> PFN_SECTION_SHIFT;
 	zone = page_zone(pfn_to_page(start_pfn));
@@ -71,13 +50,41 @@
 	return ret;
 }
 
+static int pseries_remove_memory(struct device_node *np)
+{
+	const char *type;
+	const unsigned int *regs;
+	unsigned long base;
+	unsigned int lmb_size;
+	int ret = -EINVAL;
+
+	/*
+	 * Check to see if we are actually removing memory
+	 */
+	type = of_get_property(np, "device_type", NULL);
+	if (type == NULL || strcmp(type, "memory") != 0)
+		return 0;
+
+	/*
+	 * Find the bae address and size of the lmb
+	 */
+	regs = of_get_property(np, "reg", NULL);
+	if (!regs)
+		return ret;
+
+	base = *(unsigned long *)regs;
+	lmb_size = regs[3];
+
+	ret = pseries_remove_lmb(base, lmb_size);
+	return ret;
+}
+
 static int pseries_add_memory(struct device_node *np)
 {
 	const char *type;
 	const unsigned int *regs;
 	unsigned long base;
 	unsigned int lmb_size;
-	u64 start_pfn;
 	int ret = -EINVAL;
 
 	/*
@@ -100,8 +107,37 @@
 	/*
 	 * Update memory region to represent the memory add
 	 */
-	lmb_add(base, lmb_size);
-	return 0;
+	ret = lmb_add(base, lmb_size);
+	return (ret < 0) ? -EINVAL : 0;
+}
+
+static int pseries_drconf_memory(unsigned long *base, unsigned int action)
+{
+	struct device_node *np;
+	const unsigned long *lmb_size;
+	int rc;
+
+	np = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!np)
+		return -EINVAL;
+
+	lmb_size = of_get_property(np, "ibm,lmb-size", NULL);
+	if (!lmb_size) {
+		of_node_put(np);
+		return -EINVAL;
+	}
+
+	if (action == PSERIES_DRCONF_MEM_ADD) {
+		rc = lmb_add(*base, *lmb_size);
+		rc = (rc < 0) ? -EINVAL : 0;
+	} else if (action == PSERIES_DRCONF_MEM_REMOVE) {
+		rc = pseries_remove_lmb(*base, *lmb_size);
+	} else {
+		rc = -EINVAL;
+	}
+
+	of_node_put(np);
+	return rc;
 }
 
 static int pseries_memory_notifier(struct notifier_block *nb,
@@ -118,6 +154,11 @@
 		if (pseries_remove_memory(node))
 			err = NOTIFY_BAD;
 		break;
+	case PSERIES_DRCONF_MEM_ADD:
+	case PSERIES_DRCONF_MEM_REMOVE:
+		if (pseries_drconf_memory(node, action))
+			err = NOTIFY_BAD;
+		break;
 	default:
 		err = NOTIFY_DONE;
 		break;
