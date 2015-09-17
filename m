Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0199.hostedemail.com
 [216.40.44.199])
 by lists.ozlabs.org (Postfix) with ESMTP id 627DD1A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 00:53:03 +1000 (AEST)
Date: Thu, 17 Sep 2015 10:52:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Scott Wood <scottwood@freescale.com>, Christophe Leroy
 <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
Message-ID: <20150917105257.1244ac92@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.11.1509171630130.3951@nanos>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
 <alpine.DEB.2.11.1509162159110.3951@nanos>
 <20150916215435.48bee4d3@grimm.local.home>
 <alpine.DEB.2.11.1509170911120.3951@nanos>
 <20150917092931.56475b7d@gandalf.local.home>
 <alpine.DEB.2.11.1509171630130.3951@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 17 Sep 2015 16:38:52 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 17 Sep 2015, Steven Rostedt wrote:
> 
> > On Thu, 17 Sep 2015 12:13:15 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > Digging deeper. My assumption that it's a post powerpc merge failure
> > > turned out to be wrong.
> > 
> > Does 4.2 have the problem?
> 
> No. Neither does 
> 
> 4c92b5bb1422: Merge branch 'pcmcia' of git://ftp.arm.linux.org.uk/~rmk/linux-arm

What's the significance of that commit?

>  
> > If it's a corruption of the mcount tables, it could be specific on what
> > the compiler does. That is, the working of one kernel to the other, may
> > only depend on how gcc compiled something. Have you tried different
> > compilers? Maybe one version of gcc may work over another?
> 
> It just results in a different failure mode. Instead of silently
> hanging I get:
> 
> [    2.248275] Oops: Exception in kernel mode, sig: 4 [#1]
> [    2.253633] PREEMPT lite5200
> [    2.256584] Modules linked in:
> [    2.259723] CPU: 0 PID: 1 Comm: swapper Not tainted 4.3.0-rc1-51179-gae80a2f-dirty #75
> [    2.267815] task: c383c000 ti: c383a000 task.ti: c383a000
> [    2.273330] NIP: c00e1eec LR: c00df0f4 CTR: 00000000
> [    2.278405] REGS: c383bcd0 TRAP: 0700   Not tainted  (4.3.0-rc1-51179-gae80a2f-dirty)
> [    2.286396] MSR: 00089032 <EE,ME,IR,DR,RI>  CR: 44824028  XER: 00000000
> [    2.293187] 
> GPR00: c00def84 c383bd80 c383c000 c3084000 bffffff1 00677595 c383bdd8 00000000 
> GPR08: 00000001 00000001 00000400 00000002 24828022 00000000 c0004254 84822042 
> GPR16: 20000000 44822042 fffff000 c3086ffc c06ce248 c383a000 c3082000 c06d0000 
> GPR24: c383a000 00000ffc 00677595 bffffff1 c3084000 c3015bfc 00000017 c3086000 
> [    2.323656] NIP [c00e1eec] vm_normal_page+0x0/0xdc
> [    2.328560] LR [c00df0f4] follow_page_mask+0x260/0x4fc
> [    2.333807] Call Trace:
> [    2.336321] [c383bd80] [c00def84] follow_page_mask+0xf0/0x4fc (unreliable)
> [    2.343360] [c383bdd0] [c00df4a4] __get_user_pages.part.28+0x114/0x3e0
> [    2.350050] [c383be30] [c010e788] copy_strings+0x16c/0x2c8
> [    2.355668] [c383bea0] [c010e91c] copy_strings_kernel+0x38/0x50
> [    2.361730] [c383bec0] [c011057c] do_execveat_common+0x440/0x658
> [    2.367877] [c383bf10] [c01107cc] do_execve+0x38/0x48
> [    2.373056] [c383bf20] [c00039f0] try_to_run_init_process+0x24/0x64
> [    2.379469] [c383bf30] [c000430c] kernel_init+0xb8/0x10c
> [    2.384924] [c383bf40] [c0010c40] ret_from_kernel_thread+0x5c/0x64
> [    2.391242] --- interrupt: 0 at   (null)
> [    2.391242]     LR =   (null)
> [    2.398263] Instruction dump:
> [    2.401297] 01000000 00037000 00000000 00000000 f0000000 00000001 0a641e09 acde4823 
> [    2.409237] 000f0000 179a7b00 07de2900 03ef1480 <01f78a40> 0001c200 60000000 9421fff0 

Can you objdump this and and see what that is suppose to be.

> [    2.417375] ---[ end trace 996fd312ce9c18ce ]---
> 
> Again, if I disable CONFIG_TRACER its gone.

You mean if you disable CONFIG_FUNCTION_TRACER?

Below is the entire push of ftrace for this merge window. Not much has
changed. Could using "unsigned long" instead of "long" with the
MCOUNT_ADDR cause this bug?

-- Steve

diff --git a/Documentation/trace/ftrace.txt b/Documentation/trace/ftrace.txt
index 7ddb1e319f84..072d3c4d5753 100644
--- a/Documentation/trace/ftrace.txt
+++ b/Documentation/trace/ftrace.txt
@@ -686,6 +686,8 @@ The above is mostly meaningful for kernel developers.
 	 The marks are determined by the difference between this
 	 current trace and the next trace.
 	  '$' - greater than 1 second
+	  '@' - greater than 100 milisecond
+	  '*' - greater than 10 milisecond
 	  '#' - greater than 1000 microsecond
 	  '!' - greater than 100 microsecond
 	  '+' - greater than 10 microsecond
@@ -1939,26 +1941,49 @@ want, depending on your needs.
 
   ie:
 
-  0)               |    up_write() {
-  0)   0.646 us    |      _spin_lock_irqsave();
-  0)   0.684 us    |      _spin_unlock_irqrestore();
-  0)   3.123 us    |    }
-  0)   0.548 us    |    fput();
-  0) + 58.628 us   |  }
+  3) # 1837.709 us |          } /* __switch_to */
+  3)               |          finish_task_switch() {
+  3)   0.313 us    |            _raw_spin_unlock_irq();
+  3)   3.177 us    |          }
+  3) # 1889.063 us |        } /* __schedule */
+  3) ! 140.417 us  |      } /* __schedule */
+  3) # 2034.948 us |    } /* schedule */
+  3) * 33998.59 us |  } /* schedule_preempt_disabled */
 
   [...]
 
