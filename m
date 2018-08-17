Return-Path: <srs0=wqyd=la=linux.ibm.com=muriloo@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sNGN00j3zDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 22:45:31 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41sNGM2DQRz8tPk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 22:45:31 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41sNGK2Cb0z9s3x
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2018 22:45:29 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7HCcq0J049070
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2018 08:45:27 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kwxc30p6s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2018 08:45:27 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 17 Aug 2018 06:45:26 -0600
Date: Fri, 17 Aug 2018 09:45:19 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/traps: Avoid rate limit messages from show
 unhandled signals
References: <20180817065500.16899-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180817065500.16899-1-mpe@ellerman.id.au>
Message-Id: <20180817124519.GC7458@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Michael.

On Fri, Aug 17, 2018 at 04:55:00PM +1000, Michael Ellerman wrote:
> In the recent commit to add an explicit ratelimit state when showing
> unhandled signals, commit 35a52a10c3ac ("powerpc/traps: Use an
> explicit ratelimit state for show_signal_msg()"), I put the check of
> show_unhandled_signals and the ratelimit state before the call to
> unhandled_signal() so as to avoid unnecessarily calling the latter
> when show_unhandled_signals is false.
> 
> However that causes us to check the ratelimit state on every call, so
> if we take a lot of *handled* signals that has the effect of making
> the ratelimit code print warnings that callbacks have been suppressed
> when they haven't.
> 
> So rearrange the code so that we check show_unhandled_signals first,
> then call unhandled_signal() and finally check the ratelimit state.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Nice catch.  Thanks for patching it.

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> ---
>  arch/powerpc/kernel/traps.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 070e96f1773a..c85adb858271 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -315,22 +315,21 @@ void user_single_step_siginfo(struct task_struct *tsk,
>  	info->si_addr = (void __user *)regs->nip;
>  }
>  
> -static bool show_unhandled_signals_ratelimited(void)
> +static void show_signal_msg(int signr, struct pt_regs *regs, int code,
> +			    unsigned long addr)
>  {
>  	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>  				      DEFAULT_RATELIMIT_BURST);
> -	return show_unhandled_signals && __ratelimit(&rs);
> -}
>  
> -static void show_signal_msg(int signr, struct pt_regs *regs, int code,
> -			    unsigned long addr)
> -{
> -	if (!show_unhandled_signals_ratelimited())
> +	if (!show_unhandled_signals)
>  		return;
>  
>  	if (!unhandled_signal(current, signr))
>  		return;
>  
> +	if (!__ratelimit(&rs))
> +		return;
> +
>  	pr_info("%s[%d]: %s (%d) at %lx nip %lx lr %lx code %x",
>  		current->comm, current->pid, signame(signr), signr,
>  		addr, regs->nip, regs->link, code);
> -- 
> 2.17.1
> 

-- 
Murilo
