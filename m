Date: Wed, 6 Feb 2002 11:37:28 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Jeffrey D. Kowing" <jeffrey.d.kowing1@jsc.nasa.gov>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: io.h and I/O port access from user space
In-Reply-To: <15456.16854.183292.343027@igor.jsc.nasa.gov>
Message-ID: <Pine.GSO.4.21.0202060953400.20126-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 5 Feb 2002, Jeffrey D. Kowing wrote:
> Has anyone in powerpc land used the isapnptools ?

Yes, I modifed it to work on my LongTrail, using the mmap() /dev/mem method.

> Specifically, I've got an inhouse 603ev/MPC106 board on a PC/104 form
> factor running a linuxppc 2.4.x kernel.  I've been using an Adastra
> NSP-104 PC/104 module as my network interface card.  That card,
> besides its ethernet chip, also has a Super I/O PC87338 chip that
> controls two serial ports (i.e. SCC1 and SCC2).  Naturally, I just had
> to use those two serial ports, and, of course, it doesn't have nice
> little jumpers to set IRQ and IO base addresses.  Instead, it wants to
> be configured using Plug-n-Play which I obviously know nothing about.
> Anyways, I thought, hey, I'll investigate by using this nifty
> isapnptools package.  Silly me.

Note that isapnptools didn't find anything ISA PnP on my box. My LongTrail has
the following ISA devices:
  - NS87308VUL Super I/O controller, so-called PnP, but only using device
    specific configuration, not generic ISA PnP
  - Crystal/Cirrus CS4236B audio, so-called PnP, but only using device specific
    configuration, not generic ISA PnP
  - one (so far unused) ISA slot

Probably it's similar for your 87338.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
