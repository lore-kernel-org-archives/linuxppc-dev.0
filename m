Return-Path: <michael@ozlabs.org>
To: <linux-kernel@vger.kernel.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 29 Sep 2006 07:53:41 +1000
Subject: [RFC/PATCH 5/7] Enable MSI on Powerpc
In-Reply-To: <1159480412.269240.988552559176.qpush@concordia>
Message-Id: <20060928215342.446D067BEC@ozlabs.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow PCI_MSI to build on Powerpc.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/Makefile |    4 ++++
 drivers/pci/Kconfig          |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

Index: to-merge/arch/powerpc/kernel/Makefile
===================================================================
--- to-merge.orig/arch/powerpc/kernel/Makefile
+++ to-merge/arch/powerpc/kernel/Makefile
@@ -67,6 +67,10 @@ pci64-$(CONFIG_PPC64)		+= pci_64.o pci_d
 				   pci_direct_iommu.o iomap.o
 pci32-$(CONFIG_PPC32)		:= pci_32.o
 obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y)
+
+msiobj-y			:= msi.o
+obj-$(CONFIG_PCI_MSI)		+= $(msiobj-y)
+
 kexec-$(CONFIG_PPC64)		:= machine_kexec_64.o
 kexec-$(CONFIG_PPC32)		:= machine_kexec_32.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o $(kexec-y)
Index: to-merge/drivers/pci/Kconfig
===================================================================
--- to-merge.orig/drivers/pci/Kconfig
+++ to-merge/drivers/pci/Kconfig
@@ -4,7 +4,7 @@
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	depends on PCI
-	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64
+	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64 || PPC
 	help
 	   This allows device drivers to enable MSI (Message Signaled
 	   Interrupts).  Message Signaled Interrupts enable a device to
