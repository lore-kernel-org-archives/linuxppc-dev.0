Message-ID: <3CAB6955.6000103@routefree.com>
Date: Wed, 03 Apr 2002 12:43:01 -0800
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
References: <20020403024321.GN1026@zax> <3CAABAB0.5030000@pacbell.net> <3CAB40C1.8000909@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What he said!  We ended up making all of the changes to move buffers,
align them, etc for both USB and skbuffs, as well as fixing the overly
aggressive prefetches in memcpy that overlapped previously
cache-invalidated memory, etc.  The end result is an ugly set of
changes, but at least the board works reliably now.  We also found one
nasty problem with an Epson USB printer where after request buffers were
bloated to cache line aligned length and the bloated length passed to
the device, that the device doesn't like the bloated length.  So we
hacked up the control path a little to get at the original length  too.
  This sort of stuff is a real pain to fix correctly to deal nicely with
non-coherent systems.

	david

Dan Malek wrote:
>
> Armin wrote:
>
>
>
>> Ah yes,  We have done something simular (internally) and had the same
>> reservations. This will help me with the ocp usb drivers i am working
>> on.   I would like to see some way of reminding us that this was done.
>> let say a config option for 4xx_usb_dma_workarround.
>
>
> It isn't unique to 4xx.  This was originally done for the 8xx USB
> (actually,
> probably for StrongARM and I just copied it over).  These functions are
> only used for incoherent processors, so there isn't any need to further
> define this with another config option.  Just leave a comment here, change
> the #ifdef CONFIG_USB to #if 1 (it should be done all of the time).
>
> Just remember this is not a solution, and simply makes the problem less
> likely to appear.  If you happen to perform this operation, and then the
> processor happens to touch the cache line before the DMA is complete,
> your DMA buffer will still be corrputed.  So far, we have just been lucky
> the DMA completes before anything else in the cache line is touched by
> the processor.  This only guarantees the processor will never get incorrect
> information when it shares a cache line with a DMA.
>
>
>     -- Dan
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
