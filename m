To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: u64 fun and PCI DMA not working for things behind bridges?
References: <m2k86a2gw5.fsf@dynamic-addr-83-177.resnet.rochester.edu>
	<19350124073426.30284@mailhost.mipsys.com>
From: Daniel Berlin <dberlin@redhat.com>
Date: 01 Mar 2001 10:08:01 -0500
In-Reply-To: <19350124073426.30284@mailhost.mipsys.com> (Benjamin Herrenschmidt's message of "Thu, 1 Mar 2001 15:02:42 +0100")
Message-ID: <m2d7c1y1bi.fsf@dynamic-addr-83-177.resnet.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> >
> >The firewire device is behind the same bridge the GMAC is behind. Is
> >there something special I need to do to make physical dma work all the
> >time when the device you are dma'ing to/from is behind a bridge?
> >
> >It could be a hardware implementation problem in the uni-north FW, of
> >course. I'm just trying to see if anyone has ever noticed anything.
> >
> >
> >Right now i have to resort to having the SBP-2 driver emulate physical
> >dma reads/writes by telling the firewire subsystem driver to redirect
> >all reads/writes into host memory through a routine that simply does
> >memcpys.
> >I also tell the controller it's not allowed to allow physical dma
> >accesses to be performed (there are filter registers that let you
> >specify what addresses you'll allow physical dma access to, and what
> >you want to go through the normal block read/write/quadlet read/write
> >process) , and that the other side must do it through normal block
> >reads/write packets.
> >
> >This works, but it's a little slow, of course.
>
> It might be possible that we have an apple bug here... Could you try
> doing as if the device was not cache coherent ?

I'm on it.

>
> Basically, invalidate the cache for a data block that will be filled by
> the device, and flush the cache for a data block that will be read by the
> device. You can do the first one with dcbi, the second with dcbf, both
> loops followed by a "sync" instruction to make sure the ache operations
> are completed.
>

This would, of course, be much easier if i had something snooping the
1394 bus, so i could see if it's even really *trying* to do the DMA.

The thing that makes me think it is is the fact that i get random
kernel crashes right after it should be doing the DMA (IE it's
writing the wrong memory).

Let me give your idea a try.

> Ben

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
