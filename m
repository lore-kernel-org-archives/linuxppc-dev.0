Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7AFA1B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 07:25:12 +1000 (EST)
Date: Wed, 22 Jun 2011 16:24:57 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/book3e-64: use a separate TLB handler when
	linear map is bolted
Message-ID: <20110622162457.1016390e@schlenkerla.am.freescale.net>
In-Reply-To: <1308350669.32158.60.camel@pasglop>
References: <20110603221232.GA29809@schlenkerla.am.freescale.net>
	<1308276050.2516.129.camel@pasglop>
	<20110617113215.56b3d6df@schlenkerla.am.freescale.net>
	<1308350669.32158.60.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 18 Jun 2011 08:44:29 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Can't you just re-org the PACA instead ? (with a comment) ? Or at least
> if you want to keep it that way, put the cache line explanation in a
> comment somewhere.

OK.

> > > > +.macro tlb_prolog_bolted addr
> > > > +	mtspr	SPRN_SPRG_TLB_SCRATCH,r13
> > > > +	mfspr	r13,SPRN_SPRG_PACA
> > > > +	std	r10,PACA_EXTLB+EX_TLB_R10(r13)
> > > > +	mfcr	r10
> > > > +	std	r11,PACA_EXTLB+EX_TLB_R11(r13)
> > > > +	mfspr	r11,SPRN_SPRG_TLB_SCRATCH
> > > 
> > > Do you need that ? Can't you leave r13 in scratch the whole way and
> > > just pop it out in the error case when branching to DSI/ISI ? The only
> > > thing is that TLB_SCRATCH needs to be saved/restored by
> > > crit/debug/mcheck but thats worth saving cycles in the TLB miss handler
> > > no ?
> > 
> > Sounds right... I'll try it.

This saved another 1% or so.  I don't think TLB_SCRATCH needs to be saved
by crit/debug/mcheck -- they shouldn't be taking TLB misses, at least
in the bolted case.  Even non-bolted, it doesn't look like there are enough
extlb levels to deal with a linear TLB miss inside a crit/debug/mcheck
inside a linear TLB miss inside a virtual page table miss inside a normal
TLB miss.

Currently, we could just as well take that crit/debug/mcheck after
storing to TLB_SCRATCH but before saving it to extlb, and have the same
problem.

-Scott
