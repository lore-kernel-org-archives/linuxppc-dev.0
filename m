Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EABE768439
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Oct 2005 10:35:18 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1128644808.17365.2.camel@gaston>
References: <Pine.LNX.4.61.0509221450190.30738@nylon.am.freescale.net>
	<1127599811.27674.47.camel@gaston>
	<AFEB186E-99B9-4BE8-9AE3-315C74277483@freescale.com>
	<1128644808.17365.2.camel@gaston>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 10:33:49 +1000
Message-Id: <1128645230.17365.5.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: make sure we have an L3 before touch its
	control register
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-10-07 at 10:26 +1000, Benjamin Herrenschmidt wrote:
> > Dope, you're right.  I notice that we apparent do this for BTIC and  
> > DPM in this function though?
> 
> Yes, those bits are buggy. Good catch

And no, in fact, my brain is buggy... On ppc32 we identify first, then
fixup, then only do the call_setup_cpu ! That's why the Idle NAP code
actually goes test the feature bit.

I think ppc64 does it the other way around. ppc64 certainly _requires_
taht the fixup has not yet been applied while running early_setup() as
it may change some CPU features according to firmware properties.

So in the merged kernel, we need to be extra careful here. I think we
should go the ppc64 way actually and apply the fixups later. But that
means fixing the code in cpu_setup_6xx.S indeed.

Ben.
