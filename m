Return-Path: <marcelo.tosatti@cyclades.com>
Received: from www.linux.org.uk (parcelfarce.linux.theplanet.co.uk
	[195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D17F2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Oct 2004 04:58:44 +1000 (EST)
Date: Fri, 15 Oct 2004 13:55:38 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20041015165538.GB4131@logos.cnet>
References: <20041015160941.GA4054@logos.cnet>
	<20041015181539.GG19791@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041015181539.GG19791@smtp.west.cox.net>
Cc: "Nei A. Chiaradia" <nei.chiaradia@cyclades.com>,
	Regina Kodato <regina.kodato@cyclades.com>,
	Wanda Rosalino <wanda.rosalino@cyclades.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] PRxK sub-architecture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 15, 2004 at 11:15:39AM -0700, Tom Rini wrote:
> [ Switched over to linuxppc-embedded ]
> 
> On Fri, Oct 15, 2004 at 01:09:41PM -0300, Marcelo Tosatti wrote:
> 
> Just some rough comments:
> 
> [snip]
> > diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/8xx_io/fec.c linux-2.6-bkppc/arch/ppc/8xx_io/fec.c
> > --- linux-2.6-bkppc.orig/arch/ppc/8xx_io/fec.c	2004-09-02 08:52:19.000000000 -0300
> > +++ linux-2.6-bkppc/arch/ppc/8xx_io/fec.c	2004-09-02 14:33:23.000000000 -0300
> > @@ -173,7 +173,7 @@
> >  	uint	phy_status;
> >  	uint	phy_speed;
> >  	phy_info_t	*phy;
> > -	struct tq_struct phy_task;
> > +	struct work_struct phy_task;
> >  
> >  	uint	sequence_done;
> >  
> 
> This looks like a dupe of what's already in linuxppc-2.5.
> 
> [snip]
> > diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/boot/simple/embed_config.c linux-2.6-bkppc/arch/ppc/boot/simple/embed_config.c
> > --- linux-2.6-bkppc.orig/arch/ppc/boot/simple/embed_config.c	2004-09-02 08:52:19.000000000 -0300
> > +++ linux-2.6-bkppc/arch/ppc/boot/simple/embed_config.c	2004-09-02 10:17:19.000000000 -0300
> 
> This looks like it should be done in prxk.c, with the various hooks that
> we provide in misc.c, which might have to be ported to misc-embedded.c.

OK, I'll look into this.

> [snip]
> > diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/boot/simple/head.S linux-2.6-bkppc/arch/ppc/boot/simple/head.S
> > --- linux-2.6-bkppc.orig/arch/ppc/boot/simple/head.S	2004-09-02 08:52:19.000000000 -0300
> > +++ linux-2.6-bkppc/arch/ppc/boot/simple/head.S	2004-09-02 17:30:39.000000000 -0300
> 
> Do we really need to do this?  If so, why?

Yes because the bootloader jumps to 0x00002120. 

We can't afford to change that, I think.

I'll take a closer look at this too.

> [snip]
> > diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/include/asm-ppc/prxk.h linux-2.6-bkppc/include/asm-ppc/prxk.h
> > --- linux-2.6-bkppc.orig/include/asm-ppc/prxk.h	1969-12-31 21:00:00.000000000 -0300
> > +++ linux-2.6-bkppc/include/asm-ppc/prxk.h	2004-09-02 08:54:51.000000000 -0300
> [snip]
> > +/* Machine type
> > +*/
> > +#define _MACH_8xx (_MACH_PRxK)
> 
> Eh?  Is there more to come that moves 8xx towards what we have on
> pmac/prep/chrp ?  Or a left-over from older kernels?

I think its just a leftover from older kernels.

> Thanks.

Thank you for commenting!

I'll move embed_config() to prxk.c as suggested, fix the _bcopy_str(), 
and come up with another patch next week.
