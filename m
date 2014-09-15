Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57A191A0027
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 09:55:18 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 15 Sep 2014 19:55:15 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CB07D6E8029
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 19:54:59 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8FNtBBp47055098
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 23:55:11 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8FNtA7J003600
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 19:55:11 -0400
Date: Mon, 15 Sep 2014 16:54:55 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH] powerpc/numa: add ability to disable and debug
 topology updates
Message-ID: <20140915235455.GB5238@linux.vnet.ibm.com>
References: <20140909200913.GG22906@linux.vnet.ibm.com>
 <1410757536.32643.1.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410757536.32643.1.camel@concordia>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 15.09.2014 [15:05:36 +1000], Michael Ellerman wrote:
> On Tue, 2014-09-09 at 13:09 -0700, Nishanth Aravamudan wrote:
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
> 
> Boot-time parameters are kind of a pain, not least because they
> require a reboot to activate.

Thanks for the review, this is a good point. In the case we're
hitting, we're actually crashing at boot because of possibly dodgy
firmware data.

> Does it really need to be a boot param, or could it be a debugfs or
> sysctl flag? ie. do we need to disable it immediately at boot or would
> it be OK if it was /etc/rc.local or similar that turned it off ?

We need it off at boot, potentially. An LPAR does not indicate that it
will or will not respond to the events in any synchronous fashion, so
the hypervisor is free to send them to us whenever.

> It looks like arch_update_cpu_topology() is called quite early, from
> init_sched_domains(), but in that case I don't see how
> cpu_associativity_changes_mask can be non-zero, ie. we'll never do any
> work via that path.

Correct, that path is probably fine. But we can get these hypervisor
events fairly early in boot.

> As far as the debug goes, we could just use pr_debug() with
> CONFIG_DYNAMIC_DEBUG, it's not quite as easy to enable as a kernel
> parameter but for the odd bit of debugging it should be fine.

That's a good point, I wonder with that mechanism if we should perhaps
extend/remove other static debugging methods in favor of that (e.g.,
numa=debug)?

> I guess the downside there is you have to do some work before you know
> if you're printing anything out. More below ...
> 
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
> 
> Can you add a:
> 	#define pr_fmt(fmt) "numa: " fmt
> 
> At the top of the file and then use pr_xxx() for these?

Yes.

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
> > 	weight = cpumask_weight(&cpu_associativity_changes_mask);
> > 	if (!weight)
> > 		return 0;
> > @@ -1610,6 +1635,25 @@ int arch_update_cpu_topology(void)
> >  	 *
> >  	 * And for the similar reason, we will skip all the following updating.
> >  	 */
> 
> The comment should stay attached to the check below of updated_cpus, ie. this
> block should preceed the comment.

Yep.

> > +	if (topology_updates_debug) {
> > +		char *buf = kmalloc_array(NR_CPUS*5, sizeof(char), GFP_KERNEL);
> > +		cpumask_scnprintf(buf, NR_CPUS*5, &updated_cpus);
> > +		printk(KERN_DEBUG "Topology update for the following CPUs:\n");
> > +		printk(KERN_DEBUG " %s\n", buf);
> > +		printk(KERN_DEBUG "cpumask_weight(&updated_cpus)) = %u\n",
> > +						cpumask_weight(&updated_cpus));
> 
> Do we really need to print the cpumask? The same information is
> available below right, just in a more verbose form?

Yes, sorry, this is a "living" patch, and I haven't fully cleaned it up.
Will remove the cpumask bodge in v2.

> Assuming we can skip that we can just use pr_debug() for these I think
> and drop the debug flag. Or is this a super hot-path that I'm not
> aware of?

Not super hot, but when it breaks, your LPAR is unusable.

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
> 
> It was already broken, but can you fix the (lack of) error handling
> here please?

Yep, will make it the first patch in the series.

-Nish
