Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66A4EDDED9
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 07:38:28 +1000 (EST)
Subject: Re: [RFC] [PATCH] PowerPC: Add 64-bit phys addr support to 32-bit pci.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20070918221811.57b92c18@localhost.localdomain>
References: <DF9456FB-459D-4800-B994-D9B198096069@kernel.crashing.org>
	<20070918160754.GA22698@ru.mvista.com>
	<20070918221811.57b92c18@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 07:38:20 +1000
Message-Id: <1190151501.6403.113.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > @@ -879,11 +891,18 @@
> >  	prev = NULL;
> >  	while ((rlen -= np * sizeof(unsigned int)) >= 0) {
> >  		if (prev) {
> > -			if (prev[0] == ranges[0] && prev[1] == ranges[1] &&
> > -				(prev[2] + prev[na+4]) == ranges[2] &&
> > -				(prev[na+2] + prev[na+4]) == ranges[na+2]) {
> > -				prev[na+4] += ranges[na+4];
> > +			prev_pci_space = prev[0];
> > +			prev_pci_addr = pci_get_range64(&prev[1]);
> > +			prev_size = pci_get_range64(&prev[na+3]);
> > +			pci_space = ranges[0];
> > +			pci_addr = pci_get_range64(&ranges[1]);
> > +			if ((prev_pci_space == pci_space) && 
> > +			    ((prev_pci_addr + prev_size) == pci_addr)) {
> > +				size = pci_get_range64(&ranges[na+3]);
> > +				prev_size += size;
> >  				ranges[0] = 0;
> > +				prev[na+3] = (u32)((prev_size >> 32) & 0xffffffff);
> > +				prev[na+4] = (u32)(prev_size & 0xffffffff);
> >  				ranges += np;
> >  				continue;
> 
> I do think that ranges hacking (even on a copy) to cope with contiguous ranges is not a good deed. And nobody would object the upper looks horrible from the maintenance POV.
> >  			

Yes, hacking of ranges shouldn't be done there. PowerMac does range
coalescing separately, we can move this to some generic place maybe and
use it where needed.

Just make everything use resource_size_t in the PCI bits and u64 in the
parsing bits.

> This is not correct - it should depend on #ac of the parent node.
> But I'll stop right here - there is no deep mutual difference between 32 & 64 bit so that to keep 2 similar implementations, none of which (esp 32bit) really comply the spec. It should work the same way, and, if there are differences, they should be handled
> explicitly, and, of course, reconsidered if they make sense (like isa_io_base, absense of io_size in ppc32 and so on)
> 
> I am *not* telling here that my implementation is the only true way around. But we need to improve and make code cleaner rather then just extend existing error-prone approach.

We need to merge 32 and 64 bits here for sure.

Ben.
