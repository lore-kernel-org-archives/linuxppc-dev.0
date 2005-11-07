Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtai20.cox.net (fed1rmmtai20.cox.net [68.230.241.39])
	by ozlabs.org (Postfix) with ESMTP id CE1DA6869A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 03:37:33 +1100 (EST)
Date: Mon, 7 Nov 2005 08:51:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20051107155147.GC3839@smtp.west.cox.net>
References: <F6AD7E21CDF4E145A44F61F43EE6D9393FD5A2@tmnt04.transmode.se>
	<20051107101618.GA15522@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051107101618.GA15522@logos.cnet>
Cc: linuxppc-embedded@ozlabs.org, Dan Malek <dan@embeddedalley.com>,
	Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	gtolstolytkin@ru.mvista.com
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

On Mon, Nov 07, 2005 at 08:16:18AM -0200, Marcelo Tosatti wrote:
> Joakim!
> 
> On Mon, Nov 07, 2005 at 03:32:52PM +0100, Joakim Tjernlund wrote:
> > Hi Marcelo
> > 
> > [SNIP] 
> > > The root of the problem are the changes against the 8xx TLB 
> > > handlers introduced
> > > during v2.6. What happens is the TLBMiss handlers load the 
> > > zeroed pte into
> > > the TLB, causing the TLBError handler to be invoked (thats 
> > > two TLB faults per 
> > > pagefault), which then jumps to the generic MM code to setup the pte.
> > > 
> > > The bug is that the zeroed TLB is not invalidated (the same reason
> > > for the "dcbst" misbehaviour), resulting in infinite TLBError faults.
> > > 
> > > Dan, I wonder why we just don't go back to v2.4 behaviour.
> > 
> > This is one reason why it is the way it is:
> > http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html
> > This details are little fuzzy ATM, but I think the reason for the
> > current
> > impl. was only that it was less intrusive to impl.
> 
> Ah, I see. I wonder if the bug is processor specific: we don't have such
> changes in our v2.4 tree and never experienced such problem.
> 
> It should be pretty easy to hit it right? (instruction pagefaults should
> fail).
> 
> Grigori, Tom, can you enlight us about the issue on the URL above. How
> can it be triggered?

So after looking at the code in 2.6.14 and current git, I think the
above URL isn't relevant, unless there was a change I missed (which
could totally be possible) that reverted the patch there and fixed that
issue in a different manner.  But since I didn't figure that out until I
had finished researching it again:

Switching hats for a minute, this came from a bug a customer of
MontaVista found, so I can't give out the testcase :(

To repeat what Joakim said back then:
"I think I have figured this out. The first TLB misses that happen at
app startup is Data TLB misses. These will then hit the NULL L1 entry
and end up in do_page_fault() which will populate the L1 entry. But when
you have a very large app that spans more than one L1 entry (16 MB I
think) it may happen that you will have I-TLB Miss first one of the L1
entrys which will make the I-TLB handler bail out to do_page_fault() and
the app craches(SEGV)."

Looking at the patch again, what I don't see is why I talk about fudging
I-TLB Miss at 0x400 when it's I-TLB Error we fudge at being there, but
then get hung up that there can be a slight diff between the two ("This
is because we check bit 4 of SRR1 in both cases, but in the case of an
I-TLB Miss, this bit is always set, and it only indicates a protection
fault on an I-TLB Error.") so instead of 0x1300 jumping to the handler
at 0x400, we treat it like a regular exception so we know where we came
from, and perhaps missed fixing a case somewhere?

-- 
Tom Rini
http://gate.crashing.org/~trini/
