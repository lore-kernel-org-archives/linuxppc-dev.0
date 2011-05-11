Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 3DA421007F8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:40 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <7e6176e1d349f386d3a43dd88a4170a14ce0c7a4.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:42 -0500
Subject: [PATCH 20/37] powerpc: add kconfig for muxed smp ipi support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Compile the new smp ipi mux and demux code only if a platform
will make use of it.  The new config is selected as required.

The new cause_ipi smp op is only available conditionally to point out
configs where the select is required; this makes setting the op an
immediate fail instead of a deferred unresolved symbol at link.

This also creates a new config for power surge powermac upgrade support
that can be disabled in expert mode but is default on.

I also removed the depends / default y on CONFIG_XICS since it is selected
by PSERIES.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
I kept this seperate mostly because of the addition of the PSURGE kconfig
and to focus the discussion on the seperate concepts but it can be merged
into the previous patch if desireed.
---
 arch/powerpc/include/asm/smp.h          |    2 ++
 arch/powerpc/kernel/smp.c               |    2 ++
 arch/powerpc/platforms/Kconfig          |   11 +++++++++--
 arch/powerpc/platforms/Kconfig.cputype  |    2 ++
 arch/powerpc/platforms/iseries/Kconfig  |    1 +
 arch/powerpc/platforms/powermac/Kconfig |   11 ++++++++++-
 arch/powerpc/platforms/powermac/pic.c   |    4 ++--
 arch/powerpc/platforms/powermac/smp.c   |    8 ++++----
 8 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 9ae64bf..11eb404 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -38,7 +38,9 @@ extern void cpu_die(void);
 
 struct smp_ops_t {
 	void  (*message_pass)(int cpu, int msg);
+#ifdef CONFIG_PPC_SMP_MUXED_IPI
 	void  (*cause_ipi)(int cpu, unsigned long data);
+#endif
 	int   (*probe)(void);
 	int   (*kick_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 72717e1..a28e945 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -178,6 +178,7 @@ int smp_request_message_ipi(int virq, int msg)
 	return err;
 }
 
+#ifdef CONFIG_PPC_SMP_MUXED_IPI
 struct cpu_messages {
 	unsigned long messages;		/* current messages bits */
 	unsigned long data;		/* data for cause ipi */
@@ -230,6 +231,7 @@ irqreturn_t smp_ipi_demux(void)
 	}
 	return IRQ_HANDLED;
 }
+#endif /* CONFIG_PPC_SMP_MUXED_IPI */
 
 void smp_send_reschedule(int cpu)
 {
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 6059053..ac95735 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -57,15 +57,22 @@ config UDBG_RTAS_CONSOLE
 	depends on PPC_RTAS
 	default n
 
+config PPC_SMP_MUXED_IPI
+	bool
+	help
+	  Select this opton if your platform supports SMP and your
+	  interrupt controller provides less than 4 interrupts to each
+	  cpu.	This will enable the generic code to multiplex the 4
+	  messages on to one ipi.
+
 config PPC_UDBG_BEAT
 	bool "BEAT based debug console"
 	depends on PPC_CELLEB
 	default n
 
 config XICS
-	depends on PPC_PSERIES
 	bool
-	default y
+	select PPC_SMP_MUXED_IPI
 
 config IPIC
 	bool
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a1e6238..2165b65 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -73,6 +73,7 @@ config PPC_BOOK3S_64
 config PPC_BOOK3E_64
 	bool "Embedded processors"
 	select PPC_FPU # Make it a choice ?
+	select PPC_SMP_MUXED_IPI
 
 endchoice
 
@@ -178,6 +179,7 @@ config FSL_BOOKE
 config PPC_FSL_BOOK3E
 	bool
 	select FSL_EMB_PERFMON
+	select PPC_SMP_MUXED_IPI
 	default y if FSL_BOOKE
 
 config PTE_64BIT
diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
index ea1d362..b57cda3 100644
--- a/arch/powerpc/platforms/iseries/Kconfig
+++ b/arch/powerpc/platforms/iseries/Kconfig
@@ -1,6 +1,7 @@
 config PPC_ISERIES
 	bool "IBM Legacy iSeries"
 	depends on PPC64 && PPC_BOOK3S
+	select PPC_SMP_MUXED_IPI
 	select PPC_INDIRECT_PIO
 	select PPC_INDIRECT_MMIO
 	select PPC_PCI_CHOICE if EXPERT
diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index 1e1a087..1afd10f 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -18,4 +18,13 @@ config PPC_PMAC64
 	select PPC_970_NAP
 	default y
 
-
+config PPC_PMAC32_PSURGE
+	bool "Support for powersurge upgrade cards" if EXPERT
+	depends on SMP && PPC32 && PPC_PMAC
+	select PPC_SMP_MUXED_IPI
+	default y
+	help
+	  The powersurge cpu boards can be used in the generation
+	  of powermacs that have a socket for an upgradeable cpu card,
+	  including the 7500, 8500, 9500, 9600.  Support exists for
+	  both dual and quad socket upgrade cards.
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 2f34ad0..b706cb3 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -239,7 +239,7 @@ static unsigned int pmac_pic_get_irq(void)
 	unsigned long bits = 0;
 	unsigned long flags;
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_PPC_PMAC32_PSURGE
 	void psurge_smp_message_recv(void);
 
        	/* IPI's are a hack on the powersurge -- Cort */
@@ -247,7 +247,7 @@ static unsigned int pmac_pic_get_irq(void)
 		psurge_smp_message_recv();
 		return NO_IRQ_IGNORE;	/* ignore, already handled */
         }
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_PPC_PMAC32_PSURGE */
 	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
 	for (irq = max_real_irqs; (irq -= 32) >= 0; ) {
 		int i = irq >> 5;
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index a340107..67b6e14 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -70,7 +70,7 @@ static void (*pmac_tb_freeze)(int freeze);
 static u64 timebase;
 static int tb_req;
 
-#ifdef CONFIG_PPC32
+#ifdef CONFIG_PPC_PMAC32_PSURGE
 
 /*
  * Powersurge (old powermac SMP) support.
@@ -420,7 +420,7 @@ struct smp_ops_t psurge_smp_ops = {
 	.give_timebase	= smp_psurge_give_timebase,
 	.take_timebase	= smp_psurge_take_timebase,
 };
-#endif /* CONFIG_PPC32 - actually powersurge support */
+#endif /* CONFIG_PPC_PMAC32_PSURGE */
 
 /*
  * Core 99 and later support
@@ -980,7 +980,7 @@ void __init pmac_setup_smp(void)
 		of_node_put(np);
 		smp_ops = &core99_smp_ops;
 	}
-#ifdef CONFIG_PPC32
+#ifdef CONFIG_PPC_PMAC32_PSURGE
 	else {
 		/* We have to set bits in cpu_possible_mask here since the
 		 * secondary CPU(s) aren't in the device tree. Various
@@ -993,7 +993,7 @@ void __init pmac_setup_smp(void)
 			set_cpu_possible(cpu, true);
 		smp_ops = &psurge_smp_ops;
 	}
-#endif /* CONFIG_PPC32 */
+#endif /* CONFIG_PPC_PMAC32_PSURGE */
 
 #ifdef CONFIG_HOTPLUG_CPU
 	ppc_md.cpu_die = pmac_cpu_die;
-- 
1.7.0.4
