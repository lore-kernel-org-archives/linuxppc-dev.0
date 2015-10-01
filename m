Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F9D1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 16:44:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/4] powerpc/pseries: Drop always true CONFIG_PSERIES_MSI
Date: Thu,  1 Oct 2015 16:44:34 +1000
Message-Id: <1443681874-28145-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1443681874-28145-1-git-send-email-mpe@ellerman.id.au>
References: <1443681874-28145-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that pseries selects PCI_MSI && PCI, EEH will always be true, and
therefore CONFIG_PSERIES_MSI will always be true. So drop it, and move
msi.o to obj-y.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/Kconfig  | 5 -----
 arch/powerpc/platforms/pseries/Makefile | 3 +--
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index d9068a3d6af4..bec90fb30425 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -43,11 +43,6 @@ config DTL
 
 	  Say N if you are unsure.
 
-config PSERIES_MSI
-       bool
-       depends on PCI_MSI && PPC_PSERIES && EEH
-       default y
-
 config PSERIES_ENERGY
 	tristate "pSeries energy management capabilities driver"
 	depends on PPC_PSERIES
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 952f4ba0546e..cf53be157624 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -4,11 +4,10 @@ ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   setup.o iommu.o event_sources.o ras.o \
 			   firmware.o power.o dlpar.o mobility.o rng.o \
-			   pci.o pci_dlpar.o eeh_pseries.o
+			   pci.o pci_dlpar.o eeh_pseries.o msi.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
-obj-$(CONFIG_PSERIES_MSI)	+= msi.o
 obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
-- 
2.1.4
