Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 07 Nov 2006 18:21:25 +1100
Subject: [RFC/PATCH 7/7] Enable MSI on Powerpc
In-Reply-To: <1162884080.585336.70559261997.qpush@cradle>
Message-Id: <20061107072127.D589667D06@ozlabs.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow PCI_MSI to build on Powerpc. Hook up a few platforms to use
the appropriate MSI backend.

We still need CONFIG_POWERPC.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/Makefile           |    6 ++++++
 arch/powerpc/platforms/maple/setup.c   |    3 +++
 arch/powerpc/platforms/powermac/pic.c  |    3 +++
 arch/powerpc/platforms/pseries/setup.c |    3 +++
 drivers/pci/Kconfig                    |    2 +-
 drivers/pci/Makefile                   |    4 +++-
 6 files changed, 19 insertions(+), 2 deletions(-)

Index: msi/arch/powerpc/kernel/Makefile
===================================================================
--- msi.orig/arch/powerpc/kernel/Makefile
+++ msi/arch/powerpc/kernel/Makefile
@@ -66,6 +66,12 @@ pci64-$(CONFIG_PPC64)		+= pci_64.o pci_d
 				   pci_direct_iommu.o iomap.o
 pci32-$(CONFIG_PPC32)		:= pci_32.o
 obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y)
+
+msiobj-y			:= msi.o
+msiobj-$(CONFIG_PPC_RTAS)	+= msi-rtas.o
+msiobj-$(CONFIG_MPIC)		+= msi-mpic.o
+obj-$(CONFIG_PCI_MSI)		+= $(msiobj-y)
+
 kexec-$(CONFIG_PPC64)		:= machine_kexec_64.o
 kexec-$(CONFIG_PPC32)		:= machine_kexec_32.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o $(kexec-y)
Index: msi/arch/powerpc/platforms/maple/setup.c
===================================================================
--- msi.orig/arch/powerpc/platforms/maple/setup.c
+++ msi/arch/powerpc/platforms/maple/setup.c
@@ -61,6 +61,7 @@
 #include <asm/lmb.h>
 #include <asm/mpic.h>
 #include <asm/udbg.h>
+#include <asm/msi.h>
 
 #include "maple.h"
 
@@ -275,6 +276,8 @@ static void __init maple_init_IRQ(void)
 	ppc_md.get_irq = mpic_get_irq;
 	of_node_put(mpic_node);
 	of_node_put(root);
+
+	msi_mpic_init();
 }
 
 static void __init maple_progress(char *s, unsigned short hex)
Index: msi/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- msi.orig/arch/powerpc/platforms/powermac/pic.c
+++ msi/arch/powerpc/platforms/powermac/pic.c
@@ -34,6 +34,7 @@
 #include <asm/time.h>
 #include <asm/pmac_feature.h>
 #include <asm/mpic.h>
+#include <asm/msi.h>
 
 #include "pmac.h"
 
@@ -562,6 +563,8 @@ static int __init pmac_pic_probe_mpic(vo
 	set_irq_data(cascade, mpic2);
 	set_irq_chained_handler(cascade, pmac_u3_cascade);
 
+	msi_mpic_init();
+
 	of_node_put(slave);
 	return 0;
 }
Index: msi/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- msi.orig/arch/powerpc/platforms/pseries/setup.c
+++ msi/arch/powerpc/platforms/pseries/setup.c
@@ -65,6 +65,7 @@
 #include <asm/i8259.h>
 #include <asm/udbg.h>
 #include <asm/smp.h>
+#include <asm/msi.h>
 
 #include "plpar_wrappers.h"
 #include "ras.h"
@@ -275,6 +276,7 @@ static void __init pseries_discover_pic(
 #ifdef CONFIG_SMP
 			smp_init_pseries_mpic();
 #endif
+			msi_mpic_init();
 			return;
 		} else if (strstr(typep, "ppc-xicp")) {
 			ppc_md.init_IRQ       = xics_init_IRQ;
@@ -284,6 +286,7 @@ static void __init pseries_discover_pic(
 #ifdef CONFIG_SMP
 			smp_init_pseries_xics();
 #endif
+			msi_rtas_init();
 			return;
 		}
 	}
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