-  0)               |      putname() {
-  0)               |        kmem_cache_free() {
-  0)   0.518 us    |          __phys_addr();
-  0)   1.757 us    |        }
-  0)   2.861 us    |      }
-  0) ! 115.305 us  |    }
-  0) ! 116.402 us  |  }
+  1)   0.260 us    |              msecs_to_jiffies();
+  1)   0.313 us    |              __rcu_read_unlock();
+  1) + 61.770 us   |            }
+  1) + 64.479 us   |          }
+  1)   0.313 us    |          rcu_bh_qs();
+  1)   0.313 us    |          __local_bh_enable();
+  1) ! 217.240 us  |        }
+  1)   0.365 us    |        idle_cpu();
+  1)               |        rcu_irq_exit() {
+  1)   0.417 us    |          rcu_eqs_enter_common.isra.47();
+  1)   3.125 us    |        }
+  1) ! 227.812 us  |      }
+  1) ! 457.395 us  |    }
+  1) @ 119760.2 us |  }
+
+  [...]
+
+  2)               |    handle_IPI() {
+  1)   6.979 us    |                  }
+  2)   0.417 us    |      scheduler_ipi();
+  1)   9.791 us    |                }
+  1) + 12.917 us   |              }
+  2)   3.490 us    |    }
+  1) + 15.729 us   |            }
+  1) + 18.542 us   |          }
+  2) $ 3594274 us  |  }
 
   + means that the function exceeded 10 usecs.
   ! means that the function exceeded 100 usecs.
   # means that the function exceeded 1000 usecs.
+  * means that the function exceeded 10 msecs.
+  @ means that the function exceeded 100 msecs.
   $ means that the function exceeded 1 sec.
 
 
diff --git a/arch/metag/include/asm/ftrace.h b/arch/metag/include/asm/ftrace.h
index 2901f0f7d944..a2269d60a945 100644
--- a/arch/metag/include/asm/ftrace.h
+++ b/arch/metag/include/asm/ftrace.h
@@ -6,7 +6,7 @@
 
 #ifndef __ASSEMBLY__
 extern void mcount_wrapper(void);
-#define MCOUNT_ADDR		((long)(mcount_wrapper))
+#define MCOUNT_ADDR		((unsigned long)(mcount_wrapper))
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
diff --git a/arch/microblaze/include/asm/ftrace.h b/arch/microblaze/include/asm/ftrace.h
index fd2fa2eca62f..da0144f40d99 100644
--- a/arch/microblaze/include/asm/ftrace.h
+++ b/arch/microblaze/include/asm/ftrace.h
@@ -3,7 +3,7 @@
 
 #ifdef CONFIG_FUNCTION_TRACER
 
-#define MCOUNT_ADDR		((long)(_mcount))
+#define MCOUNT_ADDR		((unsigned long)(_mcount))
 #define MCOUNT_INSN_SIZE	8 /* sizeof mcount call */
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index e3661872fbea..ef89b1465573 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -2,7 +2,7 @@
 #define _ASM_POWERPC_FTRACE
 
 #ifdef CONFIG_FUNCTION_TRACER
-#define MCOUNT_ADDR		((long)(_mcount))
+#define MCOUNT_ADDR		((unsigned long)(_mcount))
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
 
 #ifdef __ASSEMBLY__
diff --git a/arch/sh/include/asm/ftrace.h b/arch/sh/include/asm/ftrace.h
index e79fb6ebaa42..1f157b86eaa7 100644
--- a/arch/sh/include/asm/ftrace.h
+++ b/arch/sh/include/asm/ftrace.h
@@ -9,7 +9,7 @@
 #ifndef __ASSEMBLY__
 extern void mcount(void);
 
-#define MCOUNT_ADDR		((long)(mcount))
+#define MCOUNT_ADDR		((unsigned long)(mcount))
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 #define CALL_ADDR		((long)(ftrace_call))
diff --git a/arch/sparc/include/asm/ftrace.h b/arch/sparc/include/asm/ftrace.h
index 9ec94ad116fb..3192a8e42fd6 100644
--- a/arch/sparc/include/asm/ftrace.h
+++ b/arch/sparc/include/asm/ftrace.h
@@ -2,7 +2,7 @@
 #define _ASM_SPARC64_FTRACE
 
 #ifdef CONFIG_MCOUNT
-#define MCOUNT_ADDR		((long)(_mcount))
+#define MCOUNT_ADDR		((unsigned long)(_mcount))
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
 
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index f45acad3c4b6..24938852db30 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -3,9 +3,9 @@
 
 #ifdef CONFIG_FUNCTION_TRACER
 #ifdef CC_USING_FENTRY
-# define MCOUNT_ADDR		((long)(__fentry__))
+# define MCOUNT_ADDR		((unsigned long)(__fentry__))
 #else
-# define MCOUNT_ADDR		((long)(mcount))
+# define MCOUNT_ADDR		((unsigned long)(mcount))
 #endif
 #define MCOUNT_INSN_SIZE	5 /* sizeof mcount call */
 
diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index dee3bb1d5a6b..2cca6cd342d8 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -46,7 +46,7 @@ TRACE_EVENT(task_rename,
 	TP_fast_assign(
 		__entry->pid = task->pid;
 		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
-		memcpy(entry->newcomm, comm, TASK_COMM_LEN);
+		strlcpy(entry->newcomm, comm, TASK_COMM_LEN);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 02bece4a99ea..f46dbb5cdf76 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -613,13 +613,18 @@ static int function_stat_show(struct seq_file *m, void *v)
 		goto out;
 	}
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	avg = rec->time;
+	do_div(avg, rec->counter);
+	if (tracing_thresh && (avg < tracing_thresh))
+		goto out;
+#endif
+
 	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
 	seq_printf(m, "  %-30.30s  %10lu", str, rec->counter);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	seq_puts(m, "    ");
-	avg = rec->time;
-	do_div(avg, rec->counter);
 
 	/* Sample standard deviation (s^2) */
 	if (rec->counter <= 1)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6260717c18e3..fc347f8b1bca 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -400,6 +400,17 @@ struct rb_irq_work {
 };
 
 /*
+ * Structure to hold event state and handle nested events.
+ */
+struct rb_event_info {
+	u64			ts;
+	u64			delta;
+	unsigned long		length;
+	struct buffer_page	*tail_page;
+	int			add_timestamp;
+};
+
+/*
  * Used for which event context the event is in.
  *  NMI     = 0
  *  IRQ     = 1
@@ -1876,73 +1887,6 @@ rb_event_index(struct ring_buffer_event *event)
 	return (addr & ~PAGE_MASK) - BUF_PAGE_HDR_SIZE;
 }
 
-static inline int
-rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
-		   struct ring_buffer_event *event)
-{
-	unsigned long addr = (unsigned long)event;
-	unsigned long index;
-
-	index = rb_event_index(event);
-	addr &= PAGE_MASK;
-
-	return cpu_buffer->commit_page->page == (void *)addr &&
-		rb_commit_index(cpu_buffer) == index;
-}
-
-static void
-rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
-{
-	unsigned long max_count;
-
-	/*
-	 * We only race with interrupts and NMIs on this CPU.
-	 * If we own the commit event, then we can commit
-	 * all others that interrupted us, since the interruptions
-	 * are in stack format (they finish before they come
-	 * back to us). This allows us to do a simple loop to
-	 * assign the commit to the tail.
-	 */
- again:
-	max_count = cpu_buffer->nr_pages * 100;
-
-	while (cpu_buffer->commit_page != cpu_buffer->tail_page) {
-		if (RB_WARN_ON(cpu_buffer, !(--max_count)))
-			return;
-		if (RB_WARN_ON(cpu_buffer,
-			       rb_is_reader_page(cpu_buffer->tail_page)))
-			return;
-		local_set(&cpu_buffer->commit_page->page->commit,
-			  rb_page_write(cpu_buffer->commit_page));
-		rb_inc_page(cpu_buffer, &cpu_buffer->commit_page);
-		cpu_buffer->write_stamp =
-			cpu_buffer->commit_page->page->time_stamp;
-		/* add barrier to keep gcc from optimizing too much */
-		barrier();
-	}
-	while (rb_commit_index(cpu_buffer) !=
-	       rb_page_write(cpu_buffer->commit_page)) {
-
-		local_set(&cpu_buffer->commit_page->page->commit,
-			  rb_page_write(cpu_buffer->commit_page));
-		RB_WARN_ON(cpu_buffer,
-			   local_read(&cpu_buffer->commit_page->page->commit) &
-			   ~RB_WRITE_MASK);
-		barrier();
-	}
-
-	/* again, keep gcc from optimizing */
-	barrier();
-
-	/*
-	 * If an interrupt came in just after the first while loop
-	 * and pushed the tail page forward, we will be left with
-	 * a dangling commit that will never go forward.
-	 */
-	if (unlikely(cpu_buffer->commit_page != cpu_buffer->tail_page))
-		goto again;
-}
-
 static void rb_reset_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	cpu_buffer->read_stamp = cpu_buffer->reader_page->page->time_stamp;
