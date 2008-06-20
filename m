Return-Path: <nfont@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B34BDDEED
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 07:32:58 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5KLWtQ9021489
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:32:55 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5KLWttA230730
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:32:55 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5KLWtcI005324
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:32:55 -0400
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5KLWtaR005313
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:32:55 -0400
Received: from [9.53.40.161] (mudbug-009053040161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m5KLWso0068294
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 16:32:55 -0500
Message-ID: <485C2207.90407@austin.ibm.com>
Date: Fri, 20 Jun 2008 16:32:55 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] Update device tree correctly for drconf memory add/remove
References: <485C2033.20101@austin.ibm.com>
In-Reply-To: <485C2033.20101@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Memory dlpar updates to correctly update the device tree when an lmb is
added/removed.  The main difference for memory under the
ibm,dynamic-reconfiguration-memory node is that dlpar adding or removing an
lmb only requires an update to the ibm,dynamic-memory property.  Previously,
entire nodes were added or removed when a lmb was dlpar added/removed.

The patch updates the /proc/ppc64/ofdt interface to recognize when the
ibm,dynamic-memory preoperty is updated and properly invokes the memory
hotplug notifier chain.

This also updates the pseries hotplug notifier to be able to gather information
for lmbs represented under the ibm,dynamic-reconfiguration-memory node and
have the lmbs added/removed.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: linux-2.6.git/include/asm-powerpc/pSeries_reconfig.h
===================================================================
--- linux-2.6.git.orig/include/asm-powerpc/pSeries_reconfig.h	2008-06-20 
12:08:41.000000000 -0500
+++ linux-2.6.git/include/asm-powerpc/pSeries_reconfig.h	2008-06-20 
12:50:03.000000000 -0500
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
--- linux-2.6.git.orig/arch/powerpc/platforms/pseries/reconfig.c	2008-06-20 
12:08:41.000000000 -0500
+++ linux-2.6.git/arch/powerpc/platforms/pseries/reconfig.c	2008-06-20 
12:58:22.000000000 -0500
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
+	if (rc)
+		return rc;
+
+	/* For memory under the ibm,dynamic-reconfiguration-memory node
+	 * of the device tree, adding and removing memory is just an update
+	 * to the ibm,dynamic-memory property instead of adding/removing a
+	 * memory node in the device tree.  For these cases we still need to
+	 * involve the notifier chain.
+	 */
+	if (!strcmp(name, "ibm,dynamic-memory")) {
+		int action;
+
+		next_prop = parse_next_property(next_prop, end, &name,
+						&length, &value);
+		if (!next_prop)
+			return -EINVAL;
+
+		if (!strcmp(name, "add"))
+			action = PSERIES_DRCONF_MEM_ADD;
+		else
+			action = PSERIES_DRCONF_MEM_REMOVE;
+
+		blocking_notifier_call_chain(&pSeries_reconfig_chain,
+					     action, value);
+	}
+
+	return 0;
  }

  /**
Index: linux-2.6.git/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-06-20 
12:40:21.000000000 -0500
+++ linux-2.6.git/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-06-20 
13:18:09.000000000 -0500
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
+	unsigned long start_pfn, start;
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
-	 * Find the base address and size of the lmb
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
@@ -71,6 +50,35 @@
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
+	 * Find the base address and size of the lmb
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
@@ -99,10 +107,39 @@
  	/*
  	 * Update memory region to represent the memory add
  	 */
-	lmb_add(base, lmb_size);
-	return 0;
+	ret = lmb_add(base, lmb_size);
+	return (ret < 0) ? -EINVAL : 0;
  }

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
+ }
+
  static int pseries_memory_notifier(struct notifier_block *nb,
  				unsigned long action, void *node)
  {
@@ -117,6 +154,11 @@
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
