Date: Thu, 30 May 2002 15:14:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: LMBench and CONFIG_PIN_TLB
Message-ID: <20020530051404.GV16537@zax>
References: <20020529030838.GZ16537@zax> <3CF4E842.3070207@embeddededge.com> <15605.24191.948013.249297@argo.ozlabs.ibm.com> <3CF581BE.8020207@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CF581BE.8020207@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 29, 2002 at 09:34:54PM -0400, Dan Malek wrote:
>
> Paul Mackerras wrote:
>
>
> >I suspect we are all confusing two things here: (1) having pinned TLB
> >entries and (2) using large-page TLB entries for the kernel.
>
> I wasn't confusing them :-).  I know that large page sizes are beneficial.
> Someday I hope to finish the code that allows large page sizes in the
> Linux page tables, so we can just load them.

Well it so happens that Paul and I have tried implementing that this
morning.  More data coming in the next day or two.

> >We could have (2) without pinning any TLB entries but it would take
> >more code in the TLB miss handler to do that.
>
> Only on the 4xx.  I have code for the 8xx that loads them using the
> standard lookup.  Unfortunately, I have found something that isn't quite
> stable with the large page sizes, but I don't know what it is.

I'm only talking about 4xx.

> >....  It is an interesting
> >question whether the benefit of having the 64th TLB slot available for
> >applications would outweigh the cost of the slightly slower TLB
> >misses.
>
> Removing the entry will increase the TLB miss rate by 1/64 * 100 percent,
> or a little over 1.5%, right?  Any application that is thrashing the TLB
> cache by removing one entry is running on luck anyway, so we can't consider
> those.  When you have applications using lots of CPU in user space (which
> is usually a good thing :-), increased TLB misses will add up.

Um, assuming a program with some degree of locality, I'd expect it to
increase the miss rate by somewhat less than 1/64, but it will
certainly increase them to an extent.  So, show us the data.

> >.... My feeling is that it would be a close-run thing either way.
>
> So, if you have a product that runs better one way or the other, just
> select the option that suits your needs.  If the 4xx didn't require the
> extra code in the miss handler to fangle the PTE, large pages without
> pinning would clearly be the way to go (that's why it's an easy decision
> on 8xx and I'm using it for testing).

Actually from the looks of this implementation doing large pages won't
be too bad - we can hijack an existing test so we only hit the extra
code if we hit a large page entry.  Tests coming soon, I would expect
it to beat the current CONFIG_PIN_TLB.

> >.... David's suggestion was purely in the context of the 405
> >processor, which has 64.
>
> There is an option to enable it, so just enable it by default.  What
> do you gain by removing the option, except the possibility to prevent
> someone from using it when it may be to their benefit?  It certainly
> isn't a proven modification, as there may be some latent bugs associated
> with dual mapping pages that may be covered by the large page and
> some other mapping (I think this is the problem I see on the 8xx).

We gain simplicity of code.  Feeping creaturism isn't a good thing.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
