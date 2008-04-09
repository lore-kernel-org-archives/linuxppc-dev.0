Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7B3F4DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 12:19:59 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m392JnSm023197
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 19:19:50 -0700 (MST)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Make pci_bus_to_host()'s struct pci_bus * argument
	const
Date: Tue,  8 Apr 2008 19:19:32 -0700
Message-Id: <1207707572-24364-1-git-send-email-tpiepho@freescale.com>
Cc: Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Why?  Because:
A) It's not modified and so it can be made const.  const is good.
B) If one has a function that was given a const pci_bus pointer and you
want to get a pointer to its pci_controller, you'll get a warning from gcc
when you use pci_bus_to_host().  This is the right way to stop that
warning.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 include/asm-powerpc/pci-bridge.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index e5802c6..b95d033 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -117,7 +117,7 @@ struct pci_controller {
 
 #ifndef CONFIG_PPC64
 
-static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
+static inline struct pci_controller *pci_bus_to_host(const struct pci_bus *bus)
 {
 	return bus->sysdata;
 }
@@ -235,7 +235,7 @@ extern void pcibios_fixup_new_pci_devices(struct pci_bus *bus);
 
 extern int pcibios_remove_root_bus(struct pci_controller *phb);
 
-static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
+static inline struct pci_controller *pci_bus_to_host(const struct pci_bus *bus)
 {
 	struct device_node *busdn = bus->sysdata;
 
-- 
1.5.4.1
