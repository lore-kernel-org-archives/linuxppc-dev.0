Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D82A1A0003
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 06:11:17 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 16 Sep 2014 16:11:14 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9AFA06E8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 16:10:59 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8GKBBVo4325778
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 20:11:11 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8GKB9DH031920
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 16:11:11 -0400
Date: Tue, 16 Sep 2014 13:10:53 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] powerpc/numa: add ability to disable and debug
 topology updates
Message-ID: <20140916201053.GE5238@linux.vnet.ibm.com>
References: <20140909200913.GG22906@linux.vnet.ibm.com>
 <5418929C.4050401@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5418929C.4050401@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16.09.2014 [14:42:20 -0500], Nathan Fontenot wrote:
> 
> 
> On 09/09/2014 03:09 PM, Nishanth Aravamudan wrote:
> > We have hit a few customer issues with the topology update code (VPHN
> > and PRRN). It would be nice to be able to debug the notifications coming
> > from the hypervisor in both cases to the LPAR, as well as to disable
> > reacting to the notifications, to narrow down the source of the
> > problems. Add a basic level of such functionality, similar to the numa=
> > command-line parameter.
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > ---
> > This is pretty rough, but has been useful in the field already. I'm not
> > sure if more information would be useful than this basic amount.
> > 
> > diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> > index 5ae8608ca9f5..6e3b9e3a2ab4 100644
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -3370,6 +3370,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> >  			e.g. base its process migration decisions on it.
> >  			Default is on.
> >  
> > +	topology_updates= [KNL, PPC, NUMA]
> > +			Format: {off | debug}
> > +			Specify if the kernel should ignore (off) or
> > +			emit more information (debug) when the
> > +			hypervisor sends NUMA topology updates to an
> > +			LPAR.
> > +
> >  	tp720=		[HW,PS2]
> >  
> >  	tpm_suspend_pcr=[HW,TPM]
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index d7737a542fd7..72c5ad313cbe 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -1160,6 +1160,28 @@ static int __init early_numa(char *p)
> >  }
> >  early_param("numa", early_numa);
> >  
> > +static int topology_updates_enabled = 1;
> > +static int topology_updates_debug = 0;
> > +
> > +static int __init early_topology_updates(char *p)
> > +{
> > +	if (!p)
> > +		return 0;
> > +
> > +	if (strstr(p, "off")) {
> > +		printk(KERN_INFO "Disabling topology updates\n");
> > +		topology_updates_enabled = 0;
> > +	}
> > +
> > +	if (strstr(p, "debug")) {
> > +		printk(KERN_INFO "Enabling topology updates debug\n");
> > +		topology_updates_debug = 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +early_param("topology_updates", early_topology_updates);
> > +
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> >  /*
> >   * Find the node associated with a hot added memory section for
> > @@ -1546,6 +1568,9 @@ int arch_update_cpu_topology(void)
> >  	struct device *dev;
> >  	int weight, new_nid, i = 0;
> >  
> > +	if (!topology_updates_enabled)
> > +		return 0;
> > +
> >  	weight = cpumask_weight(&cpu_associativity_changes_mask);
> >  	if (!weight)
> >  		return 0;
> > @@ -1610,6 +1635,25 @@ int arch_update_cpu_topology(void)
> >  	 *
> >  	 * And for the similar reason, we will skip all the following updating.
> >  	 */
> > +
> > +	if (topology_updates_debug) {
> > +		char *buf = kmalloc_array(NR_CPUS*5, sizeof(char), GFP_KERNEL);
> > +		cpumask_scnprintf(buf, NR_CPUS*5, &updated_cpus);
> > +		printk(KERN_DEBUG "Topology update for the following CPUs:\n");
> > +		printk(KERN_DEBUG " %s\n", buf);
> > +		printk(KERN_DEBUG "cpumask_weight(&updated_cpus)) = %u\n",
> > +						cpumask_weight(&updated_cpus));
> > +
> > +		if (cpumask_weight(&updated_cpus)) {
> > +			for (ud = &updates[0]; ud; ud = ud->next) {
> > +				printk(KERN_DEBUG "cpu %d moving from node %d "
> > +						  "to %d\n", ud->cpu,
> > +						  ud->old_nid, ud->new_nid);
> > +			}
> > +		}
> > +		kfree(buf);
> > +	}
> > +
> >  	if (!cpumask_weight(&updated_cpus))
> >  		goto out;
> >  
> > @@ -1807,8 +1851,10 @@ static const struct file_operations topology_ops = {
> >  
> >  static int topology_update_init(void)
> >  {
> > -	start_topology_update();
> > -	proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops);
> > +	if (topology_updates_enabled) {
> > +		start_topology_update();
> > +		proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops);
> > +	}
> >  
> 
> Is there any reason you would want to enable topology updates at some
> later point?
> 
> If so you could still create the /proc file and update it to set
> topology_updates_enabled appropriately in start_topology_update()
> and stop_topology_update().

Oh, that's a good point! I'll adjust the patch accordingly (disable at
boot, leave the run-time twiddle).

-Nish
