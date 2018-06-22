Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Bh0D42pYzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 11:33:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/numa: Correct kernel message severity
In-Reply-To: <1521013954-21348-1-git-send-email-vipin@linux.vnet.ibm.com>
References: <1521013954-21348-1-git-send-email-vipin@linux.vnet.ibm.com>
Date: Fri, 22 Jun 2018 11:32:59 +1000
Message-ID: <87y3f7ehbo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:

> printk() in unmap_cpu_from_node() uses KERN_ERR message severity,
> for a WARNING message. Change it to pr_warn().
>
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index edd8d0b..1632f4b 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -163,8 +163,7 @@ static void unmap_cpu_from_node(unsigned long cpu)
>  	if (cpumask_test_cpu(cpu, node_to_cpumask_map[node])) {
>  		cpumask_clear_cpu(cpu, node_to_cpumask_map[node]);
>  	} else {
> -		printk(KERN_ERR "WARNING: cpu %lu not found in node %d\n",
> -		       cpu, node);
> +		pr_warn("WARNING: cpu %lu not found in node %d\n", cpu, node);
>  	}
>  }

The full function is:

static void unmap_cpu_from_node(unsigned long cpu)
{
	int node = numa_cpu_lookup_table[cpu];

	dbg("removing cpu %lu from node %d\n", cpu, node);

	if (cpumask_test_cpu(cpu, node_to_cpumask_map[node])) {
		cpumask_clear_cpu(cpu, node_to_cpumask_map[node]);
	} else {
		printk(KERN_ERR "WARNING: cpu %lu not found in node %d\n",
		       cpu, node);
	}
}


So we look up what node the CPU is on, and then we lookup the set of
CPUs on that node, and they don't match.

That seems like a bug, not a warning.

Have you looked at why we're seeing this warning? It seems like maybe
something else is going wrong to get us into this situation to begin
with.

If there's some good reason why this is happening, and it's truly
harmless, then we can just remove the printk() entirely.

cheers
