From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15623.63352.516734.245869@argo.ozlabs.ibm.com>
Date: Thu, 13 Jun 2002 11:38:00 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
In-Reply-To: <3D07D80F.9050306@embeddededge.com>
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
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> Long ago, modern operating systems abstracted much of the VM implementation
> away from the drivers.  The most useful example would be for us to use
> an I/O vector triplet {physaddr, offset, length} in a driver for any DMA
> or other physical address operation.  Drivers shouldn't care how memory
> mapping is implemented, they should be given information about a VM address
> range that is suitable for them to perform DMA.  This way, we don't have

I think this deserves some discussion, on a couple of levels, for the
sake of the other people who are on this list and following this
discussion.

At the high level, Linus and the other core kernel developers have a
mindset which seems to me a bit different from that of many other
software developers, including those responsible for various
proprietary operations systems.  It is a mindset which highly values
simplicity and clarity of code, and in particular being able to
understand what a piece of code is doing, in considerable detail, when
you read it.  Abstraction is valued but only to the extent that it
contributes to the clarity of the code.  Abstraction beyond that
point, that is to say abstraction that hides details that are relevant
to the code using the abstraction, is rejected.  Combined with that is
an emphasis on performance.  Generality is not seen as desirable in
itself, but only to the extent that it contributes to simplicity and
clarity of code.  And academic ideas of the "right" ways to do things,
while they will be considered, are not by any means taken as gospel.

I think this mindset is the reason why we have an efficient and
maintainable kernel rather than a microkernel-based system written in
C++.

In the context of drivers doing DMA, there are basically two ways for
the code calling the driver to specify where the buffer is that it
wants to use for I/O: (a) as a virtual address, (b) as a pointer to
the page struct for the page plus an offset.  Method (b) is
increasingly being used in 2.5 since it lets you specify a buffer
anywhere in memory even on 32-bit systems with multiple GB of RAM.

But let us consider a buffer specified by a virtual address.  There
are basically three kinds of virtual address the driver could be
given:

(1) kernel lowmem
(2) other kernel virtual addresses
(3) user addresses

Thinking about this from the driver's perspective, (1) is easy.  We
know the buffer will be contiguous and that it isn't going to go away
from under us.  (2) is a little harder because the buffer may not be
physically contiguous.  If our device handles scatter/gather then we
could possibly handle it, but we start to need allocate space for
scatter/gather lists of varying length even if we are only handling a
single buffer at a time.  And if our device doesn't handle
scatter/gather then we have a bigger problem - we may even need to use
a bounce buffer.  And (3) is harder still because the buffer may move
or disappear.  In this case we need to pin the buffer as well as
handling the fact that it may be physically discontiguous.

Given this, I would claim that an abstraction that tries to hide the
differences between different kinds of virtual address is one that
hides details that are relevant to drivers, and that that is one
reason why Linux doesn't have such an abstraction.  Instead, when
drivers are required to handle physically discontiguous buffers, we
make that apparent up front and provide the drivers with the details
they need to handle that case efficiently as well as the contiguous
case.

Paul.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
