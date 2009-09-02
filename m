Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 455F1B7BD5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 15:53:08 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99C79DDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 15:53:07 +1000 (EST)
Subject: Re: [PATCH] Fix fake numa on ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: balbir@linux.vnet.ibm.com
In-Reply-To: <20090901142729.GA5022@balbir.in.ibm.com>
References: <20090901050316.GA4076@in.ibm.com>
	<20090901055753.GB5563@balbir.in.ibm.com>
	<20090901092407.GC4076@in.ibm.com>
	<20090901142729.GA5022@balbir.in.ibm.com>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 15:52:52 +1000
Message-Id: <1251870772.14675.418.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ankita Garg <ankita@in.ibm.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-01 at 19:57 +0530, Balbir Singh wrote:

> > 
> > Heres the updated patch:
> > 
> > Signed-off-by: Ankita Garg <ankita@in.ibm.com> 

The thread is too messy. Please Ankita can you re-submit in proper
form (ie. subject, cset, signed-off & patch) please ?

In general, don't mix reply to comments and new patch submission,
or patchwork gets really confuse. Post a new name, with something
like [PATCH v2] <name of the patch> in the subject.

Thanks.

Cheers,
Ben.

> > Index: linux-2.6.31-rc5/arch/powerpc/mm/numa.c
> > ===================================================================
> > --- linux-2.6.31-rc5.orig/arch/powerpc/mm/numa.c
> > +++ linux-2.6.31-rc5/arch/powerpc/mm/numa.c
> > @@ -26,6 +26,13 @@
> >  #include <asm/smp.h>
> > 
> >  static int numa_enabled = 1;
> > +static int fake_enabled = 1;
> > +
> > +/*
> > + * The array maps a real numa node to the first fake node that gets
> > + * created on it
> > + */
> > +int fake_numa_node_mapping[MAX_NUMNODES];
> > 
> >  static char *cmdline __initdata;
> > 
> > @@ -49,14 +56,29 @@ static int __cpuinit fake_numa_create_ne
> >  	unsigned long long mem;
> >  	char *p = cmdline;
> >  	static unsigned int fake_nid;
> > +	static unsigned int prev_nid = 0;
> >  	static unsigned long long curr_boundary;
> > 
> >  	/*
> >  	 * Modify node id, iff we started creating NUMA nodes
> >  	 * We want to continue from where we left of the last time
> >  	 */
> > -	if (fake_nid)
> > +	if (fake_nid) {
> > +		/*
> > +		 * Moved over to the next real numa node, increment fake
> > +		 * node number and store the mapping of the real node to
> > +		 * the fake node
> > +		 */
> > +		if (prev_nid != *nid) {
> > +			fake_nid++;
> > +			fake_numa_node_mapping[*nid] = fake_nid;
> > +			prev_nid = *nid;
> > +			*nid = fake_nid;
> > +			return 0;
> > +		}
> >  		*nid = fake_nid;
> > +	}
> > +
> >  	/*
> >  	 * In case there are no more arguments to parse, the
> >  	 * node_id should be the same as the last fake node id
> > @@ -440,7 +462,7 @@ static int of_drconf_to_nid_single(struc
> >   */
> >  static int __cpuinit numa_setup_cpu(unsigned long lcpu)
> >  {
> > -	int nid = 0;
> > +	int nid = 0, new_nid;
> >  	struct device_node *cpu = of_get_cpu_node(lcpu, NULL);
> > 
> >  	if (!cpu) {
> > @@ -450,8 +472,15 @@ static int __cpuinit numa_setup_cpu(unsi
> > 
> >  	nid = of_node_to_nid_single(cpu);
> > 
> > +	if (fake_enabled && nid) {
> > +		new_nid = fake_numa_node_mapping[nid];
> > +		if (new_nid > 0)
> > +			nid = new_nid;
> > +	}
> > +
> >  	if (nid < 0 || !node_online(nid))
> >  		nid = any_online_node(NODE_MASK_ALL);
> > +
> >  out:
> >  	map_cpu_to_node(lcpu, nid);
> > 
> > @@ -1005,8 +1034,12 @@ static int __init early_numa(char *p)
> >  		numa_debug = 1;
> > 
> >  	p = strstr(p, "fake=");
> > -	if (p)
> > +	if (p) {
> >  		cmdline = p + strlen("fake=");
> > +		if (numa_enabled) {
> > +			fake_enabled = 1;
> > +		}
> > +	}
> > 
> >  	return 0;
> >  }
> >
> 
> 
> Looks good to me
> 
> 
> Reviewed-by: Balbir Singh <balbir@linux.vnet.ibm.com>
>  
> 
> 
