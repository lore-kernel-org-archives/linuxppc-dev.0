Message-Id: <200001211356.HAA30692@lists.linuxppc.org>
Date: Fri, 21 Jan 2000 08:53:26 -0500 (EST)
From: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Reply-To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
To: bh40@calva.net, paubert@iram.es
Cc: khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>> Another thing to take care of is PCI write posting: Basically, when you
>> write, let's say, a MMIO register, you are not guaranteed that this write
>> have actually been done unless you do a read from the same io space. For
>> example: If you write an interrupt mask register to disable an interrupt
>> followed by critical code in which this interrupt _must not_ happen, you
>> need absolutely to do a read (typically to re-read the mask you just
>> wrote to) after the write, and before the critical code.
>
>In this case, I think that you need the following:
>
>- write,
>- eieio,
>- read,
>- isync to make sure that the read has reached the registers and is not in
>a load pending queue or whatever which can be quite deep especially if the
>processor does never need the result of the read...


Okay, please let me be specific here to make sure I understand.

In fixing the xf3.9.17 code in the r128 module, there is a routine that

1. reads from an MMIO register to get the current value of the hardware cursor
enable bit

2. writes to that same MMIO register to turn off the hardware cursor

3. copies an new image for the cursor into framebuffer memory

4. reloads the MMIO register to put back the original value for the hardware
cursor enable bit.


There are no eieios or isyncs anywhere in the current implementation.  The
problem is that sometimes that hardware cursor flashes garabage as if the
hardware cursor disable was never done.

So from what I have read here, I should rewrite this routine to look as follows:


1. read the current value of the MMIO register for the hardware cursor enable

2. write to that same register to disable tha hardware cursor

3. eieio

4. read back in from the hardware cursor enable register to make sure a PCI
write post has been done  (does this need to be in a loop?)

5. isync

6. write the new cursor image into framebuffer memory with no eieios to allow
for burst writing

7. eieio (to make sure the complete image had been written)

8. write back to the MMIO register to put back its original value

9. eieio

10.  read the current value from the MMIO register to make sure the write post
was done properly

11. isync



This seems like extreme overkill.

Am I simply misunderstanding this PCI write post thing and the need for eieio
and isync?

I really thought I only needed an sync or isync when I was reading from value
(say a semaphore or spin lock) and wanted to make sure absolutely *no*
pre-fetches or other accesses happened in the code or datastructures protected
by the spinlock or semaphore.

I always though all other forms of access on PPC did enforce in order of
completion (i.e. allowed pre-fetching of operands, data, etc) but that a write
to memory really would complete before any later read or write to any location
which came from a later instruction.

If that is true, then you only need eieio or sync/isync when you are writing a
value that somehow will impact other later accesses and you need to be sure it
is complete before the later accesses do any pre-fetching of data.

Am I messed up here?  I really thought I understood this but now I am very
unsure.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
