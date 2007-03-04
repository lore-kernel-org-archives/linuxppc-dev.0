Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C8C19DE00D
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 17:07:53 +1100 (EST)
Date: Sun, 4 Mar 2007 17:04:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 4/6] [POWERPC] allow pSeries to build without CONFIG_PCI
Message-Id: <20070304170444.2eb423ce.sfr@canb.auug.org.au>
In-Reply-To: <20070304170348.511af7cb.sfr@canb.auug.org.au>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<20070304170241.816f9802.sfr@canb.auug.org.au>
	<20070304170348.511af7cb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig                    |    5 ++-
 arch/powerpc/kernel/Makefile            |    4 +-
 arch/powerpc/platforms/pseries/Makefile |    5 ++-
 arch/powerpc/platforms/pseries/iommu.c  |   53 +++++++++++++++++-------------
 arch/powerpc/platforms/pseries/setup.c  |    5 +++
 drivers/video/Kconfig                   |    2 +-
 include/asm-powerpc/ppc-pci.h           |    7 ++++
 7 files changed, 51 insertions(+), 30 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6dfbd52..e720527 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -89,7 +89,7 @@ config SCHED_NO_NO_OMIT_FRAME_POINTER
 
 config ARCH_MAY_HAVE_PC_FDC
 	bool
-	default y
+	default !PPC_PSERIES || PCI
 
 config PPC_OF
 	def_bool y
@@ -1028,7 +1028,8 @@ config MCA
 
 config PCI
 	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
-		|| PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2 || PPC_PS3
+		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
+		|| MPC7448HPC2 || PPC_PS3
 	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 8120d42..e0fa80e 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -25,8 +25,8 @@ obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
 obj-$(CONFIG_PPC_OF)		+= of_device.o of_platform.o prom_parse.o
 procfs-$(CONFIG_PPC64)		:= proc_ppc64.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
-rtaspci-$(CONFIG_PPC64)		:= rtas_pci.o
-obj-$(CONFIG_PPC_RTAS)		+= rtas.o rtas-rtc.o $(rtaspci-y)
+rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)	:= rtas_pci.o
+obj-$(CONFIG_PPC_RTAS)		+= rtas.o rtas-rtc.o $(rtaspci-y-y)
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
 obj-$(CONFIG_RTAS_PROC)		+= rtas-proc.o
 obj-$(CONFIG_LPARCFG)		+= lparcfg.o
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 2dfd050..90235d5 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -2,14 +2,15 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS		+= -mno-minimal-toc
 endif
 
-obj-y			:= pci.o lpar.o hvCall.o nvram.o reconfig.o \
-			   setup.o iommu.o ras.o rtasd.o pci_dlpar.o \
+obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
+			   setup.o iommu.o ras.o rtasd.o \
 			   firmware.o power.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_XICS)	+= xics.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
+obj-$(CONFIG_PCI)	+= pci.o pci_dlpar.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
 
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9322f74..f9510a5 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -242,6 +242,7 @@ static unsigned long tce_get_pSeriesLP(struct iommu_table *tbl, long tcenum)
 	return tce_ret;
 }
 
+#ifdef CONFIG_PCI
 static void iommu_table_setparms(struct pci_controller *phb,
 				 struct device_node *dn,
 				 struct iommu_table *tbl)
@@ -478,29 +479,6 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		       pci_name(dev));
 }
 
-static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *node)
-{
-	int err = NOTIFY_OK;
-	struct device_node *np = node;
-	struct pci_dn *pci = PCI_DN(np);
-
-	switch (action) {
-	case PSERIES_RECONFIG_REMOVE:
-		if (pci && pci->iommu_table &&
-		    get_property(np, "ibm,dma-window", NULL))
-			iommu_free_table(np);
-		break;
-	default:
-		err = NOTIFY_DONE;
-		break;
-	}
-	return err;
-}
-
-static struct notifier_block iommu_reconfig_nb = {
-	.notifier_call = iommu_reconfig_notifier,
-};
-
 static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 {
 	struct device_node *pdn, *dn;
@@ -554,6 +532,35 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 
 	dev->dev.archdata.dma_data = pci->iommu_table;
 }
+#else  /* CONFIG_PCI */
+#define pci_dma_bus_setup_pSeries	NULL
+#define pci_dma_dev_setup_pSeries	NULL
+#define pci_dma_bus_setup_pSeriesLP	NULL
+#define pci_dma_dev_setup_pSeriesLP	NULL
+#endif /* !CONFIG_PCI */
+
+static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *node)
+{
+	int err = NOTIFY_OK;
+	struct device_node *np = node;
+	struct pci_dn *pci = PCI_DN(np);
+
+	switch (action) {
+	case PSERIES_RECONFIG_REMOVE:
+		if (pci && pci->iommu_table &&
+		    get_property(np, "ibm,dma-window", NULL))
+			iommu_free_table(np);
+		break;
+	default:
+		err = NOTIFY_DONE;
+		break;
+	}
+	return err;
+}
+
+static struct notifier_block iommu_reconfig_nb = {
+	.notifier_call = iommu_reconfig_notifier,
+};
 
 /* These are called very early. */
 void iommu_init_early_pSeries(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 34aff47..ff87b1a 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -65,6 +65,7 @@
 #include <asm/udbg.h>
 #include <asm/smp.h>
 #include <asm/firmware.h>
+#include <asm/eeh.h>
 
 #include "plpar_wrappers.h"
 #include "pseries.h"
@@ -514,6 +515,10 @@ void pSeries_power_off(void)
 	for (;;);
 }
 
+#ifndef CONFIG_PCI
+void pSeries_final_fixup(void) { }
+#endif
+
 define_machine(pseries) {
 	.name			= "pSeries",
 	.probe			= pSeries_probe,
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8874cf2..9478ad9 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -388,7 +388,7 @@ config FB_ATARI
 
 config FB_OF
 	bool "Open Firmware frame buffer device support"
-	depends on (FB = y) && (PPC64 || PPC_OF)
+	depends on (FB = y) && (PPC64 || PPC_OF) && (!PPC_PSERIES || PCI)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/include/asm-powerpc/ppc-pci.h b/include/asm-powerpc/ppc-pci.h
index ab6eddb..4a05340 100644
--- a/include/asm-powerpc/ppc-pci.h
+++ b/include/asm-powerpc/ppc-pci.h
@@ -10,6 +10,8 @@
 #define _ASM_POWERPC_PPC_PCI_H
 #ifdef __KERNEL__
 
+#ifdef CONFIG_PCI
+
 #include <linux/pci.h>
 #include <asm/pci-bridge.h>
 
@@ -126,5 +128,10 @@ struct device_node * find_device_pe(struct device_node *dn);
 
 #endif
 
+#else /* CONFIG_PCI */
+static inline void find_and_init_phbs(void) { }
+static inline void init_pci_config_tokens(void) { }
+#endif /* !CONFIG_PCI */
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_PPC_PCI_H */
-- 
1.5.0.1
