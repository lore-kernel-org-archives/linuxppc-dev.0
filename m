Date: Mon, 12 Nov 2001 21:02:26 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <3BF012CA.287A76A@mvista.com>
Message-ID: <Pine.GSO.4.21.0111122055010.10720-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 12 Nov 2001, Jun Sun wrote:
> Geert Uytterhoeven wrote:
> > On Mon, 12 Nov 2001, Maciej W. Rozycki wrote:
> > >  Unless you use a non-MC146818 RTC, which you need to write a separate
> > > driver for anyway.
> >
> > Yep, so that's why both m68k and PPC have common routines to read/write the
> > RTC, with a /dev/rtc-compatible abstraction on top of it.
> >
>
> Geert, what is the abstraction they used?

At first sight, we only use get_rtc_time() and mach_hwclk().

> The /dev/rtc interface is highly influenced by MC146818 chip, which not all
> RTC devices are alike.  The only fundamental thing in the driver is really the
> read and write time.
>
> If their abstraction is reasonable, perhaps they can all converge to a better,
> more generic rtc interface.

Check out the following files from the m68k CVS tree (see
http://linux-m68k-cvs.apia.dhs.org/):

  - drivers/char/genrtc.c
  - include/asm-m68k/machdep.h
  - include/asm-m68k/rtc.h

On PPC, they have something similar.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
