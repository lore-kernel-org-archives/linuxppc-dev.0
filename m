Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 13 Dec 2006 21:39:44 +1100
Subject: [PATCH 4/9] Enable MSI on Powerpc
In-Reply-To: <1166006370.90082.476088563252.qpush@cradle>
Message-Id: <20061213103955.9295468021@ozlabs.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow PCI_MSI to build on Powerpc.

We still need CONFIG_POWERPC.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/Makefile |    5 +++++
 drivers/pci/Kconfig          |    2 +-
 drivers/pci/Makefile         |    4 +++-
 3 files changed, 9 insertions(+), 2 deletions(-)

Index: msi/arch/powerpc/kernel/Makefile
===================================================================
--- msi.orig/arch/powerpc/kernel/Makefile
+++ msi/arch/powerpc/kernel/Makefile
@@ -65,6 +65,11 @@ obj-$(CONFIG_MODULES)		+= $(module-y)
 pci64-$(CONFIG_PPC64)		+= pci_64.o pci_dn.o
 pci32-$(CONFIG_PPC32)		:= pci_32.o
 obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y)
+
+msiobj-y			:= msi.o
+msiobj-$(CONFIG_PPC_RTAS)	+= msi-rtas.o
+obj-$(CONFIG_PCI_MSI)		+= $(msiobj-y)
+
 kexec-$(CONFIG_PPC64)		:= machine_kexec_64.o
 kexec-$(CONFIG_PPC32)		:= machine_kexec_32.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o $(kexec-y)
Index: msi/drivers/pci/Kconfig
===================================================================
--- msi.orig/drivers/pci/Kconfig
+++ msi/drivers/pci/Kconfig
@@ -4,7 +4,7 @@
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	depends on PCI
-	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64
+	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64 || PPC_MERGE
 	help
 	   This allows device drivers to enable MSI (Message Signaled
 	   Interrupts).  Message Signaled Interrupts enable a device to
Index: msi/drivers/pci/Makefile
===================================================================
--- msi.orig/drivers/pci/Makefile
+++ msi/drivers/pci/Makefile
@@ -14,8 +14,10 @@ obj-$(CONFIG_HOTPLUG) += hotplug.o
 # Build the PCI Hotplug drivers if we were asked to
 obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
 
-# Build the PCI MSI interrupt support
+# Build the PCI MSI interrupt support, but not for arch/powerpc
+ifndef CONFIG_PPC_MERGE
 obj-$(CONFIG_PCI_MSI) += msi.o
+endif
 
 # Build the Hypertransport interrupt support
 obj-$(CONFIG_HT_IRQ) += htirq.o
