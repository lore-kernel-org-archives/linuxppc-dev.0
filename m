Date: Thu, 6 Jun 2002 11:35:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: First cut at large page support on 40x
Message-ID: <20020606013535.GP2630@zax>
References: <20020531042153.GD16537@zax> <3CFC0D3F.9030901@embeddededge.com> <20020604035947.GH2762@zax> <3CFCFC20.80101@embeddededge.com> <20020605001034.GB17752@zax> <3CFE49A1.7080105@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CFE49A1.7080105@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 05, 2002 at 01:25:53PM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> >Hang on, I'm not clear about this.  Does your PMD contain an entry to
> >be loaded into the TLB or not?
>
> Yes (well, it's supposed to :-).  The PMD is loaded into the xx_TWC
> register and the PTE into the xx_RPN register.  The bits in the PMD/TWC
> contain the page size information, those in the PTE/RPN contain the
> remainder of the control/status and real page number.  I don't have it
> working quite right yet, but the bits are all aligned very nicely in
> the hardware to make this happen regardless of the page size.
>
> The basic logic on the 8xx is trivial.  Load the PMD into the TWC, the PTE
> into the RPN, and you are done.  The PMD still has the pointer to the PTE
> page, and the 8xx provides a hardware assist using that to give you the
> pointer to the PTE.  The only thing we have to do in software is update
> the accessed bit in the PTE.  The least significant bits of the PMD contain
> the page size and cache control for the page, the PTE is identical to what
> we have always used.

Ok, which PTE do you use to load the RPN for the large page entry?
The first one in the page directory, or the one corresponding to the
actual address you're looking up?

I don't know about 8xx, but on 4xx the low bits in the RPN when
putting a large page entry into the TLB *must* be zeroed, or general
wierdness may occur.  So using the PTE corresponding to the actual
address would mean an extra branch in the large-page case and clearing
some bits.

> > .....  In my implemention the PMD entry
> >itself contains the data to load into TLB_DATA (except that we borrow
> >the top three bits of ZSEL for the page size).  Since we're doing that
> >there's no room in the entry for a pointer to a page of PTEs.
>
> You may want to consider just emulating something like I have done.  Just
> leave the page table structure alone, and use the LS bits of the PMD to
> store the page size information (or anything else useful).  This
> way, the

The fact that our implementation works now, and yours is still
unstable, does not encourage me to take this approach.

> Linux page tables remain intact, and the only change I needed was to
> actually test for a PMD_VALID flag and ignore the least significant bits
> when
> constructing a pointer to the PTE table.  The background debuggers that know
> how to peruse the page tables will continue to work properly, the memory
> management functions will work properly, and chances are the 4xx tlb miss
> handler
> won't require any special case branches when loading the TLB either.

We already must test to see if the PMD is present in the normal case.
In our implementation large page PMDs show up as not present.  So it's
only in the uncommon case (not present) that we test for a large page
PMD entry.

> All of the framework for this is already done for the 8xx, I just have
> not committed the function that scans the page tables and modifies the PMD
> for the larger page.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