@@ -1968,64 +1912,6 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 	iter->head = 0;
 }
 
-/* Slow path, do not inline */
-static noinline struct ring_buffer_event *
-rb_add_time_stamp(struct ring_buffer_event *event, u64 delta)
-{
-	event->type_len = RINGBUF_TYPE_TIME_EXTEND;
-
-	/* Not the first event on the page? */
-	if (rb_event_index(event)) {
-		event->time_delta = delta & TS_MASK;
-		event->array[0] = delta >> TS_SHIFT;
-	} else {
-		/* nope, just zero it */
-		event->time_delta = 0;
-		event->array[0] = 0;
-	}
-
-	return skip_time_extend(event);
-}
-
-/**
- * rb_update_event - update event type and data
- * @event: the event to update
- * @type: the type of event
- * @length: the size of the event field in the ring buffer
- *
- * Update the type and data fields of the event. The length
- * is the actual size that is written to the ring buffer,
- * and with this, we can determine what to place into the
- * data field.
- */
-static void
-rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
-		struct ring_buffer_event *event, unsigned length,
-		int add_timestamp, u64 delta)
-{
-	/* Only a commit updates the timestamp */
-	if (unlikely(!rb_event_is_commit(cpu_buffer, event)))
-		delta = 0;
-
-	/*
-	 * If we need to add a timestamp, then we
-	 * add it to the start of the resevered space.
-	 */
-	if (unlikely(add_timestamp)) {
-		event = rb_add_time_stamp(event, delta);
-		length -= RB_LEN_TIME_EXTEND;
-		delta = 0;
-	}
-
-	event->time_delta = delta;
-	length -= RB_EVNT_HDR_SIZE;
-	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT) {
-		event->type_len = 0;
-		event->array[0] = length;
-	} else
-		event->type_len = DIV_ROUND_UP(length, RB_ALIGNMENT);
-}
-
 /*
  * rb_handle_head_page - writer hit the head page
  *
@@ -2184,29 +2070,13 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 	return 0;
 }
 
-static unsigned rb_calculate_event_length(unsigned length)
-{
-	struct ring_buffer_event event; /* Used only for sizeof array */
-
-	/* zero length can cause confusions */
-	if (!length)
-		length++;
-
-	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT)
-		length += sizeof(event.array[0]);
-
-	length += RB_EVNT_HDR_SIZE;
-	length = ALIGN(length, RB_ARCH_ALIGNMENT);
-
-	return length;
-}
-
 static inline void
 rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
-	      struct buffer_page *tail_page,
-	      unsigned long tail, unsigned long length)
+	      unsigned long tail, struct rb_event_info *info)
 {
+	struct buffer_page *tail_page = info->tail_page;
 	struct ring_buffer_event *event;
+	unsigned long length = info->length;
 
 	/*
 	 * Only the event that crossed the page boundary
@@ -2276,13 +2146,14 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
  */
 static noinline struct ring_buffer_event *
 rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
-	     unsigned long length, unsigned long tail,
-	     struct buffer_page *tail_page, u64 ts)
+	     unsigned long tail, struct rb_event_info *info)
 {
+	struct buffer_page *tail_page = info->tail_page;
 	struct buffer_page *commit_page = cpu_buffer->commit_page;
 	struct ring_buffer *buffer = cpu_buffer->buffer;
 	struct buffer_page *next_page;
 	int ret;
+	u64 ts;
 
 	next_page = tail_page;
 
@@ -2368,74 +2239,120 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 
  out_again:
 
-	rb_reset_tail(cpu_buffer, tail_page, tail, length);
+	rb_reset_tail(cpu_buffer, tail, info);
 
 	/* fail and let the caller try again */
 	return ERR_PTR(-EAGAIN);
 
  out_reset:
 	/* reset write */
-	rb_reset_tail(cpu_buffer, tail_page, tail, length);
+	rb_reset_tail(cpu_buffer, tail, info);
 
 	return NULL;
 }
 
-static struct ring_buffer_event *
-__rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
-		  unsigned long length, u64 ts,
-		  u64 delta, int add_timestamp)
+/* Slow path, do not inline */
+static noinline struct ring_buffer_event *
+rb_add_time_stamp(struct ring_buffer_event *event, u64 delta)
 {
-	struct buffer_page *tail_page;
-	struct ring_buffer_event *event;
-	unsigned long tail, write;
+	event->type_len = RINGBUF_TYPE_TIME_EXTEND;
 
-	/*
-	 * If the time delta since the last event is too big to
-	 * hold in the time field of the event, then we append a
-	 * TIME EXTEND event ahead of the data event.
-	 */
-	if (unlikely(add_timestamp))
-		length += RB_LEN_TIME_EXTEND;
+	/* Not the first event on the page? */
+	if (rb_event_index(event)) {
+		event->time_delta = delta & TS_MASK;
+		event->array[0] = delta >> TS_SHIFT;
+	} else {
+		/* nope, just zero it */
+		event->time_delta = 0;
+		event->array[0] = 0;
+	}
+
+	return skip_time_extend(event);
+}
 
-	tail_page = cpu_buffer->tail_page;
-	write = local_add_return(length, &tail_page->write);
+static inline int rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
+				     struct ring_buffer_event *event);
 
