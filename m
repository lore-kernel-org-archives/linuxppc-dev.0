Return-Path: <mk-lists@creamnet.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 4DC3967B9A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Sep 2006 04:15:49 +1000 (EST)
To: "Steven Kaiser" <skaiser.uci@gmail.com>
Subject: Re: MPC5200b kernel module memory mapping
References: <000001c6dd12$417d7a50$6e4ec880@volt>
From: Markus =?iso-8859-1?Q?Klotzb=FCcher?= <mk@creamnet.de>
Date: Thu, 21 Sep 2006 20:10:17 +0200
In-Reply-To: <000001c6dd12$417d7a50$6e4ec880@volt> (Steven Kaiser's message of
	"Wed, 20 Sep 2006 17:09:49 -0700")
Message-ID: <87slilxf92.fsf@creamnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Steven,

"Steven Kaiser" <skaiser.uci@gmail.com> writes:

> In a kernel module, I am trying to iomemory map or ioport map a range of
> addresses so later I can talk directly to custom external hardware.  I have
> tried to follow the advice of Rubini chapter 8.  I think I am setting it up
> correctly, but at the precise moment I try to write anything within my
> range, the kernel crashes badly.  My board is a Lite5200b, using a 2.4.25
> kernel.
...
> 	// enable LocalBus Chip Select CS2 to hit on our address range
> 	*(volatile u32 *)MPC5xxx_MM_IPBI &= ~0x00040000;
> 	*(volatile u16 *)(MPC5xxx_MM_CS2_START + 2) = MALab_MM_START >> 16;
> 	*(volatile u16 *)(MPC5xxx_MM_CS2_STOP + 2) = MALab_MM_END >> 16;
> 	*(volatile u32 *)MPC5xxx_MM_IPBI |= 0x00040000;
>
> 	// map our physical address into kernal virtual address space
> 	// do I need this call?
> 	ioaddr = ioremap(MALab_MM_START,MALab_MM_SIZE);

Yes, you do need this call if you want to access physical addresses.

> return 0;
> }
>
> Later (in a ioctrl routine), I will try and write something to the first
> location in my address range.  I tried these three ways:
>
> 	*(volatile u16 *)MALab_MM_START = 0x5555;
> 	outw(0x5555,MALab_MM_START);
> 	outw(0x5555,ioaddr);
>
> Any and all of the these calls crash the kernel so horrendously I have to
> reboot.  Sometimes I have to delete and mknod a new /dev entry.
>
> I have tried the io memory map technique instead of the above io port map
> technique, using request_mem_region(), with the same crashing results upon
> any writew() call or direct variants.  I tried things without the ioremap()
> call--  I get a segmentation fault in these cases.
>
> The request_region() or request_mem_region() seems to work ok.  I can cat
> /proc/iomem or /proc/ioports and see my range in there.  I am pretty

This doesn't really tell you anything, it's mere housekeeping.

> sure I am setting up the LocalBus chip select registers ok.

I would guess this is not the case. What kind of device is this?

Regards

	Markus
