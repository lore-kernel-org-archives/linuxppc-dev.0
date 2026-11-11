Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8405606AE1E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0izC1Zvx;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=CbY69Pkd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPsHq6Kkdz2yqx;
	Thu, 12 Nov 2026 05:19:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794421191;
	cv=none; b=gT5edWraGeeu+JlXV7JRE/jGb+iF3YU9q1X9Z/91UdFo2vWiLjPOVeg6h6h/pmR7pcYNbOBzWVPHKhmKwStbwRx3eJhBVrxuRnagQP4YblBA6RwkloMNI8d5jcvd8TmsR5UL3wZ8fZHAaKKarGWbCFkTULOdEVT80Fv+5Y3biK2FbuXj9oRSnOp6XU1Zwg0FV0PdSwj6hRabSB3SlV6NR6EW4lBgbmNm2DIieOltWTlcAlLUU/Jxq6+fAUzrNOiXwqeOQF+UYogzJ96N3X7BBljLlBmHWn17y8GA6R/unRLBumxZ4XNtog1hrNqDQ98ezGDLRz0BR29S8zSr2xEo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794421191; c=relaxed/relaxed;
	bh=f3Wcjc9BIe85EqNvN9SeVwKoNluy9XRggUuK2flMK5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3pW0TE1LGQvkX5qLeWn4QaBL+6WaUh57hhO+1s9/p3U4+YeKlBJLSUWWkmLb87wbVcLfGvFx96iORA8fWjco2i/Ln9xtxSB/1C2Hp113kapgq2TzOIpPApVGEWjGi9zMVpiFI9tLaVG6y6llAQXUJaPfUjkZV8GXinyOAoFmReaqZP8Ezq49EJnphvOYiabcWvKfAVFv3eHvdcDwXZP2NvJpvb86HMOS3Uu4dem109t4QQzAZSukISKZ22/A3HPmmahw4sgyYU8yJmtC8HhLaFZAz1PCSaG0mUg5FKzEuBmZA3XNqNEpY0C2Jl+LnIXFRgYcOjLcswyYE+1qY+Drw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0izC1Zvx; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=CbY69Pkd; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0izC1Zvx;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=CbY69Pkd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPsHn5c3Vz2ylm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 05:19:49 +1100 (AEDT)
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794421184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3Wcjc9BIe85EqNvN9SeVwKoNluy9XRggUuK2flMK5g=;
	b=0izC1ZvxadR7rAbLUF3PFUMa5LNhy0SfNg5+dRtjJnOYvgORyaQYFwE4gXMPj2NhZyWkW+
	OMunzir+W+4sPzxuq2eckKDFTm8XOhkTceilmSZYd7gb93tuj3UolqXvVT8FSe2JVQCR3w
	bW+46ZC88yDWLUyOhokFGO9uGdpF4VWKXrpUT9DPbFNKq6k7OYJIa+UzlPulqNXvL2OKoN
	8I0BLrwz1eGHxCvAZGf3mE6JoOVb0w2fqlwMINCuZlI7WhWNazL3l9uZgxfT2pO8KrE9SX
	aSh7ZljDSx8bXkri6+2uh4WYdFIKo8BI6iV36LqPAMHC5l7YJmmw2SGLvgLyGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794421184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3Wcjc9BIe85EqNvN9SeVwKoNluy9XRggUuK2flMK5g=;
	b=CbY69Pkdm4v6sGZAeZvqa7iXHFidLubVz+LqDj8cAlSqsXZSxTYTB4tdi5OqFrqFNdKp3I
	GvojDLs1YvYkogCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>,
	printk@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Gal Pressman <gal@nvidia.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH printk v2 1/6] printk: Introduce and specify flush reasons
Date: Wed, 11 Nov 2026 19:25:17 +0106
Message-ID: <20261111181942.593695-2-john.ogness@linutronix.de>
In-Reply-To: <20261111181942.593695-1-john.ogness@linutronix.de>
References: <20261111181942.593695-1-john.ogness@linutronix.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prepare for per-console atomic flushing policies by introducing
enum pr_flush_reason to classify various reasons for performing a
printk backlog flush. The reasons are specified for
printk_trigger_flush() and console_flush_on_panic().

For atomic printing from printk_trigger_flush(), propagate the
reason down to __nbcon_atomic_flush_pending_con(), where the actual
atomic flushing is executed.

