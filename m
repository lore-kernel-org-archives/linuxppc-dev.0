Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/6] powerpc: Make NR_IRQS a CONFIG option
Date: Wed, 14 Oct 2009 16:44:44 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The irq_desc array consumes quite a lot of space, and for systems
that don't need or can't have 512 irqs it's just wasted space.

The first 16 are reserved for ISA, so the minimum of 32 is really
16 - and no one has asked for more than 512 so leave that as the
maximum.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig           |   10 ++++++++++
 arch/powerpc/include/asm/irq.h |    4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 10a0a54..2230e75 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -56,6 +56,16 @@ config IRQ_PER_CPU
 	bool
 	default y
 
+config NR_IRQS
+	int "Number of virtual interrupt numbers"
+	range 32 512
+	default "512"
+	help
+	  This defines the number of virtual interrupt numbers the kernel
+	  can manage. Virtual interrupt numbers are what you see in
+	  /proc/interrupts. If you configure your system to have too few,
+	  drivers will fail to load or worse - handle with care.
+
 config STACKTRACE_SUPPORT
 	bool
 	default y
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index bbcd1aa..b83fcc8 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -34,8 +34,8 @@ extern atomic_t ppc_n_lost_interrupts;
  */
 #define NO_IRQ_IGNORE		((unsigned int)-1)
 
-/* Total number of virq in the platform (make it a CONFIG_* option ? */
-#define NR_IRQS		512
+/* Total number of virq in the platform */
+#define NR_IRQS		CONFIG_NR_IRQS
 
 /* Number of irqs reserved for the legacy controller */
 #define NUM_ISA_INTERRUPTS	16
-- 
1.6.2.1
