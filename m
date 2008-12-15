Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7BD5DDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 08:08:09 +1100 (EST)
Subject: Re: [PATCH 15/16] powerpc/mm: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1229374998.8332.20.camel@localhost>
References: <20081215054611.3C3C1474E1@ozlabs.org>
	<8F38D1CB-D389-4065-A309-3126B6D482DB@freescale.com>
	<1229374998.8332.20.camel@localhost>
Content-Type: text/plain
Date: Tue, 16 Dec 2008 08:05:57 +1100
Message-Id: <1229375157.26324.126.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-16 at 08:03 +1100, Michael Ellerman wrote:
> On Mon, 2008-12-15 at 14:54 -0600, Kumar Gala wrote:
> > >
> > > #ifndef __ASSEMBLY__
> > > +
> > > +/*
> > > + * Macro to mark a page protection value as "uncacheable".
> > > + */
> > > +
> > > +#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_COHERENT | _PAGE_COHERENT | \
> > > + 			 _PAGE_WRITETHRU)
> > 
> > we like coherent so much we set it thrice?
> 
> That makes it really-really-really coherent.

Actually the mask is used to remove those bits so not quite :-)

Should be all WIMG, I'll send a fix.

Cheers,
Ben.
