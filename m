Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4423A1A0193
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 01:08:16 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 07:08:13 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6A0743E40048
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 07:08:10 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u19E8AYk22872180
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 07:08:10 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u19E89dh004433
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 07:08:10 -0700
Received: from oc5780617838.ibm.com ([9.80.84.27])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u19E77FC029067
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 07:07:08 -0700
Subject: Re: powerpc/xmon: Add xmon command to dump process/task similar to
 ps(1)
To: linuxppc-dev@lists.ozlabs.org
References: <20160209105824.9231E140B97@ozlabs.org>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Message-ID: <56B9F28B.7060607@linux.vnet.ibm.com>
Date: Tue, 9 Feb 2016 08:07:07 -0600
MIME-Version: 1.0
In-Reply-To: <20160209105824.9231E140B97@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

That looks fine to me.

Thanks!


On 02/09/2016 04:58 AM, Michael Ellerman wrote:
> On Mon, 2015-23-11 at 15:01:15 UTC, Douglas Miller wrote:
>> Add 'P' command with optional task_struct address to dump all/one task's
>> information: task pointer, kernel stack pointer, PID, PPID, state
>> (interpreted), CPU where (last) running, and command.
>>
>> Introduce XMON_PROTECT macro to standardize memory-access-fault
>> protection (setjmp). Initially used only by the 'P' command.
> Hi Doug,
>
> Sorry this has taken a while, it keeps getting preempted by more important
> patches.
>
> I'm also not a big fan of the protect macro, it works for this case, but it's
> already a bit ugly calling for_each_process() inside the macro, and it would be
> even worse for multi line logic.
>
> I think I'd rather just open code it, and hopefully we can come up with a
> better solution for catching errors in the long run.
>
> I also renamed the routines to use "task", because "proc" in xmon is already
> used to mean "procedure", and the struct is task_struct after all.
>
> How does this look?
>
> cheers
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 47e195d66a9a..942796fa4767 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -163,6 +163,7 @@ static int  cpu_cmd(void);
>   static void csum(void);
>   static void bootcmds(void);
>   static void proccall(void);
> +static void show_tasks(void);
>   void dump_segments(void);
>   static void symbol_lookup(void);
>   static void xmon_show_stack(unsigned long sp, unsigned long lr,
> @@ -238,6 +239,7 @@ Commands:\n\
>     mz	zero a block of memory\n\
>     mi	show information about memory allocation\n\
>     p 	call a procedure\n\
> +  P 	list processes/tasks\n\
>     r	print registers\n\
>     s	single step\n"
>   #ifdef CONFIG_SPU_BASE
> @@ -967,6 +969,9 @@ cmds(struct pt_regs *excp)
>   		case 'p':
>   			proccall();
>   			break;
> +		case 'P':
> +			show_tasks();
> +			break;
>   #ifdef CONFIG_PPC_STD_MMU
>   		case 'u':
>   			dump_segments();
> @@ -2566,6 +2571,61 @@ memzcan(void)
>   		printf("%.8x\n", a - mskip);
>   }
>   
> +static void show_task(struct task_struct *tsk)
> +{
> +	char state;
> +
> +	/*
> +	 * Cloned from kdb_task_state_char(), which is not entirely
> +	 * appropriate for calling from xmon. This could be moved
> +	 * to a common, generic, routine used by both.
> +	 */
> +	state = (tsk->state == 0) ? 'R' :
> +		(tsk->state < 0) ? 'U' :
> +		(tsk->state & TASK_UNINTERRUPTIBLE) ? 'D' :
> +		(tsk->state & TASK_STOPPED) ? 'T' :
> +		(tsk->state & TASK_TRACED) ? 'C' :
> +		(tsk->exit_state & EXIT_ZOMBIE) ? 'Z' :
> +		(tsk->exit_state & EXIT_DEAD) ? 'E' :
> +		(tsk->state & TASK_INTERRUPTIBLE) ? 'S' : '?';
> +
> +	printf("%p %016lx %6d %6d %c %2d %s\n", tsk,
> +		tsk->thread.ksp,
> +		tsk->pid, tsk->parent->pid,
> +		state, task_thread_info(tsk)->cpu,
> +		tsk->comm);
> +}
> +
> +static void show_tasks(void)
> +{
> +	unsigned long tskv;
> +	struct task_struct *tsk = NULL;
> +
> +	printf("     task_struct     ->thread.ksp    PID   PPID S  P CMD\n");
> +
> +	if (scanhex(&tskv))
> +		tsk = (struct task_struct *)tskv;
> +
> +	if (setjmp(bus_error_jmp) != 0) {
> +		catch_memory_errors = 0;
> +		printf("*** Error dumping task %p\n", tsk);
> +		return;
> +	}
> +
> +	catch_memory_errors = 1;
> +	sync();
> +
> +	if (tsk)
> +		show_task(tsk);
> +	else
> +		for_each_process(tsk)
> +			show_task(tsk);
> +
> +	sync();
> +	__delay(200);
> +	catch_memory_errors = 0;
> +}
> +
>   static void proccall(void)
>   {
>   	unsigned long args[8];
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
