Date: Tue, 14 Mar 2000 08:33:56 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Mark S. Mathews" <mark@absoval.com>
cc: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Byte swapped inw/outw again....
In-Reply-To: <Pine.LNX.3.96.1000313131056.12701A-100000@tristar.cc.absoval.com>
Message-ID: <Pine.LNX.4.05.10003140831390.19873-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 13 Mar 2000, Mark S. Mathews wrote:
> Another driver port with inw/outw issues again.  I've looked through the
> linuxppc-dev archive and I'm not quite seeing the answer to my question
> (below).
>
> I'm porting a driver for a WLAN card whose interface is all 16-bit
> registers.  Sometimes the reads/writes are strictly a 16-bit integer
> quantity where the byte swapping in inw/outw wouldn't be too much of a
> problem.  Other times we're reading/writing buffer contents from/to the
> card 2-bytes at a time (swapping in this case is exceptionally bad).
>
> When writing the driver originally on the x86 I put in xxx_to_cpu and
> cpu_to_xxx calls everywhere assuming that the inw/outw words would be
> coming up byteswapped on the PPC and other platforms.  Now, after I
> realize that inw/outw are trying to do the byte swapping....my code is
> swapping them back and we're _still_ backwards.  ;-)

Hence, you should remove the le*_to_cpu() calls. Inw()/outw() are defined to
operate on PCI/ISA I/O space, which is defined to be little endian.

> What I'd like to do is set/unset or undef/define an item such that the
> inw/outw I'm using _will not_ do the byte swapping.  On reading the code
> and looking through the archives, I get the feeling there is a RIGHT way
> to do this.  I just haven't been able to figure it out precisely.

There is indeed a way to do this, but since it's not `The Right Way' for this
case I won't tell you :-) Doing this would still make it break on other big
endian platforms, which is not what you want, I assume.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
