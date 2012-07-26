Return-Path: <paulus@ozlabs.org>
Date: Fri, 27 Jul 2012 09:56:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Give hypervisor decrementer interrupts their own
 handler
Message-ID: <20120726235611.GA16566@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the handler for hypervisor decrementer interrupts is
the same as for decrementer interrupts, i.e. timer_interrupt().
This is bogus; if we ever do get a hypervisor decrementer interrupt
it won't have anything to do with the next timer event.  In fact
the only time we get hypervisor decrementer interrupts is when one
is left pending on exit from a KVM guest.

When we get a hypervisor decrementer interrupt we don't need to do
anything special to clear it, since they are edge-triggered on the
transition of HDEC from 0 to -1.  Thus this adds an empty handler
function for them.  We don't need to have them masked when interrupts
are soft-disabled, so we use STD_EXCEPTION_HV instead of
MASKABLE_EXCEPTION_HV.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/exceptions-64s.S |    3 ++-
 arch/powerpc/kernel/time.c           |    9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 925bd6d..5b64eb2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -188,7 +188,7 @@ hardware_interrupt_hv:
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x800)
 
 	MASKABLE_EXCEPTION_PSERIES(0x900, 0x900, decrementer)
-	MASKABLE_EXCEPTION_HV(0x980, 0x982, decrementer)
+	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
 
 	STD_EXCEPTION_PSERIES(0xa00, 0xa00, trap_0a)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xa00)
@@ -489,6 +489,7 @@ machine_check_common:
 
 	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt, do_IRQ)
 	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, .timer_interrupt)
+	STD_EXCEPTION_COMMON(0x980, hdecrementer, .hdec_interrupt)
 	STD_EXCEPTION_COMMON(0xa00, trap_0a, .unknown_exception)
 	STD_EXCEPTION_COMMON(0xb00, trap_0b, .unknown_exception)
 	STD_EXCEPTION_COMMON(0xd00, single_step, .single_step_exception)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index be171ee..e49e931 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -535,6 +535,15 @@ void timer_interrupt(struct pt_regs * regs)
 	trace_timer_interrupt_exit(regs);
 }
 
+/*
+ * Hypervisor decrementer interrupts shouldn't occur but are sometimes
+ * left pending on exit from a KVM guest.  We don't need to do anything
+ * to clear them, as they are edge-triggered.
+ */
+void hdec_interrupt(struct pt_regs *regs)
+{
+}
+
 #ifdef CONFIG_SUSPEND
 static void generic_suspend_disable_irqs(void)
 {
-- 
1.7.10.rc3.219.g53414
