Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8270A67C62
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 07:13:31 +1100 (EST)
Subject: [PATCH] powerpc: Workaround oldworld OF bug with IRQs & P2P bridges
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 07:13:26 +1100
Message-Id: <1166127206.31351.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On some oldworld PowerMacs, OF doesn't assign interrupts properly
beyond P2P bridges. Fortunately, the fix is easy as all those machines
just wire all IRQ lines together to one IRQ which is assigned to the
bridge itself. We already have a special function for parsing Apple
OldWorld interrupts which are special, so let's add to it the ability
to walk up the PCI tree to find interrupts.

This fixes irqs on the lower slots of s900 clones among others.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I'll also send that to -stable once it's been in for a few weeks.

Index: linux-work/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_parse.c	2006-12-14 09:27:22.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom_parse.c	2006-12-14 09:29:36.000000000 +1100
@@ -920,9 +920,20 @@
 
 	/*
 	 * Old machines just have a list of interrupt numbers
-	 * and no interrupt-controller nodes.
+	 * and no interrupt-controller nodes. We also have dodgy
+	 * cases where the APPL,interrupts property is completely
+	 * missing behind pci-pci bridges and we have to get it
+	 * from the parent (the bridge itself, as apple just wired
+	 * everything together on these)
 	 */
-	ints = get_property(device, "AAPL,interrupts", &intlen);
+	while (device) {
+		ints = get_property(device, "AAPL,interrupts", &intlen);
+		if (ints != NULL)
+			break;
+		device = device->parent;
+		if (device && strcmp(device->type, "pci") != 0)
+			break;
+	}
 	if (ints == NULL)
 		return -EINVAL;
 	intlen /= sizeof(u32);