For legacy printing, use a new global variable @legacy_flush_reason
to track the reason in case nbcon consoles are using legacy
printing.

Update all printk_trigger_flush() and console_flush_on_panic()
call sites as well as any explicit lower-level atomic flush calls
to specify the reason.

Note that PR_FLUSH_RUNTIME is used for cases where the reason for
the flush is not clearly defined.

No functional change.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/loongarch/kernel/reset.c  |  2 +-
 arch/powerpc/kernel/traps.c    |  2 +-
 arch/powerpc/kernel/watchdog.c |  2 +-
 include/linux/console.h        |  2 +-
 include/linux/printk.h         | 22 ++++++++++++++++++--
 kernel/debug/debug_core.c      |  2 +-
 kernel/panic.c                 |  6 +++---
 kernel/printk/internal.h       |  5 +++--
 kernel/printk/nbcon.c          | 28 ++++++++++++++++---------
 kernel/printk/printk.c         | 38 ++++++++++++++++++++++++----------
 kernel/reboot.c                |  2 +-
 lib/nmi_backtrace.c            |  2 +-
 12 files changed, 78 insertions(+), 35 deletions(-)

diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
index de8fa5a8a825c..3dfc4a6216cee 100644
--- a/arch/loongarch/kernel/reset.c
+++ b/arch/loongarch/kernel/reset.c
@@ -30,7 +30,7 @@ void machine_halt(void)
 	clear_csr_ecfg(ECFG0_IM);
 
 	pr_notice("\n\n** You can safely turn off the power now **\n\n");
-	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING, PR_FLUSH_HANG);
 
 	while (true) {
 		__asm__ __volatile__("idle 0" : : : "memory");
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 3a8f5416e3f6e..fb7373954c9ca 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -175,7 +175,7 @@ void panic_flush_kmsg_end(void)
 	kmsg_dump(KMSG_DUMP_PANIC);
 	bust_spinlocks(0);
 	debug_locks_off();
-	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING, PR_FLUSH_RUNTIME);
 }
 
 static unsigned long oops_begin(struct pt_regs *regs)
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 582ee3fd71c1b..3d4f9dcb82866 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -365,7 +365,7 @@ static void watchdog_timer_interrupt(int cpu)
 		 *
 		 * See wd_lockup_ipi.
 		 */
-		printk_trigger_flush();
+		printk_trigger_flush(PR_FLUSH_RUNTIME);
 	}
 }
 
diff --git a/include/linux/console.h b/include/linux/console.h
index df23148987eeb..06d01f1743512 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -713,7 +713,7 @@ extern void console_lock(void);
 extern int console_trylock(void);
 extern void console_unlock(void);
 extern void console_unblank(void);
-extern void console_flush_on_panic(enum con_flush_mode mode);
+extern void console_flush_on_panic(enum con_flush_mode mode, enum pr_flush_reason reason);
 extern struct tty_driver *console_device(int *);
 extern void console_suspend(struct console *);
 extern void console_resume(struct console *);
diff --git a/include/linux/printk.h b/include/linux/printk.h
index f594c1266bfd4..711bd280d1c2f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -145,6 +145,24 @@ void early_printk(const char *s, ...) { }
 
 struct dev_printk_info;
 
+/**
+ * enum pr_flush_reason - Reason for a flush
+ * @PR_FLUSH_RUNTIME:	A flush while the kernel is running
+ * @PR_FLUSH_RESTART:	The kernel is ending, but another instance should
+ *			follow (reboot, kexec)
+ * @PR_FLUSH_HANG:	The kernel is ending and will enter an infinite loop
+ * @PR_FLUSH_KDB:	Printing while KDB is active
+ *
+ * Flush reasons are used to determine if unsafe atomic flushing should be
+ * performed, based on individual console policies.
+ */
+enum pr_flush_reason {
+	PR_FLUSH_RUNTIME = 0,
+	PR_FLUSH_RESTART,
+	PR_FLUSH_HANG,
+	PR_FLUSH_KDB,
+};
+
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(4, 0)
 int vprintk_emit(int facility, int level,
@@ -202,7 +220,7 @@ void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
-void printk_trigger_flush(void);
+void printk_trigger_flush(enum pr_flush_reason reason);
 void console_try_replay_all(void);
 void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
@@ -298,7 +316,7 @@ static inline void dump_stack_lvl(const char *log_lvl)
 static inline void dump_stack(void)
 {
 }
-static inline void printk_trigger_flush(void)
+static inline void printk_trigger_flush(enum pr_flush_reason reason)
 {
 }
 static inline void console_try_replay_all(void)
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index b276504c1c6bd..fed8a5b38eaa1 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -999,7 +999,7 @@ void kgdb_panic(const char *msg)
 		return;
 
 	debug_locks_off();
-	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING, PR_FLUSH_RUNTIME);
 
 	if (dbg_kdb_mode)
 		kdb_printf("PANIC: %s\n", msg);
