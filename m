Return-Path: <peterz@infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [134.117.69.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70328B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Jan 2011 22:07:24 +1100 (EST)
Subject: [PATCH] sched: provide scheduler_ipi() callback in response to
	smp_send_reschedule()
From: Peter Zijlstra <peterz@infradead.org>
To: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky
	<ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King
	<linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Mikael
	Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony
	Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu
	Takata <takata@linux-m32r.org>, Ralf Baechle <ralf@linux-mips.org>, David
	Howells <dhowells@redhat.com>, Koichi Yasutake
	<yasutake.koichi@jp.panasonic.com>, Kyle McMartin <kyle@mcmartin.ca>,
	Helge Deller <deller@gmx.de>, "James E.J. Bottomley"
	<jejb@parisc-linux.org>,  Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin
	Schwidefsky <schwidefsky@de.ibm.com>,  Heiko Carstens
	<heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt
	<lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Chris
	Metcalf <cmetcalf@tilera.com>, Jeff Dike <jdike@addtoit.com>,  Thomas
	Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter
	Anvin" <hpa@zytor.com>,  x86@kernel.org, Jeremy Fitzhardinge
	<jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
	uclinux-dist-devel@blackfin.uclinux.org,  linux-cris-kernel@axis.com,
	linux-ia64@vger.kernel.org,  linux-m32r@ml.linux-m32r.org,
	linux-m32r-ja@ml.linux-m32r.org,  linux-mips@linux-mips.org,
	linux-am33-list@redhat.com,  linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,  linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net,
	user-mode-linux-user@lists.sourceforge.net, xen-devel@lists.xensource.com,
	virtualization@lists.osdl.org, Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 Jan 2011 12:07:13 +0100
Message-ID: <1295262433.30950.53.camel@laptop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For future rework of try_to_wake_up() we'd like to push part of that
onto the CPU the task is actually going to run on, in order to do so we
need a generic callback from the existing scheduler IPI.

This patch introduces such a generic callback: scheduler_ipi() and
implements it as a NOP.

I visited existing smp_send_reschedule() implementations and tried to
add a call to scheduler_ipi() in their handler part, but esp. for MIPS
I'm not quite sure I actually got all of them.

Also, while reading through all this, I noticed the blackfin SMP code
looks to be broken, it simply discards any IPI when low on memory.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/alpha/kernel/smp.c         |    1 +
 arch/arm/kernel/smp.c           |    1 +
 arch/blackfin/mach-common/smp.c |    3 ++-
 arch/cris/arch-v32/kernel/smp.c |   13 ++++++++-----
 arch/ia64/kernel/irq_ia64.c     |    2 ++
 arch/ia64/xen/irq_xen.c         |   10 +++++++++-
 arch/m32r/kernel/smp.c          |    2 +-
 arch/mips/kernel/smtc.c         |    1 +
 arch/mips/sibyte/bcm1480/smp.c  |    7 +++----
 arch/mips/sibyte/sb1250/smp.c   |    7 +++----
 arch/mn10300/kernel/smp.c       |    2 +-
 arch/parisc/kernel/smp.c        |    1 +
 arch/powerpc/kernel/smp.c       |    1 +
 arch/s390/kernel/smp.c          |    6 +++---
 arch/sh/kernel/smp.c            |    2 ++
 arch/sparc/kernel/smp_32.c      |    2 +-
 arch/sparc/kernel/smp_64.c      |    1 +
 arch/tile/kernel/smp.c          |    1 +
 arch/um/kernel/smp.c            |    2 +-
 arch/x86/kernel/smp.c           |    1 +
 arch/x86/xen/smp.c              |    1 +
 include/linux/sched.h           |    1 +
 22 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 42aa078..c4a570b 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -587,6 +587,7 @@ handle_ipi(struct pt_regs *regs)
 		case IPI_RESCHEDULE:
 			/* Reschedule callback.  Everything to be done
 			   is done by the interrupt return path.  */
+			scheduler_ipi();
 			break;
=20
 		case IPI_CALL_FUNC:
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 9066473..ffde790 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -579,6 +579,7 @@ asmlinkage void __exception do_IPI(struct pt_regs *regs=
)
 				 * nothing more to do - eveything is
 				 * done on the interrupt return path
 				 */
+				scheduler_ipi();
 				break;
=20
 			case IPI_CALL_FUNC:
diff --git a/arch/blackfin/mach-common/smp.c b/arch/blackfin/mach-common/sm=
p.c
index a17107a..e210f8a 100644
--- a/arch/blackfin/mach-common/smp.c
+++ b/arch/blackfin/mach-common/smp.c
@@ -156,6 +156,7 @@ static irqreturn_t ipi_handler(int irq, void *dev_insta=
nce)
 		case BFIN_IPI_RESCHEDULE:
 			/* That's the easiest one; leave it to
 			 * return_from_int. */
+			scheduler_ipi();
 			kfree(msg);
 			break;
 		case BFIN_IPI_CALL_FUNC:
@@ -301,7 +302,7 @@ void smp_send_reschedule(int cpu)
=20
 	msg =3D kzalloc(sizeof(*msg), GFP_ATOMIC);
 	if (!msg)
-		return;
+		return; /* XXX unreliable needs fixing ! */
 	INIT_LIST_HEAD(&msg->list);
 	msg->type =3D BFIN_IPI_RESCHEDULE;
=20
diff --git a/arch/cris/arch-v32/kernel/smp.c b/arch/cris/arch-v32/kernel/sm=
p.c
index 84fed3b..86e3c76 100644
--- a/arch/cris/arch-v32/kernel/smp.c
+++ b/arch/cris/arch-v32/kernel/smp.c
@@ -340,15 +340,18 @@ irqreturn_t crisv32_ipi_interrupt(int irq, void *dev_=
id)
=20
 	ipi =3D REG_RD(intr_vect, irq_regs[smp_processor_id()], rw_ipi);
=20
+	if (ipi.vector & IPI_SCHEDULE) {
+		scheduler_ipi();
+	}
 	if (ipi.vector & IPI_CALL) {
-	         func(info);
+		func(info);
 	}
 	if (ipi.vector & IPI_FLUSH_TLB) {
-		     if (flush_mm =3D=3D FLUSH_ALL)
-			 __flush_tlb_all();
-		     else if (flush_vma =3D=3D FLUSH_ALL)
+		if (flush_mm =3D=3D FLUSH_ALL)
+			__flush_tlb_all();
+		else if (flush_vma =3D=3D FLUSH_ALL)
 			__flush_tlb_mm(flush_mm);
-		     else
+		else
 			__flush_tlb_page(flush_vma, flush_addr);
 	}
=20
diff --git a/arch/ia64/kernel/irq_ia64.c b/arch/ia64/kernel/irq_ia64.c
index 9a26015..a580230 100644
--- a/arch/ia64/kernel/irq_ia64.c
+++ b/arch/ia64/kernel/irq_ia64.c
@@ -31,6 +31,7 @@
 #include <linux/irq.h>
 #include <linux/ratelimit.h>
 #include <linux/acpi.h>
+#include <linux/sched.h>
=20
 #include <asm/delay.h>
 #include <asm/intrinsics.h>
@@ -496,6 +497,7 @@ ia64_handle_irq (ia64_vector vector, struct pt_regs *re=
gs)
 			smp_local_flush_tlb();
 			kstat_incr_irqs_this_cpu(irq, desc);
 		} else if (unlikely(IS_RESCHEDULE(vector))) {
+			scheduler_ipi();
 			kstat_incr_irqs_this_cpu(irq, desc);
 		} else {
 			ia64_setreg(_IA64_REG_CR_TPR, vector);
diff --git a/arch/ia64/xen/irq_xen.c b/arch/ia64/xen/irq_xen.c
index a3fb7cf..2f235a3 100644
--- a/arch/ia64/xen/irq_xen.c
+++ b/arch/ia64/xen/irq_xen.c
@@ -92,6 +92,8 @@ static unsigned short saved_irq_cnt;
 static int xen_slab_ready;
=20
 #ifdef CONFIG_SMP
+#include <linux/sched.h>
+
 /* Dummy stub. Though we may check XEN_RESCHEDULE_VECTOR before __do_IRQ,
  * it ends up to issue several memory accesses upon percpu data and
  * thus adds unnecessary traffic to other paths.
@@ -99,7 +101,13 @@ static int xen_slab_ready;
 static irqreturn_t
 xen_dummy_handler(int irq, void *dev_id)
 {
+	return IRQ_HANDLED;
+}
=20
+static irqreturn_t
+xen_resched_handler(int irq, void *dev_id)
+{
+	scheduler_ipi();
 	return IRQ_HANDLED;
 }
=20
@@ -110,7 +118,7 @@ static struct irqaction xen_ipi_irqaction =3D {
 };
=20
 static struct irqaction xen_resched_irqaction =3D {
-	.handler =3D	xen_dummy_handler,
+	.handler =3D	xen_resched_handler,
 	.flags =3D	IRQF_DISABLED,
 	.name =3D		"resched"
 };
diff --git a/arch/m32r/kernel/smp.c b/arch/m32r/kernel/smp.c
index 31cef20..f0ecc3f 100644
--- a/arch/m32r/kernel/smp.c
+++ b/arch/m32r/kernel/smp.c
@@ -138,7 +138,7 @@ void smp_send_reschedule(int cpu_id)
  *=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
*/
 void smp_reschedule_interrupt(void)
 {
-	/* nothing to do */
+	scheduler_ipi();
 }
=20
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
*
diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 39c0825..0443e91 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -931,6 +931,7 @@ static void post_direct_ipi(int cpu, struct smtc_ipi *p=
ipi)
 static void ipi_resched_interrupt(void)
 {
 	/* Return from interrupt should be enough to cause scheduler check */
+	scheduler_ipi();
 }
=20
 static void ipi_call_interrupt(void)
diff --git a/arch/mips/sibyte/bcm1480/smp.c b/arch/mips/sibyte/bcm1480/smp.=
c
index 47b347c..513a301 100644
--- a/arch/mips/sibyte/bcm1480/smp.c
+++ b/arch/mips/sibyte/bcm1480/smp.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/smp.h>
 #include <linux/kernel_stat.h>
+#include <linux/sched.h>
=20
 #include <asm/mmu_context.h>
 #include <asm/io.h>
@@ -189,10 +190,8 @@ void bcm1480_mailbox_interrupt(void)
 	/* Clear the mailbox to clear the interrupt */
 	__raw_writeq(((u64)action)<<48, mailbox_0_clear_regs[cpu]);
=20
-	/*
-	 * Nothing to do for SMP_RESCHEDULE_YOURSELF; returning from the
-	 * interrupt will do the reschedule for us
-	 */
+	if (actione & SMP_RESCHEDULE_YOURSELF)
+		scheduler_ipi();
=20
 	if (action & SMP_CALL_FUNCTION)
 		smp_call_function_interrupt();
diff --git a/arch/mips/sibyte/sb1250/smp.c b/arch/mips/sibyte/sb1250/smp.c
index c00a5cb..38e7f6b 100644
--- a/arch/mips/sibyte/sb1250/smp.c
+++ b/arch/mips/sibyte/sb1250/smp.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/kernel_stat.h>
+#include <linux/sched.h>
=20
 #include <asm/mmu_context.h>
 #include <asm/io.h>
@@ -177,10 +178,8 @@ void sb1250_mailbox_interrupt(void)
 	/* Clear the mailbox to clear the interrupt */
 	____raw_writeq(((u64)action) << 48, mailbox_clear_regs[cpu]);
=20
-	/*
-	 * Nothing to do for SMP_RESCHEDULE_YOURSELF; returning from the
-	 * interrupt will do the reschedule for us
-	 */
+	if (action & SMP_RESCHEDULE_YOURSELF)
+		scheduler_ipi();
=20
 	if (action & SMP_CALL_FUNCTION)
 		smp_call_function_interrupt();
diff --git a/arch/mn10300/kernel/smp.c b/arch/mn10300/kernel/smp.c
index 0dcd1c6..17f16ca 100644
--- a/arch/mn10300/kernel/smp.c
+++ b/arch/mn10300/kernel/smp.c
@@ -471,7 +471,7 @@ void smp_send_stop(void)
  */
 static irqreturn_t smp_reschedule_interrupt(int irq, void *dev_id)
 {
-	/* do nothing */
+	scheduler_ipi();
 	return IRQ_HANDLED;
 }
=20
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 69d63d3..f8f7970 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -155,6 +155,7 @@ ipi_interrupt(int irq, void *dev_id)
 			=09
 			case IPI_RESCHEDULE:
 				smp_debug(100, KERN_DEBUG "CPU%d IPI_RESCHEDULE\n", this_cpu);
+				scheduler_ipi();
 				/*
 				 * Reschedule callback.  Everything to be
 				 * done is done by the interrupt return path.
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 68034bb..7ee0fc3 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -128,6 +128,7 @@ static irqreturn_t call_function_action(int irq, void *=
data)
 static irqreturn_t reschedule_action(int irq, void *data)
 {
 	/* we just need the return path side effect of checking need_resched */
+	scheduler_ipi();
 	return IRQ_HANDLED;
 }
