Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9BCA02C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 16:54:55 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 22 Jul 2013 12:19:07 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1CCBBE0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 12:24:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6M6teEd24510614
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 12:25:41 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6M6skXH012964
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 16:54:47 +1000
Message-ID: <51ECD664.7040708@linux.vnet.ibm.com>
Date: Mon, 22 Jul 2013 12:21:16 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] powerpc: kernel: remove useless code which related
 with 'max_cpus'
References: <51ECCA10.7010709@asianux.com>
 <51ECCEA8.5040406@linux.vnet.ibm.com> <51ECD0BF.8080605@asianux.com>
 <51ECD3D4.9020405@asianux.com>
In-Reply-To: <51ECD3D4.9020405@asianux.com>
Content-Type: text/plain; charset=UTF-8
Cc: chenhui.zhao@freescale.com, "paulus@samba.org" <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2013 12:10 PM, Chen Gang wrote:
> Since not need 'max_cpus' after the related commit, the related code
> are useless too, need be removed.
> 
> The related commit:
> 
>   c1aa687 powerpc: Clean up obsolete code relating to decrementer and timebase
> 
> The related warning:
> 
>   arch/powerpc/kernel/smp.c:323:43: warning: parameter ‘max_cpus’ set but not used [-Wunused-but-set-parameter]
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

This version looks good.

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> ---
>  arch/powerpc/kernel/smp.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 38b0ba6..7edbd5b 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -346,13 +346,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
>  	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
> 
> -	if (smp_ops)
> -		if (smp_ops->probe)
> -			max_cpus = smp_ops->probe();
> -		else
> -			max_cpus = NR_CPUS;
> -	else
> -		max_cpus = 1;
> +	if (smp_ops && smp_ops->probe)
> +		smp_ops->probe();
>  }
> 
>  void smp_prepare_boot_cpu(void)
> 
