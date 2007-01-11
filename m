Return-Path: <michael@ozlabs.org>
To: Greg Kroah-Hartman <greg@kroah.com>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 11 Jan 2007 22:25:20 +1100
Subject: [PATCH 3/7] Enable MSI on Powerpc
In-Reply-To: <1168514716.63474.857278133999.qpush@cradle>
Message-Id: <20070111112503.920E6DDEBE@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olof Johannsson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow PCI_MSI to build on Powerpc. Until we merge and enable some
backends, pci_enable_msi() etc. will always return an error.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/Makefile |    4 ++++
 drivers/pci/Kconfig          |    2 +-
 drivers/pci/Makefile         |    4 +++-
 3 files changed, 8 insertions(+), 2 deletions(-)

Index: msi/arch/powerpc/kernel/Makefile
===================================================================
--- msi.orig/arch/powerpc/kernel/Makefile
+++ msi/arch/powerpc/kernel/Makefile
@@ -65,6 +65,10 @@ obj-$(CONFIG_MODULES)		+= $(module-y)
 pci64-$(CONFIG_PPC64)		+= pci_64.o pci_dn.o
 pci32-$(CONFIG_PPC32)		:= pci_32.o
 obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y)
+
+msiobj-y			:= msi.o
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
