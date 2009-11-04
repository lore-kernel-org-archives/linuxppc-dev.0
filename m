Return-Path: <nfont@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C83CB7B9D
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 09:14:51 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA4MKDjo032584
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 17:20:13 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA4MEl3n1130722
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 17:14:47 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA4MElih004662
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 17:14:47 -0500
Message-ID: <4AF1FCD2.9060307@austin.ibm.com>
Date: Wed, 04 Nov 2009 16:14:42 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [RFC PATCH 1/5] Move devtree_lock and allnodes declaration to of.h
References: <4AF1FB29.50905@austin.ibm.com>
In-Reply-To: <4AF1FB29.50905@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the declaration of devtree_lock and allnodes from powerpc/microblaze
asm/prom.h to linux/of.h

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
Index: linux-next/include/linux/of.h
===================================================================
--- linux-next.orig/include/linux/of.h	2009-11-02 13:39:46.000000000 -0600
+++ linux-next/include/linux/of.h	2009-11-02 14:17:29.000000000 -0600
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/kref.h>
 #include <linux/mod_devicetable.h>
+#include <linux/spinlock.h>
 
 typedef u32 phandle;
 typedef u32 ihandle;
@@ -63,6 +64,9 @@
 #endif
 };
 
+extern rwlock_t devtree_lock;
+extern struct device_node *allnodes;
+
 static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
 {
 	return test_bit(flag, &n->_flags);
Index: linux-next/arch/powerpc/kernel/prom.c
===================================================================
--- linux-next.orig/arch/powerpc/kernel/prom.c	2009-11-02 13:39:40.000000000 -0600
+++ linux-next/arch/powerpc/kernel/prom.c	2009-11-02 14:07:43.000000000 -0600
@@ -32,6 +32,7 @@
 #include <linux/debugfs.h>
 #include <linux/irq.h>
 #include <linux/lmb.h>
+#include <linux/of.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -79,10 +80,6 @@
 struct boot_param_header *initial_boot_params;
 #endif
 
-extern struct device_node *allnodes;	/* temporary while merging */
-
-extern rwlock_t devtree_lock;	/* temporary while merging */
-
 /* export that to outside world */
 struct device_node *of_chosen;
 
Index: linux-next/arch/microblaze/include/asm/prom.h
===================================================================
--- linux-next.orig/arch/microblaze/include/asm/prom.h	2009-11-02 13:39:39.000000000 -0600
+++ linux-next/arch/microblaze/include/asm/prom.h	2009-11-02 14:10:13.000000000 -0600
@@ -23,6 +23,7 @@
 #include <linux/of_fdt.h>
 #include <linux/proc_fs.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <asm/irq.h>
 #include <asm/atomic.h>
 
@@ -37,9 +38,6 @@
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
-extern struct device_node *allnodes;	/* temporary while merging */
-extern rwlock_t devtree_lock;	/* temporary while merging */
-
 /* For updating the device tree at runtime */
 extern void of_attach_node(struct device_node *);
 extern void of_detach_node(struct device_node *);
Index: linux-next/arch/sparc/kernel/prom.h
===================================================================
--- linux-next.orig/arch/sparc/kernel/prom.h	2009-11-02 13:39:40.000000000 -0600
+++ linux-next/arch/sparc/kernel/prom.h	2009-11-02 14:12:46.000000000 -0600
@@ -2,11 +2,9 @@
 #define __PROM_H
 
 #include <linux/spinlock.h>
+#include <linux/of.h>
 #include <asm/prom.h>
 
-extern struct device_node *allnodes;	/* temporary while merging */
-extern rwlock_t devtree_lock;	/* temporary while merging */
-
 extern void * prom_early_alloc(unsigned long size);
 extern void irq_trans_init(struct device_node *dp);
 
