Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F370DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 00:40:42 +1000 (EST)
Date: Thu, 13 Sep 2007 09:40:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/9] 8xx: Infrastructure code cleanup.
Message-ID: <20070913144021.GA32043@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201718.GB24260@ld0162-tx32.am.freescale.net>
	<20070913071125.GC24281@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070913071125.GC24281@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2007 at 05:11:25PM +1000, David Gibson wrote:
> > -#define immr_unmap(addr)		iounmap(addr)
> > +#define immr_map(member) (&mpc8xx_immr->member)
> > +#define immr_map_size(member, size) (&mpc8xx_immr->member)
> > +#define immr_unmap(addr) iounmap(addr)
> 
> This looks bogus.  You're replacing the old crap immr_map() functions,
> which ioremap()ed the registers every time, with a much simpler
> version which uses an established-once mapping of the register
> region.  AFAICT, anywah.
> 
> So far, so good - but your immr_unmap() still does an iounmap() which
> is surely wrong - it should now be a no-op, leaving the mpc8xx_immr
> mapping intact.  You probably get away with it by accident, because I
> imagine attempting to unmap an unaligned chunk of the region will just
> fail.

D'oh!  Thanks for pointing that out.

-Scott
