MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: ioremap on powerpc question
Date: Mon, 15 Jul 2002 13:58:21 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106401281440@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have a question about ioremap_nocache() on powerpc.

I want to create a huge RAM buffer for i/o purposes, so I
boot the kernel with parameter "mem=64M" (actually, my
system, an IBM ebony 440, has 128M RAM)
This leave 64M sitting around unused by the linux kernel.

Then, I can do

	unsigned char *buf;
	buf = ioremap_nocache(64*1024*1024, 64*1024*1024);

And get back some kind of virtual address, "buf" which I want
to use for example to recieve data coming in from an IP socket.

Then, since I know the physical address of buf (because I set
it up myself with ioremap), I want to DMA from buf to a PCI
device.

I have all this working fine on x86, so far so good.

However, on powerpc, as soon as I try to do, for example:

	*buf = '\0'; // write one char to virt addr returned by ioremap

It blows up with a machine check.

(BTW, buf happens to be == 0xc505c000, so alignment shouldn't be a problem.)

Now, I see threads on LKML via google that say, essentially,
"you _must_ use readb/writeb, etc to access addresses returned
by ioremap,"  I had presumed this is because ioremap is used most
typically to access memory, registers, etc which are actually on
PCI devices.  In my case, I am simply remapping actual RAM, not
on the PCI bus at all.  I thought this meant that I can get away
with accessing those virtual addresses directly.  Am I wrong about
that?  (well, it seems I am wrong somewhere, but why?)

Using readb/writeb would defeat my purpose.
My purpose is to avoid an extra copy of the data.  I want to read/write
the data off an IP socket into/from a buffer which is then directly DMA-able
to/from a PCI device, and thus avoid having to copy the data into a special
DMA-able buffer from a more "ordinary" buffer that's used with the socket.

I'm using ioremap because kmalloc can't give me big enough buffers.
(nothing even close to 64M, and in the end it's likely I would want
even more than 64M.)

Is what I'm trying to do possible?  Where am I going wrong?

Thanks,

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
