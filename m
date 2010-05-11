Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Tue, 11 May 2010 16:28:27 +1000
Subject: [PATCH] powerpc, kexec: Fix race in kexec shutdown
Message-Id: <1273559307.55666.645438163872.qpush@pale>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In kexec_prepare_cpus cpu, the primary CPU IPIs the secondary CPUs to
kexec_smp_down().  kexec_smp_down() calls kexec_smp_wait() which sets
the hw_cpu_id() to -1.  The primary does this while leaving IRQs on
which means the primary can take a timer interrupt which can lead to
the primary IPIing one of the secondary CPUs (say, for a scheduler
re-balance) but since the secondary CPU now has a hw_cpu_id = -1, we
IPI CPU -1... Kaboom!

We are hitting this case regularly on POWER7 machines.  

Also, the secondaries are clearing out any pending IPIs before
guaranteeing that no more will be received.  

This changes kexec_prepare_cpus() so that we turn off IRQs in the
primary CPU much earlier.  It adds a paca flag to say that the
secondaries have entered the kexec_smp_down() IPI and turned off IRQs,
rather than overloading hw_cpu_id with -1.

It also ensures that all CPUs have their IRQs off before we clear out
any pending IPI requests (in kexec_cpu_down()) to ensure there are no
trailing IPIs left unacknowledged.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/paca.h        |    1 +
 arch/powerpc/kernel/machine_kexec_64.c |   28 ++++++++++++++++++++--------
 arch/powerpc/kernel/misc_64.S          |    3 ---
 3 files changed, 21 insertions(+), 11 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/include/asm/paca.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/paca.h
+++ linux-2.6-ozlabs/arch/powerpc/include/asm/paca.h
@@ -82,6 +82,7 @@ struct paca_struct {
 	s16 hw_cpu_id;			/* Physical processor number */
 	u8 cpu_start;			/* At startup, processor spins until */
 					/* this becomes non-zero. */
+	u8 kexec_irqs_off;		/* set when kexec down has irqs off */
 #ifdef CONFIG_PPC_STD_MMU_64
 	struct slb_shadow *slb_shadow_ptr;
 
Index: linux-2.6-ozlabs/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/machine_kexec_64.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/machine_kexec_64.c
@@ -155,16 +155,23 @@ void kexec_copy_flush(struct kimage *ima
 
 #ifdef CONFIG_SMP
 
-/* FIXME: we should schedule this function to be called on all cpus based
- * on calling the interrupts, but we would like to call it off irq level
- * so that the interrupt controller is clean.
- */
+static int kexec_all_irq_disabled = 0;
+
 static void kexec_smp_down(void *arg)
 {
+	local_irq_disable();
+	mb(); /* make sure our irqs are disabled before we say they are */
+	get_paca()->kexec_irqs_off = 1;
+	while(kexec_all_irq_disabled == 0)
+		cpu_relax();
+	mb(); /* make sure all irqs are disabled before this */
+	/*
+	 * Now every CPU has IRQs off, we can clear out any pending
+	 * IPIs and be sure that no more will come in after this.
+	 */
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(0, 1);
 
-	local_irq_disable();
 	kexec_smp_wait();
 	/* NOTREACHED */
 }
@@ -174,14 +181,17 @@ static void kexec_prepare_cpus(void)
 	int my_cpu, i, notified=-1;
 
 	smp_call_function(kexec_smp_down, NULL, /* wait */0);
+	local_irq_disable();
+	mb(); /* make sure IRQs are disabled before we say they are */
+	get_paca()->kexec_irqs_off = 1;
 	my_cpu = get_cpu();
 
-	/* check the others cpus are now down (via paca hw cpu id == -1) */
+	/* check the others cpus are now down (via paca kexec_irqs_off == 1) */
 	for (i=0; i < NR_CPUS; i++) {
 		if (i == my_cpu)
 			continue;
 
-		while (paca[i].hw_cpu_id != -1) {
+		while (paca[i].kexec_irqs_off != 1) {
 			barrier();
 			if (!cpu_possible(i)) {
 				printk("kexec: cpu %d hw_cpu_id %d is not"
@@ -207,6 +217,9 @@ static void kexec_prepare_cpus(void)
 			}
 		}
 	}
+	mb();
+	/* we are sure every CPU has IRQs off at this point */
+	kexec_all_irq_disabled = 1;
 
 	/* after we tell the others to go down */
 	if (ppc_md.kexec_cpu_down)
@@ -214,7 +227,6 @@ static void kexec_prepare_cpus(void)
 
 	put_cpu();
 
-	local_irq_disable();
 }
 
 #else /* ! SMP */
Index: linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/misc_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
@@ -494,14 +494,11 @@ kexec_flag:
  * note: this is a terminal routine, it does not save lr
  *
  * get phys id from paca
- * set paca id to -1 to say we got here
  * switch to real mode
  * join other cpus in kexec_wait(phys_id)
  */
 _GLOBAL(kexec_smp_wait)
 	lhz	r3,PACAHWCPUID(r13)
-	li	r4,-1
-	sth	r4,PACAHWCPUID(r13)	/* let others know we left */
 	bl	real_mode
 	b	.kexec_wait
 
