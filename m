Message-ID: <3CFF1624.2070808@embeddededge.com>
Date: Thu, 06 Jun 2002 03:58:28 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
References: <20020531042153.GD16537@zax>	<3CFC0D3F.9030901@embeddededge.com>	<20020604035947.GH2762@zax>	<3CFCFC20.80101@embeddededge.com>	<15614.37065.549142.218906@argo.ozlabs.ibm.com>	<3CFEE9A3.5060300@embeddededge.com> <15614.63160.272890.683586@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> .... I didn't think we were getting "there"
> (i.e. towards having a device tree) at all yet on systems without OF
> though.

It was one of the first things Ben and I discussed long ago before
this bi_rec stuff appeared.  We were just going to have the bootloaders
build OF-like device tree........and I'll just stop that discussion
right here :-)


> As for iopa(), what I mainly don't like is its use in virt_to_phys and
> virt_to_bus.

That's just because there wasn't any other well defined interface to
get the information, and it's the way m68k/APUS (IIRC) did it.  There
have been discussions going on forever about the demise of virt_to_*
functions which I thought would have occurred by now.

> ....  The reason for that is that every other architecture
> restricts the use of virt_to_phys/bus to addresses that are part of
> the kernel mapping of lowmem,

I know, and I've been exposed to operating systems that have emerged
from this primitive state long ago :-)  It's hard to go back to early-80's
designs :-)


> .... If a driver uses
> consistent_alloc or pci_alloc_consistent, the driver should save and
> use the physical address returned by those functions.

But, that's a relatively new addition and the support of these functions
in a non cache coherent system requires the use of something like iopa().
We allocate a contiguous virtual space to remap the pages we wish to
change cache attributes.  We can't find the physical addresses associated
with these pages unless we search the page tables.  Prior to having
consistent_* we had to do this behind the curtains and needed iopa() to
get the proper mapping result.

> .....  Ideally we
> would have analogous routines to pci_[un]map_single for the on-chip
> devices.

I agree, but it doesn't remove the lower level requirement of searching
page tables.


> Do you have other situations in mind (other than debugging-type
> things) where you need to use virt_to_phys/bus on something that isn't
> a lowmem address?

I just think Linux should at least move into the last decade and have
standard methods for managing memory regardless of how it is allocated or
where it is located :-)  The consistent_* functions have removed the need
for drivers to search out mappings on their own, so I don't see the need
for this function outside of supporting the consistent_* functions.

> I don't see a lot of value in doing things differently from all the
> other architectures in this instance, and I think that restricting
> virt_to_bus/phys to lowmem addresses is reasonable.  I don't mind if
> iopa() stays around for a few specialized uses.

I wasn't talking about this in my message.  I was talking about the
horrible hack you guys made to mapin_ram() and didn't like my suggestion
to just keep the page tables and just scan them later to set up the PMDs.
I think we could also clean up the PMD/PTE structure and look at the tlb
miss exception to streamline that as well.

> Viewed as a problem child?  By whom?

Wasn't there once this desire to split the trees into desktop and embedded
just so you wouldn't have to deal with any of my changes :-)  I seem to
remember such a conversation.....but then you changed employers :-)

> You know I hate ifdefs. :)

I can make them go away :-)

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
