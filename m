Date: Mon, 7 Jun 2004 02:26:22 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Marius Groeger <mgroeger@sysgo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] Simple ioremap cache
Message-ID: <20040607092622.GA31404@gate.ebshome.net>
References: <20040605002915.GA17603@gate.ebshome.net> <Pine.LNX.4.56.0406070931180.3147@mag.sysgo.com> <20040607084812.GA5808@gate.ebshome.net> <Pine.LNX.4.56.0406071100110.11623@mag.sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.56.0406071100110.11623@mag.sysgo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 07, 2004 at 11:12:42AM +0200, Marius Groeger wrote:
> > > To do this, I think you also need
> > > to flag a bigger virtual page size to the MMU, eg. program a different
> > > PAGESZ_* value (see include/asm-ppc/mmu.h). If you don't, the MMU has to
> > > manage diffent chunks all the same, they just happen to be virtually
> > > contiguous.
> >
> > I don't follow you here, sorry. Could you give some examples with
> > the real TLB contents for the cases you are describing?
>
> What I mean is to merge/coaelsce individual mappings within the same
> IO area. Eg., consider an IO area with multiple resources at
> 0xd000.0000 spanning more than one 4k page. Now, driver A requests
> access to a page at 0xd0000.0100, and driver B wants to access
> 0xd0003.0400. Usually, this would lead to 2 diffent mapping entries
> for the following phys base/size pairs (0xd0000.0000, 0x1000);
> (0xd0003.0000, 0x1000). With optimization, this could be handled by
> one mapping at 0xd0000.0000 spanning a 16k page. It's a bit like when
> BATs are used to cover larger chunks.
>
> Again, this was an idea we had a while ago. I don't know how much real
> remedy is in implementing it. There once was also talk about a "big
> TLB" patch. I haven't checked if this is already part of 2.5/2.6.

Yeah, I see now.

This kind of coalescing might be useful for PCI device drivers ioremaps (I saw
some adjacent mappings on tipb - I _think_ they were different PCI peripherals)

>
> > What do you mean "just mapping entries" ? TLB slots contain these "mapping
> > entries", that's the whole purpose of TLB.
>
> Yes, but 4xx allows for variable sized TLBs.

Sure, these big TLBs are even used for kernel lowmem mappings on 4xx (again to
save some TLB misses :)

Eugene


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
