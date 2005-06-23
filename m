Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E12F67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Jun 2005 11:33:17 +1000 (EST)
Date: Thu, 23 Jun 2005 17:03:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrei Konovalov <akonovalov@ru.mvista.com>, akpm@osdl.org,
	trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
	yshpilevsky@ru.mvista.com, linuxppc-embedded@ozlabs.org
Message-ID: <20050623200301.GA26802@logos.cnet>
References: <42BAD78E.1020801@ru.mvista.com>
	<20050623140522.GA25724@logos.cnet>
	<20050623194856.GA4588@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050623194856.GA4588@gate.ebshome.net>
Subject: Re: [PATCH] ppc32: add Freescale MPC885ADS board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 23, 2005 at 12:48:56PM -0700, Eugene Surovegin wrote:
> On Thu, Jun 23, 2005 at 11:05:22AM -0300, Marcelo Tosatti wrote:
> > 
> > Hi Andrei,
> > 
> > On Thu, Jun 23, 2005 at 07:38:54PM +0400, Andrei Konovalov wrote:
> > <snip>
> > 
> > > diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
> > > --- a/arch/ppc/syslib/m8xx_setup.c
> > > +++ b/arch/ppc/syslib/m8xx_setup.c
> > > @@ -369,7 +369,7 @@ m8xx_map_io(void)
> > >  #if defined(CONFIG_HTDMSOUND) || defined(CONFIG_RPXTOUCH) || defined(CONFIG_FB_RPX)
> > >  	io_block_mapping(HIOX_CSR_ADDR, HIOX_CSR_ADDR, HIOX_CSR_SIZE, _PAGE_IO);
> > >  #endif
> > > -#ifdef CONFIG_FADS
> > > +#if defined(CONFIG_FADS) || defined(CONFIG_MPC885ADS)
> > >  	io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
> > >  #endif
> > >  #ifdef CONFIG_PCI
> > 
> > I suppose you also want to include CONFIG_MPC885ADS in the io_block_mapping(IO_BASE) 
> > here?
> 
> I think it'd be great if we _stop_ adding new io_block_mapping users, 
> there is ioremap() for stuff like this, let's use it instead.

(go back after reading previous discussion)

For that you need ioremap() to handle BATs and CAMs right?
What would be the difficulties with doing that?

For 8xx (which lacks BAT's and CAM's) we could try immediately I suppose.

Seems to be BenH's plan, along with making the virtual addresses
dynamic and not static. 

While at it, what are the possibilities of making BAT's and/or CAM's
available to userspace through hugetlbfs or some other mechanism?
