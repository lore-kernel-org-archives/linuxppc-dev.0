Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72A4C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 10:51:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281322176F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 10:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281322176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4430zc1pn2zDqJB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 21:51:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4430x52MydzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 21:49:22 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3B4F9AE14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 10:49:19 +0000 (UTC)
Date: Mon, 18 Feb 2019 11:49:17 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v04] powerpc/numa: Perform full re-add of CPU for
 PRRN/VPHN topology update
Message-ID: <20190218114917.5ab865c4@naga>
In-Reply-To: <d8b67f9d-77d0-2be3-15bc-c7f11bc519f7@linux.vnet.ibm.com>
References: <d8b67f9d-77d0-2be3-15bc-c7f11bc519f7@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 14 Feb 2019 09:56:26 -0600
Michael Bringmann <mwb@linux.vnet.ibm.com> wrote:

Hello,

> To: linuxppc-dev@lists.ozlabs.org
> To: linux-kernel@vger.kernel.org
> Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Paul Mackerras <paulus@samba.org>
> Michael Ellerman <mpe@ellerman.id.au>
> Nathan Lynch <nathanl@linux.vnet.ibm.com>
> Corentin Labbe <clabbe@baylibre.com>
> Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Guenter Roeck <linux@roeck-us.net>
> Michael Bringmann <mwb@linux.vnet.ibm.com>
> "Oliver O'Halloran" <oohall@gmail.com>
> Russell Currey <ruscur@russell.cc>
> Haren Myneni <haren@us.ibm.com>
> Al Viro <viro@zeniv.linux.org.uk>
> Kees Cook <keescook@chromium.org>
> Nicholas Piggin <npiggin@gmail.com>
> Rob Herring <robh@kernel.org>
> Juliet Kim <minkim@us.ibm.com>
> Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> Date: 2018-11-05 16:14:12 -0600
> Subject: [PATCH v04] powerpc/numa: Perform full re-add of CPU for PRRN/VPHN topology update

Looks like something went wrong with the e-mail headers.

Maybe you should re-send?

Thanks

Michal

