Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400rfP3lBMzDqjt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 21:28:12 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/numa: Correct kernel message severity
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com
References: <1520935913-23593-1-git-send-email-vipin@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <29183547-d1c5-5282-86cb-3d5acbade58f@c-s.fr>
Date: Tue, 13 Mar 2018 11:28:04 +0100
MIME-Version: 1.0
In-Reply-To: <1520935913-23593-1-git-send-email-vipin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 13/03/2018 à 11:11, Vipin K Parashar a écrit :
> printk in unmap_cpu_from_node() uses KERN_ERR message severity
> for a WARNING message. Correct message severity to KERN_WARNING.
> 
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> ---
>   arch/powerpc/mm/numa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index edd8d0b..79c94cc 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -163,7 +163,7 @@ static void unmap_cpu_from_node(unsigned long cpu)
>   	if (cpumask_test_cpu(cpu, node_to_cpumask_map[node])) {
>   		cpumask_clear_cpu(cpu, node_to_cpumask_map[node]);
>   	} else {
> -		printk(KERN_ERR "WARNING: cpu %lu not found in node %d\n",
> +		printk(KERN_WARNING "WARNING: cpu %lu not found in node %d\n",
 >   		       cpu, node);

Why not take the opportunity to use pr_warn() instead, hence to put back 
the cpu and node vars on the same line.

Christophe

>   	}
>   }
> 
