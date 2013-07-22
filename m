Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B15AB2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 16:21:54 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 22 Jul 2013 11:43:59 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 21640E004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 11:51:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6M6MbNr29163596
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 11:52:37 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6M6LkKq001597
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 16:21:47 +1000
Message-ID: <51ECCEA8.5040406@linux.vnet.ibm.com>
Date: Mon, 22 Jul 2013 11:48:16 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] powerpc: kernel: remove useless code which related with
 'max_cpus'
References: <51ECCA10.7010709@asianux.com>
In-Reply-To: <51ECCA10.7010709@asianux.com>
Content-Type: text/plain; charset=windows-1252
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

On 07/22/2013 11:28 AM, Chen Gang wrote:
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
> ---
>  arch/powerpc/kernel/smp.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 38b0ba6..8c2bae4 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -345,14 +345,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> 
>  	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
>  	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
> -
> -	if (smp_ops)
> -		if (smp_ops->probe)
> -			max_cpus = smp_ops->probe();

No, you can't just remove the call to ->probe(). Its essential.
For example, one such ->probe() routine, xics_smp_probe() does some
pretty important stuff, such as populating the ->cause_ipi function
pointer etc, see below:

143 int __init xics_smp_probe(void)
144 {
145         /* Setup cause_ipi callback  based on which ICP is used */
146         smp_ops->cause_ipi = icp_ops->cause_ipi;
147 
148         /* Register all the IPIs */
149         xics_request_ipi();
150 
151         return cpumask_weight(cpu_possible_mask);
152 }

> -		else
> -			max_cpus = NR_CPUS;
> -	else
> -		max_cpus = 1;
>  }
>

Yes, max_cpus is unused, but you have to be careful while removing
code.
Regards,
Srivatsa S. Bhat
