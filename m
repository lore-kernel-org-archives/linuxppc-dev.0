Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F325A1A0A72
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 07:13:23 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 2 Oct 2014 15:13:21 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CD80C38C8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 17:13:18 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s92LDImx7536958
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Oct 2014 21:13:18 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s92LDIpC028430
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Oct 2014 17:13:18 -0400
Date: Thu, 2 Oct 2014 14:13:05 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 1/3] powerpc: Fix warning reported by
 verify_cpu_node_mapping()
Message-ID: <20141002211305.GB12862@linux.vnet.ibm.com>
References: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben & Michael,

What's the status of these patches?

Thanks,
Nish

On 27.08.2014 [17:33:59 +0800], Li Zhong wrote:
> With commit 2fabf084b6ad ("powerpc: reorder per-cpu NUMA information's
> initialization"), during boottime, cpu_numa_callback() is called
> earlier(before their online) for each cpu, and verify_cpu_node_mapping()
> uses cpu_to_node() to check whether siblings are in the same node.
> 
> It skips the checking for siblings that are not online yet. So the only
> check done here is for the bootcpu, which is online at that time. But
> the per-cpu numa_node cpu_to_node() uses hasn't been set up yet (which
> will be set up in smp_prepare_cpus()).
> 
> So I saw something like following reported:
> [    0.000000] CPU thread siblings 1/2/3 and 0 don't belong to the same
> node!
> 
> As we don't actually do the checking during this early stage, so maybe
> we could directly call numa_setup_cpu() in do_init_bootmem().
> 
> Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index d7737a5..9918c02 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1128,8 +1128,7 @@ void __init do_init_bootmem(void)
>  	 * early in boot, cf. smp_prepare_cpus().
>  	 */
>  	for_each_possible_cpu(cpu) {
> -		cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
> -				  (void *)(unsigned long)cpu);
> +		numa_setup_cpu((unsigned long)cpu);
>  	}
>  }
> 
> -- 
> 1.9.1
> 
