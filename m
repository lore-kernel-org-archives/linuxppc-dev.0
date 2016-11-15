Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHtdJ6HBmzDvhd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 14:47:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/pseries: Move ibmebus.c into platforms pseries
Date: Tue, 15 Nov 2016 14:47:43 +1100
Message-Id: <1479181664-6699-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1479181664-6699-1-git-send-email-mpe@ellerman.id.au>
References: <1479181664-6699-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ibmebus.c is pseries only code, so move it in there.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/Makefile                         | 1 -
 arch/powerpc/platforms/Kconfig                       | 6 ------
 arch/powerpc/platforms/pseries/Kconfig               | 6 ++++++
 arch/powerpc/platforms/pseries/Makefile              | 1 +
 arch/powerpc/{kernel => platforms/pseries}/ibmebus.c | 0
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/powerpc/{kernel => platforms/pseries}/ibmebus.c (100%)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 9c57ebf61e4d..26b5a5e02e69 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -58,7 +58,6 @@ obj-$(CONFIG_PPC_RTAS)		+= rtas.o rtas-rtc.o $(rtaspci-y-y)
 obj-$(CONFIG_PPC_RTAS_DAEMON)	+= rtasd.o
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
 obj-$(CONFIG_RTAS_PROC)		+= rtas-proc.o
-obj-$(CONFIG_IBMEBUS)           += ibmebus.o
 obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
 				  eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index eae86c35e4c6..7e3a2ebba29b 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -168,12 +168,6 @@ config MPIC_BROKEN_REGREAD
 	  well, but enabling it uses about 8KB of memory to keep copies
 	  of the register contents in software.
 
-config IBMEBUS
-	depends on PPC_PSERIES
-	bool "Support for GX bus based adapters"
-	help
-	  Bus device driver for GX bus based adapters.
-
 config EEH
 	bool
 	depends on (PPC_POWERNV || PPC_PSERIES) && PCI
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index f7d78b81951d..fbf2e4477f88 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -132,3 +132,9 @@ config IBMVIO
 	depends on PPC_PSERIES
 	bool
 	default y
+
+config IBMEBUS
+	depends on PPC_PSERIES
+	bool "Support for GX bus based adapters"
+	help
+	  Bus device driver for GX bus based adapters.
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 85ba00233fb0..942fe116a8ba 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_DTL)		+= dtl.o
 obj-$(CONFIG_IO_EVENT_IRQ)	+= io_event_irq.o
 obj-$(CONFIG_LPARCFG)		+= lparcfg.o
 obj-$(CONFIG_IBMVIO)		+= vio.o
+obj-$(CONFIG_IBMEBUS)		+= ibmebus.o
 
 ifeq ($(CONFIG_PPC_PSERIES),y)
 obj-$(CONFIG_SUSPEND)		+= suspend.o
diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
similarity index 100%
rename from arch/powerpc/kernel/ibmebus.c
rename to arch/powerpc/platforms/pseries/ibmebus.c
-- 
2.7.4
