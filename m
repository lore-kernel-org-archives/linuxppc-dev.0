Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id B0A12DDDDF
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 20:00:06 +1000 (EST)
Message-ID: <48B919CB.3090509@hypersurf.com>
Date: Sat, 30 Aug 2008 02:58:35 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] Add kernel doc for the completion,
	fix kernel-doc-nano-HOWTO.txt
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds kernel doc for the completion feature. It is in kernel/sched.c
and include/linux/completion.h.

An error in the split-man.pl PERL snippet in kernel-doc-nano-HOWTO.txt is
also fixed.

My name is Kevin Diggs and I approve this patch.

Signed-off-by: Kevin Diggs <kevdig@hypersurf.com>


Index: Documentation/kernel-doc-nano-HOWTO.txt
===================================================================
--- Documentation/kernel-doc-nano-HOWTO.txt.orig	2008-08-13 02:18:53.000000000 -0700
+++ Documentation/kernel-doc-nano-HOWTO.txt	2008-08-19 14:21:43.000000000 -0700
@@ -168,10 +168,10 @@ if ($#ARGV < 0) {
  mkdir $ARGV[0],0777;
  $state = 0;
  while (<STDIN>) {
-    if (/^\.TH \"[^\"]*\" 4 \"([^\"]*)\"/) {
+    if (/^\.TH \"[^\"]*\" 9 \"([^\"]*)\"/) {
  	if ($state == 1) { close OUT }
  	$state = 1;
-	$fn = "$ARGV[0]/$1.4";
+	$fn = "$ARGV[0]/$1.9";
  	print STDERR "Creating $fn\n";
  	open OUT, ">$fn" or die "can't open $fn: $!\n";
  	print OUT $_;
Index: include/linux/completion.h
===================================================================
--- include/linux/completion.h.orig	2008-08-13 00:56:52.000000000 -0700
+++ include/linux/completion.h	2008-08-20 01:47:21.000000000 -0700
@@ -10,6 +10,18 @@

  #include <linux/wait.h>

+/**
+ * struct completion - structure used to maintain state for a "completion"
+ *
+ * This is the opaque structure used to maintain the state for a "completion".
+ * Completions currently use a FIFO to queue threads that have to wait for
+ * the "completion" event.
+ *
+ * See also:  complete(), wait_for_completion() (and friends _timeout,
+ * _interruptible, _interruptible_timeout, and _killable), init_completion(),
+ * and macros DECLARE_COMPLETION(), DECLARE_COMPLETION_ONSTACK(), and
+ * INIT_COMPLETION().
+ */
  struct completion {
  	unsigned int done;
  	wait_queue_head_t wait;
@@ -21,6 +33,14 @@ struct completion {
  #define COMPLETION_INITIALIZER_ONSTACK(work) \
  	({ init_completion(&work); work; })

+/**
+ * DECLARE_COMPLETION: - declare and initialize a completion structure
+ * @work:  identifier for the completion structure
+ *
+ * This macro declares and initializes a completion structure. Generally used
+ * for static declarations. You should use the _ONSTACK variant for automatic
+ * variables.
+ */
  #define DECLARE_COMPLETION(work) \
  	struct completion work = COMPLETION_INITIALIZER(work)

@@ -29,6 +49,13 @@ struct completion {
   * completions - so we use the _ONSTACK() variant for those that
   * are on the kernel stack:
   */
+/**
+ * DECLARE_COMPLETION_ONSTACK: - declare and initialize a completion structure
+ * @work:  identifier for the completion structure
+ *
+ * This macro declares and initializes a completion structure on the kernel
+ * stack.
+ */
  #ifdef CONFIG_LOCKDEP
  # define DECLARE_COMPLETION_ONSTACK(work) \
  	struct completion work = COMPLETION_INITIALIZER_ONSTACK(work)
@@ -36,6 +63,13 @@ struct completion {
  # define DECLARE_COMPLETION_ONSTACK(work) DECLARE_COMPLETION(work)
  #endif

+/**
+ * init_completion: - Initialize a dynamically allocated completion
+ * @x:  completion structure that is to be initialized
+ *
+ * This inline function will initialize a dynamically created completion
+ * structure.
+ */
  static inline void init_completion(struct completion *x)
  {
  	x->done = 0;
@@ -53,6 +87,13 @@ extern unsigned long wait_for_completion
  extern void complete(struct completion *);
  extern void complete_all(struct completion *);

+/**
+ * INIT_COMPLETION: - reinitialize a completion structure
+ * @x:  completion structure to be reinitialized
+ *
+ * This macro should be used to reinitialize a completion structure so it can
+ * be reused. This is especially important after complete_all() is used.
+ */
  #define INIT_COMPLETION(x)	((x).done = 0)

  #endif
Index: kernel/sched.c
===================================================================
--- kernel/sched.c.orig	2008-08-13 02:22:42.000000000 -0700
+++ kernel/sched.c	2008-08-20 12:36:01.000000000 -0700
@@ -4363,6 +4363,15 @@ __wake_up_sync(wait_queue_head_t *q, uns
  }
  EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */

+/**
+ * complete: - signals a single thread waiting on this completion
+ * @x:  holds the state of this particular completion
+ *
+ * This will wake up a single thread waiting on this completion. Threads will be
+ * awakened in the same order in which they were queued.
+ *
+ * See also complete_all(), wait_for_completion() and related routines.
+ */
  void complete(struct completion *x)
  {
  	unsigned long flags;
@@ -4374,6 +4383,12 @@ void complete(struct completion *x)
  }
  EXPORT_SYMBOL(complete);

+/**
+ * complete_all: - signals all threads waiting on this completion
+ * @x:  holds the state of this particular completion
+ *
+ * This will wake up all threads waiting on this particular completion event.
+ */
  void complete_all(struct completion *x)
  {
  	unsigned long flags;
@@ -4425,12 +4440,31 @@ wait_for_common(struct completion *x, lo
  	return timeout;
  }

+/**
+ * wait_for_completion: - waits for completion of a task
+ * @x:  holds the state of this particular completion
+ *
+ * This waits to be signaled for completion of a specific task. It is NOT
+ * interruptible and there is no timeout.
+ *
+ * See also similar routines (i.e. wait_for_completion_timeout()) with timeout
+ * and interrupt capability. Also see complete().
+ */
  void __sched wait_for_completion(struct completion *x)
  {
  	wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
  }
  EXPORT_SYMBOL(wait_for_completion);

+/**
+ * wait_for_completion_timeout: - waits for completion of a task (w/timeout)
+ * @x:  holds the state of this particular completion
+ * @timeout:  timeout value in jiffies
+ *
+ * This waits for either a completion of a specific task to be signaled or for a
+ * specified timeout to expire. The timeout is in jiffies. It is not
+ * interruptible.
+ */
  unsigned long __sched
  wait_for_completion_timeout(struct completion *x, unsigned long timeout)
  {
@@ -4438,6 +4472,13 @@ wait_for_completion_timeout(struct compl
  }
  EXPORT_SYMBOL(wait_for_completion_timeout);

+/**
+ * wait_for_completion_interruptible: - waits for completion of a task (w/intr)
+ * @x:  holds the state of this particular completion
+ *
+ * This waits for completion of a specific task to be signaled. It is
+ * interruptible.
+ */
  int __sched wait_for_completion_interruptible(struct completion *x)
  {
  	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE);
@@ -4447,6 +4488,14 @@ int __sched wait_for_completion_interrup
  }
  EXPORT_SYMBOL(wait_for_completion_interruptible);

+/**
+ * wait_for_completion_interruptible_timeout: - waits for completion (w/(to,intr))
+ * @x:  holds the state of this particular completion
+ * @timeout:  timeout value in jiffies
+ *
+ * This waits for either a completion of a specific task to be signaled or for a
+ * specified timeout to expire. It is interruptible. The timeout is in jiffies.
+ */
  unsigned long __sched
  wait_for_completion_interruptible_timeout(struct completion *x,
  					  unsigned long timeout)
@@ -4455,6 +4504,13 @@ wait_for_completion_interruptible_timeou
  }
  EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);

+/**
+ * wait_for_completion_killable: - waits for completion of a task (killable)
+ * @x:  holds the state of this particular completion
+ *
+ * This waits to be signaled for completion of a specific task. It can be
+ * interrupted by a kill signal.
+ */
  int __sched wait_for_completion_killable(struct completion *x)
  {
  	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_KILLABLE);
