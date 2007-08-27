Return-Path: <vitb@kernel.crashing.org>
Date: Mon, 27 Aug 2007 12:31:10 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/3] [POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
Message-ID: <20070827123110.4b6f799f@localhost.localdomain>
In-Reply-To: <20070827074955.GE7306@localhost.localdomain>
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825092947.4087.68187.stgit@localhost.localdomain>
	<20070827011515.GA12804@localhost.localdomain>
	<20070827103136.4e0ffc43@localhost.localdomain>
	<20070827074955.GE7306@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 27 Aug 2007 17:49:55 +1000
David Gibson wrote:

> On Mon, Aug 27, 2007 at 10:31:36AM +0400, Vitaly Bordug wrote:
> > On Mon, 27 Aug 2007 11:15:16 +1000
> > David Gibson wrote:
> > 
> > > On Sat, Aug 25, 2007 at 01:29:47PM +0400, Vitaly Bordug wrote:
> [snip]
> > > > +void __devinit pci_process_bridge_OF_ranges(struct
> > > > pci_controller *hose,
> > > > +					    struct device_node
> > > > *dev, int prim) +{
> > > > +	static unsigned int static_lc_ranges[256];
> > > > +	const unsigned int *ranges;
> > > > +	unsigned int *lc_ranges;
> > > > +	unsigned int pci_space;
> > > > +	unsigned long size = 0;
> > > 
> > > size can be 64-bit on 32-bit systems, at least in theory.
> > > 
> > hm, well, but later, we'll call ioremap (at least for IO region)
> > that has size passed as ulong type. And,  such a size could be
> > consumed by the code,only if resource_size_t is 64bit too. I'll
> > look at it further.
> 
> You should probably actually test for that condition though, rather
> than blithely truncating.
> 

ok, makes sense.

> [snip]
> > > > +	/* Map ranges to struct according to spec. */
> > > > +	if (na >= 2) {
> > > > +		ranges64 = (void *)ranges;
> > > > +		ranges_amnt = rlen / sizeof(*ranges64);
> > > > +	} else {
> > > > +		ranges32 = (void *)ranges;
> > > > +		ranges_amnt = rlen / sizeof(*ranges32);
> > > > +	}
> > > > +
> > > > +	hose->io_base_phys = 0;
> > > > +	for (i = 0; i < ranges_amnt; i++) {
> > > > +		res = NULL;
> > > > +		if (ranges64) {
> > > > +			if (ranges64[i].pci_space == 0)
> > > > +				continue;
> > > > +
> > > > +			pci_space = ranges64[i].pci_space;
> > > > +			pci_addr =
> > > > +			    (u64) ranges64[i].pci_addr[0] <<
> > > > 32 | ranges64[i].
> > > > +			    pci_addr[1];
> > > 
> > > Why not just define the pci_addr field in your structures as
> > > u64?  You would have to define the structure with
> > > attribute((packed)), I guess.
> > > 
> > that was in the first approach, but it gets really interesting
> > numbers (and with contents nothing to do with real stuff), on
> > platforms that are pure 32bit. I mean, 
> 
> I'm guessing that's because you didn't put the ((packed)) in: without
> it, gcc will align the 64-bit quantity to a 64-bit boundary, inserting
> 32-bits of padding into the structure between pci_space and pci_addr,
> so that it doesn't actually line up with the ranges property.
> 
will check, but sounds reasonable.

> > u32 foo, foo1;
> > u64 foo64;
> > 
> > foo = bar[1];
> > foo1 = bar[2];
> > foo64 = ((u64)foo << 32) | foo1;
> > 
> > does not seem to work on 32bit board. I may need to write a clear
> > testcase and submit it here, maybe I'm missing something very
> > obvious.
> 
> !?!  shouldn't be anything wrong with that arithmetic...
> 
Wrong example, I'll have real snippet if alignment trick won't work (and I hope it will)

> [snip]
> > > > +			cpu_phys_addr =
> > > > +			    of_translate_address(dev,
> > > > ranges64[i].phys_addr);
> > > > +			/*
> > > > +			 * I haven't observed 2 significant
> > > > size cells in kernel
> > > > +			 * code, so we're accounting only LSB
> > > > of size part
> > > > +			 * from ranges. -vitb
> > > > +			 */
> > > > +			size = ranges64[i].size[1];
> > > > +#ifdef CONFIG_PPC64
> > > > +			if (ranges64[i].size[0])
> > > > +				size |=
> > > > ranges64[i].size[0]<<32; +#endif
> > > > +			DBG("Observed: pci %llx phys %llx size
> > > > %x\n", pci_addr,
> > > > +			    cpu_phys_addr, size);
> > > > +		} else {
> > > > +			if (ranges32[i].pci_space == 0)
> > > > +				continue;
> > > > +
> > > > +			pci_space = (unsigned
> > > > int)ranges32[i].pci_space;
> > > > +			pci_addr = (unsigned
> > > > int)ranges32[i].pci_addr[1];
> > > > +			cpu_phys_addr = (unsigned
> > > > int)ranges32[i].phys_addr[0];
> > > 
> > > 
> > > We should really be using of_translate_address() in all cases -
> > > that's what it's for, after all.
> > > 
> > being called, it gives 0 in 32bit branch of  if () {. Since, iirc,
> > 32bit range parsing does not have it in original, variant,
> > I have it put as is. worths a brief investigation...
> 
> Then we should fix of_translate_address() for 32-bit....
> 
> I don't think this patch is actually required for the 44x pci support,
> yes?  It might be better to leave this until later - it's only a tiny
> piece of all the consolidations we should do between ppc32 and ppc64
> PCI code.  Currently there are a lot of silly, subtle differences
> between them :(.

Well, my point is:
	- pci_32.c ranges parsing code is confusing and silly in many
	ways

	- there is no obvious way to enable 64bit phys addressed
	handled correctly there.
	possible approaches may bring more problems than solve.

	- completely correct is going to be *hard* as David noted, but
	we can consider effective merge(with code flow similar to existing funcs) of existing
	bits a good starting point. Else, when a lot of stufpci_process_bridge_OF_rangesf would depend on 
	both functions, it would be too painful to rewrite.
	(speaking about pci_process_bridge_OF_ranges here)
	  

> 
> > > > +			size = ranges32[i].size[1];
> > > > +
> > > > +			DBG("Observed: pci %x phys %x size
> > > > %x\n",
> > > > +			    (u32) pci_addr, (u32)
> > > > cpu_phys_addr, size);
> > > > +		}
> > > 
> > > You don't have any equivalent of the code that exists in both
> > > pre-existing versions to coalesce contiguous ranges.  You probably
> > > want to use the 64-bit version, since that doesn't need a local
> > > copy of the ranges.
> > > 
> > correct. yet, the whole aim of the upper seems to use summary size
> > of contiguous block and that's it.
> > How would we recognize IORESOURCE_PREFETCH then? (I know, my code
> > is missing that prefetch regions so far, but anyway).
> > >From the code, it seems to declare each resource that is part of
> > >contiguous block, with the size of entire block.
> > 
> > That's prolly from binding, but can you please elaborate the logic
> > for better understanding?
> 
> The attributes such as PREFETCH are encoded into cell 0 of the 3-cell
> OF PCI address.  So, ranges with different attributes won't appear as
> contiguous in this space.
> 
ok, I think there's no problem to implement it in the new func then.

-- 
Sincerely, Vitaly
