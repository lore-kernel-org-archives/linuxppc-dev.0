Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e28esmtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0F01DDE074
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 21:34:00 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id m0IAXjkg009695
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 16:03:45 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0IAXjQl876726
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 16:03:45 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id m0IAXisx030842
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 10:33:44 GMT
Date: Fri, 18 Jan 2008 12:38:24 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC (Take 2)
Message-ID: <20080118070824.GD8973@balbir.in.ibm.com>
References: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
	<1200634493.7806.0.camel@concordia.ozlabs.ibm.com>
	<1200635099.7806.3.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1200635099.7806.3.camel@concordia.ozlabs.ibm.com>
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

* Michael Ellerman <michael@ellerman.id.au> [2008-01-18 16:44:58]:

> On Fri, 2008-01-18 at 16:34 +1100, Michael Ellerman wrote:
> > On Sat, 2007-12-08 at 04:07 +0530, Balbir Singh wrote:
> > > Changelog
> > > 
> > > 1. Get rid of the constant 5 (based on comments from
> > >                                 Geert.Uytterhoeven@sonycom.com)
> > > 2. Implement suggestions from Olof Johannson
> > > 3. Check if cmdline is NULL in fake_numa_create_new_node()
> > > 
> > > Tested with additional parameters from Olof
> > > 
> > > numa=debug,fake=
> > > numa=foo,fake=bar
> > 
> > 
> > I'm not sure why yet, but git bisect tells me it's this patch that's
> > causing the for-2.6.25 tree to explode on boot on cell machines.
> 
> This fixes it, although I'm a little worried about some of the
> removals/movings of node_set_online() in the patch.
> 
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 1666e7d..dcedc26 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -49,7 +49,6 @@ static int __cpuinit fake_numa_create_new_node(unsigned long end_pfn,
>  	static unsigned int fake_nid = 0;
>  	static unsigned long long curr_boundary = 0;
>  
> -	*nid = fake_nid;
>  	if (!p)
>  		return 0;
>  
> @@ -60,6 +59,7 @@ static int __cpuinit fake_numa_create_new_node(unsigned long end_pfn,
>  	if (mem < curr_boundary)
>  		return 0;
>  
> +	*nid = fake_nid;
>  	curr_boundary = mem;
>  
>  	if ((end_pfn << PAGE_SHIFT) > mem) {
> 

This patch makes sense, ideally fake_numa_create_new_node() should
just be a no-op in the case of machines with real NUMA nodes.


-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
