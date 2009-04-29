Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DDFF9DDEE9
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 21:45:03 +1000 (EST)
Date: Wed, 29 Apr 2009 13:44:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/6] powerpc: Move #ifdef'ed body of do_IRQ() into a
	separate function
Message-ID: <20090429114448.GA13129@lst.de>
References: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
	<20090425181823.GA10481@lst.de>
	<1240879747.11027.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1240879747.11027.2.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 28, 2009 at 10:49:07AM +1000, Michael Ellerman wrote:
> On Sat, 2009-04-25 at 20:18 +0200, Christoph Hellwig wrote:
> > On Thu, Apr 23, 2009 at 11:31:37AM +1000, Michael Ellerman wrote:
> > > +#ifdef CONFIG_IRQSTACKS
> > 
> > Wasn't there a plan to make CONFIG_IRQSTACKS the unconditional default?
> 
> Not sure. Looks like the 64-bit configs all turn it on, and all but one
> or two of the 32-bit configs don't.

Yeah, but do they have a reason not to turn it on?  Having irqstacks
is a lot safer than no having it because the stack useage is a lot more
predictable.  And not having to maintain two codepathes is also a
benefit all by itself.
