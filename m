Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 06E872C00EE
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 17:54:41 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 12 Aug 2013 13:18:23 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 71F44E0053
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 13:24:54 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7C7toRf45613154
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 13:25:51 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7C7sXBN017595
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 13:24:33 +0530
Message-ID: <520894D6.7050701@linux.vnet.ibm.com>
Date: Mon, 12 Aug 2013 13:25:02 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 2/2] powerpc: Use ibm,
 chip-id property to compute cpu_core_mask if available
References: <20130812062847.GB20246@iris.ozlabs.ibm.com>
 <20130812062933.GC20246@iris.ozlabs.ibm.com>
In-Reply-To: <20130812062933.GC20246@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2013 11:59 AM, Paul Mackerras wrote:
> Some systems have an ibm,chip-id property in the cpu nodes in the
> device tree.  On these systems, we now use that to compute the
> cpu_core_mask (i.e. the set of core siblings) rather than looking
> at cache properties.

Looks fine.

Tested-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

-Vasant

>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> v2: add is bool, use of_read_number
>
>   arch/powerpc/kernel/smp.c | 48 ++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 1568525..a4137de 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -587,6 +587,33 @@ int cpu_first_thread_of_core(int core)
>   }
>   EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
>
> +static void traverse_siblings_chip_id(int cpu, bool add, int chipid)
> +{
> +	const struct cpumask *mask;
> +	struct device_node *np;
> +	int i, plen;
> +	const __be32 *prop;
> +
> +	mask = add ? cpu_online_mask : cpu_present_mask;
> +	for_each_cpu(i, mask) {
> +		np = of_get_cpu_node(i, NULL);
> +		if (!np)
> +			continue;
> +		prop = of_get_property(np, "ibm,chip-id", &plen);
> +		if (prop && plen == sizeof(int) &&
> +		    of_read_number(prop, 1) == chipid) {
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
> @@ -611,14 +638,29 @@ static struct device_node *cpu_to_l2cache(int cpu)
>
>   static void traverse_core_siblings(int cpu, bool add)
>   {
> -	struct device_node *l2_cache;
> +	struct device_node *l2_cache, *np;
>   	const struct cpumask *mask;
> -	int i;
> +	int i, chip, plen;
> +	const __be32 *prop;
> +
> +	/* First see if we have ibm,chip-id properties in cpu nodes */
> +	np = of_get_cpu_node(cpu, NULL);
> +	if (np) {
> +		chip = -1;
> +		prop = of_get_property(np, "ibm,chip-id", &plen);
> +		if (prop && plen == sizeof(int))
> +			chip = of_read_number(prop, 1);
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
>
