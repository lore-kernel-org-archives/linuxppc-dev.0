Date: Tue, 23 Jan 2001 08:01:24 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Robert E Brose II <bob@kunk.jriver.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <20010123064948.1745.qmail@kunk.jriver.com>
Message-ID: <Pine.LNX.4.05.10101230759160.18545-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Jan 2001, Robert E Brose II wrote:
> On Mon, 22 Jan 2001, Dan Malek wrote:
> >> > .....  I
> >> > wonder why planb works at all....
> >>
> >> Probably because no one stumbles across the memory it is trashing?
> >> Currently, bad_thing_will_happen = vmalloc + virt_to_bus + dma.
> >> It could be with the right memory size, modulo addressing, memory
> >> controller configuration, timing of the vmalloc, it just may
> >> accidently work.  If this is the case, I would be out buying
> >> lottery tickets........
>
> On Mon, 22 Jan 2001, Takashi Oe wrote:
> > Ok, my apologies, planb doesn't use vmalloc at all these days.  So, there
> > is no problem of that kind.  (In the beginning, it had vmalloc with a lot
> > of problems as I recall now.)
>
> How about the use of vmalloc in the video frame buffer drivers? At
> one point I ran into some weird behavior with controlfb (mmap patched),
> XFree4.0, planb and Xawtv (the xawtv display froze the machine). I was
> not able to duplicate that in X3.3.6

The frame buffer device drivers don't use vmalloc(), except for vfb, which is a
sample driver that works on vmalloc()'ed memory instead of on real video
memory. But you're right that vfb can crash if you try to mmap() its /dev/fb*,
since it's vmalloc()'ed.

However, that doesn't matter since no one will ever really use vfb :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