=20
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 94cf510..61789e8 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -163,12 +163,12 @@ static void do_ext_call_interrupt(unsigned int ext_in=
t_code,
=20
 	/*
 	 * handle bit signal external calls
-	 *
-	 * For the ec_schedule signal we have to do nothing. All the work
-	 * is done automatically when we return from the interrupt.
 	 */
 	bits =3D xchg(&S390_lowcore.ext_call_fast, 0);
=20
+	if (test_bit(ec_schedule, &bits))
+		scheduler_ipi();
+
 	if (test_bit(ec_call_function, &bits))
 		generic_smp_call_function_interrupt();
=20
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 509b36b..6207561 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
+#include <linux/sched.h>
 #include <asm/atomic.h>
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -323,6 +324,7 @@ void smp_message_recv(unsigned int msg)
 		generic_smp_call_function_interrupt();
 		break;
 	case SMP_MSG_RESCHEDULE:
+		scheduler_ipi();
 		break;
 	case SMP_MSG_FUNCTION_SINGLE:
 		generic_smp_call_function_single_interrupt();
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 91c10fb..042d8c9 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -125,7 +125,7 @@ struct linux_prom_registers smp_penguin_ctable __cpuini=
tdata =3D { 0 };
=20
 void smp_send_reschedule(int cpu)
 {
-	/* See sparc64 */
+	scheduler_ipi();
 }
=20
 void smp_send_stop(void)
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index b6a2b8f..68e26e2 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1369,6 +1369,7 @@ void smp_send_reschedule(int cpu)
 void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs)
 {
 	clear_softint(1 << irq);
+	scheduler_ipi();
 }
