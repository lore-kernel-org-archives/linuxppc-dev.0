Return-Path: <arnd@arndb.de>
Message-Id: <20060619183404.213201000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:17 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 02/20] cell: fix interrupt priority handling
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
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

Index: powerpc.git/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/interrupt.c
+++ powerpc.git/arch/powerpc/platforms/cell/interrupt.c
@@ -117,8 +117,7 @@ static int iic_external_get_irq(struct c
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
