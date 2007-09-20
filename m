Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 717E1DDE0C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 18:26:11 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8K8PdEO020089
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 18:25:39 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8K8Pebi3723352
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 18:25:40 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8K8OAbB006048
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 18:24:10 +1000
Message-ID: <46F22E60.2090403@linux.vnet.ibm.com>
Date: Thu, 20 Sep 2007 13:55:04 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Satyam Sharma <satyam@infradead.org>
Subject: Re: [PATCH] powerpc: Avoid pointless WARN_ON(irqs_disabled()) from
	panic codepath
References: <46EA5CEB.7020104@linux.vnet.ibm.com>
	<a781481a0709140337u2c26f770h2af6d457bc39f280@mail.gmail.com>
	<alpine.LFD.0.999.0709180511070.8863@enigma.security.iitk.ac.in>
In-Reply-To: <alpine.LFD.0.999.0709180511070.8863@enigma.security.iitk.ac.in>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Satyam Sharma wrote:
>> ------------[ cut here ]------------
>> Badness at arch/powerpc/kernel/smp.c:202
>>     
>
> comes when smp_call_function_map() has been called with irqs disabled,
> which is illegal. However, there is a special case, the panic() codepath,
> when we do not want to warn about this -- warning at that time is pointless
> anyway, and only serves to scroll away the *real* cause of the panic and
> distracts from the real bug.
>
> * So let's extract the WARN_ON() from smp_call_function_map() into all its
>   callers -- smp_call_function() and smp_call_function_single()
>
> * Also, introduce another caller of smp_call_function_map(), namely
>   __smp_call_function() (and make smp_call_function() a wrapper over this)
>   which does *not* warn about disabled irqs
>
> * Use this __smp_call_function() from the panic codepath's smp_send_stop()
>
> We also end having to move code of smp_send_stop() below the definition
> of __smp_call_function().
>
> Signed-off-by: Satyam Sharma <satyam@infradead.org>
>
> ---
>
> Untested (not even compile-tested) patch.
> Could someone point me to ppc32/64 cross-compilers for i386?
>
>  arch/powerpc/kernel/smp.c |   27 ++++++++++++++++++---------
>  1 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 1ea4316..b24dcba 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -152,11 +152,6 @@ static void stop_this_cpu(void *dummy)
>  		;
>  }
>
> -void smp_send_stop(void)
> -{
> -	smp_call_function(stop_this_cpu, NULL, 1, 0);
> -}
> -
>  /*
>   * Structure and data for smp_call_function(). This is designed to minimise
>   * static memory requirements. It also looks cleaner.
> @@ -198,9 +193,6 @@ int smp_call_function_map(void (*func) (void *info), void *info, int nonatomic,
>  	int cpu;
>  	u64 timeout;
>
> -	/* Can deadlock when called with interrupts disabled */
> -	WARN_ON(irqs_disabled());
> -
>  	if (unlikely(smp_ops == NULL))
>  		return ret;
>
> @@ -270,10 +262,19 @@ int smp_call_function_map(void (*func) (void *info), void *info, int nonatomic,
>  	return ret;
>  }
>
> +static int __smp_call_function(void (*func)(void *info), void *info,
> +			       int nonatomic, int wait)
> +{
> +	return smp_call_function_map(func,info,nonatomic,wait,cpu_online_map);
> +}
> +
>  int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
>  			int wait)
>  {
> -	return smp_call_function_map(func,info,nonatomic,wait,cpu_online_map);
> +	/* Can deadlock when called with interrupts disabled */
> +	WARN_ON(irqs_disabled());
> +
> +	return __smp_call_function(func, info, nonatomic, wait);
>  }
>  EXPORT_SYMBOL(smp_call_function);
>
> @@ -283,6 +284,9 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int
>  	cpumask_t map = CPU_MASK_NONE;
>  	int ret = 0;
>
> +	/* Can deadlock when called with interrupts disabled */
> +	WARN_ON(irqs_disabled());
> +
>  	if (!cpu_online(cpu))
>  		return -EINVAL;
>
> @@ -299,6 +303,11 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int
>  }
>  EXPORT_SYMBOL(smp_call_function_single);
>
> +void smp_send_stop(void)
> +{
> +	__smp_call_function(stop_this_cpu, NULL, 1, 0);
> +}
> +
>  void smp_call_function_interrupt(void)
>  {
>  	void (*func) (void *info);
>   
Hi,

This patch solves the badness oops we get on the powerpc.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
