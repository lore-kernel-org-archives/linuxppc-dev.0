Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2DA21A04CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 09:31:38 +1000 (EST)
Date: Tue, 12 Aug 2014 09:31:37 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 paulmck@linux.vnet.ibm.com
Subject: [PATCH 2/2] powerpc: Add ppc64 hard lockup detector support
Message-ID: <20140812093137.404e8930@kryten>
In-Reply-To: <20140805145621.2fa2a372@kryten>
References: <20140805145500.773004e9@kryten> <20140805145621.2fa2a372@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hard lockup detector uses a PMU event as a periodic NMI to
detect if we are stuck (where stuck means no timer interrupts have
occurred).

Ben's rework of the ppc64 soft disable code has made ppc64 PMU
exceptions a partial NMI. They can get disabled if an external interrupt
comes in, but otherwise PMU interrupts will fire in interrupt disabled
regions.

I wrote a kernel module to test this patch and noticed we sometimes
missed hard lockup warnings. The RCU code detected the stall first and
issued an IPI to backtrace all CPUs. Unfortunately an IPI is an external
interrupt and that will hard disable interrupts, preventing the hard
lockup detector from going off.

If I reduced the hard lockup threshold to 5 seconds:

echo 5 > /proc/sys/kernel/watchdog_thresh

Then it would beat the RCU code in detecting a stall and get a
correct backtrace out.

Another downside is that our PMCs can only count to 2^31, so even when
we ask for 10 seconds of processor cycles, we end up taking a couple
of PMU exceptions a second.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

v2: Mikey noticed a build issue with oprofile. Since our NMI is just
the PMU hardware it doesn't make any sense for oprofile to try and
use it.

Index: b/arch/powerpc/Kconfig
===================================================================
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -145,6 +145,7 @@ config PPC
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select ARCH_USE_CMPXCHG_LOCKREF if PPC64
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_PERF_EVENTS_NMI if PPC64
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
Index: b/arch/powerpc/include/asm/nmi.h
===================================================================
--- /dev/null
+++ b/arch/powerpc/include/asm/nmi.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_NMI_H
+#define _ASM_NMI_H
+
+#endif /* _ASM_NMI_H */
Index: b/arch/powerpc/kernel/setup_64.c
===================================================================
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -800,3 +800,10 @@ unsigned long memory_block_size_bytes(vo
 struct ppc_pci_io ppc_pci_io;
 EXPORT_SYMBOL(ppc_pci_io);
 #endif
+
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
+u64 hw_nmi_get_sample_period(int watchdog_thresh)
+{
+	return ppc_proc_freq * watchdog_thresh;
+}
+#endif
Index: b/arch/Kconfig
===================================================================
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -32,7 +32,7 @@ config HAVE_OPROFILE
 
 config OPROFILE_NMI_TIMER
 	def_bool y
-	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	depends on (PERF_EVENTS && HAVE_PERF_EVENTS_NMI) && !PPC
 
 config KPROBES
 	bool "Kprobes"
