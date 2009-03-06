Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <1e297c2bc75a03f17da24c568249c8e9925a9034.1236310746.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/pseries: The RPA PCI hotplug driver depends on EEH
Date: Fri,  6 Mar 2009 14:39:14 +1100 (EST)
Cc: linux-pci@vger.kernel.org, kristen.c.accardi@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The RPA PCI hotplug driver calls EEH routines, so should depend on
EEH. Also PPC_PSERIES implies PPC64, so remove that.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/pci/hotplug/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index eacfb13..9aa4fe1 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -143,7 +143,7 @@ config HOTPLUG_PCI_SHPC
 
 config HOTPLUG_PCI_RPA
 	tristate "RPA PCI Hotplug driver"
-	depends on PPC_PSERIES && PPC64 && !HOTPLUG_PCI_FAKE
+	depends on PPC_PSERIES && EEH && !HOTPLUG_PCI_FAKE
 	help
 	  Say Y here if you have a RPA system that supports PCI Hotplug.
 
-- 
1.6.1.2
