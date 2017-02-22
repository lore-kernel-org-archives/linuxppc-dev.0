Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vT9c86zpXzDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 08:34:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Weisbecker <fweisbec@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Remove leftover cputime_to_nsecs call causing
 build error
In-Reply-To: <1487690321-21553-1-git-send-email-fweisbec@gmail.com>
References: <1487690321-21553-1-git-send-email-fweisbec@gmail.com>
Date: Thu, 23 Feb 2017 08:34:15 +1100
Message-ID: <87fuj5zz8o.fsf@concordia.ellerman.id.au>
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

Frederic Weisbecker <fweisbec@gmail.com> writes:

> This type conversion is a leftover that got ignored during the kcpustat
> conversion to nanosecs, resulting in build breakage with config having
> CONFIG_NO_HZ_FULL=y.
>
> 	arch/powerpc/kernel/time.c: In function 'running_clock':
> 	arch/powerpc/kernel/time.c:712:2: error: implicit declaration of function 'cputime_to_nsecs' [-Werror=implicit-function-declaration]
> 	  return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);
>
> All we need is to remove it.
>
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Oliver O'Halloran <oohall@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


Are you going to send this to Linus, or should I?

cheers


> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 14e4855..bc84a8d 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -709,7 +709,7 @@ unsigned long long running_clock(void)
>  	 * time and on a host which doesn't do any virtualisation TB *should* equal
>  	 * VTB so it makes no difference anyway.
>  	 */
> -	return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);
> +	return local_clock() - kcpustat_this_cpu->cpustat[CPUTIME_STEAL];
>  }
>  #endif
>  
> -- 
> 2.7.4
