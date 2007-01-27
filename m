Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3DDFDDE20C
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jan 2007 07:46:01 +1100 (EST)
Subject: [PATCH] powerpc: Fix sys_pciconfig_iobase bus matching
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Sun, 28 Jan 2007 07:45:53 +1100
Message-Id: <1169930753.24996.210.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A stupid bug has been plaguing the sys_pciconfig_iobase on ppc64. It wasn't
noticed until recently as it seems to not affect G5s but it's been causing
problems running X servers on some other machines recently. The bus number
matching was bogus.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Sent to Linus directly in case it can still make it into 2.6.20 ...

Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2007-01-28 07:14:04.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_64.c	2007-01-28 07:15:47.000000000 +1100
@@ -1430,7 +1430,7 @@
 
 	for (ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
 		bus = pci_bus_b(ln);
-		if (in_bus >= bus->number && in_bus < (bus->number + bus->subordinate))
+		if (in_bus >= bus->number && in_bus <= bus->subordinate)
 			break;
 		bus = NULL;
 	}
