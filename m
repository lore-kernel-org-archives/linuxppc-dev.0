Date: Fri, 21 Jan 2000 16:13:28 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
cc: bh40@calva.net, khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: <200001211355.NAA05477@granada.iram.es>
Message-ID: <Pine.HPX.4.10.10001211502220.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,


> Okay, please let me be specific here to make sure I understand.
>
> In fixing the xf3.9.17 code in the r128 module, there is a routine that
>
> 1. reads from an MMIO register to get the current value of the hardware cursor
> enable bit
>
> 2. writes to that same MMIO register to turn off the hardware cursor

Read modify write of a single register should not need any eieio, but I'm
not so sure when reading or wrting a FIFO for example. Could it be that
lwz r3,reg followed by lwz r4,reg appear reversed on the bus ?

I can't think of any good reason to do it: if you have to go to the bus
anyway, keeping it in order will minimize the number of instructions in
fly in the HW. The only thing that may improve performance when you have
to go to the bus is to move loads ahead of stores, reordering between
noncacheable reads or between noncacheable writes does not make sense, but
weird hardware designs do exist.

>
> 3. copies an new image for the cursor into framebuffer memory
>
> 4. reloads the MMIO register to put back the original value for the hardware
> cursor enable bit.
>
>
> There are no eieios or isyncs anywhere in the current implementation.  The
> problem is that sometimes that hardware cursor flashes garabage as if the
> hardware cursor disable was never done.


No the isync was tere when you have to protect against interrupts, I don't
tink that it is your case.

> So from what I have read here, I should rewrite this routine to look as follows:
>
>
> 1. read the current value of the MMIO register for the hardware cursor enable
>
> 2. write to that same register to disable tha hardware cursor
>
> 3. eieio

Yes.

>
> 4. read back in from the hardware cursor enable register to make sure a PCI
> write post has been done  (does this need to be in a loop?)
>
> 5. isync

I tink that you can skip 4) and 5)

> 6. write the new cursor image into framebuffer memory with no eieios to allow
> for burst writing
>
> 7. eieio (to make sure the complete image had been written)
>
> 8. write back to the MMIO register to put back its original value
>
> 9. eieio
>
> 10.  read the current value from the MMIO register to make sure the write post
> was done properly
>
> 11. isync

You can skip 10 and 11 I think.

> This seems like extreme overkill.
>
> Am I simply misunderstanding this PCI write post thing and the need for eieio
> and isync?

No the isync was there for the case of interrupt masking. But even then
that might not be enough with an interrupt controller which is too slow
to remove the interrupt request from the CPU, or at least you might get
spurious interrupts. But I digress...

> I really thought I only needed an sync or isync when I was reading from value
> (say a semaphore or spin lock) and wanted to make sure absolutely *no*
> pre-fetches or other accesses happened in the code or datastructures protected
> by the spinlock or semaphore.

Indeed, basically the sync ans isync are mosty interrupt and SMP
synchronizatin issues, this is not your case AFAICT.

> I always though all other forms of access on PPC did enforce in order of
> completion (i.e. allowed pre-fetching of operands, data, etc) but that a write
> to memory really would complete before any later read or write to any location
> which came from a later instruction.

No, a read may be moved before a write as long as there are no address
conflicts (overlaps). That's pretty common on all high end processors.

> If that is true, then you only need eieio or sync/isync when you are writing a
> value that somehow will impact other later accesses and you need to be sure it
> is complete before the later accesses do any pre-fetching of data.

Bridges also may reorder writes and burst them, eieio can be used to
prevent this. That's not only the processor effect...

> Am I messed up here?  I really thought I understood this but now I am very
> unsure.

I've often believed that I understood it and later came to the conclusion
that I was wrong, maybe I'm still wrong but hopefully I'm coming closer
to a full understanding of these things every time it is discussed on the
mailing lists :-).

	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
