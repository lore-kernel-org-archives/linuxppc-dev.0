Return-Path: <maynardj@us.ibm.com>
Message-ID: <45BF64DC.7040506@us.ibm.com>
Date: Tue, 30 Jan 2007 09:31:40 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 3/4] Add support to OProfile for profiling
	Cell BE SPUs -- update
References: <45BE4ED0.5030808@us.ibm.com> <45BE4F78.6080705@us.ibm.com>
	<200701300524.32556.arnd@arndb.de>
In-Reply-To: <200701300524.32556.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> On Monday 29 January 2007 20:48, Maynard Johnson wrote:
> 
>>Subject: Enable SPU switch notification to detect currently active SPU tasks.
>>
>>From: Maynard Johnson <maynardj@us.ibm.com>
>>
>>This patch adds to the capability of spu_switch_event_register so that the
>>caller is also notified of currently active SPU tasks.  It also exports
>>spu_switch_event_register and spu_switch_event_unregister.
>>
>>Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
> 
> 
> I looked through it again, and think I found a serious bug, but that
> should be easy enough to solve:
> 
> 
>>+static void notify_spus_active(void)
>>+{
>>+       int node;
>>+       /* Wake up the active spu_contexts. When the awakened processes 
>>+        * sees their notify_active flag is set, they will call
>>+        * spu_switch_notify();
>>+        */
>>+       for (node = 0; node < MAX_NUMNODES; node++) {
>>+               struct spu *spu;
>>+               mutex_lock(&spu_prio->active_mutex[node]);
>>+                list_for_each_entry(spu, &spu_prio->active_list[node], list) {
>>+                       struct spu_context *ctx = spu->ctx;
> 
> 
> [side note]
> There is a small whitespace breakage in here, please make sure you always
> use tabs for indenting, not space characters.
> [/side note]
> 
> 
>>@@ -45,9 +45,10 @@
>>        u64 pte_fault;
>> 
>>        *stat = ctx->ops->status_read(ctx);
>>-       if (ctx->state != SPU_STATE_RUNNABLE)
>>-               return 1;
>>+
>>        spu = ctx->spu;
>>+       if (ctx->state != SPU_STATE_RUNNABLE || spu->notify_active)
>>+               return 1;
>>        pte_fault = spu->dsisr &
>>            (MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED);
>>        return (!(*stat & 0x1) || pte_fault || spu->class_0_pending) ? 1 : 0;
>>@@ -305,6 +306,7 @@
>>                   u32 *npc, u32 *event)
>> {
>>        int ret;
>>+       struct spu * spu;
>>        u32 status;
>> 
>>        if (down_interruptible(&ctx->run_sema))
>>@@ -318,8 +320,16 @@
>> 
>>        do {
>>                ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, &status));
>>+               spu = ctx->spu;
>>                if (unlikely(ret))
>>                        break;
>>+               if (unlikely(spu->notify_active)) {
>>+                       spu->notify_active = 0;
>>+                       if (!(status & SPU_STATUS_STOPPED_BY_STOP)) {
>>+                               spu_switch_notify(spu, ctx);
>>+                               continue;
>>+                       }
>>+               }
> 
> 
> This is before spu_reacquire_runnable, so in case the spu got
> preempted at the same time when oprofile was enabled, ctx->spu
> is NULL, and you can't load the notify_active flag from it.
> 
> On solution would be to move the notify_active flag from ctx->spu
> into ctx itself, but maybe there are other ways to solve this.
In an earlier review of this patch, Christopher Hellwig suggested I move 
the notify_active flag to be a bit in the sched_flags field that's added 
in his scheduler patch series.  If this patch series will be a available 
in an "Arnd" tree that we'll be using for our current OProfile 
development, perhaps I should wait until that time to change this, since 
the window of vulnerability is quite small.  What do you think?

-Maynard
> 
> Thanks,
> 
> 	Arnd <><
