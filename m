Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8ABDB1A17EA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 06:16:16 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 24 Sep 2014 14:16:14 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4849B1FF001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 14:04:58 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8OKGC0n45285472
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 22:16:13 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8OKGCjd027408
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 14:16:12 -0600
Message-ID: <5423268C.6000407@linux.vnet.ibm.com>
Date: Wed, 24 Sep 2014 15:16:12 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/3] pseries: Fix endian issues in cpu hot-removal
References: <1410898547-12296-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <1410898547-12296-4-git-send-email-tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <1410898547-12296-4-git-send-email-tlfalcon@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: bharata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2014 03:15 PM, Thomas Falcon wrote:
> When removing a cpu, this patch makes sure that values
> gotten from or passed to firmware are in the correct
> endian format.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
> Changes in v3:
> 
>  drc_index in dlpar_cpu_release is no longer const to
>  fix compilation error found by Bharata Rao
> ---
>  arch/powerpc/platforms/pseries/dlpar.c       | 20 +++++++++++---------
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 10 ++++++----
>  2 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 187e4eb..0fad5b6 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -444,7 +444,8 @@ static int dlpar_offline_cpu(struct device_node *dn)
>  	int rc = 0;
>  	unsigned int cpu;
>  	int len, nthreads, i;
> -	const u32 *intserv;
> +	const __be32 *intserv;
> +	u32 thread;
>  
>  	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
>  	if (!intserv)
> @@ -454,8 +455,9 @@ static int dlpar_offline_cpu(struct device_node *dn)
>  
>  	cpu_maps_update_begin();
>  	for (i = 0; i < nthreads; i++) {
> +		thread = be32_to_cpu(intserv[i]);
>  		for_each_present_cpu(cpu) {
> -			if (get_hard_smp_processor_id(cpu) != intserv[i])
> +			if (get_hard_smp_processor_id(cpu) != thread)
>  				continue;
>  
>  			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
> @@ -477,14 +479,14 @@ static int dlpar_offline_cpu(struct device_node *dn)
>  			 * Upgrade it's state to CPU_STATE_OFFLINE.
>  			 */
>  			set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
> -			BUG_ON(plpar_hcall_norets(H_PROD, intserv[i])
> +			BUG_ON(plpar_hcall_norets(H_PROD, thread)
>  								!= H_SUCCESS);
>  			__cpu_die(cpu);
>  			break;
>  		}
>  		if (cpu == num_possible_cpus())
>  			printk(KERN_WARNING "Could not find cpu to offline "
> -			       "with physical id 0x%x\n", intserv[i]);
> +			       "with physical id 0x%x\n", thread);
>  	}
>  	cpu_maps_update_done();
>  
> @@ -496,15 +498,15 @@ out:
>  static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>  {
>  	struct device_node *dn;
> -	const u32 *drc_index;
> +	u32 drc_index;
>  	int rc;
>  
>  	dn = of_find_node_by_path(buf);
>  	if (!dn)
>  		return -EINVAL;
>  
> -	drc_index = of_get_property(dn, "ibm,my-drc-index", NULL);
> -	if (!drc_index) {
> +	rc = of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
> +	if (rc) {
>  		of_node_put(dn);
>  		return -EINVAL;
>  	}
> @@ -515,7 +517,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>  		return -EINVAL;
>  	}
>  
> -	rc = dlpar_release_drc(*drc_index);
> +	rc = dlpar_release_drc(drc_index);
>  	if (rc) {
>  		of_node_put(dn);
>  		return rc;
> @@ -523,7 +525,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>  
>  	rc = dlpar_detach_node(dn);
>  	if (rc) {
> -		dlpar_acquire_drc(*drc_index);
> +		dlpar_acquire_drc(drc_index);
>  		return rc;
>  	}
>  
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 447f8c6..5c375f9 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -90,7 +90,7 @@ static void rtas_stop_self(void)
>  {
>  	static struct rtas_args args = {
>  		.nargs = 0,
> -		.nret = 1,
> +		.nret = cpu_to_be32(1),
>  		.rets = &args.args[0],
>  	};
>  
> @@ -312,7 +312,8 @@ static void pseries_remove_processor(struct device_node *np)
>  {
>  	unsigned int cpu;
>  	int len, nthreads, i;
> -	const u32 *intserv;
> +	const __be32 *intserv;
> +	u32 thread;
>  
>  	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
>  	if (!intserv)
> @@ -322,8 +323,9 @@ static void pseries_remove_processor(struct device_node *np)
>  
>  	cpu_maps_update_begin();
>  	for (i = 0; i < nthreads; i++) {
> +		thread = be32_to_cpu(intserv[i]);
>  		for_each_present_cpu(cpu) {
> -			if (get_hard_smp_processor_id(cpu) != intserv[i])
> +			if (get_hard_smp_processor_id(cpu) != thread)
>  				continue;
>  			BUG_ON(cpu_online(cpu));
>  			set_cpu_present(cpu, false);
> @@ -332,7 +334,7 @@ static void pseries_remove_processor(struct device_node *np)
>  		}
>  		if (cpu >= nr_cpu_ids)
>  			printk(KERN_WARNING "Could not find cpu to remove "
> -			       "with physical id 0x%x\n", intserv[i]);
> +			       "with physical id 0x%x\n", thread);
>  	}
>  	cpu_maps_update_done();
>  }
> 
