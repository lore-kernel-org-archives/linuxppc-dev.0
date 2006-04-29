Return-Path: <arnd@arndb.de>
Message-Id: <20060429233920.028529000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:15 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 03/13] cell: fix interrupt priority handling
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

Checking the priority field to test for irq validity is
completely bogus and breaks with future external interrupt
controllers.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linus-2.6/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/interrupt.c	2006-04-29 22:47:55.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/interrupt.c	2006-04-29 22:53:41.000000000 +0200
@@ -136,8 +136,7 @@
 		 * One of these units can be connected
 		 * to an external interrupt controller.
 		 */
-		if (pending.prio > 0x3f ||
-		    pending.class != 2)
+		if (pending.class != 2)
 			break;
 		irq = IIC_EXT_OFFSET
 			+ spider_get_irq(node)

--
