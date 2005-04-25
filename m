Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 7F55067AC5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 06:26:53 +1000 (EST)
Date: Mon, 25 Apr 2005 13:26:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050425202641.GD19245@smtp.west.cox.net>
References: <20050413195713.GF11131@logos.cnet>
	<20050425145029.GD3112@smtp.west.cox.net>
	<20050425143619.GF25420@logos.cnet>
	<20050425195519.GA2970@gate.ebshome.net>
	<20050425145916.GA25998@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050425145916.GA25998@logos.cnet>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] attempt to remove misc-embedded.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 25, 2005 at 11:59:17AM -0300, Marcelo Tosatti wrote:
> On Mon, Apr 25, 2005 at 12:55:20PM -0700, Eugene Surovegin wrote:
> > On Mon, Apr 25, 2005 at 11:36:19AM -0300, Marcelo Tosatti wrote:
> > > So the plan is to move all cpu specific code in decompress_kernel() to cpu specific code :)
> > > 
> > > Including
> > > 
> > > #ifdef CONFIG_44x
> > >         /* Reset MAL */
> > >         mtdcr(DCRN_MALCR(DCRN_MAL_BASE), MALCR_MMSR);
> > >         /* Wait for reset */
> > >         while (mfdcr(DCRN_MALCR(DCRN_MAL_BASE)) & MALCR_MMSR) {};
> > >         /* Reset EMAC */
> > >         *(volatile unsigned long *)PPC44x_EMAC0_MR0 = 0x20000000;
> > >         __asm__ __volatile__("eieio");
> > > #endif
> > 
> > Hmm, strange, 2.4 has this code already moved to misc-44x.c, I wonder 
> > why this change never made it to 2.6.
> > 
> > Marcelo, I assume you are going to make this look like 2.4, right?
> 
> Sure, that looks better. 
> 
> Ok, so we can just make something minimal as misc-4xx, for 8xx, and 
> have everything which can be outside decompress_kernel() there.

Yes, I think we're starting to understand eachother, as that sounds like
what I was talking about.

-- 
Tom Rini
http://gate.crashing.org/~trini/