> 
> On pseries systems, performing changes to a partition's affinity
> can result in altering the nodes a CPU is assigned to the
> current system.  For example, some systems are subject to resource
> balancing operations by the operator or control software.  In such
> environments, system CPUs may be in node 1 and 3 at boot, and be
> moved to nodes 2, 3, and 5, for better performance.
> 
> The current implementation attempts to recognize such changes within
> the powerpc-specific version of arch_update_cpu_topology to modify a
> range of system data structures directly.  However, some scheduler
> data structures may be inaccessible, or the timing of a node change
> may still lead to corruption or error in other modules (e.g. user
> space) which do not receive notification of these changes.
> 
> This patch modifies the PRRN/VPHN topology update worker function to
> recognize an affinity change for a CPU, and to perform a full DLPAR
> remove and add of the CPU instead of dynamically changing its node
> to resolve this issue.
> 
> [Based upon patch submission:
> Subject: [PATCH] powerpc/pseries: Perform full re-add of CPU for topology update post-migration
> From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Date: Tue Oct 30 05:43:36 AEDT 2018
> ]
> 
> [Replace patch submission:
> Subject: [PATCH] powerpc/topology: Update numa mask when cpu node mapping changes
> From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Date: Wed Oct 10 15:24:46 AEDT 2018
> ]
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> Changes in v04:
>   -- Revise tests in topology_timer_fn to check vphn_enabled before prrn_enabled
>   -- Remove unnecessary changes to numa_update_cpu_topology
> Changes in v03:
>   -- Fixed under-scheduling of topo updates.
> Changes in v02:
>   -- Reuse more of the previous implementation to reduce patch size
>   -- Replace former calls to numa_update_cpu_topology(false) by
>      topology_schedule_update
>   -- Make sure that we report topology changes back through
>      arch_update_cpu_topology
>   -- Fix problem observed in powerpc next kernel with updating
>      cpu_associativity_changes_mask in timer_topology_fn when both
>      prrn_enabled and vphn_enabled, and many extra CPUs are possible,
>      but not installed.
>   -- Fix problem with updating cpu_associativity_changes_mask when
>      VPHN associativity information does not arrive until after first
>      call to update topology occurs.
> ---
>  arch/powerpc/include/asm/topology.h |    7 +----
>  arch/powerpc/kernel/rtasd.c         |    2 +
>  arch/powerpc/mm/numa.c              |   47 +++++++++++++++++++++++------------
>  3 files changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index f85e2b01c3df..79505c371fd5 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -42,7 +42,7 @@ extern void __init dump_numa_cpu_topology(void);
>  
>  extern int sysfs_add_device_to_node(struct device *dev, int nid);
>  extern void sysfs_remove_device_from_node(struct device *dev, int nid);
> -extern int numa_update_cpu_topology(bool cpus_locked);
> +extern void topology_schedule_update(void);
>  
>  static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node)
>  {
> @@ -77,10 +77,7 @@ static inline void sysfs_remove_device_from_node(struct device *dev,
>  {
>  }
>  
> -static inline int numa_update_cpu_topology(bool cpus_locked)
> -{
> -	return 0;
> -}
> +static inline void topology_schedule_update(void) {}
>  
>  static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node) {}
>  
> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> index 8a1746d755c9..b1828de7ab78 100644
> --- a/arch/powerpc/kernel/rtasd.c
> +++ b/arch/powerpc/kernel/rtasd.c
> @@ -285,7 +285,7 @@ static void handle_prrn_event(s32 scope)
>  	 * the RTAS event.
>  	 */
>  	pseries_devicetree_update(-scope);
> -	numa_update_cpu_topology(false);
> +	topology_schedule_update();
>  }
>  
>  static void handle_rtas_event(const struct rtas_error_log *log)
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index b5d1c45c1475..eb63479f09d7 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1077,6 +1077,8 @@ static int prrn_enabled;
>  static void reset_topology_timer(void);
>  static int topology_timer_secs = 1;
>  static int topology_inited;
> +static int topology_update_in_progress;
> +static int topology_changed;
>  
>  /*
>   * Change polling interval for associativity changes.
> @@ -1297,9 +1299,9 @@ static int update_lookup_table(void *data)
>   * Update the node maps and sysfs entries for each cpu whose home node
>   * has changed. Returns 1 when the topology has changed, and 0 otherwise.
>   *
> - * cpus_locked says whether we already hold cpu_hotplug_lock.
> + * readd_cpus: Also readd any CPUs that have changed affinity
>   */
> -int numa_update_cpu_topology(bool cpus_locked)
> +static int numa_update_cpu_topology(bool readd_cpus)
>  {
>  	unsigned int cpu, sibling, changed = 0;
>  	struct topology_update_data *updates, *ud;
> @@ -1307,7 +1309,8 @@ int numa_update_cpu_topology(bool cpus_locked)
>  	struct device *dev;
>  	int weight, new_nid, i = 0;
>  
> -	if (!prrn_enabled && !vphn_enabled && topology_inited)
> +	if ((!prrn_enabled && !vphn_enabled && topology_inited) ||
> +		topology_update_in_progress)
>  		return 0;
>  
>  	weight = cpumask_weight(&cpu_associativity_changes_mask);
> @@ -1318,6 +1321,8 @@ int numa_update_cpu_topology(bool cpus_locked)
>  	if (!updates)
>  		return 0;
>  
> +	topology_update_in_progress = 1;
> +
>  	cpumask_clear(&updated_cpus);
>  
>  	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
> @@ -1339,16 +1344,21 @@ int numa_update_cpu_topology(bool cpus_locked)
>  
>  		new_nid = find_and_online_cpu_nid(cpu);
>  
> -		if (new_nid == numa_cpu_lookup_table[cpu]) {
> +		if ((new_nid == numa_cpu_lookup_table[cpu]) ||
> +			!cpu_present(cpu)) {
>  			cpumask_andnot(&cpu_associativity_changes_mask,
>  					&cpu_associativity_changes_mask,
>  					cpu_sibling_mask(cpu));
> -			dbg("Assoc chg gives same node %d for cpu%d\n",
> +			if (cpu_present(cpu))
> +				dbg("Assoc chg gives same node %d for cpu%d\n",
>  					new_nid, cpu);
>  			cpu = cpu_last_thread_sibling(cpu);
>  			continue;
>  		}
>  
> +		if (readd_cpus)
> +			dlpar_cpu_readd(cpu);
> +
>  		for_each_cpu(sibling, cpu_sibling_mask(cpu)) {
>  			ud = &updates[i++];
>  			ud->next = &updates[i];
> @@ -1390,7 +1400,7 @@ int numa_update_cpu_topology(bool cpus_locked)
>  	if (!cpumask_weight(&updated_cpus))
>  		goto out;
>  
> -	if (cpus_locked)
> +	if (!readd_cpus)
>  		stop_machine_cpuslocked(update_cpu_topology, &updates[0],
>  					&updated_cpus);
>  	else
> @@ -1401,9 +1411,9 @@ int numa_update_cpu_topology(bool cpus_locked)
>  	 * offline CPUs. It is best to perform this update from the stop-
>  	 * machine context.
>  	 */
> -	if (cpus_locked)
> +	if (!readd_cpus)
>  		stop_machine_cpuslocked(update_lookup_table, &updates[0],
> -					cpumask_of(raw_smp_processor_id()));
> +			     cpumask_of(raw_smp_processor_id()));
>  	else
>  		stop_machine(update_lookup_table, &updates[0],
>  			     cpumask_of(raw_smp_processor_id()));
> @@ -1420,35 +1430,40 @@ int numa_update_cpu_topology(bool cpus_locked)
>  	}
>  
>  out:
> +	topology_update_in_progress = 0;
>  	kfree(updates);
>  	return changed;
>  }
>  
>  int arch_update_cpu_topology(void)
>  {
> -	return numa_update_cpu_topology(true);
> +	return numa_update_cpu_topology(false);
>  }
>  
>  static void topology_work_fn(struct work_struct *work)
>  {
> -	rebuild_sched_domains();
> +	lock_device_hotplug();
> +	if (numa_update_cpu_topology(true))
> +		rebuild_sched_domains();
> +	unlock_device_hotplug();
>  }
>  static DECLARE_WORK(topology_work, topology_work_fn);
>  
> -static void topology_schedule_update(void)
> +void topology_schedule_update(void)
>  {
> -	schedule_work(&topology_work);
> +	if (!topology_update_in_progress)
> +		schedule_work(&topology_work);
>  }
>  
>  static void topology_timer_fn(struct timer_list *unused)
>  {
> -	if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
> -		topology_schedule_update();
> -	else if (vphn_enabled) {
> +	if (vphn_enabled) {
>  		if (update_cpu_associativity_changes_mask() > 0)
>  			topology_schedule_update();
>  		reset_topology_timer();
>  	}
> +	else if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
> +		topology_schedule_update();
>  }
>  static struct timer_list topology_timer;
>  
> @@ -1553,7 +1568,7 @@ void __init shared_proc_topology_init(void)
>  	if (lppaca_shared_proc(get_lppaca())) {
>  		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
>  			    nr_cpumask_bits);
> -		numa_update_cpu_topology(false);
> +		topology_schedule_update();
>  	}
>  }
>  
> 

