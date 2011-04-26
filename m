Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 31EF9B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 04:26:19 +1000 (EST)
Message-ID: <4DB70E37.9040407@windriver.com>
Date: Tue, 26 Apr 2011 14:25:59 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] powerpc/kexec: Fix build failure on 32-bit SMP
References: <1303693471.3032.212.camel@localhost>
In-Reply-To: <1303693471.3032.212.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11-04-24 09:04 PM, Ben Hutchings wrote:
> Commit b987812b3fcaf70fdf0037589e5d2f5f2453e6ce left
> crash_kexec_wait_realmode() undefined for UP.
> 
> Commit 7c7a81b53e581d727d069cc45df5510516faac31 defined it for UP but
> left it undefined for 32-bit SMP.

Crap,  I'd originally tested it for 32-SMP too, but not retested after
fixing the UP regression.  I'm resolving to not touch this file again. :)

> 
> Seems like people are getting confused by nested #ifdef's, so move the

So true.

> definitions of crash_kexec_wait_realmode() after the #ifdef CONFIG_SMP
> section.

I probably should have done this from the get-go as well.  Oh well.
At least we are progressing towards a more readable file.

> 
> Compile-tested with 32-bit UP, 32-bit SMP and 64-bit SMP configurations.

Since it seems I always get bit by the one combo I skip testing on,
I also tested 64-bit UP as well - just to be extra sure.  Thanks for
fixing my brown paper bag moment.

> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Paul.

> ---
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -162,34 +162,6 @@
>  	/* Leave the IPI callback set */
>  }
>  
> -/* wait for all the CPUs to hit real mode but timeout if they don't come in */
> -#ifdef CONFIG_PPC_STD_MMU_64
> -static void crash_kexec_wait_realmode(int cpu)
> -{
> -	unsigned int msecs;
> -	int i;
> -
> -	msecs = 10000;
> -	for (i=0; i < NR_CPUS && msecs > 0; i++) {
> -		if (i == cpu)
> -			continue;
> -
> -		while (paca[i].kexec_state < KEXEC_STATE_REAL_MODE) {
> -			barrier();
> -			if (!cpu_possible(i)) {
> -				break;
> -			}
> -			if (!cpu_online(i)) {
> -				break;
> -			}
> -			msecs--;
> -			mdelay(1);
> -		}
> -	}
> -	mb();
> -}
> -#endif	/* CONFIG_PPC_STD_MMU_64 */
> -
>  /*
>   * This function will be called by secondary cpus or by kexec cpu
>   * if soft-reset is activated to stop some CPUs.
> @@ -234,7 +206,6 @@
>  }
>  
>  #else	/* ! CONFIG_SMP */
> -static inline void crash_kexec_wait_realmode(int cpu) {}
>  
>  static void crash_kexec_prepare_cpus(int cpu)
>  {
> @@ -257,6 +228,36 @@
>  }
>  #endif	/* CONFIG_SMP */
>  
> +/* wait for all the CPUs to hit real mode but timeout if they don't come in */
> +#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_64)
> +static void crash_kexec_wait_realmode(int cpu)
> +{
> +	unsigned int msecs;
> +	int i;
> +
> +	msecs = 10000;
> +	for (i=0; i < NR_CPUS && msecs > 0; i++) {
> +		if (i == cpu)
> +			continue;
> +
> +		while (paca[i].kexec_state < KEXEC_STATE_REAL_MODE) {
> +			barrier();
> +			if (!cpu_possible(i)) {
> +				break;
> +			}
> +			if (!cpu_online(i)) {
> +				break;
> +			}
> +			msecs--;
> +			mdelay(1);
> +		}
> +	}
> +	mb();
> +}
> +#else
> +static inline void crash_kexec_wait_realmode(int cpu) {}
> +#endif	/* CONFIG_SMP && CONFIG_PPC_STD_MMU_64 */
> +
>  /*
>   * Register a function to be called on shutdown.  Only use this if you
>   * can't reset your device in the second kernel.
> 
