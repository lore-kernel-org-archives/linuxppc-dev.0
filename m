Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4D071A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Sep 2014 14:23:23 +1000 (EST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 67A4114018A
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2014 14:23:23 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: Don't call generic code on offline cpus
Date: Tue,  2 Sep 2014 14:23:16 +1000
Message-Id: <1409631796-32139-1-git-send-email-paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platforms, when a CPU is offline, we put it into nap mode.
It's possible that the CPU wakes up from nap mode while it is still
offline due to a stray IPI.  A misdirected device interrupt could also
potentially cause it to wake up.  In that circumstance, we need to clear
the interrupt so that the CPU can go back to nap mode.

In the past the clearing of the interrupt was accomplished by briefly
enabling interrupts and allowing the normal interrupt handling code
(do_IRQ() etc.) to handle the interrupt.  This has the problem that
this code calls irq_enter() and irq_exit(), which call functions such
as account_system_vtime() which use RCU internally.  Use of RCU is not
permitted on offline CPUs and will trigger errors if RCU checking is
enabled.

To avoid calling into any generic code which might use RCU, we adopt
a different method of clearing interrupts on offline CPUs.  Since we
are on the PowerNV platform, we know that the system interrupt
controller is a XICS being driven directly (i.e. not via hcalls) by
the kernel.  Hence this adds a new icp_native_flush_interrupt()
function to the native-mode XICS driver and arranges to call that
when an offline CPU is woken from nap.  This new function reads the
interrupt from the XICS.  If it is an IPI, it clears the IPI; if it
is a device interrupt, it prints a warning and disables the source.
Then it does the end-of-interrupt processing for the interrupt.

The other thing that briefly enabling interrupts did was to check and
clear the irq_happened flag in this CPU's PACA.  Therefore, after
flushing the interrupt from the XICS, we also clear all bits except
the PACA_IRQ_HARD_DIS (interrupts are hard disabled) bit from the
irq_happened flag.  The PACA_IRQ_HARD_DIS flag is set by power7_nap()
and is left set to indicate that interrupts are hard disabled.  This
means we then have to ignore that flag in power7_nap(), which is
reasonable since it doesn't indicate that any interrupt event needs
servicing.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/xics.h       |  1 +
 arch/powerpc/kernel/idle_power7.S     |  2 +-
 arch/powerpc/platforms/powernv/smp.c  |  6 +++---
 arch/powerpc/sysdev/xics/icp-native.c | 25 +++++++++++++++++++++++++
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index 282d43a..0d050ea 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -29,6 +29,7 @@
 /* Native ICP */
 #ifdef CONFIG_PPC_ICP_NATIVE
 extern int icp_native_init(void);
+extern void icp_native_flush_interrupt(void);
 #else
 static inline int icp_native_init(void) { return -ENODEV; }
 #endif
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index be05841..c0754bb 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -73,7 +73,7 @@ _GLOBAL(power7_powersave_common)
 
 	/* Check if something happened while soft-disabled */
 	lbz	r0,PACAIRQHAPPENED(r13)
-	cmpwi	cr0,r0,0
+	andi.	r0,r0,~PACA_IRQ_HARD_DIS@l
 	beq	1f
 	cmpwi	cr0,r4,0
 	beq	1f
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 5fcfcf4..9b71a5c 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -168,9 +168,9 @@ static void pnv_smp_cpu_kill_self(void)
 		power7_nap(1);
 		ppc64_runlatch_on();
 
-		/* Reenable IRQs briefly to clear the IPI that woke us */
-		local_irq_enable();
-		local_irq_disable();
+		/* Clear the IPI that woke us up */
+		icp_native_flush_interrupt();
+		local_paca->irq_happened &= PACA_IRQ_HARD_DIS;
 		mb();
 
 		if (cpu_core_split_required())
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index de8d948..2fc4cf1 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -155,6 +155,31 @@ static void icp_native_cause_ipi(int cpu, unsigned long data)
 		icp_native_set_qirr(cpu, IPI_PRIORITY);
 }
 
+/*
+ * Called when an interrupt is received on an off-line CPU to
+ * clear the interrupt, so that the CPU can go back to nap mode.
+ */
+void icp_native_flush_interrupt(void)
+{
+	unsigned int xirr = icp_native_get_xirr();
+	unsigned int vec = xirr & 0x00ffffff;
+
+	if (vec == XICS_IRQ_SPURIOUS)
+		return;
+	if (vec == XICS_IPI) {
+		/* Clear pending IPI */
+		int cpu = smp_processor_id();
+		kvmppc_set_host_ipi(cpu, 0);
+		icp_native_set_qirr(cpu, 0xff);
+	} else {
+		pr_err("XICS: hw interrupt 0x%x to offline cpu, disabling\n",
+		       vec);
+		xics_mask_unknown_vec(vec);
+	}
+	/* EOI the interrupt */
+	icp_native_set_xirr(xirr);
+}
+
 void xics_wake_cpu(int cpu)
 {
 	icp_native_set_qirr(cpu, IPI_PRIORITY);
-- 
2.1.0.rc1
