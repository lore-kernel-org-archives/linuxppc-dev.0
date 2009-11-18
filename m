Return-Path: <nfont@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 173541007DD
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 13:57:37 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAI2qP0d006737
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:52:25 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAI2vVLK161424
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:57:31 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAI2vVWv012485
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:57:31 -0700
Message-ID: <4B03629A.9050503@austin.ibm.com>
Date: Tue, 17 Nov 2009 20:57:30 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH 4/4] Move of_node[attach,detach] declarations to linux/of.h
References: <4B030FC2.9070401@austin.ibm.com>
In-Reply-To: <4B030FC2.9070401@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge the declarations of of_attach_node and of_detach_node from the asm/prom.h
headers of powerpc and microblaze into linux/of.h.

This update also requires adding linux/of.h to the include list for
powerpc/platforms/pseries/reconfig.h.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: test-devicetree/arch/microblaze/include/asm/prom.h
===================================================================
--- test-devicetree.orig/arch/microblaze/include/asm/prom.h	2009-11-17 14:17:03.000000000 -0600
+++ test-devicetree/arch/microblaze/include/asm/prom.h	2009-11-17 14:18:25.000000000 -0600
@@ -139,10 +139,6 @@
 		of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long __init of_get_flat_dt_root(void);
 
-/* For updating the device tree at runtime */
-extern void of_attach_node(struct device_node *);
-extern void of_detach_node(struct device_node *);
-
 /* Other Prototypes */
 extern void finish_device_tree(void);
 extern void unflatten_device_tree(void);
Index: test-devicetree/arch/powerpc/include/asm/prom.h
===================================================================
--- test-devicetree.orig/arch/powerpc/include/asm/prom.h	2009-11-17 14:17:03.000000000 -0600
+++ test-devicetree/arch/powerpc/include/asm/prom.h	2009-11-17 14:18:25.000000000 -0600
@@ -137,10 +137,6 @@
 extern int __init of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long __init of_get_flat_dt_root(void);
 
-/* For updating the device tree at runtime */
-extern void of_attach_node(struct device_node *);
-extern void of_detach_node(struct device_node *);
-
 /* Other Prototypes */
 extern void finish_device_tree(void);
 extern void unflatten_device_tree(void);
Index: test-devicetree/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- test-devicetree.orig/arch/powerpc/platforms/pseries/reconfig.c	2009-11-17 14:17:03.000000000 -0600
+++ test-devicetree/arch/powerpc/platforms/pseries/reconfig.c	2009-11-17 14:18:25.000000000 -0600
@@ -15,6 +15,7 @@
 #include <linux/kref.h>
 #include <linux/notifier.h>
 #include <linux/proc_fs.h>
+#include <linux/of.h>
 
 #include <asm/prom.h>
 #include <asm/machdep.h>
Index: test-devicetree/include/linux/of.h
===================================================================
--- test-devicetree.orig/include/linux/of.h	2009-11-17 14:17:03.000000000 -0600
+++ test-devicetree/include/linux/of.h	2009-11-17 14:18:25.000000000 -0600
@@ -84,4 +84,10 @@
 	const char *list_name, const char *cells_name, int index,
 	struct device_node **out_node, const void **out_args);
 
+#ifdef CONFIG_OF_DYNAMIC
+/* For updating the device tree at runtime */
+extern void of_attach_node(struct device_node *);
+extern void of_detach_node(struct device_node *);
+#endif
+
 #endif /* _LINUX_OF_H */
