Date: Wed, 20 Sep 2000 01:42:35 +0200 (MET DST)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: paulus@linuxcare.com.au, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39C7C7EE.7B17A25B@mvista.com>
Message-ID: <Pine.GSO.4.10.10009200107220.9268-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> > Shouldn't it be possible, to add such stuff directly to the hash table
> > and add the official mapping later?
>
> In many cases (and certainly the 8xx) the mapping done early is assumed
> to be the address used throughout the life of the system.  Using one
> set of mapping early, and then something else later is quite confusing
> when you have global pointers like immr, you have to update internal
> processor registers when it changes, and internal devices that you
> previously initialized use the old value.

Fixed addresses shouldn't be that much of a problem. Either you allocate
them somewhere after VMALLOC_END or you adjust VMALLOC_START. I think
currently the first is done. Anyway, IMO the map_page() call can IMO be
delayed, we would only need a C implementation from parts hashtable.S,
what might be usefull for other stuff as well.

> > BTW the whole mm stuff really needs a big cleanup,
>
> Heh...This quote has been in e-mail messages for years :-).
>
> I don't think we need lots of changes, but it should continue to
> evolve into something more efficient.

Something I would like to throw out first is mem_pieces.c. It can be
replaced now with the new bootmem stuff, but that would reqire to find
some piece unused piece of memory for the bootmem map, everything else can
then be nicely done with bootmem.
Most of the functions in mem_pieces.c are also in bootmem.c now, except
mem_pieces_sort()/mem_pieces_coalesce(). But the funny thing here is,
these two functions are only called by get_mem_prop(), which is only
called by pmac_find_end_of_memory(), which then is completly confused, if
doesn't find a single piece of memory starting at zero.
I could do the generic part, but I simply don't know all the machine
specific details, besides what I can read/guess from the source (I'm
already responsible for all the bugs in the m68k implementation, so I have
some experience with it. :) )

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
