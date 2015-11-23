Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54F691A0271
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 11:28:44 +1100 (AEDT)
Message-ID: <1448238524.18775.5.camel@ellerman.id.au>
Subject: Re: [PATCH] Add xmon command to dump process/task similar to ps(1)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 23 Nov 2015 11:28:44 +1100
In-Reply-To: <1447936318-18487-2-git-send-email-dougmill@linux.vnet.ibm.com>
References: <1447936318-18487-1-git-send-email-dougmill@linux.vnet.ibm.com>
 <1447936318-18487-2-git-send-email-dougmill@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Doug,

Your subject should be something more like:

"powerpc/xmon: Add command to dump process/task similar to ps(1)"

On Thu, 2015-11-19 at 06:31 -0600, Douglas Miller wrote:
>

And you need to write a change log. It doesn't have to be an opus, but there
should be something here.

eg. Where did you get the mapping of the state to the letters, and does it
match the generic code?

> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 13c6e20..5c24f55 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -2450,6 +2473,41 @@ memzcan(void)
>  		printf("%.8x\n", a - mskip);
>  }
>  
> +static void procshow(struct task_struct *tsk)
> +{
> +	char state;
> +
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
> +static void proclist(void)
> +{
> +	unsigned long tskv;
> +	struct task_struct *tsk;
> +
> +	if (scanhex(&tskv)) {
> +		tsk = (struct task_struct *)tskv;
> +		XMON_PROTECT(procshow(tsk), "*** Error dumping task %p\n", tsk);
> +	} else {
> +		for_each_process(tsk) {
> +			XMON_PROTECT(procshow(tsk), "*** Error dumping task %p\n", tsk);
> +		}

You should be wrapping the for_each_process() loop in the PROTECT macro as well
as the call to procshow(). There are pointer dereferences in the for each macro
that could fault if you have a corrupted task list.

cheers