diff --git a/kernel/panic.c b/kernel/panic.c
index a4dbb6b8cd2bf..32286365d4fee 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -707,11 +707,11 @@ void vpanic(const char *fmt, va_list args)
 	 * panic() is not being callled from OOPS.
 	 */
 	debug_locks_off();
-	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING, PR_FLUSH_RUNTIME);
 
 	if ((panic_print & SYS_INFO_PANIC_CONSOLE_REPLAY) ||
 		panic_console_replay)
-		console_flush_on_panic(CONSOLE_REPLAY_ALL);
+		console_flush_on_panic(CONSOLE_REPLAY_ALL, PR_FLUSH_RUNTIME);
 
 	if (!panic_blink)
 		panic_blink = no_blink;
@@ -764,7 +764,7 @@ void vpanic(const char *fmt, va_list args)
 	 * defers printing (such as NMI) and irq_work is not available.
 	 * Explicitly flush the kernel log buffer one last time.
 	 */
-	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING, PR_FLUSH_HANG);
 	nbcon_atomic_flush_unsafe();
 
 	local_irq_enable();
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 85fbf1801cbe0..32f83658ffc5b 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -104,7 +104,7 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
-void nbcon_atomic_flush_pending(void);
+void nbcon_atomic_flush_pending(enum pr_flush_reason reason);
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 				   int cookie, bool use_atomic);
 bool nbcon_kthread_create(struct console *con);
@@ -156,7 +156,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
-static inline void nbcon_atomic_flush_pending(void) { }
+static inline void nbcon_atomic_flush_pending(enum pr_flush_reason reason) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 						 int cookie, bool use_atomic) { return false; }
 static inline void nbcon_kthread_wake(struct console *con) { }
@@ -168,6 +168,7 @@ extern bool have_boot_console;
 extern bool have_nbcon_console;
 extern bool have_legacy_console;
 extern bool legacy_allow_panic_sync;
+extern enum pr_flush_reason legacy_flush_reason;
 
 /**
  * struct console_flush_type - Define available console flush methods
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 5f8afaca88665..935fd6b86bac7 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1542,6 +1542,7 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  * __nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
  *					write_atomic() callback
  * @con:			The nbcon console to flush
+ * @reason:			The reason for the flush
  * @stop_seq:			Flush up until this record
  *
  * Return:	0 if @con was flushed up to @stop_seq Otherwise, error code on
@@ -1561,7 +1562,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  * returned, it cannot be expected that the unfinalized record will become
  * available.
  */
-static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+static int __nbcon_atomic_flush_pending_con(struct console *con, enum pr_flush_reason reason,
+					    u64 stop_seq)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
@@ -1610,6 +1612,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
  * nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
  *					write_atomic() callback
  * @con:			The nbcon console to flush
+ * @reason:			The reason for the flush
  * @stop_seq:			Flush up until this record
  *
  * This will stop flushing before @stop_seq if another context has ownership.
@@ -1617,13 +1620,14 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
  * are added while this context was flushing and there is no other context
  * to handle the printing, this context must also flush those records.
  */
