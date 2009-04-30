Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25476DE197
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 23:10:22 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/9] powerpc/pci: clean up direct access to sysdata by
	indirect ops
Date: Thu, 30 Apr 2009 08:10:07 -0500
Message-Id: <1241097015-11208-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We shouldn't directly access sysdata to get the pci_controller.  Instead
use pci_bus_to_host() for this purpose.  In the future we might have
sysdata be a device_node to match ppc64 and unify the code between ppc32
& ppc64.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/indirect_pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index 7fd49c9..7ed8096 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -24,7 +24,7 @@ static int
 indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		     int len, u32 *val)
 {
-	struct pci_controller *hose = bus->sysdata;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	volatile void __iomem *cfg_data;
 	u8 cfg_type = 0;
 	u32 bus_no, reg;
@@ -82,7 +82,7 @@ static int
 indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		      int len, u32 val)
 {
-	struct pci_controller *hose = bus->sysdata;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	volatile void __iomem *cfg_data;
 	u8 cfg_type = 0;
 	u32 bus_no, reg;
-- 
1.6.0.6
