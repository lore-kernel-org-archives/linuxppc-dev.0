Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 3B757DDDA8
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 02:55:27 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Neuling <mikey@neuling.org>
Subject: [PATCH] powerpc/cell: fix dependency in cpufreq
Date: Tue, 10 Feb 2009 16:55:16 +0100
References: <18282.1234226812@neuling.org> <22829.1234230526@neuling.org>
	<25212.1234231317@neuling.org>
In-Reply-To: <25212.1234231317@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200902101655.17013.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Christian Krafft <parabelboi@bopserverein.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cbe_cpufreq has a partial dependency on cbe_cpufreq_pmi, which cannot
be easily expressed in Kconfig. This fixes it by introducing an
extra Kconfig symbol CBE_CPUFREQ_PMI_ENABLE. To make the dependency
clearer, turn PPC_PMI into an automatic symbol.

Reported-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

This is the best I could come up with.

--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -91,15 +91,6 @@ config RTAS_FLASH
 	tristate "Firmware flash interface"
 	depends on PPC64 && RTAS_PROC
 
-config PPC_PMI
-	tristate "Support for PMI"
-	depends on PPC_IBM_CELL_BLADE
-	help
-	  PMI (Platform Management Interrupt) is a way to
-	  communicate with the BMC (Baseboard Management Controller).
-	  It is used in some IBM Cell blades.
-	default m
-
 config MMIO_NVRAM
 	bool
 	default n
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 5cc3279..037f59a 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -98,7 +98,7 @@ config PPC_IBM_CELL_RESETBUTTON
 
 config PPC_IBM_CELL_POWERBUTTON
 	tristate "IBM Cell Blade power button"
-	depends on PPC_IBM_CELL_BLADE && PPC_PMI && INPUT_EVDEV
+	depends on PPC_IBM_CELL_BLADE && INPUT_EVDEV
 	default y
 	help
 	  Support Powerbutton on IBM Cell blades.
@@ -118,9 +118,9 @@ config CBE_CPUFREQ
 	  For details, take a look at <file:Documentation/cpu-freq/>.
 	  If you don't have such processor, say N
 
-config CBE_CPUFREQ_PMI
-	tristate "CBE frequency scaling using PMI interface"
-	depends on CBE_CPUFREQ && PPC_PMI && EXPERIMENTAL
+config CBE_CPUFREQ_PMI_ENABLE
+	bool "CBE frequency scaling using PMI interface"
+	depends on CBE_CPUFREQ && EXPERIMENTAL
 	default n
 	help
 	  Select this, if you want to use the PMI interface
@@ -128,6 +128,20 @@ config CBE_CPUFREQ_PMI
 	  processor will not only be able to run at lower speed,
 	  but also at lower core voltage.
 
+config CBE_CPUFREQ_PMI
+	tristate
+	depends on CBE_CPUFREQ_PMI_ENABLE
+	default CBE_CPUFREQ
+
+config PPC_PMI
+	tristate
+	default y
+	depends on CBE_CPUFREQ_PMI || PPC_IBM_CELL_POWERBUTTON
+	help
+	  PMI (Platform Management Interrupt) is a way to
+	  communicate with the BMC (Baseboard Management Controller).
+	  It is used in some IBM Cell blades.
+
 config CBE_CPUFREQ_SPU_GOVERNOR
 	tristate "CBE frequency scaling based on SPU usage"
 	depends on SPU_FS && CPU_FREQ