=20
 /* This is a nop because we capture all other cpus
diff --git a/arch/tile/kernel/smp.c b/arch/tile/kernel/smp.c
index 9575b37..91a1ddf 100644
--- a/arch/tile/kernel/smp.c
+++ b/arch/tile/kernel/smp.c
@@ -190,6 +190,7 @@ static irqreturn_t handle_reschedule_ipi(int irq, void =
*token)
 	 * profiler count in the meantime.
 	 */
 	__get_cpu_var(irq_stat).irq_resched_count++;
+	scheduler_ipi();
=20
 	return IRQ_HANDLED;
 }
diff --git a/arch/um/kernel/smp.c b/arch/um/kernel/smp.c
index 106bf27..eefb107 100644
--- a/arch/um/kernel/smp.c
+++ b/arch/um/kernel/smp.c
@@ -173,7 +173,7 @@ void IPI_handler(int cpu)
 			break;
=20
 		case 'R':
-			set_tsk_need_resched(current);
+			scheduler_ipi();
 			break;
=20
 		case 'S':
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 513deac..e38c2d8 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -202,6 +202,7 @@ void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
 	inc_irq_stat(irq_resched_count);
+	scheduler_ipi();
 	/*
 	 * KVM uses this interrupt to force a cpu out of guest mode
 	 */
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 72a4c79..6196fb1 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -53,6 +53,7 @@ static irqreturn_t xen_call_function_single_interrupt(int=
 irq, void *dev_id);
 static irqreturn_t xen_reschedule_interrupt(int irq, void *dev_id)
 {
 	inc_irq_stat(irq_resched_count);
+	scheduler_ipi();
=20
 	return IRQ_HANDLED;
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 341acbb..aa458dc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2183,6 +2183,7 @@ extern void set_task_comm(struct task_struct *tsk, ch=
ar *from);
 extern char *get_task_comm(char *to, struct task_struct *tsk);
=20
 #ifdef CONFIG_SMP
+static inline void scheduler_ipi(void) { }
 extern unsigned long wait_task_inactive(struct task_struct *, long match_s=
tate);
 #else
 static inline unsigned long wait_task_inactive(struct task_struct *p,
