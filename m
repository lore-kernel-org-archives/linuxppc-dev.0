Message-Id: <200204041235.g34CZDw22993@p2.parker.boston.ma.us>
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs 
In-Reply-To: Message from Dan Malek <dan@embeddededge.com>
   of "Wed, 03 Apr 2002 21:54:29 EST." <3CABC065.6050107@embeddededge.com>
Date: Thu, 04 Apr 2002 07:35:13 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
>David Gibson wrote:
>
>
>> It's becoming easier though, with the __cacheline_aligned macro.  Plus
>> I think if the buffer is individually kmalloc()ed it will be properly
>> aligned.
>
>Alignment is only half the problem.  You have to ensure the object is
>modulo cache line size as well.  You can't be sharing cache lines subject
>to DMA with other DMA or processor core data.

Maybe I need to go drink some coffee, but I'm confused by this thread.

The real problem, as I recall, was that cache invalidate routine one
in the 405 port didn't respect the addresses handed to it and instead
invalidated the entire cache line, even if it went beyond the address
range provided.

This behavior was different than other ports, specfically the ARM
port.

I don't think the patch was needed on the ARM.  It was just need on
the 405.

Fixing the usb code is a good idea, but it would just hide the real
problem.

The original problem was that the USB code was doing DMA off the
stack.  I don't recommend that, but I can't find any reason why it
specifically should not work or not be allowed.  (and listen, if you
argue that it's philosophically bad I agree - note I said
*technically* wrong).

When the ohci driver did a cache invalidate on the buffer - in
preparation for dma into the buffer - it destroyed part of the stack,
the part which had not yet been flushed.

On other ports, like the ARM, the cache invalidate routine 'notices'
if the address range is not cache line aligned and flushes the parts
which are not.

I argued long ago (to parties which are present but probably sleeping
right now :-)) that this should be changed.

I'll make this argument again, now.

also, I think the comment in the code is incorrect.  I think the code
should read that the cache_invalidate routine is broken on some ports.

off to make some coffee...

-brad

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
