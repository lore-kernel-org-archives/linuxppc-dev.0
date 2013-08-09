Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0E812C00D3
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Aug 2013 17:21:50 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 9 Aug 2013 12:45:38 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 85E9EE004F
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Aug 2013 12:52:02 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r797LgBo33882136
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Aug 2013 12:51:42 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r797LibW018679
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Aug 2013 12:51:44 +0530
Message-ID: <520498A4.9050805@linux.vnet.ibm.com>
Date: Fri, 09 Aug 2013 12:52:12 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Use ibm,
 chip-id property to compute cpu_core_mask if available
References: <20130704030506.GA2396@iris.ozlabs.ibm.com>
In-Reply-To: <20130704030506.GA2396@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2013 08:35 AM, Paul Mackerras wrote:
> Some systems have an ibm,chip-id property in the cpu nodes in the
> device tree.  On these systems, we now use that to compute the
> cpu_core_mask (i.e. the set of core siblings) rather than looking
> at cache properties.
>

Paul,

I wanted to test this patch but not able to apply this patch on top of Linux 
tree. Looks like I'm missing traverse_core_siblings() related patch. I searched 
in ppc mailing list and couldn't figure out.

Can you point me to related patch?

-Vasant


> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index b72d8c9..3b7a118 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -587,6 +587,32 @@ int cpu_first_thread_of_core(int core)
>   }
>   EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
>
> +static void traverse_siblings_chip_id(int cpu, int add, int chipid)
> +{
> +	const struct cpumask *mask;
> +	struct device_node *np;
> +	int i, plen;
> +	const int *prop;
> +
> +	mask = add ? cpu_online_mask : cpu_present_mask;
> +	for_each_cpu(i, mask) {
> +		np = of_get_cpu_node(i, NULL);
> +		if (!np)
> +			continue;
> +		prop = of_get_property(np, "ibm,chip-id", &plen);
> +		if (prop && plen == sizeof(int) && *prop == chipid) {
> +			if (add) {
> +				cpumask_set_cpu(cpu, cpu_core_mask(i));
> +				cpumask_set_cpu(i, cpu_core_mask(cpu));
> +			} else {
> +				cpumask_clear_cpu(cpu, cpu_core_mask(i));
> +				cpumask_clear_cpu(i, cpu_core_mask(cpu));
> +			}
> +		}
> +		of_node_put(np);
> +	}
> +}
> +
>   /* Must be called when no change can occur to cpu_present_mask,
>    * i.e. during cpu online or offline.
>    */
> @@ -611,14 +637,29 @@ static struct device_node *cpu_to_l2cache(int cpu)
>
>   static void traverse_core_siblings(int cpu, int add)
>   {
> -	struct device_node *l2_cache;
> +	struct device_node *l2_cache, *np;
>   	const struct cpumask *mask;
> -	int i;
> +	int i, chip, plen;
> +	const int *prop;
> +
> +	/* First see if we have ibm,chip-id properties in cpu nodes */
> +	np = of_get_cpu_node(cpu, NULL);
> +	if (np) {
> +		chip = -1;
> +		prop = of_get_property(np, "ibm,chip-id", &plen);
> +		if (prop && plen == sizeof(int))
> +			chip = *(int *)prop;
> +		of_node_put(np);
> +		if (chip >= 0) {
> +			traverse_siblings_chip_id(cpu, add, chip);
> +			return;
> +		}
> +	}
>
>   	l2_cache = cpu_to_l2cache(cpu);
>   	mask = add ? cpu_online_mask : cpu_present_mask;
>   	for_each_cpu(i, mask) {
> -		struct device_node *np = cpu_to_l2cache(i);
> +		np = cpu_to_l2cache(i);
>   		if (!np)
>   			continue;
>   		if (np == l2_cache) {
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
