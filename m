Date: Thu, 28 Sep 2000 11:59:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Paul Mackerras <paulus@linuxcare.com.au>, Dan Malek <dan@mvista.com>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <19340822040932.8760@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 27 Sep 2000, Benjamin Herrenschmidt wrote:
> >Life would be much simpler if PCI I/O space used a similar opaque IO base
> >cookie with a corresponding ioportremap(cookie) function (looks a lot like
> >Dan's tell_me_where() function, which I didn't realize until now :-), before
> >feeding everything to inb() and friends. On ia32, ioportremap() would
> evaluate
> >to the identity.
> >
> >No way we can convince The Others to use this approach? It does sound logical
> >:-)
>
> I'm not sure it would help. It would probably allow a kind of "mapping on
> demand" of the IO region on memory mapped IOs platforms, but unless we
> add another parameter to ioportremap telling it the pci_dev (or at least
> the bus number), we can't "guess" on which IO bus the device is and which
> physical base we must use.

But we can find out the IO bus by looking in which region the physical address
is located, right? Or do we have the same region on different IO busses?
That would be really weird! Different IO busses should decode different
regions.

The ioportremap() function would move all overhead from looking up the IO bus
and physical base from inb() and friends to ioportremap(). So instead of doing

    u8 inb(unsigned int phys_offset)
    {
	if (phys_offset >= region1_start && region1_end)
	    return in_8(region1_base+phys_offset));
	else if (phys_offset >= region2_start && region2_end)
	    return in_8(region2_base+phys_offset));
	else
	    ...
    }

we can do

    unsigned int ioportremap(unsigned int phys_offset, unsigned int size)
    {
	if (phys_offset >= region1_start && region1_end)
	    return region1_base;
	else if (phys_offset >= region2_start && region2_end)
	    return region2_base;
	else
	    ...
	/* perhaps do some ioremap() as well, if this wasn't set up at machine
	   init */
    }

    static inline u8 inb(unsigned int virtual_offset)
    {
	return in_8(virtual_offset);
    }

where virtual_offset is made from adding the magic cookie returned by
ioportremap and the offset inside the ioportremap'ed region.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
