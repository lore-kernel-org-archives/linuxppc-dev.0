Return-Path: <markn@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C905B7DA7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 May 2010 22:30:10 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4HCU8Pk031685
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 May 2010 22:30:08 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4HCU9831814652
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 May 2010 22:30:09 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4HCU9sA007087
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 May 2010 22:30:09 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Make request_ras_irqs() available to other
	pseries code
Date: Mon, 17 May 2010 22:33:01 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201005172233.01183.markn@au1.ibm.com>
Cc: Tseng-hui Lin <tsenglin@us.ibm.com>, engebret@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment only the RAS code uses event-sources interrupts (for EPOW
events and internal errors) so request_ras_irqs() (which actually requests
the event-sources interrupts) is found in ras.c and is static.

We want to be able to use event-sources interrupts in other pseries code,
so let's rename request_ras_irqs() to request_event_sources_irqs() and
move it to event_sources.c.

This will be used in an upcoming patch that adds support for IO Event
interrupts that come through as event sources.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/platforms/pseries/Makefile        |    2 
 arch/powerpc/platforms/pseries/event_sources.c |   79 +++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/event_sources.h |   29 +++++++++
 arch/powerpc/platforms/pseries/ras.c           |   63 +------------------
 4 files changed, 113 insertions(+), 60 deletions(-)

Index: upstream/arch/powerpc/platforms/pseries/event_sources.c
===================================================================
--- /dev/null
+++ upstream/arch/powerpc/platforms/pseries/event_sources.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2001 Dave Engebretsen IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <asm/prom.h>
+
+#include "event_sources.h"
+
+void request_event_sources_irqs(struct device_node *np,
+				irq_handler_t handler,
+				const char *name)
+{
+	int i, index, count = 0;
+	struct of_irq oirq;
+	const u32 *opicprop;
+	unsigned int opicplen;
+	unsigned int virqs[16];
+
+	/* Check for obsolete "open-pic-interrupt" property. If present, then
+	 * map those interrupts using the default interrupt host and default
+	 * trigger
+	 */
+	opicprop = of_get_property(np, "open-pic-interrupt", &opicplen);
+	if (opicprop) {
+		opicplen /= sizeof(u32);
+		for (i = 0; i < opicplen; i++) {
+			if (count > 15)
+				break;
+			virqs[count] = irq_create_mapping(NULL, *(opicprop++));
+			if (virqs[count] == NO_IRQ)
+				printk(KERN_ERR "Unable to allocate interrupt "
+				       "number for %s\n", np->full_name);
+			else
+				count++;
+
+		}
+	}
+	/* Else use normal interrupt tree parsing */
+	else {
+		/* First try to do a proper OF tree parsing */
+		for (index = 0; of_irq_map_one(np, index, &oirq) == 0;
+		     index++) {
+			if (count > 15)
+				break;
+			virqs[count] = irq_create_of_mapping(oirq.controller,
+							    oirq.specifier,
+							    oirq.size);
+			if (virqs[count] == NO_IRQ)
+				printk(KERN_ERR "Unable to allocate interrupt "
+				       "number for %s\n", np->full_name);
+			else
+				count++;
+		}
+	}
+
+	/* Now request them */
+	for (i = 0; i < count; i++) {
+		if (request_irq(virqs[i], handler, 0, name, NULL)) {
+			printk(KERN_ERR "Unable to request interrupt %d for "
+			       "%s\n", virqs[i], np->full_name);
+			return;
+		}
+	}
+}
+
Index: upstream/arch/powerpc/platforms/pseries/event_sources.h
===================================================================
--- /dev/null
+++ upstream/arch/powerpc/platforms/pseries/event_sources.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2001 Dave Engebretsen IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#ifndef _POWERPC_EVENT_SOURCES_H
+#define _POWERPC_EVENT_SOURCES_H
+
+#include <linux/interrupt.h>
+
+struct device_node;
+
+extern void request_event_sources_irqs(struct device_node *np,
+				       irq_handler_t handler, const char *name);
+
+#endif /* _POWERPC_EVENT_SOURCES_H */
Index: upstream/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- upstream.orig/arch/powerpc/platforms/pseries/Makefile
+++ upstream/arch/powerpc/platforms/pseries/Makefile
@@ -7,7 +7,7 @@ EXTRA_CFLAGS		+= -DDEBUG
 endif
 
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
-			   setup.o iommu.o ras.o \
+			   setup.o iommu.o event_sources.o ras.o \
 			   firmware.o power.o dlpar.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_XICS)	+= xics.o
