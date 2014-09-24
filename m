Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17BEC1A15F0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 06:15:47 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 24 Sep 2014 14:15:45 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 69B423E40030
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 14:15:43 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8OKDgGU1311012
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 22:13:42 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8OKFhXx025429
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 14:15:43 -0600
Message-ID: <5423266E.1060101@linux.vnet.ibm.com>
Date: Wed, 24 Sep 2014 15:15:42 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] pseries: Fix endian issues in onlining cpu threads
References: <1410898547-12296-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <1410898547-12296-3-git-send-email-tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <1410898547-12296-3-git-send-email-tlfalcon@linux.vnet.ibm.com>
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
> The ibm,ppc-interrupt-server#s property is in big endian format.
> These values need to be converted when used by little endian
> architectures.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
> Changes in v2:
> 
>  Followed suggestions from Michael Ellerman
>    conversion of intserv values occur once
> ---
>  arch/powerpc/platforms/pseries/dlpar.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 5acbe59..187e4eb 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -363,7 +363,8 @@ static int dlpar_online_cpu(struct device_node *dn)
>  	int rc = 0;
>  	unsigned int cpu;
>  	int len, nthreads, i;
> -	const u32 *intserv;
> +	const __be32 *intserv;
> +	u32 thread;
>  
>  	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
>  	if (!intserv)
> @@ -373,8 +374,9 @@ static int dlpar_online_cpu(struct device_node *dn)
>  
>  	cpu_maps_update_begin();
>  	for (i = 0; i < nthreads; i++) {
> +		thread = be32_to_cpu(intserv[i]);
>  		for_each_present_cpu(cpu) {
> -			if (get_hard_smp_processor_id(cpu) != intserv[i])
> +			if (get_hard_smp_processor_id(cpu) != thread)
>  				continue;
>  			BUG_ON(get_cpu_current_state(cpu)
>  					!= CPU_STATE_OFFLINE);
> @@ -388,7 +390,7 @@ static int dlpar_online_cpu(struct device_node *dn)
>  		}
>  		if (cpu == num_possible_cpus())
>  			printk(KERN_WARNING "Could not find cpu to online "
> -			       "with physical id 0x%x\n", intserv[i]);
> +			       "with physical id 0x%x\n", thread);
>  	}
>  	cpu_maps_update_done();
>  
> 
