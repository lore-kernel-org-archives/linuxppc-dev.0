Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F6FB67C39
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 09:32:40 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bob Brose <linuxppcdev@qbjnet.com>
In-Reply-To: <20061213190958.16479.qmail@kunk.qbjnet.com>
References: <20061213190958.16479.qmail@kunk.qbjnet.com>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 09:32:35 +1100
Message-Id: <1166049155.11914.215.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What about that patch ? If it doesn't help, please send me a new dmesg
log of 2.6.19 with patches -and- with #defin'ing DEBUG in
arch/powerpc/kernel/pci_32.c and prom_parse.c.

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
