Message-ID: <3D07E743.6090206@embeddededge.com>
Date: Wed, 12 Jun 2002 20:28:51 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
References: <20020531042153.GD16537@zax>	<3CFC0D3F.9030901@embeddededge.com>	<20020604035947.GH2762@zax>	<3CFCFC20.80101@embeddededge.com>	<15614.37065.549142.218906@argo.ozlabs.ibm.com>	<3CFEE9A3.5060300@embeddededge.com>	<15614.63160.272890.683586@argo.ozlabs.ibm.com>	<3CFF1624.2070808@embeddededge.com>	<20020612035203.GQ25800@zax>	<3D06E702.4000709@embeddededge.com>	<20020612064344.GT25800@zax>	<3D07D80F.9050306@embeddededge.com> <15623.56408.342901.245259@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> This is an issue which is much wider than the question of what the PPC
> port should do.  The linux-kernel@vger.kernel.org list is the
> appropriate place to discuss this sort of thing.

Yeah, right :-)  I can't bear the signal to noise ratio out there :-)

> The PCI DMA API is designed so that drivers never need to translate
> between virtual and physical addresses themselves.  Our API for local
> peripherals on embedded chips should do the same.

As far as I know, they do.  Just call consistent_alloc() and keep track
of the addresses.  At the time I implemented consistent_alloc(), I
updated all drivers I could test (and some that I couldn't :-) to do this.
At the time, there were PCI drivers on 4xx and 8xx that didn't do the
right thing with the pci_* functions, so I had to keep some kind of mapping
to make them work.

> "Well don't do that then" :)  If you are calling pci_map_single on a
> vmalloc'd address you are living dangerously even if virt_to_* does
> use iopa, since vmalloc'd memory is not physically contiguous.
>
>
>>doing this or are they doing it correctly?  I don't know, but I do know
>>if they call these functions we better return the right answer.
>
>
> Hitting a BUG() would be more appropriate in these cases.

I know, but the higher level functions are sufficiently disjoint that you
can't keep context across them to know if someone is doing something bad.
I guess we could just check for an address in the VMALLOC space and not
translate that, but then I'll get criticized for adding code into that
fast virt_to_* path :-)  You also don't know, in the case of noncoherent
processors, that the virtual mapping you received is from a 'vmalloc'
space, even though it was done properly for DMA.  It's one thing to call
vmalloc() and try to do DMA, and it's another to use an alternate mapping
to properly implement a feature under a standard interface.

So, just toss iopa(), use the macros in their standard way, and see how
long we run before the system crashes (SCSI drivers, eepro100,... :-)


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
