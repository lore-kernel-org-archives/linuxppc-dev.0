Date: Thu, 1 Nov 2001 12:19:09 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: small cleanup
In-Reply-To: <20011031155335.A20613@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.GSO.4.21.0111011218330.4445-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 31 Oct 2001, Tom Rini wrote:
> On Wed, Oct 31, 2001 at 08:49:27PM +0100, Roman Zippel wrote:
> > On Wed, 31 Oct 2001, Tom Rini wrote:
> > > Yes, and compiled only on CONFIG_ALL_PPC.  But the if statement will
> > > always be false on !CONFIG_ALL_PPC, so while the compiler will warn
> > > about an implicit declaration, it won't cause a link error.  Eg:
> > > --- 1.34/arch/ppc/kernel/pci.c  Sat Oct  6 11:16:41 2001
> > > +++ edited/pci.c        Wed Oct 31 08:40:26 2001
> > > @@ -743,6 +743,9 @@
> > >                 ranges += np;
> > >         }
> > >  }
> > > +#else
> > > +/* Kill a warning */
> > > +#define pcibios_make_OF_bus_map do { } while(0)
> > >  #endif /* CONFIG_ALL_PPC */
> > >
> > >  void __init
> >
> > Hmm, I don't see how that is any better, but it's ok for me.
>
> I'd still rather just ignore the warning. :)

Nope, such warnings distract you from the real warnings. Better to have no
warnings at all.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
