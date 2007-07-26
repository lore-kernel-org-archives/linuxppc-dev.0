Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Jul 2007 14:07:14 +1000
Subject: [PATCH 3/3] powerpc: Fix Maple platform ISA bus
Message-Id: <20070726040755.50545DDEDA@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Maple platform has ISA IOs but didn't call the new functions to
actually map those, thus crashing when trying to access the nvram.

This fixes Maple and js2x using SLOF

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 
 arch/powerpc/platforms/maple/pci.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-work/arch/powerpc/platforms/maple/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/maple/pci.c	2007-07-25 16:29:22.000000000 +1000
+++ linux-work/arch/powerpc/platforms/maple/pci.c	2007-07-26 10:30:43.000000000 +1000
@@ -490,6 +490,9 @@ static int __init maple_add_bridge(struc
 	/* Fixup "bus-range" OF property */
 	fixup_bus_range(dev);
 
+	/* Check for legacy IOs */
+	isa_bridge_find_early(hose);
+
 	return 0;
 }
 
