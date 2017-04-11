Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2NjV4RXpzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 20:35:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] powerpc/book3s: mce: Use add_taint_no_warn() in
 machine_check_early().
In-Reply-To: <148765089349.20315.11180051017586952500.stgit@jupiter.in.ibm.com>
References: <148765088309.20315.15300624012053746538.stgit@jupiter.in.ibm.com>
 <148765089349.20315.11180051017586952500.stgit@jupiter.in.ibm.com>
Date: Tue, 11 Apr 2017 20:35:08 +1000
Message-ID: <87pogjut9f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> machine_check_early() gets called in real mode. The very first time when
> add_taint() is called, it prints a warning which ends up calling opal
> call (that uses OPAL_CALL wrapper) for writing it to console. If we get a
> very first machine check while we are in opal we are doomed. OPAL_CALL
> overwrites the PACASAVEDMSR in r13 and in this case when we are done with
> MCE handling the original opal call will use this new MSR on it's way
> back to opal_return. This usually leads unexpected behaviour or kernel
> to panic. Instead use the add_taint_no_warn() that does not call printk.
>
> This is broken with current FW level. We got lucky so far for not getting
> very first MCE hit while in OPAL. But easily reproducible on Mambo.
> This should go to stable as well alongwith patch 1/2.

This is not a good way to fix a bug that needs to go back to stable.
Changing generic code means I need to sync up with the right maintainer,
get acks, etc. And then convince people that it should go to stable also.

So you can please fix this a different way for stable?

Can we just do the tainting later, once we're in virtual mode?

cheers

> Fixes: 27ea2c420cad powerpc: Set the correct kernel taint on machine check errors.
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/traps.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 62b587f..4a048dc 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -306,7 +306,7 @@ long machine_check_early(struct pt_regs *regs)
>  
>  	__this_cpu_inc(irq_stat.mce_exceptions);
>  
> -	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
> +	add_taint_no_warn(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>  
>  	/*
>  	 * See if platform is capable of handling machine check. (e.g. PowerNV
