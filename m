Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 401D7DE1EA
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 23:10:26 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/9] powerpc/pci: clean up direct access to sysdata by RTAS
Date: Thu, 30 Apr 2009 08:10:14 -0500
Message-Id: <1241097015-11208-8-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1241097015-11208-7-git-send-email-galak@kernel.crashing.org>
References: <1241097015-11208-1-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-2-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-3-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-4-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-5-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-6-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-7-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We shouldn't directly access sysdata to get the device node but call
pci_bus_to_OF_node() for this purpose.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/rtas_pci.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 8869001..54e66da 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -93,10 +93,7 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 {
 	struct device_node *busdn, *dn;
 
-	if (bus->self)
-		busdn = pci_device_to_OF_node(bus->self);
-	else
-		busdn = bus->sysdata;	/* must be a phb */
+	busdn = pci_bus_to_OF_node(bus);
 
 	/* Search only direct children of the bus */
 	for (dn = busdn->child; dn; dn = dn->sibling) {
@@ -140,10 +137,7 @@ static int rtas_pci_write_config(struct pci_bus *bus,
 {
 	struct device_node *busdn, *dn;
 
-	if (bus->self)
-		busdn = pci_device_to_OF_node(bus->self);
-	else
-		busdn = bus->sysdata;	/* must be a phb */
+	busdn = pci_bus_to_OF_node(bus);
 
 	/* Search only direct children of the bus */
 	for (dn = busdn->child; dn; dn = dn->sibling) {
-- 
1.6.0.6
