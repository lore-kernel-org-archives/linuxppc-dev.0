Date: Tue, 4 Jun 2002 13:48:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Do we need tlbsx at finish_tlb_load?
Message-ID: <20020604034832.GE2762@zax>
References: <20020530080434.GY16537@zax> <20020603024344.GA6765@zax> <3CFC0794.7020907@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CFC0794.7020907@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 03, 2002 at 08:19:32PM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> >Ok, not seeing any replies here.  If no-one speaks up for this tlbsx
> >in the next couple of days, I'll remove it from 2_4_devel.
>
> Some of us (fortunately) have a life outside of kernel hacking, so
> it takes time to reply.
>
> An instuction TLB miss will load the TLB with a PTE that indicates it isn't
> valid.  A subsequent TLB instruction fault to load the page will cause a
> data tlb miss to copy the page, and when you fix up this entry to allow a
> write, you don't want to create an alias in the TLB.

I don't follow you.  Either there is a TLB entry for the virtual
address or there isn't.  If there isn't, we'll get an ITLB or DTLB
miss and the tlbsx will always fail.  If there is, we'll get a DSI or
an ISI.  ISI never loads a TLB entry anyway, and DSI does so using a
different code path from the TLB miss handlers which does (and needs
to) do a tlbsx.  The tlbsx at finish_tlb_load is *only* called from
the TLB miss vectors, never from DSI or ISI.

> If you remove the tlbsx, you can see this happen when init starts and you
> dump the TLB after every type of TLB fault while it is starting.

Well I haven't removed it, but the large page patch also counts the
number of times this tlbsx gets a hit.  I've never seen the number to
be non-zero.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
