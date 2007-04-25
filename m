Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A05BDDF0B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 10:07:49 +1000 (EST)
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070424.110456.124867547.davem@davemloft.net>
References: <20070424223245.78f4fdfb.sfr@canb.auug_.org.au>
	<f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
	<AF0367BA48C55940A43CCF08DF35553C011ECCD1@az33exm24.fsl.freescale.net>
	<20070424.110456.124867547.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 10:07:31 +1000
Message-Id: <1177459651.14873.164.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I totally disagree that you should be changing anything
> during these consolidations.
> 
> Move the code around in one pass where you can _VERIFY_
> that things are precisely the same and won't break.
>
> Then later you can get fancy and change things however you
> wish.

Oh I think we all agree there... we just use the opportunity to discuss
how we should improve the consolidation further :-)

> You people giving comments like this have your priorities totally
> screwed up and you are doing nothing but unnecessarily slowing down
> this wonderful consolidation.  Even worse you might even be giving
> Stephen a disincentive to keep working actively on this.
> 
> So please STOP THIS CRAP now, thanks.
> 
> Everything so far is pure whining, and has nothing to do with
> the substance of what Stephen is trying to accomplish, a
> _CODE CONSOLIDATION_.  So please don't get in the way of that
> effort.

Dave, no need to shout :-) I think it's pretty well agreed that
Stephen's patches are good to go (unless nits I haven't seen), we are
really just discussing what we should do on top of them.

Now regarding the parsing of #address-cells / #size-cells, it's indeed a
bug that we walk up the tree on powerpc, we did that initially, I think,
due to a misunderstanding of the spec, but since the code's been doing
that forever, nobody ever wanted to change it and take the risk to break
it.

At one point, I suppose we'll have to bit the bullet and do a patch
going to the proper behaviour and see what breaks (probably nothing
nowadays, except maybe some rare old apple mac-io stuffs that I need to
double check) but that should definitely be done separately from the
consolidation.

Ben.