-	/* set write to only the index of the write */
-	write &= RB_WRITE_MASK;
-	tail = write - length;
+/**
+ * rb_update_event - update event type and data
+ * @event: the event to update
+ * @type: the type of event
+ * @length: the size of the event field in the ring buffer
+ *
+ * Update the type and data fields of the event. The length
+ * is the actual size that is written to the ring buffer,
+ * and with this, we can determine what to place into the
+ * data field.
+ */
+static void
+rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
+		struct ring_buffer_event *event,
+		struct rb_event_info *info)
+{
+	unsigned length = info->length;
+	u64 delta = info->delta;
+
+	/* Only a commit updates the timestamp */
+	if (unlikely(!rb_event_is_commit(cpu_buffer, event)))
+		delta = 0;
 
 	/*
-	 * If this is the first commit on the page, then it has the same
-	 * timestamp as the page itself.
+	 * If we need to add a timestamp, then we
+	 * add it to the start of the resevered space.
 	 */
-	if (!tail)
+	if (unlikely(info->add_timestamp)) {
+		event = rb_add_time_stamp(event, delta);
+		length -= RB_LEN_TIME_EXTEND;
 		delta = 0;
+	}
 
-	/* See if we shot pass the end of this buffer page */
-	if (unlikely(write > BUF_PAGE_SIZE))
-		return rb_move_tail(cpu_buffer, length, tail,
-				    tail_page, ts);
+	event->time_delta = delta;
+	length -= RB_EVNT_HDR_SIZE;
+	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT) {
+		event->type_len = 0;
+		event->array[0] = length;
+	} else
+		event->type_len = DIV_ROUND_UP(length, RB_ALIGNMENT);
+}
 
-	/* We reserved something on the buffer */
+static unsigned rb_calculate_event_length(unsigned length)
+{
+	struct ring_buffer_event event; /* Used only for sizeof array */
 
-	event = __rb_page_index(tail_page, tail);
-	kmemcheck_annotate_bitfield(event, bitfield);
-	rb_update_event(cpu_buffer, event, length, add_timestamp, delta);
+	/* zero length can cause confusions */
+	if (!length)
+		length++;
 
-	local_inc(&tail_page->entries);
+	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT)
+		length += sizeof(event.array[0]);
+
+	length += RB_EVNT_HDR_SIZE;
+	length = ALIGN(length, RB_ARCH_ALIGNMENT);
 
 	/*
-	 * If this is the first commit on the page, then update
-	 * its timestamp.
+	 * In case the time delta is larger than the 27 bits for it
+	 * in the header, we need to add a timestamp. If another
+	 * event comes in when trying to discard this one to increase
+	 * the length, then the timestamp will be added in the allocated
+	 * space of this event. If length is bigger than the size needed
+	 * for the TIME_EXTEND, then padding has to be used. The events
+	 * length must be either RB_LEN_TIME_EXTEND, or greater than or equal
+	 * to RB_LEN_TIME_EXTEND + 8, as 8 is the minimum size for padding.
+	 * As length is a multiple of 4, we only need to worry if it
+	 * is 12 (RB_LEN_TIME_EXTEND + 4).
 	 */
-	if (!tail)
-		tail_page->page->time_stamp = ts;
+	if (length == RB_LEN_TIME_EXTEND + RB_ALIGNMENT)
+		length += RB_ALIGNMENT;
 
-	/* account for these added bytes */
-	local_add(length, &cpu_buffer->entries_bytes);
+	return length;
+}
 
-	return event;
+#ifndef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
+static inline bool sched_clock_stable(void)
+{
+	return true;
 }
+#endif
 
 static inline int
 rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
@@ -2483,22 +2400,75 @@ static void rb_start_commit(struct ring_buffer_per_cpu *cpu_buffer)
 	local_inc(&cpu_buffer->commits);
 }
 
-static inline void rb_end_commit(struct ring_buffer_per_cpu *cpu_buffer)
+static void
+rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	unsigned long commits;
-
-	if (RB_WARN_ON(cpu_buffer,
-		       !local_read(&cpu_buffer->committing)))
-		return;
+	unsigned long max_count;
 
+	/*
+	 * We only race with interrupts and NMIs on this CPU.
+	 * If we own the commit event, then we can commit
+	 * all others that interrupted us, since the interruptions
+	 * are in stack format (they finish before they come
+	 * back to us). This allows us to do a simple loop to
+	 * assign the commit to the tail.
+	 */
  again:
