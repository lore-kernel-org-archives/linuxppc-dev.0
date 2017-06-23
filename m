Return-Path: <cyrilbur@gmail.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wv7DB01WZzDqjM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 16:03:21 +1000 (AEST)
Received: by mail-io0-x244.google.com with SMTP id h134so6014506iof.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 23:03:21 -0700 (PDT)
Message-ID: <1498197792.7039.1.camel@gmail.com>
Subject: Re: [PATCH] powerpc/kernel: Avoid redundancies on giveup_all
From: Cyril Bur <cyrilbur@gmail.com>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Gustavo Romero <gromero@linux.vnet.ibm.com>
Date: Fri, 23 Jun 2017 16:03:12 +1000
In-Reply-To: <1498163243-22203-1-git-send-email-leitao@debian.org>
References: <1498163243-22203-1-git-send-email-leitao@debian.org>
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

On Thu, 2017-06-22 at 17:27 -0300, Breno Leitao wrote:
> Currently giveup_all() calls __giveup_fpu(), __giveup_altivec(), and
> __giveup_vsx(). But __giveup_vsx() also calls __giveup_fpu() and
> __giveup_altivec() again, in a redudant manner.
> 
> Other than giving up FP and Altivec, __giveup_vsx() also disables
> MSR_VSX on MSR, but this is already done by __giveup_{fpu,altivec}().
> As VSX can not be enabled alone on MSR (without FP and/or VEC
> enabled), this is also a redundancy. VSX is never enabled alone (without
> FP and VEC) because every time VSX is enabled, as through load_up_vsx()
> and restore_math(), FP is also enabled together.
> 
> This change improves giveup_all() in average just 3%, but since
> giveup_all() is called very frequently, around 8x per CPU per second on
> an idle machine, this change might show some noticeable improvement.
> 

So I totally agree except this makes me quite nervous. I know we're
quite good at always disabling VSX when we disable FPU and ALTIVEC and
we do always turn VSX on when we enable FPU AND ALTIVEC. But still, if
we ever get that wrong...

I'm more interested in how this improves giveup_all() performance by so
much, but then hardware often surprises - I guess that's the cost of a
function call.

Perhaps caching the thread.regs->msr isn't a good idea. If we could
branch over in the common case and but still have the call to the
function in case something goes horribly wrong?

> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/process.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 2ad725ef4368..5d6af58270e6 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -494,10 +494,6 @@ void giveup_all(struct task_struct *tsk)
>  	if (usermsr & MSR_VEC)
>  		__giveup_altivec(tsk);
>  #endif
> -#ifdef CONFIG_VSX
> -	if (usermsr & MSR_VSX)
> -		__giveup_vsx(tsk);
> -#endif
>  #ifdef CONFIG_SPE
>  	if (usermsr & MSR_SPE)
>  		__giveup_spe(tsk);
