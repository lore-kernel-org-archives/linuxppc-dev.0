Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE5B61A0145
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 06:57:57 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 14:57:55 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D73A83E40048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 14:57:52 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t92KvqVD11469238
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 13:57:52 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92Kvq8I002122
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 14:57:52 -0600
Subject: Re: [PATCH] powerpc/pseries: hibernation/migration should honor
 topology update policy
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.ocm>, linuxppc-dev@lists.ozlabs.org
References: <1430848434-25793-1-git-send-email-tyreld@linux.vnet.ibm.ocm>
Cc: mpe@ellerman.id.au, nfont@linux.vnet.ibm.com, nacc@linux.vnet.ibm.com,
 stable@vger.kernel.org
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Message-ID: <560EEFCE.6050409@linux.vnet.ibm.com>
Date: Fri, 2 Oct 2015 13:57:50 -0700
MIME-Version: 1.0
In-Reply-To: <1430848434-25793-1-git-send-email-tyreld@linux.vnet.ibm.ocm>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping?

Don't thing I ever saw anything happen with this patch. On another note
I notice in retrospect the patch subject isn't really stated in
imperative mood. Maybe it would be better as:

powerpc/pseries: make hibernation/migration honor topology update policy

-Tyrel

On 05/05/2015 10:53 AM, Tyrel Datwyler wrote:
> From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> 
> The suspend call paths for hibernation and migration operations call
> stop_topology_update() and start_topology_update() respectively prior to
> suspending the LPAR and upon resume. Topology updating can be
> enabled/disabled from userspace and no check is currently done to determine
> the current policy. This results in topology updates being started upon
> resume from hibernation/migration even in the case where topology updates
> were disabled initially.
> 
> This fixes the issue by storing the current policy and only calling
> start_topology_update() in the case where either PRRN/VPHN were enabled to
> start with.
> 
> Fixes: e04fa61214a3 (powerpc/pseries: Add /proc interface to control topology updates)
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/powerpc/include/asm/topology.h      | 5 +++++
>  arch/powerpc/kernel/rtas.c               | 4 +++-
>  arch/powerpc/mm/numa.c                   | 5 +++++
>  arch/powerpc/platforms/pseries/suspend.c | 5 ++++-
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 5f1048e..44f6519 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -63,6 +63,7 @@ static inline void sysfs_remove_device_from_node(struct device *dev,
>  extern int start_topology_update(void);
>  extern int stop_topology_update(void);
>  extern int prrn_is_enabled(void);
> +extern int vphn_is_enabled(void);
>  #else
>  static inline int start_topology_update(void)
>  {
> @@ -76,6 +77,10 @@ static inline int prrn_is_enabled(void)
>  {
>  	return 0;
>  }
> +static inline int vphn_is_enabled(void)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
> 
>  #include <asm-generic/topology.h>
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 7a488c1..7ae9992 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -906,6 +906,7 @@ int rtas_ibm_suspend_me(u64 handle)
>  	DECLARE_COMPLETION_ONSTACK(done);
>  	cpumask_var_t offline_mask;
>  	int cpuret;
> +	int restart_topology_updates = (prrn_is_enabled() || vphn_is_enabled());
> 
>  	if (!rtas_service_present("ibm,suspend-me"))
>  		return -ENOSYS;
> @@ -957,7 +958,8 @@ int rtas_ibm_suspend_me(u64 handle)
>  	if (atomic_read(&data.error) != 0)
>  		printk(KERN_ERR "Error doing global join\n");
> 
> -	start_topology_update();
> +	if (restart_topology_updates)
> +		start_topology_update();
> 
>  	/* Take down CPUs not online prior to suspend */
>  	cpuret = rtas_offline_cpus_mask(offline_mask);
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 5e80621..885d950 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1593,6 +1593,11 @@ int prrn_is_enabled(void)
>  	return prrn_enabled;
>  }
> 
> +int vphn_is_enabled(void)
> +{
> +	return vphn_enabled;
> +}
> +
>  static int topology_read(struct seq_file *file, void *v)
>  {
>  	if (vphn_enabled || prrn_enabled)
> diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
> index e76aefa..b5f92e2 100644
> --- a/arch/powerpc/platforms/pseries/suspend.c
> +++ b/arch/powerpc/platforms/pseries/suspend.c
> @@ -147,6 +147,7 @@ static ssize_t store_hibernate(struct device *dev,
>  {
>  	cpumask_var_t offline_mask;
>  	int rc;
> +	int restart_topology_updates = (prrn_is_enabled() || vphn_is_enabled);
> 
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> @@ -175,7 +176,9 @@ static ssize_t store_hibernate(struct device *dev,
> 
>  		stop_topology_update();
>  		rc = pm_suspend(PM_SUSPEND_MEM);
> -		start_topology_update();
> +
> +		if (restart_topology_updates)
> +			start_topology_update();
> 
>  		/* Take down CPUs not online prior to suspend */
>  		if (!rtas_offline_cpus_mask(offline_mask))
> 