Index: upstream/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/pseries/ras.c
+++ upstream/arch/powerpc/platforms/pseries/ras.c
@@ -50,6 +50,7 @@
 #include <asm/firmware.h>
 
 #include "pseries.h"
+#include "event_sources.h"
 
 static unsigned char ras_log_buf[RTAS_ERROR_LOG_MAX];
 static DEFINE_SPINLOCK(ras_log_buf_lock);
@@ -67,63 +68,6 @@ static irqreturn_t ras_epow_interrupt(in
 static irqreturn_t ras_error_interrupt(int irq, void *dev_id);
 
 
-static void request_ras_irqs(struct device_node *np,
-			irq_handler_t handler,
-			const char *name)
-{
-	int i, index, count = 0;
-	struct of_irq oirq;
-	const u32 *opicprop;
-	unsigned int opicplen;
-	unsigned int virqs[16];
-
-	/* Check for obsolete "open-pic-interrupt" property. If present, then
-	 * map those interrupts using the default interrupt host and default
-	 * trigger
-	 */
-	opicprop = of_get_property(np, "open-pic-interrupt", &opicplen);
-	if (opicprop) {
-		opicplen /= sizeof(u32);
-		for (i = 0; i < opicplen; i++) {
-			if (count > 15)
-				break;
-			virqs[count] = irq_create_mapping(NULL, *(opicprop++));
-			if (virqs[count] == NO_IRQ)
-				printk(KERN_ERR "Unable to allocate interrupt "
-				       "number for %s\n", np->full_name);
-			else
-				count++;
-
-		}
-	}
-	/* Else use normal interrupt tree parsing */
-	else {
-		/* First try to do a proper OF tree parsing */
-		for (index = 0; of_irq_map_one(np, index, &oirq) == 0;
-		     index++) {
-			if (count > 15)
-				break;
-			virqs[count] = irq_create_of_mapping(oirq.controller,
-							    oirq.specifier,
-							    oirq.size);
-			if (virqs[count] == NO_IRQ)
-				printk(KERN_ERR "Unable to allocate interrupt "
-				       "number for %s\n", np->full_name);
-			else
-				count++;
-		}
-	}
-
-	/* Now request them */
-	for (i = 0; i < count; i++) {
-		if (request_irq(virqs[i], handler, 0, name, NULL)) {
-			printk(KERN_ERR "Unable to request interrupt %d for "
-			       "%s\n", virqs[i], np->full_name);
-			return;
-		}
-	}
-}
-
 /*
  * Initialize handlers for the set of interrupts caused by hardware errors
  * and power system events.
@@ -138,14 +82,15 @@ static int __init init_ras_IRQ(void)
 	/* Internal Errors */
 	np = of_find_node_by_path("/event-sources/internal-errors");
 	if (np != NULL) {
-		request_ras_irqs(np, ras_error_interrupt, "RAS_ERROR");
+		request_event_sources_irqs(np, ras_error_interrupt,
+					   "RAS_ERROR");
 		of_node_put(np);
 	}
 
 	/* EPOW Events */
 	np = of_find_node_by_path("/event-sources/epow-events");
 	if (np != NULL) {
-		request_ras_irqs(np, ras_epow_interrupt, "RAS_EPOW");
+		request_event_sources_irqs(np, ras_epow_interrupt, "RAS_EPOW");
 		of_node_put(np);
 	}
 
