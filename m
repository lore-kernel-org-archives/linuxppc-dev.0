Date: Tue, 14 Mar 2000 09:39:38 -0500 (EST)
From: "Mark S. Mathews" <mark@absoval.com>
Reply-To: "Mark S. Mathews" <mark@absoval.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Byte swapped inw/outw again....
In-Reply-To: <Pine.LNX.4.05.10003140831390.19873-100000@callisto.of.borg>
Message-ID: <Pine.LNX.3.96.1000314093054.14897A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just to finish off this thread...

My thanks for Geert's and Gabriel's responses.  While _I_ think it's
wierd, I'll just smile and change my code per Geert's suggestions.  I get
the feeling this is a subject that's been debated heatedly in the past and
don't want to refan the flames.

Why do I think it's wierd?  It just bothers me that the following two
pieces of code don't give you the same thing:

   uint16  a;
   uint8   *p = (uint8*)&a;
   *p = inb(portaddr);
   *(p+1) = inb(portaddr+1);
   printk("%d\n", a);

and

   a = inw(portaddr);
   printk("%d\n", a);

It just seems more logical (and readable) to me to have in[wl]/out[wl]
variants that explicitly state (as part of their name) that they are going
to do the swap.  This whole thing smells like 'magic' to me.  ;-)

Oh well, I never did mind the little things....

Thanks Again,
-Mark

On Tue, 14 Mar 2000, Geert Uytterhoeven wrote:

> On Mon, 13 Mar 2000, Mark S. Mathews wrote:
> > Another driver port with inw/outw issues again.  I've looked through the
> > linuxppc-dev archive and I'm not quite seeing the answer to my question
> > (below).
> >
> > I'm porting a driver for a WLAN card whose interface is all 16-bit
> > registers.  Sometimes the reads/writes are strictly a 16-bit integer
> > quantity where the byte swapping in inw/outw wouldn't be too much of a
> > problem.  Other times we're reading/writing buffer contents from/to the
> > card 2-bytes at a time (swapping in this case is exceptionally bad).
> >
> > When writing the driver originally on the x86 I put in xxx_to_cpu and
> > cpu_to_xxx calls everywhere assuming that the inw/outw words would be
> > coming up byteswapped on the PPC and other platforms.  Now, after I
> > realize that inw/outw are trying to do the byte swapping....my code is
> > swapping them back and we're _still_ backwards.  ;-)
>
> Hence, you should remove the le*_to_cpu() calls. Inw()/outw() are defined to
> operate on PCI/ISA I/O space, which is defined to be little endian.
>
> > What I'd like to do is set/unset or undef/define an item such that the
> > inw/outw I'm using _will not_ do the byte swapping.  On reading the code
> > and looking through the archives, I get the feeling there is a RIGHT way
> > to do this.  I just haven't been able to figure it out precisely.
>
> There is indeed a way to do this, but since it's not `The Right Way' for this
> case I won't tell you :-) Doing this would still make it break on other big
> endian platforms, which is not what you want, I assume.
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
>


Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
