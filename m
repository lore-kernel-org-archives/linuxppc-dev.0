Date: Wed, 31 Oct 2001 15:53:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: small cleanup
Message-ID: <20011031155335.A20613@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011031084233.A18493@cpe-24-221-152-185.az.sprintbbd.net> <Pine.LNX.4.33.0110312042050.1723-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0110312042050.1723-100000@serv>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 31, 2001 at 08:49:27PM +0100, Roman Zippel wrote:
> Hi,
>
> On Wed, 31 Oct 2001, Tom Rini wrote:
>
> > Yes, and compiled only on CONFIG_ALL_PPC.  But the if statement will
> > always be false on !CONFIG_ALL_PPC, so while the compiler will warn
> > about an implicit declaration, it won't cause a link error.  Eg:
> > --- 1.34/arch/ppc/kernel/pci.c  Sat Oct  6 11:16:41 2001
> > +++ edited/pci.c        Wed Oct 31 08:40:26 2001
> > @@ -743,6 +743,9 @@
> >                 ranges += np;
> >         }
> >  }
> > +#else
> > +/* Kill a warning */
> > +#define pcibios_make_OF_bus_map do { } while(0)
> >  #endif /* CONFIG_ALL_PPC */
> >
> >  void __init
>
> Hmm, I don't see how that is any better, but it's ok for me.

I'd still rather just ignore the warning. :)

> > > > This will break 4xx I think...  Can you try doing a
> > > > walnut+CONFIG_405_DMA=y compile (in _devel..)
> > >
> > > I can try it (when I get home).
> >
> > Thanks.
>
> Works fine, below is the relevant part of the patch for 2_4_devel.

Okay, thanks.  Remove my objection to that part then..

> > By and large we do it the way I said anyhow.  Is this in current gcc or
> > when we get the precompiled headers bits?
>
> That has nothing to do with precompiled headers, check the cpp info file
> ("Header Files" -> "Once-Only") for more info.

I will when I get a moment.. :)  But #ifndef __FOO__ #define __FOO__
#ifdef __BAR__ ... #endif /* __BAR__ */ #endif /* __FOO__ */ works
better than checking for __BAR__ first?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
