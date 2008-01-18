Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0F96DDEE4
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 21:33:47 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m0IAXGa3024736
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 21:33:16 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0IAbNge267490
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 21:37:23 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0IAXjns008246
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 21:33:46 +1100
Date: Fri, 18 Jan 2008 12:21:46 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC (Take 2)
Message-ID: <20080118065146.GB8973@balbir.in.ibm.com>
References: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
	<1200635703.18783.5.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1200635703.18783.5.camel@concordia.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Michael Ellerman <michael@ellerman.id.au> [2008-01-18 16:55:03]:

> On Sat, 2007-12-08 at 04:07 +0530, Balbir Singh wrote:
> > Here's a dumb simple implementation of fake NUMA nodes for PowerPC. Fake
> > NUMA nodes can be specified using the following command line option
> > 
> 
> > 
> > Comments are as always welcome!
> 
> Here's some :)
> 

Thanks!

> > diff -puN arch/powerpc/mm/numa.c~ppc-fake-numa-easy arch/powerpc/mm/numa.c
> > --- linux-2.6.24-rc4-mm1/arch/powerpc/mm/numa.c~ppc-fake-numa-easy	2007-12-07 21:25:55.000000000 +0530
> > +++ linux-2.6.24-rc4-mm1-balbir/arch/powerpc/mm/numa.c	2007-12-08 03:19:46.000000000 +0530
> > @@ -24,6 +24,8 @@
> >  
> >  static int numa_enabled = 1;
> >  
> > +static char *cmdline __initdata;
> 
> Can you call this fake_numa_args or something, cmdline is a bit generic.
> 


I could if it makes code easier to understand. Will put it in my TODO
list.

> 
> > @@ -39,6 +41,43 @@ static bootmem_data_t __initdata plat_no
> >  static int min_common_depth;
> >  static int n_mem_addr_cells, n_mem_size_cells;
> >  
> > +static int __cpuinit fake_numa_create_new_node(unsigned long end_pfn,
> > +						unsigned int *nid)
> > +{
> > +	unsigned long long mem;
> > +	char *p = cmdline;
> > +	static unsigned int fake_nid = 0;
> > +	static unsigned long long curr_boundary = 0;
> > +
> > +	*nid = fake_nid;
> 
> As I mentioned in my other email I think this is broken, you
> unconditionally overwrite *nid, even if no fake numa was specified?
> 

Aah.. OK.. looks like a BUG. I'll also respond to your other email.


> > +	if (!p)
> > +		return 0;
> > +
> > +	mem = memparse(p, &p);
> > +	if (!mem)
> > +		return 0;
> > +
> > +	if (mem < curr_boundary)
> > +		return 0;
> > +
> > +	curr_boundary = mem;
> > +
> > +	if ((end_pfn << PAGE_SHIFT) > mem) {
> > +		/*
> > +		 * Skip commas and spaces
> > +		 */
> > +		while (*p == ',' || *p == ' ' || *p == '\t')
> > +			p++;
> > +
> > +		cmdline = p;
> > +		fake_nid++;
> > +		*nid = fake_nid;
> > +		dbg("created new fake_node with id %d\n", fake_nid);
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> > +
> >  static void __cpuinit map_cpu_to_node(int cpu, int node)
> >  {
> >  	numa_cpu_lookup_table[cpu] = node;
> > @@ -344,12 +383,14 @@ static void __init parse_drconf_memory(s
> >  			if (nid == 0xffff || nid >= MAX_NUMNODES)
> >  				nid = default_nid;
> >  		}
> > -		node_set_online(nid);
> >  
> >  		size = numa_enforce_memory_limit(start, lmb_size);
> >  		if (!size)
> >  			continue;
> >  
> > +		fake_numa_create_new_node(((start + size) >> PAGE_SHIFT), &nid);
> > +		node_set_online(nid);
> 
> I can't convince myself that this is 100% ok, the moving of
> node_set_online(). At the very least it's a change in behaviour,
> previously we would online the node regardless of the memory limit.
> 

Hmm.. this can be reverted, but do we gain anything by enabling nodes,
even though we are over the memory limit?


> >  		add_active_range(nid, start >> PAGE_SHIFT,
> >  				 (start >> PAGE_SHIFT) + (size >> PAGE_SHIFT));
> >  	}
> > @@ -429,7 +470,6 @@ new_range:
> >  		nid = of_node_to_nid_single(memory);
> >  		if (nid < 0)
> >  			nid = default_nid;
> > -		node_set_online(nid);
> >  
> >  		if (!(size = numa_enforce_memory_limit(start, size))) {
> >  			if (--ranges)
> > @@ -438,6 +478,9 @@ new_range:
> >  				continue;
> >  		}
> >  
> > +		fake_numa_create_new_node(((start + size) >> PAGE_SHIFT), &nid);
> > +		node_set_online(nid);
> 
> Ditto previous comment.
> 

Yes, point noted.

Thanks for your review and problem report.

> cheers
> 
> -- 
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
> 
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
> 
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person



-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
