From: Ryan Nielsen <ran@krazynet.com>
Message-ID: <19990111042611.A152@gondolin>
Date: Mon, 11 Jan 1999 04:26:11 -0800
To: Troy Benjegerdes <hozer@drgw.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux-2.2.0-pre5 SMP broken on PReP?
References: <Pine.LNX.4.04.9901071243090.32305-100000@narn.local.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.04.9901071243090.32305-100000@narn.local.drgw.net>; from Troy Benjegerdes on Thu, Jan 07, 1999 at 12:55:22PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 07, 1999 at 12:55:22 -0600, Troy Benjegerdes wrote:
> 
> After working with 2.1.132 for awhile, I decided it was time to try
> Linus's 2.2.0-pre5, however I haven't been able to successfully boot with
> it. I have tweaked code and tried various revisions includeing pre1 and
> pre4 (pre1 wouldn't compile).
> 
> I have been getting crashes in the ncr53c8xx driver, but the dump doesn't
> seem to be providing valid information.

it is crashing in kswapd, not the ncr driver.

I got pre6 to work by reverse-patching the kswapd part of mm/vmscan.c down to pre4
this is only needed for SMP...
--- vmscan.c	Mon Jan 11 03:50:23 1999
+++ vmscan.c.works	Mon Jan 11 03:41:35 1999
@@ -20,6 +20,13 @@
 
 #include <asm/pgtable.h>
 
+/* 
+ * The wait queue for waking up the pageout daemon:
+ */
+static struct task_struct * kswapd_task = NULL;
+
+static void init_swap_timer(void);
+
 /*
  * The swap-out functions return 1 if they successfully
  * threw something out, and we got a free page. It returns
@@ -385,36 +392,71 @@
        printk ("Starting kswapd v%.*s\n", i, s);
 }
 
+#define free_memory(fn) \
+	count++; do { if (!--count) goto done; } while (fn)
+
+static int kswapd_free_pages(int kswapd_state)
+{
+	unsigned long end_time;
+
+	/* Always trim SLAB caches when memory gets low. */
+	kmem_cache_reap(0);
+
+	/* max one hundreth of a second */
+	end_time = jiffies + (HZ-1)/100;
+	do {
+		int priority = 8;
+		int count = pager_daemon.swap_cluster;
+
+		switch (kswapd_state) {
+			do {
+			default:
+				free_memory(shrink_mmap(priority, 0));
+				free_memory(swap_out(priority, 0));
+				kswapd_state++;
+			case 1:
+				free_memory(shm_swap(priority, 0));
+				shrink_dcache_memory(priority, 0);
+				kswapd_state = 0;
+			} while (--priority >= 0);
+			return kswapd_state;
+		}
+done:
+		if (nr_free_pages > freepages.high + pager_daemon.swap_cluster)
+			break;
+	} while (time_before_eq(jiffies,end_time));
+	return kswapd_state;
+}
+
 /*
- * The background pageout daemon, started as a kernel thread
- * from the init process. 
- *
- * This basically executes once a second, trickling out pages
- * so that we have _some_ free memory available even if there
- * is no other activity that frees anything up. This is needed
- * for things like routing etc, where we otherwise might have
- * all activity going on in asynchronous contexts that cannot
- * page things out.
- *
- * If there are applications that are active memory-allocators
- * (most normal use), this basically shouldn't matter.
+ * The background pageout daemon.
+ * Started as a kernel thread from the init process.
  */
 int kswapd(void *unused)
 {
 	current->session = 1;
 	current->pgrp = 1;
 	strcpy(current->comm, "kswapd");
+	sigfillset(&current->blocked);
+	
+	/*
+	 *	As a kernel thread we want to tamper with system buffers
+	 *	and other internals and thus be subject to the SMP locking
+	 *	rules. (On a uniprocessor box this does nothing).
+	 */
+	lock_kernel();
 
 	/*
-	 * Hey, if somebody wants to kill us, be our guest. 
-	 * Don't come running to mama if things don't work.
+	 * Set the base priority to something smaller than a
+	 * regular process. We will scale up the priority
+	 * dynamically depending on how much memory we need.
 	 */
-	siginitsetinv(&current->blocked, sigmask(SIGKILL));
-	
+	current->priority = (DEF_PRIORITY * 2) / 3;
+
 	/*
 	 * Tell the memory management that we're a "memory allocator",
 	 * and that if we need more memory we should get access to it
-	 * regardless (see "__get_free_pages()"). "kswapd" should
+	 * regardless (see "try_to_free_pages()"). "kswapd" should
 	 * never get caught in the normal page freeing logic.
 	 *
 	 * (Kswapd normally doesn't need memory anyway, but sometimes
@@ -425,23 +467,21 @@
 	 */
 	current->flags |= PF_MEMALLOC;
 
+	init_swap_timer();
+	kswapd_task = current;
 	while (1) {
-		if (signal_pending(current))
-			break;
+		int state = 0;
+
 		current->state = TASK_INTERRUPTIBLE;
+		flush_signals(current);
 		run_task_queue(&tq_disk);
-		schedule_timeout(HZ);
-
-		/*
-		 * kswapd isn't even meant to keep up with anything,
-		 * so just a few pages per second is plenty: the only
-		 * point is to make sure that the system doesn't stay
-		 * forever in a really bad memory squeeze.
-		 */
-		if (nr_free_pages < freepages.high)
-			try_to_free_pages(0, 16);
+		schedule();
+		swapstats.wakeups++;
+		state = kswapd_free_pages(state);
 	}
-
+	/* As if we could ever get here - maybe we want to make this killable */
+	kswapd_task = NULL;
+	unlock_kernel();
 	return 0;
 }
 
