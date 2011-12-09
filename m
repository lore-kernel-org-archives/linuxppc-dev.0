Return-Path: <anton@samba.org>
Date: Sat, 10 Dec 2011 10:28:37 +1100
From: Anton Blanchard <anton@samba.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] powerpc: fix wrong divisor in usecs_to_cputime
Message-ID: <20111210102837.526cbc19@kryten>
In-Reply-To: <m2pqfx2zub.fsf@igel.home>
References: <m2fwgvnwlm.fsf__7616.12257124415$1323342974$gmane$org@igel.home>
 <m2pqfx2zub.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andreas,

> Commit d57af9b (taskstats: use real microsecond granularity for CPU
> times) renamed msecs_to_cputime to usecs_to_cputime, but failed to
> update all numbers on the way.  This causes nonsensical cpu
> idle/iowait values to be displayed in /proc/stat (the only user of
> usecs_to_cputime so far).
> 
> This also renames __cputime_msec_factor to __cputime_usec_factor,
> adapting its value and using it directly in cputime_to_usecs instead
> of doing two multiplications.

Thanks for finding this! I noticed the strange behaviour yesterday and
was just about to investigate.

Can I suggest we add: 

Cc: <stable@vger.kernel.org> [2.6.37+]

so it will make it back into the stable trees?

Anton

> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

FWIW:
Acked-by: Anton Blanchard <anton@samba.org>

> ---
>  arch/powerpc/include/asm/cputime.h |    6 +++---
>  arch/powerpc/kernel/time.c         |   10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cputime.h
> b/arch/powerpc/include/asm/cputime.h index 1cf20bd..33a3580 100644
> --- a/arch/powerpc/include/asm/cputime.h
> +++ b/arch/powerpc/include/asm/cputime.h
> @@ -126,11 +126,11 @@ static inline u64 cputime64_to_jiffies64(const
> cputime_t ct) /*
>   * Convert cputime <-> microseconds
>   */
> -extern u64 __cputime_msec_factor;
> +extern u64 __cputime_usec_factor;
>  
>  static inline unsigned long cputime_to_usecs(const cputime_t ct)
>  {
> -	return mulhdu(ct, __cputime_msec_factor) * USEC_PER_MSEC;
> +	return mulhdu(ct, __cputime_usec_factor);
>  }
>  
>  static inline cputime_t usecs_to_cputime(const unsigned long us)
> @@ -143,7 +143,7 @@ static inline cputime_t usecs_to_cputime(const
> unsigned long us) sec = us / 1000000;
>  	if (ct) {
>  		ct *= tb_ticks_per_sec;
> -		do_div(ct, 1000);
> +		do_div(ct, 1000000);
>  	}
>  	if (sec)
>  		ct += (cputime_t) sec * tb_ticks_per_sec;
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 522bb1d..69477e5 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -168,13 +168,13 @@ EXPORT_SYMBOL_GPL(ppc_tb_freq);
>  #ifdef CONFIG_VIRT_CPU_ACCOUNTING
>  /*
>   * Factors for converting from cputime_t (timebase ticks) to
> - * jiffies, milliseconds, seconds, and clock_t (1/USER_HZ seconds).
> + * jiffies, microseconds, seconds, and clock_t (1/USER_HZ seconds).
>   * These are all stored as 0.64 fixed-point binary fractions.
>   */
>  u64 __cputime_jiffies_factor;
>  EXPORT_SYMBOL(__cputime_jiffies_factor);
> -u64 __cputime_msec_factor;
> -EXPORT_SYMBOL(__cputime_msec_factor);
> +u64 __cputime_usec_factor;
> +EXPORT_SYMBOL(__cputime_usec_factor);
>  u64 __cputime_sec_factor;
>  EXPORT_SYMBOL(__cputime_sec_factor);
>  u64 __cputime_clockt_factor;
> @@ -192,8 +192,8 @@ static void calc_cputime_factors(void)
>  
>  	div128_by_32(HZ, 0, tb_ticks_per_sec, &res);
>  	__cputime_jiffies_factor = res.result_low;
> -	div128_by_32(1000, 0, tb_ticks_per_sec, &res);
> -	__cputime_msec_factor = res.result_low;
> +	div128_by_32(1000000, 0, tb_ticks_per_sec, &res);
> +	__cputime_usec_factor = res.result_low;
>  	div128_by_32(1, 0, tb_ticks_per_sec, &res);
>  	__cputime_sec_factor = res.result_low;
>  	div128_by_32(USER_HZ, 0, tb_ticks_per_sec, &res);
