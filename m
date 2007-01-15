Return-Path: <maynardj@us.ibm.com>
Message-ID: <45ABE250.6030506@us.ibm.com>
Date: Mon, 15 Jan 2007 14:21:36 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] Cell SPU task notification
References: <45A805A0.2080000@us.ibm.com>
	<1168826871.4622.32.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1168826871.4622.32.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael,
Thanks for your comments!  My responses are below.

-Maynard

Michael Ellerman wrote:

>>Subject: Enable SPU switch notification to detect currently active SPU tasks.
>>
>>From: Maynard Johnson <maynardj@us.ibm.com>
>>
>>This patch adds to the capability of spu_switch_event_register so that the
>>caller is also notified of currently active SPU tasks.  It also exports
>>spu_switch_event_register and spu_switch_event_unregister.
> 
> 
> Hi Maynard,
> 
> It'd be really good if you could convince your mailer to send patches inline :)
Mozilla Mail is my client, and I don't see any option to force patches 
inline.  Of course, there is an option to display received attachments 
as inline, but that doesn't help you.
> 
> 
>>Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c
>>===================================================================
>>--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs/sched.c	2006-12-04 10:56:04.730698720 -0600
>>+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c	2007-01-11 09:45:37.918333128 -0600
>>@@ -46,6 +46,8 @@
>> 
>> #define SPU_MIN_TIMESLICE 	(100 * HZ / 1000)
>> 
>>+int notify_active[MAX_NUMNODES];
DOH!  Right, this is patently wrong.  Somehow, I misunderstood what 
MAX_NUMNODES was.  I'll fix it.
> 
> 
> You're basing the size of the array on MAX_NUMNODES
> (1 << CONFIG_NODES_SHIFT), but then indexing it by spu->number.
> 
> It's quite possible we'll have a system with MAX_NUMNODES == 1, but > 1
> spus, in which case this code is going to break. The PS3 is one such
> system.
> 
> Instead I think you should have a flag in the spu struct.
Yes, that's certainly an option I'll look at.
> 
> 
>> #define SPU_BITMAP_SIZE (((MAX_PRIO+BITS_PER_LONG)/BITS_PER_LONG)+1)
>> struct spu_prio_array {
>> 	unsigned long bitmap[SPU_BITMAP_SIZE];
>>@@ -81,18 +83,45 @@
>> static void spu_switch_notify(struct spu *spu, struct spu_context *ctx)
>> {
>> 	blocking_notifier_call_chain(&spu_switch_notifier,
>>-			    ctx ? ctx->object_id : 0, spu);
>>+				     ctx ? ctx->object_id : 0, spu);
>>+}
> 
> 
> Try not to make whitespace only changes in the same patch as actual code changes.
> 
> 
>>+
>>+static void notify_spus_active(void)
>>+{
>>+	int node;
>>+	/* Wake up the active spu_contexts. When the awakened processes 
>>+	 * sees their notify_active flag is set, they will call
>>+	 * spu_notify_already_active().
>>+	 */
>>+	for (node = 0; node < MAX_NUMNODES; node++) {
>>+		struct spu *spu;
>>+		mutex_lock(&spu_prio->active_mutex[node]);
>>+                list_for_each_entry(spu, &spu_prio->active_list[node], list) {
>>+			struct spu_context *ctx = spu->ctx;
>>+			wake_up_all(&ctx->stop_wq);
>>+			notify_active[ctx->spu->number] = 1;
>>+			smp_mb();
>>+		}
> 
> 
> I don't understand why you're setting the notify flag after you do the
> wake_up_all() ?
Right, I'll move it.
> 
> You only need a smp_wmb() here.
OK.
> 
> Does the scheduler guarantee that ctxs won't swap nodes? Otherwise
Don't know.  Arnd would probably know off the top of his head.
> between releasing the lock on one node and getting the lock on the next,
> a ctx could migrate between them - which would cause either spurious
> wake ups, or missing a ctx altogether. Although I'm not sure if it's
> that important.
How important is it?  If the SPUs were executing different code or 
taking different paths through the same code, then seeing the samples 
for each SPU is important.  But if this were the case, the user would 
easily see the misssing data for the missing SPU(s).  Since this sounds 
like a very small window, re-running the profile would _probably_ yield 
a complete profile.  On the other hand, if we can avoid it, we should. 
When I repost the fixed-up patch, I'll add a comment/question for Arnd 
about this issue.
> 
> 
>>+                mutex_unlock(&spu_prio->active_mutex[node]);
>>+	}
>>+	yield();
>> }
>> 
>> int spu_switch_event_register(struct notifier_block * n)
>> {
>>-	return blocking_notifier_chain_register(&spu_switch_notifier, n);
>>+	int ret;
>>+	ret = blocking_notifier_chain_register(&spu_switch_notifier, n);
>>+	if (!ret)
>>+		notify_spus_active();
>>+	return ret;
>> }
>>+EXPORT_SYMBOL_GPL(spu_switch_event_register);
>> 
>> int spu_switch_event_unregister(struct notifier_block * n)
>> {
>> 	return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
>> }
>>+EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
>> 
>> 
>> static inline void bind_context(struct spu *spu, struct spu_context *ctx)
>>@@ -250,6 +279,14 @@
>> 	return spu_get_idle(ctx, flags);
>> }
>> 
>>+void spu_notify_already_active(struct spu_context *ctx)
>>+{
>>+	struct spu *spu = ctx->spu;
>>+	if (!spu)
>>+		return;
>>+	spu_switch_notify(spu, ctx);
>>+}
>>+
>> /* The three externally callable interfaces
>>  * for the scheduler begin here.
>>  *
>>Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/spufs.h
>>===================================================================
>>--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs/spufs.h	2007-01-08 18:18:40.093354608 -0600
>>+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/spufs.h	2007-01-08 18:31:03.610345792 -0600
>>@@ -183,6 +183,7 @@
>> void spu_yield(struct spu_context *ctx);
>> int __init spu_sched_init(void);
>> void __exit spu_sched_exit(void);
>>+void spu_notify_already_active(struct spu_context *ctx);
>> 
>> extern char *isolated_loader;
>> 
>>Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/run.c
>>===================================================================
>>--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs/run.c	2007-01-08 18:33:51.979311680 -0600
>>+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/run.c	2007-01-11 10:17:20.777344984 -0600
>>@@ -10,6 +10,8 @@
>> 
>> #include "spufs.h"
>> 
>>+extern int notify_active[MAX_NUMNODES];
>>+
>> /* interrupt-level stop callback function. */
>> void spufs_stop_callback(struct spu *spu)
>> {
>>@@ -45,7 +47,9 @@
>> 	u64 pte_fault;
>> 
>> 	*stat = ctx->ops->status_read(ctx);
>>-	if (ctx->state != SPU_STATE_RUNNABLE)
>>+	smp_mb();
> 
> 
> And smp_rmb() should be sufficient here.
OK
> 
> 
>>+	if (ctx->state != SPU_STATE_RUNNABLE || notify_active[ctx->spu->number])
>> 		return 1;
>> 	spu = ctx->spu;
>> 	pte_fault = spu->dsisr &
>>@@ -319,6 +323,11 @@
>> 		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, &status));
>> 		if (unlikely(ret))
>> 			break;
>>+		if (unlikely(notify_active[ctx->spu->number])) {
>>+			notify_active[ctx->spu->number] = 0;
>>+			if (!(status & SPU_STATUS_STOPPED_BY_STOP))
>>+				spu_notify_already_active(ctx);
>>+		}
>> 		if ((status & SPU_STATUS_STOPPED_BY_STOP) &&
>> 		    (status >> SPU_STOP_STATUS_SHIFT == 0x2104)) {
>> 			ret = spu_process_callback(ctx);
> 
> 
> cheers
> 