@@ -488,4 +528,73 @@
 	unlock_kernel();
 
 	return priority >= 0;
+}
+
+/*
+ * Wake up kswapd according to the priority
+ *	0 - no wakeup
+ *	1 - wake up as a low-priority process
+ *	2 - wake up as a normal process
+ *	3 - wake up as an almost real-time process
+ *
+ * This plays mind-games with the "goodness()"
+ * function in kernel/sched.c.
+ */
+static inline void kswapd_wakeup(struct task_struct *p, int priority)
+{
+	if (priority) {
+		p->counter = p->priority << priority;
+		wake_up_process(p);
+	}
+}
+
+/* 
+ * The swap_tick function gets called on every clock tick.
+ */
+void swap_tick(void)
+{
+	struct task_struct *p = kswapd_task;
+
+	/*
+	 * Only bother to try to wake kswapd up
+	 * if the task exists and can be woken.
+	 */
+	if (p && (p->state & TASK_INTERRUPTIBLE)) {
+		unsigned int pages;
+		int want_wakeup;
+
+		/*
+		 * Schedule for wakeup if there isn't lots
+		 * of free memory or if there is too much
+		 * of it used for buffers or pgcache.
+		 *
+		 * "want_wakeup" is our priority: 0 means
+		 * not to wake anything up, while 3 means
+		 * that we'd better give kswapd a realtime
+		 * priority.
+		 */
+		want_wakeup = 0;
+		pages = nr_free_pages;
+		if (pages < freepages.high)
+			want_wakeup = 1;
+		if (pages < freepages.low)
+			want_wakeup = 2;
+		if (pages < freepages.min)
+			want_wakeup = 3;
+	
+		kswapd_wakeup(p,want_wakeup);
+	}
+
+	timer_active |= (1<<SWAP_TIMER);
+}
+
+/* 
+ * Initialise the swap timer
+ */
+
+void init_swap_timer(void)
+{
+	timer_table[SWAP_TIMER].expires = jiffies;
+	timer_table[SWAP_TIMER].fn = swap_tick;
+	timer_active |= (1<<SWAP_TIMER);
 }

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
