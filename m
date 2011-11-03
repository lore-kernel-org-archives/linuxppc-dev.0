Return-Path: <johnstul@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6B776B6F75
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 00:15:29 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <johnstul@us.ibm.com>;
 Thu, 3 Nov 2011 07:15:10 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA3DEoLA050226
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2011 07:14:52 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA3DEoAe002663
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2011 07:14:50 -0600
Message-ID: <1320326084.2892.4.camel@js-netbook>
Subject: Re: [PATCH 2/4] powerpc/time: Use clocksource_register_hz
From: John Stultz <johnstul@us.ibm.com>
To: Anton Blanchard <anton@samba.org>
Date: Thu, 03 Nov 2011 09:14:44 -0400
In-Reply-To: <20111103010111.951358660@samba.org>
References: <20111103005922.854058953@samba.org>
 <20111103010111.951358660@samba.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-03 at 11:59 +1100, Anton Blanchard wrote:
> plain text document attachment (clock3)
> Use clocksource_register_hz which calculates the shift/mult
> factors for us.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: linux-build/arch/powerpc/kernel/time.c
> ===================================================================
> --- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-03 10:19:59.493679032 +1100
> +++ linux-build/arch/powerpc/kernel/time.c	2011-11-03 10:20:00.965704053 +1100
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

So I've held off on ppc conversion to clocksource_register_hz due to the
fact that the ppc vdso gettimeofday at least used to make assumptions
that shift was 22.

Is that no longer the case?

thanks
-john
