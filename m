Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 18 Aug 2006 18:13:29 +1000
Subject: [RFC/PATCH 2/4] Allow for non-Intel MSI implementations
Message-Id: <20060818081330.9ADC867B55@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jake Moilanen <moilanen@austin.ibm.com>

This allows an architecture to provide its own MSI implementation
instead of msi.c and msi-apic.c.  We will need this on IBM System-p
machines where the hypervisor controls the assignment and setup of
MSIs.  A following patch will provide an MSI implementation for these
machines.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
---

 drivers/pci/Makefile |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: git/drivers/pci/Makefile
===================================================================
--- git.orig/drivers/pci/Makefile
+++ git/drivers/pci/Makefile
@@ -27,9 +27,11 @@ obj-$(CONFIG_PPC64) += setup-bus.o
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
 
-msiobj-y := msi.o msi-apic.o
-msiobj-$(CONFIG_IA64_GENERIC) += msi-altix.o
-msiobj-$(CONFIG_IA64_SGI_SN2) += msi-altix.o
+msiobj-$(CONFIG_X86) := msi.o msi-apic.o
+msiobj-$(CONFIG_IA64) := msi.o msi-apic.o
+msiobj-$(CONFIG_IA64_GENERIC) := msi-altix.o
+msiobj-$(CONFIG_IA64_SGI_SN2) := msi-altix.o
+
 obj-$(CONFIG_PCI_MSI) += $(msiobj-y)
 
 #
