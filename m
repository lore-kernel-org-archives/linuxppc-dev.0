Date: Thu, 5 Jul 2001 06:11:16 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: Matt Porter <mporter@mvista.com>
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
In-Reply-To: <20010629084133.A3082@cx258813-a.chnd1.az.home.com>
Message-ID: <Pine.LNX.3.95.1010705060055.12260C-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 29 Jun 2001, Matt Porter wrote:

> If you are on broken 6xx/7xx/82xx implementation then you can use the
> "nobats" kernel argument to map memory with only PTEs.  Then the
> consistent_alloc() stuff that Dan has brought over from arch/arm
> will work fine.  The implementation is simply to get_free_pages(),
> virt_to_phys(), ioremap(), and finally throw away the original
> cacheable mappings.
>
> Hrm, I see this stuff Dan's been talking about isn't in linuxppc_devel
> (bad Dan).  If we all nag him perhaps it will get there faster. :)
>
> In the meantime, look at the arch/arm's implementation to get an
> idea of how it optimizes software coherency with the knowledge of
> how you are using the memory region.

I've been poking around in the arch/arm code, impatiently contemplating
bringing the code over the my 2_4_devel tree on my own until it's been
done by someone more powerful. I looks like the big this done in the
consistent_alloc function is the calling of SetPageReserved for each page
allocated- this is a macro that sets the PG_reserved bit for the page,
which looks like it is a linux kernel thing, and not a hardware thig. Am I
missing something here, or will this actually prevent caching of those
pages? Or is the real magic done in the ioremap call, and the PG_reserved
bit tells the kernel not to touch the page (though it can still access the
data)? I presume the latter is the case, but I'd rather be sure before I
muck with this and add make my debugging job even harder.

Thanks
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
