Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f80c18430f822e26ad6f824058baff5c61647354.1209013992.git.michael@ellerman.id.au>
In-Reply-To: <c01702547f6296b2c18e5ff7504ad52cb0402664.1209013992.git.michael@ellerman.id.au>
References: <c01702547f6296b2c18e5ff7504ad52cb0402664.1209013992.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/5] Add CONFIG_PPC_PSERIES_DEBUG to enable debugging for
	platforms/pseries
Date: Thu, 24 Apr 2008 15:13:21 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a DEBUG config setting which turns on all (most) of the debugging
under platforms/pseries.

To have this take effect we need to remove all the #undef DEBUG's, in
various files. We leave the #undef DEBUG in platforms/pseries/lpar.c,
as this enables debugging printks from the low-level hash table routines,
and tends to make your system unusable. If you want those enabled you
still have to turn them on by hand.

Also some of the RAS code has a DEBUG block which causes a functional
change, so I've keyed this off a different (non-existant) debug #define.

This is only enabled if you have PPC_EARLY_DEBUG enabled also.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/Kconfig     |    5 +++++
 arch/powerpc/platforms/pseries/Makefile    |    4 ++++
 arch/powerpc/platforms/pseries/eeh.c       |    1 -
 arch/powerpc/platforms/pseries/eeh_cache.c |    1 -
 arch/powerpc/platforms/pseries/firmware.c  |    1 -
 arch/powerpc/platforms/pseries/ras.c       |    4 +---
 arch/powerpc/platforms/pseries/setup.c     |    2 --
 arch/powerpc/platforms/pseries/smp.c       |    1 -
 arch/powerpc/platforms/pseries/xics.c      |    1 -
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 306a9d0..07fe5b6 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -34,3 +34,8 @@ config LPARCFG
 	help
 	Provide system capacity information via human readable
 	<key word>=<value> pairs through a /proc/ppc64/lparcfg interface.
+
+config PPC_PSERIES_DEBUG
+	depends on PPC_PSERIES && PPC_EARLY_DEBUG
+	bool "Enable extra debug logging in platforms/pseries"
+	default y
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index bdae04b..bd2593e 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -2,6 +2,10 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS		+= -mno-minimal-toc
 endif
 
+ifeq ($(CONFIG_PPC_PSERIES_DEBUG),y)
+EXTRA_CFLAGS		+= -DDEBUG
+endif
+
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   setup.o iommu.o ras.o rtasd.o \
 			   firmware.o power.o
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 550b2f7..a3fd56b 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -39,7 +39,6 @@
 #include <asm/ppc-pci.h>
 #include <asm/rtas.h>
 
-#undef DEBUG
 
 /** Overview:
  *  EEH, or "Extended Error Handling" is a PCI bridge technology for
diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
index 1e83fcd..ce37040 100644
--- a/arch/powerpc/platforms/pseries/eeh_cache.c
+++ b/arch/powerpc/platforms/pseries/eeh_cache.c
@@ -28,7 +28,6 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
 
-#undef DEBUG
 
 /**
  * The pci address cache subsystem.  This subsystem places
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 743d494..9d3a40f 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -21,7 +21,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#undef DEBUG
 
 #include <asm/firmware.h>
 #include <asm/prom.h>
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index a1ab25c..2b548af 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -67,8 +67,6 @@ static int ras_check_exception_token;
 static irqreturn_t ras_epow_interrupt(int irq, void *dev_id);
 static irqreturn_t ras_error_interrupt(int irq, void *dev_id);
 
-/* #define DEBUG */
-
 
 static void request_ras_irqs(struct device_node *np,
 			irq_handler_t handler,
@@ -237,7 +235,7 @@ static irqreturn_t ras_error_interrupt(int irq, void *dev_id)
 		printk(KERN_EMERG "Error: Fatal hardware error <0x%lx 0x%x>\n",
 		       *((unsigned long *)&ras_log_buf), status);
 
-#ifndef DEBUG
+#ifndef DEBUG_RTAS_POWER_OFF
 		/* Don't actually power off when debugging so we can test
 		 * without actually failing while injecting errors.
 		 * Error data will not be logged to syslog.
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 65e8795..f5d29f5 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -16,8 +16,6 @@
  * bootup setup stuff..
  */
 
-#undef DEBUG
-
 #include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index e9bc2a5..9d8f8c8 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -12,7 +12,6 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#undef DEBUG
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 43df53c..ebebc28 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -9,7 +9,6 @@
  *  2 of the License, or (at your option) any later version.
  */
 
-#undef DEBUG
 
 #include <linux/types.h>
 #include <linux/threads.h>
-- 
1.5.5
