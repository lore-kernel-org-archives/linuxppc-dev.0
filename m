Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7B42EB71A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 12:43:27 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 17 Jun 2009 12:42:49 +1000
Subject: [PATCH 1/3] powerpc/rtas: Turn rtas lock into a raw spinlock
Message-Id: <20090617024327.600BFDDDA0@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RTAS currently uses a normal spinlock. However it can be called from
contexts where this is not necessarily a good idea. For example, it
can be called while syncing timebases, with the core timebase being
frozen. Unfortunately, that will deadlock in case of lock contention
when spinlock debugging is enabled as the spin lock debugging code
will try to use __delay() which ... relies on the timebase being
enabled.

Also RTAS can be used in some low level IRQ handling code path so it
may as well be a raw spinlock for -rt sake.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/rtas.h |    2 +-
 arch/powerpc/kernel/rtas.c      |   38 +++++++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 10 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/rtas.h	2009-06-10 16:09:36.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/rtas.h	2009-06-10 16:40:50.000000000 +1000
@@ -58,7 +58,7 @@ struct rtas_t {
 	unsigned long entry;		/* physical address pointer */
 	unsigned long base;		/* physical address pointer */
 	unsigned long size;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct rtas_args args;
 	struct device_node *dev;	/* virtual address pointer */
 };
Index: linux-work/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/rtas.c	2009-06-10 16:09:36.000000000 +1000
+++ linux-work/arch/powerpc/kernel/rtas.c	2009-06-10 16:40:50.000000000 +1000
@@ -40,7 +40,7 @@
 #include <asm/atomic.h>
 
 struct rtas_t rtas = {
-	.lock = SPIN_LOCK_UNLOCKED
+	.lock = __RAW_SPIN_LOCK_UNLOCKED
 };
 EXPORT_SYMBOL(rtas);
 
@@ -67,6 +67,28 @@ unsigned long rtas_rmo_buf;
 void (*rtas_flash_term_hook)(int);
 EXPORT_SYMBOL(rtas_flash_term_hook);
 
+/* RTAS use home made raw locking instead of spin_lock_irqsave
+ * because those can be called from within really nasty contexts
+ * such as having the timebase stopped which would lockup with
+ * normal locks and spinlock debugging enabled
+ */
+static unsigned long lock_rtas(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	__raw_spin_lock_flags(&rtas.lock, flags);
+	return flags;
+}
+
+static void unlock_rtas(unsigned long flags)
+{
+	__raw_spin_unlock(&rtas.lock);
+	local_irq_restore(flags);
+	preempt_enable();
+}
+
 /*
  * call_rtas_display_status and call_rtas_display_status_delay
  * are designed only for very early low-level debugging, which
@@ -79,7 +101,7 @@ static void call_rtas_display_status(cha
 
 	if (!rtas.base)
 		return;
-	spin_lock_irqsave(&rtas.lock, s);
+	s = lock_rtas();
 
 	args->token = 10;
 	args->nargs = 1;
@@ -89,7 +111,7 @@ static void call_rtas_display_status(cha
 
 	enter_rtas(__pa(args));
 
-	spin_unlock_irqrestore(&rtas.lock, s);
+	unlock_rtas(s);
 }
 
 static void call_rtas_display_status_delay(char c)
@@ -411,8 +433,7 @@ int rtas_call(int token, int nargs, int 
 	if (!rtas.entry || token == RTAS_UNKNOWN_SERVICE)
 		return -1;
 
-	/* Gotta do something different here, use global lock for now... */
-	spin_lock_irqsave(&rtas.lock, s);
+	s = lock_rtas();
 	rtas_args = &rtas.args;
 
 	rtas_args->token = token;
@@ -439,8 +460,7 @@ int rtas_call(int token, int nargs, int 
 			outputs[i] = rtas_args->rets[i+1];
 	ret = (nret > 0)? rtas_args->rets[0]: 0;
 
-	/* Gotta do something different here, use global lock for now... */
-	spin_unlock_irqrestore(&rtas.lock, s);
+	unlock_rtas(s);
 
 	if (buff_copy) {
 		log_error(buff_copy, ERR_TYPE_RTAS_LOG, 0);
@@ -837,7 +857,7 @@ asmlinkage int ppc_rtas(struct rtas_args
 
 	buff_copy = get_errorlog_buffer();
 
-	spin_lock_irqsave(&rtas.lock, flags);
+	flags = lock_rtas();
 
 	rtas.args = args;
 	enter_rtas(__pa(&rtas.args));
@@ -848,7 +868,7 @@ asmlinkage int ppc_rtas(struct rtas_args
 	if (args.rets[0] == -1)
 		errbuf = __fetch_rtas_last_error(buff_copy);
 
-	spin_unlock_irqrestore(&rtas.lock, flags);
+	unlock_rtas(flags);
 
 	if (buff_copy) {
 		if (errbuf)
