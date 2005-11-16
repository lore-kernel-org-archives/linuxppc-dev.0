Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C4B568721
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 00:52:53 +1100 (EST)
Date: Wed, 16 Nov 2005 06:39:03 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <20051116083903.GD4441@logos.cnet>
References: <20051112192826.GB20537@logos.cnet>
	<TMNT04NwMmRDltJmBYW0000000a@tmnt04.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <TMNT04NwMmRDltJmBYW0000000a@tmnt04.transmode.se>
Cc: 'Tom Rini' <trini@kernel.crashing.org>, 'Dan Malek' <dan@embeddedalley.com>,
	gtolstolytkin@ru.mvista.com, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Nov 13, 2005 at 01:47:53PM +0100, Joakim Tjernlund wrote:
>  
> 
> > -----Original Message-----
> > From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com] 
> > Sent: den 12 november 2005 20:28
> > To: Joakim Tjernlund
> > Cc: Tom Rini; Dan Malek; gtolstolytkin@ru.mvista.com; 
> > linuxppc-embedded@ozlabs.org
> > Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
> > 
> > On Mon, Nov 07, 2005 at 07:37:45PM +0100, Joakim Tjernlund wrote:
> > >  >
> > > > On Mon, Nov 07, 2005 at 07:14:15PM +0100, Joakim Tjernlund wrote:
> > > > > > -----Original Message-----
> > > > > > From: Tom Rini [mailto:trini@kernel.crashing.org]
> > > > > > Sent: 07 November 2005 16:52
> > > > > > To: Marcelo Tosatti
> > > > > > Cc: Joakim Tjernlund; Pantelis Antoniou; Dan Malek; 
> > > > > > linuxppc-embedded@ozlabs.org; gtolstolytkin@ru.mvista.com
> > > > > > Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
> > > > > > 
> > > > > > On Mon, Nov 07, 2005 at 08:16:18AM -0200, Marcelo 
> > Tosatti wrote:
> > > > > > > Joakim!
> > > > > > > 
> > > > > > > On Mon, Nov 07, 2005 at 03:32:52PM +0100, Joakim
> > > > Tjernlund wrote:
> > > > > > > > Hi Marcelo
> > > > > > > > 
> > > > > > > > [SNIP]
> > > > > > > > > The root of the problem are the changes against the 8xx 
> > > > > > > > > TLB handlers introduced during v2.6. What 
> > happens is the 
> > > > > > > > > TLBMiss handlers load the zeroed pte into the 
> > TLB, causing 
> > > > > > > > > the TLBError handler to be invoked (thats two 
> > TLB faults 
> > > > > > > > > per pagefault), which then jumps to the generic 
> > MM code to
> > > > > > setup the pte.
> > > > > > > > > 
> > > > > > > > > The bug is that the zeroed TLB is not invalidated (the
> > > > > > same reason
> > > > > > > > > for the "dcbst" misbehaviour), resulting in infinite
> > > > > > TLBError faults.
> > > > > > > > > 
> > > > > > > > > Dan, I wonder why we just don't go back to v2.4 
> > behaviour.
> > > > > > > > 
> > > > > > > > This is one reason why it is the way it is:
> > > > > > > > 
> > > > > > 
> > > > 
> > http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.ht
> > > > ml
> > > > > > > > This details are little fuzzy ATM, but I think the
> > > > reason for the
> > > > > > > > current
> > > > > > > > impl. was only that it was less intrusive to impl.
> > > > > > > 
> > > > > > > Ah, I see. I wonder if the bug is processor specific: we
> > > > > > don't have such
> > > > > > > changes in our v2.4 tree and never experienced such problem.
> > > > > > > 
> > > > > > > It should be pretty easy to hit it right? (instruction
> > > > > > pagefaults should
> > > > > > > fail).
> > > > > > > 
> > > > > > > Grigori, Tom, can you enlight us about the issue on the URL
> > > > > > above. How
> > > > > > > can it be triggered?
> > > > > > 
> > > > > > So after looking at the code in 2.6.14 and current git, I
> > > > think the
> > > > > > above URL isn't relevant, unless there was a change I
> > > > missed (which
> > > > > > could totally be possible) that reverted the patch there and 
> > > > > > fixed that issue in a different manner.  But since I didn't 
> > > > > > figure that out until I had finished researching it again:
> > > > > 
> > > > > I wasn't clear enough. What I meant was that the above 
> > patch made 
> > > > > me think and the result was that I came up with a 
> > simpler fix, the 
> > > > > "two
> > > > exception"
> > > > > fix that
> > > > > is in current kernels. See
> > > > > 
> > > > http://linux.bkbits.net:8080/linux-2.6/diffs/arch/ppc/kernel/h
> > > > ead_8xx.S@
> > > > > 
> > > > 1.19?nav=index.html|src/.|src/arch|src/arch/ppc|src/arch/ppc/k
> > > > ernel|hist
> > > > > /arch/ppc/kernel/head_8xx.S
> > > > > It appears this fix has some other issues :(
> > > > > 
> > > > > How do the other ppc arches do? I am guessing that they don't 
> > > > > double fault, but bails out to do_page_fault from the TLB Miss 
> > > > > handler, like 8xx used to do.
> > > > 
> > > > Assuming Dan doesn't come up with a more simple & better 
> > fix, maybe 
> > > > we should go back to the original patch I made?
> > > 
> > > That was what I was thinking too(or some variation of your patch) I 
> > > wonder if that would solve the misbehaving dcbst problem 
> > Marcelo found 
> > > some time ago too?
> > 
> > Hi Joakim,
> > 
> > Yes, it would fix the "dcbst" issue. That problem was 
> > triggered by a zeroed TLB entry.
> > 
> > In practice it seems that the "three exception" approach does 
> > not impose a significant overhead in comparison with the "two 
> > exception" version (as can be seen by the results of the 
> > latency tests).
> > 
> > Anyway, if decided upon, the "two exception" version (no 
> > zeroed TLB entry state) needs the TLBMiss handler should to 
> > the present bit as Dan mentioned.
> > 
> > I don't know what Dan is up to, he meant to be doing 
> > significant changes.
> > 
> > I'll be playing with TLB preloading next week... how's your 
> > TLB handler shrinkage idea?
> 
> Hi Marcelo
> 
> Its still holding I think, it's a add on to whats in linuxppc-2.4:
> http://ppc.bkbits.net:8080/linuxppc-2.4/diffs/arch/ppc/kernel/head_8xx.S@1.21?nav=index.html|src/.|src/arch|src/arch/ppc|src/arch/pp
> c/kernel|hist/arch/ppc/kernel/head_8xx.S
> 
> If one could eliminate the test for a zero L1 entry you save an extra 4 instructions.
> +	mfcr	r20
> +	cmplwi	cr0, r21, 0x0fff /* Test page descriptor page address */
> +	bng-	2f		/* If zero, don't try to find a pte */
> +	mtcr	r20
> 
> If SPRG2 is free to use you can stash r21 there, then you don't need to use RAM to stash registers.
> 
> Maybe its possible to PIN some of the vmalloc space and use that for modules?

Sure it is. That could be part of the logic to fault large pages for the kernel 
address space when possible.