-	commits = local_read(&cpu_buffer->commits);
-	/* synchronize with interrupts */
-	barrier();
-	if (local_read(&cpu_buffer->committing) == 1)
-		rb_set_commit_to_write(cpu_buffer);
-
-	local_dec(&cpu_buffer->committing);
+	max_count = cpu_buffer->nr_pages * 100;
+
+	while (cpu_buffer->commit_page != cpu_buffer->tail_page) {
+		if (RB_WARN_ON(cpu_buffer, !(--max_count)))
+			return;
+		if (RB_WARN_ON(cpu_buffer,
+			       rb_is_reader_page(cpu_buffer->tail_page)))
+			return;
+		local_set(&cpu_buffer->commit_page->page->commit,
+			  rb_page_write(cpu_buffer->commit_page));
+		rb_inc_page(cpu_buffer, &cpu_buffer->commit_page);
+		cpu_buffer->write_stamp =
+			cpu_buffer->commit_page->page->time_stamp;
+		/* add barrier to keep gcc from optimizing too much */
+		barrier();
+	}
+	while (rb_commit_index(cpu_buffer) !=
+	       rb_page_write(cpu_buffer->commit_page)) {
+
+		local_set(&cpu_buffer->commit_page->page->commit,
+			  rb_page_write(cpu_buffer->commit_page));
+		RB_WARN_ON(cpu_buffer,
+			   local_read(&cpu_buffer->commit_page->page->commit) &
+			   ~RB_WRITE_MASK);
+		barrier();
+	}
+
+	/* again, keep gcc from optimizing */
+	barrier();
+
+	/*
+	 * If an interrupt came in just after the first while loop
+	 * and pushed the tail page forward, we will be left with
+	 * a dangling commit that will never go forward.
+	 */
+	if (unlikely(cpu_buffer->commit_page != cpu_buffer->tail_page))
+		goto again;
+}
+
+static inline void rb_end_commit(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	unsigned long commits;
+
+	if (RB_WARN_ON(cpu_buffer,
+		       !local_read(&cpu_buffer->committing)))
+		return;
+
+ again:
+	commits = local_read(&cpu_buffer->commits);
+	/* synchronize with interrupts */
+	barrier();
+	if (local_read(&cpu_buffer->committing) == 1)
+		rb_set_commit_to_write(cpu_buffer);
+
+	local_dec(&cpu_buffer->committing);
 
 	/* synchronize with interrupts */
 	barrier();
@@ -2515,91 +2485,94 @@ static inline void rb_end_commit(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
-static struct ring_buffer_event *
-rb_reserve_next_event(struct ring_buffer *buffer,
-		      struct ring_buffer_per_cpu *cpu_buffer,
-		      unsigned long length)
+static inline void rb_event_discard(struct ring_buffer_event *event)
 {
-	struct ring_buffer_event *event;
-	u64 ts, delta;
-	int nr_loops = 0;
-	int add_timestamp;
-	u64 diff;
+	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+		event = skip_time_extend(event);
 
-	rb_start_commit(cpu_buffer);
+	/* array[0] holds the actual length for the discarded event */
+	event->array[0] = rb_event_data_length(event) - RB_EVNT_HDR_SIZE;
+	event->type_len = RINGBUF_TYPE_PADDING;
+	/* time delta must be non zero */
+	if (!event->time_delta)
+		event->time_delta = 1;
+}
 
-#ifdef CONFIG_RING_BUFFER_ALLOW_SWAP
-	/*
-	 * Due to the ability to swap a cpu buffer from a buffer
-	 * it is possible it was swapped before we committed.
-	 * (committing stops a swap). We check for it here and
-	 * if it happened, we have to fail the write.
-	 */
-	barrier();
-	if (unlikely(ACCESS_ONCE(cpu_buffer->buffer) != buffer)) {
-		local_dec(&cpu_buffer->committing);
-		local_dec(&cpu_buffer->commits);
-		return NULL;
-	}
-#endif
+static inline int
+rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
+		   struct ring_buffer_event *event)
+{
+	unsigned long addr = (unsigned long)event;
+	unsigned long index;
 
-	length = rb_calculate_event_length(length);
- again:
-	add_timestamp = 0;
-	delta = 0;
+	index = rb_event_index(event);
+	addr &= PAGE_MASK;
+
+	return cpu_buffer->commit_page->page == (void *)addr &&
+		rb_commit_index(cpu_buffer) == index;
+}
+
+static void
+rb_update_write_stamp(struct ring_buffer_per_cpu *cpu_buffer,
+		      struct ring_buffer_event *event)
+{
+	u64 delta;
 
 	/*
-	 * We allow for interrupts to reenter here and do a trace.
-	 * If one does, it will cause this original code to loop
-	 * back here. Even with heavy interrupts happening, this
-	 * should only happen a few times in a row. If this happens
-	 * 1000 times in a row, there must be either an interrupt
-	 * storm or we have something buggy.
-	 * Bail!
+	 * The event first in the commit queue updates the
+	 * time stamp.
 	 */
-	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 1000))
-		goto out_fail;
+	if (rb_event_is_commit(cpu_buffer, event)) {
+		/*
+		 * A commit event that is first on a page
+		 * updates the write timestamp with the page stamp
+		 */
+		if (!rb_event_index(event))
+			cpu_buffer->write_stamp =
+				cpu_buffer->commit_page->page->time_stamp;
+		else if (event->type_len == RINGBUF_TYPE_TIME_EXTEND) {
+			delta = event->array[0];
+			delta <<= TS_SHIFT;
+			delta += event->time_delta;
+			cpu_buffer->write_stamp += delta;
+		} else
+			cpu_buffer->write_stamp += event->time_delta;
+	}
+}
 
-	ts = rb_time_stamp(cpu_buffer->buffer);
-	diff = ts - cpu_buffer->write_stamp;
+static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
+		      struct ring_buffer_event *event)
+{
+	local_inc(&cpu_buffer->entries);
+	rb_update_write_stamp(cpu_buffer, event);
+	rb_end_commit(cpu_buffer);
+}
 
