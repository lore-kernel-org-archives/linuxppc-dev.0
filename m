Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B9A3B6FCB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 21:08:26 +1000 (EST)
Subject: Re: powerpc: Make early memory scan more resilient to out of order
	nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <benh-inital-memory@mdm.bga.com>
References: <1305183498.29820.95.camel@pasglop>
	<benh-inital-memory@mdm.bga.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 May 2011 21:08:18 +1000
Message-ID: <1305198498.29820.96.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-05-12 at 03:09 -0500, Milton Miller wrote:
> On Wed, 11 May 2011 about 20:58:18 -0000, Benjamin Herrenschmidt wrote:
> > We keep track of the size of the lowest block of memory and call
> > setup_initial_memory_limit() only after we've parsed them all
> > 
> 
> Good, we lose our sensitivity to device node ordering.

Yup, A platform we'll release soon has all of them backward :-)

> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> 
> > index 584b398..27475c6 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -70,6 +70,7 @@ int __initdata iommu_force_on;
> >  unsigned long tce_alloc_start, tce_alloc_end;
> >  u64 ppc64_rma_size;
> >  #endif
> > +static phys_addr_t first_memblock_size;
> 
> __initdata 
> 
> (its only referenced by 2 __init functions)
> 
> Acked-by: Milton Miller <miltonm@bga.com>

Ag good, I'll fold that in, thanks.

Cheers,
Ben.

> 
> >  static int __init early_parse_mem(char *p)
> >  {
> ..
> > @@ -507,11 +508,14 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
> ..
> > @@ -708,6 +712,7 @@ void __init early_init_devtree(void *params)
