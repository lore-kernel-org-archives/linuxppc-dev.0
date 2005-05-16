Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C52D679F4
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 01:08:40 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <c58d28ab50872f95d4c4a751d1768513@embeddededge.com>
References: <1116222720.5095.86.camel@gaston>
	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
	<c58d28ab50872f95d4c4a751d1768513@embeddededge.com>
Content-Type: text/plain
Date: Tue, 17 May 2005 01:05:38 +1000
Message-Id: <1116255938.5095.133.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-05-16 at 11:04 -0400, Dan Malek wrote:
> On May 16, 2005, at 2:21 AM, Kumar Gala wrote:
> 
> >
> > On May 16, 2005, at 12:52 AM, Benjamin Herrenschmidt wrote:
> >> Agreed. I'll fix PReP/CHRP/pmac & defconfig. Every embedded board
> >>  vendor/maintainer will be responsible for fixing his/her boards 
> >> support.
> >
> > Agreed.  We should probably send an email to linuxppc-embedded with a 
> > more proper subject line to let people know.
> 
> There isn't any reason to break everything and force updates.  If 
> someone wants
> a 3G task size, then just configure that with the advanced options.   
> All of that
> grew out of the embedded board support, so just make PMac support it 
> too.
> In particular, I don't want to force the 8xx to a 3G task space, 
> because it adds
> more instructions to the TLB handlers, on a system that has never 
> required
> such application space.  We are 12 releases in 2.6, and it still seems 
> like
> a development kernel :-)  I think if someone wants this feature on a 
> board
> port that doesn't support it, then just fix that one board port instead 
> of breaking
> everything.

I suppose it would add about ... 1 instruction :) Which is probably
barely measurable compared to the cost of the cache misses of getting to
the page table entires...

But I agree that we don't abolutely _need_ to break everybody. Maybe a
better compromise would be to have the default beeing per CPU family ?
6xx/7xx/7xxx could default to 3G and 8xx stay at 2G...

Ben.