-	/* make sure this diff is calculated here */
-	barrier();
+static __always_inline void
+rb_wakeups(struct ring_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
+{
+	bool pagebusy;
 
-	/* Did the write stamp get updated already? */
-	if (likely(ts >= cpu_buffer->write_stamp)) {
-		delta = diff;
-		if (unlikely(test_time_stamp(delta))) {
-			int local_clock_stable = 1;
-#ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
-			local_clock_stable = sched_clock_stable();
-#endif
-			WARN_ONCE(delta > (1ULL << 59),
-				  KERN_WARNING "Delta way too big! %llu ts=%llu write stamp = %llu\n%s",
-				  (unsigned long long)delta,
-				  (unsigned long long)ts,
-				  (unsigned long long)cpu_buffer->write_stamp,
-				  local_clock_stable ? "" :
-				  "If you just came from a suspend/resume,\n"
-				  "please switch to the trace global clock:\n"
-				  "  echo global > /sys/kernel/debug/tracing/trace_clock\n");
-			add_timestamp = 1;
-		}
+	if (buffer->irq_work.waiters_pending) {
+		buffer->irq_work.waiters_pending = false;
+		/* irq_work_queue() supplies it's own memory barriers */
+		irq_work_queue(&buffer->irq_work.work);
 	}
 
-	event = __rb_reserve_next(cpu_buffer, length, ts,
-				  delta, add_timestamp);
-	if (unlikely(PTR_ERR(event) == -EAGAIN))
-		goto again;
-
-	if (!event)
-		goto out_fail;
+	if (cpu_buffer->irq_work.waiters_pending) {
+		cpu_buffer->irq_work.waiters_pending = false;
+		/* irq_work_queue() supplies it's own memory barriers */
+		irq_work_queue(&cpu_buffer->irq_work.work);
+	}
 
-	return event;
+	pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
 
- out_fail:
-	rb_end_commit(cpu_buffer);
-	return NULL;
+	if (!pagebusy && cpu_buffer->irq_work.full_waiters_pending) {
+		cpu_buffer->irq_work.wakeup_full = true;
+		cpu_buffer->irq_work.full_waiters_pending = false;
+		/* irq_work_queue() supplies it's own memory barriers */
+		irq_work_queue(&cpu_buffer->irq_work.work);
+	}
 }
 
 /*
@@ -2672,6 +2645,178 @@ trace_recursive_unlock(struct ring_buffer_per_cpu *cpu_buffer)
 }
 
 /**
+ * ring_buffer_unlock_commit - commit a reserved
+ * @buffer: The buffer to commit to
+ * @event: The event pointer to commit.
+ *
+ * This commits the data to the ring buffer, and releases any locks held.
+ *
+ * Must be paired with ring_buffer_lock_reserve.
+ */
+int ring_buffer_unlock_commit(struct ring_buffer *buffer,
+			      struct ring_buffer_event *event)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	int cpu = raw_smp_processor_id();
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	rb_commit(cpu_buffer, event);
+
+	rb_wakeups(buffer, cpu_buffer);
+
+	trace_recursive_unlock(cpu_buffer);
+
+	preempt_enable_notrace();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_unlock_commit);
+
+static noinline void
+rb_handle_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
+		    struct rb_event_info *info)
+{
+	WARN_ONCE(info->delta > (1ULL << 59),
+		  KERN_WARNING "Delta way too big! %llu ts=%llu write stamp = %llu\n%s",
+		  (unsigned long long)info->delta,
+		  (unsigned long long)info->ts,
+		  (unsigned long long)cpu_buffer->write_stamp,
+		  sched_clock_stable() ? "" :
+		  "If you just came from a suspend/resume,\n"
+		  "please switch to the trace global clock:\n"
+		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n");
+	info->add_timestamp = 1;
+}
+
+static struct ring_buffer_event *
+__rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
+		  struct rb_event_info *info)
+{
+	struct ring_buffer_event *event;
+	struct buffer_page *tail_page;
+	unsigned long tail, write;
+
+	/*
+	 * If the time delta since the last event is too big to
+	 * hold in the time field of the event, then we append a
+	 * TIME EXTEND event ahead of the data event.
+	 */
+	if (unlikely(info->add_timestamp))
+		info->length += RB_LEN_TIME_EXTEND;
+
+	tail_page = info->tail_page = cpu_buffer->tail_page;
+	write = local_add_return(info->length, &tail_page->write);
+
+	/* set write to only the index of the write */
+	write &= RB_WRITE_MASK;
+	tail = write - info->length;
+
+	/*
+	 * If this is the first commit on the page, then it has the same
+	 * timestamp as the page itself.
+	 */
+	if (!tail)
+		info->delta = 0;
+
+	/* See if we shot pass the end of this buffer page */
+	if (unlikely(write > BUF_PAGE_SIZE))
+		return rb_move_tail(cpu_buffer, tail, info);
+
+	/* We reserved something on the buffer */
+
+	event = __rb_page_index(tail_page, tail);
+	kmemcheck_annotate_bitfield(event, bitfield);
+	rb_update_event(cpu_buffer, event, info);
+
+	local_inc(&tail_page->entries);
+
+	/*
+	 * If this is the first commit on the page, then update
+	 * its timestamp.
+	 */
+	if (!tail)
+		tail_page->page->time_stamp = info->ts;
+
+	/* account for these added bytes */
+	local_add(info->length, &cpu_buffer->entries_bytes);
+
+	return event;
+}
+
+static struct ring_buffer_event *
+rb_reserve_next_event(struct ring_buffer *buffer,
+		      struct ring_buffer_per_cpu *cpu_buffer,
+		      unsigned long length)
+{
+	struct ring_buffer_event *event;
+	struct rb_event_info info;
+	int nr_loops = 0;
+	u64 diff;
+
+	rb_start_commit(cpu_buffer);
+
+#ifdef CONFIG_RING_BUFFER_ALLOW_SWAP
+	/*
+	 * Due to the ability to swap a cpu buffer from a buffer
+	 * it is possible it was swapped before we committed.
+	 * (committing stops a swap). We check for it here and
+	 * if it happened, we have to fail the write.
+	 */
+	barrier();
+	if (unlikely(ACCESS_ONCE(cpu_buffer->buffer) != buffer)) {
+		local_dec(&cpu_buffer->committing);
+		local_dec(&cpu_buffer->commits);
+		return NULL;
+	}
+#endif
+
+	info.length = rb_calculate_event_length(length);
+ again:
+	info.add_timestamp = 0;
+	info.delta = 0;
+
+	/*
+	 * We allow for interrupts to reenter here and do a trace.
+	 * If one does, it will cause this original code to loop
+	 * back here. Even with heavy interrupts happening, this
+	 * should only happen a few times in a row. If this happens
+	 * 1000 times in a row, there must be either an interrupt
+	 * storm or we have something buggy.
+	 * Bail!
+	 */
+	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 1000))
+		goto out_fail;
+
+	info.ts = rb_time_stamp(cpu_buffer->buffer);
+	diff = info.ts - cpu_buffer->write_stamp;
+
+	/* make sure this diff is calculated here */
+	barrier();
+
+	/* Did the write stamp get updated already? */
+	if (likely(info.ts >= cpu_buffer->write_stamp)) {
+		info.delta = diff;
+		if (unlikely(test_time_stamp(info.delta)))
+			rb_handle_timestamp(cpu_buffer, &info);
+	}
+
+	event = __rb_reserve_next(cpu_buffer, &info);
+
+	if (unlikely(PTR_ERR(event) == -EAGAIN))
+		goto again;
+
+	if (!event)
+		goto out_fail;
+
+	return event;
+
+ out_fail:
+	rb_end_commit(cpu_buffer);
+	return NULL;
+}
+
+/**
  * ring_buffer_lock_reserve - reserve a part of the buffer
  * @buffer: the ring buffer to reserve from
  * @length: the length of the data to reserve (excluding event header)
@@ -2729,111 +2874,6 @@ ring_buffer_lock_reserve(struct ring_buffer *buffer, unsigned long length)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_lock_reserve);
 
-static void
-rb_update_write_stamp(struct ring_buffer_per_cpu *cpu_buffer,
-		      struct ring_buffer_event *event)
-{
-	u64 delta;
-
-	/*
-	 * The event first in the commit queue updates the
-	 * time stamp.
-	 */
-	if (rb_event_is_commit(cpu_buffer, event)) {
-		/*
-		 * A commit event that is first on a page
-		 * updates the write timestamp with the page stamp
-		 */
-		if (!rb_event_index(event))
-			cpu_buffer->write_stamp =
-				cpu_buffer->commit_page->page->time_stamp;
-		else if (event->type_len == RINGBUF_TYPE_TIME_EXTEND) {
-			delta = event->array[0];
-			delta <<= TS_SHIFT;
-			delta += event->time_delta;
-			cpu_buffer->write_stamp += delta;
-		} else
-			cpu_buffer->write_stamp += event->time_delta;
-	}
-}
-
-static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
-		      struct ring_buffer_event *event)
-{
-	local_inc(&cpu_buffer->entries);
-	rb_update_write_stamp(cpu_buffer, event);
-	rb_end_commit(cpu_buffer);
-}
-
-static __always_inline void
-rb_wakeups(struct ring_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
-{
-	bool pagebusy;
-
-	if (buffer->irq_work.waiters_pending) {
-		buffer->irq_work.waiters_pending = false;
-		/* irq_work_queue() supplies it's own memory barriers */
-		irq_work_queue(&buffer->irq_work.work);
-	}
-
-	if (cpu_buffer->irq_work.waiters_pending) {
-		cpu_buffer->irq_work.waiters_pending = false;
-		/* irq_work_queue() supplies it's own memory barriers */
-		irq_work_queue(&cpu_buffer->irq_work.work);
-	}
-
-	pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
-
-	if (!pagebusy && cpu_buffer->irq_work.full_waiters_pending) {
-		cpu_buffer->irq_work.wakeup_full = true;
-		cpu_buffer->irq_work.full_waiters_pending = false;
-		/* irq_work_queue() supplies it's own memory barriers */
-		irq_work_queue(&cpu_buffer->irq_work.work);
-	}
-}
-
-/**
- * ring_buffer_unlock_commit - commit a reserved
- * @buffer: The buffer to commit to
- * @event: The event pointer to commit.
- *
- * This commits the data to the ring buffer, and releases any locks held.
- *
- * Must be paired with ring_buffer_lock_reserve.
- */
-int ring_buffer_unlock_commit(struct ring_buffer *buffer,
-			      struct ring_buffer_event *event)
-{
-	struct ring_buffer_per_cpu *cpu_buffer;
-	int cpu = raw_smp_processor_id();
-
-	cpu_buffer = buffer->buffers[cpu];
-
-	rb_commit(cpu_buffer, event);
-
-	rb_wakeups(buffer, cpu_buffer);
-
-	trace_recursive_unlock(cpu_buffer);
-
-	preempt_enable_notrace();
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ring_buffer_unlock_commit);
-
-static inline void rb_event_discard(struct ring_buffer_event *event)
-{
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
-		event = skip_time_extend(event);
-
-	/* array[0] holds the actual length for the discarded event */
-	event->array[0] = rb_event_data_length(event) - RB_EVNT_HDR_SIZE;
-	event->type_len = RINGBUF_TYPE_PADDING;
-	/* time delta must be non zero */
-	if (!event->time_delta)
-		event->time_delta = 1;
-}
-
 /*
  * Decrement the entries to the page that an event is on.
  * The event does not even need to exist, only the pointer
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index abcbf7ff8743..6e79408674aa 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3035,7 +3035,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	if (!iter)
 		return ERR_PTR(-ENOMEM);
 
-	iter->buffer_iter = kzalloc(sizeof(*iter->buffer_iter) * num_possible_cpus(),
+	iter->buffer_iter = kcalloc(nr_cpu_ids, sizeof(*iter->buffer_iter),
 				    GFP_KERNEL);
 	if (!iter->buffer_iter)
 		goto release;
@@ -6990,7 +6990,7 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 	trace_init_global_iter(&iter);
 
 	for_each_tracing_cpu(cpu) {
-		atomic_inc(&per_cpu_ptr(iter.tr->trace_buffer.data, cpu)->disabled);
+		atomic_inc(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
 	}
 
 	old_userobj = trace_flags & TRACE_ITER_SYM_USEROBJ;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 404a372ad85a..7ca09cdc20c2 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -30,6 +30,7 @@
 DEFINE_MUTEX(event_mutex);
 
 LIST_HEAD(ftrace_events);
+static LIST_HEAD(ftrace_generic_fields);
 static LIST_HEAD(ftrace_common_fields);
 
 #define GFP_TRACE (GFP_KERNEL | __GFP_ZERO)
@@ -94,6 +95,10 @@ trace_find_event_field(struct trace_event_call *call, char *name)
 	struct ftrace_event_field *field;
 	struct list_head *head;
 
+	field = __find_event_field(&ftrace_generic_fields, name);
+	if (field)
+		return field;
+
 	field = __find_event_field(&ftrace_common_fields, name);
 	if (field)
 		return field;
@@ -144,6 +149,13 @@ int trace_define_field(struct trace_event_call *call, const char *type,
 }
 EXPORT_SYMBOL_GPL(trace_define_field);
 
+#define __generic_field(type, item, filter_type)			\
+	ret = __trace_define_field(&ftrace_generic_fields, #type,	\
+				   #item, 0, 0, is_signed_type(type),	\
+				   filter_type);			\
+	if (ret)							\
+		return ret;
+
 #define __common_field(type, item)					\
 	ret = __trace_define_field(&ftrace_common_fields, #type,	\
 				   "common_" #item,			\
@@ -153,6 +165,16 @@ EXPORT_SYMBOL_GPL(trace_define_field);
 	if (ret)							\
 		return ret;
 
+static int trace_define_generic_fields(void)
+{
+	int ret;
+
+	__generic_field(int, cpu, FILTER_OTHER);
+	__generic_field(char *, comm, FILTER_PTR_STRING);
+
+	return ret;
+}
+
 static int trace_define_common_fields(void)
 {
 	int ret;
@@ -2671,6 +2693,9 @@ static __init int event_trace_init(void)
 	if (!entry)
 		pr_warn("Could not create tracefs 'available_events' entry\n");
 
+	if (trace_define_generic_fields())
+		pr_warn("tracing: Failed to allocated generic fields");
+
 	if (trace_define_common_fields())
 		pr_warn("tracing: Failed to allocate common fields");
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index d81d6f302b14..bd1bf184c5c9 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -252,6 +252,50 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
 	return match;
 }
 
+/* Filter predicate for CPUs. */
+static int filter_pred_cpu(struct filter_pred *pred, void *event)
+{
+	int cpu, cmp;
+	int match = 0;
+
+	cpu = raw_smp_processor_id();
+	cmp = pred->val;
+
+	switch (pred->op) {
+	case OP_EQ:
+		match = cpu == cmp;
+		break;
+	case OP_LT:
+		match = cpu < cmp;
+		break;
+	case OP_LE:
+		match = cpu <= cmp;
+		break;
+	case OP_GT:
+		match = cpu > cmp;
+		break;
+	case OP_GE:
+		match = cpu >= cmp;
+		break;
+	default:
+		break;
+	}
+
+	return !!match == !pred->not;
+}
+
+/* Filter predicate for COMM. */
+static int filter_pred_comm(struct filter_pred *pred, void *event)
+{
+	int cmp, match;
+
+	cmp = pred->regex.match(current->comm, &pred->regex,
+				pred->regex.field_len);
+	match = cmp ^ pred->not;
+
+	return match;
+}
+
 static int filter_pred_none(struct filter_pred *pred, void *event)
 {
 	return 0;
@@ -1002,7 +1046,10 @@ static int init_pred(struct filter_parse_state *ps,
 	if (is_string_field(field)) {
 		filter_build_regex(pred);
 
-		if (field->filter_type == FILTER_STATIC_STRING) {
+		if (!strcmp(field->name, "comm")) {
+			fn = filter_pred_comm;
+			pred->regex.field_len = TASK_COMM_LEN;
+		} else if (field->filter_type == FILTER_STATIC_STRING) {
 			fn = filter_pred_string;
 			pred->regex.field_len = field->size;
 		} else if (field->filter_type == FILTER_DYN_STRING)
@@ -1025,7 +1072,10 @@ static int init_pred(struct filter_parse_state *ps,
 		}
 		pred->val = val;
 
-		fn = select_comparison_fn(pred->op, field->size,
+		if (!strcmp(field->name, "cpu"))
+			fn = filter_pred_cpu;
+		else
+			fn = select_comparison_fn(pred->op, field->size,
 					  field->is_signed);
 		if (!fn) {
 			parse_error(ps, FILT_ERR_INVALID_OP, 0);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 8968bf720c12..ca98445782ac 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -715,13 +715,13 @@ trace_print_graph_duration(unsigned long long duration, struct trace_seq *s)
 
 		snprintf(nsecs_str, slen, "%03lu", nsecs_rem);
 		trace_seq_printf(s, ".%s", nsecs_str);
-		len += strlen(nsecs_str);
+		len += strlen(nsecs_str) + 1;
 	}
 
 	trace_seq_puts(s, " us ");
 
 	/* Print remaining spaces to fit the row's width */
-	for (i = len; i < 7; i++)
+	for (i = len; i < 8; i++)
 		trace_seq_putc(s, ' ');
 }
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index dfab253727dc..8e481a84aeea 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -496,6 +496,8 @@ static const struct trace_mark {
 	char			sym;
 } mark[] = {
 	MARK(1000000000ULL	, '$'), /* 1 sec */
+	MARK(100000000ULL	, '@'), /* 100 msec */
+	MARK(10000000ULL	, '*'), /* 10 msec */
 	MARK(1000000ULL		, '#'), /* 1000 usecs */
 	MARK(100000ULL		, '!'), /* 100 usecs */
 	MARK(10000ULL		, '+'), /* 10 usecs */
@@ -508,7 +510,7 @@ char trace_find_mark(unsigned long long d)
 	int size = ARRAY_SIZE(mark);
 
 	for (i = 0; i < size; i++) {
-		if (d >= mark[i].val)
+		if (d > mark[i].val)
 			break;
 	}
 
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 3f34496244e9..b746399ab59c 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -18,12 +18,6 @@
 
 #define STACK_TRACE_ENTRIES 500
 
-#ifdef CC_USING_FENTRY
-# define fentry		1
-#else
-# define fentry		0
-#endif
-
 static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
 	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
 static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
@@ -35,7 +29,7 @@ static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
  */
 static struct stack_trace max_stack_trace = {
 	.max_entries		= STACK_TRACE_ENTRIES - 1,
-	.entries		= &stack_dump_trace[1],
+	.entries		= &stack_dump_trace[0],
 };
 
 static unsigned long max_stack_size;
@@ -55,7 +49,7 @@ static inline void print_max_stack(void)
 
 	pr_emerg("        Depth    Size   Location    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   max_stack_trace.nr_entries - 1);
+			   max_stack_trace.nr_entries);
 
 	for (i = 0; i < max_stack_trace.nr_entries; i++) {
 		if (stack_dump_trace[i] == ULONG_MAX)
@@ -77,7 +71,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 	unsigned long this_size, flags; unsigned long *p, *top, *start;
 	static int tracer_frame;
 	int frame_size = ACCESS_ONCE(tracer_frame);
-	int i;
+	int i, x;
 
 	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
 	this_size = THREAD_SIZE - this_size;
@@ -105,26 +99,20 @@ check_stack(unsigned long ip, unsigned long *stack)
 	max_stack_size = this_size;
 
 	max_stack_trace.nr_entries = 0;
-
-	if (using_ftrace_ops_list_func())
-		max_stack_trace.skip = 4;
-	else
-		max_stack_trace.skip = 3;
+	max_stack_trace.skip = 3;
 
 	save_stack_trace(&max_stack_trace);
 
-	/*
-	 * Add the passed in ip from the function tracer.
-	 * Searching for this on the stack will skip over
-	 * most of the overhead from the stack tracer itself.
-	 */
-	stack_dump_trace[0] = ip;
-	max_stack_trace.nr_entries++;
+	/* Skip over the overhead of the stack tracer itself */
+	for (i = 0; i < max_stack_trace.nr_entries; i++) {
+		if (stack_dump_trace[i] == ip)
+			break;
+	}
 
 	/*
 	 * Now find where in the stack these are.
 	 */
-	i = 0;
+	x = 0;
 	start = stack;
 	top = (unsigned long *)
 		(((unsigned long)start & ~(THREAD_SIZE-1)) + THREAD_SIZE);
@@ -139,12 +127,15 @@ check_stack(unsigned long ip, unsigned long *stack)
 	while (i < max_stack_trace.nr_entries) {
 		int found = 0;
 
-		stack_dump_index[i] = this_size;
+		stack_dump_index[x] = this_size;
 		p = start;
 
 		for (; p < top && i < max_stack_trace.nr_entries; p++) {
+			if (stack_dump_trace[i] == ULONG_MAX)
+				break;
 			if (*p == stack_dump_trace[i]) {
-				this_size = stack_dump_index[i++] =
+				stack_dump_trace[x] = stack_dump_trace[i++];
+				this_size = stack_dump_index[x++] =
 					(top - p) * sizeof(unsigned long);
 				found = 1;
 				/* Start the search from here */
@@ -156,7 +147,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 				 * out what that is, then figure it out
 				 * now.
 				 */
-				if (unlikely(!tracer_frame) && i == 1) {
+				if (unlikely(!tracer_frame)) {
 					tracer_frame = (p - stack) *
 						sizeof(unsigned long);
 					max_stack_size -= tracer_frame;
@@ -168,6 +159,10 @@ check_stack(unsigned long ip, unsigned long *stack)
 			i++;
 	}
 
+	max_stack_trace.nr_entries = x;
+	for (; x < i; x++)
+		stack_dump_trace[x] = ULONG_MAX;
+
 	if (task_stack_end_corrupted(current)) {
 		print_max_stack();
 		BUG();
@@ -192,24 +187,7 @@ stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (per_cpu(trace_active, cpu)++ != 0)
 		goto out;
 
-	/*
-	 * When fentry is used, the traced function does not get
-	 * its stack frame set up, and we lose the parent.
-	 * The ip is pretty useless because the function tracer
-	 * was called before that function set up its stack frame.
-	 * In this case, we use the parent ip.
-	 *
-	 * By adding the return address of either the parent ip
-	 * or the current ip we can disregard most of the stack usage
-	 * caused by the stack tracer itself.
-	 *
-	 * The function tracer always reports the address of where the
-	 * mcount call was, but the stack will hold the return address.
-	 */
-	if (fentry)
-		ip = parent_ip;
-	else
-		ip += MCOUNT_INSN_SIZE;
+	ip += MCOUNT_INSN_SIZE;
 
 	check_stack(ip, &stack);
 
@@ -284,7 +262,7 @@ __next(struct seq_file *m, loff_t *pos)
 {
 	long n = *pos - 1;
 
-	if (n >= max_stack_trace.nr_entries || stack_dump_trace[n] == ULONG_MAX)
+	if (n > max_stack_trace.nr_entries || stack_dump_trace[n] == ULONG_MAX)
 		return NULL;
 
 	m->private = (void *)n;
@@ -354,7 +332,7 @@ static int t_show(struct seq_file *m, void *v)
 		seq_printf(m, "        Depth    Size   Location"
 			   "    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   max_stack_trace.nr_entries - 1);
+			   max_stack_trace.nr_entries);
 
 		if (!stack_tracer_enabled && !max_stack_size)
 			print_disabled(m);
