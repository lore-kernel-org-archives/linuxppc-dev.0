Date: Fri, 29 Jun 2001 08:41:33 -0700
From: Matt Porter <mporter@mvista.com>
To: Paul White <pwhite@networkrobots.com>
Cc: Dan Malek <dan@mvista.com>, jtm@smoothsmoothie.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
Message-ID: <20010629084133.A3082@cx258813-a.chnd1.az.home.com>
References: <20010626160844.A20988@shamus.smoothsmoothie.com> <3B3C30CD.34B20F02@mvista.com> <200106291744.f5THia810339@stimpy.networkrobots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200106291744.f5THia810339@stimpy.networkrobots.com>; from pwhite@networkrobots.com on Fri, Jun 29, 2001 at 10:48:45AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 29, 2001 at 10:48:45AM -0700, Paul White wrote:
>
> Btw...Where are these "consistent_alloc()" functions?  I've not seen theses
> anywhere.
>
> I also can't imagine how they would possibly work on any CPU using BATs.
> Since the BAT is setup as cacheable space, you can't just take a "chunk"
> of it and make it non-cacheable.  Not possible.
>
> Now, yes, for the 4xx and 8xx proccessors that don't use BATs, I would
> assume that when you do one of these "non-cache" allocs, it would
> simply allocate you a batch of 4k pages, and set them as Caching
> Inhibited.
>
> Is there something I'm missing here?

If you are on broken 6xx/7xx/82xx implementation then you can use the
"nobats" kernel argument to map memory with only PTEs.  Then the
consistent_alloc() stuff that Dan has brought over from arch/arm
will work fine.  The implementation is simply to get_free_pages(),
virt_to_phys(), ioremap(), and finally throw away the original
cacheable mappings.

Hrm, I see this stuff Dan's been talking about isn't in linuxppc_devel
(bad Dan).  If we all nag him perhaps it will get there faster. :)

In the meantime, look at the arch/arm's implementation to get an
idea of how it optimizes software coherency with the knowledge of
how you are using the memory region.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
