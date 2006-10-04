Return-Path: <arnd@arndb.de>
Message-Id: <20061004161512.346170000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Wed, 04 Oct 2006 17:26:23 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 13/14] spiderpic: enable new style devtree support
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This enables support for new firmware test releases.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spider-pic.c
+++ linux-2.6/arch/powerpc/platforms/cell/spider-pic.c
@@ -244,7 +244,6 @@ static unsigned int __init spider_find_c
 	int imaplen, intsize, unit;
 	struct device_node *iic;
 
-#if 0 /* Enable that when we have a way to retreive the node as well */
 	/* First, we check wether we have a real "interrupts" in the device
 	 * tree in case the device-tree is ever fixed
 	 */
@@ -252,9 +251,8 @@ static unsigned int __init spider_find_c
 	if (of_irq_map_one(pic->of_node, 0, &oirq) == 0) {
 		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
 					     oirq.size);
-		goto bail;
+		return virq;
 	}
-#endif
 
 	/* Now do the horrible hacks */
 	tmp = get_property(pic->of_node, "#interrupt-cells", NULL);

--
