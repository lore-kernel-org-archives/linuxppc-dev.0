Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	by ozlabs.org (Postfix) with ESMTP id BA6C8679EB
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 May 2005 05:24:12 +1000 (EST)
Date: Sat, 7 May 2005 11:42:24 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Message-ID: <20050507144224.GD16996@logos.cnet>
References: <20050424165520.GA22786@logos.cnet>
	<BCEFJBPJCGFCNMMMIDBHGEJMCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHGEJMCLAA.Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, May 07, 2005 at 08:10:38PM +0200, Joakim Tjernlund wrote:
> > Hi Dan, Joakim,
> > 
> > On Sat, Apr 23, 2005 at 08:00:39PM -0400, Dan Malek wrote:
> > > 
> > > On Apr 23, 2005, at 7:51 PM, Joakim Tjernlund wrote:
> > > 
> > > >hmm, I have more than 24MB of memory and I can run CONFIG_PIN_TLB just
> > > >fine with modules off in kernel 2.4. Havn't tried 2.6 yet.
> > > 
> > > Doh.  Oh, I see.  We only do the optimization for the instruction 
> > > misses.
> > > I'll have to take a closer look at Marcelo's 2.6 tests.
> > 
> > The PIN TLB entry option does not make much difference in my tests, 
> > never did.
> > 
> > Who wrote the code? Are there results which indicate a performance gain
> > from TLB pinning on 8xx? If so, where are such results? 
> > 
> > One problem that I've noted is that initial_mmu sets {I,D}TLB index
> > to be 27 (11100). 
> > 
> > MI_RSV4I protects TLB's 27...31.
> > 
> > Given that both {I,D}TLB INDEX's are _decreased_ on each update, it seems
> > to me that initial_mmu should set {I,D}TLB INDEX to 31, which will then 
> > decrease down to 27 after 4 TLB's are created.  
> > 
> > Another question that comes to mind is why initial_mmu does create 
> > additional 8Meg TLB entries for D-cache but not for I-cache: 
> > 
> > #ifdef CONFIG_PIN_TLB
> >         /* Map two more 8M kernel data pages.
> >         */
> > 	...
> > #endif
> 
> Not completly sure that this is correct. There are a few:
> 	addi	r10, r10, 0x0100
>  	mtspr	SPRN_MD_CTR, r10
> later on which will "overflow" 0x1f00 into 0x2000 etc.

Yep. This is not correct at all: the TLB index is increased 
at each miss, not decreased as the manual says. 

I have confirmed it with the BDI... 

>  Jocke
> > 
> > I'll do some more CONFIG_PIN_TLB tests this week...
> > 
> > --- head_8xx.S.orig2	2005-04-24 17:55:59.000000000 -0300
> > +++ head_8xx.S	2005-04-24 17:57:44.000000000 -0300
> > @@ -697,7 +697,7 @@
> >  	tlbia			/* Invalidate all TLB entries */
> >  #ifdef CONFIG_PIN_TLB
> >  	lis	r8, MI_RSV4I@h
> > -	ori	r8, r8, 0x1c00
> > +	ori	r8, r8, 0x1f00
> >  #else
> >  	li	r8, 0
> >  #endif
> > @@ -705,7 +705,7 @@
> >  
> >  #ifdef CONFIG_PIN_TLB
> >  	lis	r10, (MD_RSV4I | MD_RESETVAL)@h
> > -	ori	r10, r10, 0x1c00
> > +	ori	r10, r10, 0x1f00
> >  	mr	r8, r10
> >  #else
> >  	lis	r10, MD_RESETVAL@h
