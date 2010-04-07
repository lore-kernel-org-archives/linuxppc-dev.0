Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70884B7D27
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 14:57:38 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id o374vZYD022076
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Apr 2010 10:27:35 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o374vYsa2805802
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Apr 2010 10:27:34 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o374vXQ2021617
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Apr 2010 10:27:34 +0530
Date: Wed, 7 Apr 2010 10:27:18 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] powerpc: add support for new hcall H_BEST_ENERGY
Message-ID: <20100407045718.GA14391@dirshya.in.ibm.com>
References: <20100303181822.GH5439@dirshya.in.ibm.com>
	<1270605889.13812.117.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1270605889.13812.117.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2010-04-07 12:04:49]:

> On Wed, 2010-03-03 at 23:48 +0530, Vaidyanathan Srinivasan wrote:
> > Hi,
> 
> > diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> > index 03dd6a2..fbd93e3 100644
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -359,6 +359,8 @@ void __init check_for_initrd(void)
> >  #ifdef CONFIG_SMP
> >  
> >  int threads_per_core, threads_shift;
> > +EXPORT_SYMBOL_GPL(threads_per_core);
> 
> While I agree it should be exported for the APIs in cputhread.h to be
> usable from a module, this variable shouldn't be -used- directly, but
> only via the API functions in there.

Ok agreed.  This will be the first module to use this and hence will
have to implement the API and export the function.

>  .../...
> 
> > +
> > +#define MODULE_VERS "1.0"
> > +#define MODULE_NAME "pseries_energy"
> > +
> > +/* Helper Routines to convert between drc_index to cpu numbers */
> > +
> > +static u32 cpu_to_drc_index(int cpu)
> > +{
> > +	struct device_node *dn = NULL;
> > +	const int *indexes;
> > +	int i;
> > +	dn = of_find_node_by_name(dn, "cpus");
> 
> Check the result. Also that's not a nice way to do that, you should look
> for /cpus by path I reckon.

I will check the return code, but why do you feel getting the node by
path is better?  Is there any race, or we may have duplicate "cpus"
node?

> > +	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> 
> Check the result here too.

Yes, will do.

> > +	/* Convert logical cpu number to core number */
> > +	i = cpu / threads_per_core;
> 
> Don't use that variable as I said earlier. Use cpu_thread_to_core()

Ack

> > +	/*
> > +	 * The first element indexes[0] is the number of drc_indexes
> > +	 * returned in the list.  Hence i+1 will get the drc_index
> > +	 * corresponding to core number i.
> > +	 */
> > +	WARN_ON(i > indexes[0]);
> > +	return indexes[i + 1];
> > +}
> > +
> > +static int drc_index_to_cpu(u32 drc_index)
> > +{
> > +	struct device_node *dn = NULL;
> > +	const int *indexes;
> > +	int i, cpu;
> > +	dn = of_find_node_by_name(dn, "cpus");
> > +	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> 
> Same comments, check results and use /cpus path

Sure. Will do.

> > +	/*
> > +	 * First element in the array is the number of drc_indexes
> > +	 * returned.  Search through the list to find the matching
> > +	 * drc_index and get the core number
> > +	 */
> > +	for (i = 0; i < indexes[0]; i++) {
> > +		if (indexes[i + 1] == drc_index)
> > +			break;
> > +	}
> > +	/* Convert core number to logical cpu number */
> > +	cpu = i * threads_per_core;
> 
> Here's more annoying as we don't have an API in cputhread.h for that.
> 
> In fact, we have a confusion in there since cpu_first_thread_in_core()
> doesn't actually take a core number ...
> 
> I'm going to recommend a complicated approach but that's the best in the
> long run:
> 
>  - First do a patch that renames cpu_first_thread_in_core() to something
> clearer like cpu_first_thread_in_same_core() or cpu_leftmost_sibling()
> (I think I prefer the later). Rename the few users in
> arch/powerpc/mm/mmu_context_nohash.c and arch/powerpc/kernel/smp.c
> 
>  - Then do a patch that adds a cpu_first_thread_of_core() that takes a
> core number, basically does:
> 
> static inline int cpu_first_thread_of_core(int core)
> {
> 	return core << threads_shift;
> }
> 
>  - Then add your modified H_BEST_ENERGY patch on top of it using the
> above two as pre-reqs :-)

Ok, I can do that change and then base this patch on the new API.

> > +	return cpu;
> > +}
> > +
> > +/*
> > + * pseries hypervisor call H_BEST_ENERGY provides hints to OS on
> > + * preferred logical cpus to activate or deactivate for optimized
> > + * energy consumption.
> > + */
> > +
> > +#define FLAGS_MODE1	0x004E200000080E01
> > +#define FLAGS_MODE2	0x004E200000080401
> > +#define FLAGS_ACTIVATE  0x100
> > +
> > +static ssize_t get_best_energy_list(char *page, int activate)
> > +{
> > +	int rc, cnt, i, cpu;
> > +	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
> > +	unsigned long flags = 0;
> > +	u32 *buf_page;
> > +	char *s = page;
> > +
> > +	buf_page = (u32 *) get_zeroed_page(GFP_KERNEL);
> > +
> Why that blank line ?

I will remove them

> > +	if (!buf_page)
> > +		return 0;
> 
> So here you return 0 instead of -ENOMEM

Will fix.  -ENOMEM is correct.

> > +	flags = FLAGS_MODE1;
> > +	if (activate)
> > +		flags |= FLAGS_ACTIVATE;
> > +
> > +	rc = plpar_hcall9(H_BEST_ENERGY, retbuf, flags, 0, __pa(buf_page),
> > +				0, 0, 0, 0, 0, 0);
> > +
> > +	
> 
> Again, no need for a blank line before xx = foo() and if (xx)

Ack.

> > if (rc != H_SUCCESS) {
> > +		free_page((unsigned long) buf_page);
> > +		return -EINVAL;
> > +	}
> 
> And here you return an error code. Which one is right ?

Returning an error code is correct to user space.  The call will check
for return value on read while getting the list.

Thanks for the detailed review.  I will fix the issues that you
pointed out and post the next version.

--Vaidy
