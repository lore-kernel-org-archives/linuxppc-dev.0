Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wgzH1KqczDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 16:43:35 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4U6dStJ109069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 02:43:33 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j9nhmbb3w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 02:43:32 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Wed, 30 May 2018 07:43:31 +0100
Subject: Re: [PATCH v2] powerpc/numa: Correct kernel message severity
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, Christophe LEROY <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1521013954-21348-1-git-send-email-vipin@linux.vnet.ibm.com>
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 12:13:25 +0530
MIME-Version: 1.0
In-Reply-To: <1521013954-21348-1-git-send-email-vipin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <53e120f0-2f35-05b0-7a18-9eec6ce8da72@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,


Any progress/update with this patch ?

Please do let know, if something more is needed here.


Regards,

Vipin


On Wednesday 14 March 2018 01:22 PM, Vipin K Parashar wrote:
> printk() in unmap_cpu_from_node() uses KERN_ERR message severity,
> for a WARNING message. Change it to pr_warn().
>
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
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
