Date: Sat, 23 Sep 2000 14:34:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: Dan Malek <dan@mvista.com>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <14794.54989.87038.231729@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.10.10009231430200.413-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 22 Sep 2000, Paul Mackerras wrote:
> No, it's correct.  I was going through my old emails yesterday and I
> found this email from Dave Miller to linux-kernel:

I remember that one :-)

> >    Does this means that there is no way to mmap the PCI IO space on
> >    any platform other than ia32?
> >
> > One needs to be a bit more specific for me to give you an
> > answer :-)
> >
> > Inside the kernel:
> >
> > 1) PCI I/O space is accessed by obtaining the base address via the
> >    appropriate pci_dev->resource[xxx] value, and feeding that directly
> >    into inb/inw/inl and friends.
> >
> > 2) PCI MEM space is accessed by obtaining the opaque MEM base cookie
> >    in pci_dev->resource[xxx], mapping it with ioremap(cookie), and
> >    feeding what you obtain from that to readw and friends.  When
> >    done with the MEM space area, you iounmap it.

Life would be much simpler if PCI I/O space used a similar opaque IO base
cookie with a corresponding ioportremap(cookie) function (looks a lot like
Dan's tell_me_where() function, which I didn't realize until now :-), before
feeding everything to inb() and friends. On ia32, ioportremap() would evaluate
to the identity.

No way we can convince The Others to use this approach? It does sound logical
:-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
