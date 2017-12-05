Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrvwQ57ljzDrpj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 08:27:33 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB5LO7NQ051470
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Dec 2017 16:27:31 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ep29cb0g2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Dec 2017 16:27:31 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 5 Dec 2017 14:27:30 -0700
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vB5LRTbd4849956
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Dec 2017 14:27:29 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22AF36A03D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 14:27:29 -0700 (MST)
Received: from [9.41.92.213] (unknown [9.41.92.213])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP id F07076A043
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 14:27:28 -0700 (MST)
Subject: Re: [PATCH] powerpc/numa: Invalidate numa_cpu_lookup_table on cpu
 remove
To: linuxppc-dev@lists.ozlabs.org
References: <151250734088.18010.16614705059743383721.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 5 Dec 2017 15:27:28 -0600
MIME-Version: 1.0
In-Reply-To: <151250734088.18010.16614705059743383721.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <58b7d497-f63b-ea38-641f-4226ff72ceb0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Disregard. I'll send an updated patch soon.

-Nathan

On 12/05/2017 02:55 PM, Nathan Fontenot wrote:
> When DLPAR removing a CPU, the unmapping of the cpu from a node in
> unmap_cpu_from_node() should also invalidate the CPUs entry in the
> numa_cpu_lookup_table. There is not a guarantee that on a subsequent
> DLPAR add of the CPU the associativity will be the same and thus
> could be in a different node. Invalidating the entry in the
> numa_cpu_lookup_table causes the associativity to be read from the
> device tree at the time of the add.
> 
> The current behavior of not invalidating the CPUs entry in the
> numa_cpu_lookup_table can result in scenarios where the the topology
> layout of CPUs in the partition does not match the device tree
> or the topology reported by the HMC.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index adb6364f4091..415b1a76b429 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -164,6 +164,8 @@ static void unmap_cpu_from_node(unsigned long cpu)
> 
>  	dbg("removing cpu %lu from node %d\n", cpu, node);
> 
> +	update_numa_cpu_lookup_table(cpu, -1);
> +
>  	if (cpumask_test_cpu(cpu, node_to_cpumask_map[node])) {
>  		cpumask_clear_cpu(cpu, node_to_cpumask_map[node]);
>  	} else {
> 
