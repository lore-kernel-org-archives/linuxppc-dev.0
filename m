Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Arnd Bergmann <arnd@arndb.de>
MIME-Version: 1.0
Subject: [PATCH] powerpc/cell: fix dependency in cpufreq
Date: Tue, 10 Feb 2009 11:46:52 +1100
Message-ID: <18282.1234226812@neuling.org>
Sender: mikey@neuling.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cbe_cpufreq.c uses cbe_cpufreq_has_pmi which is provided by
cbe_cpufreq_pmi.c.  Hence CBE_CPUFREQ depends on CBE_CPUFREQ_PMI.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
I'm not 100% sure is this the right fix.  Should CBE_CPUFREQ really
depend on CBE_CPUFREQ_PMI?

 arch/powerpc/platforms/cell/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/cell/Kconfig
+++ linux-2.6-ozlabs/arch/powerpc/platforms/cell/Kconfig
@@ -111,7 +111,7 @@ config CBE_THERM
 
 config CBE_CPUFREQ
 	tristate "CBE frequency scaling"
-	depends on CBE_RAS && CPU_FREQ
+	depends on CBE_RAS && CPU_FREQ && CBE_CPUFREQ_PMI
 	default m
 	help
 	  This adds the cpufreq driver for Cell BE processors.
@@ -120,7 +120,7 @@ config CBE_CPUFREQ
 
 config CBE_CPUFREQ_PMI
 	tristate "CBE frequency scaling using PMI interface"
-	depends on CBE_CPUFREQ && PPC_PMI && EXPERIMENTAL
+	depends on PPC_PMI && EXPERIMENTAL
 	default n
 	help
 	  Select this, if you want to use the PMI interface
