Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1275D67BAC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 10:24:57 +1000 (EST)
Date: Wed, 29 Jun 2005 16:38:46 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050629193846.GA4748@logos.cnet>
References: <f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet>
	<20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston> <42C153E1.3060004@mrv.com>
	<1120018530.5133.241.camel@gaston> <42C2BF03.9000402@mrv.com>
	<20050629155445.GA3560@logos.cnet>
	<1120087568.31924.14.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1120087568.31924.14.camel@gaston>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: get_mmu_context() for (very) FEW_CONTEXTS
	and	KERNEL_PREEMPT race/starvation issue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 30, 2005 at 09:26:07AM +1000, Benjamin Herrenschmidt wrote:
> 
> > Execution is resumed exactly where it has been interrupted.
> > 
> > > The idea behind my patch was to get rid of that nr_free_contexts counter 
> > > that is (I thing) redundant with the context_map.
> > 
> > Apparently its there to avoid the spinlock exactly on !FEW_CONTEXTS machines.
> > 
> > I suppose that what happens is that get_mmu_context() gets preempted after stealing
> > a context (so nr_free_contexts = 0), but before setting next_mmu_context to the 
> > next entry
> > 
> > next_mmu_context = (ctx + 1) & LAST_CONTEXT;
> 
> Ugh ? Can switch_mm() be preempted at all ? Did I miss yet another
> "let's open 10 gazillion races for gun" Ingo patch ?

Doh nope it can't - my bad.

> > So if the now running higher prio tasks calls switch_mm() (which is likely to happen)
> > it loops forever on atomic_dec_if_positive(&nr_free_contexts), while steal_context()
> > sees "mm->context == CONTEXT".
> 
> I think the race is only when destroy_context() is preempted, but maybe
> I missed something.

Nope, I think you are right. My "theory" is obviously flawed now. 

There seem to be several contexts where destroy_context() could be called
with preempt enabled - I should have been shutup in the first place :)

Lets wait for Guillaume to test...
