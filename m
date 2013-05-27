Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7836E2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 16:45:18 +1000 (EST)
Message-ID: <51A300F4.80103@windriver.com>
Date: Mon, 27 May 2013 14:45:08 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: Re: [PATCH] powerpc/32bit, PREEMPT:Load TI_FLAGS to check NEED_RESCHED
References: <1369636076-2644-1-git-send-email-Priyanka.Jain@freescale.com>
In-Reply-To: <1369636076-2644-1-git-send-email-Priyanka.Jain@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/27/2013 02:27 PM, Priyanka Jain wrote:
> Add instruction to load TI_FLAGS in r8
>
> While returning from exception handling in case of PREEMPT enabled,
> _TIF_NEED_RESCHED bit is checked in TI_FLAGS (thread_info flag) of current
> task. Only if this bit is set, it should continue with the process of
> calling preempt_schedule_irq() to schedule highest priority task if
> available.
>
> Current code assumes that r8 contains TI_FLAGS and check this for
> _TIF_NEED_RESCHED, but as r8 is modified in the code which executes before

Could you elaborate this scenario? As I take a look at this path:

	...
         /* Clear _TIF_EMULATE_STACK_STORE flag */
         lis     r11,_TIF_EMULATE_STACK_STORE@h
         addi    r5,r9,TI_FLAGS
0:      lwarx   r8,0,r5
         andc    r8,r8,r11
#ifdef CONFIG_IBM405_ERR77
         dcbt    0,r5
#endif
         stwcx.  r8,0,r5
         bne-    0b
1:

#ifdef CONFIG_PREEMPT
         /* check current_thread_info->preempt_count */
         lwz     r0,TI_PREEMPT(r9)
         cmpwi   0,r0,0          /* if non-zero, just restore regs and return */
         bne     restore
         andi.   r8,r8,_TIF_NEED_RESCHED
	...

Where is R8 clobbered?

Tiejun

> this check, r8 no longer contains the expected TI_FLAGS information.
>
> As a result check for comparison with _TIF_NEED_RESCHED was failing even if
> NEED_RESCHED bit is set in the current thread_info flag. Due to this,
> preempt_schedule_irq() and in turn scheduler was not getting called even if
> highest priority task is ready for execution.
>
>
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> ---
>   arch/powerpc/kernel/entry_32.S |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index d22e73e..0239c7f 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -887,6 +887,7 @@ resume_kernel:
>   #ifdef CONFIG_PREEMPT
>   	/* check current_thread_info->preempt_count */
>   	lwz	r0,TI_PREEMPT(r9)
> +	lwz	r8,TI_FLAGS(r9)
>   	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
>   	bne	restore
>   	andi.	r8,r8,_TIF_NEED_RESCHED
>
