Date: Mon, 15 Jul 2002 16:46:46 -0700
From: Matt Porter <porter@cox.net>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioremap on powerpc question
Message-ID: <20020715164646.A2833@home.com>
References: <45B36A38D959B44CB032DA427A6E106401281440@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45B36A38D959B44CB032DA427A6E106401281440@cceexc18.americas.cpqcorp.net>; from Steve.Cameron@hp.com on Mon, Jul 15, 2002 at 01:58:21PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 15, 2002 at 01:58:21PM -0500, Cameron, Steve wrote:
>
> Hello,
>
> I have a question about ioremap_nocache() on powerpc.
>
> I want to create a huge RAM buffer for i/o purposes, so I
> boot the kernel with parameter "mem=64M" (actually, my
> system, an IBM ebony 440, has 128M RAM)
> This leave 64M sitting around unused by the linux kernel.
>
> Then, I can do
>
> 	unsigned char *buf;
> 	buf = ioremap_nocache(64*1024*1024, 64*1024*1024);
>
> And get back some kind of virtual address, "buf" which I want
> to use for example to recieve data coming in from an IP socket.
>
> Then, since I know the physical address of buf (because I set
> it up myself with ioremap), I want to DMA from buf to a PCI
> device.
>
> I have all this working fine on x86, so far so good.
>
> However, on powerpc, as soon as I try to do, for example:
>
> 	*buf = '\0'; // write one char to virt addr returned by ioremap
>
> It blows up with a machine check.

You are hitting a 440GP specific feature.  ioremap is trapping
ranges of addresses and "fixing them up" with the proper ERPN.
Unfortunately, I left the default on a no match as an ERPN=1
which will ioremap 1 0400 0000.   That's why you get a bus error.

Try this patch:

===== arch/ppc/mm/pgtable.c 1.19 vs edited =====
--- 1.19/arch/ppc/mm/pgtable.c	Wed Jun 26 15:00:59 2002
+++ edited/arch/ppc/mm/pgtable.c	Mon Jul 15 16:12:32 2002
@@ -93,7 +93,7 @@
 ioremap(unsigned long addr, unsigned long size)
 {
 	unsigned long long addr64;
-	unsigned long long page_4gb = PPC440_IO_PAGE;
+	unsigned long long page_4gb = 0;

 	/*
 	 * Trap the least significant 32-bit portions of an

> (BTW, buf happens to be == 0xc505c000, so alignment shouldn't be a problem.)
>
> Now, I see threads on LKML via google that say, essentially,
> "you _must_ use readb/writeb, etc to access addresses returned
> by ioremap,"  I had presumed this is because ioremap is used most
> typically to access memory, registers, etc which are actually on
> PCI devices.  In my case, I am simply remapping actual RAM, not
> on the PCI bus at all.  I thought this meant that I can get away
> with accessing those virtual addresses directly.  Am I wrong about
> that?  (well, it seems I am wrong somewhere, but why?)

The "_must_" comes from a desire to make all drivers portable.
Some platforms cannot directly access PCI address space, and
so their methods are encapsulated in read*/write* (alpha).

> Using readb/writeb would defeat my purpose.
> My purpose is to avoid an extra copy of the data.  I want to read/write
> the data off an IP socket into/from a buffer which is then directly DMA-able
> to/from a PCI device, and thus avoid having to copy the data into a special
> DMA-able buffer from a more "ordinary" buffer that's used with the socket.

Sounds reasonable, you're going for a level of performance in which
portability goes out the window.  That's Ok.

> I'm using ioremap because kmalloc can't give me big enough buffers.
> (nothing even close to 64M, and in the end it's likely I would want
> even more than 64M.)

You could use alloc_bootmem_pages() to get a large buffer more
elegantly than lopping off memory and ioremapping. IMHO, it is
a slightly more flexible approach to large allocations.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
