Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <22058bc403dd654ba888c598b538435efef96c8f.1236310591.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/pseries: The pseries MSI code depends on EEH
Date: Fri,  6 Mar 2009 14:36:39 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/Kconfig  |    5 +++++
 arch/powerpc/platforms/pseries/Makefile |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index ddc2a30..095ff6f 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -25,6 +25,11 @@ config EEH
 	depends on PPC_PSERIES && PCI
 	default y if !EMBEDDED
 
+config PSERIES_MSI
+       bool
+       depends on PCI_MSI && EEH
+       default y
+
 config SCANLOG
 	tristate "Scanlog dump interface"
 	depends on RTAS_PROC && PPC_PSERIES
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index dfe574a..0ce691d 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
 obj-$(CONFIG_PCI)	+= pci.o pci_dlpar.o
-obj-$(CONFIG_PCI_MSI)	+= msi.o
+obj-$(CONFIG_PSERIES_MSI)	+= msi.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
 obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o
-- 
1.6.1.2
