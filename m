Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E68567AC7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 06:12:36 +1000 (EST)
Date: Mon, 25 Apr 2005 11:59:17 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tom Rini <trini@kernel.crashing.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050425145916.GA25998@logos.cnet>
References: <20050413195713.GF11131@logos.cnet>
	<20050425145029.GD3112@smtp.west.cox.net>
	<20050425143619.GF25420@logos.cnet>
	<20050425195519.GA2970@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050425195519.GA2970@gate.ebshome.net>
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

On Mon, Apr 25, 2005 at 12:55:20PM -0700, Eugene Surovegin wrote:
> On Mon, Apr 25, 2005 at 11:36:19AM -0300, Marcelo Tosatti wrote:
> > So the plan is to move all cpu specific code in decompress_kernel() to cpu specific code :)
> > 
> > Including
> > 
> > #ifdef CONFIG_44x
> >         /* Reset MAL */
> >         mtdcr(DCRN_MALCR(DCRN_MAL_BASE), MALCR_MMSR);
> >         /* Wait for reset */
> >         while (mfdcr(DCRN_MALCR(DCRN_MAL_BASE)) & MALCR_MMSR) {};
> >         /* Reset EMAC */
> >         *(volatile unsigned long *)PPC44x_EMAC0_MR0 = 0x20000000;
> >         __asm__ __volatile__("eieio");
> > #endif
> 
> Hmm, strange, 2.4 has this code already moved to misc-44x.c, I wonder 
> why this change never made it to 2.6.
> 
> Marcelo, I assume you are going to make this look like 2.4, right?

Sure, that looks better. 

Ok, so we can just make something minimal as misc-4xx, for 8xx, and 
have everything which can be outside decompress_kernel() there.

One immediate advantage would be the INTERACTIVE_CONSOLE option.
