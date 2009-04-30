Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67B97DE1BB
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 23:10:25 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/9] powerpc/pci: clean up direct access to sysdata by
	powermac platforms
Date: Thu, 30 Apr 2009 08:10:13 -0500
Message-Id: <1241097015-11208-7-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1241097015-11208-6-git-send-email-galak@kernel.crashing.org>
References: <1241097015-11208-1-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-2-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-3-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-4-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-5-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-6-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/platforms/powermac/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 45936c9..86f69a4 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -655,7 +655,7 @@ static int __init pmac_probe(void)
 /* Move that to pci.c */
 static int pmac_pci_probe_mode(struct pci_bus *bus)
 {
-	struct device_node *node = bus->sysdata;
+	struct device_node *node = pci_bus_to_OF_node(bus);
 
 	/* We need to use normal PCI probing for the AGP bus,
 	 * since the device for the AGP bridge isn't in the tree.
-- 
1.6.0.6
