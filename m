From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15623.61149.22953.9238@argo.ozlabs.ibm.com>
Date: Thu, 13 Jun 2002 11:01:17 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
In-Reply-To: <3D07E743.6090206@embeddededge.com>
References: <20020531042153.GD16537@zax>
	<3CFC0D3F.9030901@embeddededge.com>
	<20020604035947.GH2762@zax>
	<3CFCFC20.80101@embeddededge.com>
	<15614.37065.549142.218906@argo.ozlabs.ibm.com>
	<3CFEE9A3.5060300@embeddededge.com>
	<15614.63160.272890.683586@argo.ozlabs.ibm.com>
	<3CFF1624.2070808@embeddededge.com>
	<20020612035203.GQ25800@zax>
	<3D06E702.4000709@embeddededge.com>
	<20020612064344.GT25800@zax>
	<3D07D80F.9050306@embeddededge.com>
	<15623.56408.342901.245259@argo.ozlabs.ibm.com>
	<3D07E743.6090206@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> > Hitting a BUG() would be more appropriate in these cases.
>
> I know, but the higher level functions are sufficiently disjoint that you
> can't keep context across them to know if someone is doing something bad.
> I guess we could just check for an address in the VMALLOC space and not
> translate that, but then I'll get criticized for adding code into that
> fast virt_to_* path :-)

Not by me, doing a range check in virt_to_* would be perfectly
appropriate.

>  You also don't know, in the case of noncoherent
> processors, that the virtual mapping you received is from a 'vmalloc'
> space, even though it was done properly for DMA.  It's one thing to call
> vmalloc() and try to do DMA, and it's another to use an alternate mapping
> to properly implement a feature under a standard interface.

Drivers shouldn't be doing virt_to_* on the address they get from a
consistent-alloc function.  Given that doing it the right way is easy
(just remember the physical address that the consistent alloc function
gives you) I don't have any qualms about breaking drivers that do it
the wrong way.

(I should note that I'm not intending to break them in 2.4, not even
in 2_4_devel; virt_to_* can continue to use iopa there.  But in 2.5 we
can be more brutal.)

> So, just toss iopa(), use the macros in their standard way, and see how
> long we run before the system crashes (SCSI drivers, eepro100,... :-)

There is the issue of making sure that we don't have DMA buffers and
other variables in the same cache line.  This is being thrashed out on
linux-kernel at the moment. :)

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
