Return-Path: <pacman@shell01.TheWorld.com>
Received: from TheWorld.com (pcls5.std.com [192.74.137.145])
	by ozlabs.org (Postfix) with ESMTP id 21237DDEB9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 11:35:39 +1000 (EST)
From: Alan Curry <pacman@theworld.com>
Message-Id: <200707250128.l6P1SWSF1336935@shell01.TheWorld.com>
Subject: [PATCH] powerpc: Pegasos keyboard detection
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Jul 2007 21:28:32 -0400 (EDT)
In-Reply-To: <200707230616.l6N6GaPg1212004@shell01.TheWorld.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As of 2.6.22 the kernel doesn't recognize the i8042 keyboard/mouse controller
on the PegasosPPC. This is because of a feature/bug in the OF device tree:
the "device_type" attribute is an empty string instead of "8042" as the
kernel expects. This patch (against 2.6.22.1) adds a secondary detection
which looks for a device whose *name* is "8042" if there is no device whose
*type* is "8042".

Signed-off-by: Alan Curry <pacman@world.std.com>

--- arch/powerpc/kernel/setup-common.c.orig	2007-07-24 19:04:17.000000000 -0500
+++ arch/powerpc/kernel/setup-common.c	2007-07-24 19:06:36.000000000 -0500
@@ -487,6 +487,10 @@ int check_legacy_ioport(unsigned long ba
 	switch(base_port) {
 	case I8042_DATA_REG:
 		np = of_find_node_by_type(NULL, "8042");
+		/* Pegasos has no device_type on its 8042 node, look for the
+		 * name instead */
+		if (!np)
+			np = of_find_node_by_name(NULL, "8042");
 		break;
 	case FDC_BASE: /* FDC1 */
 		np = of_find_node_by_type(NULL, "fdc");