-static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+static void nbcon_atomic_flush_pending_con(struct console *con, enum pr_flush_reason reason,
+					   u64 stop_seq)
 {
 	struct console_flush_type ft;
 	int err;
 
 again:
-	err = __nbcon_atomic_flush_pending_con(con, stop_seq);
+	err = __nbcon_atomic_flush_pending_con(con, reason, stop_seq);
 
 	/*
 	 * If there was a new owner (-EPERM, -EAGAIN), that context is
@@ -1652,9 +1656,10 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 /**
  * __nbcon_atomic_flush_pending - Flush all nbcon consoles using their
  *					write_atomic() callback
+ * @reason:			The reason for the flush
  * @stop_seq:			Flush up until this record
  */
-static void __nbcon_atomic_flush_pending(u64 stop_seq)
+static void __nbcon_atomic_flush_pending(enum pr_flush_reason reason, u64 stop_seq)
 {
 	struct console *con;
 	int cookie;
@@ -1672,7 +1677,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
 		if (nbcon_seq_read(con) >= stop_seq)
 			continue;
 
-		nbcon_atomic_flush_pending_con(con, stop_seq);
+		nbcon_atomic_flush_pending_con(con, reason, stop_seq);
 	}
 	console_srcu_read_unlock(cookie);
 }
@@ -1681,14 +1686,16 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
  * nbcon_atomic_flush_pending - Flush all nbcon consoles using their
  *				write_atomic() callback
  *
+ * @reason:	The reason for the flush
+ *
  * Flush the backlog up through the currently newest record. Any new
  * records added while flushing will not be flushed if there is another
  * context available to handle the flushing. This is to avoid one CPU
  * printing unbounded because other CPUs continue to add records.
  */
-void nbcon_atomic_flush_pending(void)
+void nbcon_atomic_flush_pending(enum pr_flush_reason reason)
 {
-	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
+	__nbcon_atomic_flush_pending(reason, prb_next_reserve_seq(prb));
 }
 
 /**
@@ -1701,7 +1708,7 @@ void nbcon_atomic_flush_pending(void)
 void nbcon_atomic_flush_unsafe(void)
 {
 	panic_nbcon_allow_unsafe_takeover = true;
-	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
+	__nbcon_atomic_flush_pending(PR_FLUSH_HANG, prb_next_reserve_seq(prb));
 	panic_nbcon_allow_unsafe_takeover = false;
 }
 
@@ -1931,7 +1938,8 @@ void nbcon_device_release(struct console *con)
 		 * using the legacy loop.
 		 */
 		if (ft.nbcon_atomic) {
-			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
+			__nbcon_atomic_flush_pending_con(con, PR_FLUSH_RUNTIME,
+							 prb_next_reserve_seq(prb));
 		} else if (ft.legacy_direct) {
 			if (console_trylock())
 				console_unlock();
@@ -2001,7 +2009,7 @@ void nbcon_kdb_release(struct nbcon_write_context *wctxt)
 	 * The console was locked only when the write_atomic() callback
 	 * was usable.
 	 */
-	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb));
+	__nbcon_atomic_flush_pending_con(ctxt->console, PR_FLUSH_KDB, prb_next_reserve_seq(prb));
 }
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5dbcf8a9909bb..c059b40fc993c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -464,6 +464,14 @@ bool have_boot_console;
 /* See printk_legacy_allow_panic_sync() for details. */
 bool legacy_allow_panic_sync;
 
+/*
+ * While some context is performing a backlog flush, track the reason for
+ * the flush in case nbcon consoles are using legacy printing.
+ * Synchronized by the console_lock, except in console_flush_on_panic()
+ * when the console_lock is ignored.
+ */
+enum pr_flush_reason legacy_flush_reason = PR_FLUSH_RUNTIME;
+
 /* Avoid using irq_work when suspending. */
 bool console_irqwork_blocked;
 
@@ -2455,7 +2463,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	if (ft.nbcon_atomic)
-		nbcon_atomic_flush_pending();
+		nbcon_atomic_flush_pending(PR_FLUSH_RUNTIME);
 
 	if (ft.nbcon_offload)
 		nbcon_kthreads_wake();
