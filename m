Message-ID: <36b714c8040804103826917da1@mail.gmail.com>
Date: Wed, 4 Aug 2004 13:38:38 -0400
From: Brian Waite <linwoes@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Workaround for 745x data corruption bug
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	Adrian Cox <adrian@humboldt.co.uk>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1091580331.1922.42.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1091291276.987.57.camel@localhost>
	 <410E85EE.8050707@mvista.com>  <36b714c804080306175c5dc3f6@mail.gmail.com> <1091580331.1922.42.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben,

So what kind of aliasing issues do you forsee uner 2.4?
Thanks
Brian
On Wed, 04 Aug 2004 10:45:32 +1000, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> > Looking at this errata, I don't think poeple using Marvell chips will
> > be affected by this errata.
> > I don't see this as impacting the IO subsystem only the internal MPX system. IE
> > using a 2 74xx system and not using the M bit. This race can also
> > occur on a single processor system with the M disabled, as it is in
> > Linux, but it has nothing to do with the memory controller mapping its
> > PCI<->mem windows as non cacheable. You should be able to boost the IO
> > throughput using non coherency without this errata impacting you any
> > more than it already is.
> >
> > Anyone please correct me if I am wrong because I need to know.
>
> Note that I feel obligated to re-state again that doing non-coherent
> DMA on a 6xx/7xx/7xxx CPU is a big no brainer and is asking for all sorts
> of cache aliasing issues because of the way the kernel linear mapping of
> memory is BAT mapped... (Note that 2.6 should be able to deal with the
> DBAT beeing disabled, at the expense of perfs, though I'm pretty sure we
> need the IBAT still set).
>
> Ben.
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
