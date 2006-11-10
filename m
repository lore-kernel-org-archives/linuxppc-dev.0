Return-Path: <hugh_dickins@symantec.com>
Received: from extu-mxob-1.symantec.com (extu-mxob-1.symantec.com
	[216.10.194.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD34167EA5
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 08:32:28 +1100 (EST)
Date: Fri, 10 Nov 2006 21:32:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] ppc64: make soft_enabled irqs preempt safe
In-Reply-To: <17748.17364.884083.164844@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0611102102190.376@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
	<Pine.LNX.4.64.0610311841570.26470@blonde.wat.veritas.com>
	<17748.17364.884083.164844@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 10 Nov 2006, Paul Mackerras wrote:
> Hugh Dickins writes:
> 
> > local_irq_restore be careful to access hard_enabled and lppaca before
> > setting soft_enabled, which may well permit preemption.  Use local_paca
> 
> The reason for testing hard_enabled *after* setting soft_enabled is to
> avoid a race.  If we load hard_enabled first, as your patch does, then
> an interrupt could come in between that load and the store that sets
> soft_enabled, and we would miss that and not hard-enable as we should.

Ah, yes, of course.

> 
> I'm not sure what the solution is.  I suppose we could disable
> preemption, although I'd rather something lighter-weight if possible.

On reflection, considering what can actually happen in those cases
where local_irq_restore might get preempted - what happens when it
gets it wrong - it now looks to me like disabling preemption there
would be overkill: we just need to make sure that we're looking at
our own cpu in a couple of places i.e. stop gcc from doing one of
those "mr r5,r13" kind of things.  (If hard_enabled is actually 0,
we won't be preempted anyway; if it's 1, then all we have to do is
make sure we're looking at ours rather than someone else's 0.)

That's assuming iseries_handle_interrupts does no harm if called
without an interrupt pending, I hope that's the case (otherwise,
maybe that block would need preempt_disable/preempt_enable, since
get_lppaca() references are inevitably non-atomic, never mind the
gcc oddity - though I'm sure you'd work out how to avoid it later).

I must emphasize again that my asm is likely to be nonsense: seems
to work, but as likely to be introducing its own bugs as fixing
the preemption issue: please hack it right, thanks!



Rewrite local_get_flags and local_irq_disable to use r13 explicitly,
to avoid the risk that gcc will split get_paca()->soft_enabled into a
sequence unsafe against preemption.  Similar care in local_irq_restore.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/powerpc/kernel/irq.c    |   57 +++++++++++++++++++++++++++++++++++++++----
 include/asm-powerpc/hw_irq.h |   20 +++++++++++----
 2 files changed, 67 insertions(+), 10 deletions(-)

--- 2.6.19-rc5-mm1/arch/powerpc/kernel/irq.c	2006-11-08 12:39:06.000000000 +0000
+++ linux/arch/powerpc/kernel/irq.c	2006-11-10 20:12:10.000000000 +0000
@@ -97,22 +97,69 @@ EXPORT_SYMBOL(irq_desc);
 
 int distribute_irqs = 1;
 
+static inline unsigned long get_hard_enabled(void)
+{
+	unsigned long enabled;
+
+	__asm__ __volatile__("lbz %0,%1(13)"
+	: "=r" (enabled) : "i" (offsetof(struct paca_struct, hard_enabled)));
+
+	return enabled;
+}
+
+static inline void set_soft_enabled(unsigned long enable)
+{
+	__asm__ __volatile__("stb %0,%1(13)"
+	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
+}
+
 void local_irq_restore(unsigned long en)
 {
-	get_paca()->soft_enabled = en;
+	/*
+	 * get_paca()->soft_enabled = en;
+	 * Is it ever valid to use local_irq_restore(0) when soft_enabled is 1?
+	 * That was allowed before, and in such a case we do need to take care
+	 * that gcc will set soft_enabled directly via r13, not choose to use
+	 * an intermediate register, lest we're preempted to a different cpu.
+	 */
+	set_soft_enabled(en);
 	if (!en)
 		return;
 
 	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		if (get_paca()->lppaca_ptr->int_dword.any_int)
+		/*
+		 * Do we need to disable preemption here?  Not really: in the
+		 * unlikely event that we're preempted to a different cpu in
+		 * between getting r13, loading its lppaca_ptr, and loading
+		 * its any_int, we might call iseries_handle_interrupts without
+		 * an interrupt pending on the new cpu, but that's no disaster,
+		 * is it?  And the business of preempting us off the old cpu
+		 * would itself involve a local_irq_restore which handles the
+		 * interrupt to that cpu.
+		 *
+		 * But use "local_paca->lppaca_ptr" instead of "get_lppaca()"
+		 * to avoid any preemption checking added into get_paca().
+		 */
+		if (local_paca->lppaca_ptr->int_dword.any_int)
 			iseries_handle_interrupts();
 		return;
 	}
 
-	if (get_paca()->hard_enabled)
+	/*
+	 * if (get_paca()->hard_enabled) return;
+	 * But again we need to take care that gcc gets hard_enabled directly
+	 * via r13, not choose to use an intermediate register, lest we're
+	 * preempted to a different cpu in between the two instructions.
+	 */
+	if (get_hard_enabled())
 		return;
-	/* need to hard-enable interrupts here */
-	get_paca()->hard_enabled = en;
+
+	/*
+	 * Need to hard-enable interrupts here.  Since currently disabled,
+	 * no need to take further asm precautions against preemption; but
+	 * use local_paca instead of get_paca() to avoid preemption checking.
+	 */
+	local_paca->hard_enabled = en;
 	if ((int)mfspr(SPRN_DEC) < 0)
 		mtspr(SPRN_DEC, 1);
 	hard_irq_enable();
--- 2.6.19-rc5-mm1/include/asm-powerpc/hw_irq.h	2006-11-08 12:39:15.000000000 +0000
+++ linux/include/asm-powerpc/hw_irq.h	2006-11-10 13:21:39.000000000 +0000
@@ -18,15 +18,25 @@ extern void timer_interrupt(struct pt_re
 
 static inline unsigned long local_get_flags(void)
 {
-	return get_paca()->soft_enabled;
+	unsigned long flags;
+
+	__asm__ __volatile__("lbz %0,%1(13)"
+	: "=r" (flags)
+	: "i" (offsetof(struct paca_struct, soft_enabled)));
+
+	return flags;
 }
 
 static inline unsigned long local_irq_disable(void)
 {
-	unsigned long flag = get_paca()->soft_enabled;
-	get_paca()->soft_enabled = 0;
-	barrier();
-	return flag;
+	unsigned long flags, zero;
+
+	__asm__ __volatile__("li %1,0; lbz %0,%2(13); stb %1,%2(13)"
+	: "=r" (flags), "=&r" (zero)
+	: "i" (offsetof(struct paca_struct, soft_enabled))
+	: "memory");
+
+	return flags;
 }
 
 extern void local_irq_restore(unsigned long);
