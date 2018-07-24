Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zqw24CPWzDrS7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 06:39:14 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6OKdBwm092214
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 16:39:11 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ke9knm3pf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 16:39:11 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 24 Jul 2018 16:39:05 -0400
Subject: Re: [PATCH v07 6/9] pmt/numa: Disable arch_update_cpu_topology during
 CPU readd
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
References: <2c5645d4-2911-5e49-5e41-7966fb909142@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 24 Jul 2018 15:38:58 -0500
MIME-Version: 1.0
In-Reply-To: <2c5645d4-2911-5e49-5e41-7966fb909142@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <af12aba9-6fc2-40d8-477d-17348666bdea@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2018 03:18 PM, Michael Bringmann wrote:
> pmt/numa: Disable arch_update_cpu_topology during post migration
> CPU readd updates when evaluating device-tree changes after LPM
> to avoid thread deadlocks trying to update node assignments.
> System timing between all of the threads and timers restarted in
> a migrated system overlapped frequently allowing tasks to start
> acquiring resources (get_online_cpus) needed by rebuild_sched_domains.
> Defer the operation of that function until after the CPU readd has
> completed.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/hotplug-cpu.c |    9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 1906ee57..df1791b 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -26,6 +26,7 @@
>   #include <linux/sched.h>	/* for idle_task_exit */
>   #include <linux/sched/hotplug.h>
>   #include <linux/cpu.h>
> +#include <linux/cpuset.h>
>   #include <linux/of.h>
>   #include <linux/slab.h>
>   #include <asm/prom.h>
> @@ -684,9 +685,15 @@ static int dlpar_cpu_readd_by_index(u32 drc_index)
> 
>   	pr_info("Attempting to re-add CPU, drc index %x\n", drc_index);
> 
> +	arch_update_cpu_topology_suspend();
>   	rc = dlpar_cpu_remove_by_index(drc_index, false);
> -	if (!rc)
> +	arch_update_cpu_topology_resume();
> +
> +	if (!rc) {
> +		arch_update_cpu_topology_suspend();
>   		rc = dlpar_cpu_add(drc_index, false);
> +		arch_update_cpu_topology_resume();
> +	}
> 

A couple of questions...Why not disable across the entire remove and add
operations instead of disabling for each operation?

Also, what about other CPU add/remove routines, do they need to do
similar disabling?

-Nathan

>   	if (rc)
>   		pr_info("Failed to update cpu at drc_index %lx\n",
> 
