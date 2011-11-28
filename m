Return-Path: <johnstul@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 68B711007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 10:36:00 +1100 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <johnstul@us.ibm.com>;
 Mon, 28 Nov 2011 18:35:57 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pASNUunH295396
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 18:30:56 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pASNUtOx019621
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 18:30:56 -0500
Message-ID: <1322523053.24090.6.camel@work-vm>
Subject: Re: [PATCH 3/6] powerpc/time: Use clocksource_register_hz
From: john stultz <johnstul@us.ibm.com>
To: Anton Blanchard <anton@samba.org>
Date: Mon, 28 Nov 2011 15:30:53 -0800
In-Reply-To: <20111124060847.282144743@samba.org>
References: <20111124060716.362614789@samba.org>
 <20111124060847.282144743@samba.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-24 at 17:07 +1100, Anton Blanchard wrote:
> plain text document attachment (clock3)
> Use clocksource_register_hz which calculates the shift/mult
> factors for us. Also remove the shift = 22 assumption in
> vsyscall_update - thanks to Paul Mackerras and John Stultz for
> catching that.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: linux-build/arch/powerpc/kernel/time.c
> ===================================================================
> --- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-17 10:11:51.175038860 +1100
> +++ linux-build/arch/powerpc/kernel/time.c	2011-11-17 10:11:55.547114957 +1100
> @@ -86,8 +86,6 @@ static struct clocksource clocksource_rt
>  	.rating       = 400,
>  	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
>  	.mask         = CLOCKSOURCE_MASK(64),
> -	.shift        = 22,
> -	.mult         = 0,	/* To be filled in */
>  	.read         = rtc_read,
>  };
> 
> @@ -97,8 +95,6 @@ static struct clocksource clocksource_ti
>  	.rating       = 400,
>  	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
>  	.mask         = CLOCKSOURCE_MASK(64),
> -	.shift        = 22,
> -	.mult         = 0,	/* To be filled in */
>  	.read         = timebase_read,
>  };
> 
> @@ -822,9 +818,8 @@ void update_vsyscall(struct timespec *wa
>  	++vdso_data->tb_update_count;
>  	smp_mb();
> 
> -	/* XXX this assumes clock->shift == 22 */
> -	/* 4611686018 ~= 2^(20+64-22) / 1e9 */
> -	new_tb_to_xs = (u64) mult * 4611686018ULL;
> +	/* 19342813113834067 ~= 2^(20+64) / 1e9 */
> +	new_tb_to_xs = (u64) mult * (19342813113834067ULL >> clock->shift);

I never verified the math on this, but assuming Paul had it right, this
patch looks good!

Acked-by: John Stultz <johnstul@us.ibm.com>

Thanks again!
-john
