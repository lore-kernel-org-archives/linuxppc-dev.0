Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29BFC1A06AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 18:22:06 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F33461402B3
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2015 18:22:05 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 16 Nov 2015 17:22:05 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 55D8E2BB0057
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2015 18:22:02 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAG7LsIF40566908
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2015 18:22:02 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAG7LTYU017064
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2015 18:21:30 +1100
Message-ID: <564983E6.6000307@linux.vnet.ibm.com>
Date: Mon, 16 Nov 2015 12:51:10 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au,
 benh@kernel.crashing.org
CC: linuxppc-dev@ozlabs.org, paulus@samba.org, sam.bobroff@au1.ibm.com
Subject: Re: [PATCH 4/5] powerpc/tm: Check for already reclaimed tasks
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
 <1447390652-28355-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1447390652-28355-4-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/13/2015 10:27 AM, Michael Neuling wrote:
> Currently we can hit a scenario where we'll tm_reclaim() twice.  This
> results in a TM bad thing exception because the second reclaim occurs
> when not in suspend mode.
> 
> The scenario in which this can happen is the following.  We attempt to
> deliver a signal to userspace.  To do this we need obtain the stack
> pointer to write the signal context.  To get this stack pointer we
> must tm_reclaim() in case we need to use the checkpointed stack
> pointer (see get_tm_stackpointer()).  Normally we'd then return
> directly to userspace to deliver the signal without going through
> __switch_to().
> 
> Unfortunatley, if at this point we get an error (such as a bad
> userspace stack pointer), we need to exit the process.  The exit will
> result in a __switch_to().  __switch_to() will attempt to save the
> process state which results in another tm_reclaim().  This
> tm_reclaim() now causes a TM Bad Thing exception as this state has
> already been saved and the processor is no longer in TM suspend mode.
> Whee!
> 
> This patch checks the state of the MSR to ensure we are TM suspended
> before we attempt the tm_reclaim().  If we've already saved the state
> away, we should no longer be in TM suspend mode.  This has the
> additional advantage of checking for a potential TM Bad Thing
> exception.

Can this situation be created using a test and verified that with
this new change, the kernel can handle it successfully. I guess
the self test in the series does not cover this scenario.

> 
> Found using syscall fuzzer.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/powerpc/kernel/process.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 5fbe5d8..a1b41d1 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -551,6 +551,25 @@ static void tm_reclaim_thread(struct thread_struct *thr,
>  		msr_diff &= MSR_FP | MSR_VEC | MSR_VSX | MSR_FE0 | MSR_FE1;
>  	}
>  
> +	/*
> +	 * Use the current MSR TM suspended bit to track if we have
> +	 * checkpointed state outstanding.
> +	 * On signal delivery, we'd normally reclaim the checkpointed
> +	 * state to obtain stack pointer (see:get_tm_stackpointer()).
> +	 * This will then directly return to userspace without going
> +	 * through __switch_to(). However, if the stack frame is bad,
> +	 * we need to exit this thread which calls __switch_to() which
> +	 * will again attempt to reclaim the already saved tm state.
> +	 * Hence we need to check that we've not already reclaimed
> +	 * this state.
> +	 * We do this using the current MSR, rather tracking it in
> +	 * some specific bit thread_struct bit, as it has the

There is one extra "bit" here ^^^^^.
