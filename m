Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2064567B57
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Jun 2005 12:11:42 +1000 (EST)
Date: Thu, 23 Jun 2005 19:11:37 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050624021137.GB4588@gate.ebshome.net>
References: <42BAD78E.1020801@ru.mvista.com>
	<20050623140522.GA25724@logos.cnet>
	<20050623194856.GA4588@gate.ebshome.net>
	<20050623200301.GA26802@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050623200301.GA26802@logos.cnet>
Cc: akpm@osdl.org, trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org, Andrei Konovalov <akonovalov@ru.mvista.com>,
	yshpilevsky@ru.mvista.com
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

On Thu, Jun 23, 2005 at 05:03:01PM -0300, Marcelo Tosatti wrote:
> On Thu, Jun 23, 2005 at 12:48:56PM -0700, Eugene Surovegin wrote:
> > On Thu, Jun 23, 2005 at 11:05:22AM -0300, Marcelo Tosatti wrote:
> > > 
> > > Hi Andrei,
> > > 
> > > On Thu, Jun 23, 2005 at 07:38:54PM +0400, Andrei Konovalov wrote:
> > > <snip>
> > > 
> > > > diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
> > > > --- a/arch/ppc/syslib/m8xx_setup.c
> > > > +++ b/arch/ppc/syslib/m8xx_setup.c
> > > > @@ -369,7 +369,7 @@ m8xx_map_io(void)
> > > >  #if defined(CONFIG_HTDMSOUND) || defined(CONFIG_RPXTOUCH) || defined(CONFIG_FB_RPX)
> > > >  	io_block_mapping(HIOX_CSR_ADDR, HIOX_CSR_ADDR, HIOX_CSR_SIZE, _PAGE_IO);
> > > >  #endif
> > > > -#ifdef CONFIG_FADS
> > > > +#if defined(CONFIG_FADS) || defined(CONFIG_MPC885ADS)
> > > >  	io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
> > > >  #endif
> > > >  #ifdef CONFIG_PCI
> > > 
> > > I suppose you also want to include CONFIG_MPC885ADS in the io_block_mapping(IO_BASE) 
> > > here?
> > 
> > I think it'd be great if we _stop_ adding new io_block_mapping users, 
> > there is ioremap() for stuff like this, let's use it instead.
> 
> (go back after reading previous discussion)
> 
> For that you need ioremap() to handle BATs and CAMs right?

Why? BATs or CAMs are just an optimization. You can use ordinary 4K 
ptes.

We don't have BATs on 44x and don't use io_block_mapping also. It's 
not that difficult - just start using ioremap() instead of 
io_block_mapping() and fix code which assumes phys_addr == virt_addr.

-- 
Eugene
