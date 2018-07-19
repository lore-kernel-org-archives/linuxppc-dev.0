Return-Path: <noring@nocrew.org>
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Wlc2334kzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 06:14:41 +1000 (AEST)
Date: Thu, 19 Jul 2018 22:14:17 +0200
From: Fredrik Noring <noring@nocrew.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Improvements for the PS3
Message-ID: <20180719201415.GE8962@localhost.localdomain>
References: <20180714164906.GQ23412@localhost.localdomain>
 <7d6362d7-da99-e57f-40ed-81c7a03ea1a4@infradead.org>
 <CAMuHMdX3xiRYYdhQftHRDYFqob7xMHm-xxvh3NyoC1TowH4x8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAMuHMdX3xiRYYdhQftHRDYFqob7xMHm-xxvh3NyoC1TowH4x8g@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Geert, Geoff,

> > > so I added a sleep with
> > >
> > > +     msleep(10000);
> 
> I can't see where you added the sleep, but 10s seems excessive.
> If the real reason is the need to wait for an interrupt for ps3fb_sync_image(),
> then waiting for 40 ms should be sufficient? Or am I missing something?

It's at the end of ps3fb_probe, as shown in the original post:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-July/175771.html

I thought 100 ms or so would work, but evidently it didn't. In fact, 1 s
for even 5 s didn't seem to work either. In any case, I would like to
develop a solution that does not need to sleep at all, so that will be my
first approach for a proper implementation.

> > > I suppose the problem is that it relies on interrupts for ps3fb_sync_image
> > > to regularly copy the image, hence without them the screen isn't updated to
> > > show kernel panics, etc. Perhaps one way to fix that is to implement the
> > > struct fb_tile_ops API, so that the console is synchronously updated? Would
> > > that be acceptable?
> >
> > I'm not sure if that would work or not.   Maybe Geert is more familiar with it.
> 
> That sounds like a complex solution, slowing down the console a lot.

Why would that be slow? I have implemented a similar technique for the
PlayStation 2 frame buffer, and (without any measurements at hand now) it
appears to be about as fast as is possible, and reasonably easy too. :)

It works like this:

The PS2 frame buffer can operate in two distinct modes: virtual mode or
console mode. Virtual mode is very similar to the PS3 in that the whole
visible kernel memory frame buffer is copied to the Graphics Synthesizer
(GS) via DMA regularly at vertical blank intervals.

Console mode is different. No kernel memory is allocated for the frame
buffer at all (which is a significant improvement in itself given that the
PS2 is limited to 32 MiB of main memory) and mmap is disabled. Some struct
fb_ops such as fb_fillrect and fb_copyarea are directly accelerated by GS
hardware. The GS has two CRT merge circuits made for picture-in-picture that
are used to accelerate YWRAP in hardware, which is particularly effective
for console text scrolling.

Additionally, the tiled API is implemented, and it turned out to be a rather
good fit. The GS has 4 MiB of local frame buffer video memory (not directly
accessible by the kernel). The maximum practical resolution 1920x1080p at 16
bits per pixel is 4147200 bytes, which leaves 47104 bytes for a tiled font
which at 8x8 pixels and a minimum 4 bits indexed texture palette is at most
1464 characters. The indexed palette makes it easy to switch colors. struct
fb_tile_ops such as fb_tileblit are accelerated by GS texture sprites which
are fast (GS local copy) for the kernel via simple DMA (GIF) GS commands.

Console text is always synchronous and therefore works properly in interrupt
contexts and with kernel panics, etc. which is essential for debuggability.
A buffered version could be faster, possibly, but I think that might as well
be implemented by a user space console driver using a /dev/gs interface that
can do zero-copy GS commands. The PS2 frame buffer implementation is nearly
complete:

https://github.com/frno7/linux/blob/ps2-v4.17-n3/drivers/video/fbdev/ps2fb.c

Some adjustments and feature reductions seem to be needed for a PS3 version
of anything similar. The simplest implementation is probably to just mirror
characters as they are printed synchronously. I don't know the overhead of
the hypervisor calls for copying graphics though, but the typical areas are
quite small. Perhaps one could avoid allocating the kernel frame buffer as
well when it's not needed. I have to investigate these things to be sure.

> What about letting ps3fb register a panic notifier to sync the screen, like
> hyperv_fb does?

That would not work with kernel freezes unfortunately. Debugging those with
nondeterministicly invisible kernel prints would be painful, I believe.

Fredrik
