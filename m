Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHtdJ0bJRzDvhd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 14:47:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/pseries: Move vio.c into platforms pseries
Date: Tue, 15 Nov 2016 14:47:42 +1100
Message-Id: <1479181664-6699-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vio.c is pseries only code, so move it in there.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/Makefile                     | 1 -
 arch/powerpc/platforms/Kconfig                   | 5 -----
 arch/powerpc/platforms/pseries/Kconfig           | 5 +++++
 arch/powerpc/platforms/pseries/Makefile          | 1 +
 arch/powerpc/{kernel => platforms/pseries}/vio.c | 0
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/powerpc/{kernel => platforms/pseries}/vio.c (100%)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1925341dbb9c..9c57ebf61e4d 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -58,7 +58,6 @@ obj-$(CONFIG_PPC_RTAS)		+= rtas.o rtas-rtc.o $(rtaspci-y-y)
 obj-$(CONFIG_PPC_RTAS_DAEMON)	+= rtasd.o
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
 obj-$(CONFIG_RTAS_PROC)		+= rtas-proc.o
-obj-$(CONFIG_IBMVIO)		+= vio.o
 obj-$(CONFIG_IBMEBUS)           += ibmebus.o
 obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
 				  eeh_driver.o eeh_event.o eeh_sysfs.o
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index fbdae8377b71..eae86c35e4c6 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -168,11 +168,6 @@ config MPIC_BROKEN_REGREAD
 	  well, but enabling it uses about 8KB of memory to keep copies
 	  of the register contents in software.
 
-config IBMVIO
-	depends on PPC_PSERIES
-	bool
-	default y
-
 config IBMEBUS
 	depends on PPC_PSERIES
 	bool "Support for GX bus based adapters"
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index bec90fb30425..f7d78b81951d 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -127,3 +127,8 @@ config HV_PERF_CTRS
 	  systems. 24x7 is available on Power 8 systems.
 
           If unsure, select Y.
+
+config IBMVIO
+	depends on PPC_PSERIES
+	bool
+	default y
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index fedc2ccf029d..85ba00233fb0 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_CMM)		+= cmm.o
 obj-$(CONFIG_DTL)		+= dtl.o
 obj-$(CONFIG_IO_EVENT_IRQ)	+= io_event_irq.o
 obj-$(CONFIG_LPARCFG)		+= lparcfg.o
+obj-$(CONFIG_IBMVIO)		+= vio.o
 
 ifeq ($(CONFIG_PPC_PSERIES),y)
 obj-$(CONFIG_SUSPEND)		+= suspend.o
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/platforms/pseries/vio.c
similarity index 100%
rename from arch/powerpc/kernel/vio.c
rename to arch/powerpc/platforms/pseries/vio.c
-- 
2.7.4