@@ -2870,7 +2878,7 @@ static int console_cpu_notify(unsigned int cpu)
 	if (!cpuhp_tasks_frozen) {
 		printk_get_console_flush_type(&ft);
 		if (ft.nbcon_atomic)
-			nbcon_atomic_flush_pending();
+			nbcon_atomic_flush_pending(PR_FLUSH_RUNTIME);
 		if (ft.legacy_direct) {
 			if (console_trylock())
 				console_unlock();
@@ -3530,10 +3538,11 @@ static void __console_rewind_all(void)
 /**
  * console_flush_on_panic - flush console content on panic
  * @mode: flush all messages in buffer or just the pending ones
+ * @reason:	The reason for the flush
  *
  * Immediately output all pending messages no matter what.
  */
-void console_flush_on_panic(enum con_flush_mode mode)
+void console_flush_on_panic(enum con_flush_mode mode, enum pr_flush_reason reason)
 {
 	struct console_flush_type ft;
 	bool handover;
@@ -3561,11 +3570,14 @@ void console_flush_on_panic(enum con_flush_mode mode)
 
 	printk_get_console_flush_type(&ft);
 	if (ft.nbcon_atomic)
-		nbcon_atomic_flush_pending();
+		nbcon_atomic_flush_pending(PR_FLUSH_RUNTIME);
 
 	/* Flush legacy consoles once allowed, even when dangerous. */
-	if (legacy_allow_panic_sync)
+	if (legacy_allow_panic_sync) {
+		legacy_flush_reason = reason;
 		console_flush_all(false, &next_seq, &handover);
+		legacy_flush_reason = PR_FLUSH_RUNTIME;
+	}
 }
 
 /*
@@ -3775,7 +3787,7 @@ static void printk_kthreads_shutdown(void *data)
 		 * The threads may have been stopped while printing a
 		 * backlog. Flush any records left over.
 		 */
-		nbcon_atomic_flush_pending();
+		nbcon_atomic_flush_pending(PR_FLUSH_RUNTIME);
 	}
 	console_list_unlock();
 }
@@ -4537,7 +4549,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	/* Flush the consoles so that records up to @seq are printed. */
 	printk_get_console_flush_type(&ft);
 	if (ft.nbcon_atomic)
-		nbcon_atomic_flush_pending();
+		nbcon_atomic_flush_pending(PR_FLUSH_RUNTIME);
 	if (ft.legacy_direct) {
 		console_lock();
 		console_unlock();
@@ -4725,6 +4737,7 @@ void defer_console_output(void)
 
 /**
  * printk_trigger_flush - Attempt to flush printk buffer to consoles.
+ * @reason:	The reason for the flush
  *
  * If possible, flush the printk buffer to all consoles in the caller's
  * context. If offloading is available, trigger deferred printing.
@@ -4732,18 +4745,21 @@ void defer_console_output(void)
  * This is best effort. Depending on the system state, console states,
  * and caller context, no actual flushing may result from this call.
  */
-void printk_trigger_flush(void)
+void printk_trigger_flush(enum pr_flush_reason reason)
 {
 	struct console_flush_type ft;
 
 	printk_get_console_flush_type(&ft);
 	if (ft.nbcon_atomic)
-		nbcon_atomic_flush_pending();
+		nbcon_atomic_flush_pending(reason);
 	if (ft.nbcon_offload)
 		nbcon_kthreads_wake();
 	if (ft.legacy_direct) {
-		if (console_trylock())
+		if (console_trylock()) {
+			legacy_flush_reason = reason;
 			console_unlock();
+			legacy_flush_reason = PR_FLUSH_RUNTIME;
+		}
 	}
 	if (ft.legacy_offload)
 		defer_console_output();
@@ -5090,7 +5106,7 @@ void console_try_replay_all(void)
 	if (console_trylock()) {
 		__console_rewind_all();
 		if (ft.nbcon_atomic)
-			nbcon_atomic_flush_pending();
+			nbcon_atomic_flush_pending(PR_FLUSH_RUNTIME);
 		if (ft.nbcon_offload)
 			nbcon_kthreads_wake();
 		if (ft.legacy_offload)
diff --git a/kernel/reboot.c b/kernel/reboot.c
index a93c23b9e1948..f2f5dfa8e33ce 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -101,7 +101,7 @@ void emergency_restart(void)
 	 * the emergency restart. Move them to the atomic mode.
 	 */
 	nbcon_cpu_emergency_enter();
-	printk_trigger_flush();
+	printk_trigger_flush(PR_FLUSH_RESTART);
 
 	machine_emergency_restart();
 }
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index f39c9eca88885..925276113d3a0 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -91,7 +91,7 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 	 * Force flush any remote buffers that might be stuck in IRQ context
 	 * and therefore could not run their irq_work.
 	 */
-	printk_trigger_flush();
+	printk_trigger_flush(PR_FLUSH_RUNTIME);
 
 	clear_bit_unlock(0, &backtrace_flag);
 	put_cpu();
-- 
2.47.3


