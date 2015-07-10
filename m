Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47C131A0225
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2015 02:25:39 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 10 Jul 2015 10:25:37 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id F07BD1FF002E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 10:16:43 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t6AGOokT41812168
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 09:24:50 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6AGPWFZ001148
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 10:25:33 -0600
Date: Fri, 10 Jul 2015 09:25:31 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Rientjes <rientjes@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] powerpc/numa: fix cpu_to_node() usage during boot
Message-ID: <20150710162531.GE44862@linux.vnet.ibm.com>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1507081811280.16585@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1507081811280.16585@chino.kir.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08.07.2015 [18:22:09 -0700], David Rientjes wrote:
> On Thu, 2 Jul 2015, Nishanth Aravamudan wrote:
> 
> > Much like on x86, now that powerpc is using USE_PERCPU_NUMA_NODE_ID, we
> > have an ordering issue during boot with early calls to cpu_to_node().
> > The value returned by those calls now depend on the per-cpu area being
> > setup, but that is not guaranteed to be the case during boot. Instead,
> > we need to add an early_cpu_to_node() which doesn't use the per-CPU area
> > and call that from certain spots that are known to invoke cpu_to_node()
> > before the per-CPU areas are not configured.
> > 
> > On an example 2-node NUMA system with the following topology:
> > 
> > available: 2 nodes (0-1)
> > node 0 cpus: 0 1 2 3
> > node 0 size: 2029 MB
> > node 0 free: 1753 MB
> > node 1 cpus: 4 5 6 7
> > node 1 size: 2045 MB
> > node 1 free: 1945 MB
> > node distances:
> > node   0   1 
> >   0:  10  40 
> >   1:  40  10 
> > 
> > we currently emit at boot:
> > 
> > [    0.000000] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
> > 
> > After this commit, we correctly emit:
> > 
> > [    0.000000] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7 
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > 
> > diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> > index 5f1048e..f2c4c89 100644
> > --- a/arch/powerpc/include/asm/topology.h
> > +++ b/arch/powerpc/include/asm/topology.h
> > @@ -39,6 +39,8 @@ static inline int pcibus_to_node(struct pci_bus *bus)
> >  extern int __node_distance(int, int);
> >  #define node_distance(a, b) __node_distance(a, b)
> >  
> > +extern int early_cpu_to_node(int);
> > +
> >  extern void __init dump_numa_cpu_topology(void);
> >  
> >  extern int sysfs_add_device_to_node(struct device *dev, int nid);
> > diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> > index c69671c..23a2cf3 100644
> > --- a/arch/powerpc/kernel/setup_64.c
> > +++ b/arch/powerpc/kernel/setup_64.c
> > @@ -715,8 +715,8 @@ void __init setup_arch(char **cmdline_p)
> >  
> >  static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align)
> >  {
> > -	return __alloc_bootmem_node(NODE_DATA(cpu_to_node(cpu)), size, align,
> > -				    __pa(MAX_DMA_ADDRESS));
> > +	return __alloc_bootmem_node(NODE_DATA(early_cpu_to_node(cpu)), size,
> > +				    align, __pa(MAX_DMA_ADDRESS));
> >  }
> >  
> >  static void __init pcpu_fc_free(void *ptr, size_t size)
> > @@ -726,7 +726,7 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
> >  
> >  static int pcpu_cpu_distance(unsigned int from, unsigned int to)
> >  {
> > -	if (cpu_to_node(from) == cpu_to_node(to))
> > +	if (early_cpu_to_node(from) == early_cpu_to_node(to))
> >  		return LOCAL_DISTANCE;
> >  	else
> >  		return REMOTE_DISTANCE;
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index 5e80621..9ffabf4 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -157,6 +157,11 @@ static void map_cpu_to_node(int cpu, int node)
> >  		cpumask_set_cpu(cpu, node_to_cpumask_map[node]);
> >  }
> >  
> > +int early_cpu_to_node(int cpu)
> > +{
> > +	return numa_cpu_lookup_table[cpu];
> > +}
> > +
> >  #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PPC_SPLPAR)
> >  static void unmap_cpu_from_node(unsigned long cpu)
> >  {
> > 
> > 
> 
> early_cpu_to_node() looks like it's begging to be __init since we 
> shouldn't have a need to reference to numa_cpu_lookup_table after boot and 
> that appears like it can be done if pcpu_cpu_distance() is made __init in 
> this patch and smp_prepare_boot_cpu() is made __init in the next patch.  
> So I think this is fine, but those functions and things like 
> reset_numa_cpu_lookup_table() should be in init.text.

Yep, that makes total sense!

> After the percpu areas on initialized and cpu_to_node() is correct, it 
> would be really nice to be able to make numa_cpu_lookup_table[] be 
> __initdata since it shouldn't be necessary anymore.  That probably has cpu 
> callbacks that need to be modified to no longer look at 
> numa_cpu_lookup_table[] or pass the value in, but it would make it much 
> cleaner.  Then nobody will have to worry about figuring out whether 
> early_cpu_to_node() or cpu_to_node() is the right one to call.

When I worked on the original pcpu patches for power, I wanted to do
this, but got myself confused and never came back to it. Thank you for
suggesting it and I'll work on it soon.

-Nish
