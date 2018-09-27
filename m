Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Lhgg0bsvzF37b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 03:31:42 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8RHTfYI018311
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:31:40 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ms2amv1y4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:31:40 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 27 Sep 2018 13:31:39 -0400
Subject: Re: [PATCH] powerpc/rtas: Fix a potential race between CPU-Offline &
 Migration
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
References: <1538067112-11493-1-git-send-email-ego@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Thu, 27 Sep 2018 12:31:34 -0500
MIME-Version: 1.0
In-Reply-To: <1538067112-11493-1-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <fa97b7f0-0cef-fc47-6566-216e399ac52a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/27/2018 11:51 AM, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Live Partition Migrations require all the present CPUs to execute the
> H_JOIN call, and hence rtas_ibm_suspend_me() onlines any offline CPUs
> before initiating the migration for this purpose.
> 
> The commit 85a88cabad57
> ("powerpc/pseries: Disable CPU hotplug across migrations")
> disables any CPU-hotplug operations once all the offline CPUs are
> brought online to prevent any further state change. Once the
> CPU-Hotplug operation is disabled, the code assumes that all the CPUs
> are online.
> 
> However, there is a minor window in rtas_ibm_suspend_me() between
> onlining the offline CPUs and disabling CPU-Hotplug when a concurrent
> CPU-offline operations initiated by the userspace can succeed thereby
> nullifying the the aformentioned assumption. In this unlikely case
> these offlined CPUs will not call H_JOIN, resulting in a system hang.
> 
> Fix this by verifying that all the present CPUs are actually online
> after CPU-Hotplug has been disabled, failing which we return from
> rtas_ibm_suspend_me() with -EBUSY.

Would we also want to havr the ability to re-try onlining all of the cpus
before failing the migration?

This would involve a bigger code change as the current code to online all
CPUs would work in its current form.

-Nathan

> 
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/rtas.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 2c7ed31..27f6fd3 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -982,6 +982,16 @@ int rtas_ibm_suspend_me(u64 handle)
>  	}
> 
>  	cpu_hotplug_disable();
> +
> +	/* Check if we raced with a CPU-Offline Operation */
> +	if (unlikely(!cpumask_equal(cpu_present_mask, cpu_online_mask))) {
> +		pr_err("%s: Raced against a concurrent CPU-Offline\n",
> +		       __func__);
> +		atomic_set(&data.error, -EBUSY);
> +		cpu_hotplug_enable();
> +		goto out;
> +	}
> +
>  	stop_topology_update();
> 
>  	/* Call function on all CPUs.  One of us will make the
> 
