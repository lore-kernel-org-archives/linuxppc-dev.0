Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 770066852E
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 14:56:53 +1100 (EST)
Subject: [PATCH] powerpc: Workaround for of_platform without "reg" nor
	"dcr-reg"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 14:56:37 +1100
Message-Id: <1164081397.8207.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Devices with no "reg" nor "dcr-reg" property are given a bus_id which
is the node name alone. This means that if more than one such device
with the same names are present in the system, sysfs will have
collisions when creating the symlinks and will fail registering the
devices.

This works around that problem by assigning successive numbers to such
devices.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Paul: This is 2.6.20 material, not 2.6.19

Index: linux-cell/arch/powerpc/kernel/of_platform.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/of_platform.c	2006-11-21 11:01:12.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/of_platform.c	2006-11-21 14:07:06.000000000 +1100
@@ -27,6 +27,8 @@
 #include <asm/topology.h>
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
+#include <asm/atomic.h>
+
 
 /*
  * The list of OF IDs below is used for matching bus types in the
@@ -51,6 +53,8 @@ static struct of_device_id of_default_bu
 	{},
 };
 
+static atomic_t bus_no_reg_magic;
+
 /*
  *
  * OF platform device type definition & base infrastructure
@@ -165,6 +169,7 @@ static void of_platform_make_bus_id(stru
 	char *name = dev->dev.bus_id;
 	const u32 *reg;
 	u64 addr;
+	long magic;
 
 	/*
 	 * If it's a DCR based device, use 'd' for native DCRs
@@ -203,9 +208,11 @@ static void of_platform_make_bus_id(stru
 	}
 
 	/*
-	 * No BusID, use the node name and pray
+	 * No BusID, use the node name and add a globally incremented
+	 * counter (and pray...)
 	 */
-	snprintf(name, BUS_ID_SIZE, "%s", node->name);
+	magic = atomic_add_return(1, &bus_no_reg_magic);
+	snprintf(name, BUS_ID_SIZE, "%s.%d", node->name, magic - 1);
 }
 
 struct of_device* of_platform_device_create(struct device_node *np,
