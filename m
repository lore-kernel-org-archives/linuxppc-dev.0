Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401PHb526KzDqsV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:58:50 +1100 (AEDT)
Subject: Re: [PATCH v2] powerpc/numa: Correct kernel message severity
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com
References: <1521013954-21348-1-git-send-email-vipin@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <e3ad74a9-4cf6-ff62-0840-30732aee129d@c-s.fr>
Date: Wed, 14 Mar 2018 08:58:45 +0100
MIME-Version: 1.0
In-Reply-To: <1521013954-21348-1-git-send-email-vipin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 14/03/2018 à 08:52, Vipin K Parashar a écrit :
> printk() in unmap_cpu_from_node() uses KERN_ERR message severity,
> for a WARNING message. Change it to pr_warn().
> 
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/mm/numa.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index edd8d0b..1632f4b 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -163,8 +163,7 @@ static void unmap_cpu_from_node(unsigned long cpu)
>   	if (cpumask_test_cpu(cpu, node_to_cpumask_map[node])) {
>   		cpumask_clear_cpu(cpu, node_to_cpumask_map[node]);
>   	} else {
> -		printk(KERN_ERR "WARNING: cpu %lu not found in node %d\n",
> -		       cpu, node);
> +		pr_warn("WARNING: cpu %lu not found in node %d\n", cpu, node);
>   	}
>   }
>   #endif /* CONFIG_HOTPLUG_CPU || CONFIG_PPC_SPLPAR */
> 
